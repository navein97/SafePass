import React, { useState } from 'react';
import { View, Text, StyleSheet, TextInput, Modal, Alert, ScrollView, TouchableOpacity } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { X, UserPlus } from 'lucide-react-native';
import { AuthService } from '../services/authService';

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
  const [password, setPassword] = useState('123456'); // Default password
  const [age, setAge] = useState('');
  const [vehicleType, setVehicleType] = useState('');
  const [region, setRegion] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');

  // Error State
  const [errors, setErrors] = useState<{ [key: string]: boolean }>({});

  const vehicleOptions = [
    { label: t('profile.vehicles.containerHaulage'), value: 'Container Haulage' },
    { label: t('profile.vehicles.curtainSide'), value: 'Curtain Side' },
    { label: t('profile.vehicles.openCargo'), value: 'Open Cargo' },
    { label: t('profile.vehicles.smallTruck'), value: 'Small Truck' }
  ];

  const regionOptions = [
    { label: t('common.malaysia'), value: 'MY' },
    { label: t('user.thailand', 'Thailand'), value: 'TH' },
    { label: t('user.singapore', 'Singapore'), value: 'SG' }
  ];

    const handleCreateUser = async () => {
    // Validate fields
    const newErrors: { [key: string]: boolean } = {};
    if (!fullName.trim()) newErrors.fullName = true;
    if (!employeeId.trim()) newErrors.employeeId = true;
    if (!password) newErrors.password = true;
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
        
        const { error } = await AuthService.signUp({
            fullName: fullName.trim(),
            employeeId: employeeId.trim(),
            password,
            age: parseInt(age),
            vehicle_type: vehicleType,
            region,
            phone_number: phoneNumber.trim(),
            role: 'driver'
        });
        
        if (error) throw new Error(error);

        Alert.alert(
            'Success', 
            `New user created!\n\nName: ${fullName}\nEmployee ID: ${employeeId}\nPassword: ${password}`,
            [{ text: 'OK', onPress: () => {
                if (onUserCreated) onUserCreated();
                onClose();
                setFullName('');
                setEmployeeId('');
                setPassword('123456');
                setAge('');
                setVehicleType('');
                setRegion('');
                setPhoneNumber('');
                setErrors({});
            }}]
        );
        
    } catch (error: any) {
        let errorMessage = error.message || t('user.errorCreate');
        
        // Handle duplicate user error specifically
        if (errorMessage.includes('already registered') || errorMessage.includes('duplicate')) {
            errorMessage = t('user.errorDuplicate', 'A user with this Employee ID already exists.');
        }
        
        Alert.alert(t('common.error'), errorMessage);
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
                    <Text style={[styles.title, dynamicStyles.title]}>{t('user.createTitle', 'Create New Driver')}</Text>
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
                  placeholder="MY-CNG001"
                  placeholderTextColor={colors.text.tertiary}
                  autoCapitalize="characters"
              />

              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.password', 'Password')}</Text>
              <TextInput 
                  style={[
                      styles.input, 
                      dynamicStyles.input,
                      errors.password && dynamicStyles.errorBorder
                  ]}
                  value={password}
                  onChangeText={(text) => {
                      setPassword(text);
                      if (text) setErrors(prev => ({ ...prev, password: false }));
                  }}
                  placeholder="Enter password"
                  placeholderTextColor={colors.text.tertiary}
                  secureTextEntry
              />

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
                  <Text style={[styles.label, dynamicStyles.label]}>{t('auth.phone', 'Phone')}</Text>
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
                      region === opt.value && { color: '#000', fontFamily: typography.fonts.bold }
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
                      vehicleType === opt.value && { color: '#000', fontFamily: typography.fonts.bold }
                    ]}>{opt.label}</Text>
                  </TouchableOpacity>
                ))}
              </View>

              <View style={{ marginTop: 24, marginBottom: 10 }}>
                  <GlassButton 
                      title={loading ? t('user.creating', 'Creating...') : t('user.createUser', 'Create Account')}
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
});
