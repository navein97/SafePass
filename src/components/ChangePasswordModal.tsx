import React, { useState } from 'react';
import { View, Text, TextInput, Modal, TouchableOpacity, StyleSheet, ActivityIndicator, Alert } from 'react-native';
import { useTheme } from '../context/ThemeContext';
import { useTranslation } from 'react-i18next';
import { typography } from '../theme/typography';
import { GlassCard } from './ui/GlassCard';
import { GlassButton } from './ui/GlassButton';
import { X, Key } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { KeyboardDismissView, PreventDismissView } from './ui/KeyboardDismissView';

interface ChangePasswordModalProps {
    visible: boolean;
    onClose: () => void;
    user: { id: string; name: string } | null;
}

export const ChangePasswordModal = ({ visible, onClose, user }: ChangePasswordModalProps) => {
    const { colors } = useTheme();
    const { t } = useTranslation();
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);

    const handleChange = async () => {
        if (!user) return;
        if (password.length < 6) {
            Alert.alert(t('common.error'), t('auth.passwordMinLength'));
            return;
        }

        try {
            setLoading(true);
            const { success, error } = await AuthService.changeUserPassword(user.id, password);
            
            if (!success || error) {
                throw new Error(error || t('user.errorChangePassword', 'Failed to change password'));
            }

            Alert.alert(t('common.success'), t('user.passwordChangedSuccess', { name: user.name }));
            setPassword('');
            onClose();
        } catch (error: any) {
            Alert.alert(t('common.error'), error.message);
        } finally {
            setLoading(false);
        }
    };

    if (!user) return null;

    return (
        <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
            <KeyboardDismissView>
                <View style={[styles.overlay, { backgroundColor: 'rgba(0,0,0,0.5)' }]}>
                    <PreventDismissView>
                        <GlassCard style={styles.container}>
                    <View style={styles.header}>
                        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
                            <Key size={24} color={colors.primary.DEFAULT} />
                            <Text style={[styles.title, { color: colors.text.primary }]}>{t('user.changePassword')}</Text>
                        </View>
                        <TouchableOpacity onPress={onClose}>
                            <X size={24} color={colors.text.secondary} />
                        </TouchableOpacity>
                    </View>

                    <Text style={[styles.subtitle, { color: colors.text.secondary }]}>
                        {t('user.enterNewPasswordFor')} <Text style={{ fontWeight: 'bold', color: colors.text.primary }}>{user.name}</Text>
                    </Text>

                    <TextInput 
                        style={[styles.input, { 
                            backgroundColor: colors.background.subtle,
                            color: colors.text.primary,
                            borderColor: colors.border 
                        }]}
                        placeholder={t('user.newPasswordPlaceholder')}
                        placeholderTextColor={colors.text.tertiary}
                        secureTextEntry
                        value={password}
                        onChangeText={setPassword}
                    />

                    <GlassButton 
                        title={loading ? t('user.changing') : t('user.changePassword')}
                        onPress={handleChange}
                        disabled={loading}
                        style={{ marginTop: 20 }}
                    />
                        </GlassCard>
                    </PreventDismissView>
                </View>
            </KeyboardDismissView>
        </Modal>
    );
};

const styles = StyleSheet.create({
    overlay: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 20 },
    container: {
        width: '100%',
        maxWidth: 400,
        padding: 24 },
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 16 },
    title: {
        fontSize: 20,
        fontFamily: typography.fonts.bold },
    subtitle: {
        fontSize: 14,
        fontFamily: typography.fonts.regular,
        marginBottom: 20 },
    input: {
        width: '100%',
        padding: 12,
        borderRadius: 8,
        borderWidth: 1,
        fontSize: 16 }
});
