import * as XLSX from 'xlsx';
import { BatchService } from './batchService';

export const ExcelExportService = {
    /**
     * Export leaderboard to Excel format matching client template
     */
    async exportLeaderboard(): Promise<void> {
        try {
            const stats = await BatchService.getAllUsersBatchStats();
            const ws = this.createMasterUserWorksheet(stats);

            // Create workbook
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, 'Master User Report');

            // Generate filename
            const timestamp = new Date().toISOString().split('T')[0];
            const filename = `SafePass_Report_${timestamp}.xlsx`;

            // Write file
            XLSX.writeFile(wb, filename);
            console.log(`✅ Excel file exported: ${filename}`);
        } catch (error) {
            console.error('Error exporting to Excel:', error);
            throw error;
        }
    },

    /**
     * Export leaderboard with Blob for React Native (web only)
     */
    async exportLeaderboardBlob(): Promise<Blob> {
        try {
            const stats = await BatchService.getAllUsersBatchStats();
            const ws = this.createMasterUserWorksheet(stats);

            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, 'Master User Report');

            // Write to binary string
            const wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });

            // Convert to Blob
            const buf = new ArrayBuffer(wbout.length);
            const view = new Uint8Array(buf);
            for (let i = 0; i < wbout.length; i++) {
                view[i] = wbout.charCodeAt(i) & 0xff;
            }

            return new Blob([buf], { type: 'application/octet-stream' });
        } catch (error) {
            console.error('Error creating Excel blob:', error);
            throw error;
        }
    },

    /**
     * Internal helper to create the complex worksheet structure
     */
    createMasterUserWorksheet(stats: any[]): XLSX.WorkSheet {
        // ROW 1: Merged Group Headers
        const row1 = [
            '', '', '', '', // Driver Name, Staff ID, Division, Region
            'Batch 1', '', '', '', '',
            'Batch 2', '', '', '', '',
            'Batch 3', '', '', '', '',
            'Batch 4', '', '', '', '',
            'DOPD', '', '',
            'Risk level',
            'Time/ Minutes'
        ];

        // ROW 2: Sub-headers
        const row2 = [
            'Driver Name', 'Staff ID', 'Division', 'Region',
            'Marks', 'MCQ', '%', 'MCQ', 'Batch %', // Batch 1
            'Marks', 'MCQ', '%', 'MCQ', 'Batch %', // Batch 2
            'Marks', 'MCQ', '%', 'MCQ', 'Batch %', // Batch 3
            'Marks', 'MCQ', '%', 'MCQ', 'Batch %', // Batch 4
            'Operational Excellence',
            'Operational Discipline',
            'Professional Conduct',
            '', // Risk level
            'Time/ Minutes'
        ];

        // Prepare data rows
        const dataRows = stats.map(user => {
            const row = [
                user.userName,
                user.staffId,
                user.division,
                user.region
            ];

            // Add 4 batches of data
            [1, 2, 3, 4].forEach(num => {
                const batch = user.batches.find((b: any) => b.batchNumber === num);
                if (batch && batch.attemptCount > 0) {
                    const marks = Math.round((batch.averageScore / 100) * 30);
                    const mcqAttempted = 30; // Based on image requirement
                    row.push(
                        marks,
                        mcqAttempted,
                        `${batch.accuracy}%`,
                        mcqAttempted,
                        `${batch.completion}%`
                    );
                } else {
                    row.push('', '', '', '', '');
                }
            });

            // DOPD (Average across all attempted batches)
            const attemptedBatches = user.batches.filter((b: any) => b.attemptCount > 0);

            if (attemptedBatches.length > 0) {
                const totalComponents = attemptedBatches.reduce((acc: any, batch: any) => ({
                    operation: acc.operation + batch.componentScores.operation,
                    discipline: acc.discipline + batch.componentScores.discipline,
                    professionalism: acc.professionalism + batch.componentScores.professionalism
                }), { operation: 0, discipline: 0, professionalism: 0 });

                const count = attemptedBatches.length;

                row.push(
                    `${Math.round(totalComponents.operation / count)}%`,
                    `${Math.round(totalComponents.discipline / count)}%`,
                    `${Math.round(totalComponents.professionalism / count)}%`
                );
            } else {
                row.push('0%', '0%', '0%');
            }

            // Risk Level (Placeholder or logic)
            row.push('Low');

            // Total Time in Minutes
            row.push(user.totalTimeMinutes);

            return row;
        });

        const ws = XLSX.utils.aoa_to_sheet([row1, row2, ...dataRows]);

        // Define Merges
        ws['!merges'] = [
            { s: { r: 0, c: 4 }, e: { r: 0, c: 8 } },   // Batch 1
            { s: { r: 0, c: 9 }, e: { r: 0, c: 13 } },  // Batch 2
            { s: { r: 0, c: 14 }, e: { r: 0, c: 18 } }, // Batch 3
            { s: { r: 0, c: 19 }, e: { r: 0, c: 23 } }, // Batch 4
            { s: { r: 0, c: 24 }, e: { r: 0, c: 26 } }, // DOPD
            { s: { r: 0, c: 27 }, e: { r: 1, c: 27 } }, // Risk level
            { s: { r: 0, c: 28 }, e: { r: 1, c: 28 } }, // Time/Minutes
            // Merge labels in Row 1 & 2 for first 4 columns
            { s: { r: 0, c: 0 }, e: { r: 1, c: 0 } },
            { s: { r: 0, c: 1 }, e: { r: 1, c: 1 } },
            { s: { r: 0, c: 2 }, e: { r: 1, c: 2 } },
            { s: { r: 0, c: 3 }, e: { r: 1, c: 3 } },
        ];

        // Column widths
        ws['!cols'] = [
            { wch: 20 }, { wch: 15 }, { wch: 10 }, { wch: 12 }, // Basic Info
            ...Array(20).fill({ wch: 8 }), // 4 batches x 5 cols
            { wch: 18 }, { wch: 18 }, { wch: 18 }, // DOPD
            { wch: 12 }, { wch: 15 } // Risk, Time
        ];

        return ws;
    },
};
