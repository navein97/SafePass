import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TextInput, Modal, ScrollView, TouchableOpacity } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { Toast } from './Toast';
import { X, UserPlus, Eye, EyeOff } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { PracticeService } from '../services/practiceService';

interface CreateUserModalProps {
  visible: boolean;
  onClose: () => void;
  currentUserLevel: 1 | 2;
  currentUserDepartment?: string;
  onUserCreated?: () => void;
}

export const CreateUserModal: React.FC<CreateUserModalProps> = ({ visible, onClose, currentUserLevel, currentUserDepartment, onUserCreated }) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  const [loading, setLoading] = useState(false);
  
  // Form State
  const [fullName, setFullName] = useState('');
  const [employeeId, setEmployeeId] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [age, setAge] = useState('');
  const [vehicleType, setVehicleType] = useState('');
  const [region, setRegion] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [role, setRole] = useState<'driver' | 'manager'>('driver');

  // Password Visibility State
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  // Error State
  const [errors, setErrors] = useState<{ [key: string]: boolean }>({});
  
  // Toast State
  const [toastVisible, setToastVisible] = useState(false);
  const [toastMessage, setToastMessage] = useState('');
  const [toastType, setToastType] = useState<'success' | 'error' | 'info'>('success');

  const [vehicleOptions, setVehicleOptions] = useState<{ label: string; value: string }[]>([]);

  useEffect(() => {
    if (visible) {
      const loadOptions = async () => {
        try {
          const types = await PracticeService.getVehicleTypes();
          if (types && types.length > 0) {
            const opts = types.map(type => {
              const toCamelCase = (str: string) => {
                return str
                    .toLowerCase()
                    .replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
              };
              const labelKey = `profile.vehicles.${toCamelCase(type)}`;
              return {
                label: t(labelKey, type),
                value: type
              };
            });
            setVehicleOptions(opts);
          }
        } catch (err) {
          console.error('Error fetching vehicle options in CreateUserModal:', err);
        }
      };
      loadOptions();
    }
  }, [visible]);

  const regionOptions = [
    { label: t('common.malaysia'), value: 'MY' },
    { label: t('user.thailand', 'Thailand'), value: 'TH' },
    { label: t('user.singapore', 'Singapore'), value: 'SG' }
  ];

  const roleOptions = [
    { label: t('user.driver', 'Driver'), value: 'driver' },
    ...(currentUserLevel === 1 ? [{ label: t('user.manager', 'Manager'), value: 'manager' }] : [])
  ];

    const handleCreateUser = async () => {
    // Validate fields
    const newErrors: { [key: string]: boolean } = {};
    if (!fullName.trim()) newErrors.fullName = true;
    if (!employeeId.trim()) newErrors.employeeId = true;
    if (!password) newErrors.password = true;
    if (!confirmPassword) newErrors.confirmPassword = true;
    if (password !== confirmPassword) {
        newErrors.password = true;
        newErrors.confirmPassword = true;
    }
    if (!age) newErrors.age = true;
    if (!vehicleType) newErrors.vehicleType = true;
    if (!region) newErrors.region = true;
    if (!phoneNumber.trim()) newErrors.phoneNumber = true;

    if (Object.keys(newErrors).length > 0) {
        setErrors(newErrors);
        return;
    }

    try {
        setLoading(true);
        
        const { profile: currentProfile } = await AuthService.getUserProfile();

        const { error } = await AuthService.signUp({
            fullName: fullName.trim(),
            employeeId: employeeId.trim(),
            password,
            age: parseInt(age),
            vehicle_type: vehicleType,
            region,
            phone_number: phoneNumber.trim(),
            role: role,
            manager_level: role === 'manager' ? 2 : undefined,
            companyId: currentProfile?.company_id
        });
        
        if (error) throw new Error(error);

        // Show success toast
        setToastMessage(t('user.userCreated', { fullName }));
        setToastType('success');
        setToastVisible(true);
        
        // Reset form and close after a delay
        setTimeout(() => {
            if (onUserCreated) onUserCreated();
            onClose();
            setFullName('');
            setEmployeeId('');
            setPassword('');
            setConfirmPassword('');
            setAge('');
            setVehicleType('');
            setRegion('');
            setPhoneNumber('');
            setRole('driver');
            setErrors({});
        }, 4000); // Give user time to see the success message
        
    } catch (error: any) {
        let errorMessage = error.message || t('user.errorCreate');
        
        // Handle duplicate or quota errors specifically
        if (errorMessage.includes('already registered') || errorMessage.includes('duplicate')) {
            errorMessage = t('user.errorDuplicate');
        } else if (errorMessage.toLowerCase().includes('quota exceeded')) {
            errorMessage = role === 'manager' ? t('user.errorQuotaExceededManager') : t('user.errorQuotaExceeded');
        }
        
        setToastMessage(errorMessage);
        setToastType('error');
        setToastVisible(true);
    } finally {
        setLoading(false);
    }
  };

  const dynamicStyles = {
    title: { color: colors.text.primary },
    label: { color: colors.text.secondary },
    input: {
        backgroundColor: colors.background.subtle,
        color: colors.text.primary,
        borderColor: colors.border,
    },
    errorBorder: {
        borderColor: colors.status?.danger || '#FF3B30', // Fallback red
        borderWidth: 1.5,
    }
  };

  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <Toast 
        visible={toastVisible} 
        message={toastMessage} 
        type={toastType} 
        onHide={() => setToastVisible(false)} 
      />
      <View style={styles.modalOverlay}>
        <ScrollView 
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContainer}
          showsVerticalScrollIndicator={false}
          keyboardShouldPersistTaps="handled"
        >
          <GlassCard style={styles.modalContent}>
              <View style={styles.header}>
                  <View style={{ flexDirection: 'row', alignItems: 'center' }}>
                    <UserPlus size={24} color={colors.primary.DEFAULT} style={{ marginRight: 10 }} />
                    <Text style={[styles.title, dynamicStyles.title]}>{t('user.createTitle', 'Create New User')}</Text>
                  </View>
                  <TouchableOpacity onPress={onClose} style={styles.closeButton}>
                      <X size={20} color={colors.text.primary} />
                  </TouchableOpacity>
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.fullName')}</Text>
              <TextInput 
                  style={[
                      styles.input, 
                      dynamicStyles.input,
                      errors.fullName && dynamicStyles.errorBorder
                  ]}
                  value={fullName}
                  onChangeText={(text) => {
                      setFullName(text);
                      if (text) setErrors(prev => ({ ...prev, fullName: false }));
                  }}
                  placeholder={t('auth.fullName')}
                  placeholderTextColor={colors.text.tertiary}
              />
              
              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.employeeId')}</Text>
              <TextInput 
                  style={[
                      styles.input, 
                      dynamicStyles.input,
                      errors.employeeId && dynamicStyles.errorBorder
                  ]}
                  value={employeeId}
                  onChangeText={(text) => {
                      setEmployeeId(text);
                      if (text) setErrors(prev => ({ ...prev, employeeId: false }));
                  }}
                  placeholder={t('auth.employeeIdPlaceholder')}
                  placeholderTextColor={colors.text.tertiary}
                  autoCapitalize="none"
              />

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.password', 'Password')}</Text>
              <View>
                  <TextInput 
                      style={[
                          styles.input, 
                          dynamicStyles.input,
                          errors.password && dynamicStyles.errorBorder,
                          { paddingRight: 50 }
                      ]}
                      value={password}
                      onChangeText={(text) => {
                          setPassword(text);
                          if (text) setErrors(prev => ({ ...prev, password: false }));
                      }}
                      placeholder={t('auth.passwordPlaceholder', 'Enter password')}
                      placeholderTextColor={colors.text.tertiary}
                      secureTextEntry={!showPassword}
                  />
                  <TouchableOpacity 
                      style={styles.eyeIcon} 
                      onPress={() => setShowPassword(!showPassword)}
                  >
                      {showPassword ? (
                          <EyeOff size={20} color={colors.text.tertiary} />
                      ) : (
                          <Eye size={20} color={colors.text.tertiary} />
                      )}
                  </TouchableOpacity>
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.confirmPassword', 'Confirm Password')}</Text>
              <View>
                  <TextInput 
                      style={[
                          styles.input, 
                          dynamicStyles.input,
                          errors.confirmPassword && dynamicStyles.errorBorder,
                          { paddingRight: 50 }
                      ]}
                      value={confirmPassword}
                      onChangeText={(text) => {
                          setConfirmPassword(text);
                          if (text) setErrors(prev => ({ ...prev, confirmPassword: false }));
                      }}
                      placeholder={t('auth.confirmPasswordPlaceholder', 'Re-enter password')}
                      placeholderTextColor={colors.text.tertiary}
                      secureTextEntry={!showConfirmPassword}
                  />
                  <TouchableOpacity 
                      style={styles.eyeIcon} 
                      onPress={() => setShowConfirmPassword(!showConfirmPassword)}
                  >
                      {showConfirmPassword ? (
                          <EyeOff size={20} color={colors.text.tertiary} />
                      ) : (
                          <Eye size={20} color={colors.text.tertiary} />
                      )}
                  </TouchableOpacity>
              </View>
              {errors.confirmPassword && password !== confirmPassword && (
                  <Text style={[styles.errorText, { color: colors.status?.danger || '#FF3B30' }]}>
                      {t('auth.passwordsDoNotMatch', 'Passwords do not match')}
                  </Text>
              )}

              <View style={styles.row}>
                <View style={{ flex: 1, marginRight: 8 }}>
                  <Text style={[styles.label, dynamicStyles.label]}>{t('profile.age', 'Age')}</Text>
                  <TextInput 
                      style={[
                          styles.input, 
                          dynamicStyles.input,
                          errors.age && dynamicStyles.errorBorder
                      ]}
                      value={age}
                      onChangeText={(text) => {
                          setAge(text);
                          if (text) setErrors(prev => ({ ...prev, age: false }));
                      }}
                      placeholder="25"
                      placeholderTextColor={colors.text.tertiary}
                      keyboardType="numeric"
                  />
                </View>
                <View style={{ flex: 1, marginLeft: 8 }}>
                  <Text style={[styles.label, dynamicStyles.label]}>{t('auth.phone', 'Phone No.')}</Text>
                  <TextInput 
                      style={[
                          styles.input, 
                          dynamicStyles.input,
                          errors.phoneNumber && dynamicStyles.errorBorder
                      ]}
                      value={phoneNumber}
                      onChangeText={(text) => {
                          setPhoneNumber(text);
                          if (text) setErrors(prev => ({ ...prev, phoneNumber: false }));
                      }}
                      placeholder="+60..."
                      placeholderTextColor={colors.text.tertiary}
                      keyboardType="phone-pad"
                  />
                </View>
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('profile.region', 'Region')}</Text>
              <View style={styles.optionsGrid}>
                {regionOptions.map((opt) => (
                  <TouchableOpacity
                    key={opt.value}
                    style={[
                      styles.optionChip,
                      { borderColor: colors.border },
                      region === opt.value && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT },
                      errors.region && !region && { borderColor: colors.status?.danger || '#FF3B30' }
                    ]}
                    onPress={() => {
                        setRegion(opt.value);
                        setErrors(prev => ({ ...prev, region: false }));
                    }}
                  >
                    <Text style={[
                      styles.optionText,
                      { color: colors.text.secondary },
                      region === opt.value && { color: '#FFF', fontFamily: typography.fonts.bold }
                    ]}>{opt.label}</Text>
                  </TouchableOpacity>
                ))}
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('profile.vehicleType', 'Vehicle Type')}</Text>
              <View style={styles.optionsWrap}>
                {vehicleOptions.map((opt) => (
                  <TouchableOpacity
                    key={opt.value}
                    style={[
                      styles.optionChip,
                      { borderColor: colors.border },
                      vehicleType === opt.value && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT },
                      errors.vehicleType && !vehicleType && { borderColor: colors.status?.danger || '#FF3B30' }
                    ]}
                    onPress={() => {
                        setVehicleType(opt.value);
                        setErrors(prev => ({ ...prev, vehicleType: false }));
                    }}
                  >
                    <Text style={[
                      styles.optionText,
                      { color: colors.text.secondary },
                      vehicleType === opt.value && { color: '#FFF', fontFamily: typography.fonts.bold }
                    ]}>{opt.label}</Text>
                  </TouchableOpacity>
                ))}
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('user.role', 'Role')}</Text>
              <View style={styles.optionsGrid}>
                {roleOptions.map((opt) => (
                  <TouchableOpacity
                    key={opt.value}
                    style={[
                      styles.optionChip,
                      { borderColor: colors.border },
                      role === opt.value && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT }
                    ]}
                    onPress={() => setRole(opt.value as 'driver' | 'manager')}
                  >
                    <Text style={[
                      styles.optionText,
                      { color: colors.text.secondary },
                      role === opt.value && { color: '#FFF', fontFamily: typography.fonts.bold }
                    ]}>{opt.label}</Text>
                  </TouchableOpacity>
                ))}
              </View>

              <View style={{ marginTop: 24, marginBottom: 10 }}>
                  <GlassButton 
                      title={loading ? t('user.creating') : t('user.createUser')}
                      onPress={handleCreateUser}
                      variant="primary"
                      disabled={loading}
                  />
              </View>
          </GlassCard>
        </ScrollView>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.8)',
  },
  scrollView: {
    flex: 1,
  },
  scrollContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: 20,
    paddingVertical: 60,
  },
  modalContent: {
    width: '100%',
    padding: 24,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 24,
  },
  title: {
    fontSize: 22,
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
    marginTop: 16,
  },
  input: {
    borderWidth: 1,
    borderRadius: 12,
    padding: 12,
    fontSize: 16,
    fontFamily: typography.fonts.regular,
  },
  row: {
    flexDirection: 'row',
  },
  optionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  optionsWrap: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  optionChip: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 12,
    borderWidth: 1,
  },
  optionText: {
    fontSize: 13,
    fontFamily: typography.fonts.medium,
  },
  errorText: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
    marginTop: 4,
    marginLeft: 4,
  },
  eyeIcon: {
    position: 'absolute',
    right: 0,
    top: 0,
    bottom: 0,
    paddingHorizontal: 16,
    justifyContent: 'center',
    alignItems: 'center',
  },
});
