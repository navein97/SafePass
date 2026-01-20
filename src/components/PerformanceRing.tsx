import React, { useEffect, useRef } from 'react';
import { View, Text, Animated, StyleSheet, ViewStyle } from 'react-native';
import Svg, { Circle, G } from 'react-native-svg';

interface PerformanceRingProps {
  score: number; // 0 to 1
  label: string;
  subLabel?: string;
  size?: number;
  color?: string;
  strokeWidth?: number;
  style?: ViewStyle;
}

const AnimatedCircle = Animated.createAnimatedComponent(Circle);

export const PerformanceRing: React.FC<PerformanceRingProps> = ({
  score,
  label,
  subLabel,
  size = 120,
  color,
  strokeWidth = 10,
  style,
}) => {
  const radius = (size - strokeWidth) / 2;
  const circumference = radius * 2 * Math.PI;
  const animatedValue = useRef(new Animated.Value(0)).current;

  // Determine color based on score if not provided
  const ringColor = color || (score >= 0.75 ? '#10B981' : score >= 0.4 ? '#F59E0B' : '#EF4444');
  
  // Determine sublabel if not provided
  const displaySubLabel = subLabel || (score >= 0.75 ? 'High / Strong' : score >= 0.4 ? 'Medium' : 'Low / Issue');

  useEffect(() => {
    Animated.timing(animatedValue, {
      toValue: score,
      duration: 1500,
      useNativeDriver: true,
    }).start();
  }, [score]);

  const strokeDashoffset = animatedValue.interpolate({
    inputRange: [0, 1],
    outputRange: [circumference, 0],
  });

  return (
    <View style={[styles.container, { width: size, height: size + 40 }, style]}>
      <View style={{ width: size, height: size }}>
        <Svg width={size} height={size}>
          <G rotation="-90" origin={`${size / 2}, ${size / 2}`}>
            {/* Background Circle */}
            <Circle
              cx={size / 2}
              cy={size / 2}
              r={radius}
              stroke="#E5E7EB"
              strokeWidth={strokeWidth}
              fill="transparent"
            />
            {/* Progress Circle */}
            <AnimatedCircle
              cx={size / 2}
              cy={size / 2}
              r={radius}
              stroke={ringColor}
              strokeWidth={strokeWidth}
              strokeDasharray={circumference}
              strokeDashoffset={strokeDashoffset}
              strokeLinecap="round"
              fill="transparent"
            />
          </G>
        </Svg>
        <View style={styles.centerTextContainer}>
          <Text style={styles.scoreText}>{(score * 100).toFixed(0)}%</Text>
        </View>
      </View>
      <View style={styles.labelContainer}>
        <Text style={styles.labelText} numberOfLines={2}>{label}</Text>
        <Text style={[styles.subLabelText, { color: ringColor }]}>{displaySubLabel}</Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    margin: 8,
  },
  centerTextContainer: {
    ...StyleSheet.absoluteFillObject,
    justifyContent: 'center',
    alignItems: 'center',
  },
  scoreText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#1F2937',
  },
  labelContainer: {
    marginTop: 8,
    alignItems: 'center',
  },
  labelText: {
    fontSize: 12,
    fontWeight: '600',
    color: '#4B5563',
    textAlign: 'center',
  },
  subLabelText: {
    fontSize: 10,
    fontWeight: 'bold',
    marginTop: 2,
    textAlign: 'center',
  },
});
