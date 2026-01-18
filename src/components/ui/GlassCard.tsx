import React from 'react';
import { View, StyleSheet, ViewStyle, StyleProp } from 'react-native';
import { BlurView } from 'expo-blur';
import { useTheme } from '../../context/ThemeContext';

interface GlassCardProps {
  children: React.ReactNode;
  style?: StyleProp<ViewStyle>;
  intensity?: number;
}

export const GlassCard: React.FC<GlassCardProps> = ({ 
  children, 
  style, 
  intensity = 20 
}) => {
  const { colors, theme } = useTheme();

  return (
    <View style={[
      styles.container, 
      { 
        backgroundColor: colors.background.glass,
        borderColor: colors.background.glassBorder 
      }, 
      style
    ]}>
      <BlurView 
        intensity={intensity} 
        tint={theme === 'dark' ? 'dark' : 'light'} 
        style={StyleSheet.absoluteFill} 
      />
      <View style={styles.content}>
        {children}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    borderRadius: 20,
    overflow: 'hidden',
    borderWidth: 1,
  },
  content: {
    padding: 20,
  },
});
