import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { 
  Flame, 
  Trophy, 
  Shield, 
  Heart, 
  MessageCircle, 
  Bell,
  Star,
} from 'lucide-react-native';
import { colors } from '../theme/colors';

interface Notification {
  id: string;
  type: 'streak' | 'mention' | 'like' | 'comment' | 'leaderboard' | 'shield';
  title: string;
  message: string;
  timestamp: string;
  isRead: boolean;
}

const SAMPLE_NOTIFICATIONS: Notification[] = [
  {
    id: '1',
    type: 'streak',
    title: '🔥 Keep it going!',
    message: 'You\'re on a 5-day streak! Complete today\'s mission to maintain it.',
    timestamp: '2 min ago',
    isRead: false,
  },
  {
    id: '2',
    type: 'like',
    title: 'New Likes',
    message: 'Driver Mike and 3 others liked your achievement post!',
    timestamp: '1 hour ago',
    isRead: false,
  },
  {
    id: '3',
    type: 'leaderboard',
    title: '🏆 Climbing the ranks!',
    message: 'You moved up 3 positions! Currently ranked #12.',
    timestamp: '3 hours ago',
    isRead: true,
  },
  {
    id: '4',
    type: 'comment',
    title: 'New Comment',
    message: 'Driver Sarah commented on your streak: "Amazing work! 👏"',
    timestamp: '5 hours ago',
    isRead: true,
  },
  {
    id: '5',
    type: 'shield',
    title: '🛡️ Shield Alert',
    message: 'Your Safety Shield dropped to 75%. Complete missions to recharge!',
    timestamp: '1 day ago',
    isRead: true,
  },
  {
    id: '6',
    type: 'mention',
    title: 'You were mentioned!',
    message: 'Your team lead mentioned you in a post about top performers.',
    timestamp: '2 days ago',
    isRead: true,
  },
];

function NotificationItem({ notification }: { notification: Notification }) {
  const getIcon = () => {
    switch (notification.type) {
      case 'streak':
        return <Flame color={colors.streak.flame} size={24} />;
      case 'like':
        return <Heart color={colors.status.danger} size={24} fill={colors.status.danger} />;
      case 'comment':
        return <MessageCircle color={colors.primary.DEFAULT} size={24} />;
      case 'leaderboard':
        return <Trophy color={colors.leaderboard.gold} size={24} />;
      case 'shield':
        return <Shield color={colors.status.success} size={24} />;
      case 'mention':
        return <Star color={colors.primary.DEFAULT} size={24} />;
      default:
        return <Bell color={colors.text.secondary} size={24} />;
    }
  };

  return (
    <TouchableOpacity 
      style={[
        styles.notificationItem,
        !notification.isRead && styles.notificationUnread,
      ]}
    >
      <View style={styles.iconContainer}>
        {getIcon()}
      </View>
      <View style={styles.contentContainer}>
        <View style={styles.headerRow}>
          <Text style={styles.title}>{notification.title}</Text>
          {!notification.isRead && <View style={styles.unreadDot} />}
        </View>
        <Text style={styles.message}>{notification.message}</Text>
        <Text style={styles.timestamp}>{notification.timestamp}</Text>
      </View>
    </TouchableOpacity>
  );
}

export function NotificationsScreen() {
  const unreadCount = SAMPLE_NOTIFICATIONS.filter(n => !n.isRead).length;

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Notifications</Text>
        {unreadCount > 0 && (
          <View style={styles.badge}>
            <Text style={styles.badgeText}>{unreadCount}</Text>
          </View>
        )}
      </View>

      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
      >
        {/* Quick Actions */}
        <View style={styles.quickActions}>
          <TouchableOpacity style={styles.quickActionButton}>
            <Text style={styles.quickActionText}>Mark all as read</Text>
          </TouchableOpacity>
        </View>

        {/* Notifications List */}
        {SAMPLE_NOTIFICATIONS.map(notification => (
          <NotificationItem key={notification.id} notification={notification} />
        ))}

        <View style={styles.bottomPadding} />
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  headerTitle: {
    fontFamily: 'Inter-Bold',
    fontSize: 24,
    color: colors.text.primary,
  },
  badge: {
    backgroundColor: colors.status.danger,
    borderRadius: 12,
    paddingHorizontal: 8,
    paddingVertical: 4,
    marginLeft: 12,
  },
  badgeText: {
    fontFamily: 'Inter-Bold',
    fontSize: 12,
    color: colors.text.primary,
  },
  scrollView: {
    flex: 1,
  },
  quickActions: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    paddingHorizontal: 16,
    paddingVertical: 12,
  },
  quickActionButton: {
    paddingHorizontal: 12,
    paddingVertical: 6,
  },
  quickActionText: {
    fontFamily: 'Inter-Medium',
    fontSize: 13,
    color: colors.primary.DEFAULT,
  },
  notificationItem: {
    flexDirection: 'row',
    padding: 16,
    marginHorizontal: 16,
    marginBottom: 8,
    backgroundColor: colors.background.card,
    borderRadius: 16,
    borderWidth: 1,
    borderColor: colors.border,
  },
  notificationUnread: {
    borderColor: colors.primary.DEFAULT,
    borderWidth: 2,
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: colors.background.subtle,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  contentContainer: {
    flex: 1,
  },
  headerRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 4,
  },
  title: {
    fontFamily: 'Inter-Bold',
    fontSize: 15,
    color: colors.text.primary,
    flex: 1,
  },
  unreadDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: colors.primary.DEFAULT,
    marginLeft: 8,
  },
  message: {
    fontFamily: 'Inter-Regular',
    fontSize: 14,
    color: colors.text.secondary,
    lineHeight: 20,
    marginBottom: 6,
  },
  timestamp: {
    fontFamily: 'Inter-Regular',
    fontSize: 12,
    color: colors.text.tertiary,
  },
  bottomPadding: {
    height: 100,
  },
});
