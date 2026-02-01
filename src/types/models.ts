export type Region = 'MY' | 'PT' | 'TH' | 'SG';

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
    vehicleType?: 'Container Haulage' | 'Curtain Side' | 'Open Cargo' | 'Small Truck' | 'Tanker' | string;
    // Master User Fields
    managerLevel?: 1 | 2;
    department?: string;
    division?: string;
    area?: string;
}

export interface Question {
    id: string;
    text: string;
    text_ms?: string; // Malay translation
    options: string[];
    options_ms?: string[]; // Malay options
    correctOptionIndex: number;
    explanation: string;
    explanation_ms?: string; // Malay explanation
    region: Region[]; // Applicable regions
    category: string;
    imageUrl?: string; // Optional image URL for visual questions
    difficulty: 'easy' | 'intermediate' | 'hard';
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
