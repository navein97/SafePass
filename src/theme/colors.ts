// Palette Definitions
const common = {
  status: {
    success: '#00C853',
    warning: '#FFD700',
    danger: '#FF3D00',
    info: '#FFD700',
  },
  streak: {
    flame: '#FF6B00',
    flameGlow: '#FF9500',
    multiplier: '#FFD700',
  },
  leaderboard: {
    gold: '#FFD700',
    silver: '#C0C0C0',
    bronze: '#CD7F32',
    pitLane: '#FF6B00',
    purple: '#9C27B0',
  },
};

export const darkColors = {
  ...common,
  mode: 'dark',
  primary: {
    DEFAULT: '#FFD700',
    light: '#FFE55C',
    dark: '#CCB000',
  },
  secondary: {
    DEFAULT: '#1A1A1A',
    light: '#333333',
    dark: '#000000',
  },
  background: {
    default: '#0A0A0A',
    subtle: '#1A1A1A',
    card: '#141414',
    glass: 'rgba(20, 20, 20, 0.9)',
    glassBorder: 'rgba(255, 215, 0, 0.2)',
    white: '#FFFFFF',
  },
  text: {
    primary: '#FFFFFF',
    secondary: 'rgba(255, 255, 255, 0.7)',
    tertiary: 'rgba(255, 255, 255, 0.4)',
    inverse: '#000000',
    accent: '#FFD700',
  },
  border: 'rgba(255, 215, 0, 0.3)',
  input: 'rgba(255, 255, 255, 0.1)',
  overlay: 'rgba(0, 0, 0, 0.85)',
  gradients: {
    primary: ['#FFD700', '#FFA500'],
    danger: ['#FF3D00', '#FF6D00'],
    dark: ['#1A1A1A', '#000000'],
    success: ['#00C853', '#00E676'],
    gold: ['#FFD700', '#FFB300'],
    background: ['#0A0A0A', '#1A1A1A'], // New for full bg
  },
};

export const lightColors = {
  ...common,
  mode: 'light',
  primary: {
    DEFAULT: '#FFD700', // Keep brand yellow
    light: '#FFE55C',
    dark: '#C7A300',
  },
  secondary: {
    DEFAULT: '#F5F5F5',
    light: '#FFFFFF',
    dark: '#E0E0E0',
  },
  background: {
    default: '#FFFFFF',
    subtle: '#F5F7FA', // Very light grey blue
    card: '#FFFFFF',
    glass: 'rgba(255, 255, 255, 0.85)',
    glassBorder: 'rgba(0, 0, 0, 0.05)',
    white: '#FFFFFF',
  },
  text: {
    primary: '#1A1A1A', // Nearly black
    secondary: 'rgba(0, 0, 0, 0.6)',
    tertiary: 'rgba(0, 0, 0, 0.4)',
    inverse: '#FFFFFF', // White text on yellow/black
    accent: '#B8860B',  // Dark Goldenrod for light mode readability
  },
  border: 'rgba(0, 0, 0, 0.1)',
  input: 'rgba(0, 0, 0, 0.05)',
  overlay: 'rgba(255, 255, 255, 0.85)',
  gradients: {
    primary: ['#FFD700', '#FFC107'],
    danger: ['#FF5252', '#FF1744'],
    dark: ['#F5F5F5', '#E0E0E0'], // Light gradient
    success: ['#00E676', '#00C853'],
    gold: ['#FFD700', '#FFA000'],
    background: ['#FFFFFF', '#F5F7FA'], // Light bg
  },
};

// Default export for backward compatibility during refactor
export const colors = darkColors;
