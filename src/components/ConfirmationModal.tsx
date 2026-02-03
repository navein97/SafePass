import React, { useState } from 'react';
import { View, Text, Modal, TouchableOpacity, StyleSheet, ActivityIndicator } from 'react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassCard } from './ui/GlassCard';
import { AlertTriangle } from 'lucide-react-native';

interface ConfirmationModalProps {
    visible: boolean;
    title: string;
    message: string;
    onConfirm: () => void;
    onCancel: () => void;
    loading?: boolean;
    confirmText?: string;
    cancelText?: string;
    type?: 'danger' | 'warning' | 'info';
}

export const ConfirmationModal = ({ 
    visible, 
    title, 
    message, 
    onConfirm, 
    onCancel, 
    loading = false,
    confirmText = "Confirm",
    cancelText = "Cancel",
    type = 'danger'
}: ConfirmationModalProps) => {
    const { colors } = useTheme();

    const getIconColor = () => {
        switch(type) {
            case 'danger': return colors.status.danger;
            case 'warning': return colors.status.warning;
            default: return colors.primary.DEFAULT;
        }
    };

    return (
        <Modal visible={visible} transparent animationType="fade" onRequestClose={onCancel}>
            <View style={[styles.overlay, { backgroundColor: 'rgba(0,0,0,0.5)' }]}>
                <GlassCard style={styles.container}>
                    <View style={styles.iconContainer}>
                        <AlertTriangle size={48} color={getIconColor()} />
                    </View>
                    
                    <Text style={[styles.title, { color: colors.text.primary }]}>{title}</Text>
                    <Text style={[styles.message, { color: colors.text.secondary }]}>{message}</Text>

                    <View style={styles.buttonRow}>
                        <TouchableOpacity 
                            style={[styles.button, styles.cancelButton, { borderColor: colors.border }]} 
                            onPress={onCancel}
                            disabled={loading}
                        >
                            <Text style={[styles.buttonText, { color: colors.text.primary }]}>{cancelText}</Text>
                        </TouchableOpacity>

                        <TouchableOpacity 
                            style={[styles.button, { backgroundColor: getIconColor() }]} 
                            onPress={onConfirm}
                            disabled={loading}
                        >
                            {loading ? (
                                <ActivityIndicator color="#FFF" size="small" />
                            ) : (
                                <Text style={[styles.buttonText, { color: '#FFF', fontWeight: 'bold' }]}>{confirmText}</Text>
                            )}
                        </TouchableOpacity>
                    </View>
                </GlassCard>
            </View>
        </Modal>
    );
};

const styles = StyleSheet.create({
    overlay: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        padding: 20,
    },
    container: {
        width: '100%',
        maxWidth: 340,
        padding: 24,
        alignItems: 'center',
    },
    iconContainer: {
        marginBottom: 16,
    },
    title: {
        fontSize: 20,
        fontFamily: typography.fonts.bold,
        marginBottom: 8,
        textAlign: 'center',
    },
    message: {
        fontSize: 16,
        fontFamily: typography.fonts.regular,
        textAlign: 'center',
        marginBottom: 24,
        lineHeight: 22,
    },
    buttonRow: {
        flexDirection: 'row',
        gap: 12,
        width: '100%',
    },
    button: {
        flex: 1,
        paddingVertical: 12,
        borderRadius: 8,
        alignItems: 'center',
        justifyContent: 'center',
    },
    cancelButton: {
        backgroundColor: 'transparent',
        borderWidth: 1,
    },
    buttonText: {
        fontSize: 16,
        fontFamily: typography.fonts.medium,
    }
});
