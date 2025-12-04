import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, Alert, ActivityIndicator, RefreshControl, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { Trophy, ChevronLeft, AlertTriangle } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';
import { getWeek, getYear } from 'date-fns';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { LinearGradient } from 'expo-linear-gradient';

interface LeaderboardEntry {
  id: string;
  user_id: string;
  full_name: string;
  employee_id: string;
  score: number;
  status: 'COMPLIANT' | 'OVERDUE';
  completed_at: string;
}

export const ManagerQuickViewScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
  const [currentUser, setCurrentUser] = useState<any>(null);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      await fetchLeaderboard();
    } catch (error) {
      console.error('Error loading data:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchLeaderboard = async () => {
    try {
      // Get current user
      const { profile } = await AuthService.getUserProfile();
      setCurrentUser(profile);

      const now = new Date();
      const currentWeek = getWeek(now);
      const currentYear = getYear(now);

      // Fetch all compliance logs for this week
      // Note: This requires RLS policies to be updated to allow public viewing
      const { data: logs, error } = await supabase
        .from('compliance_logs')
        .select(`
          id,
          user_id,
          score,
          status,
          completed_at,
          profiles:user_id (full_name, employee_id)
        `)
        .eq('week_number', currentWeek)
        .eq('year', currentYear)
        .order('score', { ascending: false });

      if (error) throw error;

      // Transform data
      const entries: LeaderboardEntry[] = logs.map((log: any) => ({
        id: log.id,
        user_id: log.user_id,
        full_name: log.profiles?.full_name || 'Unknown',
        employee_id: log.profiles?.employee_id || '???',
        score: log.score || 0,
        status: log.status,
        completed_at: log.completed_at,
      }));

      setLeaderboard(entries);
    } catch (error) {
      console.error('Error fetching leaderboard:', error);
      // Fallback for demo if RLS blocks access
      Alert.alert('Notice', 'Please run the RLS update script to see all users.');
    }
  };

  const onRefresh = async () => {
    setRefreshing(true);
    await fetchLeaderboard();
    setRefreshing(false);
  };

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        <View style={styles.header}>
          <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
            <ChevronLeft color={colors.text.primary} size={24} />
          </TouchableOpacity>
          <Text style={styles.headerTitle}>Weekly Leaderboard</Text>
          <View style={{ width: 24 }} />
        </View>

        <ScrollView 
          contentContainerStyle={styles.content}
          refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={colors.primary.DEFAULT} />}
          showsVerticalScrollIndicator={false}
        >
          <GlassCard style={styles.banner}>
            <Trophy size={48} color="#FFD700" />
            <Text style={styles.bannerTitle}>Safety Champions</Text>
            <Text style={styles.bannerSubtitle}>Week {getWeek(new Date())}</Text>
          </GlassCard>

          {leaderboard.length === 0 ? (
            <View style={styles.emptyState}>
              <AlertTriangle size={48} color={colors.text.tertiary} />
              <Text style={styles.emptyText}>No quizzes completed this week yet.</Text>
              <Text style={styles.emptySubtext}>Be the first to complete the quiz!</Text>
            </View>
          ) : (
            leaderboard.map((entry, index) => {
              const isMe = entry.user_id === currentUser?.id;
              return (
                <GlassCard 
                  key={entry.id} 
                  style={[
                    styles.card, 
                    isMe && styles.myCard,
                    index === 0 && styles.goldCard,
                    index === 1 && styles.silverCard,
                    index === 2 && styles.bronzeCard
                  ]}
                  intensity={isMe ? 40 : 20}
                >
                  <View style={styles.cardContent}>
                    <View style={styles.rankContainer}>
                      <Text style={[styles.rank, isMe && styles.myRank]}>#{index + 1}</Text>
                    </View>
                    
                    <View style={styles.infoContainer}>
                      <Text style={[styles.name, isMe && styles.myName]}>
                        {entry.full_name} {isMe ? '(You)' : ''}
                      </Text>
                      <Text style={[styles.id, isMe && styles.myId]}>{entry.employee_id}</Text>
                    </View>

                    <View style={styles.scoreContainer}>
                      <Text style={[styles.score, isMe && styles.myScore]}>{entry.score}%</Text>
                      <Text style={styles.status}>{entry.status}</Text>
                    </View>
                  </View>
                </GlassCard>
              );
            })
          )}
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingVertical: 12,
    marginTop: 10,
  },
  backButton: {
    padding: 8,
  },
  headerTitle: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  content: {
    padding: 16,
  },
  banner: {
    alignItems: 'center',
    marginBottom: 24,
    padding: 24,
  },
  bannerTitle: {
    fontSize: typography.sizes['2xl'],
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginTop: 8,
  },
  bannerSubtitle: {
    fontSize: typography.sizes.base,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  card: {
    marginBottom: 12,
  },
  cardContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  myCard: {
    borderColor: colors.primary.light,
    backgroundColor: 'rgba(59, 130, 246, 0.1)',
  },
  goldCard: {
    borderColor: '#FFD700',
    borderWidth: 2,
  },
  silverCard: {
    borderColor: '#C0C0C0',
  },
  bronzeCard: {
    borderColor: '#CD7F32',
  },
  rankContainer: {
    width: 40,
    alignItems: 'center',
    justifyContent: 'center',
  },
  rank: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    color: colors.text.secondary,
  },
  myRank: {
    color: colors.primary.light,
  },
  infoContainer: {
    flex: 1,
    marginLeft: 12,
  },
  name: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  myName: {
    color: colors.primary.light,
  },
  id: {
    fontSize: typography.sizes.sm,
    color: colors.text.secondary,
    fontFamily: typography.fonts.regular,
  },
  myId: {
    color: colors.primary.DEFAULT,
  },
  scoreContainer: {
    alignItems: 'flex-end',
  },
  score: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    color: colors.status.success,
  },
  myScore: {
    color: colors.status.success,
  },
  status: {
    fontSize: 10,
    color: colors.text.tertiary,
    textTransform: 'uppercase',
  },
  emptyState: {
    alignItems: 'center',
    padding: 48,
  },
  emptyText: {
    marginTop: 16,
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    textAlign: 'center',
  },
  emptySubtext: {
    marginTop: 8,
    fontSize: typography.sizes.sm,
    color: colors.text.tertiary,
    textAlign: 'center',
  },
});

