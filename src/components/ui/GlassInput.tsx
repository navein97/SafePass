import React, { useState } from 'react';
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
  const { colors, theme } = useTheme();
  const [isFocused, setIsFocused] = useState(false);

  // Background and border handling for input wrapper
  const wrapperStyle = [
    styles.inputWrapper,
    {
      backgroundColor: theme === 'light' ? '#F5F5F5' : colors.background.glass,
      borderColor: 'transparent', // We'll handle border manually via wrapper
    }
  ];

  return (
    <View style={[styles.container, containerStyle]}>
      {label ? <Text style={[styles.label, { color: colors.text.secondary }]}>{label}</Text> : null}
      
      {/* Wrapper for border on focus */}
      <View style={[
        styles.gradientBorderWrapper, 
        isFocused 
          ? { padding: 2, backgroundColor: theme === 'light' ? '#000000' : colors.text.primary }
          : { padding: 1, backgroundColor: theme === 'dark' ? colors.border : '#E0E0E0' }
      ]}>
        <View style={wrapperStyle}>
          {theme === 'dark' && <BlurView intensity={10} tint="dark" style={StyleSheet.absoluteFill} />}
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
              selectionColor={theme === 'light' ? '#000000' : colors.text.primary}
              onFocus={(e) => {
                setIsFocused(true);
                props.onFocus?.(e);
              }}
              onBlur={(e) => {
                setIsFocused(false);
                props.onBlur?.(e);
              }}
              {...props}
            />
            {rightIcon ? <View style={styles.iconRight}>{rightIcon}</View> : null}
          </View>
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
    borderRadius: 10,
    overflow: 'hidden',
    height: '100%',
    width: '100%',
  },
  gradientBorderWrapper: {
    borderRadius: 12, // slightly larger to hold border
    height: 52,
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

