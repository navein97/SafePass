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
import { Heart, MessageCircle, Share2, Flame, Shield, Trophy } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { getWeek, getYear } from 'date-fns';

interface FeedPost {
  id: string;
  type: 'streak' | 'achievement' | 'shield' | 'leaderboard' | 'pitlane';
  userName: string;
  userAvatar?: string;
  content: string;
  timestamp: string;
  likes: number;
  comments: number;
  isLiked: boolean;
}

function FeedItem({ post, onLike }: { post: FeedPost; onLike: (id: string) => void }) {
  const { colors } = useTheme();
  
  // Use distinct styles for this component to access colors immediately inside
  const itemStyles = useMemo(() => StyleSheet.create({
    feedItem: {
      marginHorizontal: 16,
      marginBottom: 12,
      padding: 16,
      backgroundColor: colors.background.card,
      borderRadius: 16,
      borderWidth: 1,
      borderColor: colors.border,
    },
    feedHeader: {
      flexDirection: 'row',
      alignItems: 'center',
      marginBottom: 12,
    },
    avatarContainer: {
      width: 44,
      height: 44,
      borderRadius: 22,
      backgroundColor: colors.background.subtle,
      justifyContent: 'center',
      alignItems: 'center',
      marginRight: 12,
    },
    feedHeaderText: {
      flex: 1,
    },
    userName: {
      fontFamily: 'Inter-Bold',
      fontSize: 15,
      color: colors.text.primary,
    },
    timestamp: {
      fontFamily: 'Inter-Regular',
      fontSize: 12,
      color: colors.text.tertiary,
      marginTop: 2,
    },
    feedContent: {
      fontFamily: 'Inter-Regular',
      fontSize: 15,
      color: colors.text.primary,
      lineHeight: 22,
      marginBottom: 12,
    },
    feedActions: {
      flexDirection: 'row',
      borderTopWidth: 1,
      borderTopColor: colors.border,
      paddingTop: 12,
    },
    actionButton: {
      flexDirection: 'row',
      alignItems: 'center',
      marginRight: 24,
    },
    actionText: {
      fontFamily: 'Inter-Medium',
      fontSize: 13,
      color: colors.text.secondary,
      marginLeft: 6,
    },
    actionTextLiked: {
      color: colors.status.danger,
    },
  }), [colors]);

  const getIcon = () => {
    switch (post.type) {
      case 'streak':
        return <Flame color={colors.streak.flame} size={24} />;
      case 'shield':
        return <Shield color={colors.status.success} size={24} />;
      case 'achievement':
        return <Trophy color={colors.primary.DEFAULT} size={24} />;
      case 'leaderboard':
        return <Trophy color={colors.leaderboard.gold} size={24} />;
      case 'pitlane':
        return <Shield color={colors.status.warning} size={24} />;
      default:
        return null;
    }
  };

  return (
    <View style={itemStyles.feedItem}>
      <View style={itemStyles.feedHeader}>
        <View style={itemStyles.avatarContainer}>
          {getIcon()}
        </View>
        <View style={itemStyles.feedHeaderText}>
          <Text style={itemStyles.userName}>{post.userName}</Text>
          <Text style={itemStyles.timestamp}>{post.timestamp}</Text>
        </View>
      </View>
      
      <Text style={itemStyles.feedContent}>{post.content}</Text>
      
      <View style={itemStyles.feedActions}>
        <TouchableOpacity 
          style={itemStyles.actionButton} 
          onPress={() => onLike(post.id)}
        >
          <Heart 
            color={post.isLiked ? colors.status.danger : colors.text.secondary} 
            size={20}
            fill={post.isLiked ? colors.status.danger : 'transparent'}
          />
          <Text style={[itemStyles.actionText, post.isLiked && itemStyles.actionTextLiked]}>
            {post.likes}
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={itemStyles.actionButton}>
          <MessageCircle color={colors.text.secondary} size={20} />
          <Text style={itemStyles.actionText}>{post.comments}</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={itemStyles.actionButton}>
          <Share2 color={colors.text.secondary} size={20} />
        </TouchableOpacity>
      </View>
    </View>
  );
}

function PitLaneCard({ drivers }: { drivers: any[] }) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  const styles = useMemo(() => StyleSheet.create({
    pitLaneCard: {
      margin: 16,
      padding: 20,
      backgroundColor: colors.background.card,
      borderRadius: 20,
      borderWidth: 2,
      borderColor: colors.leaderboard.pitLane,
    },
    pitLaneHeader: {
      marginBottom: 16,
    },
    pitLaneTitle: {
      fontFamily: 'Inter-Bold',
      fontSize: 18,
      color: colors.leaderboard.pitLane,
      marginBottom: 4,
    },
    pitLaneSubtitle: {
      fontFamily: 'Inter-Regular',
      fontSize: 13,
      color: colors.text.secondary,
    },
    pitLaneDriver: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'space-between',
      paddingVertical: 12,
      borderBottomWidth: 1,
      borderBottomColor: colors.border,
    },
    pitLaneInfo: {
      flex: 1,
    },
    pitLaneName: {
      fontFamily: 'Inter-Medium',
      fontSize: 14,
      color: colors.text.primary,
    },
    pitLaneMessage: {
      fontFamily: 'Inter-Regular',
      fontSize: 12,
      color: colors.text.tertiary,
      marginTop: 2,
    },
    retakeText: {
      fontFamily: 'Inter-Medium',
      fontSize: 12,
      color: colors.leaderboard.pitLane,
      fontStyle: 'italic',
    },
  }), [colors]);

  if (drivers.length === 0) return null;

  return (
    <View style={styles.pitLaneCard}>
      <View style={styles.pitLaneHeader}>
        <Text style={styles.pitLaneTitle}>🔧 {t('social.pitLane')}</Text>
        <Text style={styles.pitLaneSubtitle}>{t('social.pitLaneSubtitle')}</Text>
      </View>
      
      {drivers.map((driver, index) => (
        <View key={index} style={styles.pitLaneDriver}>
          <View style={styles.pitLaneInfo}>
            <Text style={styles.pitLaneName}>{driver.full_name}</Text>
            <Text style={styles.pitLaneMessage}>{t('common.score')}: {driver.safety_index}%</Text>
          </View>
          <Text style={styles.retakeText}>{t('social.needsImprovement')}</Text>
        </View>
      ))}
    </View>
  );
}

export function SocialScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const [feed, setFeed] = useState<FeedPost[]>([]);
  const [pitLaneDrivers, setPitLaneDrivers] = useState<any[]>([]);
  const [topDrivers, setTopDrivers] = useState<any[]>([]);
  const [refreshing, setRefreshing] = useState(false);

  // Main screen styles needing theme access
  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    loadFeed();
  }, []);

  const onRefresh = React.useCallback(async () => {
    setRefreshing(true);
    await Promise.all([loadFeed(), checkAndCreateWeeklyPosts()]);
    setRefreshing(false);
  }, []);

  const loadFeed = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // Get current user's company
      const { data: profile } = await supabase
        .from('profiles')
        .select('company_id')
        .eq('id', user.id)
        .single();
        
      const companyId = profile?.company_id;

      // Fetch Posts - thanks to RLS, this naturally filters, but we can make it explicit 
      // if posts had a company_id. For now, RLS handles it.
      const { data, error } = await supabase
        .from('posts')
        .select(`
          *,
          profiles:user_id (full_name),
          post_likes (user_id)
        `)
        .order('created_at', { ascending: false });

      if (error) throw error;

      if (data) {
        const mappedFeed: FeedPost[] = data.map((post: any) => ({
          id: post.id,
          type: 'achievement', // Default type
          userName: post.profiles?.full_name || 'User',
          content: post.content,
          timestamp: new Date(post.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
          likes: post.likes_count || 0,
          comments: 0,
          isLiked: post.post_likes?.some((like: any) => like.user_id === user?.id) || false,
        }));
        setFeed(mappedFeed);
      }

      let pitDataQuery = supabase
        .from('profiles')
        .select('full_name, safety_index')
        .lt('safety_index', 70)
        .order('safety_index', { ascending: true })
        .limit(3);
        
      if (companyId) { pitDataQuery = pitDataQuery.eq('company_id', companyId); }
      const { data: pitData } = await pitDataQuery;
        
      if (pitData) {
        setPitLaneDrivers(pitData);
      }

      let topDataQuery = supabase
        .from('profiles')
        .select('full_name, safety_index')
        .order('safety_index', { ascending: false })
        .limit(3);
        
      if (companyId) { topDataQuery = topDataQuery.eq('company_id', companyId); }
      const { data: topData } = await topDataQuery;
      
      if (topData) {
        setTopDrivers(topData);
      }
    } catch (error) {
       console.error('Error loading feed:', error);
    }
  };

  /**
   * Check if we need to generate weekly automated posts
   * and create them for Top 3 and Bottom 3 drivers.
   */
  const checkAndCreateWeeklyPosts = async () => {
    try {
      const week = getWeek(new Date());
      const year = getYear(new Date());
      
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;
      
      const { data: profile } = await supabase
        .from('profiles')
        .select('company_id')
        .eq('id', user.id)
        .single();
        
      const companyId = profile?.company_id;
      // We append company_id to the weekTag so we only check if THIS company has posted this week
      const weekTag = `[Week ${week}-${year}-C${companyId || 'Global'}]`;

      // 1. Check if posts already exist for this week
      const { data: existingPosts } = await supabase
        .from('posts')
        .select('id')
        .ilike('content', `%${weekTag}%`)
        .limit(1);

      if (existingPosts && existingPosts.length > 0) {
        // Already posted this week
        return;
      }

      console.log('Generating weekly auto-posts...');

      // 2. Fetch Top 3 for this company
      let topDriversQuery = supabase
        .from('profiles')
        .select('id, full_name, safety_index')
        .order('safety_index', { ascending: false })
        .limit(3);
      
      if (companyId) { topDriversQuery = topDriversQuery.eq('company_id', companyId); }
      const { data: topDrivers } = await topDriversQuery;

      // 3. Fetch Bottom 3 (Pit Lane) for this company
      let bottomDriversQuery = supabase
        .from('profiles')
        .select('id, full_name, safety_index')
        .lt('safety_index', 70)
        .order('safety_index', { ascending: true })
        .limit(3);
        
      if (companyId) { bottomDriversQuery = bottomDriversQuery.eq('company_id', companyId); }
      const { data: bottomDrivers } = await bottomDriversQuery;

      const postsToCreate: any[] = [];

      // Create Top 3 Posts
      if (topDrivers) {
        topDrivers.forEach((driver, index) => {
          const rank = index + 1;
          let message = '';
          if (rank === 1) message = t('social.posts.top1', { score: driver.safety_index, weekTag });
          if (rank === 2) message = t('social.posts.top2', { weekTag });
          if (rank === 3) message = t('social.posts.top3', { weekTag });

          postsToCreate.push({
            user_id: driver.id,
            content: message,
            // Removed 'type' field - column doesn't exist in posts table
          });
        });
      }

      // Create Pit Lane Posts
      if (bottomDrivers) {
        bottomDrivers.forEach((driver) => {
          postsToCreate.push({
            user_id: driver.id,
            content: t('social.posts.pitlane', { score: driver.safety_index, weekTag }),
            // Removed 'type' field - column doesn't exist in posts table
          });
        });
      }

      // 4. Batch Insert
      if (postsToCreate.length > 0) {
        const { error } = await supabase
          .from('posts')
          .insert(postsToCreate);
        
        if (error) {
          console.error('Error creating auto-posts:', error);
        } else {
           // Reload feed to show new posts
           loadFeed();
        }
      }

    } catch (error) {
      console.error('Error generating weekly posts:', error);
    }
  };

  useEffect(() => {
    checkAndCreateWeeklyPosts();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleLike = async (id: string) => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const post = feed.find(p => p.id === id);
      if (!post) return;

      const newIsLiked = !post.isLiked;
      const newLikesCount = newIsLiked ? post.likes + 1 : post.likes - 1;

      // Optimistic update
      setFeed(prevFeed =>
        prevFeed.map(p =>
          p.id === id
            ? { 
                ...p, 
                isLiked: newIsLiked, 
                likes: newLikesCount
              }
            : p
        )
      );

      if (newIsLiked) {
        // Add like
        const { error } = await supabase
          .from('post_likes')
          .insert({ post_id: id, user_id: user.id });
        
        if (error) throw error;
      } else {
        // Remove like
        const { error } = await supabase
          .from('post_likes')
          .delete()
          .eq('post_id', id)
          .eq('user_id', user.id);

        if (error) throw error;
      }
    } catch (error) {
      console.error('Error toggling like:', error);
      // Revert optimistic update on error
      loadFeed();
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>{t('social.title')}</Text>
      </View>
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={colors.primary.DEFAULT} />
        }
      >
        {/* Top 3 Highlight - Pinned */}
        <View style={styles.topThreeCard}>
          <Text style={styles.topThreeTitle}>🏆 {t('social.topPerformers')}</Text>
          <View style={styles.topThreeContainer}>
            {/* 2nd Place */}
            <View style={styles.topThreeItem}>
              <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.silver }]}>
                <Text style={styles.medalText}>2</Text>
              </View>
              <Text style={styles.topThreeName}>
                {topDrivers[1]?.full_name?.split(' ')[0] || '---'}
              </Text>
              <Text style={styles.topThreeScore}>
                {topDrivers[1]?.safety_index || 0}%
              </Text>
            </View>
            
            {/* 1st Place */}
            <View style={[styles.topThreeItem, styles.topThreeFirst]}>
              <View style={[styles.medalBadge, styles.medalBadgeGold]}>
                <Text style={styles.medalText}>1</Text>
              </View>
              <Text style={styles.topThreeName}>
                 {topDrivers[0]?.full_name?.split(' ')[0] || '---'}
              </Text>
              <Text style={styles.topThreeScore}>
                 {topDrivers[0]?.safety_index || 0}%
              </Text>
            </View>
            
            {/* 3rd Place */}
            <View style={styles.topThreeItem}>
              <View style={[styles.topThreeItem]}>
                <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.bronze }]}>
                  <Text style={styles.medalText}>3</Text>
                </View>
                <Text style={styles.topThreeName}>
                   {topDrivers[2]?.full_name?.split(' ')[0] || '---'}
                </Text>
                <Text style={styles.topThreeScore}>
                   {topDrivers[2]?.safety_index || 0}%
                </Text>
              </View>
            </View>
          </View>
        </View>

        {/* Feed Items */}
        {feed.length === 0 ? (
          <View style={{ padding: 20, alignItems: 'center' }}>
            <Text style={{ color: colors.text.secondary }}>{t('social.noPosts')}</Text>
          </View>
        ) : (
          feed.map(post => (
            <FeedItem key={post.id} post={post} onLike={handleLike} />
          ))
        )}

        {/* Pit Lane Section */}
        <PitLaneCard drivers={pitLaneDrivers} />
        
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
  scrollView: {
    flex: 1,
  },
  topThreeCard: {
    margin: 16,
    padding: 20,
    backgroundColor: colors.background.card,
    borderRadius: 20,
    borderWidth: 2,
    borderColor: colors.primary.DEFAULT,
  },
  topThreeTitle: {
    fontFamily: 'Inter-Bold',
    fontSize: 18,
    color: colors.primary.DEFAULT,
    textAlign: 'center',
    marginBottom: 20,
  },
  topThreeContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'flex-end',
  },
  topThreeItem: {
    alignItems: 'center',
    marginHorizontal: 16,
  },
  topThreeFirst: {
    marginBottom: 20,
  },
  medalBadge: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
  },
  medalBadgeGold: {
    backgroundColor: colors.leaderboard.gold,
    width: 50,
    height: 50,
    borderRadius: 25,
  },
  medalText: {
    fontFamily: 'Inter-Bold',
    fontSize: 18,
    color: colors.text.inverse,
  },
  topThreeName: {
    fontFamily: 'Inter-Medium',
    fontSize: 14,
    color: colors.text.primary,
    marginBottom: 4,
  },
  topThreeScore: {
    fontFamily: 'Inter-Bold',
    fontSize: 16,
    color: colors.primary.DEFAULT,
  },
  bottomPadding: {
    height: 100,
  },
});

