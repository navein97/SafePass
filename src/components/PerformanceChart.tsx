import React from 'react';
import { View, Text, StyleSheet, Dimensions } from 'react-native';
import Svg, { Path, Circle, Line, Text as SvgText, Defs, LinearGradient, Stop } from 'react-native-svg';
import { useTheme } from '../context/ThemeContext';

interface DataPoint {
  value: number; // 0-100
  label: string; // e.g. "W1", "W2"
}

interface PerformanceChartProps {
  data: DataPoint[];
  height?: number;
  width?: number;
}

import { typography } from '../theme/typography';
import { useTranslation } from 'react-i18next';

export const PerformanceChart = ({ data, height = 200, width }: PerformanceChartProps) => {
  const { t } = useTranslation(); // Hook
  const { colors } = useTheme();
  const screenWidth = width || Dimensions.get('window').width - 40;
  
  if (!data || data.length === 0) {
      return (
          <View style={[styles.container, { height, width: screenWidth, justifyContent: 'center', alignItems: 'center' }]}>
              <Text style={{ color: colors.text.secondary }}>{t('common.noData') || 'No data available yet'}</Text>
          </View>
      );
  }

  // If only one point, add a 'zero' start point to make a line
  const chartData = data.length === 1 
    ? [{ value: 0, label: '0%' }, ...data]
    : data;

  // Chart Config - Increased horizontal padding to prevent cutoff
  const hPadding = 45; 
  const vPadding = 30;
  const chartHeight = height - vPadding * 2;
  const chartWidth = screenWidth - hPadding * 2;
  const maxValue = 100;
  
  // Helper to map coordinates
  const getX = (index: number) => {
    return hPadding + (index * (chartWidth / (chartData.length - 1)));
  };
  const getY = (value: number) => height - vPadding - ((value / maxValue) * chartHeight);

  // Generate Path
  let d = `M ${getX(0)} ${getY(chartData[0].value)}`;
  if (chartData.length > 1) {
    chartData.slice(1).forEach((point, i) => {
        d += ` L ${getX(i + 1)} ${getY(point.value)}`;
    });
  }

  // Generate Area Path (close the loop for gradient fill)
  const dArea = `${d} L ${getX(chartData.length - 1)} ${height - vPadding} L ${getX(0)} ${height - vPadding} Z`;

  return (
    <View style={[styles.container, { width: screenWidth }]}>
      <Text style={[styles.title, { color: colors.text.primary }]}>{t('profile.performanceTrend')}</Text>
      <Svg height={height} width={screenWidth}>
        <Defs>
          <LinearGradient id="gradient" x1="0" y1="0" x2="0" y2="1">
            <Stop offset="0" stopColor={colors.primary.DEFAULT} stopOpacity="0.5" />
            <Stop offset="1" stopColor={colors.primary.DEFAULT} stopOpacity="0.0" />
          </LinearGradient>
        </Defs>

        {/* Grid Lines */}
        {[0, 25, 50, 75, 100].map((val) => (
            <Line 
                key={val}
                x1={hPadding}
                y1={getY(val)}
                x2={screenWidth - hPadding}
                y2={getY(val)}
                stroke={colors.border}
                strokeWidth="1"
                strokeDasharray="4 4"
            />
        ))}

        {/* Area Fill */}
        <Path d={dArea} fill="url(#gradient)" />

        {/* Line */}
        <Path 
          d={d} 
          stroke={colors.primary.DEFAULT} 
          strokeWidth="3" 
          fill="none" 
          strokeLinecap="round" 
          strokeLinejoin="round" 
        />

        {/* Data Points - Only end points and current for beauty */}
        {chartData.map((point, index) => (
            <React.Fragment key={index}>
                <Circle 
                    cx={getX(index)} 
                    cy={getY(point.value)} 
                    r="4" 
                    fill="#FFF" 
                    stroke={colors.primary.DEFAULT} 
                    strokeWidth="2" 
                />
                
                {/* Score Label above point */}
                <SvgText
                    x={getX(index)}
                    y={getY(point.value) - 10}
                    fontSize="10"
                    fontFamily={typography.fonts.bold}
                    fill={colors.text.primary}
                    textAnchor="middle"
                >
                    {point.value}%
                </SvgText>

                {/* X-Axis Labels */}
                <SvgText
                    x={getX(index)}
                    y={height - 2}
                    fontSize="10"
                    fontFamily={typography.fonts.medium}
                    fill={colors.text.secondary}
                    textAnchor="middle"
                >
                    {point.label}
                </SvgText>
            </React.Fragment>
        ))}
      </Svg>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingVertical: 16,
    alignItems: 'center',
  },
  title: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    fontWeight: 'bold',
    marginBottom: 8,
    alignSelf: 'flex-start',
    marginLeft: 15,
  }
});
