import React, { useState, useEffect, useCallback, useMemo } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  TouchableOpacity,
  ActivityIndicator,
} from 'react-native';
import Svg, { Line, Text as SvgText, Defs, LinearGradient, Stop, Rect } from 'react-native-svg';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { useTranslation } from 'react-i18next';
import {
  BatchService,
  BatchPerformanceItem,
  BatchPerformanceResult,
} from '../services/batchService';

export interface PerformanceChartProps {
  data?: BatchPerformanceItem[] | any[];
  userId?: string;
  height?: number;
  width?: number;
  allowedRanges?: any[];
  initialRange?: any;
  showMetrics?: boolean;
  title?: string;
  onRangeChange?: (range: any) => void;
  onBatchPress?: (batchNumber: number) => void;
}

export const PerformanceChart: React.FC<PerformanceChartProps> = ({
  data: initialData,
  userId,
  height = 220,
  width,
  showMetrics = true,
  title,
  onBatchPress,
}) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const [measuredWidth, setMeasuredWidth] = useState<number>(0);
  const [batchItems, setBatchItems] = useState<BatchPerformanceItem[]>([]);
  const [stats, setStats] = useState<BatchPerformanceResult['stats']>({
    batchesCompleted: 0,
    totalBatches: 8,
    mcqsCompleted: 0,
    totalMCQs: 240,
    averageScore: 0,
  });
  const [loading, setLoading] = useState<boolean>(false);
  const [selectedIndex, setSelectedIndex] = useState<number | null>(null);

  // In-memory cache ref by userId
  const cacheRef = React.useRef<{ items: BatchPerformanceItem[]; stats: BatchPerformanceResult['stats'] } | null>(null);

  const fetchBatchPerformance = useCallback(async () => {
    if (!userId) return;

    if (cacheRef.current) {
      setBatchItems(cacheRef.current.items);
      setStats(cacheRef.current.stats);
      // Default selection to currently active in_progress batch or latest completed
      const activeIdx = cacheRef.current.items.findIndex(b => b.status === 'in_progress');
      if (activeIdx !== -1) {
        setSelectedIndex(activeIdx);
      }
      return;
    }

    setLoading(true);
    try {
      const result = await BatchService.getUserBatchPerformance(userId);
      if (result && result.items) {
        cacheRef.current = result;
        setBatchItems(result.items);
        setStats(result.stats);

        const inProgIdx = result.items.findIndex(b => b.status === 'in_progress');
        if (inProgIdx !== -1) {
          setSelectedIndex(inProgIdx);
        } else {
          const lastCompletedIdx = result.items.reduce(
            (last, b, idx) => (b.status === 'completed' ? idx : last),
            -1
          );
          if (lastCompletedIdx !== -1) setSelectedIndex(lastCompletedIdx);
        }
      }
    } catch (err) {
      console.error('Failed to fetch batch performance:', err);
    } finally {
      setLoading(false);
    }
  }, [userId]);

  // Sync if initialData is provided
  useEffect(() => {
    if (initialData && Array.isArray(initialData) && initialData.length > 0) {
      // Check if data is already in BatchPerformanceItem format
      if ('batchNumber' in initialData[0] || 'label' in initialData[0]) {
        const normalized = initialData.map((d: any, i: number) => ({
          batchNumber: d.batchNumber || i + 1,
          label: d.label || `B${d.batchNumber || i + 1}`,
          score: Math.min(100, Math.max(0, d.score ?? d.value ?? 0)),
          status: (d.status as 'completed' | 'in_progress' | 'not_started') || (d.score > 0 ? 'completed' : 'not_started'),
          isPassed: d.isPassed ?? (d.score >= 60),
          completedCount: d.completedCount || 0,
          totalQuestions: d.totalQuestions || 30,
          attemptsCount: d.attemptsCount || 0,
          completedAt: d.completedAt || null,
        }));
        setBatchItems(normalized);
      }
    } else if (userId) {
      fetchBatchPerformance();
    }
  }, [initialData, userId, fetchBatchPerformance]);

  const containerWidth = width || measuredWidth || (Dimensions.get('window').width - 48);

  // Fallback items if none yet
  const displayItems = useMemo<BatchPerformanceItem[]>(() => {
    if (batchItems && batchItems.length > 0) {
      return batchItems;
    }
    return [1, 2, 3, 4, 5, 6, 7, 8].map((b) => ({
      batchNumber: b,
      label: `B${b}`,
      score: 0,
      status: b === 1 ? 'in_progress' : 'not_started',
      isPassed: false,
      completedCount: 0,
      totalQuestions: 30,
      attemptsCount: 0,
    }));
  }, [batchItems]);

  // Layout Dimensions
  const leftPadding = 34; // Space for Y-axis markers (100%, 60%, 0%)
  const rightPadding = 16;
  const topPadding = 26; // Room for score text above top of 100% bars
  const bottomPadding = 42; // Room for "B1" and "done / now / --"
  const chartAreaWidth = Math.max(10, containerWidth - leftPadding - rightPadding);
  const chartAreaHeight = Math.max(10, height - topPadding - bottomPadding);

  const getY = useCallback(
    (value: number) => {
      const clamped = Math.min(100, Math.max(0, value));
      return topPadding + (1 - clamped / 100) * chartAreaHeight;
    },
    [topPadding, chartAreaHeight]
  );

  const y60 = getY(60);
  const y100 = getY(100);
  const y0 = getY(0);

  const slotWidth = chartAreaWidth / Math.max(1, displayItems.length);
  const barWidth = Math.min(24, Math.max(14, slotWidth * 0.58));

  const selectedItem =
    selectedIndex !== null && displayItems[selectedIndex] ? displayItems[selectedIndex] : null;

  const handleBarSelect = (index: number) => {
    const newIdx = index === selectedIndex ? null : index;
    setSelectedIndex(newIdx);
    if (newIdx !== null && onBatchPress) {
      onBatchPress(displayItems[newIdx].batchNumber);
    }
  };

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
      {/* Header with Title and Passing Benchmark Pill */}
      <View style={[styles.headerRow, { paddingHorizontal: 12 }]}>
        <View style={styles.titleContainer}>
          <Text style={[styles.title, { color: colors.text.primary }]}>
            {title || t('profile.batchPerformance', 'Batch Performance')}
          </Text>
          <Text style={[styles.subtitle, { color: colors.text.secondary }]}>
            {selectedItem
              ? `${t('quiz.batchTitle', { number: selectedItem.batchNumber })}: ${selectedItem.score}% (${selectedItem.status === 'completed' ? (selectedItem.isPassed ? t('profile.passed', 'Passed') : t('profile.needsImprovement', 'Needs Improvement')) : selectedItem.status === 'in_progress' ? t('profile.inProgress', 'In Progress') : t('profile.notStarted', 'Not Started')})`
              : t('profile.passingScore', 'Passing (60%)')}
          </Text>
        </View>

        {/* Passing Benchmark Badge */}
        <View
          style={[
            styles.benchmarkBadge,
            {
              backgroundColor: colors.mode === 'light' ? 'rgba(16, 185, 129, 0.08)' : 'rgba(16, 185, 129, 0.15)',
              borderColor: 'rgba(16, 185, 129, 0.35)',
            },
          ]}
        >
          <View style={[styles.benchmarkDot, { backgroundColor: '#10B981' }]} />
          <Text style={[styles.benchmarkText, { color: '#10B981' }]}>
            {t('profile.passingScore', 'Pass: 60%')}
          </Text>
        </View>
      </View>

      {/* Summary Metrics Row */}
      {showMetrics && (
        <View style={[styles.metricsRow, { paddingHorizontal: 12 }]}>
          {/* Card 1: Batches Completed */}
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
              {t('profile.batchesCompletedLabel', 'Batches Completed')}
            </Text>
            <Text style={[styles.metricValue, { color: colors.text.primary }]}>
              {`${stats.batchesCompleted} / ${stats.totalBatches}`}
            </Text>
          </View>

          {/* Card 2: MCQs Completed */}
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

          {/* Card 3: Average Score */}
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
              {t('profile.averageScore', 'Average Score')}
            </Text>
            <Text
              style={[
                styles.metricValue,
                {
                  color:
                    stats.averageScore >= 60
                      ? '#10B981'
                      : stats.averageScore > 0
                      ? '#F59E0B'
                      : colors.text.secondary,
                },
              ]}
            >
              {stats.averageScore > 0 ? `${stats.averageScore}%` : t('ratings.na', 'N/A')}
            </Text>
          </View>
        </View>
      )}

      {/* Bar Chart Section */}
      <View style={{ width: containerWidth, height, position: 'relative' }}>
        {loading && (
          <View style={[styles.loadingOverlay, { height }]}>
            <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
          </View>
        )}

        <Svg height={height} width={containerWidth}>
          <Defs>
            {/* Success Green Gradient (Passed) */}
            <LinearGradient id="barPassed" x1="0" y1="0" x2="0" y2="1">
              <Stop offset="0" stopColor="#10B981" stopOpacity="0.95" />
              <Stop offset="1" stopColor="#059669" stopOpacity="0.8" />
            </LinearGradient>

            {/* Warning Amber/Red Gradient (Needs Improvement) */}
            <LinearGradient id="barWarning" x1="0" y1="0" x2="0" y2="1">
              <Stop offset="0" stopColor="#F59E0B" stopOpacity="0.95" />
              <Stop offset="1" stopColor="#D97706" stopOpacity="0.8" />
            </LinearGradient>

            {/* Active In-Progress Primary Gradient */}
            <LinearGradient id="barActive" x1="0" y1="0" x2="0" y2="1">
              <Stop offset="0" stopColor={colors.primary.DEFAULT} stopOpacity="0.95" />
              <Stop offset="1" stopColor={colors.primary.DEFAULT} stopOpacity="0.65" />
            </LinearGradient>
          </Defs>

          {/* 100% Top Baseline Grid */}
          <Line
            x1={leftPadding}
            y1={y100}
            x2={containerWidth - rightPadding}
            y2={y100}
            stroke={colors.border}
            strokeWidth="1"
            strokeDasharray="3 3"
            opacity={0.4}
          />
          <SvgText
            x={leftPadding - 6}
            y={y100 + 3}
            fontSize="9"
            fontFamily={typography.fonts.medium}
            fill={colors.text.secondary}
            opacity={0.7}
            textAnchor="end"
          >
            100%
          </SvgText>

          {/* 60% Passing Benchmark Guideline */}
          <Line
            x1={leftPadding}
            y1={y60}
            x2={containerWidth - rightPadding}
            y2={y60}
            stroke="#10B981"
            strokeWidth="1.2"
            strokeDasharray="4 4"
            opacity={0.7}
          />
          <SvgText
            x={leftPadding - 6}
            y={y60 + 3}
            fontSize="9"
            fontFamily={typography.fonts.bold}
            fill="#10B981"
            textAnchor="end"
            fontWeight="bold"
          >
            60%
          </SvgText>

          {/* 0% Bottom Baseline */}
          <Line
            x1={leftPadding}
            y1={y0}
            x2={containerWidth - rightPadding}
            y2={y0}
            stroke={colors.border}
            strokeWidth="1.5"
            opacity={0.7}
          />
          <SvgText
            x={leftPadding - 6}
            y={y0 + 3}
            fontSize="9"
            fontFamily={typography.fonts.medium}
            fill={colors.text.secondary}
            opacity={0.6}
            textAnchor="end"
          >
            0%
          </SvgText>

          {/* Render 8 Batch Bars */}
          {displayItems.map((item, index) => {
            const centerX = leftPadding + (index + 0.5) * slotWidth;
            const barX = centerX - barWidth / 2;
            const isSelected = selectedIndex === index;

            // Bar dimensions
            const isNotStarted = item.status === 'not_started';
            const isInProgress = item.status === 'in_progress';
            const isCompleted = item.status === 'completed';

            // Calculate height proportional to score (0..100)
            const calculatedBarH = (item.score / 100) * chartAreaHeight;
            const barH = isNotStarted
              ? 0
              : Math.max(isInProgress && item.completedCount > 0 ? 6 : (item.score > 0 ? 6 : 0), calculatedBarH);
            const barY = topPadding + chartAreaHeight - barH;

            // Fill color
            let fillUrl = 'url(#barPassed)';
            if (isCompleted) {
              fillUrl = item.isPassed ? 'url(#barPassed)' : 'url(#barWarning)';
            } else if (isInProgress) {
              fillUrl = item.score >= 60 ? 'url(#barPassed)' : 'url(#barActive)';
            }

            return (
              <React.Fragment key={`batch-${item.batchNumber}`}>
                {/* Touch Hotspot covering entire column */}
                <Rect
                  x={centerX - slotWidth / 2}
                  y={0}
                  width={slotWidth}
                  height={height}
                  fill="transparent"
                  onPress={() => handleBarSelect(index)}
                />

                {/* Selection Highlight Pillar Background */}
                {isSelected && (
                  <Rect
                    x={centerX - slotWidth / 2 + 2}
                    y={topPadding - 4}
                    width={slotWidth - 4}
                    height={chartAreaHeight + 8}
                    rx={6}
                    ry={6}
                    fill={colors.mode === 'light' ? 'rgba(0,0,0,0.04)' : 'rgba(255,255,255,0.06)'}
                    stroke={colors.primary.DEFAULT}
                    strokeWidth="1"
                  />
                )}

                {/* Bar Element */}
                {isNotStarted ? (
                  /* Placeholder dashed rectangle for unstarted batches */
                  <Rect
                    x={barX}
                    y={topPadding + 10}
                    width={barWidth}
                    height={chartAreaHeight - 10}
                    rx={4}
                    ry={4}
                    fill={colors.mode === 'light' ? 'rgba(0,0,0,0.02)' : 'rgba(255,255,255,0.02)'}
                    stroke={colors.border}
                    strokeWidth="1"
                    strokeDasharray="3 3"
                    opacity={0.45}
                  />
                ) : (
                  /* Filled Proportional Bar */
                  <Rect
                    x={barX}
                    y={barY}
                    width={barWidth}
                    height={barH}
                    rx={4}
                    ry={4}
                    fill={fillUrl}
                    stroke={
                      isInProgress
                        ? colors.primary.DEFAULT
                        : isSelected
                        ? '#FFFFFF'
                        : 'transparent'
                    }
                    strokeWidth={isSelected ? 1.5 : (isInProgress ? 1 : 0)}
                  />
                )}

                {/* Score Text above Bar */}
                <SvgText
                  x={centerX}
                  y={isNotStarted ? y0 - 8 : Math.min(y0 - 6, barY - 6)}
                  fontSize="10"
                  fontFamily={typography.fonts.bold}
                  fill={
                    isNotStarted
                      ? (colors.mode === 'light' ? '#9CA3AF' : '#6B7280')
                      : item.score >= 60
                      ? '#10B981'
                      : item.score > 0
                      ? '#F59E0B'
                      : colors.text.secondary
                  }
                  textAnchor="middle"
                  fontWeight={isSelected || isCompleted ? 'bold' : 'normal'}
                  opacity={isNotStarted ? 0.4 : 1}
                >
                  {isNotStarted ? '--' : `${item.score}%`}
                </SvgText>

                {/* Batch Label (B1 to B8) */}
                <SvgText
                  x={centerX}
                  y={height - 22}
                  fontSize="11"
                  fontFamily={isSelected ? typography.fonts.bold : typography.fonts.medium}
                  fill={
                    isSelected || isInProgress
                      ? colors.primary.DEFAULT
                      : isNotStarted
                      ? (colors.mode === 'light' ? '#9CA3AF' : '#6B7280')
                      : colors.text.primary
                  }
                  textAnchor="middle"
                  fontWeight={isSelected || isInProgress ? 'bold' : '500'}
                  opacity={isNotStarted ? 0.5 : 1}
                >
                  {item.label}
                </SvgText>

                {/* Status Indicator Text underneath */}
                <SvgText
                  x={centerX}
                  y={height - 8}
                  fontSize="8.5"
                  fontFamily={typography.fonts.bold}
                  fill={
                    isCompleted
                      ? (item.isPassed ? '#10B981' : '#F59E0B')
                      : isInProgress
                      ? colors.primary.DEFAULT
                      : (colors.mode === 'light' ? '#9CA3AF' : '#6B7280')
                  }
                  textAnchor="middle"
                  fontWeight="bold"
                  opacity={isNotStarted ? 0.35 : 0.9}
                >
                  {isCompleted
                    ? (item.isPassed ? '✓' : '!')
                    : isInProgress
                    ? t('profile.currentBatchTag', 'NOW')
                    : '--'}
                </SvgText>
              </React.Fragment>
            );
          })}
        </Svg>

        {/* Floating Tooltip / Popover when a bar is selected */}
        {selectedItem && selectedIndex !== null && (
          <View
            pointerEvents="none"
            style={[
              styles.floatingTooltip,
              {
                left: Math.min(
                  Math.max(leftPadding + (selectedIndex + 0.5) * slotWidth - 60, 8),
                  containerWidth - 128
                ),
                top: 2,
                backgroundColor: colors.mode === 'light' ? '#1F2937' : '#111827',
                borderColor: selectedItem.isPassed
                  ? '#10B981'
                  : selectedItem.status === 'in_progress'
                  ? colors.primary.DEFAULT
                  : colors.border,
              },
            ]}
          >
            <Text style={styles.tooltipBatch}>
              {t('quiz.batchTitle', { number: selectedItem.batchNumber })}
            </Text>
            <Text
              style={[
                styles.tooltipScore,
                {
                  color:
                    selectedItem.status === 'not_started'
                      ? '#9CA3AF'
                      : selectedItem.isPassed
                      ? '#10B981'
                      : '#F59E0B',
                },
              ]}
            >
              {selectedItem.status === 'not_started' ? t('profile.notStarted', 'Not Started') : `${selectedItem.score}%`}
            </Text>
            <Text style={styles.tooltipQuestions}>
              {selectedItem.completedCount > 0
                ? `${selectedItem.completedCount} / ${selectedItem.totalQuestions} ${t('profile.mcqsUnit', 'MCQs')}`
                : selectedItem.status === 'in_progress'
                ? t('profile.inProgress', 'In Progress')
                : `${selectedItem.totalQuestions} ${t('profile.mcqsUnit', 'MCQs')}`}
            </Text>
          </View>
        )}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingVertical: 10,
    width: '100%',
    alignItems: 'center',
  },
  headerRow: {
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 6,
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
  benchmarkBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 5,
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    borderWidth: 1,
  },
  benchmarkDot: {
    width: 6,
    height: 6,
    borderRadius: 3,
  },
  benchmarkText: {
    fontSize: 10,
    fontFamily: typography.fonts.bold,
    fontWeight: '700',
  },
  metricsRow: {
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: 8,
    marginVertical: 8,
  },
  metricCard: {
    flex: 1,
    paddingVertical: 7,
    paddingHorizontal: 6,
    borderRadius: 8,
    borderWidth: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  metricLabel: {
    fontSize: 9.5,
    fontFamily: typography.fonts.medium,
    textTransform: 'uppercase',
    letterSpacing: 0.3,
    marginBottom: 2,
    textAlign: 'center',
  },
  metricValue: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    fontWeight: 'bold',
    textAlign: 'center',
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
    paddingHorizontal: 10,
    paddingVertical: 6,
    borderRadius: 8,
    borderWidth: 1,
    alignItems: 'center',
    minWidth: 120,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 5,
    zIndex: 20,
  },
  tooltipBatch: {
    fontSize: 10,
    color: '#9CA3AF',
    fontFamily: typography.fonts.medium,
  },
  tooltipScore: {
    fontSize: 14,
    fontWeight: 'bold',
    fontFamily: typography.fonts.bold,
    marginVertical: 1,
  },
  tooltipQuestions: {
    fontSize: 9.5,
    color: '#D1D5DB',
    fontFamily: typography.fonts.regular,
  },
});
