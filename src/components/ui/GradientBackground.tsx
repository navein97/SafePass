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
    <View style={[
        styles.container, 
        { backgroundColor: theme === 'light' ? '#F7F8FA' : colors.background.default }, 
        style
    ]}>
      {children}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

