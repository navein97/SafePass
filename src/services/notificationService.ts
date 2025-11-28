import * as Notifications from 'expo-notifications';
import { Platform } from 'react-native';
import { colors } from '../theme/colors';

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
            console.log('Failed to get push token for push notification!');
            return;
        }

        token = (await Notifications.getExpoPushTokenAsync()).data;
        return token;
    },

    async scheduleWeeklyReminder() {
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
    }
};
