import { Platform } from 'react-native';

export const typography = {
    fonts: {
        regular: Platform.select({ ios: 'Inter-Regular', android: 'Inter_400Regular', default: 'System' }),
        medium: Platform.select({ ios: 'Inter-Medium', android: 'Inter_500Medium', default: 'System' }),
        bold: Platform.select({ ios: 'Inter-Bold', android: 'Inter_700Bold', default: 'System' }),
        mono: Platform.select({ ios: 'Courier', android: 'monospace', default: 'monospace' }),
    },
    sizes: {
        xs: 12,
        sm: 14,
        base: 16,
        lg: 18,
        xl: 20,
        '2xl': 24,
        '3xl': 30,
        '4xl': 36,
    },
    lineHeights: {
        tight: 1.25,
        normal: 1.5,
        relaxed: 1.75,
    },
};
