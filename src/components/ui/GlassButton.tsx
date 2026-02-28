import React from 'react';
import { TouchableOpacity, Text, StyleSheet, ActivityIndicator, ViewStyle, TextStyle, StyleProp, View } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { useTheme } from '../../context/ThemeContext';

interface GlassButtonProps {
  onPress: () => void;
  title: string;
  variant?: 'primary' | 'secondary' | 'danger' | 'outline';
  loading?: boolean;
  disabled?: boolean;
  style?: StyleProp<ViewStyle>;
  textStyle?: TextStyle;
  icon?: React.ReactNode;
}

export const GlassButton: React.FC<GlassButtonProps> = ({
  onPress,
  title,
  variant = 'primary',
  loading = false,
  disabled = false,
  style,
  textStyle,
  icon,
}) => {
  const { colors, theme } = useTheme();

  const getGradientColors = () => {
    if (disabled) return ['#3A3A3C', '#2C2C2E'];
    
    switch (variant) {
      case 'primary':
        return colors.gradients.primary;
      case 'danger':
        return colors.gradients.danger;
      case 'secondary':
        return theme === 'light' ? ['#E5E5EA', '#D1D1D6'] : ['#3A3A3C', '#2C2C2E']; // Light gray for light mode, Dark gray for dark mode
      case 'outline':
        // Use fully transparent white to avoid Android black artifact issues
        return ['rgba(255, 255, 255, 0)', 'rgba(255, 255, 255, 0)'] as const;
      default:
        return colors.gradients.primary;
    }
  };

  const getTextColor = () => {
    if (disabled) return colors.text.tertiary;
    if (variant === 'outline') {
        // Darker gold/primary for visibility on light backgrounds
        return theme === 'light' ? colors.primary.dark : colors.primary.DEFAULT;
    }
    if (variant === 'secondary') {
        return theme === 'light' ? colors.text.secondary : colors.text.primary;
    }
    return colors.text.inverse;
  };

  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.8}
      style={[
        styles.container,
        !disabled && variant !== 'outline' && styles.shadowStyle,
        variant === 'outline' && styles.outlineContainer,
        variant === 'outline' && { borderColor: colors.primary.DEFAULT },
        style
      ]}
    >
      <LinearGradient
        colors={getGradientColors() as any}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 0 }}
        style={[
            styles.gradient, 
            !!title && styles.gradientPadding,
            variant === 'outline' && styles.outlineGradient
        ]}
      >
        {loading ? (
          <ActivityIndicator color={getTextColor()} />
        ) : (
          <>
            {icon && <>{icon}</>}
            <Text style={[styles.text, { color: getTextColor() }, textStyle]}>
              {title}
            </Text>
          </>
        )}
      </LinearGradient>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  shadowStyle: {
    shadowColor: '#E1257C', // Use primary pink for a vibrant glow
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.35,
    shadowRadius: 12,
    elevation: 8,
  },
  container: {
    borderRadius: 12,
    height: 50,
    backgroundColor: 'transparent',
  },
  outlineContainer: {
    borderWidth: 1,
    // colors is not available here, so we use a style prop injection or move this style to dynamic styles
    // Simpler: use the color prop in the component render
    borderColor: '#E1257C', // Default pink, overwritten dynamically if needed? No, 'outline' variant expects border.
    shadowOpacity: 0,
    elevation: 0,
  },
  gradient: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 10,
    borderRadius: 12, // Added here to crop gradient without overflow:hidden on parent
  },
  gradientPadding: {
    paddingHorizontal: 20,
  },
  outlineGradient: {
    backgroundColor: 'transparent',
  },
  text: {
    fontSize: 16,
    fontWeight: '600',
    letterSpacing: 0.5,
  },
});
