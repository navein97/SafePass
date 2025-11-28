import * as SecureStore from 'expo-secure-store';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { ComplianceRecord, QuizAttempt } from '../types/models';
import * as Crypto from 'expo-crypto';

// Keys
const KEYS = {
    COMPLIANCE_LOG: 'compliance_log',
    DRIVER_PROFILE: 'driver_profile',
    LAST_QUIZ_DATE: 'last_quiz_date',
    QUIZ_ATTEMPTS: 'quiz_attempts',
};

// Helper to generate HMAC signature
const generateSignature = async (data: string): Promise<string> => {
    // In a real app, this key should be securely managed or derived
    const secretKey = 'safe-pass-secure-key-v1';
    const signature = await Crypto.digestStringAsync(
        Crypto.CryptoDigestAlgorithm.SHA256,
        data + secretKey
    );
    return signature;
};

export const StorageService = {
    // Save compliance record securely
    async saveComplianceRecord(record: Omit<ComplianceRecord, 'signature'>) {
        try {
            const dataString = JSON.stringify(record);
            const signature = await generateSignature(dataString);

            const fullRecord: ComplianceRecord = {
                ...record,
                signature,
            };

            // Get existing logs
            const existingLogsStr = await SecureStore.getItemAsync(KEYS.COMPLIANCE_LOG);
            const existingLogs: ComplianceRecord[] = existingLogsStr ? JSON.parse(existingLogsStr) : [];

            // Add new record
            const updatedLogs = [fullRecord, ...existingLogs];

            // Save back to SecureStore
            await SecureStore.setItemAsync(KEYS.COMPLIANCE_LOG, JSON.stringify(updatedLogs));

            return true;
        } catch (error) {
            console.error('Error saving compliance record:', error);
            return false;
        }
    },

    // Get compliance logs and verify integrity
    async getComplianceLogs(): Promise<{ logs: ComplianceRecord[], isTampered: boolean }> {
        try {
            const logsStr = await SecureStore.getItemAsync(KEYS.COMPLIANCE_LOG);
            if (!logsStr) return { logs: [], isTampered: false };

            const logs: ComplianceRecord[] = JSON.parse(logsStr);
            let isTampered = false;

            // Verify each record
            for (const log of logs) {
                const { signature, ...data } = log;
                const dataString = JSON.stringify(data);
                const expectedSignature = await generateSignature(dataString);

                if (signature !== expectedSignature) {
                    isTampered = true;
                    break;
                }
            }

            return { logs, isTampered };
        } catch (error) {
            console.error('Error reading compliance logs:', error);
            return { logs: [], isTampered: false };
        }
    },

    // Save quiz attempt (AsyncStorage for non-sensitive data)
    async saveQuizAttempt(attempt: QuizAttempt) {
        try {
            const attemptsStr = await AsyncStorage.getItem(KEYS.QUIZ_ATTEMPTS);
            const attempts = attemptsStr ? JSON.parse(attemptsStr) : [];
            attempts.push(attempt);
            await AsyncStorage.setItem(KEYS.QUIZ_ATTEMPTS, JSON.stringify(attempts));
        } catch (error) {
            console.error('Error saving quiz attempt:', error);
        }
    },

    async getQuizAttempts(): Promise<QuizAttempt[]> {
        try {
            const attemptsStr = await AsyncStorage.getItem(KEYS.QUIZ_ATTEMPTS);
            return attemptsStr ? JSON.parse(attemptsStr) : [];
        } catch (error) {
            console.error('Error getting quiz attempts:', error);
            return [];
        }
    }
};
