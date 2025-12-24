import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { 
  Trophy, 
  Medal, 
  TrendingUp, 
  TrendingDown,
  ChevronRight,
  Wrench,
} from 'lucide-react-native';
import { colors } from '../theme/colors';

const { width: SCREEN_WIDTH } = Dimensions.get('window');

interface Driver {
  rank: number;
  name: string;
  team: string;
  score: number;
  streak: number;
  trend: 'up' | 'down' | 'same';
  trendValue: number;
}

const LEADERBOARD_DATA: Driver[] = [
  { rank: 1, name: 'Driver Mike', team: 'Team Alpha', score: 98, streak: 15, trend: 'up', trendValue: 2 },
  { rank: 2, name: 'Driver Sarah', team: 'Team Beta', score: 95, streak: 12, trend: 'same', trendValue: 0 },
  { rank: 3, name: 'Driver James', team: 'Team Alpha', score: 93, streak: 8, trend: 'up', trendValue: 1 },
  { rank: 4, name: 'Driver Emma', team: 'Team Gamma', score: 91, streak: 10, trend: 'down', trendValue: 2 },
  { rank: 5, name: 'Driver John', team: 'Team Beta', score: 89, streak: 6, trend: 'up', trendValue: 3 },
  { rank: 6, name: 'Driver Lisa', team: 'Team Delta', score: 87, streak: 4, trend: 'same', trendValue: 0 },
  { rank: 7, name: 'Driver Alex', team: 'Team Alpha', score: 85, streak: 7, trend: 'up', trendValue: 1 },
  { rank: 8, name: 'Driver Kate', team: 'Team Gamma', score: 82, streak: 3, trend: 'down', trendValue: 1 },
  { rank: 9, name: 'Driver Tom', team: 'Team Delta', score: 62, streak: 0, trend: 'down', trendValue: 4 },
  { rank: 10, name: 'Driver Ben', team: 'Team Beta', score: 58, streak: 0, trend: 'down', trendValue: 3 },
  { rank: 11, name: 'Driver Anna', team: 'Team Gamma', score: 55, streak: 0, trend: 'down', trendValue: 2 },
];

function TopThreePodium({ drivers }: { drivers: Driver[] }) {
  const [second, first, third] = [drivers[1], drivers[0], drivers[2]];

  return (
    <View style={styles.podiumContainer}>
      {/* Second Place */}
      <View style={styles.podiumItem}>
        <View style={[styles.podiumAvatar, styles.podiumSecond]}>
          <Text style={styles.avatarText}>{second.name.charAt(7)}</Text>
        </View>
        <View style={[styles.podiumBar, styles.podiumBarSecond]}>
          <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.silver }]}>
            <Text style={styles.medalNumber}>2</Text>
          </View>
        </View>
        <Text style={styles.podiumName}>{second.name.replace('Driver ', '')}</Text>
        <Text style={styles.podiumScore}>{second.score}%</Text>
      </View>

      {/* First Place */}
      <View style={styles.podiumItem}>
        <View style={[styles.podiumAvatar, styles.podiumFirst]}>
          <Text style={styles.avatarText}>{first.name.charAt(7)}</Text>
        </View>
        <LinearGradient
          colors={colors.gradients.gold as [string, string]}
          style={[styles.podiumBar, styles.podiumBarFirst]}
        >
          <View style={[styles.medalBadge, styles.medalBadgeGold]}>
            <Trophy color={colors.text.inverse} size={20} />
          </View>
        </LinearGradient>
        <Text style={[styles.podiumName, styles.podiumNameFirst]}>{first.name.replace('Driver ', '')}</Text>
        <Text style={[styles.podiumScore, styles.podiumScoreFirst]}>{first.score}%</Text>
      </View>

      {/* Third Place */}
      <View style={styles.podiumItem}>
        <View style={[styles.podiumAvatar, styles.podiumThird]}>
          <Text style={styles.avatarText}>{third.name.charAt(7)}</Text>
        </View>
        <View style={[styles.podiumBar, styles.podiumBarThird]}>
          <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.bronze }]}>
            <Text style={styles.medalNumber}>3</Text>
          </View>
        </View>
        <Text style={styles.podiumName}>{third.name.replace('Driver ', '')}</Text>
        <Text style={styles.podiumScore}>{third.score}%</Text>
      </View>
    </View>
  );
}

function LeaderboardItem({ driver, isPitLane }: { driver: Driver; isPitLane?: boolean }) {
  return (
    <TouchableOpacity 
      style={[
        styles.leaderboardItem,
        isPitLane && styles.leaderboardItemPitLane,
      ]}
    >
      <View style={styles.rankContainer}>
        <Text style={[styles.rankText, isPitLane && styles.rankTextPitLane]}>
          #{driver.rank}
        </Text>
      </View>

      <View style={styles.driverInfo}>
        <View style={[styles.avatar, isPitLane && styles.avatarPitLane]}>
          <Text style={styles.avatarInitial}>{driver.name.charAt(7)}</Text>
        </View>
        <View style={styles.driverDetails}>
          <Text style={styles.driverName}>{driver.name}</Text>
          <Text style={styles.teamName}>{driver.team}</Text>
        </View>
      </View>

      <View style={styles.statsContainer}>
        <Text style={[styles.scoreText, isPitLane && styles.scoreTextPitLane]}>
          {driver.score}%
        </Text>
        <View style={styles.trendContainer}>
          {driver.trend === 'up' && (
            <>
              <TrendingUp color={colors.status.success} size={14} />
              <Text style={styles.trendUp}>+{driver.trendValue}</Text>
            </>
          )}
          {driver.trend === 'down' && (
            <>
              <TrendingDown color={colors.status.danger} size={14} />
              <Text style={styles.trendDown}>-{driver.trendValue}</Text>
            </>
          )}
          {driver.trend === 'same' && (
            <Text style={styles.trendSame}>—</Text>
          )}
        </View>
      </View>

      {isPitLane && (
        <TouchableOpacity style={styles.retakeBtn}>
          <Wrench color={colors.text.primary} size={16} />
        </TouchableOpacity>
      )}

      <ChevronRight color={colors.text.tertiary} size={20} />
    </TouchableOpacity>
  );
}

export function LeaderboardScreen() {
  const [activeTab, setActiveTab] = useState<'weekly' | 'monthly' | 'allTime'>('weekly');
  
  const topThree = LEADERBOARD_DATA.slice(0, 3);
  const restOfBoard = LEADERBOARD_DATA.slice(3, 8);
  const pitLane = LEADERBOARD_DATA.slice(8);

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Leaderboard</Text>
      </View>

      {/* Tab Selector */}
      <View style={styles.tabContainer}>
        {(['weekly', 'monthly', 'allTime'] as const).map(tab => (
          <TouchableOpacity
            key={tab}
            style={[styles.tab, activeTab === tab && styles.tabActive]}
            onPress={() => setActiveTab(tab)}
          >
            <Text style={[styles.tabText, activeTab === tab && styles.tabTextActive]}>
              {tab === 'allTime' ? 'All Time' : tab.charAt(0).toUpperCase() + tab.slice(1)}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
      >
        {/* Top 3 Podium */}
        <TopThreePodium drivers={topThree} />

        {/* Rest of Leaderboard */}
        <View style={styles.leaderboardList}>
          {restOfBoard.map(driver => (
            <LeaderboardItem key={driver.rank} driver={driver} />
          ))}
        </View>

        {/* Pit Lane Section */}
        <View style={styles.pitLaneSection}>
          <View style={styles.pitLaneHeader}>
            <Wrench color={colors.leaderboard.pitLane} size={24} />
            <Text style={styles.pitLaneTitle}>Pit Lane</Text>
            <Text style={styles.pitLaneSubtitle}>Need a Tune-up</Text>
          </View>
          
          {pitLane.map(driver => (
            <LeaderboardItem key={driver.rank} driver={driver} isPitLane />
          ))}
        </View>

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
  },
  headerTitle: {
    fontFamily: 'Inter-Bold',
    fontSize: 24,
    color: colors.text.primary,
  },
  tabContainer: {
    flexDirection: 'row',
    marginHorizontal: 16,
    marginBottom: 16,
    backgroundColor: colors.background.card,
    borderRadius: 12,
    padding: 4,
  },
  tab: {
    flex: 1,
    paddingVertical: 10,
    borderRadius: 10,
    alignItems: 'center',
  },
  tabActive: {
    backgroundColor: colors.primary.DEFAULT,
  },
  tabText: {
    fontFamily: 'Inter-Medium',
    fontSize: 13,
    color: colors.text.secondary,
  },
  tabTextActive: {
    color: colors.text.inverse,
  },
  scrollView: {
    flex: 1,
  },
  podiumContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'flex-end',
    paddingHorizontal: 20,
    paddingVertical: 24,
    marginBottom: 16,
  },
  podiumItem: {
    alignItems: 'center',
    width: (SCREEN_WIDTH - 80) / 3,
  },
  podiumAvatar: {
    width: 50,
    height: 50,
    borderRadius: 25,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 8,
    borderWidth: 3,
  },
  podiumFirst: {
    width: 60,
    height: 60,
    borderRadius: 30,
    borderColor: colors.leaderboard.gold,
    backgroundColor: colors.background.card,
  },
  podiumSecond: {
    borderColor: colors.leaderboard.silver,
    backgroundColor: colors.background.card,
  },
  podiumThird: {
    borderColor: colors.leaderboard.bronze,
    backgroundColor: colors.background.card,
  },
  avatarText: {
    fontFamily: 'Inter-Bold',
    fontSize: 18,
    color: colors.text.primary,
  },
  podiumBar: {
    width: '80%',
    borderTopLeftRadius: 8,
    borderTopRightRadius: 8,
    alignItems: 'center',
    paddingTop: 12,
  },
  podiumBarFirst: {
    height: 100,
  },
  podiumBarSecond: {
    height: 70,
    backgroundColor: colors.leaderboard.silver,
  },
  podiumBarThird: {
    height: 50,
    backgroundColor: colors.leaderboard.bronze,
  },
  medalBadge: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: 'center',
    alignItems: 'center',
  },
  medalBadgeGold: {
    backgroundColor: 'rgba(0,0,0,0.3)',
  },
  medalNumber: {
    fontFamily: 'Inter-Bold',
    fontSize: 16,
    color: colors.text.inverse,
  },
  podiumName: {
    fontFamily: 'Inter-Medium',
    fontSize: 13,
    color: colors.text.primary,
    marginTop: 8,
  },
  podiumNameFirst: {
    fontFamily: 'Inter-Bold',
    fontSize: 14,
  },
  podiumScore: {
    fontFamily: 'Inter-Bold',
    fontSize: 16,
    color: colors.text.secondary,
    marginTop: 4,
  },
  podiumScoreFirst: {
    color: colors.primary.DEFAULT,
    fontSize: 18,
  },
  leaderboardList: {
    marginHorizontal: 16,
  },
  leaderboardItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 12,
    marginBottom: 8,
    backgroundColor: colors.background.card,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: colors.border,
  },
  leaderboardItemPitLane: {
    borderColor: colors.leaderboard.pitLane,
    borderWidth: 2,
  },
  rankContainer: {
    width: 40,
    alignItems: 'center',
  },
  rankText: {
    fontFamily: 'Inter-Bold',
    fontSize: 14,
    color: colors.text.secondary,
  },
  rankTextPitLane: {
    color: colors.leaderboard.pitLane,
  },
  driverInfo: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: colors.background.subtle,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  avatarPitLane: {
    borderWidth: 2,
    borderColor: colors.leaderboard.pitLane,
  },
  avatarInitial: {
    fontFamily: 'Inter-Bold',
    fontSize: 16,
    color: colors.text.primary,
  },
  driverDetails: {
    flex: 1,
  },
  driverName: {
    fontFamily: 'Inter-Medium',
    fontSize: 14,
    color: colors.text.primary,
  },
  teamName: {
    fontFamily: 'Inter-Regular',
    fontSize: 12,
    color: colors.text.tertiary,
    marginTop: 2,
  },
  statsContainer: {
    alignItems: 'flex-end',
    marginRight: 8,
  },
  scoreText: {
    fontFamily: 'Inter-Bold',
    fontSize: 16,
    color: colors.primary.DEFAULT,
  },
  scoreTextPitLane: {
    color: colors.leaderboard.pitLane,
  },
  trendContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 2,
  },
  trendUp: {
    fontFamily: 'Inter-Medium',
    fontSize: 11,
    color: colors.status.success,
    marginLeft: 2,
  },
  trendDown: {
    fontFamily: 'Inter-Medium',
    fontSize: 11,
    color: colors.status.danger,
    marginLeft: 2,
  },
  trendSame: {
    fontFamily: 'Inter-Medium',
    fontSize: 11,
    color: colors.text.tertiary,
  },
  retakeBtn: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: colors.leaderboard.pitLane,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 8,
  },
  pitLaneSection: {
    marginTop: 24,
    marginHorizontal: 16,
  },
  pitLaneHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  pitLaneTitle: {
    fontFamily: 'Inter-Bold',
    fontSize: 18,
    color: colors.leaderboard.pitLane,
    marginLeft: 8,
  },
  pitLaneSubtitle: {
    fontFamily: 'Inter-Regular',
    fontSize: 13,
    color: colors.text.tertiary,
    marginLeft: 8,
  },
  bottomPadding: {
    height: 100,
  },
});
