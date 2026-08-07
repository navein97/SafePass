// Palette Definitions
const common = {
  status: {
    success: '#00C853',
    warning: '#E1257C',
    danger: '#FF3D00',
    info: '#7B2CBF',
  },
  streak: {
    flame: '#C2185B',
    flameGlow: '#D81B60',
    multiplier: '#E1257C',
  },
  leaderboard: {
    gold: '#E1257C',
    silver: '#F564A9',
    bronze: '#C2185B',
    pitLane: '#C2185B',
    purple: '#9C27B0',
  },
};

export const darkColors = {
  ...common,
  mode: 'dark',
  primary: {
    DEFAULT: '#E1257C',
    light: '#F564A9',
    dark: '#A11A58',
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
    glassBorder: 'rgba(255, 255, 255, 0.1)',
    white: '#FFFFFF',
  },
  text: {
    primary: '#FFFFFF',
    secondary: 'rgba(255, 255, 255, 0.8)',
    tertiary: 'rgba(255, 255, 255, 0.55)',
    inverse: '#FFFFFF',
    accent: '#E1257C',
  },
  border: 'rgba(255, 255, 255, 0.1)',
  input: 'rgba(255, 255, 255, 0.05)',
  overlay: 'rgba(0, 0, 0, 0.85)',
  gradients: {
    primary: ['#E1257C', '#7B2CBF'],
    danger: ['#FF3D00', '#FF6D00'],
    dark: ['#1A1A1A', '#000000'],
    success: ['#00C853', '#00E676'],
    gold: ['#E1257C', '#7B2CBF'],
    background: ['#0A0A0A', '#1A1A1A'], // New for full bg
  },
};

export const lightColors = {
  ...common,
  mode: 'light',
  primary: {
    DEFAULT: '#E1257C', // Keep brand pink
    light: '#F564A9',
    dark: '#A11A58',
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
    secondary: 'rgba(0, 0, 0, 0.75)',
    tertiary: 'rgba(0, 0, 0, 0.55)',
    inverse: '#FFFFFF', // White text on pink/black
    accent: '#A11A58',  // Dark Pink for light mode readability
  },
  border: 'rgba(0, 0, 0, 0.08)',
  input: 'rgba(0, 0, 0, 0.04)',
  overlay: 'rgba(255, 255, 255, 0.85)',
  gradients: {
    primary: ['#E1257C', '#7B2CBF'],
    danger: ['#FF5252', '#FF1744'],
    dark: ['#F5F5F5', '#E0E0E0'], // Light gradient
    success: ['#00E676', '#00C853'],
    gold: ['#E1257C', '#7B2CBF'],
    background: ['#FFFFFF', '#F5F7FA'], // Light bg
  },
};

// Default export for backward compatibility during refactor
export const colors = lightColors;
