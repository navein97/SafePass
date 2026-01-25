import React, { useState, useEffect, useMemo, useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  TextInput,
  LayoutAnimation,
  Platform,
  UIManager,
  ActivityIndicator,
  FlatList,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { 
  Trophy, 
  Medal, 
  TrendingUp, 
  TrendingDown,
  ChevronRight,
  ChevronDown,
  Wrench,
  Search,
} from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { supabase } from '../lib/supabase';
import { GlassCard } from '../components/ui/GlassCard';
import { useFocusEffect } from '@react-navigation/native';
import { AuthService } from '../services/authService';

if (Platform.OS === 'android') {
  if (UIManager.setLayoutAnimationEnabledExperimental) {
    UIManager.setLayoutAnimationEnabledExperimental(true);
  }
}

const { width: SCREEN_WIDTH } = Dimensions.get('window');

interface ComponentScores {
  operation: number;
  professionalism: number;
  discipline: number;
}

interface Driver {
  rank: number;
  name: string;
  team: string;
  score: number;
  streak: number;
  trend: 'up' | 'down' | 'same';
  trendValue: number;
  componentScores?: ComponentScores;
  age?: number;
  vehicle?: string;
  department?: string;
  division?: string;
  area?: string;
}

function TopThreePodium({ drivers, colors }: { drivers: Driver[], colors: any }) {
  const [second, first, third] = [drivers[1], drivers[0], drivers[2]];

  if (!first) return null;

  const styles = useMemo(() => createStyles(colors), [colors]);

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
          <Text style={styles.podiumName} numberOfLines={1}>{second.name.replace('Driver ', '')}</Text>
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
        <Text style={[styles.podiumName, styles.podiumNameFirst]} numberOfLines={1}>{first.name.replace('Driver ', '')}</Text>
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
          <Text style={styles.podiumName} numberOfLines={1}>{third.name.replace('Driver ', '')}</Text>
          <Text style={styles.podiumScore}>{third.score}%</Text>
        </View>
      ) : <View style={styles.podiumItem} />}
    </View>
  );
}

function LeaderboardItem({ driver, isPitLane, colors, isExpanded, onPress, isManager }: { driver: Driver; isPitLane?: boolean; colors: any; isExpanded: boolean; onPress: () => void; isManager: boolean }) {
  const { t } = useTranslation();
  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <TouchableOpacity 
      activeOpacity={isManager ? 0.8 : 1}
      onPress={isManager ? onPress : undefined}
      style={[
        styles.leaderboardItem,
        isPitLane && styles.leaderboardItemPitLane,
      ]}
    >
      <View style={styles.itemMainRow}>
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

        <View style={{ marginLeft: 8 }}>
            {isManager && (
                isExpanded ? (
                    <ChevronDown color={colors.text.tertiary} size={20} />
                ) : (
                    <ChevronRight color={colors.text.tertiary} size={20} />
                )
            )}
        </View>
      </View>

      {isExpanded && (
          <View style={styles.expandedContent}>
              <View style={styles.personalInfoContainer}>
                  <View style={styles.infoItem}>
                      <Text style={styles.infoLabel}>{t('common.age', 'Age')}</Text>
                      <Text style={styles.infoValue}>{driver.age || '-'}</Text>
                  </View>
                  <View style={styles.divider} />
                  <View style={styles.infoItem}>
                      <Text style={styles.infoLabel}>{t('common.vehicle', 'Vehicle')}</Text>
                      <Text style={styles.infoValue}>{driver.vehicle || '-'}</Text>
                  </View>
              </View>
              
              {driver.componentScores && (
              <View style={styles.paramsContainer}>
                  <View style={styles.paramItem}>
                      <Text style={styles.paramLabel}>{t('leaderboard.operation', 'Operation')}</Text>
                      <View style={styles.paramBarBg}>
                          <View style={[styles.paramBarFill, { width: `${driver.componentScores.operation}%`, backgroundColor: colors.primary.DEFAULT }]} />
                      </View>
                      <Text style={styles.paramValue}>{driver.componentScores.operation}%</Text>
                  </View>
                  <View style={styles.paramItem}>
                      <Text style={styles.paramLabel}>{t('leaderboard.professionalism', 'Prof.')}</Text>
                      <View style={styles.paramBarBg}>
                          <View style={[styles.paramBarFill, { width: `${driver.componentScores.professionalism}%`, backgroundColor: colors.leaderboard.purple }]} />
                      </View>
                      <Text style={styles.paramValue}>{driver.componentScores.professionalism}%</Text>
                  </View>
                  <View style={styles.paramItem}>
                      <Text style={styles.paramLabel}>{t('leaderboard.discipline', 'Discipline')}</Text>
                      <View style={styles.paramBarBg}>
                          <View style={[styles.paramBarFill, { width: `${driver.componentScores.discipline}%`, backgroundColor: colors.leaderboard.gold }]} />
                      </View>
                      <Text style={styles.paramValue}>{driver.componentScores.discipline}%</Text>
                  </View>
                  </View>
              )}
          </View>
      )}
    </TouchableOpacity>
  );
}

export function LeaderboardScreen() {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [activeTab, setActiveTab] = useState<'weekly' | 'monthly' | 'allTime'>('weekly');
  const [drivers, setDrivers] = useState<Driver[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [expandedDriverId, setExpandedDriverId] = useState<number | null>(null);
  
  // Manager View State
  const [isManager, setIsManager] = useState(false);
  const [managerProfile, setManagerProfile] = useState<any>(null);
  const [activeFilter, setActiveFilter] = useState<'All' | 'Department' | 'Division' | 'Area'>('All');

  const styles = useMemo(() => createStyles(colors), [colors]);

  // Refresh leaderboard when screen comes into focus
  useFocusEffect(
    useCallback(() => {
      setDrivers([]); // Clear current list immediately to avoid confusion
      checkUserRole();
      loadLeaderboard();
    }, [activeTab])
  );

  const checkUserRole = async () => {
      const { profile } = await AuthService.getUserProfile();
      if (profile?.role === 'manager' || profile?.role === 'admin') {
          setIsManager(true);
          setManagerProfile(profile);
      }
  };

  const loadLeaderboard = async () => {
    try {
      setLoading(true);
      
      let queryFn;
      
      // Calculate date ranges
      const now = new Date();
      let startDate = new Date();
      
      if (activeTab === 'weekly') {
        startDate.setDate(now.getDate() - 7);
      } else if (activeTab === 'monthly') {
        startDate.setDate(now.getDate() - 30);
      } else {
        startDate = new Date(0); 
      }

      // For Weekly/Monthly, we need to aggregate quiz attempts
      if (activeTab === 'weekly' || activeTab === 'monthly') {
          const { data: attempts, error } = await supabase
            .from('quiz_attempts')
            .select('user_id, score, component_scores, profiles(full_name, region, streak, age, vehicle_type, department, division, area)')
            .gte('completed_at', startDate.toISOString());

          if (error) throw error;

          // Aggregate scores by user
          const userScores: Record<string, { total: number, count: number, profile: any, components: ComponentScores }> = {};
          
          attempts?.forEach((attempt: any) => {
              const profileData = Array.isArray(attempt.profiles) ? attempt.profiles[0] : attempt.profiles;
              if (!userScores[attempt.user_id]) {
                  userScores[attempt.user_id] = { 
                      total: 0, 
                      count: 0, 
                      profile: profileData,
                      components: { operation: 0, professionalism: 0, discipline: 0 }
                  };
              }
              userScores[attempt.user_id].total += attempt.score;
              userScores[attempt.user_id].count += 1;
              
              if (attempt.component_scores) {
                   userScores[attempt.user_id].components.operation += (attempt.component_scores.operation || 0);
                   userScores[attempt.user_id].components.professionalism += (attempt.component_scores.professionalism || 0);
                   userScores[attempt.user_id].components.discipline += (attempt.component_scores.discipline || 0);
              }
          });

          // Fetch previous period for trend
           const previousStartDate = new Date(startDate);
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
 
            const prevScores: Record<string, { total: number, count: number }> = {};
            prevAttempts?.forEach((attempt: any) => {
                if (!prevScores[attempt.user_id]) {
                    prevScores[attempt.user_id] = { total: 0, count: 0 };
                }
                prevScores[attempt.user_id].total += attempt.score;
                prevScores[attempt.user_id].count += 1;
            });

          const mappedDrivers: Driver[] = Object.keys(userScores).map((userId) => {
              const u = userScores[userId];
              const currentAvg = Math.round(u.total / u.count);

              // Calculate average component scores
              const compAvg = {
                  operation: Math.round(u.components.operation / u.count),
                  professionalism: Math.round(u.components.professionalism / u.count),
                  discipline: Math.round(u.components.discipline / u.count),
              };
              
              let trend: 'up' | 'down' | 'same' = 'same';
              let trendValue = 0;
              const prev = prevScores[userId];
              if (prev && prev.count > 0) {
                   const prevAvg = Math.round(prev.total / prev.count);
                   const diff = currentAvg - prevAvg;
                   if (diff > 0) { trend = 'up'; trendValue = diff; }
                   else if (diff < 0) { trend = 'down'; trendValue = Math.abs(diff); }
              }
              
              return {
                  rank: 0,
                  name: u.profile?.full_name || 'Driver',
                  team: u.profile?.region === 'MY' ? 'Malaysia' : 'Portugal',
                  score: currentAvg,
                  streak: u.profile?.streak || 0,
                  trend,
                  trendValue,

                  componentScores: compAvg,
                  age: u.profile?.age,
                  vehicle: u.profile?.vehicle_type,
                  department: u.profile?.department,
                  division: u.profile?.division,
                  area: u.profile?.area
              };
          });

          mappedDrivers.sort((a, b) => b.score - a.score);
          mappedDrivers.forEach((d, i) => d.rank = i + 1);
          setDrivers(mappedDrivers);

      } else {
          // All Time - use safety_index as the score
          const { data, error } = await supabase
            .from('profiles')
            .select('*')
            .order('safety_index', { ascending: false })
            .limit(50);

          if (error) throw error;

          if (data) {
            const mappedDrivers: Driver[] = data.map((p: any, index: number) => ({
              rank: index + 1,
              name: p.full_name || 'Driver',
              team: p.region === 'MY' ? 'Malaysia' : 'Portugal',
              score: p.safety_index || p.total_score || 0,
              streak: p.streak || 0,
              trend: 'same',
              trendValue: 0,

              componentScores: p.component_scores || { operation: 0, professionalism: 0, discipline: 0 },
              age: p.age,
              vehicle: p.vehicle_type
            }));
            
            // Re-sort just in case
            mappedDrivers.sort((a, b) => b.score - a.score);
            mappedDrivers.forEach((d, i) => d.rank = i + 1);
            
            setDrivers(mappedDrivers);
          }
      }

    } catch (error) {
      console.error('Error loading leaderboard:', error);
    } finally {
      setLoading(false);
    }
  };
  
  const filteredDrivers = drivers.filter(d => {
    const matchesSearch = d.name.toLowerCase().includes(searchQuery.toLowerCase());
    
    // Filter Logic for Managers
    if (activeFilter === 'All') return matchesSearch;
    
    // Filter by Manager's context
    if (managerProfile) {
        if (activeFilter === 'Department' && managerProfile.department) {
             return matchesSearch && d.department === managerProfile.department;
        }
        if (activeFilter === 'Division' && managerProfile.division) {
             return matchesSearch && d.division === managerProfile.division;
        }
        if (activeFilter === 'Area' && managerProfile.area) {
             return matchesSearch && d.area === managerProfile.area;
        }
    }
    
    // Fallback if no match or no manager profile
    return matchesSearch;
  });

  const topThree = filteredDrivers.slice(0, 3);

  const handleExpand = (rank: number) => {
      LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
      setExpandedDriverId(expandedDriverId === rank ? null : rank);
  };

  return (
    <View style={styles.container}>
      <SafeAreaView style={styles.safeArea}>
        <View style={styles.header}>
          <Text style={styles.headerTitle}>{t('leaderboard.title', 'Leaderboard')}</Text>
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
                {tab === 'allTime' ? t('leaderboard.allTime', 'All Time') : t(`leaderboard.${tab}`, tab.charAt(0).toUpperCase() + tab.slice(1))}
              </Text>
            </TouchableOpacity>
          ))}
        </View>

        {/* Manager Filters */}
        {isManager && (
            <View style={styles.managerFiltersContainer}>
                <Text style={styles.managerLabel}>{t('leaderboard.filterBy')}</Text>
                <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.filterScroll}>
                    {(['All', 'Department', 'Division', 'Area'] as const).map((filter) => (
                        <TouchableOpacity 
                            key={filter} 
                            style={[styles.filterChip, activeFilter === filter && styles.filterChipActive]}
                            onPress={() => setActiveFilter(filter)}
                        >
                            <Text style={[styles.filterText, activeFilter === filter && styles.filterTextActive]}>
                                {filter}
                            </Text>
                        </TouchableOpacity>
                    ))}
                </ScrollView>
            </View>
        )}
        
        {/* Search Bar */}
        <View style={styles.searchContainer}>
            <View style={styles.searchBar}>
                <Search color={colors.text.tertiary} size={20} />
                <TextInput 
                    placeholder={t('leaderboard.searchPlaceholder')} 
                    placeholderTextColor={colors.text.tertiary}
                    style={styles.searchInput}
                    value={searchQuery}
                    onChangeText={setSearchQuery}
                />
            </View>
        </View>

        <FlatList
          data={filteredDrivers}
          style={styles.scrollView}
          contentContainerStyle={{ flexGrow: 1 }}
          showsVerticalScrollIndicator={false}
          keyExtractor={(item) => item.rank.toString()}
          extraData={expandedDriverId} // Ensure re-render on expand/collapse
          ListHeaderComponent={
            <>
               {!searchQuery && <TopThreePodium drivers={topThree} colors={colors} />}
            </>
          }
          ListEmptyComponent={
            loading ? (
               <View style={styles.loadingContainer}>
                  <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
               </View>
            ) : (
              <View style={{ padding: 20, alignItems: 'center' }}>
                <Text style={{ color: colors.text.secondary }}>{t('common.noResults', 'No drivers found')}</Text>
              </View>
            )
          }
          renderItem={({ item, index }) => {
            const isPitLaneItem = !searchQuery && index >= 10;
            const showPitLaneHeader = !searchQuery && index === 10;

            return (
              <View>
                {showPitLaneHeader && (
                    <View style={[styles.pitLaneHeader, { marginTop: 24, marginHorizontal: 16 }]}>
                        <Wrench color={colors.leaderboard.pitLane} size={24} />
                        <Text style={styles.pitLaneTitle}>{t('social.pitLane')}</Text>
                        <Text style={styles.pitLaneSubtitle}>{t('leaderboard.tuneUp')}</Text>
                    </View>
                )}
                
                <View style={{ marginHorizontal: 16 }}>
                      <LeaderboardItem 
                        driver={item} 
                        isPitLane={isPitLaneItem} 
                        colors={colors}
                        isExpanded={expandedDriverId === item.rank}
                        onPress={() => handleExpand(item.rank)}
                        isManager={isManager}
                      />
                </View>
              </View>
            );
          }}
          ListFooterComponent={
              <View style={styles.bottomPadding} />
          }
        />
      </SafeAreaView>
    </View>
  );
}

const createStyles = (colors: any) => StyleSheet.create({
  loadingContainer: {
    height: 300,
    justifyContent: 'center',
    alignItems: 'center',
  },
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  safeArea: {
    flex: 1,
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
    marginBottom: 12,
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
    backgroundColor: '#CA8A04', // Darker Gold (yellow-600) instead of primary default
  },
  tabText: {
    fontFamily: 'Inter-Medium',
    fontSize: 13,
    color: colors.text.secondary,
  },
  tabTextActive: {
    color: colors.text.inverse,
  },
  searchContainer: {
      paddingHorizontal: 16,
      marginBottom: 16,
  },
  searchBar: {
      flexDirection: 'row',
      alignItems: 'center',
      backgroundColor: colors.background.card,
      borderRadius: 12,
      paddingHorizontal: 12,
      paddingVertical: 10,
      borderWidth: 1,
      borderColor: colors.border,
  },
  managerFiltersContainer: {
      paddingHorizontal: 16,
      marginBottom: 12,
  },
  managerLabel: {
      fontSize: 12,
      fontFamily: 'Inter-Bold',
      color: colors.text.secondary,
      marginBottom: 8,
      marginLeft: 4,
  },
  filterScroll: {
      paddingRight: 16,
      gap: 8,
  },
  filterChip: {
      paddingHorizontal: 16,
      paddingVertical: 6,
      borderRadius: 16,
      backgroundColor: colors.background.subtle,
      borderWidth: 1,
      borderColor: colors.border,
  },
  filterChipActive: {
      backgroundColor: colors.primary.DEFAULT,
      borderColor: colors.primary.DEFAULT,
  },
  filterText: {
      fontSize: 12,
      fontFamily: 'Inter-Medium',
      color: colors.text.secondary,
  },
  filterTextActive: {
      color: colors.text.inverse,
      fontFamily: 'Inter-Bold',
  },
  searchInput: {
      flex: 1,
      marginLeft: 10,
      color: colors.text.primary,
      fontFamily: 'Inter-Medium',
      fontSize: 14,
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
    textAlign: 'center',
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
    color: '#CA8A04', // Darker Gold
    fontSize: 18,
  },
  leaderboardItem: {
    marginBottom: 8,
    backgroundColor: colors.background.card,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: colors.border,
    padding: 12,
  },
  itemMainRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  expandedContent: {
      marginTop: 12,
      paddingTop: 12,
      borderTopWidth: 1,
      borderTopColor: colors.border,
  },
  paramsContainer: {
      flexDirection: 'row',
      justifyContent: 'space-between',
  },
  paramItem: {
      flex: 1,
      alignItems: 'center',
  },
  paramLabel: {
      fontSize: 11,
      color: colors.text.tertiary,
      marginBottom: 4,
      fontFamily: 'Inter-Medium',
  },
  paramBarBg: {
      width: '80%',
      height: 4,
      backgroundColor: colors.background.subtle,
      borderRadius: 2,
      marginBottom: 4,
  },
  paramBarFill: {
      height: '100%',
      borderRadius: 2,
  },
  paramValue: {
      fontSize: 12,
      color: colors.text.primary,
      fontFamily: 'Inter-Bold',
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
  personalInfoContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
    backgroundColor: 'rgba(255,255,255,0.05)',
    borderRadius: 8,
    padding: 8,
  },
  infoItem: {
    flex: 1,
    alignItems: 'center',
  },
  divider: {
    width: 1,
    height: '60%',
    backgroundColor: 'rgba(255,255,255,0.1)',
  },
  infoLabel: {
    fontSize: 11,
    color: colors.text.tertiary,
    marginBottom: 2,
    fontFamily: 'Inter-Medium',
  },
  infoValue: {
    fontSize: 13,
    color: colors.text.primary,
    fontFamily: 'Inter-Bold',
  },
});
