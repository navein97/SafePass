import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  TextInput,
  ActivityIndicator,
  Modal,
  Alert,
  Switch,
  Platform
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import {
  Shield,
  Users,
  Send,
  Activity,
  Search,
  Eye,
  ArrowLeft,
  CheckCircle,
  AlertCircle,
  Bell,
  Sparkles,
  Building,
  RefreshCw,
  Clock,
  Layers
} from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { PasscodeGateModal } from '../components/PasscodeGateModal';
import { SuperAdminService, MasterCompany } from '../services/superAdminService';
import { AnalyticsService, AppEvent } from '../services/analyticsService';
import { PasscodeService } from '../services/passcodeService';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { GradientBackground } from '../components/ui/GradientBackground';

export const SuperAdminScreen = ({ navigation }: any) => {
  const { colors } = useTheme();

  // Access Control State
  const [unlocked, setUnlocked] = useState(false);
  const [activeTab, setActiveTab] = useState<'masters' | 'broadcast' | 'analytics'>('masters');

  // Master Users State
  const [loadingCompanies, setLoadingCompanies] = useState(false);
  const [companies, setCompanies] = useState<MasterCompany[]>([]);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCompany, setSelectedCompany] = useState<MasterCompany | null>(null);
  const [inspectModalVisible, setInspectModalVisible] = useState(false);
  const [inspectTelemetry, setInspectTelemetry] = useState<{
    drivers: any[];
    recentQuizzes: any[];
    recentNotifications: any[];
  } | null>(null);
  const [loadingInspect, setLoadingInspect] = useState(false);

  // Broadcast State
  const [broadcastTarget, setBroadcastTarget] = useState<'all_masters' | 'beta_masters' | 'specific_company'>('all_masters');
  const [broadcastCompanyId, setBroadcastCompanyId] = useState('');
  const [broadcastTitle, setBroadcastTitle] = useState('');
  const [broadcastMessage, setBroadcastMessage] = useState('');
  const [sendingBroadcast, setSendingBroadcast] = useState(false);

  // Analytics & Event Logs State
  const [loadingAnalytics, setLoadingAnalytics] = useState(false);
  const [metrics, setMetrics] = useState({ totalEvents: 0, totalCompanies: 0, totalUsers: 0, totalQuizzes: 0 });
  const [eventLogs, setEventLogs] = useState<AppEvent[]>([]);

  useEffect(() => {
    if (unlocked) {
      loadData();
      AnalyticsService.trackEvent('super_admin_unlocked', { timestamp: new Date().toISOString() });
    }
  }, [unlocked]);

  const loadData = async () => {
    setLoadingCompanies(true);
    setLoadingAnalytics(true);

    const fetchedCompanies = await SuperAdminService.getAllMasterCompanies();
    setCompanies(fetchedCompanies);
    setLoadingCompanies(false);

    const fetchedMetrics = await AnalyticsService.getUsageMetrics();
    const fetchedLogs = await AnalyticsService.getRecentEvents(50);
    setMetrics(fetchedMetrics);
    setEventLogs(fetchedLogs);
    setLoadingAnalytics(false);
  };

  // Beta Toggle Handler
  const handleToggleBeta = async (comp: MasterCompany) => {
    const success = await SuperAdminService.toggleBetaStatus(comp.id, comp.is_beta_tester || false);
    if (success) {
      setCompanies(prev =>
        prev.map(c => (c.id === comp.id ? { ...c, is_beta_tester: !c.is_beta_tester } : c))
      );
      AnalyticsService.trackEvent('beta_status_toggled', { company_id: comp.id, new_status: !comp.is_beta_tester });
    }
  };

  // Incognito Telemetry Inspection Handler
  const handleInspect = async (comp: MasterCompany) => {
    setSelectedCompany(comp);
    setInspectModalVisible(true);
    setLoadingInspect(true);

    const telemetry = await SuperAdminService.inspectCompanyTelemetry(comp.id);
    setInspectTelemetry(telemetry);
    setLoadingInspect(false);

    AnalyticsService.trackEvent('incognito_telemetry_inspected', { company_id: comp.id, company_name: comp.name });
  };

  // Broadcast Handler
  const handleSendBroadcast = async () => {
    if (!broadcastTitle.trim() || !broadcastMessage.trim()) {
      Alert.alert('Required Fields Missing', 'Please provide both a Title and Message for the broadcast.');
      return;
    }

    if (broadcastTarget === 'specific_company' && !broadcastCompanyId) {
      Alert.alert('Selection Required', 'Please select a specific company to receive the message.');
      return;
    }

    setSendingBroadcast(true);

    const result = await SuperAdminService.sendTargetedNotification({
      targetType: broadcastTarget,
      companyId: broadcastCompanyId,
      title: broadcastTitle.trim(),
      message: broadcastMessage.trim(),
    });

    setSendingBroadcast(false);

    if (result.success) {
      Alert.alert('Broadcast Sent', `Successfully dispatched notification to ${result.count} master user(s).`);
      setBroadcastTitle('');
      setBroadcastMessage('');
      AnalyticsService.trackEvent('targeted_broadcast_sent', {
        target: broadcastTarget,
        count: result.count,
      });
    } else {
      Alert.alert('Broadcast Failed', result.error || 'Unable to send broadcast.');
    }
  };

  const filteredCompanies = companies.filter(c => {
    const query = searchQuery.toLowerCase();
    return (
      c.name.toLowerCase().includes(query) ||
      (c.code && c.code.toLowerCase().includes(query)) ||
      (c.master_user?.full_name && c.master_user.full_name.toLowerCase().includes(query)) ||
      (c.master_user?.email && c.master_user.email.toLowerCase().includes(query))
    );
  });

  if (!unlocked) {
    return (
      <View style={{ flex: 1, backgroundColor: colors.background.default }}>
        <PasscodeGateModal
          visible={!unlocked}
          title="Super Admin Portal Access"
          subtitle="Enter access passcode to unlock system monitoring and targeted messaging."
          onUnlocked={() => setUnlocked(true)}
          onCancel={() => {
            if (navigation.canGoBack()) navigation.goBack();
            else navigation.navigate('Login');
          }}
        />
      </View>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        {/* Header */}
        <View style={styles.header}>
          <TouchableOpacity
            style={[styles.iconBtn, { borderColor: colors.border }]}
            onPress={() => {
              if (navigation.canGoBack()) navigation.goBack();
              else navigation.navigate('Login');
            }}
          >
            <ArrowLeft color={colors.text.primary} size={20} />
          </TouchableOpacity>

          <View style={styles.headerTitleGroup}>
            <View style={styles.headerBadge}>
              <Shield size={14} color={colors.primary.DEFAULT} />
              <Text style={[styles.headerBadgeText, { color: colors.primary.DEFAULT }]}>SUPER ADMIN (/woof)</Text>
            </View>
            <Text style={[styles.headerTitle, { color: colors.text.primary }]}>Control Center</Text>
          </View>
        </View>

        {/* Tab Selector Bar */}
        <View style={[styles.tabBar, { backgroundColor: 'rgba(255, 255, 255, 0.05)', borderColor: colors.border }]}>
          <TouchableOpacity
            style={[styles.tabItem, activeTab === 'masters' && { backgroundColor: colors.primary.DEFAULT }]}
            onPress={() => setActiveTab('masters')}
          >
            <Users size={16} color={activeTab === 'masters' ? '#fff' : colors.text.secondary} />
            <Text style={[styles.tabText, { color: activeTab === 'masters' ? '#fff' : colors.text.secondary }]}>
              Master Users
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.tabItem, activeTab === 'broadcast' && { backgroundColor: colors.primary.DEFAULT }]}
            onPress={() => setActiveTab('broadcast')}
          >
            <Send size={16} color={activeTab === 'broadcast' ? '#fff' : colors.text.secondary} />
            <Text style={[styles.tabText, { color: activeTab === 'broadcast' ? '#fff' : colors.text.secondary }]}>
              Messaging
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.tabItem, activeTab === 'analytics' && { backgroundColor: colors.primary.DEFAULT }]}
            onPress={() => setActiveTab('analytics')}
          >
            <Activity size={16} color={activeTab === 'analytics' ? '#fff' : colors.text.secondary} />
            <Text style={[styles.tabText, { color: activeTab === 'analytics' ? '#fff' : colors.text.secondary }]}>
              Analytics & Logs
            </Text>
          </TouchableOpacity>
        </View>

        {/* TAB 1: MASTER USERS & INCOGNITO MONITORING */}
        {activeTab === 'masters' && (
          <ScrollView style={styles.tabContent} contentContainerStyle={{ paddingBottom: 40 }}>
            {/* Search and Refresh Bar */}
            <View style={styles.searchRow}>
              <View style={[styles.searchInputContainer, { borderColor: colors.border }]}>
                <Search size={18} color={colors.text.tertiary} style={{ marginRight: 8 }} />
                <TextInput
                  style={[styles.searchInput, { color: colors.text.primary }]}
                  placeholder="Search master user, email, or company code..."
                  placeholderTextColor={colors.text.tertiary}
                  value={searchQuery}
                  onChangeText={setSearchQuery}
                />
              </View>

              <TouchableOpacity style={[styles.refreshBtn, { borderColor: colors.border }]} onPress={loadData}>
                <RefreshCw size={18} color={colors.text.primary} />
              </TouchableOpacity>
            </View>

            {loadingCompanies ? (
              <ActivityIndicator size="large" color={colors.primary.DEFAULT} style={{ marginTop: 40 }} />
            ) : filteredCompanies.length === 0 ? (
              <View style={styles.emptyState}>
                <Building size={48} color={colors.text.tertiary} />
                <Text style={[styles.emptyText, { color: colors.text.secondary }]}>No master users found.</Text>
              </View>
            ) : (
              filteredCompanies.map(comp => (
                <GlassCard key={comp.id} style={styles.companyCard}>
                  <View style={styles.companyCardHeader}>
                    <View style={{ flex: 1 }}>
                      <View style={styles.companyTitleRow}>
                        <Text style={[styles.companyName, { color: colors.text.primary }]}>{comp.name}</Text>
                        {comp.code && (
                          <View style={[styles.codeBadge, { backgroundColor: colors.primary.DEFAULT + '20' }]}>
                            <Text style={[styles.codeBadgeText, { color: colors.primary.DEFAULT }]}>
                              {comp.code}
                            </Text>
                          </View>
                        )}
                      </View>
                      <Text style={[styles.masterDetailText, { color: colors.text.secondary }]}>
                        Master: {comp.master_user?.full_name || 'Unassigned'} ({comp.master_user?.email || 'No email'})
                      </Text>
                      {Boolean(comp.master_user?.phone_number) && (
                        <Text style={[styles.masterPhoneText, { color: colors.text.tertiary }]}>
                          📞 {comp.master_user?.phone_number}
                        </Text>
                      )}
                    </View>

                    {/* Incognito Inspect Action Button */}
                    <TouchableOpacity
                      style={[styles.inspectBtn, { backgroundColor: colors.primary.DEFAULT }]}
                      onPress={() => handleInspect(comp)}
                    >
                      <Eye size={16} color="#fff" />
                      <Text style={styles.inspectBtnText}>Incognito</Text>
                    </TouchableOpacity>
                  </View>

                  {/* Company Stats Grid */}
                  <View style={[styles.statsRow, { borderColor: colors.border }]}>
                    <View style={styles.statCol}>
                      <Text style={[styles.statValue, { color: colors.text.primary }]}>{comp.total_drivers}</Text>
                      <Text style={[styles.statLabel, { color: colors.text.tertiary }]}>Drivers</Text>
                    </View>
                    <View style={styles.statCol}>
                      <Text style={[styles.statValue, { color: colors.text.primary }]}>{comp.total_quizzes}</Text>
                      <Text style={[styles.statLabel, { color: colors.text.tertiary }]}>Quizzes</Text>
                    </View>
                    <View style={styles.statCol}>
                      <Text style={[styles.statValue, { color: colors.status.success }]}>{comp.average_score}%</Text>
                      <Text style={[styles.statLabel, { color: colors.text.tertiary }]}>Avg Score</Text>
                    </View>
                  </View>

                  {/* Beta Tester Toggle */}
                  <View style={styles.betaToggleRow}>
                    <View style={styles.betaLabelGroup}>
                      <Sparkles size={16} color={comp.is_beta_tester ? '#F59E0B' : colors.text.tertiary} />
                      <Text style={[styles.betaToggleLabel, { color: colors.text.primary }]}>
                        Testing / Beta User Group
                      </Text>
                    </View>
                    <Switch
                      value={Boolean(comp.is_beta_tester)}
                      onValueChange={() => handleToggleBeta(comp)}
                      trackColor={{ false: '#374151', true: colors.primary.DEFAULT }}
                      thumbColor="#fff"
                    />
                  </View>
                </GlassCard>
              ))
            )}
          </ScrollView>
        )}

        {/* TAB 2: TARGETED MESSAGING */}
        {activeTab === 'broadcast' && (
          <ScrollView style={styles.tabContent} contentContainerStyle={{ paddingBottom: 40 }}>
            <GlassCard style={styles.broadcastCard}>
              <View style={styles.cardHeader}>
                <Bell size={22} color={colors.primary.DEFAULT} />
                <Text style={[styles.sectionTitle, { color: colors.text.primary }]}>Targeted Notification Release</Text>
              </View>
              <Text style={[styles.sectionSubtitle, { color: colors.text.secondary }]}>
                Send targeted in-app & push messages to master users for testing and monitoring.
              </Text>

              {/* Target Selector */}
              <Text style={[styles.fieldLabel, { color: colors.text.primary }]}>Target Audience</Text>
              <View style={styles.targetOptionsRow}>
                <TouchableOpacity
                  style={[
                    styles.targetOption,
                    broadcastTarget === 'all_masters' && { borderColor: colors.primary.DEFAULT, backgroundColor: colors.primary.DEFAULT + '20' }
                  ]}
                  onPress={() => setBroadcastTarget('all_masters')}
                >
                  <Text style={[styles.targetOptionText, { color: colors.text.primary }]}>All Master Users</Text>
                </TouchableOpacity>

                <TouchableOpacity
                  style={[
                    styles.targetOption,
                    broadcastTarget === 'beta_masters' && { borderColor: colors.primary.DEFAULT, backgroundColor: colors.primary.DEFAULT + '20' }
                  ]}
                  onPress={() => setBroadcastTarget('beta_masters')}
                >
                  <Text style={[styles.targetOptionText, { color: colors.text.primary }]}>Beta Testers Only</Text>
                </TouchableOpacity>

                <TouchableOpacity
                  style={[
                    styles.targetOption,
                    broadcastTarget === 'specific_company' && { borderColor: colors.primary.DEFAULT, backgroundColor: colors.primary.DEFAULT + '20' }
                  ]}
                  onPress={() => setBroadcastTarget('specific_company')}
                >
                  <Text style={[styles.targetOptionText, { color: colors.text.primary }]}>Specific Company</Text>
                </TouchableOpacity>
              </View>

              {/* Company Picker Dropdown if Specific Company */}
              {broadcastTarget === 'specific_company' && (
                <View style={styles.companyPickerWrapper}>
                  <Text style={[styles.fieldLabel, { color: colors.text.primary }]}>Select Master Company</Text>
                  <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginVertical: 8 }}>
                    {companies.map(comp => (
                      <TouchableOpacity
                        key={comp.id}
                        style={[
                          styles.companyChip,
                          broadcastCompanyId === comp.id && { backgroundColor: colors.primary.DEFAULT }
                        ]}
                        onPress={() => setBroadcastCompanyId(comp.id)}
                      >
                        <Text style={[styles.chipText, { color: broadcastCompanyId === comp.id ? '#fff' : colors.text.primary }]}>
                          {comp.name}
                        </Text>
                      </TouchableOpacity>
                    ))}
                  </ScrollView>
                </View>
              )}

              {/* Title Input */}
              <Text style={[styles.fieldLabel, { color: colors.text.primary }]}>Notification Title</Text>
              <TextInput
                style={[styles.input, { borderColor: colors.border, color: colors.text.primary }]}
                placeholder="e.g. New Feature Preview: Driver Scoring"
                placeholderTextColor={colors.text.tertiary}
                value={broadcastTitle}
                onChangeText={setBroadcastTitle}
              />

              {/* Message Input */}
              <Text style={[styles.fieldLabel, { color: colors.text.primary }]}>Message Body</Text>
              <TextInput
                style={[styles.textArea, { borderColor: colors.border, color: colors.text.primary }]}
                placeholder="Write message content..."
                placeholderTextColor={colors.text.tertiary}
                multiline
                numberOfLines={4}
                value={broadcastMessage}
                onChangeText={setBroadcastMessage}
              />

              <GlassButton
                title={sendingBroadcast ? 'Sending Notification...' : 'Dispatch Broadcast'}
                onPress={handleSendBroadcast}
                variant="primary"
                loading={sendingBroadcast}
                style={{ marginTop: 20 }}
              />
            </GlassCard>
          </ScrollView>
        )}

        {/* TAB 3: USAGE ANALYTICS & EVENT LOGS */}
        {activeTab === 'analytics' && (
          <ScrollView style={styles.tabContent} contentContainerStyle={{ paddingBottom: 40 }}>
            {/* Quick Metrics Grid */}
            <View style={styles.metricsGrid}>
              <GlassCard style={styles.metricCard}>
                <Activity color={colors.primary.DEFAULT} size={24} />
                <Text style={[styles.metricValue, { color: colors.text.primary }]}>{metrics.totalEvents}</Text>
                <Text style={[styles.metricLabel, { color: colors.text.tertiary }]}>System Events</Text>
              </GlassCard>

              <GlassCard style={styles.metricCard}>
                <Building color="#10B981" size={24} />
                <Text style={[styles.metricValue, { color: colors.text.primary }]}>{metrics.totalCompanies}</Text>
                <Text style={[styles.metricLabel, { color: colors.text.tertiary }]}>Workspaces</Text>
              </GlassCard>

              <GlassCard style={styles.metricCard}>
                <Users color="#8B5CF6" size={24} />
                <Text style={[styles.metricValue, { color: colors.text.primary }]}>{metrics.totalUsers}</Text>
                <Text style={[styles.metricLabel, { color: colors.text.tertiary }]}>Total Users</Text>
              </GlassCard>

              <GlassCard style={styles.metricCard}>
                <Layers color="#F59E0B" size={24} />
                <Text style={[styles.metricValue, { color: colors.text.primary }]}>{metrics.totalQuizzes}</Text>
                <Text style={[styles.metricLabel, { color: colors.text.tertiary }]}>Quizzes Taken</Text>
              </GlassCard>
            </View>

            {/* Event Activity Stream */}
            <GlassCard style={styles.eventCard}>
              <View style={styles.cardHeader}>
                <Clock size={20} color={colors.primary.DEFAULT} />
                <Text style={[styles.sectionTitle, { color: colors.text.primary }]}>Live Activity Stream</Text>
              </View>

              {loadingAnalytics ? (
                <ActivityIndicator size="small" color={colors.primary.DEFAULT} style={{ marginVertical: 20 }} />
              ) : eventLogs.length === 0 ? (
                <Text style={[styles.emptyText, { color: colors.text.tertiary, marginVertical: 20 }]}>
                  No system events recorded yet.
                </Text>
              ) : (
                eventLogs.map((log, idx) => (
                  <View key={log.id || idx} style={[styles.eventRow, { borderColor: colors.border }]}>
                    <View style={styles.eventDot} />
                    <View style={{ flex: 1 }}>
                      <Text style={[styles.eventName, { color: colors.text.primary }]}>{log.event_name}</Text>
                      <Text style={[styles.eventTime, { color: colors.text.tertiary }]}>
                        {log.created_at ? new Date(log.created_at).toLocaleString() : 'Recently'}
                      </Text>
                    </View>
                  </View>
                ))
              )}
            </GlassCard>
          </ScrollView>
        )}

        {/* INCOGNITO TELEMETRY INSPECT MODAL */}
        <Modal
          visible={inspectModalVisible}
          animationType="slide"
          transparent={true}
          onRequestClose={() => setInspectModalVisible(false)}
        >
          <View style={styles.modalOverlay}>
            <GlassCard style={styles.inspectCardContainer}>
              <View style={styles.modalHeader}>
                <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
                  <Eye size={22} color={colors.primary.DEFAULT} />
                  <Text style={[styles.modalTitle, { color: colors.text.primary }]}>
                    Incognito View: {selectedCompany?.name}
                  </Text>
                </View>
                <TouchableOpacity onPress={() => setInspectModalVisible(false)}>
                  <Text style={{ color: colors.text.secondary, fontWeight: '700' }}>Close</Text>
                </TouchableOpacity>
              </View>

              {loadingInspect ? (
                <ActivityIndicator size="large" color={colors.primary.DEFAULT} style={{ marginVertical: 40 }} />
              ) : (
                <ScrollView style={{ maxHeight: 500 }}>
                  <Text style={[styles.inspectSectionHeader, { color: colors.text.primary }]}>
                    👥 Registered Drivers ({inspectTelemetry?.drivers.length || 0})
                  </Text>
                  {inspectTelemetry?.drivers.map(d => (
                    <View key={d.id} style={[styles.inspectItemRow, { borderColor: colors.border }]}>
                      <Text style={[styles.inspectItemTitle, { color: colors.text.primary }]}>
                        {d.full_name || d.name || 'Driver'}
                      </Text>
                      <Text style={[styles.inspectItemSub, { color: colors.text.tertiary }]}>
                        ID: {d.employee_id || 'N/A'} | Phone: {d.phone_number || d.phone || 'N/A'}
                      </Text>
                    </View>
                  ))}

                  <Text style={[styles.inspectSectionHeader, { color: colors.text.primary, marginTop: 16 }]}>
                    📝 Recent Quiz Activity ({inspectTelemetry?.recentQuizzes.length || 0})
                  </Text>
                  {inspectTelemetry?.recentQuizzes.map((q, i) => (
                    <View key={q.id || i} style={[styles.inspectItemRow, { borderColor: colors.border }]}>
                      <Text style={[styles.inspectItemTitle, { color: colors.status.success }]}>
                        Score: {q.score}%
                      </Text>
                      <Text style={[styles.inspectItemSub, { color: colors.text.tertiary }]}>
                        {q.created_at ? new Date(q.created_at).toLocaleString() : ''}
                      </Text>
                    </View>
                  ))}
                </ScrollView>
              )}
            </GlassCard>
          </View>
        </Modal>
      </SafeAreaView>
    </GradientBackground>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 14,
  },
  iconBtn: {
    width: 42,
    height: 42,
    borderRadius: 12,
    borderWidth: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
  },
  headerTitleGroup: {
    alignItems: 'center',
  },
  headerBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    marginBottom: 2,
  },
  headerBadgeText: {
    fontFamily: typography.fonts.bold,
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 1,
  },
  headerTitle: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  tabBar: {
    flexDirection: 'row',
    marginHorizontal: 20,
    marginVertical: 10,
    borderRadius: 14,
    borderWidth: 1,
    padding: 4,
  },
  tabItem: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 10,
    borderRadius: 10,
    gap: 6,
  },
  tabText: {
    fontFamily: typography.fonts.medium,
    fontSize: 13,
    fontWeight: '600',
  },
  tabContent: {
    flex: 1,
    paddingHorizontal: 20,
  },
  searchRow: {
    flexDirection: 'row',
    gap: 10,
    marginBottom: 16,
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1,
    borderRadius: 12,
    paddingHorizontal: 12,
    height: 44,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
  },
  searchInput: {
    flex: 1,
    fontSize: 14,
  },
  refreshBtn: {
    width: 44,
    height: 44,
    borderRadius: 12,
    borderWidth: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
  },
  emptyState: {
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 60,
    gap: 12,
  },
  emptyText: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.regular,
  },
  companyCard: {
    padding: 18,
    borderRadius: 16,
    marginBottom: 14,
  },
  companyCardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 12,
  },
  companyTitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
    marginBottom: 4,
  },
  companyName: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  codeBadge: {
    paddingHorizontal: 8,
    paddingVertical: 2,
    borderRadius: 6,
  },
  codeBadgeText: {
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
    fontSize: 11,
  },
  masterDetailText: {
    fontSize: typography.sizes.xs,
    fontFamily: typography.fonts.regular,
  },
  masterPhoneText: {
    fontSize: typography.sizes.xs,
    fontFamily: typography.fonts.regular,
    marginTop: 2,
  },
  inspectBtn: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 10,
  },
  inspectBtnText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '600',
  },
  statsRow: {
    flexDirection: 'row',
    borderTopWidth: 1,
    borderBottomWidth: 1,
    paddingVertical: 10,
    marginVertical: 10,
  },
  statCol: {
    flex: 1,
    alignItems: 'center',
  },
  statValue: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  statLabel: {
    fontSize: 11,
    fontFamily: typography.fonts.regular,
  },
  betaToggleRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 4,
  },
  betaLabelGroup: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  betaToggleLabel: {
    fontSize: 13,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  broadcastCard: {
    padding: 20,
    borderRadius: 18,
  },
  cardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    marginBottom: 6,
  },
  sectionTitle: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  sectionSubtitle: {
    fontSize: typography.sizes.xs,
    fontFamily: typography.fonts.regular,
    marginBottom: 20,
  },
  fieldLabel: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
    marginTop: 12,
    marginBottom: 6,
  },
  targetOptionsRow: {
    flexDirection: 'row',
    gap: 8,
    marginBottom: 10,
  },
  targetOption: {
    flex: 1,
    paddingVertical: 10,
    paddingHorizontal: 6,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: 'rgba(255, 255, 255, 0.1)',
    alignItems: 'center',
  },
  targetOptionText: {
    fontSize: 12,
    fontWeight: '600',
    textAlign: 'center',
  },
  companyPickerWrapper: {
    marginVertical: 6,
  },
  companyChip: {
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    marginRight: 8,
  },
  chipText: {
    fontSize: 12,
    fontWeight: '600',
  },
  input: {
    borderWidth: 1,
    borderRadius: 12,
    paddingHorizontal: 14,
    height: 48,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
    fontSize: 14,
  },
  textArea: {
    borderWidth: 1,
    borderRadius: 12,
    paddingHorizontal: 14,
    paddingVertical: 12,
    height: 100,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
    fontSize: 14,
    textAlignVertical: 'top',
  },
  metricsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 12,
    marginBottom: 16,
  },
  metricCard: {
    width: '48%',
    padding: 16,
    borderRadius: 16,
    alignItems: 'center',
    gap: 6,
  },
  metricValue: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    fontWeight: '800',
  },
  metricLabel: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
  },
  eventCard: {
    padding: 18,
    borderRadius: 18,
  },
  eventRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    gap: 12,
  },
  eventDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#3B82F6',
  },
  eventName: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  eventTime: {
    fontSize: 11,
    fontFamily: typography.fonts.regular,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.8)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  inspectCardContainer: {
    width: '100%',
    maxWidth: 500,
    padding: 22,
    borderRadius: 20,
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  modalTitle: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  inspectSectionHeader: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.medium,
    fontWeight: '700',
    marginBottom: 8,
  },
  inspectItemRow: {
    paddingVertical: 8,
    borderBottomWidth: 1,
  },
  inspectItemTitle: {
    fontSize: typography.sizes.xs,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  inspectItemSub: {
    fontSize: 11,
    fontFamily: typography.fonts.regular,
  },
  cancelBtnModal: {
    paddingHorizontal: 18,
    height: 48,
    borderRadius: 12,
    borderWidth: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
});
