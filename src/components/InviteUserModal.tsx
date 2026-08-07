import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Modal, TouchableOpacity, Linking, Alert, TextInput } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from './ui/GlassButton';
import { GlassCard } from './ui/GlassCard';
import { X, MessageCircle } from 'lucide-react-native';
import { Validation } from '../utils/validation';

interface UserProfile {
    id: string;
    full_name: string;
    employee_id: string;
    phone_number?: string;
    region?: string;
    [key: string]: any;
}

interface InviteUserModalProps {
    visible: boolean;
    onClose: () => void;
    user: UserProfile | null;
    companyId: string | null;
    initialPassword?: string;
}

export const InviteUserModal: React.FC<InviteUserModalProps> = ({ 
    visible, 
    onClose, 
    user, 
    companyId, 
    initialPassword = '' 
}) => {
    const { t, i18n } = useTranslation();
    const { colors, theme } = useTheme();
    const isDark = theme === 'dark';

    const [inviteLang, setInviteLang] = useState<'en' | 'ms'>(i18n.language === 'ms' ? 'ms' : 'en');
    const [password, setPassword] = useState(initialPassword);
    const [companyCode, setCompanyCode] = useState(t('common.notAvailable', 'N/A'));
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        if (visible) {
            setInviteLang(i18n.language === 'ms' ? 'ms' : 'en');
            setPassword(initialPassword);
            fetchCompanyCode();
        }
    }, [visible, user, initialPassword]);

    const fetchCompanyCode = async () => {
        if (!companyId) return;
        setLoading(true);
        try {
            const { supabase } = require('../lib/supabase');
            const { data: comp } = await supabase
                .from('companies')
                .select('code')
                .eq('id', companyId)
                .single();
            if (comp?.code) {
                setCompanyCode(comp.code.toUpperCase());
            }
        } catch (err) {
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    const handleInviteWhatsApp = () => {
        if (!user) return;
        
        const message = t('user.inviteWhatsAppMessage', {
            companyCode: companyCode,
            userId: user.employee_id,
            password: password.trim() ? password : "____________________",
            lng: inviteLang
        });
        
        let phone = user.phone_number ? Validation.toWhatsAppPhone(user.phone_number, user.region || 'MY') : '';
        
        const url = `whatsapp://send?text=${encodeURIComponent(message)}${phone ? `&phone=${phone}` : ''}`;
        
        Linking.canOpenURL(url)
          .then((supported) => {
            if (!supported) {
              Alert.alert(t('common.error'), "WhatsApp is not installed on your device");
            } else {
              Linking.openURL(url);
              onClose(); // Auto close after sending
            }
          })
          .catch((err) => console.error('An error occurred', err));
    };

    const dynamicStyles = {
        title: { color: colors.text.primary },
        label: { color: colors.text.secondary },
        input: {
            backgroundColor: colors.background.subtle,
            color: colors.text.primary,
            borderColor: colors.border,
        },
    };

    return (
        <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
            <View style={styles.modalOverlay}>
                <View style={styles.modalContainer}>
                    <GlassCard style={styles.modalContent}>
                        <View style={styles.header}>
                            <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                                <MessageCircle size={24} color="#25D366" style={{ marginRight: 10 }} />
                                <Text style={[styles.title, dynamicStyles.title]}>{t('user.inviteUser', 'Invite User')}</Text>
                            </View>
                            <TouchableOpacity onPress={onClose} style={styles.closeButton}>
                                <X size={20} color={colors.text.primary} />
                            </TouchableOpacity>
                        </View>

                        <Text style={[styles.label, dynamicStyles.label, { marginBottom: 16 }]}>
                            {t('user.inviteUserDescription', 'Send an invitation via WhatsApp with the login details and download link.')}
                        </Text>
                        
                        <Text style={[styles.label, dynamicStyles.label]}>{t('auth.password', 'Password')} ({t('common.optional', 'Optional')})</Text>
                        <TextInput 
                            style={[styles.input, dynamicStyles.input, { marginBottom: 24 }]}
                            value={password}
                            onChangeText={setPassword}
                            placeholder={t('user.passwordPlaceholder', 'Enter password (or leave blank)')}
                            placeholderTextColor={colors.text.tertiary}
                        />

                        {/* Language Toggle */}
                        <View style={{ flexDirection: 'row', justifyContent: 'center', marginBottom: 16, alignItems: 'center' }}>
                            <View style={{ flexDirection: 'row', backgroundColor: isDark ? 'rgba(255,255,255,0.1)' : 'rgba(0,0,0,0.05)', borderRadius: 20, padding: 3 }}>
                                <TouchableOpacity 
                                    onPress={() => setInviteLang('en')}
                                    style={{
                                        paddingVertical: 6,
                                        paddingHorizontal: 16,
                                        backgroundColor: inviteLang === 'en' ? (isDark ? '#333' : '#FFF') : 'transparent',
                                        borderRadius: 16,
                                        shadowColor: inviteLang === 'en' ? '#000' : 'transparent',
                                        shadowOffset: { width: 0, height: 1 },
                                        shadowOpacity: 0.1,
                                        shadowRadius: 1,
                                        elevation: inviteLang === 'en' ? 2 : 0
                                    }}
                                >
                                    <Text style={{ 
                                        color: inviteLang === 'en' ? colors.text.primary : colors.text.secondary,
                                        fontSize: 13,
                                        fontFamily: inviteLang === 'en' ? typography.fonts.bold : typography.fonts.medium
                                    }}>EN</Text>
                                </TouchableOpacity>
                                <TouchableOpacity 
                                    onPress={() => setInviteLang('ms')}
                                    style={{
                                        paddingVertical: 6,
                                        paddingHorizontal: 16,
                                        backgroundColor: inviteLang === 'ms' ? (isDark ? '#333' : '#FFF') : 'transparent',
                                        borderRadius: 16,
                                        shadowColor: inviteLang === 'ms' ? '#000' : 'transparent',
                                        shadowOffset: { width: 0, height: 1 },
                                        shadowOpacity: 0.1,
                                        shadowRadius: 1,
                                        elevation: inviteLang === 'ms' ? 2 : 0
                                    }}
                                >
                                    <Text style={{ 
                                        color: inviteLang === 'ms' ? colors.text.primary : colors.text.secondary,
                                        fontSize: 13,
                                        fontFamily: inviteLang === 'ms' ? typography.fonts.bold : typography.fonts.medium
                                    }}>BM</Text>
                                </TouchableOpacity>
                            </View>
                        </View>
                        
                        <View style={{ gap: 12 }}>
                            <GlassButton 
                                title={t('user.inviteViaWhatsApp', 'Invite via WhatsApp')}
                                onPress={handleInviteWhatsApp}
                                variant="primary"
                                icon={<MessageCircle size={20} color="#FFF" />}
                                style={{ backgroundColor: '#25D366', borderColor: '#25D366' }} // WhatsApp Green
                                disabled={loading}
                            />
                            <GlassButton 
                                title={t('common.cancel', 'Cancel')}
                                onPress={onClose}
                                variant="secondary"
                            />
                        </View>
                    </GlassCard>
                </View>
            </View>
        </Modal>
    );
};

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.8)',
    justifyContent: 'center',
    alignItems: 'center'
  },
  modalContainer: {
    width: '100%',
    paddingHorizontal: 20,
    maxWidth: 400
  },
  modalContent: {
    width: '100%',
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
  closeButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: 'rgba(255,255,255,0.1)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  label: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    marginBottom: 8,
  },
  input: {
    borderWidth: 1,
    borderRadius: 12,
    padding: 12,
    fontSize: 16,
    fontFamily: typography.fonts.regular,
  },
});
