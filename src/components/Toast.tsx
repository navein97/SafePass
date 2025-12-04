import React, { useEffect, useRef } from 'react';
import { Animated, Text, StyleSheet, View } from 'react-native';
import { BlurView } from 'expo-blur';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';

interface ToastProps {
  message: string;
  visible: boolean;
  duration?: number;
  type?: 'success' | 'error' | 'info';
  onHide?: () => void;
}

export const Toast: React.FC<ToastProps> = ({
  message,
  visible,
  duration = 4000,
  type = 'success',
  onHide,
}) => {
  const opacity = useRef(new Animated.Value(0)).current;
  const translateY = useRef(new Animated.Value(-100)).current;

  useEffect(() => {
    if (visible) {
      // Slide in and fade in
      Animated.parallel([
        Animated.timing(opacity, {
          toValue: 1,
          duration: 300,
          useNativeDriver: true,
        }),
        Animated.timing(translateY, {
          toValue: 0,
          duration: 300,
          useNativeDriver: true,
        }),
      ]).start();

      // Auto hide after duration
      const timer = setTimeout(() => {
        hideToast();
      }, duration);

      return () => clearTimeout(timer);
    }
  }, [visible]);

  const hideToast = () => {
    Animated.parallel([
      Animated.timing(opacity, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true,
      }),
      Animated.timing(translateY, {
        toValue: -100,
        duration: 300,
        useNativeDriver: true,
      }),
    ]).start(() => {
      if (onHide) onHide();
    });
  };

  if (!visible) return null;

  const getBorderColor = () => {
    switch (type) {
      case 'success': return colors.status.success;
      case 'error': return colors.status.danger;
      default: return colors.primary.DEFAULT;
    }
  };

  const getBackgroundColor = () => {
    switch (type) {
      case 'success': return 'rgba(52, 199, 89, 0.2)';
      case 'error': return 'rgba(255, 59, 48, 0.2)';
      default: return 'rgba(0, 122, 255, 0.2)';
    }
  };

  return (
    <Animated.View
      style={[
        styles.container,
        {
          opacity,
          transform: [{ translateY }],
          borderColor: getBorderColor(),
          backgroundColor: getBackgroundColor(),
        },
      ]}
    >
      <BlurView intensity={20} tint="dark" style={StyleSheet.absoluteFill} />
      <Text style={styles.message}>{message}</Text>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    top: 60,
    left: 20,
    right: 20,
    padding: 16,
    borderRadius: 16,
    borderWidth: 1,
    overflow: 'hidden',
    zIndex: 9999,
    alignItems: 'center',
    justifyContent: 'center',
  },
  message: {
    color: colors.text.primary,
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.medium,
    textAlign: 'center',
  },
});

