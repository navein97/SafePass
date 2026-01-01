import React, { useState, useEffect } from 'react';
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
import { supabase } from '../lib/supabase';

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



function TopThreePodium({ drivers }: { drivers: Driver[] }) {
  const [second, first, third] = [drivers[1], drivers[0], drivers[2]];

  if (!first) return null;

  return (
    <View style={styles.podiumContainer}>
      {/* Second Place */}
      {second ? (
        <View style={styles.podiumItem}>
          <View style={[styles.podiumAvatar, styles.podiumSecond]}>
            <Text style={styles.avatarText}>{second.name?.charAt(0) || '?'}</Text>
          </View>
          <View style={[styles.podiumBar, styles.podiumBarSecond]}>
            <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.silver }]}>
              <Text style={styles.medalNumber}>2</Text>
            </View>
          </View>
          <Text style={styles.podiumName}>{second.name.replace('Driver ', '')}</Text>
          <Text style={styles.podiumScore}>{second.score}%</Text>
        </View>
      ) : <View style={styles.podiumItem} />}

      {/* First Place */}
      <View style={styles.podiumItem}>
        <View style={[styles.podiumAvatar, styles.podiumFirst]}>
          <Text style={styles.avatarText}>{first.name?.charAt(0) || '?'}</Text>
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
      {third ? (
        <View style={styles.podiumItem}>
          <View style={[styles.podiumAvatar, styles.podiumThird]}>
            <Text style={styles.avatarText}>{third.name?.charAt(0) || '?'}</Text>
          </View>
          <View style={[styles.podiumBar, styles.podiumBarThird]}>
            <View style={[styles.medalBadge, { backgroundColor: colors.leaderboard.bronze }]}>
              <Text style={styles.medalNumber}>3</Text>
            </View>
          </View>
          <Text style={styles.podiumName}>{third.name.replace('Driver ', '')}</Text>
          <Text style={styles.podiumScore}>{third.score}%</Text>
        </View>
      ) : <View style={styles.podiumItem} />}
    </View>
  );
}

function LeaderboardItem({ driver, isPitLane }: { driver: Driver; isPitLane?: boolean }) {
  return (
    <View 
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
          <Text style={styles.avatarInitial}>{driver.name.charAt(0)}</Text>
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
        <Text style={styles.needsTuneup}>🔧</Text>
      )}
    </View>
  );
}

export function LeaderboardScreen() {
  const [activeTab, setActiveTab] = useState<'weekly' | 'monthly' | 'allTime'>('weekly');
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadLeaderboard();
  }, [activeTab]);

  const loadLeaderboard = async () => {
    try {
      setLoading(true);
      
      let queryFn;
      
      // Calculate date ranges
      const now = new Date();
      let startDate = new Date();
      
      if (activeTab === 'weekly') {
        // Last 7 days
        startDate.setDate(now.getDate() - 7);
      } else if (activeTab === 'monthly') {
        // Last 30 days
        startDate.setDate(now.getDate() - 30);
      } else {
        // All Time (Arbitrary old date)
        startDate = new Date(0); 
      }

      // For Weekly/Monthly, we need to aggregate quiz attempts
      if (activeTab === 'weekly' || activeTab === 'monthly') {
          const { data: attempts, error } = await supabase
            .from('quiz_attempts')
            .select('user_id, score, profiles(full_name, region, streak)')
            .gte('completed_at', startDate.toISOString());

          if (error) throw error;

          // Aggregate scores by user
          const userScores: Record<string, { total: number, count: number, profile: any }> = {};
          
          attempts?.forEach((attempt: any) => {
              if (!userScores[attempt.user_id]) {
                  userScores[attempt.user_id] = { 
                      total: 0, 
                      count: 0, 
                      profile: attempt.profiles 
                  };
              }
              userScores[attempt.user_id].total += attempt.score;
              userScores[attempt.user_id].count += 1;
          });

          // Also fetch previous period data for trend calculation
          const previousStartDate = new Date(startDate);
          const previousEndDate = new Date(startDate);
          if (activeTab === 'weekly') {
              previousStartDate.setDate(previousStartDate.getDate() - 7);
          } else {
              previousStartDate.setDate(previousStartDate.getDate() - 30);
          }

          const { data: prevAttempts } = await supabase
            .from('quiz_attempts')
            .select('user_id, score')
            .gte('completed_at', previousStartDate.toISOString())
            .lt('completed_at', startDate.toISOString());

          // Calculate previous averages
          const prevScores: Record<string, { total: number, count: number }> = {};
          prevAttempts?.forEach((attempt: any) => {
              if (!prevScores[attempt.user_id]) {
                  prevScores[attempt.user_id] = { total: 0, count: 0 };
              }
              prevScores[attempt.user_id].total += attempt.score;
              prevScores[attempt.user_id].count += 1;
          });

          // Convert to Driver array with trend
          const mappedDrivers: Driver[] = Object.keys(userScores).map((userId) => {
              const u = userScores[userId];
              const currentAvg = Math.round(u.total / u.count);
              
              // Calculate trend
              let trend: 'up' | 'down' | 'same' = 'same';
              let trendValue = 0;
              
              const prev = prevScores[userId];
              if (prev && prev.count > 0) {
                  const prevAvg = Math.round(prev.total / prev.count);
                  const diff = currentAvg - prevAvg;
                  if (diff > 0) {
                      trend = 'up';
                      trendValue = diff;
                  } else if (diff < 0) {
                      trend = 'down';
                      trendValue = Math.abs(diff);
                  }
              }
              
              return {
                  rank: 0,
                  name: u.profile?.full_name || 'Driver',
                  team: u.profile?.region === 'MY' ? 'Malaysia' : 'Portugal',
                  score: currentAvg,
                  streak: u.profile?.streak || 0,
                  trend,
                  trendValue
              };
          });

          // Sort by Score DESC
          mappedDrivers.sort((a, b) => b.score - a.score);
          
          // Assign Ranks
          mappedDrivers.forEach((d, i) => d.rank = i + 1);
          
          setDrivers(mappedDrivers);

      } else {
          // All Time - Use the cached aggregation in profiles
          const { data, error } = await supabase
            .from('profiles')
            .select('*')
            .order('total_score', { ascending: false })
            .limit(20);

          if (error) throw error;

          if (data) {
            const mappedDrivers: Driver[] = data.map((p: any, index: number) => ({
              rank: index + 1,
              name: p.full_name || 'Driver',
              team: p.region === 'MY' ? 'Malaysia' : 'Portugal',
              score: p.total_score || 0,
              streak: p.streak || 0,
              trend: 'same',
              trendValue: 0
            }));
            setDrivers(mappedDrivers);
          }
      }

    } catch (error) {
      console.error('Error loading leaderboard:', error);
    } finally {
      setLoading(false);
    }
  };
  
  const topThree = drivers.slice(0, 3);
  const restOfBoard = drivers.slice(3, 10);
  const pitLane = drivers.slice(10);

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
  needsTuneup: {
    fontSize: 16,
    marginLeft: 8,
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
