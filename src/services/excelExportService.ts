import * as XLSX from 'xlsx';
import { BatchService } from './batchService';
import * as FileSystem from 'expo-file-system/legacy';
import * as Sharing from 'expo-sharing';
import { Platform } from 'react-native';

export const ExcelExportService = {
    /**
     * Export leaderboard to Excel format matching client template
     */
    async exportLeaderboard(): Promise<{ success: boolean; message?: string }> {
        try {
            const stats = await BatchService.getAllUsersBatchStats();
            const ws = this.createMasterUserWorksheet(stats);

            // Create workbook
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, 'Master User Report');

            // Generate filename
            const timestamp = new Date().toISOString().split('T')[0];
            const filename = `Driver360_Report_${timestamp}.xlsx`;

            if (Platform.OS === 'web') {
                XLSX.writeFile(wb, filename);
                return { success: true };
            } else {
                const base64 = XLSX.write(wb, { type: 'base64', bookType: 'xlsx' });
                const fileUri = `${FileSystem.documentDirectory}${filename}`;
                
                await FileSystem.writeAsStringAsync(fileUri, base64, {
                    encoding: FileSystem.EncodingType.Base64
                });

                const canShare = await Sharing.isAvailableAsync();
                if (canShare) {
                    await Sharing.shareAsync(fileUri, {
                        mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                        dialogTitle: 'Export Report',
                        UTI: 'com.microsoft.excel.xls'
                    });
                    return { success: true };
                } else {
                    return { success: false, message: 'Sharing is not available on this device' };
                }
            }
        } catch (error: any) {
            console.error('Error exporting to Excel:', error);
            return { success: false, message: error?.message || 'Failed to export' };
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
            'Batch 5', '', '', '', '',
            'Batch 6', '', '', '', '',
            'Batch 7', '', '', '', '',
            'Batch 8', '', '', '', '',
            'DOPD', '', '',
            'Risk Level'
        ];

        // ROW 2: Sub-headers
        const row2 = [
            'Driver Name', 'Staff ID', 'Vehicle Type', 'Region',
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 1
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 2
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 3
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 4
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 5
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 6
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 7
            'Marks', 'Target MCQ', 'Accuracy %', 'Attempted', 'Complete %', // Batch 8
            'Operational Effectiveness',
            'Operational Discipline',
            'Professional Conduct'
        ];

        // Prepare data rows
        const dataRows = stats.map(user => {
            const row = [
                user.userName,
                user.staffId,
                user.vehicleType || '-',
                user.region
            ];

            let totalSafetyScore = 0;
            let batchCount = 0;

            // Add 8 batches of data
            [1, 2, 3, 4, 5, 6, 7, 8].forEach(num => {
                const batch = user.batches.find((b: any) => b.batchNumber === num);
                if (batch && batch.attemptCount > 0) {
                    const marks = Math.round((batch.averageScore / 100) * 30);
                    const mcqAttempted = Math.round((batch.completion / 100) * 30); // actual questions they saw
                    row.push(
                        marks,
                        30, // Target MCQ is always 30
                        `${batch.accuracy}%`,
                        mcqAttempted,
                        `${batch.completion}%`
                    );
                    totalSafetyScore += batch.averageScore;
                    batchCount++;
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

            // Risk Level based on average score across batches
            const safetyIndex = batchCount > 0 ? Math.round(totalSafetyScore / batchCount) : 0;
            let riskLevel = 'High Risk';
            if (safetyIndex >= 80) riskLevel = 'Low Risk';
            else if (safetyIndex >= 60) riskLevel = 'Medium Risk';
            row.push(riskLevel);

            return row;
        });

        const ws = XLSX.utils.aoa_to_sheet([row1, row2, ...dataRows]);

        // Define Merges
        ws['!merges'] = [
            { s: { r: 0, c: 4 }, e: { r: 0, c: 8 } },   // Batch 1
            { s: { r: 0, c: 9 }, e: { r: 0, c: 13 } },  // Batch 2
            { s: { r: 0, c: 14 }, e: { r: 0, c: 18 } }, // Batch 3
            { s: { r: 0, c: 19 }, e: { r: 0, c: 23 } }, // Batch 4
            { s: { r: 0, c: 24 }, e: { r: 0, c: 28 } }, // Batch 5
            { s: { r: 0, c: 29 }, e: { r: 0, c: 33 } }, // Batch 6
            { s: { r: 0, c: 34 }, e: { r: 0, c: 38 } }, // Batch 7
            { s: { r: 0, c: 39 }, e: { r: 0, c: 43 } }, // Batch 8
            { s: { r: 0, c: 44 }, e: { r: 0, c: 46 } }, // DOPD
            { s: { r: 0, c: 47 }, e: { r: 1, c: 47 } }, // Risk Level
            // Merge labels in Row 1 & 2 for first 4 columns
            { s: { r: 0, c: 0 }, e: { r: 1, c: 0 } },
            { s: { r: 0, c: 1 }, e: { r: 1, c: 1 } },
            { s: { r: 0, c: 2 }, e: { r: 1, c: 2 } },
            { s: { r: 0, c: 3 }, e: { r: 1, c: 3 } },
        ];

        // Column widths
        ws['!cols'] = [
            { wch: 20 }, { wch: 15 }, { wch: 15 }, { wch: 10 }, // Basic Info
            ...Array(40).fill({ wch: 11 }), // 8 batches x 5 cols
            { wch: 18 }, { wch: 18 }, { wch: 18 }, // DOPD
            { wch: 14 } // Risk Level
        ];

        return ws;
    },
};
