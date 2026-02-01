import React from 'react';
import { TextInput, View, StyleSheet, Text, TextInputProps, ViewStyle } from 'react-native';
import { BlurView } from 'expo-blur';
import { useTheme } from '../../context/ThemeContext';

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
  const { colors } = useTheme();

  return (
    <View style={[styles.container, containerStyle]}>
      {label ? <Text style={[styles.label, { color: colors.text.secondary }]}>{label}</Text> : null}
      <View style={[
        styles.inputWrapper, 
        { 
          backgroundColor: colors.background.glass,
          borderColor: colors.background.glassBorder 
        }
      ]}>
        <BlurView intensity={10} tint="dark" style={StyleSheet.absoluteFill} />
        <View style={styles.contentContainer}>
          {leftIcon ? <View style={styles.iconLeft}>{leftIcon}</View> : null}
          <TextInput
            style={[
              styles.input, 
              { color: colors.text.primary },
              leftIcon ? styles.inputWithLeftIcon : undefined, 
              rightIcon ? styles.inputWithRightIcon : undefined, 
              style
            ]}
            placeholderTextColor={colors.text.tertiary}
            selectionColor={colors.primary.DEFAULT}
            {...props}
          />
          {rightIcon ? <View style={styles.iconRight}>{rightIcon}</View> : null}
        </View>
      </View>
      {error ? <Text style={[styles.error, { color: colors.status.danger }]}>{error}</Text> : null}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginBottom: 16,
  },
  label: {
    fontSize: 14,
    marginBottom: 8,
    fontWeight: '500',
    marginLeft: 4,
  },
  inputWrapper: {
    borderRadius: 12,
    overflow: 'hidden',
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
    fontSize: 12,
    marginTop: 4,
    marginLeft: 4,
  },
});

