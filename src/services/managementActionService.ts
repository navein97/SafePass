export interface DPIScores {
    operation: number;      // Operational Effectiveness (OE)
    discipline: number;     // Operational Discipline (OD)
    professionalism: number;// Professional Conduct (PC)
}

export interface DPIAnalysisResult {
    priorityRanking: Array<{
        key: 'operation' | 'discipline' | 'professionalism';
        label: string;
        score: number;
    }>;
    priority1: {
        key: 'operation' | 'discipline' | 'professionalism';
        label: string;
        score: number;
    };
    riskLevel: 'Low Risk' | 'Medium Risk' | 'High Risk';
    managementAction: string;
}

const ACTION_TEMPLATES: Record<string, Record<'High Risk' | 'Medium Risk' | 'Low Risk', string>> = {
    operation: {
        'High Risk': 'Prioritise improvement in hazard awareness, operational judgment, and defensive driving techniques.',
        'Medium Risk': 'Monitor defensive driving practices and reinforce hazard identification skills.',
        'Low Risk': 'Maintain strong operational awareness and share best practices with team members.'
    },
    discipline: {
        'High Risk': 'Prioritise improvement in compliance with regulations, SOPs, and operational discipline requirements.',
        'Medium Risk': 'Reinforce adherence to company policies, daily check routines, and standard operating procedures.',
        'Low Risk': 'Maintain high standards of operational compliance and safety protocol adherence.'
    },
    professionalism: {
        'High Risk': 'Prioritise coaching in professional conduct, customer representation, and workplace accountability.',
        'Medium Risk': 'Support ongoing development in professional communication and conduct standards.',
        'Low Risk': 'Maintain exemplary professional conduct and positive brand representation.'
    }
};

export const ManagementActionService = {
    /**
     * Analyzes DPI scores and returns priority ranking, risk level, and management action statement.
     */
    analyzeDPI(scores: DPIScores): DPIAnalysisResult {
        const components = [
            { key: 'operation' as const, label: 'Operational Effectiveness', score: Math.round(scores.operation || 0) },
            { key: 'discipline' as const, label: 'Operational Discipline', score: Math.round(scores.discipline || 0) },
            { key: 'professionalism' as const, label: 'Professional Conduct', score: Math.round(scores.professionalism || 0) }
        ];

        // Sort from lowest score (Priority #1) to highest score (Priority #3)
        const priorityRanking = [...components].sort((a, b) => a.score - b.score);
        const priority1 = priorityRanking[0];

        // Risk Level determination (Weakest link rule: if Priority #1 score < 60 -> High Risk; < 80 -> Medium Risk; >= 80 -> Low Risk)
        let riskLevel: 'Low Risk' | 'Medium Risk' | 'High Risk' = 'Low Risk';
        if (priority1.score < 60) {
            riskLevel = 'High Risk';
        } else if (priority1.score < 80) {
            riskLevel = 'Medium Risk';
        }

        const managementAction = ACTION_TEMPLATES[priority1.key][riskLevel];

        return {
            priorityRanking,
            priority1,
            riskLevel,
            managementAction
        };
    }
};
