import React from 'react';
import { TouchableWithoutFeedback, Keyboard, Platform, View } from 'react-native';

interface Props {
  children: React.ReactNode;
}

export const KeyboardDismissView: React.FC<Props> = ({ children }) => {
  if (Platform.OS === 'web') {
    return <>{children}</>;
  }
  
  return (
    <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
      {children}
    </TouchableWithoutFeedback>
  );
};

export const PreventDismissView: React.FC<Props> = ({ children }) => {
  if (Platform.OS === 'web') {
    return <>{children}</>;
  }
  
  return (
    <TouchableWithoutFeedback>
      {children}
    </TouchableWithoutFeedback>
  );
};
