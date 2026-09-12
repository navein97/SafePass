import React, { forwardRef, useImperativeHandle, useRef } from 'react';
import HCaptcha from '@hcaptcha/react-hcaptcha';

export interface AppCaptchaProps {
  onVerify: (token: string) => void;
  onError: (error: string) => void;
  onCancel?: () => void;
}

export interface AppCaptchaRef {
  show: () => void;
}

const AppCaptcha = forwardRef<AppCaptchaRef, AppCaptchaProps>(({ onVerify, onError }, ref) => {
  const captchaRef = useRef<any>(null);

  useImperativeHandle(ref, () => ({
    show: () => {
      if (captchaRef.current) {
        captchaRef.current.execute();
      }
    }
  }));

  return (
    <HCaptcha
      ref={captchaRef}
      sitekey={process.env.EXPO_PUBLIC_HCAPTCHA_SITE_KEY || '8270cd1e-c924-43f2-acc6-d0fe308e90ec'}
      onVerify={onVerify}
      onError={(err) => onError(err || 'Captcha error')}
      onExpire={() => onError('Captcha expired')}
      size="invisible"
    />
  );
});

export default AppCaptcha;
