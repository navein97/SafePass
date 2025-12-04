import React from 'react';
import { View, StyleSheet, ViewStyle, StyleProp } from 'react-native';
import { BlurView } from 'expo-blur';
import { colors } from '../../theme/colors';

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
  return (
    <View style={[styles.container, style]}>
      <BlurView intensity={intensity} tint="dark" style={StyleSheet.absoluteFill} />
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
    backgroundColor: colors.background.glass,
    borderColor: colors.background.glassBorder,
    borderWidth: 1,
  },
  content: {
    padding: 20,
  },
});
