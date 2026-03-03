import React, { useState, useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { supabase } from '../lib/supabase';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  RefreshControl,
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
import { useTheme } from '../context/ThemeContext';

interface Notification {
  id: string;
  type: 'streak' | 'mention' | 'like' | 'comment' | 'leaderboard' | 'shield';
  title: string;
  message: string;
  timestamp: string;
  isRead: boolean;
}

function NotificationItem({ notification, onPress }: { notification: Notification; onPress: () => void }) {
  const { colors } = useTheme();

  // Create styles specific to item inside component
  const styles = useMemo(() => StyleSheet.create({
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
  }), [colors]);

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
      onPress={onPress}
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
  const { t } = useTranslation();
  const { colors } = useTheme();
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [refreshing, setRefreshing] = useState(false);

  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    loadNotifications();
  }, []);

  const onRefresh = React.useCallback(async () => {
    setRefreshing(true);
    await loadNotifications();
    setRefreshing(false);
  }, []);

  const loadNotifications = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase
        .from('notifications')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) throw error;

      if (data) {
        setNotifications(data.map((n: any) => ({
          id: n.id,
          type: n.type || 'system',
          title: n.title,
          message: n.message,
          timestamp: new Date(n.created_at).toLocaleDateString() + ' ' + new Date(n.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
          isRead: n.is_read,
        })));
      }
    } catch (error) {
      console.error('Error loading notifications:', error);
    }
  };

  const markAllRead = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { error } = await supabase
        .from('notifications')
        .update({ is_read: true })
        .eq('user_id', user.id);

      if (error) throw error;
      
      // Refresh local state
      loadNotifications();
    } catch (error) {
      console.error('Error marking all as read:', error);
    }
  };

  const markAsRead = async (notificationId: string) => {
    try {
      const { error } = await supabase
        .from('notifications')
        .update({ is_read: true })
        .eq('id', notificationId);

      if (error) throw error;
      
      // Update local state
      setNotifications(prev => 
        prev.map(n => n.id === notificationId ? { ...n, isRead: true } : n)
      );
    } catch (error) {
      console.error('Error marking notification as read:', error);
    }
  };

  const unreadCount = notifications.filter(n => !n.isRead).length;
  
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>{t('notifications.title')}</Text>
        {unreadCount > 0 && (
          <View style={styles.badge}>
            <Text style={styles.badgeText}>{unreadCount}</Text>
          </View>
        )}
      </View>

      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={colors.primary.DEFAULT} />
        }
      >
        {/* Quick Actions */}
        <View style={styles.quickActions}>
          <TouchableOpacity style={styles.quickActionButton} onPress={markAllRead}>
            <Text style={styles.quickActionText}>{t('notifications.markAllRead')}</Text>
          </TouchableOpacity>
        </View>

        {/* Notifications List */}
        {notifications.length === 0 ? (
          <View style={{ padding: 20, alignItems: 'center' }}>
            <Text style={{ color: colors.text.secondary }}>{t('notifications.empty')}</Text>
          </View>
        ) : (
          notifications.map(notification => (
            <NotificationItem 
              key={notification.id} 
              notification={notification} 
              onPress={() => markAsRead(notification.id)}
            />
          ))
        )}

        <View style={styles.bottomPadding} />
      </ScrollView>
    </SafeAreaView>
  );
}

const createStyles = (colors: any) => StyleSheet.create({
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
    color: colors.text.inverse,
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
  bottomPadding: {
    height: 100,
  },
});
