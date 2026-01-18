export type Region = 'MY' | 'PT';

export interface Driver {
    id: string;
    name: string;
    employeeId: string;
    region: Region;
    safetyIndex: number; // 0-100
    componentScores?: {
        operation: number;
        professionalism: number;
        discipline: number;
    };
    lastQuizDate?: string; // ISO string
    role?: 'staff' | 'manager';
    streak?: number;
    shieldHealth?: number;
    totalScore?: number;
    age?: number;
    vehicleType?: 'Motorcycle' | 'Car' | 'Truck' | 'Bus';
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
    componentWeights?: {
        operation?: number; // e.g. 70
        professionalism?: number;
        discipline?: number; // e.g. 30
    };
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

export interface Notification {
    id: string;
    userId: string;
    title: string;
    message: string;
    type: 'system' | 'achievement' | 'mission' | 'alert';
    isRead: boolean;
    createdAt: string;
}

export interface Post {
    id: string;
    userId: string;
    user?: {
        full_name: string;
        region: Region;
    };
    content: string;
    image_url?: string;
    likes_count: number;
    created_at: string;
}
