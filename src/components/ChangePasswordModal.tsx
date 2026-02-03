import React, { useState } from 'react';
import { View, Text, TextInput, Modal, TouchableOpacity, StyleSheet, ActivityIndicator, Alert } from 'react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassCard } from './ui/GlassCard';
import { GlassButton } from './ui/GlassButton';
import { X, Key } from 'lucide-react-native';
import { AuthService } from '../services/authService';

interface ChangePasswordModalProps {
    visible: boolean;
    onClose: () => void;
    user: { id: string; name: string } | null;
}

export const ChangePasswordModal = ({ visible, onClose, user }: ChangePasswordModalProps) => {
    const { colors } = useTheme();
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);

    const handleChange = async () => {
        if (!user) return;
        if (password.length < 6) {
            Alert.alert('Error', 'Password must be at least 6 characters');
            return;
        }

        try {
            setLoading(true);
            const { success, error } = await AuthService.changeUserPassword(user.id, password);
            
            if (!success || error) {
                throw new Error(error || 'Failed to change password');
            }

            Alert.alert('Success', `Password for ${user.name} changed successfully!`);
            setPassword('');
            onClose();
        } catch (error: any) {
            Alert.alert('Error', error.message);
        } finally {
            setLoading(false);
        }
    };

    if (!user) return null;

    return (
        <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
            <View style={[styles.overlay, { backgroundColor: 'rgba(0,0,0,0.5)' }]}>
                <GlassCard style={styles.container}>
                    <View style={styles.header}>
                        <View style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
                            <Key size={24} color={colors.primary.DEFAULT} />
                            <Text style={[styles.title, { color: colors.text.primary }]}>Change Password</Text>
                        </View>
                        <TouchableOpacity onPress={onClose}>
                            <X size={24} color={colors.text.secondary} />
                        </TouchableOpacity>
                    </View>

                    <Text style={[styles.subtitle, { color: colors.text.secondary }]}>
                        Enter new password for <Text style={{ fontWeight: 'bold', color: colors.text.primary }}>{user.name}</Text>
                    </Text>

                    <TextInput 
                        style={[styles.input, { 
                            backgroundColor: colors.background.subtle,
                            color: colors.text.primary,
                            borderColor: colors.border 
                        }]}
                        placeholder="New Password (min 6 chars)"
                        placeholderTextColor={colors.text.tertiary}
                        secureTextEntry
                        value={password}
                        onChangeText={setPassword}
                    />

                    <GlassButton 
                        title={loading ? "Changing..." : "Change Password"}
                        onPress={handleChange}
                        disabled={loading}
                        style={{ marginTop: 20 }}
                    />
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
        maxWidth: 400,
        padding: 24,
    },
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 16,
    },
    title: {
        fontSize: 20,
        fontFamily: typography.fonts.bold,
    },
    subtitle: {
        fontSize: 14,
        fontFamily: typography.fonts.regular,
        marginBottom: 20,
    },
    input: {
        width: '100%',
        padding: 12,
        borderRadius: 8,
        borderWidth: 1,
        fontSize: 16,
    }
});
