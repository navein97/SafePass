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
        if (Platform.OS === 'web') {
            console.log('Push notifications are not fully supported on web without service workers.');
            return;
        }

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
            console.log('Failed to get push token for push notification!');
            return;
        }

        token = (await Notifications.getExpoPushTokenAsync()).data;
        return token;
    },

    async scheduleWeeklyReminder() {
        if (Platform.OS === 'web') {
            // Web doesn't support scheduleNotificationAsync consistently locally
            return;
        }

        // Cancel existing to avoid duplicates
        await Notifications.cancelAllScheduledNotificationsAsync();

        // Schedule for Sunday 10:00 AM
        await Notifications.scheduleNotificationAsync({
            content: {
                title: "Weekly Safety Quiz Due",
                body: "Your mandatory safety quiz is due by tonight 11:59 PM.",
                data: { screen: 'Quiz' },
            },
            trigger: {
                type: Notifications.SchedulableTriggerInputTypes.WEEKLY,
                weekday: 1, // Sunday
                hour: 10,
                minute: 0,
            },
        });

        // Schedule for Monday 9:00 AM (New Quiz Available)
        await Notifications.scheduleNotificationAsync({
            content: {
                title: "New Safety Quiz Available",
                body: "A new set of safety questions is ready for you.",
                data: { screen: 'Quiz' },
            },
            trigger: {
                type: Notifications.SchedulableTriggerInputTypes.WEEKLY,
                weekday: 2, // Monday
                hour: 9,
                minute: 0,
            },
        });
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
