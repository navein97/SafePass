export type Region = 'MY' | 'PT';

export interface Driver {
    id: string;
    name: string;
    employeeId: string;
    region: Region;
    safetyIndex: number; // 0-100
    lastQuizDate?: string; // ISO string
    role?: 'staff' | 'manager';
}

export interface Question {
    id: string;
    text: string;
    options: string[];
    correctOptionIndex: number;
    explanation: string;
    region: Region[]; // Applicable regions
    category: string;
    imageUrl?: string; // Optional image URL for visual questions
}

export interface QuizAttempt {
    id: string;
    driverId: string;
    date: string; // ISO string
    score: number; // 0-100
    answers: {
        questionId: string;
        selectedOptionIndex: number;
        isCorrect: boolean;
    }[];
    weekNumber: number;
    year: number;
}

export interface ComplianceRecord {
    id: string;
    driverId: string;
    weekNumber: number;
    year: number;
    status: 'COMPLIANT' | 'OVERDUE';
    completedAt?: string;
    score?: number;
    signature: string; // HMAC signature for tamper-proofing
}
