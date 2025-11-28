export const Validation = {
    isValidEmail: (email: string): boolean => {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    },

    isValidPassword: (password: string): boolean => {
        return password.length >= 6;
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
