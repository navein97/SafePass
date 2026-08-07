export const Validation = {
    isValidEmail: (email: string): boolean => {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    },

    isValidPassword: (password: string): boolean => {
        return password.length >= 6;
    },

    /**
     * Formats local phone numbers (e.g. 0123456789 -> +60123456789) based on region code.
     */
    formatPhoneNumber: (phone: string, region: string = 'MY'): string => {
        let trimmed = phone.trim();
        if (!trimmed) return trimmed;
        
        // If starts with 0 (e.g. 0123456789 in MY)
        if (trimmed.startsWith('0')) {
            const countryCode = region === 'TH' ? '+66' : region === 'SG' ? '+65' : '+60';
            return `${countryCode}${trimmed.substring(1)}`;
        }
        
        // If user typed e.g. 60123456789 without +
        if (/^(60|66|65)\d+/.test(trimmed)) {
            return `+${trimmed}`;
        }

        return trimmed;
    },

    /**
     * Checks if phone number contains a valid country code for WhatsApp compatibility (+60, +66, +65, etc.)
     */
    hasCountryCode: (phone: string): boolean => {
        const trimmed = phone.trim();
        if (!trimmed) return false;
        const digitsOnly = trimmed.replace(/[^0-9]/g, '');
        if (digitsOnly.length < 8) return false;
        return trimmed.startsWith('+') || /^(60|66|65|1|44)\d+/.test(digitsOnly);
    },

    /**
     * Normalizes phone number into digits-only format starting with country code for WhatsApp URL scheme wa.me / whatsapp://
     */
    toWhatsAppPhone: (phone: string, region: string = 'MY'): string => {
        let formatted = Validation.formatPhoneNumber(phone, region);
        let digits = formatted.replace(/[^0-9]/g, '');
        if (digits.startsWith('0')) {
            const cc = region === 'TH' ? '66' : region === 'SG' ? '65' : '60';
            digits = `${cc}${digits.substring(1)}`;
        }
        return digits;
    },

    /**
     * Maps technical Supabase errors to user-friendly messages
     */
    getFriendlyErrorMessage: (error: string): string => {
        if (!error) return 'An unknown error occurred.';

        const lowerError = error.toLowerCase();

        if (lowerError.includes('invalid login credentials')) {
            return 'Incorrect email or password. Please try again.';
        }
        if (lowerError.includes('user already registered') || lowerError.includes('unique constraint')) {
            return 'This email is already registered. Please login instead.';
        }
        if (lowerError.includes('password should be at least')) {
            return 'Password must be at least 6 characters long.';
        }
        if (lowerError.includes('rate limit')) {
            return 'Too many attempts. Please wait a moment before trying again.';
        }
        if (lowerError.includes('network')) {
            return 'Network error. Please check your internet connection.';
        }

        return error; // Return original if no map found
    }
};
