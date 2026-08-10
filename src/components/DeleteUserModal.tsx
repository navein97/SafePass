import React, { useState } from 'react';
import { View, Text, Modal, TouchableOpacity, StyleSheet, ActivityIndicator, TextInput } from 'react-native';
import { useTheme } from '../context/ThemeContext';
import { useTranslation } from 'react-i18next';
import { typography } from '../theme/typography';
import { GlassCard } from './ui/GlassCard';
import { AlertTriangle } from 'lucide-react-native';
import { KeyboardDismissView, PreventDismissView } from './ui/KeyboardDismissView';

interface DeleteUserModalProps {
    visible: boolean;
    onClose: () => void;
    onConfirm: () => void;
    loading?: boolean;
}

export const DeleteUserModal = ({
    visible,
    onClose,
    onConfirm,
    loading = false
}: DeleteUserModalProps) => {
    const { colors } = useTheme();
    const { t } = useTranslation();
    const [confirmText, setConfirmText] = useState('');

    const isMatch = confirmText === t('common.confirmPlaceholder');

    return (
        <Modal
            visible={visible}
            transparent
            animationType="fade"
            onRequestClose={onClose}
        >
            <KeyboardDismissView>
                <View style={[styles.overlay, { backgroundColor: 'rgba(0,0,0,0.5)' }]}>
                    <PreventDismissView>
                        <GlassCard style={styles.container}>
                            <View style={styles.header}>
                                <Text style={[styles.title, { color: colors.text.primary }]}>
                                    {t('common.areYouSure')}
                                </Text>
                                <TouchableOpacity onPress={onClose}>
                                    <Text style={{ color: colors.text.tertiary, fontSize: 20 }}>×</Text>
                                </TouchableOpacity>
                            </View>

                            <Text style={[styles.message, { color: colors.text.secondary }]}>
                                {t('common.cannotBeUndone')} {t('auth.permanentlyDeleteNote', 'This will permanently delete the user account.')}
                            </Text>

                            <Text style={[styles.instruction, { color: colors.text.primary }]}>
                                {t('common.confirmToType', { text: t('common.confirmPlaceholder') })}
                            </Text>

                            <TextInput
                                style={[
                                    styles.input,
                                    {
                                        borderColor: colors.border,
                                        color: colors.text.primary,
                                        backgroundColor: colors.background.subtle
                                    }
                                ]}
                                value={confirmText}
                                onChangeText={setConfirmText}
                                placeholder={t('common.confirmPlaceholder')}
                                placeholderTextColor={colors.text.tertiary}
                                autoCapitalize="none"
                            />

                            <TouchableOpacity
                                style={[
                                    styles.deleteButton,
                                    {
                                        backgroundColor: isMatch ? colors.status.danger : colors.background.subtle,
                                        opacity: isMatch ? 1 : 0.5
                                    }
                                ]}
                                onPress={onConfirm}
                                disabled={!isMatch || loading}
                            >
                                {loading ? (
                                    <ActivityIndicator color="#FFF" size="small" />
                                ) : (
                                    <Text style={[
                                        styles.buttonText,
                                        { color: isMatch ? '#FFF' : colors.text.secondary }
                                    ]}>
                                        {t('user.deleteUser')}
                                    </Text>
                                )}
                            </TouchableOpacity>
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
        fontSize: 18,
        fontFamily: typography.fonts.bold },
    message: {
        fontSize: 14,
        fontFamily: typography.fonts.regular,
        marginBottom: 16,
        lineHeight: 20 },
    instruction: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        marginBottom: 8 },
    input: {
        borderWidth: 1,
        borderRadius: 8,
        padding: 12,
        fontSize: 16,
        fontFamily: typography.fonts.medium,
        marginBottom: 24 },
    deleteButton: {
        width: '100%',
        paddingVertical: 14,
        borderRadius: 8,
        alignItems: 'center',
        justifyContent: 'center' },
    buttonText: {
        fontSize: 16,
        fontFamily: typography.fonts.bold }
});
