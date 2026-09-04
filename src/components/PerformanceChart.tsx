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
  allowedRanges = ['1W', '1M', 'ALL'],
  initialRange = '1W',
  showMetrics = true,
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
    activePeriodsCount: 0,
    activePeriodsLabel: 'Active Days',
    mcqsCompleted: 0,
    periodPerformance: null,
  });
  const [loading, setLoading] = useState<boolean>(false);
  const [selectedIndex, setSelectedIndex] = useState<number | null>(null);

  // In-memory cache for fast tab switching
  const cacheRef = React.useRef<Record<string, { points: PerformanceTrendPoint[]; stats: PerformanceStats }>>({});

  // 0 = Monday, 1 = Tuesday, ..., 6 = Sunday in ISO week
  const currentIsoDayIndex = useMemo(() => {
    const day = new Date().getDay(); // 0 is Sunday, 1 is Monday, ...
    return (day + 6) % 7;
  }, []);

  // Determine if a point is in the future
  const isPointInFuture = useCallback(
    (point: PerformanceTrendPoint, index: number): boolean => {
      if (point.isFuture !== undefined) {
        return point.isFuture;
      }
      if (selectedRange === '1W' && (chartPoints.length === 7 || (!chartPoints.length))) {
        return index > currentIsoDayIndex;
      }
      return false;
    },
    [selectedRange, chartPoints.length, currentIsoDayIndex]
  );

  // Determine if a point is "Today"
  const isPointToday = useCallback(
    (point: PerformanceTrendPoint, index: number): boolean => {
      if (point.isToday !== undefined) {
        return point.isToday;
      }
      if (selectedRange === '1W' && (chartPoints.length === 7 || (!chartPoints.length))) {
        return index === currentIsoDayIndex;
      }
      return false;
    },
    [selectedRange, chartPoints.length, currentIsoDayIndex]
  );

  const calculateStatsFromPoints = useCallback(
    (points: PerformanceTrendPoint[]) => {
      const validPoints = points.filter((p, i) => !isPointInFuture(p, i));
      const activePoints = validPoints.filter(p => (p.hasActivity ?? (p.attemptsCount ? p.attemptsCount > 0 : p.value > 0)) && p.value > 0);
      const activeScores = activePoints.map(p => p.value);
      const avg = activeScores.length > 0 ? Math.round(activeScores.reduce((s, v) => s + v, 0) / activeScores.length) : 0;
      const high = activeScores.length > 0 ? Math.max(...activeScores) : 0;
      const low = activeScores.length > 0 ? Math.min(...activeScores) : 0;
      const attempts = validPoints.reduce((s, p) => s + (p.attemptsCount || 0), 0);

      setStats(prev => ({
        ...prev,
        averageScore: avg,
        highestScore: high,
        lowestScore: low,
        totalAttempts: attempts,
        activePeriodsCount: activePoints.length,
      }));
    },
    [isPointInFuture]
  );

  // Sync initialData if provided and on 1W
  useEffect(() => {
    if (initialData && initialData.length > 0 && selectedRange === '1W') {
      setChartPoints(initialData);
      calculateStatsFromPoints(initialData);
    }
  }, [initialData, selectedRange, calculateStatsFromPoints]);

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
    [userId, initialData, calculateStatsFromPoints]
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
  const displayData = useMemo<PerformanceTrendPoint[]>(() => {
    if (!chartPoints || chartPoints.length === 0) {
      if (selectedRange === '1W') {
        const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
        return dayLabels.map((label, i) => ({
          value: 0,
          label,
          isFuture: i > currentIsoDayIndex,
          isToday: i === currentIsoDayIndex,
        }));
      }
      return [{ value: 0, label: '-' }];
    }
    if (chartPoints.length === 1 && selectedRange !== '1W') {
      return [{ value: 0, label: '0%' }, ...chartPoints];
    }
    return chartPoints;
  }, [chartPoints, selectedRange, currentIsoDayIndex]);

  const hPadding = 16;
  const vPadding = 24;
  const chartHeight = height - vPadding * 2;
  const innerWidth = Math.max(10, containerWidth - hPadding * 2);
  const maxValue = 100;

  const getX = useCallback(
    (index: number) => {
      return hPadding + index * (innerWidth / Math.max(1, displayData.length - 1));
    },
    [hPadding, innerWidth, displayData.length]
  );

  const getY = useCallback(
    (value: number) => {
      return height - vPadding - ((value / maxValue) * chartHeight);
    },
    [height, vPadding, maxValue, chartHeight]
  );

  // Helper to determine if a point represents actual quiz activity
  const isPointActive = useCallback(
    (point: PerformanceTrendPoint, index: number): boolean => {
      if (isPointInFuture(point, index)) return false;
      if (point.hasActivity !== undefined) return point.hasActivity && point.value > 0;
      return (point.attemptsCount !== undefined ? point.attemptsCount > 0 : point.value > 0);
    },
    [isPointInFuture]
  );

  // Active indices (strictly past and today - points with actual quiz activity)
  const activeIndices = useMemo(() => {
    const indices: number[] = [];
    displayData.forEach((point, index) => {
      if (isPointActive(point, index)) {
        indices.push(index);
      }
    });
    return indices;
  }, [displayData, isPointActive]);

  const todayIndex = useMemo(() => {
    return displayData.findIndex((p, i) => isPointToday(p, i));
  }, [displayData, isPointToday]);

  // Generate Path and Area Fill strictly for active points
  const { d, dArea } = useMemo(() => {
    if (activeIndices.length <= 1) {
      return { d: '', dArea: '' };
    }

    const firstIdx = activeIndices[0];
    const lastIdx = activeIndices[activeIndices.length - 1];

    let linePath = `M ${getX(firstIdx)} ${getY(displayData[firstIdx].value)}`;
    for (let i = 1; i < activeIndices.length; i++) {
      const idx = activeIndices[i];
      linePath += ` L ${getX(idx)} ${getY(displayData[idx].value)}`;
    }

    const bottomY = height - vPadding;
    const areaPath = `${linePath} L ${getX(lastIdx)} ${bottomY} L ${getX(firstIdx)} ${bottomY} Z`;

    return { d: linePath, dArea: areaPath };
  }, [activeIndices, displayData, height, vPadding, getX, getY]);

  const getRangeLabel = (range: PerformanceTimeRange) => {
    switch (range) {
      case '1W':
        return t('profile.chartRange1W', '1W');
      case '1M':
        return t('profile.chartRange1M', '1M');
      case 'ALL':
        return t('profile.chartRangeAll', 'All');
      default:
        return range;
    }
  };

  const activePoint =
    selectedIndex !== null &&
    displayData[selectedIndex] &&
    !isPointInFuture(displayData[selectedIndex], selectedIndex)
      ? displayData[selectedIndex]
      : null;

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

      {/* Summary Figures (Dashboard B) */}
      {showMetrics && (
        <View style={[styles.metricsRow, { paddingHorizontal: hPadding }]}>
          <View
            style={[
              styles.metricCard,
              {
                backgroundColor: colors.mode === 'light' ? 'rgba(0, 0, 0, 0.03)' : 'rgba(255, 255, 255, 0.05)',
                borderColor: colors.border,
              },
            ]}
          >
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {selectedRange === 'ALL' ? t('profile.activeMonths', 'Active Months') : t('profile.activeDays', 'Active Days')}
            </Text>
            <Text style={[styles.metricValue, { color: colors.text.primary }]}>
              {stats.activePeriodsCount ?? 0}
            </Text>
          </View>

          <View
            style={[
              styles.metricCard,
              {
                backgroundColor: colors.mode === 'light' ? 'rgba(0, 0, 0, 0.03)' : 'rgba(255, 255, 255, 0.05)',
                borderColor: colors.border,
              },
            ]}
          >
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {t('profile.mcqsCompleted', 'MCQs Completed')}
            </Text>
            <Text style={[styles.metricValue, { color: colors.text.primary }]}>
              {stats.mcqsCompleted ?? 0}
            </Text>
          </View>

          <View
            style={[
              styles.metricCard,
              {
                backgroundColor: colors.mode === 'light' ? 'rgba(0, 0, 0, 0.03)' : 'rgba(255, 255, 255, 0.05)',
                borderColor: colors.border,
              },
            ]}
          >
            <Text style={[styles.metricLabel, { color: colors.text.secondary }]}>
              {t('profile.periodPerformance', 'Period Performance')}
            </Text>
            <Text
              style={[
                styles.metricValue,
                {
                  color: stats.periodPerformance !== null && stats.periodPerformance !== undefined
                    ? colors.primary.DEFAULT
                    : colors.text.secondary,
                },
              ]}
            >
              {stats.periodPerformance !== null && stats.periodPerformance !== undefined ? `${stats.periodPerformance}%` : t('ratings.na', 'N/A')}
            </Text>
          </View>
        </View>
      )}

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

          {/* Area Fill - strictly under active points */}
          {dArea ? <Path d={dArea} fill="url(#performanceGradient)" /> : null}

          {/* Trend Line - stops flat at today */}
          {d ? (
            <Path
              d={d}
              stroke={colors.primary.DEFAULT}
              strokeWidth="3"
              fill="none"
              strokeLinecap="round"
              strokeLinejoin="round"
            />
          ) : null}

          {/* Today Vertical Guideline Marker */}
          {todayIndex !== -1 && (
            <Line
              x1={getX(todayIndex)}
              y1={vPadding - 6}
              x2={getX(todayIndex)}
              y2={height - vPadding}
              stroke={colors.primary.DEFAULT}
              strokeWidth="1.2"
              strokeDasharray="2 3"
              opacity={selectedIndex === todayIndex ? 0.8 : 0.35}
            />
          )}

          {/* Selected Point Vertical Guideline */}
          {selectedIndex !== null &&
            selectedIndex !== todayIndex &&
            !isPointInFuture(displayData[selectedIndex], selectedIndex) && (
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
            const isFuture = isPointInFuture(point, index);
            const isToday = isPointToday(point, index);
            const isPointSelected = selectedIndex === index;
            const xPos = getX(index);
            const yPos = getY(point.value);

            const hasActivity = isPointActive(point, index);

            return (
              <React.Fragment key={index}>
                {/* Touch hotspot rect for active and past days */}
                {!isFuture && (
                  <Rect
                    x={xPos - 16}
                    y={0}
                    width={32}
                    height={height}
                    fill="transparent"
                    onPress={() => setSelectedIndex(index === selectedIndex ? null : index)}
                  />
                )}

                {/* Point Circle (Rendered for active points or today's subtle marker) */}
                {!isFuture && (
                  <>
                    {hasActivity ? (
                      <>
                        {isToday && !isPointSelected && (
                          <Circle
                            cx={xPos}
                            cy={yPos}
                            r="6"
                            fill="transparent"
                            stroke={colors.primary.DEFAULT}
                            strokeWidth="1"
                            opacity={0.5}
                          />
                        )}
                        <Circle
                          cx={xPos}
                          cy={yPos}
                          r={isPointSelected ? '6' : (isToday ? '4.5' : '3.5')}
                          fill={isPointSelected ? colors.primary.DEFAULT : '#FFFFFF'}
                          stroke={colors.primary.DEFAULT}
                          strokeWidth={isPointSelected ? '3' : '2'}
                          onPress={() => setSelectedIndex(index === selectedIndex ? null : index)}
                        />
                      </>
                    ) : isToday ? (
                      <Circle
                        cx={xPos}
                        cy={height - vPadding}
                        r="3.5"
                        fill="transparent"
                        stroke={colors.primary.DEFAULT}
                        strokeWidth="1.2"
                        strokeDasharray="2 2"
                        opacity={0.6}
                        onPress={() => setSelectedIndex(index === selectedIndex ? null : index)}
                      />
                    ) : null}
                  </>
                )}

                {/* Score label above point (active points only) */}
                {!isFuture && (hasActivity && point.value > 0 && (displayData.length <= 7 || isPointSelected)) && (
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

                {/* X-Axis Labels (all days visible, future days dimmed/greyed out) */}
                <SvgText
                  x={xPos}
                  y={height - 4}
                  fontSize="10"
                  fontFamily={
                    isToday || isPointSelected
                      ? typography.fonts.bold
                      : (isFuture ? typography.fonts.regular : typography.fonts.medium)
                  }
                  fill={
                    isFuture
                      ? (colors.mode === 'light' ? '#9CA3AF' : '#6B7280')
                      : (isPointSelected || isToday ? colors.primary.DEFAULT : colors.text.secondary)
                  }
                  opacity={isFuture ? 0.35 : 1}
                  textAnchor="middle"
                  fontWeight={isPointSelected || isToday ? 'bold' : (isFuture ? 'normal' : '500')}
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
            <Text style={styles.tooltipScore}>
              {isPointActive(activePoint, selectedIndex)
                ? `${activePoint.value}%`
                : t('profile.noActivity', 'No Activity')}
            </Text>
            <Text style={styles.tooltipDate}>{activePoint.fullDate || activePoint.label}</Text>
          </View>
        )}
      </View>
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
  metricsRow: {
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: 8,
    marginVertical: 10,
  },
  metricCard: {
    flex: 1,
    paddingVertical: 8,
    paddingHorizontal: 8,
    borderRadius: 8,
    borderWidth: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  metricLabel: {
    fontSize: 10,
    fontFamily: typography.fonts.medium,
    textTransform: 'uppercase',
    letterSpacing: 0.4,
    marginBottom: 2,
    textAlign: 'center',
  },
  metricValue: {
    fontSize: 15,
    fontFamily: typography.fonts.bold,
    fontWeight: 'bold',
    textAlign: 'center',
  },
});

