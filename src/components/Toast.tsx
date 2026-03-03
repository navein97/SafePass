import React, { useEffect, useRef } from 'react';
import { Animated, Text, StyleSheet, Platform } from 'react-native';
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

  const getColors = () => {
    switch (type) {
      case 'success':
        return {
          bg: 'rgba(34, 197, 94, 0.88)',
          border: '#16a34a',
          text: '#FFFFFF',
        };
      case 'error':
        return {
          bg: 'rgba(220, 38, 38, 0.88)',
          border: '#b91c1c',
          text: '#FFFFFF',
        };
      default:
        return {
          bg: 'rgba(59, 130, 246, 0.88)',
          border: '#1d4ed8',
          text: '#FFFFFF',
        };
    }
  };

  const { bg, border, text } = getColors();

  return (
    <Animated.View
      style={[
        styles.container,
        {
          opacity,
          transform: [{ translateY }],
          borderColor: border,
          backgroundColor: bg,
        },
      ]}
    >
      <Text style={[styles.message, { color: text }]}>{message}</Text>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    top: 60,
    left: 20,
    right: 20,
    padding: 18,
    borderRadius: 18,
    borderWidth: 2,
    overflow: 'hidden',
    zIndex: 9999,
    alignItems: 'center',
    justifyContent: 'center',
    // Shadow for extra pop
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 4 },
        shadowOpacity: 0.35,
        shadowRadius: 10,
      },
      android: {
        elevation: 10,
      },
    }),
  },
  message: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.bold,
    textAlign: 'center',
    letterSpacing: 0.2,
  },
});

