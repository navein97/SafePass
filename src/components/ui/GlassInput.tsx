import React from 'react';
import { TextInput, View, StyleSheet, Text, TextInputProps, ViewStyle } from 'react-native';
import { BlurView } from 'expo-blur';
import { colors } from '../../theme/colors';

interface GlassInputProps extends TextInputProps {
  label?: string;
  error?: string;
  containerStyle?: ViewStyle;
  leftIcon?: React.ReactNode;
  rightIcon?: React.ReactNode;
}

export const GlassInput: React.FC<GlassInputProps> = ({
  label,
  error,
  containerStyle,
  leftIcon,
  rightIcon,
  style,
  ...props
}) => {
  return (
    <View style={[styles.container, containerStyle]}>
      {label && <Text style={styles.label}>{label}</Text>}
      <View style={styles.inputWrapper}>
        <BlurView intensity={10} tint="dark" style={StyleSheet.absoluteFill} />
        <View style={styles.contentContainer}>
          {leftIcon && <View style={styles.iconLeft}>{leftIcon}</View>}
          <TextInput
            style={[
              styles.input, 
              leftIcon ? styles.inputWithLeftIcon : undefined, 
              rightIcon ? styles.inputWithRightIcon : undefined, 
              style
            ]}
            placeholderTextColor={colors.text.tertiary}
            selectionColor={colors.primary.DEFAULT}
            {...props}
          />
          {rightIcon && <View style={styles.iconRight}>{rightIcon}</View>}
        </View>
      </View>
      {error && <Text style={styles.error}>{error}</Text>}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginBottom: 16,
  },
  label: {
    color: colors.text.secondary,
    fontSize: 14,
    marginBottom: 8,
    fontWeight: '500',
    marginLeft: 4,
  },
  inputWrapper: {
    borderRadius: 12,
    overflow: 'hidden',
    backgroundColor: colors.background.glass,
    borderColor: colors.background.glassBorder,
    borderWidth: 1,
    height: 50,
  },
  contentContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
  },
  input: {
    flex: 1,
    color: colors.text.primary,
    fontSize: 16,
    paddingHorizontal: 16,
    height: '100%',
  },
  inputWithLeftIcon: {
    paddingLeft: 48,
  },
  inputWithRightIcon: {
    paddingRight: 48,
  },
  iconLeft: {
    position: 'absolute',
    left: 16,
    zIndex: 1,
  },
  iconRight: {
    position: 'absolute',
    right: 16,
    zIndex: 1,
  },
  error: {
    color: colors.status.danger,
    fontSize: 12,
    marginTop: 4,
    marginLeft: 4,
  },
});
