import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { useTheme } from '../context/ThemeContext';
import { LinearGradient } from 'expo-linear-gradient';
import { Trophy } from 'lucide-react-native';
import { GlassCard } from './ui/GlassCard';

interface MilestoneTrackerProps {
  currentPoints: number;
}

const MILESTONES = [
  { name: 'Rookie', threshold: 0, color: '#A11A58' }, // Dark Pink
  { name: 'Pro', threshold: 1000, color: '#C2185B' }, // Hotter Pink
  { name: 'Elite', threshold: 2500, color: '#E1257C' }, // Primary Pink
  { name: 'Legend', threshold: 5000, color: '#F564A9' } // Lightest Pink
];

export const MilestoneTracker = ({ currentPoints }: MilestoneTrackerProps) => {
  const { colors, theme } = useTheme();

  // Determine current level and next milestone
  let currentLevel = MILESTONES[0];
  let nextLevel = MILESTONES[1];
  
  for (let i = 0; i < MILESTONES.length; i++) {
      if (currentPoints >= MILESTONES[i].threshold) {
          currentLevel = MILESTONES[i];
          nextLevel = MILESTONES[i + 1] || null;
      }
  }

  // Calculate Progress
  let progress = 100;
  if (nextLevel) {
      const range = nextLevel.threshold - currentLevel.threshold;
      const current = currentPoints - currentLevel.threshold;
      progress = (current / range) * 100;
  }

  // Dynamic background colors for dark/light mode
  const bgElement = theme === 'dark' ? 'rgba(255,255,255,0.1)' : 'rgba(0,0,0,0.05)';

  return (
    <GlassCard style={styles.container} contentStyle={styles.content}>
      <View style={styles.header}>
        <View style={[styles.badgeContainer, { backgroundColor: bgElement }]}>
             <Trophy size={20} color={currentLevel.color} />
        </View>
        <View style={styles.textContainer}>
            <Text style={[styles.levelTitle, { color: colors.text.primary }]}>{currentLevel.name} Driver</Text>
            <Text style={[styles.pointsText, { color: colors.text.secondary }]}>{currentPoints} XP</Text>
        </View>
        {nextLevel && (
             <Text style={[styles.nextLevelText, { color: colors.text.tertiary }]}>{nextLevel.threshold - currentPoints} XP to {nextLevel.name}</Text>
        )}
      </View>

      <View style={[styles.progressBarBg, { backgroundColor: bgElement }]}>
         <LinearGradient
            colors={[currentLevel.color, nextLevel ? nextLevel.color : currentLevel.color]}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 0 }}
            style={[styles.progressBarFill, { width: `${progress}%` }]}
         />
      </View>
    </GlassCard>
  );
};

const styles = StyleSheet.create({
  container: {
    marginVertical: 12,
  },
  content: {
    padding: 16,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  badgeContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(0,0,0,0.05)',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  textContainer: {
    flex: 1,
  },
  levelTitle: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  pointsText: {
    fontSize: 12,
  },
  nextLevelText: {
    fontSize: 10,
    marginTop: 4,
  },
  progressBarBg: {
    height: 8,
    backgroundColor: 'rgba(0,0,0,0.05)',
    borderRadius: 4,
    overflow: 'hidden',
  },
  progressBarFill: {
    height: '100%',
    borderRadius: 4,
  }
});
