import React, { forwardRef, useImperativeHandle, useRef } from 'react';
import ConfirmHcaptcha from '@hcaptcha/react-native-hcaptcha';

export interface AppCaptchaProps {
  onVerify: (token: string) => void;
  onError: (error: string) => void;
  onCancel?: () => void;
}

export interface AppCaptchaRef {
  show: () => void;
}

const AppCaptcha = forwardRef<AppCaptchaRef, AppCaptchaProps>(({ onVerify, onError, onCancel }, ref) => {
  const captchaRef = useRef<any>(null);

  useImperativeHandle(ref, () => ({
    show: () => {
      if (captchaRef.current) {
        captchaRef.current.show();
      }
    }
  }));

  const onMessage = (event: any) => {
    if (event && event.nativeEvent.data) {
      const data = event.nativeEvent.data;
      if (['cancel'].includes(data)) {
        if (onCancel) onCancel();
        return;
      }
      if (['error', 'expired'].includes(data)) {
        onError('Captcha verification failed or expired.');
        return;
      }
      onVerify(data);
    }
  };

  return (
    <ConfirmHcaptcha
      ref={captchaRef}
      siteKey={process.env.EXPO_PUBLIC_HCAPTCHA_SITE_KEY || '8270cd1e-c924-43f2-acc6-d0fe308e90ec'}
      baseUrl="https://hcaptcha.com"
      languageCode="en"
      onMessage={onMessage}
      size="invisible"
    />
  );
});

export default AppCaptcha;
