import { firebaseAuth } from '../lib/firebase';
import { 
  signInWithPhoneNumber, 
  RecaptchaVerifier, 
  ConfirmationResult 
} from 'firebase/auth';
import { supabase } from '../lib/supabase';

export interface SendOtpResponse {
  success: boolean;
  message?: string;
  error?: string;
}

export interface VerifyOtpResponse {
  success: boolean;
  verified?: boolean;
  message?: string;
  error?: string;
}

// Stores active Firebase confirmation session
let activeConfirmationResult: ConfirmationResult | null = null;
let recaptchaVerifier: RecaptchaVerifier | null = null;

export const OtpService = {
  /**
   * Initializes RecaptchaVerifier for Firebase Phone Auth (if needed)
   */
  getRecaptchaVerifier(containerId: string = 'recaptcha-container'): RecaptchaVerifier {
    if (!recaptchaVerifier) {
      recaptchaVerifier = new RecaptchaVerifier(firebaseAuth, containerId, {
        size: 'invisible',
        callback: () => {
          console.log('[Firebase Auth] Recaptcha verified');
        },
      });
    }
    return recaptchaVerifier;
  },

  /**
   * Sends a 6-digit SMS OTP using Firebase Phone Auth (10,000 Free SMS/month).
   */
  async sendSmsOtp(phone: string): Promise<SendOtpResponse> {
    try {
      // Clean and normalize phone number (e.g. +60123456789)
      let formattedPhone = phone.trim().replace(/\s+/g, '');
      if (!formattedPhone.startsWith('+')) {
        if (formattedPhone.startsWith('60')) {
          formattedPhone = `+${formattedPhone}`;
        } else if (formattedPhone.startsWith('0')) {
          formattedPhone = `+60${formattedPhone.substring(1)}`;
        } else {
          formattedPhone = `+${formattedPhone}`;
        }
      }

      // Initialize invisible recaptcha verifier
      const verifier = this.getRecaptchaVerifier();

      // Trigger Firebase SMS send
      activeConfirmationResult = await signInWithPhoneNumber(firebaseAuth, formattedPhone, verifier);

      return {
        success: true,
        message: 'SMS verification code sent via Firebase (Free Tier)',
      };
    } catch (err: any) {
      console.error('[OtpService] Firebase sendSmsOtp error:', err);
      return {
        success: false,
        error: err.message || 'Failed to send SMS verification code',
      };
    }
  },

  /**
   * Verifies the 6-digit SMS OTP code using Firebase Phone Auth confirmation result.
   */
  async verifySmsOtp(phone: string, otp: string): Promise<VerifyOtpResponse> {
    try {
      if (!activeConfirmationResult) {
        return {
          success: false,
          error: 'Verification session expired. Please request a new code.',
        };
      }

      // Confirm OTP with Firebase
      const credential = await activeConfirmationResult.confirm(otp.trim());

      // Update Supabase profile as verified
      if (credential && credential.user) {
        try {
          const { data: { user } } = await supabase.auth.getUser();
          if (user) {
            await supabase
              .from('profiles')
              .update({ is_verified: true, phone_number: phone })
              .eq('id', user.id);
          }
        } catch (subErr) {
          console.warn('[OtpService] Supabase profile sync error:', subErr);
        }
      }

      return {
        success: true,
        verified: true,
        message: 'Phone number verified successfully via Firebase',
      };
    } catch (err: any) {
      console.error('[OtpService] Firebase verifySmsOtp error:', err);
      return {
        success: false,
        error: err.message || 'Invalid verification code',
      };
    }
  },

  // Aliases for compatibility
  sendWhatsAppOtp(phone: string): Promise<SendOtpResponse> {
    return this.sendSmsOtp(phone);
  },
  verifyWhatsAppOtp(phone: string, otp: string): Promise<VerifyOtpResponse> {
    return this.verifySmsOtp(phone, otp);
  },
};
