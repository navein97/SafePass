import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TextInput, Modal, Alert, ScrollView, TouchableOpacity, Image, ActivityIndicator } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { X, Upload, Image as ImageIcon } from 'lucide-react-native';
import { CompanySettingsService } from '../services/companySettingsService';
import * as ImagePicker from 'expo-image-picker';

interface CompanySettingsModalProps {
  visible: boolean;
  onClose: () => void;
}

export const CompanySettingsModal: React.FC<CompanySettingsModalProps> = ({ visible, onClose }) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  const [loading, setLoading] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [companyName, setCompanyName] = useState('');
  const [logoUrl, setLogoUrl] = useState('');
  const [selectedImage, setSelectedImage] = useState<string | null>(null);

  // Load existing settings
  useEffect(() => {
    if (visible) {
        loadSettings();
    }
  }, [visible]);

  const loadSettings = async () => {
    try {
        const info = await CompanySettingsService.getCompanyInfo();
        if (info.name) setCompanyName(info.name);
        if (info.logo_url) {
            setLogoUrl(info.logo_url);
            setSelectedImage(info.logo_url);
        }
    } catch (e) {
        console.error('Failed to load company settings', e);
    }
  };

  const pickImage = async () => {
    const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
    
    if (status !== 'granted') {
      Alert.alert(t('common.error'), 'Permission to access gallery is required.');
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ['images'],
      allowsEditing: true,
      aspect: [1, 1],
      quality: 0.8,
    });

    if (!result.canceled) {
      setSelectedImage(result.assets[0].uri);
    }
  };

  const handleSave = async () => {
    if (!companyName.trim()) {
      Alert.alert(t('common.error'), 'Company name is required');
      return;
    }

    try {
        setLoading(true);
        let finalLogoUrl = logoUrl;

        // If a new image was picked (local URI), upload it first
        if (selectedImage && selectedImage !== logoUrl) {
            setUploading(true);
            const { url, error: uploadError } = await CompanySettingsService.uploadCompanyLogo(selectedImage);
            setUploading(false);
            
            if (uploadError) {
              // If bucket doesn't exist or RLS issue
              if (uploadError.message?.includes('bucket')) {
                throw new Error('Storage bucket "company-assets" not found. Please contact administrator to create it.');
              }
              throw uploadError;
            }
            if (url) finalLogoUrl = url;
        }

        const { success, error } = await CompanySettingsService.updateCompanyInfo({
            name: companyName,
            logo_url: finalLogoUrl || null
        });
        
        if (!success) throw error;
        
        Alert.alert(t('common.success'), t('company.updateSuccess'));
        onClose();
    } catch (error: any) {
        console.error('Save error:', error);
        Alert.alert(t('common.error'), error.message || t('company.updateError'));
    } finally {
        setLoading(false);
        setUploading(false);
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
        <ScrollView 
          contentContainerStyle={styles.scrollContainer}
          showsVerticalScrollIndicator={false}
          bounces={true}
          keyboardShouldPersistTaps="handled"
        >
          <GlassCard style={styles.modalContent}>
              <View style={styles.header}>
                  <Text style={[styles.title, dynamicStyles.title]}>{t('company.settings')}</Text>
                  <TouchableOpacity 
                      onPress={onClose} 
                      style={styles.closeButton}
                      activeOpacity={0.7}
                  >
                      <X size={20} color={colors.text.primary} />
                  </TouchableOpacity>
              </View>

              <Text style={[styles.label, dynamicStyles.label]}>{t('company.name')}</Text>
              <TextInput 
                  style={[styles.input, dynamicStyles.input]}
                  value={companyName}
                  onChangeText={setCompanyName}
                  placeholder={t('company.namePlaceholder')}
                  placeholderTextColor={colors.text.tertiary}
              />

              <Text style={[styles.label, dynamicStyles.label]}>{t('company.logo')}</Text>
              
              {/* Image Picker UI */}
              <TouchableOpacity 
                style={[styles.imagePicker, { borderColor: colors.border }]}
                onPress={pickImage}
                activeOpacity={0.7}
              >
                {selectedImage ? (
                  <View style={styles.imagePreviewContainer}>
                    <Image source={{ uri: selectedImage }} style={styles.imagePreview} />
                    <View style={styles.changeImageOverlay}>
                      <Upload size={20} color="#FFF" />
                      <Text style={styles.changeImageText}>Change</Text>
                    </View>
                  </View>
                ) : (
                  <View style={styles.placeholderContainer}>
                    <ImageIcon size={40} color={colors.text.tertiary} />
                    <Text style={[styles.placeholderText, { color: colors.text.secondary }]}>
                      Tap to select company logo
                    </Text>
                  </View>
                )}
              </TouchableOpacity>
              
              <Text style={[styles.helperText, dynamicStyles.helperText]}>
                  {t('company.helperText')}
              </Text>

              <View style={{ marginTop: 24, marginBottom: 10 }}>
                  <GlassButton 
                      title={loading ? (uploading ? 'Uploading Logo...' : t('company.saving')) : t('company.saveSettings')}
                      onPress={handleSave}
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
  imagePicker: {
    width: '100%',
    height: 200,
    borderRadius: 12,
    borderWidth: 1,
    borderStyle: 'dashed',
    overflow: 'hidden',
    backgroundColor: 'rgba(255,255,255,0.05)',
  },
  placeholderContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  placeholderText: {
    marginTop: 12,
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    textAlign: 'center',
  },
  imagePreviewContainer: {
    flex: 1,
    width: '100%',
    height: '100%',
  },
  imagePreview: {
    width: '100%',
    height: '100%',
    resizeMode: 'contain',
  },
  changeImageOverlay: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    backgroundColor: 'rgba(0,0,0,0.6)',
    paddingVertical: 8,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    gap: 8,
  },
  changeImageText: {
    color: '#FFF',
    fontSize: 12,
    fontFamily: typography.fonts.bold,
  },
  helperText: {
    fontSize: 12,
    marginTop: 16,
    fontStyle: 'italic',
  },
});
