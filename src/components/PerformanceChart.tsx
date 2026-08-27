import React, { useState, useEffect, useCallback, useMemo } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  TouchableOpacity,
  ActivityIndicator,
} from 'react-native';
import Svg, { Path, Circle, Line, Text as SvgText, Defs, LinearGradient, Stop, Rect } from 'react-native-svg';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { useTranslation } from 'react-i18next';
import {
  QuizService,
  PerformanceTimeRange,
  PerformanceTrendPoint,
  PerformanceStats,
} from '../services/quizService';

export interface PerformanceChartProps {
  data?: PerformanceTrendPoint[];
  userId?: string;
  height?: number;
  width?: number;
  allowedRanges?: PerformanceTimeRange[];
  initialRange?: PerformanceTimeRange;
  showMetrics?: boolean;
  title?: string;
  onRangeChange?: (range: PerformanceTimeRange) => void;
}

export const PerformanceChart: React.FC<PerformanceChartProps> = ({
  data: initialData,
  userId,
  height = 210,
  width,
  allowedRanges = ['1W', '1M', '3M', 'ALL'],
  initialRange = '1W',
  showMetrics = false,
  title,
  onRangeChange,
}) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const [measuredWidth, setMeasuredWidth] = useState<number>(0);
  const [selectedRange, setSelectedRange] = useState<PerformanceTimeRange>(
    allowedRanges.includes(initialRange) ? initialRange : allowedRanges[0] || '1W'
  );
  const [chartPoints, setChartPoints] = useState<PerformanceTrendPoint[]>(initialData || []);
  const [stats, setStats] = useState<PerformanceStats>({
    averageScore: 0,
    highestScore: 0,
    lowestScore: 0,
    totalAttempts: 0,
  });
  const [loading, setLoading] = useState<boolean>(false);
  const [selectedIndex, setSelectedIndex] = useState<number | null>(null);

  // In-memory cache for fast tab switching
  const cacheRef = React.useRef<Record<string, { points: PerformanceTrendPoint[]; stats: PerformanceStats }>>({});

  // Sync initialData if provided and on 1W
  useEffect(() => {
    if (initialData && initialData.length > 0 && selectedRange === '1W') {
      setChartPoints(initialData);
      calculateStatsFromPoints(initialData);
    }
  }, [initialData]);

  const calculateStatsFromPoints = (points: PerformanceTrendPoint[]) => {
    const nonZero = points.map(p => p.value).filter(v => v > 0);
    const avg = nonZero.length > 0 ? Math.round(nonZero.reduce((s, v) => s + v, 0) / nonZero.length) : 0;
    const high = nonZero.length > 0 ? Math.max(...nonZero) : 0;
    const low = nonZero.length > 0 ? Math.min(...nonZero) : 0;
    const attempts = points.reduce((s, p) => s + (p.attemptsCount || 0), 0);

    setStats({
      averageScore: avg,
      highestScore: high,
      lowestScore: low,
      totalAttempts: attempts,
    });
  };

  const fetchRangeData = useCallback(
    async (range: PerformanceTimeRange) => {
      if (!userId) {
        if (initialData && range === '1W') {
          setChartPoints(initialData);
          calculateStatsFromPoints(initialData);
        }
        return;
      }

      if (cacheRef.current[range]) {
        setChartPoints(cacheRef.current[range].points);
        setStats(cacheRef.current[range].stats);
        return;
      }

      setLoading(true);
      try {
        const result = await QuizService.getPerformanceTrends(userId, range);
        if (result && result.points) {
          cacheRef.current[range] = result;
          setChartPoints(result.points);
          setStats(result.stats);
        }
      } catch (err) {
        console.error('Failed to fetch performance trend for range:', range, err);
      } finally {
        setLoading(false);
      }
    },
    [userId, initialData]
  );

  const handleRangeSelect = (range: PerformanceTimeRange) => {
    if (range === selectedRange && !loading) return;
    setSelectedRange(range);
    setSelectedIndex(null);
    if (onRangeChange) {
      onRangeChange(range);
    }
    fetchRangeData(range);
  };

  // Trigger initial fetch when component mounts or range/user changes
  useEffect(() => {
    if (userId) {
      fetchRangeData(selectedRange);
    }
  }, [userId, selectedRange, fetchRangeData]);

  const containerWidth = width || measuredWidth || (Dimensions.get('window').width - 80);

  // Normalize points for rendering
  const displayData = useMemo(() => {
    if (!chartPoints || chartPoints.length === 0) {
      return [{ value: 0, label: '-' }];
    }
    if (chartPoints.length === 1) {
      return [{ value: 0, label: '0%' }, ...chartPoints];
    }
    return chartPoints;
  }, [chartPoints]);

  const hPadding = 24;
  const vPadding = 28;
  const chartHeight = height - vPadding * 2;
  const innerWidth = Math.max(10, containerWidth - hPadding * 2);
  const maxValue = 100;

  const getX = (index: number) => {
    return hPadding + index * (innerWidth / Math.max(1, displayData.length - 1));
  };
  const getY = (value: number) => height - vPadding - ((value / maxValue) * chartHeight);

  // Generate Path
  let d = `M ${getX(0)} ${getY(displayData[0].value)}`;
  if (displayData.length > 1) {
    displayData.slice(1).forEach((point, i) => {
      d += ` L ${getX(i + 1)} ${getY(point.value)}`;
    });
  }

  // Generate Area Path for gradient fill
  const dArea = `${d} L ${getX(displayData.length - 1)} ${height - vPadding} L ${getX(0)} ${height - vPadding} Z`;

  const getRangeLabel = (range: PerformanceTimeRange) => {
    switch (range) {
      case '1W':
        return t('profile.chartRange1W', '1W');
      case '1M':
        return t('profile.chartRange1M', '1M');
      case '3M':
        return t('profile.chartRange3M', '3M');
      case 'ALL':
        return t('profile.chartRangeAll', 'All');
      default:
        return range;
    }
  };

  const activePoint = selectedIndex !== null && displayData[selectedIndex] ? displayData[selectedIndex] : null;

  return (
    <View
      style={styles.container}
      onLayout={(e) => {
        const w = e.nativeEvent.layout.width;
        if (w > 0 && Math.abs(w - measuredWidth) > 2) {
          setMeasuredWidth(w);
        }
      }}
    >
      {/* Header with Title and Range Selector Tabs */}
      <View style={[styles.headerRow, { paddingHorizontal: hPadding }]}>
        <View style={styles.titleContainer}>
          <Text style={[styles.title, { color: colors.text.primary }]}>
            {title || t('profile.performanceTrend', 'Performance Trend')}
          </Text>
          {activePoint && activePoint.fullDate ? (
            <Text style={[styles.subtitle, { color: colors.text.secondary }]}>
              {activePoint.fullDate}
            </Text>
          ) : null}
        </View>

        {/* Range Selector Tabs */}
        {allowedRanges.length > 1 && (
          <View
            style={[
              styles.rangeTabContainer,
              {
                backgroundColor: colors.mode === 'light' ? 'rgba(0, 0, 0, 0.05)' : 'rgba(255, 255, 255, 0.08)',
                borderColor: colors.border,
              },
            ]}
          >
            {allowedRanges.map((range) => {
              const isSelected = range === selectedRange;
              return (
                <TouchableOpacity
                  key={range}
                  activeOpacity={0.7}
                  onPress={() => handleRangeSelect(range)}
                  style={[
                    styles.rangeTab,
                    isSelected && {
                      backgroundColor: colors.primary.DEFAULT,
                      shadowColor: colors.primary.DEFAULT,
                      shadowOffset: { width: 0, height: 2 },
                      shadowOpacity: 0.3,
                      shadowRadius: 3,
                      elevation: 2,
                    },
                  ]}
                >
                  <Text
                    style={[
                      styles.rangeTabText,
                      {
                        color: isSelected ? '#FFFFFF' : colors.text.secondary,
                        fontWeight: isSelected ? '700' : '500',
                      },
                    ]}
                  >
                    {getRangeLabel(range)}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        )}
      </View>

      {/* Chart Section */}
      <View style={{ width: containerWidth, height, position: 'relative' }}>
        {loading && (
          <View style={[styles.loadingOverlay, { height }]}>
            <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
          </View>
        )}

        <Svg height={height} width={containerWidth}>
          <Defs>
            <LinearGradient id="performanceGradient" x1="0" y1="0" x2="0" y2="1">
              <Stop offset="0" stopColor={colors.primary.DEFAULT} stopOpacity="0.45" />
              <Stop offset="1" stopColor={colors.primary.DEFAULT} stopOpacity="0.0" />
            </LinearGradient>
          </Defs>

          {/* Grid Lines */}
          {[0, 25, 50, 75, 100].map((val) => (
            <Line
              key={val}
              x1={hPadding}
              y1={getY(val)}
              x2={containerWidth - hPadding}
              y2={getY(val)}
              stroke={colors.border}
              strokeWidth="1"
              strokeDasharray="4 4"
            />
          ))}

          {/* Area Fill */}
          <Path d={dArea} fill="url(#performanceGradient)" />

          {/* Trend Line */}
          <Path
            d={d}
            stroke={colors.primary.DEFAULT}
            strokeWidth="3"
            fill="none"
            strokeLinecap="round"
            strokeLinejoin="round"
          />

          {/* Selected Point Vertical Guideline */}
          {selectedIndex !== null && (
            <Line
              x1={getX(selectedIndex)}
              y1={vPadding - 6}
              x2={getX(selectedIndex)}
              y2={height - vPadding}
              stroke={colors.primary.DEFAULT}
              strokeWidth="1.5"
              strokeDasharray="3 3"
            />
          )}

          {/* Data Points and X-Axis Labels */}
          {displayData.map((point, index) => {
            const isPointSelected = selectedIndex === index;
            const xPos = getX(index);
            const yPos = getY(point.value);

            return (
              <React.Fragment key={index}>
                {/* Touch hotspot rect for SVG tapping */}
                <Rect
                  x={xPos - 16}
                  y={0}
                  width={32}
                  height={height}
                  fill="transparent"
                  onPress={() => setSelectedIndex(index === selectedIndex ? null : index)}
                />

                {/* Point Circle */}
                <Circle
                  cx={xPos}
                  cy={yPos}
                  r={isPointSelected ? '6' : '3.5'}
                  fill={isPointSelected ? colors.primary.DEFAULT : '#FFFFFF'}
                  stroke={colors.primary.DEFAULT}
                  strokeWidth={isPointSelected ? '3' : '2'}
                  onPress={() => setSelectedIndex(index === selectedIndex ? null : index)}
                />

                {/* Score label above point (always show when selected, or for non-zero points when small data length) */}
                {(point.value > 0 && (displayData.length <= 7 || isPointSelected)) && (
                  <SvgText
                    x={xPos}
                    y={yPos - 9}
                    fontSize="10"
                    fontFamily={typography.fonts.bold}
                    fill={isPointSelected ? colors.primary.DEFAULT : colors.text.primary}
                    textAnchor="middle"
                    fontWeight={isPointSelected ? 'bold' : 'normal'}
                  >
                    {point.value}%
                  </SvgText>
                )}

                {/* X-Axis Labels */}
                <SvgText
                  x={xPos}
                  y={height - 4}
                  fontSize="10"
                  fontFamily={typography.fonts.medium}
                  fill={isPointSelected ? colors.primary.DEFAULT : colors.text.secondary}
                  textAnchor="middle"
                  fontWeight={isPointSelected ? 'bold' : 'normal'}
                >
                  {point.label}
                </SvgText>
              </React.Fragment>
            );
          })}
        </Svg>

        {/* Floating Tooltip Pill when selected */}
        {activePoint && selectedIndex !== null && (
          <View
            pointerEvents="none"
            style={[
              styles.floatingTooltip,
              {
                left: Math.min(
                  Math.max(getX(selectedIndex) - 50, hPadding),
                  containerWidth - hPadding - 100
                ),
                top: 4,
                backgroundColor: colors.mode === 'light' ? '#1F2937' : '#111827',
                borderColor: colors.border,
              },
            ]}
          >
            <Text style={styles.tooltipScore}>{activePoint.value}%</Text>
            <Text style={styles.tooltipDate}>{activePoint.fullDate || activePoint.label}</Text>
          </View>
        )}
      </View>

      {/* Stock-Style Summary Metrics Footer (for Managers/Master on DriverDetailScreen) */}
      {showMetrics && (
        <View
          style={[
            styles.metricsContainer,
            {
              backgroundColor:
                colors.mode === 'light' ? 'rgba(0, 0, 0, 0.03)' : 'rgba(255, 255, 255, 0.04)',
              borderColor: colors.border,
            },
          ]}
        >
          {/* Total Attempts */}
          <View style={styles.metricItem}>
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {t('profile.chartAttempts', 'Attempts')}
            </Text>
            <Text style={[styles.metricValue, { color: colors.text.primary }]}>
              {stats.totalAttempts}
            </Text>
          </View>

          {/* Divider */}
          <View style={[styles.metricDivider, { backgroundColor: colors.border }]} />

          {/* Low */}
          <View style={styles.metricItem}>
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {t('profile.chartLow', 'Low')}
            </Text>
            <Text style={[styles.metricValue, { color: colors.text.primary }]}>
              {stats.lowestScore > 0 ? `${stats.lowestScore}%` : '-'}
            </Text>
          </View>

          {/* Divider */}
          <View style={[styles.metricDivider, { backgroundColor: colors.border }]} />

          {/* High */}
          <View style={styles.metricItem}>
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {t('profile.chartHigh', 'High')}
            </Text>
            <Text style={[styles.metricValue, { color: colors.text.primary }]}>
              {stats.highestScore > 0 ? `${stats.highestScore}%` : '-'}
            </Text>
          </View>

          {/* Divider */}
          <View style={[styles.metricDivider, { backgroundColor: colors.border }]} />

          {/* Overall Score */}
          <View style={styles.metricItem}>
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {t('profile.chartOverallScore', 'Overall Score')}
            </Text>
            <Text
              style={[
                styles.metricValue,
                {
                  color: stats.averageScore >= 60
                    ? colors.status.success
                    : stats.averageScore > 0
                    ? colors.text.primary
                    : colors.text.secondary,
                },
              ]}
            >
              {stats.averageScore > 0 ? `${stats.averageScore}%` : '-'}
            </Text>
          </View>
        </View>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingVertical: 12,
    width: '100%',
    alignItems: 'center',
  },
  headerRow: {
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  titleContainer: {
    flex: 1,
  },
  title: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    fontWeight: 'bold',
  },
  subtitle: {
    fontSize: 11,
    fontFamily: typography.fonts.medium,
    marginTop: 2,
  },
  rangeTabContainer: {
    flexDirection: 'row',
    borderRadius: 8,
    padding: 2,
    borderWidth: 1,
  },
  rangeTab: {
    paddingHorizontal: 9,
    paddingVertical: 4,
    borderRadius: 6,
    alignItems: 'center',
    justifyContent: 'center',
  },
  rangeTabText: {
    fontSize: 11,
    fontFamily: typography.fonts.bold,
  },
  loadingOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    zIndex: 10,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.1)',
  },
  floatingTooltip: {
    position: 'absolute',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
    borderWidth: 1,
    alignItems: 'center',
    minWidth: 90,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3,
    elevation: 4,
    zIndex: 20,
  },
  tooltipScore: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#FFFFFF',
    fontFamily: typography.fonts.bold,
  },
  tooltipDate: {
    fontSize: 10,
    color: '#9CA3AF',
    fontFamily: typography.fonts.medium,
  },
  metricsContainer: {
    marginTop: 14,
    marginHorizontal: 12,
    width: '94%',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-around',
    paddingVertical: 10,
    paddingHorizontal: 8,
    borderRadius: 12,
    borderWidth: 1,
  },
  metricItem: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  metricLabel: {
    fontSize: 10,
    fontFamily: typography.fonts.medium,
    textTransform: 'uppercase',
    letterSpacing: 0.5,
    marginBottom: 2,
  },
  metricValue: {
    fontSize: 13,
    fontFamily: typography.fonts.bold,
    fontWeight: 'bold',
  },
  metricDivider: {
    width: 1,
    height: 22,
  },
});
