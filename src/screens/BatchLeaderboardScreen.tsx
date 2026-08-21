import React, { useState, useEffect, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  RefreshControl,
  ActivityIndicator,
  Dimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Trophy, Download, ChevronDown, ChevronUp, Trash2, AlertTriangle, X } from 'lucide-react-native';
import { GlassButton } from '../components/ui/GlassButton';
import { TextInput, Alert, Modal } from 'react-native';
import { useTheme } from '../context/ThemeContext';
import { AuthService } from '../services/authService';
import { BatchService } from '../services/batchService';
import { ExcelExportService } from '../services/excelExportService';
import { ManagementActionService } from '../services/managementActionService';
import { LinearGradient } from 'expo-linear-gradient';
import { GradientBackground } from '../components/ui/GradientBackground';
import { typography } from '../theme/typography';

const { width: SCREEN_WIDTH } = Dimensions.get('window');

interface LeaderboardEntry {
  userId: string;
  userName: string;
  staffId: string;
  averageScore: number;
  accuracy: number;
  completion: number;
  attemptCount: number;
  age: number | null;
  vehicleType: string | null;
  overallScore?: number;
  rank?: string;
  csiPercentage?: number;
  proHayatBand?: string;
  proHayatBandLabel?: string;
  componentScores: {
    operation: number;
    discipline: number;
    professionalism: number;
  };
}

export function BatchLeaderboardScreen({ navigation }: any) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const [availableBatches, setAvailableBatches] = useState<number[]>([1, 2, 3, 4, 5, 6, 7, 8]);
  const [selectedBatch, setSelectedBatch] = useState<number>(1);
  const [leaderboard, setLeaderboard] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [isManager, setIsManager] = useState(false);
  const [exportingExcel, setExportingExcel] = useState(false);
  const [expandedUserId, setExpandedUserId] = useState<string | null>(null);
  
  // Deletion State
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [userToDelete, setUserToDelete] = useState<LeaderboardEntry | null>(null);
  const [deleteConfirmText, setDeleteConfirmText] = useState('');
  const [isDeleting, setIsDeleting] = useState(false);

  useEffect(() => {
    const unsubscribe = navigation.addListener('focus', () => {
      loadLeaderboard();
    });

    return unsubscribe;
  }, [navigation]);

  // Reload when batch selection changes
  useEffect(() => {
    loadLeaderboard();
    setExpandedUserId(null); // Reset expanded item when switching batches
  }, [selectedBatch]);

  useEffect(() => {
    checkUserRole();
  }, []);

  const checkUserRole = async () => {
    const { profile } = await AuthService.getUserProfile();
    setIsManager(profile?.role === 'manager');
  };

  const loadLeaderboard = async () => {
    try {
      setLoading(true);
      
      const batches = await BatchService.getAvailableBatchNumbers();
      setAvailableBatches(batches);

      // Get all users' batch stats
      const stats = await BatchService.getAllUsersBatchStats();
      
      // Filter for selected batch and transform
      const batchLeaderboard: LeaderboardEntry[] = stats
        .map(user => {
          const batchData = user.batches.find(b => b.batchNumber === selectedBatch);
          const score = user.overallScore ?? user.csiPercentage ?? 0;
          const userRank = user.rank || user.proHayatBand || 'D Rank';
          return {
            userId: user.userId,
            userName: user.userName,
            staffId: user.staffId,
            averageScore: batchData?.averageScore || 0,
            accuracy: batchData?.accuracy || 0,
            completion: batchData?.completion || 0,
            attemptCount: batchData?.attemptCount || 0,
            age: (user as any).age || null,
            vehicleType: (user as any).vehicleType || null,
            overallScore: score,
            rank: userRank,
            csiPercentage: score,
            proHayatBand: userRank,
            proHayatBandLabel: userRank,
            componentScores: batchData?.componentScores || {
              operation: 0,
              discipline: 0,
              professionalism: 0,
            },
          };
        })
        .filter(entry => entry.attemptCount > 0) // Only show users who have attempted
        .sort((a, b) => b.averageScore - a.averageScore); // Sort by score descending

      setLeaderboard(batchLeaderboard);
    } catch (error) {
      console.error('Error loading leaderboard:', error);
    } finally {
      setLoading(false);
    }
  };

  const onRefresh = async () => {
    setRefreshing(true);
    await loadLeaderboard();
    setRefreshing(false);
  };

  const handleExportExcel = async () => {
    try {
      setExportingExcel(true);
      const { success, message } = await ExcelExportService.exportLeaderboard();
      
      if (success) {
        Alert.alert(t('common.success'), t('leaderboard.exportSuccess'));
      } else {
        Alert.alert(t('common.error'), message || t('leaderboard.exportFailed'));
      }
    } catch (error: any) {
      console.error('Error exporting Excel:', error);
      Alert.alert(t('common.error'), error.message || t('leaderboard.exportFailed'));
    } finally {
      setExportingExcel(false);
    }
  };

  const handleDeleteUser = async () => {
    if (!userToDelete) return;
    
    if (deleteConfirmText !== userToDelete.staffId) {
      Alert.alert(t('common.error'), t('user.deleteConfirmError', 'Employee ID does not match'));
      return;
    }

    try {
      setIsDeleting(true);
      const { success, error } = await AuthService.deleteUser(userToDelete.userId);
      
      if (!success) throw new Error(error);

      Alert.alert(t('common.success'), t('user.deleteSuccess', 'User deleted successfully'));
      setShowDeleteModal(false);
      setUserToDelete(null);
      setDeleteConfirmText('');
      loadLeaderboard();
    } catch (error: any) {
      Alert.alert(t('common.error'), error.message || 'Failed to delete user');
    } finally {
      setIsDeleting(false);
    }
  };

  const renderBatchTabs = () => (
    <View>
      <ScrollView 
        horizontal 
        showsHorizontalScrollIndicator={false} 
        contentContainerStyle={styles.tabsContainer}
      >
        {availableBatches.map((batch) => (
          <TouchableOpacity
            key={batch}
            activeOpacity={0.8}
            style={[styles.tab]}
            onPress={() => setSelectedBatch(batch)}
          >
            {selectedBatch === batch ? (
              <LinearGradient
                colors={colors.gradients.primary as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
              />
            ) : null}
            <Text style={[styles.tabText, selectedBatch === batch && styles.tabTextActive]}>
              {t('quiz.batchTitle', { number: batch })}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </View>
  );

  const renderPodium = () => {
    const top3 = leaderboard.slice(0, 3);
    if (top3.length === 0) return null;

    const podiumOrder = [
      { position: 2, index: 1, height: 100, color: colors.leaderboard.silver },
      { position: 1, index: 0, height: 140, color: colors.leaderboard.gold },
      { position: 3, index: 2, height: 80, color: colors.leaderboard.bronze },
    ];

    return (
      <View style={styles.podiumContainer}>
        <Text style={styles.podiumTitle}>{t('leaderboard.top3')}</Text>
        <View style={styles.podiumRow}>
          {podiumOrder.map((item) => {
            const user = top3[item.index];
            if (!user) return <View key={item.position} style={{ flex: 1 }} />;

            return (
              <View key={item.position} style={[styles.podiumItem, { flex: 1 }]}>
                <Text style={styles.podiumName}>{user.userName.split(' ')[0]}</Text>
                <Text style={styles.podiumScore}>{user.averageScore.toFixed(1)}%</Text>
                <View
                  style={[
                    styles.podiumBase,
                    {
                      height: item.height,
                      backgroundColor: item.color,
                    },
                  ]}
                >
                  <Text style={styles.podiumRank}>{item.position}</Text>
                </View>
              </View>
            );
          })}
        </View>
      </View>
    );
  };

  const renderLeaderboardItem = (entry: LeaderboardEntry, index: number) => {
    const isExpanded = expandedUserId === entry.userId;
    const rank = index + 1;
    const passed = entry.averageScore >= 60;

    // Driver view: Redacted information
    const isCompleted = entry.completion >= 100;

    // Regular driver view
    if (!isManager) {
      return (
        <View key={entry.userId} style={styles.leaderboardItem}>
          <View style={styles.leaderboardItemHeader}>
            <View style={styles.rankBadge}>
              <Text style={styles.rankText}>{rank}</Text>
            </View>
            <View style={styles.userInfo}>
              <Text style={styles.userName}>{entry.userName}</Text>
              <Text style={styles.userSubtext}>Driver</Text>
            </View>
            <View style={styles.scoreInfo}>
              {isCompleted ? (
                <Text style={[styles.scoreText, passed && styles.scoreTextPassed, !passed && styles.scoreTextFailed]}>
                  {entry.averageScore.toFixed(1)}%
                </Text>
              ) : (
                <View style={[styles.inProgressBadge, { backgroundColor: '#F59E0B20', borderColor: '#F59E0B', borderWidth: 1, paddingHorizontal: 6, paddingVertical: 2, borderRadius: 6 }]}>
                  <Text style={[styles.inProgressText, { color: '#F59E0B', fontSize: 11 }]}>
                    {t('leaderboard.inProgress', 'In Progress')} ({Math.round(entry.completion)}%)
                  </Text>
                </View>
              )}
            </View>
          </View>
        </View>
      );
    }

    // Manager / Master User view: Full information with dropdown
    return (
      <TouchableOpacity 
        key={entry.userId} 
        style={styles.leaderboardItem}
        onPress={() => setExpandedUserId(isExpanded ? null : entry.userId)}
        activeOpacity={0.7}
      >
        <View style={styles.leaderboardItemHeader}>
          <View style={styles.rankBadge}>
            <Text style={styles.rankText}>{rank}</Text>
          </View>

          <View style={styles.userInfo}>
            <Text style={styles.userName}>{entry.userName}</Text>
            <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, flexWrap: 'wrap' }}>
              <Text style={styles.userSubtext}>{entry.staffId}</Text>
            </View>
          </View>

          <View style={styles.scoreInfo}>
            {isCompleted ? (
              <Text style={[styles.scoreText, passed && styles.scoreTextPassed, !passed && styles.scoreTextFailed]}>
                {entry.averageScore.toFixed(1)}%
              </Text>
            ) : (
              <View style={[styles.inProgressBadge, { backgroundColor: '#F59E0B20', borderColor: '#F59E0B', borderWidth: 1, paddingHorizontal: 6, paddingVertical: 2, borderRadius: 6 }]}>
                <Text style={[styles.inProgressText, { color: '#F59E0B', fontSize: 11 }]}>
                  {t('leaderboard.inProgress', 'In Progress')} ({Math.round(entry.completion)}%)
                </Text>
              </View>
            )}
            <Text style={styles.scoreSubtext}>
              {entry.attemptCount} {entry.attemptCount === 1 ? t('leaderboard.attempt') : t('leaderboard.attempts')}
            </Text>
          </View>

          {/* Dropdown indicator */}
          <View style={styles.chevronContainer}>
            {isExpanded ? (
              <ChevronUp size={20} color={colors.text.secondary} />
            ) : (
              <ChevronDown size={20} color={colors.text.secondary} />
            )}
          </View>
        </View>

        {isExpanded && (
          <View style={styles.expandedDetails}>
            {/* Personal Details */}
            <View style={styles.personalDetailsRow}>
              <View style={styles.personalDetailItem}>
                <Text style={styles.dopLabel}>{t('profile.age', 'Age')}</Text>
                <Text style={styles.personalDetailValue}>
                  {entry.age ? `${entry.age} yrs` : '-'}
                </Text>
              </View>
              <View style={styles.personalDetailItem}>
                <Text style={styles.dopLabel}>{t('profile.vehicleType', 'Vehicle')}</Text>
                <Text style={styles.personalDetailValue}>
                  {entry.vehicleType || '-'}
                </Text>
              </View>
            </View>

            {/* DOP Scores - Reverted to text as requested */}
            <View style={styles.dopGrid}>
              <View style={styles.dopItem}>
                <Text style={styles.dopLabel}>{t('leaderboard.operation', 'Operation')}</Text>
                <Text style={[styles.dopValue, { color: entry.componentScores.operation >= 60 ? '#00C853' : '#FF3D00' }]}>
                  {entry.componentScores.operation}%
                </Text>
              </View>
              <View style={styles.dopItem}>
                <Text style={styles.dopLabel}>{t('leaderboard.discipline', 'Discipline')}</Text>
                <Text style={[styles.dopValue, { color: entry.componentScores.discipline >= 60 ? '#00C853' : '#FF3D00' }]}>
                  {entry.componentScores.discipline}%
                </Text>
              </View>
              <View style={styles.dopItem}>
                <Text style={styles.dopLabel}>{t('leaderboard.professionalism', 'Professionalism')}</Text>
                <Text style={[styles.dopValue, { color: entry.componentScores.professionalism >= 60 ? '#00C853' : '#FF3D00' }]}>
                  {entry.componentScores.professionalism}%
                </Text>
              </View>
            </View>

            {/* Management Intelligence & Action Recommendation */}
            {(() => {
              const dpiAnalysis = ManagementActionService.analyzeDPI(entry.componentScores);
              const isHighRisk = dpiAnalysis.riskLevel === 'High Risk';
              const isMedRisk = dpiAnalysis.riskLevel === 'Medium Risk';
              const badgeBg = isHighRisk ? '#FF174420' : isMedRisk ? '#FFD60020' : '#00E67620';
              const badgeText = isHighRisk ? '#FF1744' : isMedRisk ? '#FFC400' : '#00E676';

              return (
                <View style={{
                  marginTop: 12,
                  padding: 10,
                  borderRadius: 8,
                  backgroundColor: colors.mode === 'light' ? '#F4F6F8' : 'rgba(255, 255, 255, 0.05)',
                  borderWidth: 1,
                  borderColor: colors.mode === 'light' ? '#E1E8ED' : 'rgba(255, 255, 255, 0.1)',
                }}>
                  <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 6 }}>
                    <Text style={{ fontSize: 11, fontWeight: '700', color: colors.mode === 'light' ? '#657786' : '#AAB8C2', textTransform: 'uppercase' }}>
                      Priority #1 Focus: <Text style={{ color: colors.text.primary }}>{dpiAnalysis.priority1.label}</Text>
                    </Text>
                    <View style={{ backgroundColor: badgeBg, paddingHorizontal: 6, paddingVertical: 2, borderRadius: 4 }}>
                      <Text style={{ fontSize: 10, fontWeight: '700', color: badgeText }}>
                        {dpiAnalysis.riskLevel}
                      </Text>
                    </View>
                  </View>
                  <Text style={{ fontSize: 11, fontStyle: 'italic', color: colors.text.primary, lineHeight: 15 }}>
                    "{dpiAnalysis.managementAction}"
                  </Text>
                </View>
              );
            })()}
          </View>
        )}
      </TouchableOpacity>
    );
  };

  return (
    <GradientBackground>
      <SafeAreaView edges={['top', 'left', 'right']} style={styles.safeArea}>
        <View style={styles.header}>
          <Text style={styles.headerTitle}>{t('leaderboard.title')}</Text>
          {isManager && (
            <TouchableOpacity
              style={styles.exportButton}
              onPress={handleExportExcel}
              disabled={exportingExcel}
            >
              {exportingExcel ? (
                <ActivityIndicator size="small" color={colors.mode === 'light' ? '#FFF' : '#000'} />
              ) : (
                <>
                  <Download size={18} color={colors.mode === 'light' ? '#FFF' : '#000'} />
                  <Text style={styles.exportButtonText}>{t('leaderboard.export')}</Text>
                </>
              )}
            </TouchableOpacity>
          )}
        </View>

        {renderBatchTabs()}

        <ScrollView
          contentContainerStyle={styles.content}
          refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
        >
          {loading ? (
            <View style={styles.loadingContainer}>
              <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
            </View>
          ) : (
            <>
              {renderPodium()}

              <View style={styles.listContainer}>
                <Text style={styles.listTitle}>{t('leaderboard.allRankings')}</Text>
                {leaderboard.length === 0 ? (
                  <Text style={styles.emptyText}>{t('leaderboard.noAttempts')}</Text>
                ) : (
                  leaderboard.map((entry, index) => renderLeaderboardItem(entry, index))
                )}
              </View>
            </>
          )}
        </ScrollView>

        {/* Delete Confirmation Modal */}
        <Modal
          visible={showDeleteModal}
          transparent
          animationType="fade"
          onRequestClose={() => setShowDeleteModal(false)}
        >
          <View style={styles.modalOverlay}>
            <View style={styles.modalContent}>
              <View style={styles.modalHeader}>
                <AlertTriangle size={24} color={colors.status.danger} />
                <Text style={styles.modalTitle}>{t('user.deleteTitle', 'Delete Driver Account')}</Text>
                <TouchableOpacity onPress={() => setShowDeleteModal(false)}>
                  <X size={24} color={colors.text.secondary} />
                </TouchableOpacity>
              </View>

              <Text style={styles.modalText}>
                {t('user.deleteConfirmText', 'Are you sure? This action cannot be undone. All quiz history and compliance logs for this user will be permanently deleted.')}
              </Text>

              <View style={styles.verificationBox}>
                <Text style={styles.verifyLabel}>
                  {t('user.deleteVerifyLabel', 'To confirm, type "{{username}}" in the box below', { username: userToDelete?.staffId })}
                </Text>
                <TextInput
                  style={[styles.verifyInput, { borderColor: deleteConfirmText === userToDelete?.staffId ? colors.status.success : colors.border }]}
                  value={deleteConfirmText}
                  onChangeText={setDeleteConfirmText}
                  placeholder={userToDelete?.staffId}
                  placeholderTextColor={colors.text.tertiary}
                  autoCapitalize="characters"
                />
              </View>

              <View style={styles.modalActions}>
                <GlassButton
                  title={t('common.cancel')}
                  onPress={() => setShowDeleteModal(false)}
                  variant="secondary"
                  style={{ flex: 1 }}
                />
                <GlassButton
                  title={isDeleting ? t('common.deleting', 'Deleting...') : t('common.delete', 'Delete')}
                  onPress={handleDeleteUser}
                  variant="danger"
                  style={{ flex: 1 }}
                  disabled={isDeleting || deleteConfirmText !== userToDelete?.staffId}
                />
              </View>
            </View>
          </View>
        </Modal>
      </SafeAreaView>
    </GradientBackground>
  );
}

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 16,
  },
  headerTitle: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  exportButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.text.primary,
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 8,
    gap: 6,
  },
  exportButtonText: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.mode === 'light' ? '#FFFFFF' : '#000000',
  },
  tabsContainer: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    marginBottom: 16,
    gap: 8,
  },
  tab: {
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderRadius: 12, // slightly larger rounds for premium view
    backgroundColor: colors.background.card,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'transparent',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 4,
  },
  tabActive: {
    backgroundColor: colors.primary.DEFAULT,
    borderColor: colors.primary.DEFAULT,
  },
  tabText: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
  },
  tabTextActive: {
    color: '#FFFFFF', // White text on pink background
    fontFamily: typography.fonts.bold,
  },
  content: {
    padding: 20,
    paddingBottom: 120,
  },
  loadingContainer: {
    paddingVertical: 60,
    alignItems: 'center',
  },
  podiumContainer: {
    backgroundColor: colors.background.card,
    borderRadius: 16,
    padding: 20,
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  podiumTitle: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'center',
    marginBottom: 20,
  },
  podiumRow: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    justifyContent: 'center',
    gap: 8,
  },
  podiumItem: {
    alignItems: 'center',
  },
  podiumName: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
    marginBottom: 4,
  },
  podiumScore: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
    marginBottom: 8,
  },
  podiumBase: {
    width: '100%',
    borderTopLeftRadius: 8,
    borderTopRightRadius: 8,
    justifyContent: 'flex-start',
    alignItems: 'center',
    paddingTop: 12,
  },
  podiumRank: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    color: '#FFF',
  },
  listContainer: {
    backgroundColor: colors.background.card,
    borderRadius: 16,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  listTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
  },
  leaderboardItem: {
    paddingVertical: 12,
    paddingHorizontal: 4,
    borderBottomWidth: 1,
    borderBottomColor: colors.border || '#E0E0E0',
  },
  leaderboardItemHeader: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  rankBadge: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: colors.background.subtle || colors.background.card,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  rankText: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.text.secondary,
  },
  userInfo: {
    flex: 1,
  },
  userName: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  userSubtext: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    marginTop: 2,
  },
  scoreInfo: {
    alignItems: 'flex-end',
  },
  scoreText: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  scoreTextPassed: {
    color: '#00C853',
  },
  scoreTextFailed: {
    color: '#FF6B6B',
  },
  scoreSubtext: {
    fontSize: 11,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    marginTop: 2,
  },
  chevronContainer: {
    marginLeft: 8,
    padding: 4,
  },
  expandedDetails: {
    marginTop: 12,
    paddingTop: 12,
    borderTopWidth: 1,
    borderTopColor: colors.border || 'rgba(255,255,255,0.1)',
  },
  personalDetailsRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 16,
    paddingBottom: 12,
    borderBottomWidth: 1,
    borderBottomColor: colors.border || 'rgba(255,255,255,0.1)',
  },
  personalDetailItem: {
    alignItems: 'center',
    flex: 1,
  },
  personalDetailValue: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginTop: 4,
  },
  dopTitle: {
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    marginBottom: 8,
    textAlign: 'center',
  },
  dopRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  dopChartContainer: {
    marginTop: 8,
    paddingHorizontal: 12,
  },
  barRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
    gap: 10,
  },
  barLabel: {
    width: 90,
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  barTrack: {
    flex: 1,
    height: 8,
    backgroundColor: colors.background.subtle || 'rgba(0,0,0,0.1)',
    borderRadius: 4,
    overflow: 'hidden',
  },
  barFill: {
    height: '100%',
    borderRadius: 4,
  },
  barValue: {
    width: 40,
    fontSize: 12,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'right',
  },
  emptyText: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
    paddingVertical: 20,
  },
  managerActions: {
    marginTop: 16,
    flexDirection: 'row',
    justifyContent: 'flex-end',
  },
  deleteButton: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: colors.status.danger + '40',
    backgroundColor: colors.status.danger + '10',
    gap: 6,
  },
  deleteButtonText: {
    fontSize: 12,
    fontFamily: typography.fonts.bold,
    color: colors.status.danger,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.8)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  modalContent: {
    backgroundColor: colors.background.card,
    borderRadius: 16,
    padding: 24,
    width: '100%',
    maxWidth: 400,
    borderWidth: 1,
    borderColor: colors.border,
  },
  modalHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 16,
  },
  modalTitle: {
    flex: 1,
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginLeft: 12,
  },
  modalText: {
    fontSize: 14,
    lineHeight: 20,
    color: colors.text.secondary,
    fontFamily: typography.fonts.regular,
    marginBottom: 24,
  },
  verificationBox: {
    marginBottom: 24,
  },
  verifyLabel: {
    fontSize: 13,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    marginBottom: 8,
  },
  verifyInput: {
    borderWidth: 1,
    borderRadius: 8,
    padding: 12,
    fontSize: 16,
    color: colors.text.primary,
    fontFamily: typography.fonts.bold,
    backgroundColor: colors.background.subtle,
  },
  modalActions: {
    flexDirection: 'row',
    gap: 12,
  },
  dopGrid: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    backgroundColor: 'rgba(0,0,0,0.02)',
    borderRadius: 12,
    padding: 10,
    marginTop: 8,
  },
  dopItem: {
    alignItems: 'center',
    flex: 1,
  },
  dopLabel: {
    fontSize: 10,
    color: colors.text.tertiary,
    fontFamily: typography.fonts.medium,
    textTransform: 'uppercase',
    marginBottom: 2,
  },
  dopValue: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
  },
  inProgressBadge: {
    backgroundColor: 'rgba(245, 158, 11, 0.15)',
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 4,
    alignSelf: 'flex-start',
  },
  inProgressText: {
    fontSize: 10,
    color: '#D97706',
    fontFamily: typography.fonts.bold,
  },
});
