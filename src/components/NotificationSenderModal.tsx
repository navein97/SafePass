import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Modal, TextInput, TouchableOpacity, Alert, ActivityIndicator } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassCard } from './ui/GlassCard';
import { GlassButton } from './ui/GlassButton';
import { X, Send } from 'lucide-react-native';
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
    const [target, setTarget] = useState<'specific' | 'all'>('specific');
    
    useEffect(() => {
        if (preselectedUser) {
            setTarget('specific');
        }
    }, [preselectedUser]);

    const handleSend = async () => {
        if (!message.trim()) {
            Alert.alert('Error', 'Please enter a message');
            return;
        }

        if (!preselectedUser) {
            Alert.alert('Error', 'No user selected');
            return;
        }

        try {
            setLoading(true);
            
            await NotificationService.sendNotification({
                userId: preselectedUser.id,
                title: 'New Message',
                body: message
            });
            
            Alert.alert('Success', `Message sent to ${preselectedUser.name}`);
            setMessage('');
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
                        <Text style={[styles.label, { color: colors.text.secondary }]}>To:</Text>
                        <Text style={[styles.targetName, { color: colors.primary.DEFAULT }]}>
                            {preselectedUser ? preselectedUser.name : 'Select User...'}
                        </Text>
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
        flexDirection: 'row',
        alignItems: 'center',
        marginBottom: 16,
    },
    label: {
        fontSize: 16,
        fontFamily: typography.fonts.medium,
        marginRight: 8,
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
    }
});
