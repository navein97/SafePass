import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, FlatList, TextInput, Alert, ActivityIndicator, RefreshControl } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { ChevronLeft, UserPlus, Search, Trash2, Key, MoreVertical, X } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { CreateUserModal } from '../components/CreateUserModal';
import { NotificationSenderModal } from '../components/NotificationSenderModal';
import { ChangePasswordModal } from '../components/ChangePasswordModal';
import { ConfirmationModal } from '../components/ConfirmationModal';
import { DeleteUserModal } from '../components/DeleteUserModal';
import { AuthService } from '../services/authService';
import { CompanySettingsService, CompanyStats } from '../services/companySettingsService';

interface UserProfile {
    id: string;
    full_name: string;
    employee_id: string;
    role: 'driver' | 'manager';
    manager_level?: 1 | 2;
    safety_index?: number;
    total_batches_completed?: number;
    // Add other fields as needed
}

export const UserManagementScreen = ({ navigation }: any) => {
    const { t } = useTranslation();
    const { colors, theme } = useTheme();
    const [users, setUsers] = useState<UserProfile[]>([]);
    const [loading, setLoading] = useState(true);
    const [currentUserProfile, setCurrentUserProfile] = useState<any>(null); // Store current user profile
    const [searchQuery, setSearchQuery] = useState('');
    const [showCreateModal, setShowCreateModal] = useState(false);
    const [showNotificationModal, setShowNotificationModal] = useState(false);

    const [selectedUserForNotification, setSelectedUserForNotification] = useState<UserProfile | null>(null);

    // Pagination
    const [page, setPage] = useState(1);
    const USERS_PER_PAGE = 10;

    const [showChangePasswordModal, setShowChangePasswordModal] = useState(false);
    const [selectedUserForPassword, setSelectedUserForPassword] = useState<UserProfile | null>(null);

    const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
    const [showFinalDeleteConfirm, setShowFinalDeleteConfirm] = useState(false);
    const [selectedUserForDelete, setSelectedUserForDelete] = useState<UserProfile | null>(null);
    const [deleteLoading, setDeleteLoading] = useState(false);
    const [companyStats, setCompanyStats] = useState<CompanyStats | null>(null);
    const [refreshing, setRefreshing] = useState(false);

    const styles = useMemo(() => createStyles(colors), [colors]);

    useEffect(() => {
        loadData();
    }, []);

    const loadData = async () => {
        setLoading(true);
        try {
            // Load current user profile first to determine permissions
            const { profile: currentProfile, error: profileError } = await AuthService.getUserProfile();
            if (profileError) throw new Error(profileError);
            setCurrentUserProfile(currentProfile);

            // Load all users
            const { users: allUsers, error: usersError } = await AuthService.getAllUsers();
            if (usersError) throw new Error(usersError);
            setUsers(allUsers || []);

            // Load company stats if user has company_id
            if (currentProfile?.company_id) {
                const stats = await CompanySettingsService.getCompanyStats(currentProfile.company_id);
                if (stats) setCompanyStats(stats);
            }
        } catch (error: any) {
            Alert.alert(t('common.error'), error.message || t('common.unexpectedErrorOccurred'));
        } finally {
            setLoading(false);
        }
    };

    const loadUsers = async () => {
        // Helper to refresh just the user list
        try {
            const { users: allUsers, error } = await AuthService.getAllUsers();
            if (error) throw new Error(error);
            setUsers(allUsers || []);
        } catch (error: any) {
            console.error('Refresh users error:', error);
        }
    };

    const onRefresh = async () => {
        setRefreshing(true);
        await loadData();
        setRefreshing(false);
    };

    const filteredUsers = useMemo(() => {
        if (!searchQuery) return users;
        const lowerQuery = searchQuery.toLowerCase();
        return users.filter(user => 
            user.full_name?.toLowerCase().includes(lowerQuery) || 
            user.employee_id?.toLowerCase().includes(lowerQuery)
        );
    }, [users, searchQuery]);

    const paginatedUsers = useMemo(() => {
        const startIndex = (page - 1) * USERS_PER_PAGE;
        return filteredUsers.slice(startIndex, startIndex + USERS_PER_PAGE);
    }, [filteredUsers, page]);

    const totalPages = Math.ceil(filteredUsers.length / USERS_PER_PAGE);

    const handleDeletePress = (user: UserProfile) => {
        setSelectedUserForDelete(user);
        setShowDeleteConfirm(true);
    };

    const proceedToFinalConfirmation = () => {
        setShowDeleteConfirm(false);
        // Small timeout to allow the first modal to close smoothly before opening the second
        setTimeout(() => {
            setShowFinalDeleteConfirm(true);
        }, 300);
    };

    const performDelete = async () => {
        if (!selectedUserForDelete) return;
        
        setDeleteLoading(true);
        try {
            const { success, error } = await AuthService.deleteUser(selectedUserForDelete.id);
            if (!success || error) throw new Error(error || 'Failed to delete user');
            
            Alert.alert(t('common.success'), t('user.userDeleted'));
            setShowFinalDeleteConfirm(false);
            loadUsers(); // Refresh the list
        } catch (err: any) {
            Alert.alert(t('common.error'), err.message || t('user.errorDelete'));
        } finally {
            setDeleteLoading(false);
        }
    };

    const handleChangePasswordPress = (user: UserProfile) => {
        setSelectedUserForPassword(user);
        setShowChangePasswordModal(true);
    };

    const renderUserItem = ({ item }: { item: UserProfile }) => (
        <View style={styles.userCard}>
            <View style={styles.userInfo}>
                <View style={styles.avatarPlaceholder}>
                    <Text style={styles.avatarText}>{item.full_name?.charAt(0).toUpperCase()}</Text>
                </View>
                <View style={{flex: 1, minWidth: 0}}>
                    <Text style={styles.userName} numberOfLines={1}>{item.full_name}</Text>
                    <Text style={styles.userSubtext} numberOfLines={1}>{item.employee_id}</Text>
                    {item.role !== 'manager' && (
                        <View style={{ flexDirection: 'row', gap: 8, marginTop: 2 }}>
                            <Text style={styles.resultText}>
                                📊 {item.safety_index ? `${Math.round(item.safety_index)}%` : 'N/A'}
                            </Text>
                            <Text style={styles.resultText}>
                                📚 {item.total_batches_completed || 0}/4
                            </Text>
                        </View>
                    )}
                </View>
            </View>

            <View style={styles.actions}>
                <TouchableOpacity onPress={() => {
                    setSelectedUserForNotification(item);
                    setShowNotificationModal(true);
                }} style={styles.actionButton}>
                    <Text style={{fontSize: 14}}>🔔</Text>
                </TouchableOpacity>
                {item.manager_level !== 1 && (
                    <TouchableOpacity onPress={() => handleChangePasswordPress(item)} style={styles.actionButton}>
                        <Key size={14} color={colors.text.secondary} />
                    </TouchableOpacity>
                )}
                {item.manager_level !== 1 && (
                    <TouchableOpacity onPress={() => handleDeletePress(item)} style={styles.actionButton}>
                        <Trash2 size={14} color={colors.status.danger} />
                    </TouchableOpacity>
                )}
            </View>
        </View>
    );

    return (
        <GradientBackground>
            <SafeAreaView style={styles.safeArea}>
                <View style={styles.header}>
                    <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
                        <ChevronLeft color={colors.text.primary} size={24} />
                    </TouchableOpacity>
                    <Text style={styles.headerTitle}>{t('profile.teamManagement')}</Text>
                    <TouchableOpacity 
                        onPress={() => {
                            setSelectedUserForNotification(null);
                            setShowNotificationModal(true);
                        }} 
                        style={styles.broadcastButton}
                    >
                        <Text style={{fontSize: 20}}>📢</Text>
                    </TouchableOpacity>
                </View>

                {/* Quota Stats Indicator */}
                {companyStats && (
                    <View style={styles.quotaContainer}>
                        <GlassCard contentStyle={styles.quotaCard}>
                            <View style={styles.quotaItem}>
                                <Text style={styles.quotaLabel}>👤 {t('user.drivers')}</Text>
                                <View style={styles.quotaBar}>
                                    <View style={[
                                        styles.quotaFill,
                                        {
                                            width: `${Math.min(100, (companyStats.drivers / companyStats.quota_drivers) * 100)}%`,
                                            backgroundColor: companyStats.drivers >= companyStats.quota_drivers 
                                                ? colors.status.danger 
                                                : companyStats.drivers >= companyStats.quota_drivers * 0.8 
                                                    ? colors.status.warning 
                                                    : colors.status.success
                                        }
                                    ]} />
                                </View>
                                <Text style={styles.quotaText}>
                                    {companyStats.drivers} / {companyStats.quota_drivers}
                                </Text>
                            </View>
                            <View style={styles.quotaItem}>
                                <Text style={styles.quotaLabel}>👔 {t('user.managers')}</Text>
                                <View style={styles.quotaBar}>
                                    <View style={[
                                        styles.quotaFill,
                                        {
                                            width: `${Math.min(100, (companyStats.managers / companyStats.quota_managers) * 100)}%`,
                                            backgroundColor: companyStats.managers >= companyStats.quota_managers 
                                                ? colors.status.danger 
                                                : companyStats.managers >= companyStats.quota_managers * 0.8 
                                                    ? colors.status.warning 
                                                    : colors.status.success
                                        }
                                    ]} />
                                </View>
                                <Text style={styles.quotaText}>
                                    {companyStats.managers} / {companyStats.quota_managers}
                                </Text>
                            </View>
                        </GlassCard>
                    </View>
                )}

                {/* ... search container ... */}
                <View style={styles.searchContainer}>
                    <GlassCard contentStyle={styles.searchBar}>
                        <Search size={20} color={colors.text.tertiary} />
                        <TextInput 
                            style={styles.searchInput}
                            placeholder={t('common.searchPlaceholder')}
                            placeholderTextColor={colors.text.tertiary}
                            value={searchQuery}
                            onChangeText={setSearchQuery}
                        />
                        {searchQuery.length > 0 && (
                            <TouchableOpacity onPress={() => setSearchQuery('')}>
                                <X size={20} color={colors.text.tertiary} />
                            </TouchableOpacity>
                        )}
                    </GlassCard>
                </View>

                {loading ? (
                    <View style={styles.center}>
                        <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
                    </View>
                ) : (
                    <View style={{ flex: 1 }}>
                        <FlatList 
                            data={paginatedUsers}
                            keyExtractor={item => item.id}
                            renderItem={renderUserItem}
                            contentContainerStyle={styles.listContent}
                            refreshControl={
                                <RefreshControl
                                    refreshing={refreshing}
                                    onRefresh={onRefresh}
                                    tintColor={colors.primary.DEFAULT}
                                    colors={[colors.primary.DEFAULT]}
                                />
                            }
                            ListEmptyComponent={
                                <View style={styles.center}>
                                    <Text style={styles.emptyText}>{t('common.noUsers', 'No users found')}</Text>
                                </View>
                            }
                        />
                    {/* Pagination Controls */}
                    <View style={styles.paginationContainer}>
                        <TouchableOpacity 
                            disabled={page === 1} 
                            onPress={() => setPage(p => Math.max(1, p - 1))}
                            style={[styles.pageButton, page === 1 && styles.pageButtonDisabled]}
                        >
                            <ChevronLeft size={20} color={page === 1 ? colors.text.tertiary : colors.text.primary} />
                        </TouchableOpacity>
                        <Text style={[styles.pageText, { color: colors.text.primary }]}>
                            Page {page} of {totalPages || 1}
                        </Text>
                        <TouchableOpacity 
                            disabled={page === totalPages || totalPages <= 1} 
                            onPress={() => setPage(p => Math.min(totalPages, p + 1))}
                            style={[styles.pageButton, (page === totalPages || totalPages <= 1) && styles.pageButtonDisabled]}
                        >
                            <ChevronLeft size={20} color={page === totalPages || totalPages <= 1 ? colors.text.tertiary : colors.text.primary} style={{ transform: [{ rotate: '180deg' }] }} />
                        </TouchableOpacity>
                    </View>
                    </View>
                )}

                <View style={styles.fabContainer}>
                    <GlassButton 
                        title={t('user.createUser', 'Add User')}
                        icon={<UserPlus size={20} color={colors.text.inverse} />}
                        onPress={() => setShowCreateModal(true)}
                        style={styles.fab}
                    />
                </View>

                <CreateUserModal 
                    visible={showCreateModal}
                    onClose={() => setShowCreateModal(false)}
                    currentUserLevel={currentUserProfile?.manager_level || 2}
                    onUserCreated={() => {
                        setShowCreateModal(false);
                        loadData(); // Reload both users AND quota stats
                    }}
                />

                <NotificationSenderModal
                    visible={showNotificationModal}
                    onClose={() => setShowNotificationModal(false)}
                    preselectedUser={selectedUserForNotification ? {
                        id: selectedUserForNotification.id,
                        name: selectedUserForNotification.full_name
                    } : null}
                />

                <ChangePasswordModal
                    visible={showChangePasswordModal}
                    onClose={() => setShowChangePasswordModal(false)}
                    user={selectedUserForPassword ? { 
                        id: selectedUserForPassword.id, 
                        name: selectedUserForPassword.full_name 
                    } : null}
                />

                <ConfirmationModal
                    visible={showDeleteConfirm}
                    title="Delete User?"
                    message={`Are you sure you want to delete ${selectedUserForDelete?.full_name}? This action cannot be undone.`}
                    onCancel={() => setShowDeleteConfirm(false)}
                    onConfirm={proceedToFinalConfirmation}
                    loading={false}
                    confirmText="Delete"
                    type="danger"
                />

                <DeleteUserModal
                    visible={showFinalDeleteConfirm}
                    onClose={() => setShowFinalDeleteConfirm(false)}
                    onConfirm={performDelete}
                    loading={deleteLoading}
                />
            </SafeAreaView>
        </GradientBackground>
    );
};

const createStyles = (colors: any) => StyleSheet.create({
    safeArea: {
        flex: 1,
    },
    header: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal: 20,
        paddingVertical: 12,
    },
    backButton: {
        padding: 8,
    },
    headerTitle: {
        fontSize: typography.sizes.xl,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    searchContainer: {
        paddingHorizontal: 20,
        marginBottom: 10,
    },
    searchBar: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: 16,
        paddingVertical: 12,
        borderRadius: 12,
        gap: 12,
    },
    searchInput: {
        flex: 1,
        marginLeft: 8,
        color: colors.text.primary,
        fontFamily: typography.fonts.medium,
        fontSize: 16,
    },
    broadcastButton: {
        padding: 8,
        backgroundColor: colors.primary.light + '20',
        borderRadius: 12,
        width: 40,
        height: 40,
        justifyContent: 'center',
        alignItems: 'center',
    },
    listContent: {
        padding: 20,
        paddingBottom: 100,
    },
    userCard: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        marginBottom: 12,
        paddingHorizontal: 16,
        paddingVertical: 14,
        borderRadius: 14,
        backgroundColor: colors.background.card,
        borderWidth: 1,
        borderColor: 'transparent',
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
        elevation: 4,
    },
    userInfo: {
        flexDirection: 'row',
        alignItems: 'center',
        flex: 1,
    },
    avatarPlaceholder: {
        width: 36,
        height: 36,
        borderRadius: 18,
        backgroundColor: colors.primary.light + '20',
        justifyContent: 'center',
        alignItems: 'center',
        marginRight: 10,
    },
    avatarText: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: colors.primary.DEFAULT,
    },
    userName: {
        fontSize: 15,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    userSubtext: {
        fontSize: 12,
        color: colors.text.secondary,
        fontFamily: typography.fonts.regular,
    },
    resultText: {
        fontSize: 11,
        color: colors.text.tertiary,
        fontFamily: typography.fonts.medium,
        marginTop: 2,
    },
    actions: {
        flexDirection: 'row',
        gap: 8,
    },
    actionButton: {
        padding: 8,
        backgroundColor: colors.background.card,
        borderRadius: 8,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 2,
        elevation: 2,
    },
    center: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    emptyText: {
        color: colors.text.secondary,
        fontSize: 16,
    },
    paginationContainer: {
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center',
        paddingVertical: 10,
        gap: 16,
        marginBottom: 80, // Space for FAB
    },
    pageButton: {
        padding: 8,
        borderRadius: 8,
        backgroundColor: colors.background.subtle,
    },
    pageButtonDisabled: {
        opacity: 0.5,
    },
    pageText: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: colors.primary.DEFAULT,
    },
    fabContainer: {
        position: 'absolute',
        bottom: 20,
        left: 20,
        right: 20,
    },
    fab: {
        width: '100%',
    },
    quotaContainer: {
        paddingHorizontal: 20,
        marginBottom: 10,
    },
    quotaCard: {
        flexDirection: 'row',
        gap: 16,
        paddingVertical: 12,
        paddingHorizontal: 16,
    },
    quotaItem: {
        flex: 1,
    },
    quotaLabel: {
        fontSize: 12,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
        marginBottom: 6,
    },
    quotaBar: {
        height: 8,
        backgroundColor: colors.background.subtle,
        borderRadius: 4,
        overflow: 'hidden',
        marginBottom: 4,
    },
    quotaFill: {
        height: '100%',
        borderRadius: 4,
    },
    quotaText: {
        fontSize: 11,
        fontFamily: typography.fonts.medium,
        color: colors.text.secondary,
        textAlign: 'center',
    }
});
