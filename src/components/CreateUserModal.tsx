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
}

export const CreateUserModal: React.FC<CreateUserModalProps> = ({ visible, onClose, currentUserLevel, currentUserDepartment }) => {
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

  const vehicleOptions = [
    'Container Haulage',
    'Curtain Side',
    'Open Cargo',
    'Small Truck'
  ];

  const regionOptions = [
    { label: 'Malaysia', value: 'MY' },
    { label: 'Thailand', value: 'TH' },
    { label: 'Singapore', value: 'SG' }
  ];

  const handleCreateUser = async () => {
    if (!fullName || !employeeId || !age || !vehicleType || !region) {
        Alert.alert(t('common.error'), t('user.errorRequired', 'Please fill in all mandatory fields'));
        return;
    }

    try {
        setLoading(true);
        
        const { error } = await AuthService.signUp({
            fullName,
            employeeId,
            password,
            age: parseInt(age),
            vehicle_type: vehicleType,
            region,
            phone_number: phoneNumber,
            role: 'driver'
        });
        
        if (error) throw new Error(error);

        Alert.alert(
            t('user.success'), 
            t('user.userCreated', { fullName, email: `${employeeId}@safepass.internal`, password }),
            [{ text: 'OK', onPress: () => {
                onClose();
                setFullName('');
                setEmployeeId('');
                setAge('');
                setVehicleType('');
                setRegion('');
                setPhoneNumber('');
            }}]
        );
        
    } catch (error: any) {
        Alert.alert(t('common.error'), error.message || t('user.errorCreate'));
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
                  style={[styles.input, dynamicStyles.input]}
                  value={fullName}
                  onChangeText={setFullName}
                  placeholder={t('auth.fullName')}
                  placeholderTextColor={colors.text.tertiary}
              />
              
              <Text style={[styles.label, dynamicStyles.label]}>{t('auth.employeeId')}</Text>
              <TextInput 
                  style={[styles.input, dynamicStyles.input]}
                  value={employeeId}
                  onChangeText={setEmployeeId}
                  placeholder="naveinrex97 / chandrajeimohan"
                  placeholderTextColor={colors.text.tertiary}
                  autoCapitalize="characters"
              />

              <View style={styles.row}>
                <View style={{ flex: 1, marginRight: 8 }}>
                  <Text style={[styles.label, dynamicStyles.label]}>{t('profile.age', 'Age')}</Text>
                  <TextInput 
                      style={[styles.input, dynamicStyles.input]}
                      value={age}
                      onChangeText={setAge}
                      placeholder="25"
                      placeholderTextColor={colors.text.tertiary}
                      keyboardType="numeric"
                  />
                </View>
                <View style={{ flex: 1, marginLeft: 8 }}>
                  <Text style={[styles.label, dynamicStyles.label]}>{t('auth.phone', 'Phone (Optional)')}</Text>
                  <TextInput 
                      style={[styles.input, dynamicStyles.input]}
                      value={phoneNumber}
                      onChangeText={setPhoneNumber}
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
                      region === opt.value && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT }
                    ]}
                    onPress={() => setRegion(opt.value)}
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
              <div style={styles.optionsWrap}>
                {vehicleOptions.map((opt) => (
                  <TouchableOpacity
                    key={opt}
                    style={[
                      styles.optionChip,
                      { borderColor: colors.border },
                      vehicleType === opt && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT }
                    ]}
                    onPress={() => setVehicleType(opt)}
                  >
                    <Text style={[
                      styles.optionText,
                      { color: colors.text.secondary },
                      vehicleType === opt && { color: '#000', fontFamily: typography.fonts.bold }
                    ]}>{opt}</Text>
                  </TouchableOpacity>
                ))}
              </div>

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
