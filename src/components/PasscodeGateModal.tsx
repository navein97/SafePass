import React, { useState } from 'react';
import {
  Modal,
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
  Platform,
  KeyboardAvoidingView
} from 'react-native';
import { Lock, ShieldCheck, KeyRound, AlertCircle } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { PasscodeService } from '../services/passcodeService';
import { GlassCard } from './ui/GlassCard';
import { GlassButton } from './ui/GlassButton';

interface PasscodeGateModalProps {
  visible: boolean;
  onUnlocked: () => void;
  onCancel?: () => void;
  title?: string;
  subtitle?: string;
}

export const PasscodeGateModal: React.FC<PasscodeGateModalProps> = ({
  visible,
  onUnlocked,
  onCancel,
  title = 'Restricted Access',
  subtitle = 'Please enter the access passcode to continue.',
}) => {
  const { colors } = useTheme();
  const [passcode, setPasscode] = useState('');
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');

  const handleVerify = async () => {
    if (!passcode.trim()) {
      setErrorMsg('Please enter a passcode');
      return;
    }

    setLoading(true);
    setErrorMsg('');

    try {
      const isValid = await PasscodeService.verifyPasscode(passcode);
      setLoading(false);

      if (isValid) {
        setPasscode('');
        onUnlocked();
      } else {
        setErrorMsg('Invalid passcode. Access denied.');
      }
    } catch (err) {
      setLoading(false);
      setErrorMsg('An error occurred during passcode verification.');
    }
  };

  return (
    <Modal
      visible={visible}
      animationType="fade"
      transparent={true}
      onRequestClose={() => {
        if (onCancel) onCancel();
      }}
    >
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
        style={styles.overlay}
      >
        <View style={styles.backdrop} />

        <GlassCard style={styles.cardContainer}>
          <View style={styles.iconWrapper}>
            <KeyRound color={colors.primary.DEFAULT} size={36} />
          </View>

          <Text style={[styles.title, { color: colors.text.primary }]}>{title}</Text>
          <Text style={[styles.subtitle, { color: colors.text.secondary }]}>{subtitle}</Text>

          <View style={[styles.inputContainer, { borderColor: errorMsg ? colors.status.danger : colors.border }]}>
            <Lock color={colors.text.tertiary} size={20} style={styles.lockIcon} />
            <TextInput
              style={[styles.input, { color: colors.text.primary }]}
              placeholder="Enter passcode"
              placeholderTextColor={colors.text.tertiary}
              secureTextEntry={true}
              keyboardType="number-pad"
              value={passcode}
              onChangeText={(txt) => {
                setPasscode(txt);
                if (errorMsg) setErrorMsg('');
              }}
              onSubmitEditing={handleVerify}
              autoFocus={true}
            />
          </View>

          {Boolean(errorMsg) && (
            <View style={styles.errorRow}>
              <AlertCircle size={16} color={colors.status.danger} />
              <Text style={[styles.errorText, { color: colors.status.danger }]}>{errorMsg}</Text>
            </View>
          )}

          <View style={styles.buttonRow}>
            {onCancel && (
              <TouchableOpacity
                style={[styles.cancelBtn, { borderColor: colors.border }]}
                onPress={onCancel}
                disabled={loading}
              >
                <Text style={[styles.cancelText, { color: colors.text.secondary }]}>Cancel</Text>
              </TouchableOpacity>
            )}

            <GlassButton
              title={loading ? 'Verifying...' : 'Unlock'}
              onPress={handleVerify}
              variant="primary"
              loading={loading}
              style={{ flex: 1 }}
            />
          </View>
        </GlassCard>
      </KeyboardAvoidingView>
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
  backdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: 'rgba(0, 0, 0, 0.75)',
  },
  cardContainer: {
    width: '100%',
    maxWidth: 420,
    padding: 28,
    borderRadius: 20,
    alignItems: 'center',
  },
  iconWrapper: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: 'rgba(59, 130, 246, 0.15)',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  title: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
    textAlign: 'center',
    marginBottom: 8,
  },
  subtitle: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.regular,
    textAlign: 'center',
    marginBottom: 24,
    paddingHorizontal: 10,
  },
  inputContainer: {
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    borderWidth: 1.5,
    borderRadius: 12,
    paddingHorizontal: 14,
    height: 52,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
    marginBottom: 12,
  },
  lockIcon: {
    marginRight: 10,
  },
  input: {
    flex: 1,
    fontSize: 16,
    letterSpacing: 2,
    fontWeight: '600',
    fontFamily: typography.fonts.medium,
  },
  errorRow: {
    flexDirection: 'row',
    alignItems: 'center',
    alignSelf: 'flex-start',
    marginBottom: 14,
    gap: 6,
  },
  errorText: {
    fontSize: 13,
    fontFamily: typography.fonts.regular,
  },
  buttonRow: {
    flexDirection: 'row',
    width: '100%',
    gap: 12,
    marginTop: 8,
  },
  cancelBtn: {
    paddingHorizontal: 20,
    height: 48,
    borderRadius: 12,
    borderWidth: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  cancelText: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    fontWeight: '600',
  },
});
