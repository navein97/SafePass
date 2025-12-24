import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Image,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Heart, MessageCircle, Share2, Flame, Shield, Trophy } from 'lucide-react-native';
import { colors } from '../theme/colors';

interface FeedPost {
  id: string;
  type: 'streak' | 'achievement' | 'shield' | 'leaderboard';
  userName: string;
  userAvatar?: string;
  content: string;
  timestamp: string;
  likes: number;
  comments: number;
  isLiked: boolean;
}

// Sample feed data - Replace with real data
const SAMPLE_FEED: FeedPost[] = [
  {
    id: '1',
    type: 'leaderboard',
    userName: 'SafePass',
    content: '🏆 Weekly Top Performers:\n🥇 Driver Mike - 98%\n🥈 Driver Sarah - 95%\n🥉 Driver James - 93%',
    timestamp: '2h ago',
    likes: 45,
    comments: 12,
    isLiked: false,
  },
  {
    id: '2',
    type: 'streak',
    userName: 'Driver Mike',
    content: '🔥 Driver Mike hit a 10-day streak! Keep up the amazing work!',
    timestamp: '3h ago',
    likes: 32,
    comments: 8,
    isLiked: true,
  },
  {
    id: '3',
    type: 'shield',
    userName: 'Logistics Team B',
    content: '🛡️ Logistics Team B improved their Safety Shield by 15%! Team effort pays off!',
    timestamp: '5h ago',
    likes: 28,
    comments: 5,
    isLiked: false,
  },
  {
    id: '4',
    type: 'achievement',
    userName: 'Driver Sarah',
    content: '⭐ Driver Sarah completed 50 missions with a 95% accuracy rate!',
    timestamp: '6h ago',
    likes: 41,
    comments: 14,
    isLiked: false,
  },
  {
    id: '5',
    type: 'streak',
    userName: 'Driver Alex',
    content: '🔥 Driver Alex is on fire! 5-day streak activated - earning 1.5x points!',
    timestamp: '8h ago',
    likes: 19,
    comments: 3,
    isLiked: false,
  },
];

const PIT_LANE_DRIVERS = [
  { name: 'Driver Tom', message: 'Needs a tune-up! 📍', score: 62 },
  { name: 'Driver Lisa', message: 'In the Pit Lane 🔧', score: 58 },
  { name: 'Driver Ben', message: 'Ready for a comeback! 💪', score: 55 },
];

function FeedItem({ post, onLike }: { post: FeedPost; onLike: (id: string) => void }) {
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
      default:
        return null;
    }
  };

  return (
    <View style={styles.feedItem}>
      <View style={styles.feedHeader}>
        <View style={styles.avatarContainer}>
          {getIcon()}
        </View>
        <View style={styles.feedHeaderText}>
          <Text style={styles.userName}>{post.userName}</Text>
          <Text style={styles.timestamp}>{post.timestamp}</Text>
        </View>
      </View>
      
      <Text style={styles.feedContent}>{post.content}</Text>
      
      <View style={styles.feedActions}>
        <TouchableOpacity 
          style={styles.actionButton} 
          onPress={() => onLike(post.id)}
        >
          <Heart 
            color={post.isLiked ? colors.status.danger : colors.text.secondary} 
            size={20}
            fill={post.isLiked ? colors.status.danger : 'transparent'}
          />
          <Text style={[styles.actionText, post.isLiked && styles.actionTextLiked]}>
            {post.likes}
          </Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.actionButton}>
          <MessageCircle color={colors.text.secondary} size={20} />
          <Text style={styles.actionText}>{post.comments}</Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={styles.actionButton}>
          <Share2 color={colors.text.secondary} size={20} />
        </TouchableOpacity>
      </View>
    </View>
  );
}

function PitLaneCard() {
  return (
    <View style={styles.pitLaneCard}>
      <View style={styles.pitLaneHeader}>
        <Text style={styles.pitLaneTitle}>🔧 Pit Lane</Text>
        <Text style={styles.pitLaneSubtitle}>These drivers need a tune-up!</Text>
      </View>
      
      {PIT_LANE_DRIVERS.map((driver, index) => (
        <View key={index} style={styles.pitLaneDriver}>
          <View style={styles.pitLaneInfo}>
            <Text style={styles.pitLaneName}>{driver.name}</Text>
            <Text style={styles.pitLaneMessage}>{driver.message}</Text>
          </View>
          <TouchableOpacity style={styles.retakeButton}>
            <Text style={styles.retakeButtonText}>Retake Mission</Text>
          </TouchableOpacity>
        </View>
      ))}
    </View>
  );
}

export function SocialScreen() {
  const [feed, setFeed] = useState<FeedPost[]>(SAMPLE_FEED);

  const handleLike = (id: string) => {
    setFeed(prevFeed =>
      prevFeed.map(post =>
        post.id === id
          ? { 
              ...post, 
              isLiked: !post.isLiked, 
              likes: post.isLiked ? post.likes - 1 : post.likes + 1 
            }
          : post
      )
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Social Feed</Text>
      </View>
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
      >
        {/* Top 3 Highlight - Pinned */}
        <View style={styles.topThreeCard}>
          <Text style={styles.topThreeTitle}>🏆 Top Performers</Text>
          <View style={styles.topThreeContainer}>
            <View style={styles.topThreeItem}>
              <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.silver }]}>
                <Text style={styles.medalText}>2</Text>
              </View>
              <Text style={styles.topThreeName}>Sarah</Text>
              <Text style={styles.topThreeScore}>95%</Text>
            </View>
            
            <View style={[styles.topThreeItem, styles.topThreeFirst]}>
              <View style={[styles.medalBadge, styles.medalBadgeGold]}>
                <Text style={styles.medalText}>1</Text>
              </View>
              <Text style={styles.topThreeName}>Mike</Text>
              <Text style={styles.topThreeScore}>98%</Text>
            </View>
            
            <View style={styles.topThreeItem}>
              <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.bronze }]}>
                <Text style={styles.medalText}>3</Text>
              </View>
              <Text style={styles.topThreeName}>James</Text>
              <Text style={styles.topThreeScore}>93%</Text>
            </View>
          </View>
        </View>

        {/* Feed Items */}
        {feed.map(post => (
          <FeedItem key={post.id} post={post} onLike={handleLike} />
        ))}

        {/* Pit Lane Section */}
        <PitLaneCard />
        
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
  retakeButton: {
    backgroundColor: colors.leaderboard.pitLane,
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 8,
  },
  retakeButtonText: {
    fontFamily: 'Inter-Medium',
    fontSize: 12,
    color: colors.text.primary,
  },
  bottomPadding: {
    height: 100,
  },
});
