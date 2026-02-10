import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, FlatList, TextInput, Alert, ActivityIndicator } from 'react-native';
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

    const [showChangePasswordModal, setShowChangePasswordModal] = useState(false);
    const [selectedUserForPassword, setSelectedUserForPassword] = useState<UserProfile | null>(null);

    const [showDeleteConfirm, setShowDeleteConfirm] = useState(false);
    const [showFinalDeleteConfirm, setShowFinalDeleteConfirm] = useState(false);
    const [selectedUserForDelete, setSelectedUserForDelete] = useState<UserProfile | null>(null);
    const [deleteLoading, setDeleteLoading] = useState(false);

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
        } catch (error: any) {
            Alert.alert('Error', error.message || 'Failed to load data');
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

    const filteredUsers = useMemo(() => {
        if (!searchQuery) return users;
        const lowerQuery = searchQuery.toLowerCase();
        return users.filter(user => 
            user.full_name?.toLowerCase().includes(lowerQuery) || 
            user.employee_id?.toLowerCase().includes(lowerQuery)
        );
    }, [users, searchQuery]);

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
            
            Alert.alert('Success', 'User deleted successfully');
            setShowFinalDeleteConfirm(false);
            loadUsers(); // Refresh the list
        } catch (err: any) {
            Alert.alert('Error', err.message || 'Failed to delete user');
        } finally {
            setDeleteLoading(false);
        }
    };

    const handleChangePasswordPress = (user: UserProfile) => {
        setSelectedUserForPassword(user);
        setShowChangePasswordModal(true);
    };

    const renderUserItem = ({ item }: { item: UserProfile }) => (
        <GlassCard style={styles.userCard}>
            <View style={styles.userInfo}>
                <View style={styles.avatarPlaceholder}>
                    <Text style={styles.avatarText}>{item.full_name?.charAt(0).toUpperCase()}</Text>
                </View>
                <View style={{flex: 1}}>
                    <Text style={styles.userName}>{item.full_name}</Text>
                    <Text style={styles.userSubtext}>{item.employee_id} • {item.role}</Text>
                    {/* Display User Results */}
                    <View style={{ flexDirection: 'row', gap: 12, marginTop: 4 }}>
                        <Text style={styles.resultText}>
                            📊 Score: {item.safety_index ? `${Math.round(item.safety_index)}%` : 'N/A'}
                        </Text>
                        <Text style={styles.resultText}>
                            📚 Batches: {item.total_batches_completed || 0}/4
                        </Text>
                    </View>
                </View>
            </View>
            
            <View style={styles.actions}>
                <TouchableOpacity onPress={() => {
                    setSelectedUserForNotification(item);
                    setShowNotificationModal(true);
                }} style={styles.actionButton}>
                    <Text>🔔</Text>
                </TouchableOpacity>
                {/* Hide change password for Master (Level 1) users */}
                {item.manager_level !== 1 && (
                    <TouchableOpacity onPress={() => handleChangePasswordPress(item)} style={styles.actionButton}>
                        <Key size={20} color={colors.text.secondary} />
                    </TouchableOpacity>
                )}
                {/* Hide delete for Master (Level 1) users */}
                {item.manager_level !== 1 && (
                    <TouchableOpacity onPress={() => handleDeletePress(item)} style={styles.actionButton}>
                        <Trash2 size={20} color={colors.status.danger} />
                    </TouchableOpacity>
                )}
            </View>
        </GlassCard>
    );

    return (
        <GradientBackground>
            <SafeAreaView style={styles.safeArea}>
                <View style={styles.header}>
                    <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
                        <ChevronLeft color={colors.text.primary} size={24} />
                    </TouchableOpacity>
                    <Text style={styles.headerTitle}>{t('profile.manageUsers', 'User Management')}</Text>
                    <View style={{ width: 40 }} /> 
                </View>

                {/* ... search container ... */}
                <View style={styles.searchContainer}>
                    <GlassCard style={styles.searchBar}>
                        <Search size={20} color={colors.text.tertiary} />
                        <TextInput 
                            style={styles.searchInput}
                            placeholder={t('common.search', 'Search by name or ID...')}
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
                    <FlatList 
                        data={filteredUsers}
                        keyExtractor={item => item.id}
                        renderItem={renderUserItem}
                        contentContainerStyle={styles.listContent}
                        ListEmptyComponent={
                            <View style={styles.center}>
                                <Text style={styles.emptyText}>{t('common.noUsers', 'No users found')}</Text>
                            </View>
                        }
                    />
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
                        loadUsers();
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
    listContent: {
        padding: 20,
        paddingBottom: 100,
    },
    userCard: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        marginBottom: 12,
        padding: 16,
    },
    userInfo: {
        flexDirection: 'row',
        alignItems: 'center',
        flex: 1,
    },
    avatarPlaceholder: {
        width: 40,
        height: 40,
        borderRadius: 20,
        backgroundColor: colors.primary.light + '40',
        justifyContent: 'center',
        alignItems: 'center',
        marginRight: 12,
    },
    avatarText: {
        fontSize: 18,
        fontFamily: typography.fonts.bold,
        color: colors.primary.DEFAULT,
    },
    userName: {
        fontSize: 16,
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
    },
    actions: {
        flexDirection: 'row',
        gap: 8,
    },
    actionButton: {
        padding: 8,
        backgroundColor: colors.background.subtle,
        borderRadius: 8,
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
    fabContainer: {
        position: 'absolute',
        bottom: 20,
        left: 20,
        right: 20,
    },
    fab: {
        width: '100%',
    }
});
