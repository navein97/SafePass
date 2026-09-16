import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  FlatList,
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
  Layers,
  Settings,
  LogIn,
  Car,
  UserCheck,
  Crown,
  Smartphone,
  ChevronDown,
  Check
} from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { PasscodeGateModal } from '../components/PasscodeGateModal';
import { SuperAdminService, MasterCompany, LoginLog, LoginStats, CompanyLookup } from '../services/superAdminService';
import { AnalyticsService, AppEvent } from '../services/analyticsService';
import { PasscodeService } from '../services/passcodeService';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { GradientBackground } from '../components/ui/GradientBackground';

export const SuperAdminScreen = ({ navigation }: any) => {
  const { colors } = useTheme();

  // Access Control State
  const [unlocked, setUnlocked] = useState(false);
  const [activeTab, setActiveTab] = useState<'masters' | 'broadcast' | 'analytics' | 'settings' | 'login_activity'>('masters');

  const PAGE_SIZE = 25;

  // Master Users State
  const [loadingCompanies, setLoadingCompanies] = useState(false);
  const [loadingMoreCompanies, setLoadingMoreCompanies] = useState(false);
  const [companies, setCompanies] = useState<MasterCompany[]>([]);
  const [companiesPage, setCompaniesPage] = useState(0);
  const [hasMoreCompanies, setHasMoreCompanies] = useState(true);
  const [totalCompaniesCount, setTotalCompaniesCount] = useState(0);
  const [companyLookups, setCompanyLookups] = useState<CompanyLookup[]>([]);
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
  const [recipientScope, setRecipientScope] = useState<'masters_only' | 'all_users'>('masters_only');
  const [broadcastTitle, setBroadcastTitle] = useState('');
  const [broadcastMessage, setBroadcastMessage] = useState('');
  const [sendingBroadcast, setSendingBroadcast] = useState(false);

  // Analytics & Event Logs State
  const [loadingAnalytics, setLoadingAnalytics] = useState(false);
  const [loadingMoreEvents, setLoadingMoreEvents] = useState(false);
  const [metrics, setMetrics] = useState({ totalEvents: 0, totalCompanies: 0, totalUsers: 0, totalQuizzes: 0 });
  const [eventLogs, setEventLogs] = useState<AppEvent[]>([]);
  const [eventsOffset, setEventsOffset] = useState(0);
  const [hasMoreEvents, setHasMoreEvents] = useState(true);

  // Login Activity State
  const [loadingLoginActivity, setLoadingLoginActivity] = useState(false);
  const [loadingMoreLogins, setLoadingMoreLogins] = useState(false);
  const [loginLogs, setLoginLogs] = useState<LoginLog[]>([]);
  const [loginsOffset, setLoginsOffset] = useState(0);
  const [hasMoreLogins, setHasMoreLogins] = useState(true);
  const [loginStats, setLoginStats] = useState<LoginStats>({
    total_today: 0,
    unique_users_today: 0,
    driver_logins_today: 0,
    manager_logins_today: 0,
    master_logins_today: 0,
    total_all_time: 0,
  });
  const [loginRoleFilter, setLoginRoleFilter] = useState<'all' | 'driver' | 'manager' | 'master'>('all');
  const [loginCompanyFilter, setLoginCompanyFilter] = useState<string | undefined>(undefined);

  // Global Settings State
  const [globalLimitInput, setGlobalLimitInput] = useState('5');
  const [limitDropdownOpen, setLimitDropdownOpen] = useState(false);
  const [loadingLimit, setLoadingLimit] = useState(false);
  const [savingLimit, setSavingLimit] = useState(false);
  const [limitSaveStatus, setLimitSaveStatus] = useState<'idle' | 'success' | 'error'>('idle');

  useEffect(() => {
    if (unlocked) {
      loadInitialData();
      loadGlobalLimit();
      AnalyticsService.trackEvent('super_admin_unlocked', { timestamp: new Date().toISOString() });
    }
  }, [unlocked]);

  useEffect(() => {
    if (unlocked && activeTab === 'login_activity') {
      loadLoginActivity(0, true);
    }
  }, [unlocked, activeTab, loginRoleFilter, loginCompanyFilter]);

  // Debounced search for Master Users
  useEffect(() => {
    if (!unlocked) return;
    const timer = setTimeout(() => {
      loadCompanies(0, true, searchQuery);
    }, 350);
    return () => clearTimeout(timer);
  }, [searchQuery]);

  const loadInitialData = async () => {
    loadCompanies(0, true, searchQuery);
    loadCompanyLookups();
    loadAnalytics(0, true);
  };

  const loadCompanyLookups = async () => {
    const lookups = await SuperAdminService.getCompanyLookupList();
    setCompanyLookups(lookups);
  };

  const loadCompanies = async (pageToLoad: number = 0, isRefreshing: boolean = false, query: string = searchQuery) => {
    if (isRefreshing || pageToLoad === 0) {
      setLoadingCompanies(true);
    } else {
      setLoadingMoreCompanies(true);
    }

    const result = await SuperAdminService.getAllMasterCompanies(pageToLoad, PAGE_SIZE, query);

    if (pageToLoad === 0) {
      setCompanies(result.companies);
    } else {
      setCompanies(prev => [...prev, ...result.companies]);
    }

    setCompaniesPage(pageToLoad);
    setHasMoreCompanies(result.hasMore);
    setTotalCompaniesCount(result.totalCount);

    setLoadingCompanies(false);
    setLoadingMoreCompanies(false);
  };

  const handleLoadMoreCompanies = () => {
    if (loadingCompanies || loadingMoreCompanies || !hasMoreCompanies) return;
    loadCompanies(companiesPage + 1, false, searchQuery);
  };

  const loadAnalytics = async (offsetToLoad: number = 0, isRefreshing: boolean = false) => {
    if (isRefreshing || offsetToLoad === 0) {
      setLoadingAnalytics(true);
      const fetchedMetrics = await AnalyticsService.getUsageMetrics();
      setMetrics(fetchedMetrics);
    } else {
      setLoadingMoreEvents(true);
    }

    const fetchedLogs = await AnalyticsService.getRecentEvents(offsetToLoad, PAGE_SIZE);

    if (offsetToLoad === 0) {
      setEventLogs(fetchedLogs);
    } else {
      setEventLogs(prev => [...prev, ...fetchedLogs]);
    }

    setEventsOffset(offsetToLoad);
    setHasMoreEvents(fetchedLogs.length === PAGE_SIZE);

    setLoadingAnalytics(false);
    setLoadingMoreEvents(false);
  };

  const handleLoadMoreEvents = () => {
    if (loadingAnalytics || loadingMoreEvents || !hasMoreEvents) return;
    loadAnalytics(eventLogs.length, false);
  };

  const loadLoginActivity = async (offsetToLoad: number = 0, isRefreshing: boolean = false) => {
    if (isRefreshing || offsetToLoad === 0) {
      setLoadingLoginActivity(true);
      const stats = await SuperAdminService.getLoginStats();
      setLoginStats(stats);
    } else {
      setLoadingMoreLogins(true);
    }

    const roleParam = loginRoleFilter === 'all' ? undefined
      : loginRoleFilter === 'master' ? 'manager'
        : loginRoleFilter;

    const logs = await SuperAdminService.getLoginLogs(PAGE_SIZE, roleParam, loginCompanyFilter, offsetToLoad);
    const filteredLogs = loginRoleFilter === 'master'
      ? logs.filter(l => l.manager_level === 1)
      : logs;

    if (offsetToLoad === 0) {
      setLoginLogs(filteredLogs);
    } else {
      setLoginLogs(prev => [...prev, ...filteredLogs]);
    }

    setLoginsOffset(offsetToLoad);
    setHasMoreLogins(logs.length === PAGE_SIZE);

    setLoadingLoginActivity(false);
    setLoadingMoreLogins(false);
  };

  const handleLoadMoreLogins = () => {
    if (loadingLoginActivity || loadingMoreLogins || !hasMoreLogins) return;
    loadLoginActivity(loginLogs.length, false);
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

  // Global Settings Handlers
  const loadGlobalLimit = async () => {
    setLoadingLimit(true);
    const current = await SuperAdminService.getGlobalDailyLimit();
    setGlobalLimitInput(String(Math.min(30, Math.max(1, current))));
    setLoadingLimit(false);
  };

  const handleSaveGlobalLimit = async () => {
    const raw = parseInt(globalLimitInput, 10);
    const parsed = Math.min(30, Math.max(1, isNaN(raw) ? 5 : raw));
    setGlobalLimitInput(String(parsed));
    setSavingLimit(true);
    setLimitSaveStatus('idle');
    const ok = await SuperAdminService.setGlobalDailyLimit(parsed);
    setSavingLimit(false);
    setLimitSaveStatus(ok ? 'success' : 'error');
    setTimeout(() => setLimitSaveStatus('idle'), 3000);
    if (ok) {
      AnalyticsService.trackEvent('global_daily_limit_changed', { new_limit: parsed });
    }
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
      recipientScope: broadcastTarget === 'specific_company' ? recipientScope : 'masters_only',
    });

    setSendingBroadcast(false);

    if (result.success) {
      const availableComps = companyLookups.length > 0 ? companyLookups : companies;
      const selectedComp = availableComps.find(c => c.id === broadcastCompanyId);
      const targetLabel = broadcastTarget === 'all_masters'
        ? 'All Master Users'
        : `${selectedComp?.name || result.companyName || 'Specific Company'} (${recipientScope === 'masters_only' ? 'Master Users' : 'All Company Members'})`;

      Alert.alert(
        'Broadcast Dispatched',
        `Successfully dispatched notification to ${result.count} recipient(s) for ${targetLabel}.`
      );
      setBroadcastTitle('');
      setBroadcastMessage('');
      AnalyticsService.trackEvent('targeted_broadcast_sent', {
        target: broadcastTarget,
        count: result.count,
        recipient_scope: recipientScope,
      });
    } else {
      Alert.alert('Broadcast Failed', result.error || 'Unable to send broadcast.');
    }
  };

  const availableCompanies = companyLookups.length > 0 ? companyLookups : companies;

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

          <TouchableOpacity
            style={[styles.tabItem, activeTab === 'settings' && { backgroundColor: colors.primary.DEFAULT }]}
            onPress={() => setActiveTab('settings')}
          >
            <Settings size={16} color={activeTab === 'settings' ? '#fff' : colors.text.secondary} />
            <Text style={[styles.tabText, { color: activeTab === 'settings' ? '#fff' : colors.text.secondary }]}>
              Settings
            </Text>
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.tabItem, activeTab === 'login_activity' && { backgroundColor: colors.primary.DEFAULT }]}
            onPress={() => setActiveTab('login_activity')}
          >
            <LogIn size={16} color={activeTab === 'login_activity' ? '#fff' : colors.text.secondary} />
            <Text style={[styles.tabText, { color: activeTab === 'login_activity' ? '#fff' : colors.text.secondary }]}>
              Logins
            </Text>
          </TouchableOpacity>
        </View>

        {/* TAB 1: MASTER USERS & INCOGNITO MONITORING */}
        {activeTab === 'masters' && (
          <FlatList
            style={styles.tabContent}
            contentContainerStyle={{ paddingBottom: 50 }}
            data={companies}
            keyExtractor={comp => comp.id}
            ListHeaderComponent={
              <View style={styles.searchRow}>
                <View style={[styles.searchInputContainer, { borderColor: colors.border }]}>
                  <Search size={18} color={colors.text.tertiary} style={{ marginRight: 8 }} />
                  <TextInput
                    style={[styles.searchInput, { color: colors.text.primary }]}
                    placeholder="Search master user, email, or company code..."
                    placeholderTextColor={colors.text.tertiary}
                    value={searchQuery}
                    onChangeText={setSearchQuery}
                    returnKeyType="search"
                  />
                  {Boolean(searchQuery) && (
                    <TouchableOpacity onPress={() => setSearchQuery('')} style={{ padding: 4 }}>
                      <Text style={{ color: colors.text.tertiary, fontSize: 13, fontWeight: '700' }}>✕</Text>
                    </TouchableOpacity>
                  )}
                </View>

                <TouchableOpacity
                  style={[styles.refreshBtn, { borderColor: colors.border }]}
                  onPress={() => loadCompanies(0, true, searchQuery)}
                >
                  <RefreshCw size={18} color={colors.text.primary} />
                </TouchableOpacity>
              </View>
            }
            renderItem={({ item: comp }) => (
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
                      Pause this company
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
            )}
            ListEmptyComponent={
              loadingCompanies ? (
                <ActivityIndicator size="large" color={colors.primary.DEFAULT} style={{ marginTop: 40 }} />
              ) : (
                <View style={styles.emptyState}>
                  <Building size={48} color={colors.text.tertiary} />
                  <Text style={[styles.emptyText, { color: colors.text.secondary }]}>No master users found.</Text>
                </View>
              )
            }
            ListFooterComponent={
              loadingMoreCompanies ? (
                <View style={{ paddingVertical: 20, alignItems: 'center', justifyContent: 'center', flexDirection: 'row', gap: 8 }}>
                  <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
                  <Text style={{ color: colors.text.secondary, fontSize: 13, fontFamily: typography.fonts.medium }}>
                    Loading next 25 master users...
                  </Text>
                </View>
              ) : !hasMoreCompanies && companies.length > 0 ? (
                <View style={{ paddingVertical: 18, alignItems: 'center' }}>
                  <Text style={{ color: colors.text.tertiary, fontSize: 12, fontFamily: typography.fonts.regular }}>
                    ✓ All {totalCompaniesCount || companies.length} master users loaded
                  </Text>
                </View>
              ) : null
            }
            onEndReached={handleLoadMoreCompanies}
            onEndReachedThreshold={0.4}
          />
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
                Send targeted in-app & push messages to Master Users or specific companies for testing and monitoring.
              </Text>

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
                    broadcastTarget === 'specific_company' && { borderColor: colors.primary.DEFAULT, backgroundColor: colors.primary.DEFAULT + '20' }
                  ]}
                  onPress={() => {
                    setBroadcastTarget('specific_company');
                    if (!broadcastCompanyId && availableCompanies.length > 0) {
                      setBroadcastCompanyId(availableCompanies[0].id);
                    }
                  }}
                >
                  <Text style={[styles.targetOptionText, { color: colors.text.primary }]}>Specific Company</Text>
                </TouchableOpacity>
              </View>

              {broadcastTarget === 'specific_company' && (
                <View style={styles.companyPickerWrapper}>
                  <Text style={[styles.fieldLabel, { color: colors.text.primary }]}>Select Target Company</Text>
                  {availableCompanies.length === 0 ? (
                    <Text style={{ color: colors.text.tertiary, fontSize: 12, marginVertical: 6 }}>
                      No registered companies found. Please refresh list.
                    </Text>
                  ) : (
                    <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginVertical: 8 }}>
                      {availableCompanies.map(comp => (
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
                  )}

                  <Text style={[styles.fieldLabel, { color: colors.text.primary, marginTop: 8 }]}>Recipient Scope</Text>
                  <View style={styles.targetOptionsRow}>
                    <TouchableOpacity
                      style={[
                        styles.targetOption,
                        recipientScope === 'masters_only' && { borderColor: colors.primary.DEFAULT, backgroundColor: colors.primary.DEFAULT + '20' }
                      ]}
                      onPress={() => setRecipientScope('masters_only')}
                    >
                      <Text style={[styles.targetOptionText, { color: colors.text.primary }]}>Master Users Only</Text>
                    </TouchableOpacity>

                    <TouchableOpacity
                      style={[
                        styles.targetOption,
                        recipientScope === 'all_users' && { borderColor: colors.primary.DEFAULT, backgroundColor: colors.primary.DEFAULT + '20' }
                      ]}
                      onPress={() => setRecipientScope('all_users')}
                    >
                      <Text style={[styles.targetOptionText, { color: colors.text.primary }]}>All Company Members</Text>
                    </TouchableOpacity>
                  </View>
                </View>
              )}

              <View style={{
                backgroundColor: 'rgba(255, 255, 255, 0.05)',
                borderWidth: 1,
                borderColor: colors.border,
                borderRadius: 12,
                padding: 12,
                marginVertical: 12,
                flexDirection: 'row',
                alignItems: 'center',
                gap: 8,
              }}>
                <Send size={16} color={colors.primary.DEFAULT} />
                <Text style={{ color: colors.text.secondary, fontSize: 12, flex: 1 }}>
                  {broadcastTarget === 'all_masters' ? (
                    'Broadcasting to all Master Users across all registered workspaces.'
                  ) : (
                    `Broadcasting to ${availableCompanies.find(c => c.id === broadcastCompanyId)?.name || 'Selected Company'
                    } (${recipientScope === 'masters_only' ? 'Master Users Only' : 'All Company Members'}).`
                  )}
                </Text>
              </View>

              <Text style={[styles.fieldLabel, { color: colors.text.primary }]}>Notification Title</Text>
              <TextInput
                style={[styles.input, { borderColor: colors.border, color: colors.text.primary }]}
                placeholder="e.g. System Announcement: Update Available"
                placeholderTextColor={colors.text.tertiary}
                value={broadcastTitle}
                onChangeText={setBroadcastTitle}
              />

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
                title={sendingBroadcast ? 'Dispatching Message...' : 'Dispatch Broadcast'}
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
          <FlatList
            style={styles.tabContent}
            contentContainerStyle={{ paddingBottom: 50 }}
            data={eventLogs}
            keyExtractor={(log, idx) => log.id || `${log.event_name}-${log.created_at}-${idx}`}
            ListHeaderComponent={
              <View>
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

                {/* Event Activity Stream Section Title & Refresh */}
                <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12, marginTop: 4 }}>
                  <View style={{ flexDirection: 'row', alignItems: 'center', gap: 8 }}>
                    <Clock size={20} color={colors.primary.DEFAULT} />
                    <Text style={[styles.sectionTitle, { color: colors.text.primary }]}>Live Activity Stream</Text>
                  </View>
                  <TouchableOpacity
                    style={[styles.refreshBtn, { borderColor: colors.border, width: 38, height: 38 }]}
                    onPress={() => loadAnalytics(0, true)}
                  >
                    <RefreshCw size={16} color={colors.text.primary} />
                  </TouchableOpacity>
                </View>
              </View>
            }
            renderItem={({ item: log, index }) => (
              <View
                key={log.id || index}
                style={{
                  flexDirection: 'row',
                  alignItems: 'center',
                  padding: 14,
                  borderRadius: 12,
                  marginBottom: 8,
                  gap: 12,
                  backgroundColor: colors.background.card,
                  borderWidth: 1,
                  borderColor: colors.border,
                }}
              >
                <View style={styles.eventDot} />
                <View style={{ flex: 1 }}>
                  <Text style={[styles.eventName, { color: colors.text.primary }]}>{log.event_name}</Text>
                  <Text style={[styles.eventTime, { color: colors.text.tertiary }]}>
                    {log.created_at ? new Date(log.created_at).toLocaleString() : 'Recently'}
                  </Text>
                </View>
              </View>
            )}
            ListEmptyComponent={
              loadingAnalytics ? (
                <ActivityIndicator size="small" color={colors.primary.DEFAULT} style={{ marginVertical: 30 }} />
              ) : (
                <Text style={[styles.emptyText, { color: colors.text.tertiary, marginVertical: 30, textAlign: 'center' }]}>
                  No system events recorded yet.
                </Text>
              )
            }
            ListFooterComponent={
              loadingMoreEvents ? (
                <View style={{ paddingVertical: 18, alignItems: 'center', justifyContent: 'center', flexDirection: 'row', gap: 8 }}>
                  <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
                  <Text style={{ color: colors.text.secondary, fontSize: 13, fontFamily: typography.fonts.medium }}>
                    Loading next 25 events...
                  </Text>
                </View>
              ) : !hasMoreEvents && eventLogs.length > 0 ? (
                <View style={{ paddingVertical: 18, alignItems: 'center' }}>
                  <Text style={{ color: colors.text.tertiary, fontSize: 12, fontFamily: typography.fonts.regular }}>
                    ✓ All system events loaded ({eventLogs.length} total)
                  </Text>
                </View>
              ) : null
            }
            onEndReached={handleLoadMoreEvents}
            onEndReachedThreshold={0.4}
          />
        )}

        {/* TAB 4: GLOBAL SETTINGS */}
        {activeTab === 'settings' && (
          <ScrollView style={styles.tabContent} contentContainerStyle={{ paddingBottom: 40 }}>
            <GlassCard style={styles.broadcastCard}>
              <View style={styles.cardHeader}>
                <Settings size={22} color={colors.primary.DEFAULT} />
                <Text style={[styles.sectionTitle, { color: colors.text.primary }]}>Global Settings</Text>
              </View>

              {/* Daily Quiz Limit */}
              <Text style={[styles.fieldLabel, { color: colors.text.primary, marginTop: 10 }]}>Daily Quiz Limit</Text>
              <Text style={[styles.sectionSubtitle, { color: colors.text.secondary, marginBottom: 16 }]}>
                Live Quiz questions per driver each day.
              </Text>

              {loadingLimit ? (
                <ActivityIndicator size="small" color={colors.primary.DEFAULT} style={{ marginVertical: 16 }} />
              ) : (
                <TouchableOpacity
                  style={[
                    styles.dropdownTrigger,
                    { borderColor: colors.border, backgroundColor: 'rgba(255, 255, 255, 0.06)' }
                  ]}
                  onPress={() => setLimitDropdownOpen(true)}
                  activeOpacity={0.7}
                >
                  <Text style={[styles.dropdownTriggerText, { color: colors.text.primary }]}>
                    {globalLimitInput} {parseInt(globalLimitInput, 10) === 1 ? 'question' : 'questions'} / day
                  </Text>
                  <ChevronDown size={20} color={colors.text.secondary} />
                </TouchableOpacity>
              )}

              {/* Status feedback */}
              {limitSaveStatus === 'success' && (
                <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, marginTop: 12 }}>
                  <CheckCircle size={16} color={colors.status.success} />
                  <Text style={{ color: colors.status.success, fontFamily: typography.fonts.medium, fontSize: 13 }}>
                    Limit updated successfully.
                  </Text>
                </View>
              )}
              {limitSaveStatus === 'error' && (
                <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, marginTop: 12 }}>
                  <AlertCircle size={16} color={colors.status.danger} />
                  <Text style={{ color: colors.status.danger, fontFamily: typography.fonts.medium, fontSize: 13 }}>
                    Failed to update limit.
                  </Text>
                </View>
              )}

              <GlassButton
                title={savingLimit ? 'Saving...' : 'Save Daily Limit'}
                onPress={handleSaveGlobalLimit}
                variant="primary"
                loading={savingLimit}
                style={{ marginTop: 16 }}
              />
            </GlassCard>
          </ScrollView>
        )}

        {/* TAB 5: LOGIN ACTIVITY */}
        {activeTab === 'login_activity' && (
          <FlatList
            style={styles.tabContent}
            contentContainerStyle={{ paddingBottom: 50 }}
            data={loginLogs}
            keyExtractor={item => item.id}
            ListHeaderComponent={
              <View>
                {/* Stats Summary Grid */}
                <View style={styles.loginStatsGrid}>
                  <GlassCard style={styles.loginStatCard}>
                    <LogIn size={20} color={colors.primary.DEFAULT} />
                    <Text style={[styles.loginStatValue, { color: colors.text.primary }]}>{loginStats.total_today}</Text>
                    <Text style={[styles.loginStatLabel, { color: colors.text.tertiary }]}>Today</Text>
                  </GlassCard>
                  <GlassCard style={styles.loginStatCard}>
                    <Users size={20} color="#8B5CF6" />
                    <Text style={[styles.loginStatValue, { color: colors.text.primary }]}>{loginStats.unique_users_today}</Text>
                    <Text style={[styles.loginStatLabel, { color: colors.text.tertiary }]}>Unique Users</Text>
                  </GlassCard>
                  <GlassCard style={styles.loginStatCard}>
                    <Car size={20} color="#3B82F6" />
                    <Text style={[styles.loginStatValue, { color: colors.text.primary }]}>{loginStats.driver_logins_today}</Text>
                    <Text style={[styles.loginStatLabel, { color: colors.text.tertiary }]}>Drivers</Text>
                  </GlassCard>
                  <GlassCard style={styles.loginStatCard}>
                    <Crown size={20} color="#F59E0B" />
                    <Text style={[styles.loginStatValue, { color: colors.text.primary }]}>{loginStats.master_logins_today}</Text>
                    <Text style={[styles.loginStatLabel, { color: colors.text.tertiary }]}>Masters</Text>
                  </GlassCard>
                </View>

                {/* All-time count */}
                <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 12, gap: 6 }}>
                  <Activity size={14} color={colors.text.tertiary} />
                  <Text style={{ color: colors.text.tertiary, fontSize: 12, fontFamily: typography.fonts.regular }}>
                    {loginStats.total_all_time.toLocaleString()} total logins recorded all time
                  </Text>
                </View>

                {/* Role Filter Bar */}
                <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 12 }}>
                  <View style={{ flexDirection: 'row', gap: 8 }}>
                    {(['all', 'driver', 'manager', 'master'] as const).map(f => (
                      <TouchableOpacity
                        key={f}
                        style={[
                          styles.loginFilterChip,
                          loginRoleFilter === f && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT }
                        ]}
                        onPress={() => setLoginRoleFilter(f)}
                      >
                        <Text style={[
                          styles.loginFilterChipText,
                          { color: loginRoleFilter === f ? '#fff' : colors.text.secondary }
                        ]}>
                          {f === 'all' ? '🌐 All' : f === 'driver' ? '🚗 Drivers' : f === 'manager' ? '👔 Managers' : '👑 Masters'}
                        </Text>
                      </TouchableOpacity>
                    ))}
                  </View>
                </ScrollView>

                {/* Company Filter (chips from availableCompanies) */}
                {availableCompanies.length > 0 && (
                  <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
                    <View style={{ flexDirection: 'row', gap: 8 }}>
                      <TouchableOpacity
                        style={[
                          styles.loginFilterChip,
                          !loginCompanyFilter && { backgroundColor: colors.primary.DEFAULT + '30', borderColor: colors.primary.DEFAULT }
                        ]}
                        onPress={() => setLoginCompanyFilter(undefined)}
                      >
                        <Text style={[styles.loginFilterChipText, { color: colors.text.secondary }]}>All Companies</Text>
                      </TouchableOpacity>
                      {availableCompanies.map(c => (
                        <TouchableOpacity
                          key={c.id}
                          style={[
                            styles.loginFilterChip,
                            loginCompanyFilter === c.id && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT }
                          ]}
                          onPress={() => setLoginCompanyFilter(loginCompanyFilter === c.id ? undefined : c.id)}
                        >
                          <Text style={[
                            styles.loginFilterChipText,
                            { color: loginCompanyFilter === c.id ? '#fff' : colors.text.secondary }
                          ]}>{c.name}</Text>
                        </TouchableOpacity>
                      ))}
                    </View>
                  </ScrollView>
                )}

                {/* Header info & Refresh button */}
                <View style={{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
                  <Text style={{ color: colors.text.tertiary, fontSize: 12, fontFamily: typography.fonts.medium }}>
                    Showing {loginLogs.length} records
                  </Text>
                  <TouchableOpacity
                    style={[styles.refreshBtn, { borderColor: colors.border, width: 38, height: 38 }]}
                    onPress={() => loadLoginActivity(0, true)}
                  >
                    <RefreshCw size={16} color={colors.text.primary} />
                  </TouchableOpacity>
                </View>
              </View>
            }
            renderItem={({ item: log }) => {
              const isMaster = log.role === 'manager' && log.manager_level === 1;
              const isManager = log.role === 'manager' && log.manager_level !== 1;
              const roleLabel = isMaster ? 'Master User' : isManager ? 'Manager' : 'Driver';
              const roleColor = isMaster ? '#F59E0B' : isManager ? '#8B5CF6' : '#3B82F6';
              const roleIcon = isMaster ? <Crown size={14} color={roleColor} /> : isManager ? <UserCheck size={14} color={roleColor} /> : <Car size={14} color={roleColor} />;
              const loginDate = new Date(log.logged_in_at);
              const now = new Date();
              const diffMs = now.getTime() - loginDate.getTime();
              const diffMins = Math.floor(diffMs / 60000);
              const timeLabel = diffMins < 1 ? 'Just now'
                : diffMins < 60 ? `${diffMins}m ago`
                  : diffMins < 1440 ? `${Math.floor(diffMins / 60)}h ago`
                    : loginDate.toLocaleDateString() + ' ' + loginDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

              return (
                <View
                  key={log.id}
                  style={{
                    flexDirection: 'row',
                    alignItems: 'center',
                    padding: 14,
                    borderRadius: 14,
                    marginBottom: 10,
                    gap: 12,
                    backgroundColor: colors.background.card,
                    borderWidth: 1,
                    borderColor: colors.border,
                  }}
                >
                  {/* Role icon badge */}
                  <View style={[styles.loginRoleIcon, { backgroundColor: roleColor + '20' }]}>
                    {roleIcon}
                  </View>

                  {/* Main info — flex:1 so it takes remaining space */}
                  <View style={{ flex: 1, minWidth: 0 }}>
                    <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, flexWrap: 'wrap' }}>
                      <Text style={[styles.loginLogName, { color: colors.text.primary }]} numberOfLines={1}>
                        {log.full_name || log.employee_id || 'Unknown User'}
                      </Text>
                      <View style={[styles.loginRoleBadge, { backgroundColor: roleColor + '25' }]}>
                        <Text style={[styles.loginRoleBadgeText, { color: roleColor }]}>{roleLabel}</Text>
                      </View>
                    </View>
                    <Text style={[styles.loginLogSub, { color: colors.text.tertiary }]} numberOfLines={1}>
                      {log.employee_id && `ID: ${log.employee_id}  ·  `}{log.company_name || '—'}
                    </Text>
                  </View>

                  {/* Time & type — pinned to the right */}
                  <View style={{ alignItems: 'flex-end', gap: 4, flexShrink: 0 }}>
                    <Text style={[styles.loginLogTime, { color: colors.text.secondary }]}>{timeLabel}</Text>
                    <View style={[styles.loginTypeBadge, { backgroundColor: colors.primary.DEFAULT + '20' }]}>
                      <LogIn size={10} color={colors.primary.DEFAULT} />
                      <Text style={[styles.loginTypeBadgeText, { color: colors.primary.DEFAULT }]}>
                        Login
                      </Text>
                    </View>
                  </View>
                </View>
              );
            }}
            ListEmptyComponent={
              loadingLoginActivity ? (
                <ActivityIndicator size="large" color={colors.primary.DEFAULT} style={{ marginTop: 40 }} />
              ) : (
                <View style={styles.emptyState}>
                  <LogIn size={48} color={colors.text.tertiary} />
                  <Text style={[styles.emptyText, { color: colors.text.secondary }]}>
                    No login records yet.
                  </Text>
                  <Text style={[styles.emptyText, { color: colors.text.tertiary, fontSize: 12 }]}>
                    Run the SQL migration first, then users need to log in.
                  </Text>
                </View>
              )
            }
            ListFooterComponent={
              loadingMoreLogins ? (
                <View style={{ paddingVertical: 18, alignItems: 'center', justifyContent: 'center', flexDirection: 'row', gap: 8 }}>
                  <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
                  <Text style={{ color: colors.text.secondary, fontSize: 13, fontFamily: typography.fonts.medium }}>
                    Loading next 25 logins...
                  </Text>
                </View>
              ) : !hasMoreLogins && loginLogs.length > 0 ? (
                <View style={{ paddingVertical: 18, alignItems: 'center' }}>
                  <Text style={{ color: colors.text.tertiary, fontSize: 12, fontFamily: typography.fonts.regular }}>
                    ✓ All login records loaded ({loginLogs.length} total)
                  </Text>
                </View>
              ) : null
            }
            onEndReached={handleLoadMoreLogins}
            onEndReachedThreshold={0.4}
          />
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

        {/* DAILY QUIZ LIMIT DROPDOWN MODAL */}
        <Modal
          visible={limitDropdownOpen}
          animationType="fade"
          transparent={true}
          onRequestClose={() => setLimitDropdownOpen(false)}
        >
          <TouchableOpacity
            style={styles.modalOverlay}
            activeOpacity={1}
            onPress={() => setLimitDropdownOpen(false)}
          >
            <TouchableOpacity
              activeOpacity={1}
              style={[styles.dropdownModalCard, { backgroundColor: colors.background.card, borderColor: colors.border }]}
              onPress={(e) => e.stopPropagation()}
            >
              <View style={styles.modalHeader}>
                <Text style={[styles.modalTitle, { color: colors.text.primary }]}>
                  Daily Quiz Limit
                </Text>
                <TouchableOpacity onPress={() => setLimitDropdownOpen(false)}>
                  <Text style={{ color: colors.text.secondary, fontWeight: '700' }}>Close</Text>
                </TouchableOpacity>
              </View>

              <ScrollView style={{ maxHeight: 360 }} showsVerticalScrollIndicator={true}>
                {Array.from({ length: 30 }, (_, i) => i + 1).map((num) => {
                  const isSelected = parseInt(globalLimitInput, 10) === num;
                  return (
                    <TouchableOpacity
                      key={num}
                      style={[
                        styles.dropdownOptionRow,
                        isSelected && { backgroundColor: colors.primary.DEFAULT + '1A' }
                      ]}
                      onPress={() => {
                        setGlobalLimitInput(String(num));
                        setLimitSaveStatus('idle');
                        setLimitDropdownOpen(false);
                      }}
                    >
                      <Text
                        style={[
                          styles.dropdownOptionText,
                          { color: isSelected ? colors.primary.DEFAULT : colors.text.primary },
                          isSelected && { fontWeight: '700', fontFamily: typography.fonts.bold }
                        ]}
                      >
                        {num} {num === 1 ? 'question' : 'questions'}{num === 5 ? ' (Default)' : ''}
                      </Text>
                      {isSelected && <Check size={18} color={colors.primary.DEFAULT} />}
                    </TouchableOpacity>
                  );
                })}
              </ScrollView>
            </TouchableOpacity>
          </TouchableOpacity>
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

  // Login Activity Tab
  loginStatsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
    marginBottom: 14,
  },
  loginStatCard: {
    width: '47%',
    padding: 14,
    borderRadius: 14,
    alignItems: 'center',
    gap: 4,
  },
  loginStatValue: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    fontWeight: '800',
  },
  loginStatLabel: {
    fontSize: 11,
    fontFamily: typography.fonts.regular,
  },
  loginFilterChip: {
    paddingHorizontal: 14,
    paddingVertical: 7,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.12)',
    backgroundColor: 'rgba(255,255,255,0.06)',
  },
  loginFilterChipText: {
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  loginLogRow: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 14,
    borderRadius: 14,
    marginBottom: 10,
    gap: 12,
  },
  loginRoleIcon: {
    width: 36,
    height: 36,
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
  },
  loginLogName: {
    fontSize: 13,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
    flexShrink: 1,
  },
  loginLogSub: {
    fontSize: 11,
    fontFamily: typography.fonts.regular,
    marginTop: 2,
  },
  loginLogTime: {
    fontSize: 11,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  loginRoleBadge: {
    paddingHorizontal: 7,
    paddingVertical: 2,
    borderRadius: 6,
  },
  loginRoleBadgeText: {
    fontSize: 10,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  loginTypeBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 3,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 6,
  },
  loginTypeBadgeText: {
    fontSize: 10,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  dropdownTrigger: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    height: 50,
    borderRadius: 12,
    borderWidth: 1,
  },
  dropdownTriggerText: {
    fontSize: 15,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
  dropdownModalCard: {
    width: '100%',
    maxWidth: 380,
    padding: 20,
    borderRadius: 20,
    borderWidth: 1,
  },
  dropdownOptionRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 10,
    marginBottom: 4,
  },
  dropdownOptionText: {
    fontSize: 15,
    fontFamily: typography.fonts.regular,
  },
});
