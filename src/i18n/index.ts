import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import { getLocales } from 'expo-localization';

import en from './en.json';
import ms from './ms.json';

const resources = {
    en: { translation: en },
    ms: { translation: ms },
} as const;

// Detect device language or default to English
const deviceLanguage = getLocales()[0]?.languageCode || 'en';

i18n
    .use(initReactI18next)
    .init({
        resources: resources as any,
        lng: deviceLanguage, // Initial language
        fallbackLng: 'en',
        interpolation: {
            escapeValue: false, // React handles escaping
        },
    });

export default i18n;
