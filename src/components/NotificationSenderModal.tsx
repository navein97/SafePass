import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Modal, TextInput, TouchableOpacity, Alert, ActivityIndicator } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassCard } from './ui/GlassCard';
import { GlassButton } from './ui/GlassButton';
import { X, Send, CheckSquare, Square } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { NotificationService } from '../services/notificationService';

interface NotificationSenderModalProps {
    visible: boolean;
    onClose: () => void;
    preselectedUser?: { id: string; name: string } | null;
}

export const NotificationSenderModal: React.FC<NotificationSenderModalProps> = ({ visible, onClose, preselectedUser }) => {
    const { t } = useTranslation();
    const { colors } = useTheme();
    const [message, setMessage] = useState('');
    const [loading, setLoading] = useState(false);
    const [targetGroups, setTargetGroups] = useState({
        managers: false,
        drivers: false,
        everyone: false
    });
    


    const handleSend = async () => {
        if (!message.trim()) {
            Alert.alert('Error', 'Please enter a message');
            return;
        }

        if (!preselectedUser && !targetGroups.managers && !targetGroups.drivers) {
            Alert.alert('Error', 'Please select at least one recipient recipient group or user');
            return;
        }

        try {
            setLoading(true);

            if (preselectedUser) {
                // Send to specific user
                await NotificationService.sendNotification({
                    userId: preselectedUser.id,
                    title: 'New Message',
                    body: message
                });
                Alert.alert('Success', `Message sent to ${preselectedUser.name}`);
            } else {
                // Bulk Send
                const { users, error } = await AuthService.getAllUsers();
                if (error || !users) throw new Error(error || 'Failed to fetch users');

                let recipients = [];
                if (targetGroups.everyone) {
                    recipients = users;
                } else if (targetGroups.managers && targetGroups.drivers) {
                    recipients = users;
                } else if (targetGroups.managers) {
                    recipients = users.filter(u => u.role === 'manager');
                } else if (targetGroups.drivers) {
                    recipients = users.filter(u => u.role === 'driver');
                }

                if (recipients.length === 0) {
                    Alert.alert('Info', 'No matching users found to send message to.');
                    return;
                }

                // Send to all (in parallel)
                await Promise.all(recipients.map(user => 
                    NotificationService.sendNotification({
                        userId: user.id,
                        title: 'New Message', // You might want to make this customizable too
                        body: message
                    })
                ));

                Alert.alert('Success', `Message sent to ${recipients.length} users.`);
            }
            
            setMessage('');
            setTargetGroups({ managers: false, drivers: false, everyone: false });
            onClose();
        } catch (error: any) {
            Alert.alert('Error', error.message || 'Failed to send message');
        } finally {
            setLoading(false);
        }
    };

    return (
        <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
            <View style={styles.overlay}>
                <GlassCard style={styles.container}>
                    <View style={styles.header}>
                        <Text style={[styles.title, { color: colors.text.primary }]}>
                            {t('notification.sendMessage', 'Send Message')}
                        </Text>
                        <TouchableOpacity onPress={onClose}>
                            <X size={24} color={colors.text.primary} />
                        </TouchableOpacity>
                    </View>

                    <View style={styles.targetInfo}>
                        <Text style={[styles.label, { color: colors.text.secondary }]}>{t('notification.to', 'To:')}</Text>
                        {preselectedUser ? (
                            <Text style={[styles.targetName, { color: colors.primary.DEFAULT }]}>
                                {preselectedUser.name}
                            </Text>
                        ) : (
                            <View style={styles.checkboxContainer}>
                                <TouchableOpacity 
                                    style={styles.checkboxOption} 
                                    onPress={() => {
                                        const newVal = !targetGroups.everyone;
                                        setTargetGroups({
                                            everyone: newVal,
                                            managers: newVal,
                                            drivers: newVal
                                        });
                                    }}
                                >
                                    {targetGroups.everyone ? 
                                        <CheckSquare size={20} color={colors.primary.DEFAULT} /> : 
                                        <Square size={20} color={colors.text.tertiary} />
                                    }
                                    <Text style={[styles.checkboxLabel, { color: colors.text.primary, fontFamily: typography.fonts.bold }]}>{t('notification.everyone', 'Everyone')}</Text>
                                </TouchableOpacity>
 
                                <TouchableOpacity 
                                    style={styles.checkboxOption} 
                                    onPress={() => setTargetGroups(prev => ({ ...prev, managers: !prev.managers, everyone: false }))}
                                >
                                    {targetGroups.managers ? 
                                        <CheckSquare size={20} color={colors.primary.DEFAULT} /> : 
                                        <Square size={20} color={colors.text.tertiary} />
                                    }
                                    <Text style={[styles.checkboxLabel, { color: colors.text.primary }]}>{t('notification.allManagers', 'All Managers')}</Text>
                                </TouchableOpacity>
                                
                                <TouchableOpacity 
                                    style={styles.checkboxOption} 
                                    onPress={() => setTargetGroups(prev => ({ ...prev, drivers: !prev.drivers, everyone: false }))}
                                >
                                    {targetGroups.drivers ? 
                                        <CheckSquare size={20} color={colors.primary.DEFAULT} /> : 
                                        <Square size={20} color={colors.text.tertiary} />
                                    }
                                    <Text style={[styles.checkboxLabel, { color: colors.text.primary }]}>{t('notification.allDrivers', 'All Drivers')}</Text>
                                </TouchableOpacity>
                            </View>
                        )}
                    </View>

                    <TextInput 
                        style={[styles.input, { 
                            backgroundColor: colors.background.subtle,
                            color: colors.text.primary,
                            borderColor: colors.border
                        }]}
                        multiline
                        numberOfLines={4}
                        placeholder={t('notification.messagePlaceholder', 'Type your message here...')}
                        placeholderTextColor={colors.text.tertiary}
                        value={message}
                        onChangeText={setMessage}
                    />

                    <GlassButton 
                        title={loading ? 'Sending...' : 'Send'}
                        onPress={handleSend}
                        icon={<Send size={20} color={colors.text.inverse} />}
                        disabled={loading}
                        style={{ marginTop: 16 }}
                    />
                </GlassCard>
            </View>
        </Modal>
    );
};

const styles = StyleSheet.create({
    overlay: {
        flex: 1,
        backgroundColor: 'rgba(0,0,0,0.5)',
        justifyContent: 'center',
        padding: 20,
    },
    container: {
        padding: 24,
    },
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 20,
    },
    title: {
        fontSize: 20,
        fontFamily: typography.fonts.bold,
    },
    targetInfo: {
        marginBottom: 16,
    },
    label: {
        fontSize: 16,
        fontFamily: typography.fonts.medium,
        marginBottom: 8,
    },
    targetName: {
        fontSize: 16,
        fontFamily: typography.fonts.bold,
    },
    input: {
        borderRadius: 12,
        borderWidth: 1,
        padding: 12,
        height: 120,
        textAlignVertical: 'top',
        fontSize: 16,
        fontFamily: typography.fonts.regular,
    },
    checkboxContainer: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        gap: 16,
    },
    checkboxOption: {
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
    },
    checkboxLabel: {
        fontSize: 16,
        fontFamily: typography.fonts.medium,
    }
});
