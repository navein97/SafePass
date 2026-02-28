import React from 'react';
import { View, StyleSheet, ViewStyle, StyleProp } from 'react-native';
import { BlurView } from 'expo-blur';
import { useTheme } from '../../context/ThemeContext';

interface GlassCardProps {
  children: React.ReactNode;
  style?: StyleProp<ViewStyle>;
  contentStyle?: StyleProp<ViewStyle>;
  noPadding?: boolean;
}

export const GlassCard: React.FC<GlassCardProps> = ({ 
  children, 
  style, 
  contentStyle,
  noPadding = false
}) => {
  const { colors, theme } = useTheme();

  return (
    <View style={[
      styles.container, 
      { 
        backgroundColor: theme === 'light' ? '#FFFFFF' : colors.background.card,
        borderColor: theme === 'dark' ? colors.border : 'transparent',
      }, 
      theme === 'light' && styles.shadow,
      style
    ]}>
      <View style={[
        styles.content,
        noPadding && { padding: 0 },
        contentStyle
      ]}>
        {children}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    borderRadius: 20,
    borderWidth: 1,
  },
  shadow: {
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 4,
    },
    shadowOpacity: 0.1,
    shadowRadius: 10,
    elevation: 8,
  },
  content: {
    padding: 20,
    position: 'relative',
    zIndex: 1,
  },
});
