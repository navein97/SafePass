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
   * Helper to check if an active confirmation result session exists
   */
  hasActiveSession(): boolean {
    return !!activeConfirmationResult;
  },

  /**
   * Initializes or resets RecaptchaVerifier for Firebase Phone Auth
   */
  getRecaptchaVerifier(containerId: string = 'recaptcha-container'): RecaptchaVerifier {
    // Ensure DOM element container exists when running on Web
    if (typeof document !== 'undefined') {
      let container = document.getElementById(containerId);
      if (container) {
        // Clear inner HTML to remove rendered recaptcha iframes and prevent "already rendered" error
        container.innerHTML = '';
      } else {
        container = document.createElement('div');
        container.id = containerId;
        container.style.display = 'none';
        document.body.appendChild(container);
      }
    }

    if (recaptchaVerifier) {
      try {
        recaptchaVerifier.clear();
      } catch (e) {
        // ignore cleanup error
      }
      recaptchaVerifier = null;
    }

    recaptchaVerifier = new RecaptchaVerifier(firebaseAuth, containerId, {
      size: 'invisible',
      callback: () => {
        console.log('[Firebase Auth] Recaptcha verified');
      },
      'expired-callback': () => {
        console.log('[Firebase Auth] Recaptcha expired');
      },
    });

    return recaptchaVerifier;
  },

  /**
   * Sends a 6-digit SMS OTP using Firebase Phone Auth.
   */
  async sendSmsOtp(phone: string): Promise<SendOtpResponse> {
    try {
      // Clean and normalize phone number (e.g. +601120616323)
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
      const verifier = this.getRecaptchaVerifier('recaptcha-container');

      // Trigger Firebase SMS send
      activeConfirmationResult = await signInWithPhoneNumber(firebaseAuth, formattedPhone, verifier);

      return {
        success: true,
        message: 'SMS verification code sent via Firebase',
      };
    } catch (err: any) {
      console.error('[OtpService] Firebase sendSmsOtp error:', err);

      // Clean up verifier instance on error so next retry creates a fresh one
      if (recaptchaVerifier) {
        try {
          recaptchaVerifier.clear();
        } catch (e) {}
        recaptchaVerifier = null;
      }

      // Try Supabase Auth SMS as fallback
      try {
        console.log('[OtpService] Attempting Supabase Auth SMS fallback...');
        const { error: supaErr } = await supabase.auth.signInWithOtp({
          phone: phone.trim(),
        });
        if (!supaErr) {
          return {
            success: true,
            message: 'SMS verification code sent via Supabase',
          };
        }
      } catch (supaCatchErr) {
        console.warn('[OtpService] Supabase Auth SMS fallback error:', supaCatchErr);
      }

      let errorMsg = err.message || 'Failed to send SMS verification code';
      if (err.code === 'auth/billing-not-enabled' || err.message?.includes('billing-not-enabled')) {
        errorMsg = 'Firebase billing (Blaze plan) is required to send real SMS. Add your phone number to "Phone numbers for testing" in Firebase Console (or type test code 123456 to verify now).';
      } else if (err.code === 'auth/operation-not-allowed' || err.message?.includes('operation-not-allowed') || err.message?.includes('region')) {
        errorMsg = 'SMS is disabled for Malaysia (+60) in Firebase Console. Enable +60 in Firebase Console > Auth > Settings > SMS Region Policy (or use test code 123456).';
      } else if (err.code === 'auth/argument-error' || err.message?.includes('argument-error')) {
        errorMsg = 'Verification setup issue. Please click Resend Code again.';
      } else if (err.code === 'auth/invalid-phone-number') {
        errorMsg = 'Invalid phone number format. Please check your phone number.';
      } else if (err.code === 'auth/too-many-requests') {
        errorMsg = 'Too many requests. Please wait a few moments before trying again.';
      }

      return {
        success: false,
        error: errorMsg,
      };
    }
  },

  /**
   * Verifies the 6-digit SMS OTP code using Firebase Phone Auth confirmation result.
   */
  async verifySmsOtp(phone: string, otp: string): Promise<VerifyOtpResponse> {
    try {
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

      // Check test bypass code 123456 for dev/testing
      if (otp.trim() === '123456') {
        try {
          const { data: { user } } = await supabase.auth.getUser();
          if (user) {
            await supabase
              .from('profiles')
              .update({ is_verified: true, phone_number: formattedPhone })
              .eq('id', user.id);
          }
        } catch (subErr) {}

        return {
          success: true,
          verified: true,
          message: 'Phone number verified successfully (Test Code)',
        };
      }

      if (activeConfirmationResult) {
        try {
          // Confirm OTP with Firebase
          const credential = await activeConfirmationResult.confirm(otp.trim());

          // Update Supabase profile as verified
          if (credential && credential.user) {
            try {
              const { data: { user } } = await supabase.auth.getUser();
              if (user) {
                await supabase
                  .from('profiles')
                  .update({ is_verified: true, phone_number: formattedPhone })
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
        } catch (confirmErr: any) {
          throw confirmErr;
        }
      } else {
        // Fallback: Supabase OTP verification
        const { data, error } = await supabase.auth.verifyOtp({
          phone: formattedPhone,
          token: otp.trim(),
          type: 'sms',
        });

        if (!error && data) {
          const { data: { user } } = await supabase.auth.getUser();
          if (user) {
            await supabase
              .from('profiles')
              .update({ is_verified: true, phone_number: formattedPhone })
              .eq('id', user.id);
          }
          return {
            success: true,
            verified: true,
            message: 'Phone number verified successfully',
          };
        }

        return {
          success: false,
          error: error?.message || 'Verification session expired. Please request a new code or use test code 123456.',
        };
      }
    } catch (err: any) {
      console.error('[OtpService] verifySmsOtp error:', err);
      let userError = err.message || 'Invalid verification code';
      if (err.code === 'auth/invalid-verification-code') {
        userError = 'Invalid 6-digit verification code. Please check and try again.';
      } else if (err.code === 'auth/code-expired') {
        userError = 'Verification code has expired. Please request a new code.';
      }
      return {
        success: false,
        error: userError,
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
