import * as Notifications from 'expo-notifications';
import { Platform } from 'react-native';
import { colors } from '../theme/colors';
import { supabase } from '../lib/supabase';

// Configure notification handler
Notifications.setNotificationHandler({
    handleNotification: async () => ({
        shouldShowAlert: true,
        shouldPlaySound: true,
        shouldSetBadge: true,
        shouldShowBanner: true,
        shouldShowList: true,
    }),
});

export const NotificationService = {
    async registerForPushNotificationsAsync() {


        let token;

        if (Platform.OS === 'android') {
            await Notifications.setNotificationChannelAsync('default', {
                name: 'default',
                importance: Notifications.AndroidImportance.MAX,
                vibrationPattern: [0, 250, 250, 250],
                lightColor: colors.primary.DEFAULT,
            });
        }

        const { status: existingStatus } = await Notifications.getPermissionsAsync();
        let finalStatus = existingStatus;

        if (existingStatus !== 'granted') {
            const { status } = await Notifications.requestPermissionsAsync();
            finalStatus = status;
        }

        if (finalStatus !== 'granted') {
            return;
        }

        token = (await Notifications.getExpoPushTokenAsync()).data;

        // Save token to Supabase profile
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (user) {
                await supabase
                    .from('profiles')
                    .update({ expo_push_token: token })
                    .eq('id', user.id);
            }
        } catch (error) {
            console.error('Error saving push token to profile:', error);
        }

        return token;
    },

    async scheduleWeeklyReminder() {
        // User requested to remove all existing scheduled notifications.
        // We will clear them and not reschedule anything for now.
        if (Platform.OS !== 'web') {
            await Notifications.cancelAllScheduledNotificationsAsync();
        }
    },

    /**
     * Send an in-app notification to a user
     */
    async sendNotification({ userId, title, body, data }: { userId: string, title: string, body: string, data?: any }) {
        try {
            // requires 'notifications' table in supabase
            const { error } = await supabase
                .from('notifications')
                .insert({
                    user_id: userId,
                    title,
                    message: body,
                    data,
                    is_read: false,
                    created_at: new Date().toISOString()
                });

            if (error) throw error;

            // Trigger real push notification via Supabase Edge Function
            try {
                await supabase.functions.invoke('send-push-notification', {
                    body: { 
                        userId, 
                        title, 
                        body, 
                        data 
                    }
                });
            } catch (pushError) {
                console.error('Push notification delivery error:', pushError);
                // We don't throw here to ensure the in-app notification still shows as success
            }

            return { success: true };
        } catch (error: any) {
            console.error('Send notification error:', error);
            // If table doesn't exist, we just log it for now as we can't create tables from client
            if (error.code === '42P01') { // undefined_table
                console.warn('Notifications table missing. Skipping persistence.');
                return { success: false, error: 'Notifications table not set up' };
            }
            throw error;
        }
    }
};
