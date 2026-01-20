import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TextInput, Modal, Alert, ScrollView, TouchableOpacity } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { X } from 'lucide-react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface CompanySettingsModalProps {
  visible: boolean;
  onClose: () => void;
}

export const CompanySettingsModal: React.FC<CompanySettingsModalProps> = ({ visible, onClose }) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  const [loading, setLoading] = useState(false);
  const [companyName, setCompanyName] = useState('');
  const [logoUrl, setLogoUrl] = useState('');

  // Load existing settings
  useEffect(() => {
    if (visible) {
        loadSettings();
    }
  }, [visible]);

  const loadSettings = async () => {
    try {
        const savedName = await AsyncStorage.getItem('COMPANY_NAME');
        const savedLogo = await AsyncStorage.getItem('COMPANY_LOGO');
        if (savedName) setCompanyName(savedName);
        if (savedLogo) setLogoUrl(savedLogo);
    } catch (e) {
        console.error('Failed to load company settings', e);
    }
  };

  const handleSave = async () => {
    try {
        setLoading(true);
        // Save to AsyncStorage (simulating backend company config)
        await AsyncStorage.setItem('COMPANY_NAME', companyName);
        await AsyncStorage.setItem('COMPANY_LOGO', logoUrl);
        
        // Simulating API delay
        await new Promise(resolve => setTimeout(resolve, 800));
        
        Alert.alert('Success', 'Company settings updated!');
        onClose();
    } catch (error: any) {
        Alert.alert('Error', 'Failed to save settings');
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
    helperText: { color: colors.text.tertiary }
  };

  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <View style={styles.modalOverlay}>
        <View style={styles.modalContainer}>
          <GlassCard style={styles.modalContent}>
            <View style={styles.header}>
                <Text style={[styles.title, dynamicStyles.title]}>{t('company.settings', 'Company Settings')}</Text>
                <TouchableOpacity 
                    onPress={onClose} 
                    style={styles.closeButton}
                    activeOpacity={0.7}
                >
                    <X size={20} color={colors.text.primary} />
                </TouchableOpacity>
            </View>

            <ScrollView 
                style={styles.scrollView}
                showsVerticalScrollIndicator={false}
                contentContainerStyle={styles.scrollContent}
                bounces={true}
            >
                <Text style={[styles.label, dynamicStyles.label]}>{t('company.name', 'Company Name')}</Text>
                <TextInput 
                    style={[styles.input, dynamicStyles.input]}
                    value={companyName}
                    onChangeText={setCompanyName}
                    placeholder="E.g. SafePass Logistics"
                    placeholderTextColor={colors.text.tertiary}
                />

                <Text style={[styles.label, dynamicStyles.label]}>{t('company.logo', 'Logo URL (Optional)')}</Text>
                <TextInput 
                    style={[styles.input, dynamicStyles.input]}
                    value={logoUrl}
                    onChangeText={setLogoUrl}
                    placeholder="https://example.com/logo.png"
                    placeholderTextColor={colors.text.tertiary}
                    autoCapitalize="none"
                />
                
                <Text style={[styles.helperText, dynamicStyles.helperText]}>
                    This name and logo will appear on the dashboard for all your drivers.
                </Text>

                <View style={{ marginTop: 24, marginBottom: 20 }}>
                    <GlassButton 
                        title={loading ? 'Saving...' : 'Save Settings'}
                        onPress={handleSave}
                        variant="primary"
                        disabled={loading}
                    />
                </View>
            </ScrollView>
          </GlassCard>
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.7)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  modalContainer: {
    width: '100%',
    maxWidth: 500,
    maxHeight: '70%',
  },
  modalContent: {
    flex: 1,
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
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingBottom: 20,
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
