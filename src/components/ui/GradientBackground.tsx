import React from 'react';
import { StyleSheet, View, ViewStyle, StyleProp, Image } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { useTheme } from '../../context/ThemeContext';

interface GradientBackgroundProps {
  children: React.ReactNode;
  style?: StyleProp<ViewStyle>;
}

export const GradientBackground: React.FC<GradientBackgroundProps> = ({ children, style }) => {
  const { colors, theme } = useTheme();

  return (
    <View style={[styles.container, { backgroundColor: colors.background.default }, style]}>
      <LinearGradient
        colors={colors.gradients.background as any}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={StyleSheet.absoluteFill}
      />
      
      {/* Background Image - reduced opacity in light mode for better readability */}
      <Image 
        source={require('../../../assets/logistics-bg.jpg')} 
        style={[StyleSheet.absoluteFill, { opacity: theme === 'dark' ? 0.15 : 0.05, width: '100%', height: '100%' }]}
        resizeMode="cover"
      />

      {/* Ambient Glow Effects */}
      <LinearGradient
        colors={[colors.primary.dark, 'transparent']}
        start={{ x: 0, y: 0 }}
        end={{ x: 0.8, y: 0.8 }}
        style={[StyleSheet.absoluteFill, { opacity: theme === 'dark' ? 0.2 : 0.1 }]}
      />
      <LinearGradient
        colors={[colors.secondary.dark, 'transparent']}
        start={{ x: 1, y: 1 }}
        end={{ x: 0.2, y: 0.2 }}
        style={[StyleSheet.absoluteFill, { opacity: theme === 'dark' ? 0.15 : 0.05 }]}
      />
      {children}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

