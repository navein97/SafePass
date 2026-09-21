import * as Crypto from 'expo-crypto';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { AppState, AppStateStatus } from 'react-native';
import { supabase } from '../lib/supabase';
import { RealtimeChannel } from '@supabase/supabase-js';

const SESSION_ID_KEY = '@safepass_session_id';

export type SessionTerminationReason = 'concurrent_login' | 'session_revoked';

let activeTerminationCallback: ((reason: SessionTerminationReason) => void) | null = null;
let inMemorySessionId: string | null = null;

export const SessionService = {
    /**
     * Get the locally stored session ID
     */
    async getLocalSessionId(): Promise<string | null> {
        if (inMemorySessionId) {
            return inMemorySessionId;
        }
        try {
            const stored = await AsyncStorage.getItem(SESSION_ID_KEY);
            if (stored) {
                inMemorySessionId = stored;
            }
            return stored;
        } catch (e) {
            console.error('[SessionService] Failed to read local session ID:', e);
            return null;
        }
    },

    /**
     * Notify active watcher that session has been terminated
     */
    notifyTermination(reason: SessionTerminationReason = 'concurrent_login') {
        if (activeTerminationCallback) {
            activeTerminationCallback(reason);
        }
    },

    /**
     * Initialize a fresh session for the user upon sign-in.
     * Generates a new session ID, stores it locally, revokes other sessions on Supabase Auth,
     * updates the database profile, and broadcasts a concurrent_login event to other devices.
     */
    async initSession(userId: string): Promise<string> {
        const newSessionId = Crypto.randomUUID();
        // Immediately set in memory so this device knows its new session ID before any DB or broadcast event
        inMemorySessionId = newSessionId;

        try {
            // 1. Store session ID locally
            await AsyncStorage.setItem(SESSION_ID_KEY, newSessionId);

            // 2. Call Supabase Auth signOut with scope: 'others' to revoke refresh tokens on other devices
            try {
                await (supabase.auth as any).signOut({ scope: 'others' });
            } catch (authErr) {
                console.debug('[SessionService] Supabase auth signOut others (non-critical):', authErr);
            }

            // 3. Update profiles table with current_session_id (graceful if column doesn't exist yet)
            try {
                await supabase
                    .from('profiles')
                    .update({
                        current_session_id: newSessionId,
                        last_active_at: new Date().toISOString(),
                    })
                    .eq('id', userId);
            } catch (dbErr) {
                console.debug('[SessionService] Profile current_session_id update (non-critical):', dbErr);
            }

            // 4. Broadcast concurrent_login event over Supabase Realtime to instantly invalidate other active devices
            try {
                const broadcastChannel = supabase.channel(`user_sessions_${userId}`);
                await new Promise<void>((resolve) => {
                    const timer = setTimeout(() => {
                        try {
                            supabase.removeChannel(broadcastChannel);
                        } catch {}
                        resolve();
                    }, 2500);

                    broadcastChannel.subscribe(async (status) => {
                        if (status === 'SUBSCRIBED') {
                            try {
                                await broadcastChannel.send({
                                    type: 'broadcast',
                                    event: 'concurrent_login',
                                    payload: {
                                        newSessionId,
                                        timestamp: Date.now(),
                                    },
                                });
                            } catch (sendErr) {
                                console.debug('[SessionService] Broadcast send failed:', sendErr);
                            }
                            clearTimeout(timer);
                            setTimeout(() => {
                                try {
                                    supabase.removeChannel(broadcastChannel);
                                } catch {}
                            }, 1000);
                            resolve();
                        } else if (status === 'CHANNEL_ERROR' || status === 'TIMED_OUT') {
                            clearTimeout(timer);
                            try {
                                supabase.removeChannel(broadcastChannel);
                            } catch {}
                            resolve();
                        }
                    });
                });
            } catch (broadcastErr) {
                console.debug('[SessionService] Broadcast session eviction (non-critical):', broadcastErr);
            }
        } catch (error) {
            console.error('[SessionService] Error in initSession:', error);
        }

        return newSessionId;
    },

    /**
     * Verifies the local session with the server and profile database.
     * Returns false if the session has been superseded or revoked.
     */
    async verifyActiveSession(userId: string): Promise<boolean> {
        try {
            const localSessionId = await this.getLocalSessionId();
            if (!localSessionId) {
                return true;
            }

            // Check if profiles table has a different active session ID
            const { data: profile, error: profileError } = await supabase
                .from('profiles')
                .select('current_session_id')
                .eq('id', userId)
                .single();

            if (profileError || !profile) {
                // If profile lookup failed (e.g. network reconnect glitch or offline), do NOT terminate
                return true;
            }

            if (profile.current_session_id && profile.current_session_id !== localSessionId) {
                console.log('⚠️ [SessionService] Active session mismatch in profiles table. DB:', profile.current_session_id, 'Local:', localSessionId);
                return false;
            }

            return true;
        } catch (e) {
            console.warn('[SessionService] verifyActiveSession network/unknown error (falling back to true):', e);
            return true;
        }
    },

    /**
     * Validate session on app launch (called by LoginScreen during auto-session restore).
     * If superseded by another device, returns false so app won't auto-navigate to MainTabs.
     */
    async validateOnLaunch(userId: string): Promise<boolean> {
        try {
            const localSessionId = await this.getLocalSessionId();

            // Query profile current_session_id
            const { data: profile, error: profileError } = await supabase
                .from('profiles')
                .select('current_session_id')
                .eq('id', userId)
                .single();

            if (profileError || !profile) {
                // Network reconnect or temporary glitch on startup — allow session restore
                return true;
            }

            // If another device has logged in and changed the session ID
            if (profile.current_session_id && localSessionId && profile.current_session_id !== localSessionId) {
                console.log('⚠️ [SessionService] Session mismatch on launch');
                return false;
            }

            // If this device doesn't have a local session ID yet (e.g. existing login from before update)
            if (!localSessionId) {
                const adoptedSessionId = profile.current_session_id || Crypto.randomUUID();
                inMemorySessionId = adoptedSessionId;
                await AsyncStorage.setItem(SESSION_ID_KEY, adoptedSessionId);
                if (!profile.current_session_id) {
                    await supabase.from('profiles').update({ current_session_id: adoptedSessionId }).eq('id', userId);
                }
            }

            return true;
        } catch (err) {
            console.warn('[SessionService] validateOnLaunch error, falling back to allow:', err);
            return true;
        }
    },

    /**
     * Starts listening for concurrent login events via Supabase Realtime broadcast,
     * Postgres changes on profiles, AppState transitions, and periodic in-app heartbeat.
     * Returns an unsubscribe function.
     */
    startSessionWatcher(
        userId: string,
        onTerminated: (reason: SessionTerminationReason) => void
    ): () => void {
        let isTerminated = false;
        let listenerChannel: RealtimeChannel | null = null;

        const handleTermination = (reason: SessionTerminationReason) => {
            if (isTerminated) return;
            isTerminated = true;
            console.log(`🚨 [SessionService] Terminating active session. Reason: ${reason}`);
            onTerminated(reason);
        };

        // Register global callback so other services (e.g. AuthService) can trigger eviction
        activeTerminationCallback = handleTermination;

        // 1. Subscribe to Realtime broadcast & Postgres changes for instant eviction
        try {
            listenerChannel = supabase.channel(`user_sessions_${userId}`);
            listenerChannel
                .on('broadcast', { event: 'concurrent_login' }, async (eventPayload) => {
                    const incomingSessionId = eventPayload.payload?.newSessionId;
                    const mySessionId = await SessionService.getLocalSessionId();

                    // Ignore own broadcast or empty IDs!
                    if (!incomingSessionId || !mySessionId || incomingSessionId === mySessionId) {
                        return;
                    }

                    console.log('⚠️ [SessionService] Instant concurrent login broadcast received!');
                    handleTermination('concurrent_login');
                })
                .on(
                    'postgres_changes',
                    {
                        event: 'UPDATE',
                        schema: 'public',
                        table: 'profiles',
                        filter: `id=eq.${userId}`,
                    },
                    async (payload) => {
                        const incomingSessionId = (payload.new as any)?.current_session_id;
                        const mySessionId = await SessionService.getLocalSessionId();

                        // Ignore own DB update or empty IDs!
                        if (!incomingSessionId || !mySessionId || incomingSessionId === mySessionId) {
                            return;
                        }

                        console.log('⚠️ [SessionService] Session mismatch detected via DB profile update!');
                        handleTermination('concurrent_login');
                    }
                )
                .subscribe((status) => {
                    if (status === 'SUBSCRIBED') {
                        console.log(`🔌 [SessionService] Subscribed to session channel for user ${userId}`);
                    }
                });
        } catch (channelErr) {
            console.debug('[SessionService] Failed to establish Realtime channel:', channelErr);
        }

        // 2. Listen to AppState changes (when returning from background or unlocking phone)
        const appStateSubscription = AppState.addEventListener('change', async (nextState: AppStateStatus) => {
            if (nextState === 'active' && !isTerminated) {
                // Delay 1.5s after returning to foreground to allow mobile network stack to reconnect cleanly
                setTimeout(async () => {
                    if (!isTerminated && AppState.currentState === 'active') {
                        const isValid = await SessionService.verifyActiveSession(userId);
                        if (!isValid) {
                            handleTermination('concurrent_login');
                        }
                    }
                }, 1500);
            }
        });

        // 3. Periodic in-app heartbeat check (every 20 seconds while active)
        const heartbeatInterval = setInterval(async () => {
            if (!isTerminated && AppState.currentState === 'active') {
                const isValid = await SessionService.verifyActiveSession(userId);
                if (!isValid) {
                    handleTermination('concurrent_login');
                }
            }
        }, 20000);

        // Return cleanup function
        return () => {
            isTerminated = true;
            activeTerminationCallback = null;
            clearInterval(heartbeatInterval);
            appStateSubscription.remove();
            if (listenerChannel) {
                supabase.removeChannel(listenerChannel);
            }
        };
    },

    /**
     * Clear local session ID from storage
     */
    async clearSession(): Promise<void> {
        inMemorySessionId = null;
        try {
            await AsyncStorage.removeItem(SESSION_ID_KEY);
        } catch (e) {
            console.error('[SessionService] Error clearing local session:', e);
        }
    },
};
