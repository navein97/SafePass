import React from 'react';
import { TouchableOpacity, Text, StyleSheet, ActivityIndicator, ViewStyle, TextStyle } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { colors } from '../../theme/colors';

interface GlassButtonProps {
  onPress: () => void;
  title: string;
  variant?: 'primary' | 'secondary' | 'danger' | 'outline';
  loading?: boolean;
  disabled?: boolean;
  style?: ViewStyle;
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
  const getGradientColors = () => {
    if (disabled) return ['#3A3A3C', '#2C2C2E'];
    
    switch (variant) {
      case 'primary':
        return colors.gradients.primary;
      case 'danger':
        return colors.gradients.danger;
      case 'secondary':
        return ['#3A3A3C', '#2C2C2E']; // Dark gray gradient
      case 'outline':
        return ['transparent', 'transparent'];
      default:
        return colors.gradients.primary;
    }
  };

  const getTextColor = () => {
    if (disabled) return colors.text.tertiary;
    if (variant === 'outline') return colors.primary.DEFAULT;
    return colors.text.primary;
  };

  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.8}
      style={[
        styles.container,
        variant === 'outline' && styles.outlineContainer,
        style
      ]}
    >
      <LinearGradient
        colors={getGradientColors()}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 0 }}
        style={[styles.gradient, variant === 'outline' && styles.outlineGradient]}
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
  container: {
    borderRadius: 12,
    overflow: 'hidden',
    height: 50,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 4,
    },
    shadowOpacity: 0.3,
    shadowRadius: 4.65,
    elevation: 8,
  },
  outlineContainer: {
    borderWidth: 1,
    borderColor: colors.primary.DEFAULT,
    shadowOpacity: 0,
    elevation: 0,
  },
  gradient: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingHorizontal: 20,
    gap: 10,
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
