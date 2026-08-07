import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TextInput, Modal, ScrollView, TouchableOpacity } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { Toast } from './Toast';
import { X, UserCheck } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { PracticeService } from '../services/practiceService';
import { Validation } from '../utils/validation';
import { supabase } from '../lib/supabase';

interface EditUserModalProps {
  visible: boolean;
  onClose: () => void;
  userToEdit: any;
  onUserUpdated?: () => void;
}

export const EditUserModal: React.FC<EditUserModalProps> = ({ visible, onClose, userToEdit, onUserUpdated }) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  const [loading, setLoading] = useState(false);
  
  // Form State
  const [fullName, setFullName] = useState('');
  const [employeeId, setEmployeeId] = useState('');
  const [age, setAge] = useState('');
  const [vehicleType, setVehicleType] = useState('');
  const [region, setRegion] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [companyCode, setCompanyCode] = useState('');

  // Error State
  const [errors, setErrors] = useState<{ [key: string]: boolean }>({});
  
  // Toast State
  const [toastVisible, setToastVisible] = useState(false);
  const [toastMessage, setToastMessage] = useState('');
  const [toastType, setToastType] = useState<'success' | 'error' | 'info'>('success');

  const [vehicleOptions, setVehicleOptions] = useState<{ label: string; value: string }[]>([]);

  useEffect(() => {
    if (visible && userToEdit) {
      setFullName(userToEdit.full_name || '');
      
      // Extract employee ID without company code if possible
      let rawId = userToEdit.employee_id || '';
      if (rawId.includes('-')) {
        const parts = rawId.split('-');
        setCompanyCode(parts[0]);
        rawId = parts.slice(1).join('-');
      }
      setEmployeeId(rawId);
      
      setAge(userToEdit.age ? userToEdit.age.toString() : '');
      setVehicleType(userToEdit.vehicle_type || '');
      setRegion(userToEdit.region || '');
      setPhoneNumber(userToEdit.phone_number || '');

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
          console.error('Error fetching vehicle options in EditUserModal:', err);
        }
      };
      loadOptions();
    }
  }, [visible, userToEdit]);

  const regionOptions = [
    { label: t('common.malaysia'), value: 'MY' },
    { label: t('user.thailand', 'Thailand'), value: 'TH' },
    { label: t('user.singapore', 'Singapore'), value: 'SG' }
  ];

  const handleUpdateUser = async () => {
    // Validate fields
    const newErrors: { [key: string]: boolean } = {};
    if (!fullName.trim()) newErrors.fullName = true;
    if (!employeeId.trim()) newErrors.employeeId = true;
    if (!age) newErrors.age = true;
    if (!vehicleType) newErrors.vehicleType = true;
    if (!region) newErrors.region = true;
    if (!phoneNumber.trim()) newErrors.phoneNumber = true;

    if (Object.keys(newErrors).length > 0) {
        setErrors(newErrors);
        return;
    }

    const formattedPhone = Validation.formatPhoneNumber(phoneNumber, region || 'MY');
    if (!Validation.hasCountryCode(formattedPhone)) {
        setToastMessage(t('auth.phoneCountryCodeRequired', 'Please include country code (e.g. +60123456789) for WhatsApp compatibility'));
        setToastType('error');
        setToastVisible(true);
        setErrors(prev => ({ ...prev, phoneNumber: true }));
        return;
    }

    try {
        setLoading(true);

        const rawId = employeeId.trim();
        const formattedId = (companyCode && !rawId.toUpperCase().startsWith(`${companyCode}-`)) 
          ? `${companyCode}-${rawId}` 
          : rawId;

        const { error } = await AuthService.updateCompanyUser({
            userId: userToEdit.id,
            fullName: fullName.trim(),
            employeeId: formattedId,
            age: parseInt(age),
            vehicle_type: vehicleType,
            region,
            phone_number: formattedPhone
        });
        
        if (error) throw new Error(error);

        // Show success toast
        setToastMessage(t('user.userUpdated', 'User profile updated successfully'));
        setToastType('success');
        setToastVisible(true);
        
        // Close after a delay
        setTimeout(() => {
            if (onUserUpdated) onUserUpdated();
            onClose();
        }, 2000);
        
    } catch (error: any) {
        let errorMessage = error.message || t('user.errorUpdate', 'Failed to update user');
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
        borderColor: colors.status?.danger || '#FF3B30',
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
                    <UserCheck size={24} color={colors.primary.DEFAULT} style={{ marginRight: 10 }} />
                    <Text style={[styles.title, dynamicStyles.title]}>{t('user.editTitle', 'Edit User Profile')}</Text>
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
              
              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.companyCode', 'Company Code')}</Text>
              <TextInput
                  style={[
                      styles.input,
                      dynamicStyles.input,
                      styles.disabledInput,
                  ]}
                  value={companyCode}
                  editable={false}
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
                  placeholder={t('auth.employeeId')}
                  placeholderTextColor={colors.text.tertiary}
                  autoCapitalize="none"
              />

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.phoneNumber')}</Text>
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
                  placeholder="+60123456789"
                  placeholderTextColor={colors.text.tertiary}
                  keyboardType="phone-pad"
              />
              {errors.phoneNumber && (
                  <Text style={[styles.errorText, { color: colors.status?.danger || '#FF3B30', marginTop: -12, marginBottom: 12 }]}>
                      {phoneNumber.trim() ? t('auth.phoneCountryCodeRequired') : t('auth.phoneRequired')}
                  </Text>
              )}

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.age')}</Text>
              <TextInput 
                  style={[
                      styles.input, 
                      dynamicStyles.input,
                      errors.age && dynamicStyles.errorBorder
                  ]}
                  value={age}
                  onChangeText={(text) => {
                      setAge(text.replace(/[^0-9]/g, ''));
                      if (text) setErrors(prev => ({ ...prev, age: false }));
                  }}
                  placeholder={t('auth.age')}
                  placeholderTextColor={colors.text.tertiary}
                  keyboardType="numeric"
                  maxLength={2}
              />

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.vehicleType')}</Text>
              <View style={styles.radioGroup}>
                  {vehicleOptions.length > 0 ? vehicleOptions.map((option) => (
                      <TouchableOpacity 
                          key={option.value}
                          style={[
                              styles.radioOption,
                              vehicleType === option.value && { backgroundColor: colors.primary.DEFAULT + '20', borderColor: colors.primary.DEFAULT },
                              errors.vehicleType && dynamicStyles.errorBorder
                          ]}
                          onPress={() => {
                              setVehicleType(option.value);
                              setErrors(prev => ({ ...prev, vehicleType: false }));
                          }}
                      >
                          <Text style={[
                              styles.radioText,
                              { color: vehicleType === option.value ? colors.primary.DEFAULT : colors.text.secondary }
                          ]}>{option.label}</Text>
                      </TouchableOpacity>
                  )) : (
                      <Text style={{color: colors.text.secondary}}>Loading options...</Text>
                  )}
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.region')}</Text>
              <View style={styles.radioGroup}>
                  {regionOptions.map((option) => (
                      <TouchableOpacity 
                          key={option.value}
                          style={[
                              styles.radioOption,
                              region === option.value && { backgroundColor: colors.primary.DEFAULT + '20', borderColor: colors.primary.DEFAULT },
                              errors.region && dynamicStyles.errorBorder
                          ]}
                          onPress={() => {
                              setRegion(option.value);
                              setErrors(prev => ({ ...prev, region: false }));
                          }}
                      >
                          <Text style={[
                              styles.radioText,
                              { color: region === option.value ? colors.primary.DEFAULT : colors.text.secondary }
                          ]}>{option.label}</Text>
                      </TouchableOpacity>
                  ))}
              </View>

              <View style={styles.footer}>
                  <GlassButton 
                      title={t('common.cancel')} 
                      onPress={onClose} 
                      variant="secondary"
                      style={styles.cancelButton}
                  />
                  <GlassButton 
                      title={t('common.update', 'Update')} 
                      onPress={handleUpdateUser} 
                      loading={loading}
                      style={styles.submitButton}
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
      backgroundColor: 'rgba(0, 0, 0, 0.5)',
      justifyContent: 'center',
      alignItems: 'center',
  },
  scrollView: {
      width: '100%',
      height: '100%',
  },
  scrollContainer: {
      flexGrow: 1,
      justifyContent: 'center',
      alignItems: 'center',
      paddingVertical: 40,
      paddingHorizontal: 20,
  },
  modalContent: {
      width: '100%',
      maxWidth: 400,
      padding: 24,
      borderRadius: 24,
  },
  header: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: 24,
  },
  title: {
      fontSize: 20,
      fontFamily: typography.fonts.bold,
  },
  closeButton: {
      padding: 4,
  },
  label: {
      fontSize: 14,
      fontFamily: typography.fonts.medium,
      marginBottom: 8,
      marginLeft: 4,
  },
  input: {
      height: 50,
      borderRadius: 12,
      paddingHorizontal: 16,
      borderWidth: 1,
      fontSize: 16,
      fontFamily: typography.fonts.regular,
      marginBottom: 16,
  },
  disabledInput: {
      opacity: 0.6,
  },
  radioGroup: {
      flexDirection: 'row',
      flexWrap: 'wrap',
      gap: 12,
      marginBottom: 16,
  },
  radioOption: {
      paddingHorizontal: 16,
      paddingVertical: 10,
      borderRadius: 20,
      borderWidth: 1,
      borderColor: 'transparent',
      backgroundColor: 'rgba(255,255,255,0.05)',
  },
  radioText: {
      fontSize: 14,
      fontFamily: typography.fonts.medium,
  },
  footer: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      marginTop: 24,
      gap: 12,
  },
  cancelButton: {
      flex: 1,
  },
  submitButton: {
      flex: 2,
  },
  errorText: {
      fontSize: 12,
      fontFamily: typography.fonts.regular,
      marginLeft: 4,
  }
});
