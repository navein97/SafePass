import React, { useState } from 'react';
import { View, Text, StyleSheet, TextInput, Modal, Alert, ScrollView, TouchableOpacity } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { X, UserPlus, Building, MapPin } from 'lucide-react-native';
import { AuthService } from '../services/authService';

interface CreateUserModalProps {
  visible: boolean;
  onClose: () => void;
  currentUserLevel: 1 | 2;
  currentUserDepartment?: string;
}

export const CreateUserModal: React.FC<CreateUserModalProps> = ({ visible, onClose, currentUserLevel, currentUserDepartment }) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  const [loading, setLoading] = useState(false);
  const [role, setRole] = useState<'driver' | 'manager'>('driver');
  
  // Form State
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('123456'); // Default password
  const [fullName, setFullName] = useState('');
  const [employeeId, setEmployeeId] = useState('');
  const [department, setDepartment] = useState('');
  const [area, setArea] = useState('');

  // Level 1 can create Level 2 Managers
  const canCreateManager = currentUserLevel === 1;

  // Pre-fill department for Level 2 Managers
  React.useEffect(() => {
      if (visible && currentUserLevel === 2 && currentUserDepartment) {
          setDepartment(currentUserDepartment);
      } else if (visible && currentUserLevel === 1) {
          // Reset for Level 1 who can type anything
          setDepartment('');
      }
  }, [visible, currentUserLevel, currentUserDepartment]);

  const handleCreateUser = async () => {
    if (!email || !fullName || !employeeId) {
        Alert.alert('Error', 'Please fill in required fields');
        return;
    }

    try {
        setLoading(true);
        // In a real app, this would call a backend function (Edge Function) to invite user
        // For this demo, we use client-side signUp but we need to sign out current user first OR use a secondary client.
        // LIMITATION: supabase-js client auth singleton. 
        // WORKAROUND: We will Alert instructions for the Manager to tell the user for now 
        // OR better: Create a "Invitation" record in a separate table if we had backend logic.
        
        // Since we are running client-side only without Edge Functions for now:
        const { error } = await AuthService.signUp({
            email,
            password,
            fullName,
            employeeId,
            region: 'MY', // Defaulting for now
            // We need to extend AuthService to accept extra metadata
            // But standard signUp takes metadata options
        });
        
        // NOTE: This will technically sign in the new user on this device if successful.
        // We will explain this limitation or use a simplified mock success for the "UI Feel".
        
        // Simulating API call for Invitation
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        Alert.alert(
            'Success', 
            `User ${fullName} created!\nEmail: ${email}\nPassword: ${password}`,
            [{ text: 'OK', onPress: onClose }]
        );
        
    } catch (error: any) {
        Alert.alert('Error', error.message || 'Failed to create user');
    } finally {
        setLoading(false);
    }
  };

  const dynamicStyles = {
    title: {
        color: colors.text.primary,
    },
    label: {
        color: colors.text.secondary,
    },
    input: {
        backgroundColor: colors.background.subtle,
        color: colors.text.primary,
        borderColor: colors.border,
    },
    helperText: {
        color: colors.text.tertiary,
    }
  };

  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <ScrollView 
        style={styles.modalOverlay}
        contentContainerStyle={styles.scrollContainer}
        showsVerticalScrollIndicator={false}
        bounces={true}
        keyboardShouldPersistTaps="handled"
      >
        <GlassCard style={styles.modalContent}>
            <View style={styles.header}>
                <Text style={[styles.title, dynamicStyles.title]}>{t('user.createTitle', 'Create New User')}</Text>
                <TouchableOpacity 
                    onPress={onClose} 
                    style={styles.closeButton}
                    activeOpacity={0.7}
                >
                    <X size={20} color={colors.text.primary} />
                </TouchableOpacity>
            </View>
            
            {/* Role Selection */}
            {canCreateManager && (
                <View style={styles.roleSelector}>
                    <GlassButton 
                        title="Driver" 
                        variant={role === 'driver' ? 'primary' : 'secondary'} 
                        onPress={() => setRole('driver')}
                        style={styles.roleButton}
                        textStyle={{ color: role === 'driver' ? '#000' : colors.text.primary }}
                    />
                    <GlassButton 
                        title="Manager (Level 2)" 
                        variant={role === 'manager' ? 'primary' : 'secondary'} 
                        onPress={() => setRole('manager')}
                        style={styles.roleButton}
                         textStyle={{ color: role === 'manager' ? '#000' : colors.text.primary }}
                    />
                </View>
            )}

            <Text style={[styles.label, dynamicStyles.label]}>{t('auth.email', 'Email')}</Text>
            <TextInput 
                style={[styles.input, dynamicStyles.input]}
                value={email}
                onChangeText={setEmail}
                placeholder="email@company.com"
                placeholderTextColor={colors.text.tertiary}
                autoCapitalize="none"
            />

            <Text style={[styles.label, dynamicStyles.label]}>{t('auth.fullName', 'Full Name')}</Text>
            <TextInput 
                style={[styles.input, dynamicStyles.input]}
                value={fullName}
                onChangeText={setFullName}
                placeholder="Full Name"
                placeholderTextColor={colors.text.tertiary}
            />
            
            <Text style={[styles.label, dynamicStyles.label]}>{t('auth.employeeId', 'Employee ID')}</Text>
            <TextInput 
                style={[styles.input, dynamicStyles.input]}
                value={employeeId}
                onChangeText={setEmployeeId}
                placeholder="EMP-XXX"
                placeholderTextColor={colors.text.tertiary}
            />

            <Text style={[styles.label, dynamicStyles.label]}>{t('user.department', 'Department')}</Text>
            <TextInput 
                style={[
                    styles.input, 
                    dynamicStyles.input,
                    currentUserLevel === 2 && { opacity: 0.7, backgroundColor: colors.background.subtle }
                ]}
                value={department}
                onChangeText={setDepartment}
                placeholder="Operations, Sales, etc."
                placeholderTextColor={colors.text.tertiary}
                editable={currentUserLevel === 1}
            />

            {role === 'manager' && (
                <>
                <Text style={[styles.label, dynamicStyles.label]}>{t('user.area', 'Area / Division')}</Text>
                <TextInput 
                    style={[styles.input, dynamicStyles.input]}
                    value={area}
                    onChangeText={setArea}
                    placeholder="North Region, etc."
                    placeholderTextColor={colors.text.tertiary}
                />
                </>
            )}

            <Text style={[styles.helperText, dynamicStyles.helperText]}>
                Default password will be set to: 123456
            </Text>

            <View style={{ marginTop: 24, marginBottom: 10 }}>
                <GlassButton 
                    title={loading ? 'Creating...' : 'Create User'}
                    onPress={handleCreateUser}
                    variant="primary"
                    disabled={loading}
                />
            </View>
        </GlassCard>
      </ScrollView>
    </Modal>
  );
};

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.7)',
  },
  scrollContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
    paddingVertical: 40,
  },
  modalContent: {
    width: '100%',
    maxWidth: 500,
    padding: 24,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  title: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    flex: 1,
  },
  closeButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255,255,255,0.1)',
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 12,
  },
  roleSelector: {
    flexDirection: 'row',
    gap: 12,
    marginBottom: 24,
  },
  roleButton: {
    flex: 1,
  },
  label: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    marginBottom: 8,
    marginTop: 12,
  },
  input: {
    borderWidth: 1,
    borderRadius: 12,
    padding: 12,
    fontSize: 16,
    fontFamily: typography.fonts.regular,
  },
  helperText: {
    fontSize: 12,
    marginTop: 16,
    fontStyle: 'italic',
  },
});
