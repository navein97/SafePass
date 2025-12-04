import React from 'react';
import { StyleSheet, View, ViewStyle, StyleProp, Image } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { colors } from '../../theme/colors';

interface GradientBackgroundProps {
  children: React.ReactNode;
  style?: StyleProp<ViewStyle>;
}

export const GradientBackground: React.FC<GradientBackgroundProps> = ({ children, style }) => {
  return (
    <View style={[styles.container, style]}>
      <LinearGradient
        colors={['#1a1a1a', '#000000']}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={StyleSheet.absoluteFill}
      />
      
      <Image 
        source={require('../../../assets/logistics-bg.png')} 
        style={[StyleSheet.absoluteFill, { opacity: 0.15, width: '100%', height: '100%' }]}
        resizeMode="cover"
      />

      {/* Ambient Glow Effects */}
      <LinearGradient
        colors={[colors.primary.dark, 'transparent']}
        start={{ x: 0, y: 0 }}
        end={{ x: 0.8, y: 0.8 }}
        style={[StyleSheet.absoluteFill, { opacity: 0.2 }]}
      />
      <LinearGradient
        colors={[colors.secondary.dark, 'transparent']}
        start={{ x: 1, y: 1 }}
        end={{ x: 0.2, y: 0.2 }}
        style={[StyleSheet.absoluteFill, { opacity: 0.15 }]}
      />
      {children}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
});

