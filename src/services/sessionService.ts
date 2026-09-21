import * as Crypto from 'expo-crypto';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { AppState, AppStateStatus } from 'react-native';
import { supabase } from '../lib/supabase';
import { RealtimeChannel } from '@supabase/supabase-js';

const SESSION_ID_KEY = '@safepass_session_id';

export type SessionTerminationReason = 'concurrent_login' | 'session_revoked';

export const SessionService = {
    /**
     * Get the locally stored session ID
     */
    async getLocalSessionId(): Promise<string | null> {
        try {
            return await AsyncStorage.getItem(SESSION_ID_KEY);
        } catch (e) {
            console.error('[SessionService] Failed to read local session ID:', e);
            return null;
        }
    },

    /**
     * Initialize a fresh session for the user upon sign-in.
     * Generates a new session ID, stores it locally, revokes other sessions on Supabase Auth,
     * updates the database profile, and broadcasts a concurrent_login event to other devices.
     */
    async initSession(userId: string): Promise<string> {
        const newSessionId = Crypto.randomUUID();
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
                await broadcastChannel.subscribe();
                await broadcastChannel.send({
                    type: 'broadcast',
                    event: 'concurrent_login',
                    payload: {
                        newSessionId,
                        timestamp: Date.now(),
                    },
                });
                // Remove temporary broadcast channel after short delay
                setTimeout(() => {
                    supabase.removeChannel(broadcastChannel);
                }, 3000);
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
            // 1. Verify that user session is still recognized by Supabase Auth server
            const { data: { user }, error: userError } = await supabase.auth.getUser();
            if (userError || !user) {
                console.log('⚠️ [SessionService] User token invalid or revoked on server');
                return false;
            }

            const localSessionId = await this.getLocalSessionId();
            if (!localSessionId) {
                return true;
            }

            // 2. Check if profiles table has a different active session ID
            const { data: profile, error: profileError } = await supabase
                .from('profiles')
                .select('current_session_id')
                .eq('id', userId)
                .single();

            if (profileError || !profile) {
                // If profile lookup failed (e.g. column not created yet or network glitch), don't falsely terminate
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
            // 1. Check server-side token validity
            const { data: { user }, error: userError } = await supabase.auth.getUser();
            if (userError || !user) {
                console.log('⚠️ [SessionService] Saved session rejected by Supabase Auth server');
                return false;
            }

            const localSessionId = await this.getLocalSessionId();

            // 2. Query profile current_session_id
            const { data: profile, error: profileError } = await supabase
                .from('profiles')
                .select('current_session_id')
                .eq('id', userId)
                .single();

            if (profileError || !profile) {
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
     * Starts listening for concurrent login events via Supabase Realtime broadcast
     * and AppState transitions to 'active'.
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

        // 1. Subscribe to Realtime broadcast channel for instant eviction (< 100ms)
        try {
            listenerChannel = supabase.channel(`user_sessions_${userId}`);
            listenerChannel
                .on('broadcast', { event: 'concurrent_login' }, async (eventPayload) => {
                    const incomingSessionId = eventPayload.payload?.newSessionId;
                    const mySessionId = await SessionService.getLocalSessionId();

                    if (incomingSessionId && mySessionId && incomingSessionId !== mySessionId) {
                        console.log('⚠️ [SessionService] Instant concurrent login broadcast received!');
                        handleTermination('concurrent_login');
                    }
                })
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
                const isValid = await SessionService.verifyActiveSession(userId);
                if (!isValid) {
                    handleTermination('concurrent_login');
                }
            }
        });

        // Return cleanup function
        return () => {
            isTerminated = true;
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
        try {
            await AsyncStorage.removeItem(SESSION_ID_KEY);
        } catch (e) {
            console.error('[SessionService] Error clearing local session:', e);
        }
    },
};
