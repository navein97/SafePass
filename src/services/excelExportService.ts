import * as XLSX from 'xlsx';
import { BatchService } from './batchService';
import { ManagementActionService } from './managementActionService';
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
            const filename = `ProHayat180_Report_${timestamp}.xlsx`;

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
     * Internal helper to create the complex worksheet structure (V2.0 Layout - 26 Columns)
     */
    createMasterUserWorksheet(stats: any[]): XLSX.WorkSheet {
        // ROW 1: Merged Group Headers
        const row1 = [
            '', '', '', '', // Driver Info (4 cols)
            'Batch 1', '', 'Batch 2', '', 'Batch 3', '', 'Batch 4', '',
            'Batch 5', '', 'Batch 6', '', 'Batch 7', '', 'Batch 8', '', // Batch Data (16 cols)
            'DPI (Latest Completed Batch)', '', '', // DPI (3 cols)
            'Management Intelligence', '', '' // Management Intelligence (3 cols)
        ];

        // ROW 2: Sub-headers
        const row2 = [
            'Driver Name', 'Staff ID', 'Vehicle Type', 'Region',
            'B1 Score', 'B1 Status',
            'B2 Score', 'B2 Status',
            'B3 Score', 'B3 Status',
            'B4 Score', 'B4 Status',
            'B5 Score', 'B5 Status',
            'B6 Score', 'B6 Status',
            'B7 Score', 'B7 Status',
            'B8 Score', 'B8 Status',
            'Operational Effectiveness (Latest Batch)',
            'Operational Discipline (Latest Batch)',
            'Professional Conduct (Latest Batch)',
            'Priority #1 Focus Area',
            'Current Risk Level',
            'Management Action'
        ];

        // Prepare data rows
        const dataRows = stats.map(user => {
            const row: any[] = [
                user.userName,
                user.staffId,
                user.vehicleType || '-',
                user.region
            ];

            // 1. Add Batch Data (16 columns: 8 batches x [Score, Status])
            [1, 2, 3, 4, 5, 6, 7, 8].forEach(num => {
                const batch = user.batches?.find((b: any) => b.batchNumber === num);
                if (batch && batch.attemptCount > 0) {
                    const isCompleted = batch.completion >= 100 || batch.isCompleted;
                    const statusText = isCompleted ? 'Completed' : `In Progress (${Math.round((batch.completion / 100) * 30)}/30)`;
                    row.push(`${batch.accuracy}%`, statusText);
                } else {
                    row.push('-', 'Not Started');
                }
            });

            // 2. Determine Latest Completed Batch (or fallback to latest attempted)
            const completedBatches = user.batches?.filter((b: any) => (b.completion >= 100 || b.isCompleted) && b.componentScores) || [];
            let latestBatch = completedBatches.length > 0 ? completedBatches[completedBatches.length - 1] : null;

            // Fallback if no completed batch exists yet
            if (!latestBatch) {
                const attempted = user.batches?.filter((b: any) => b.attemptCount > 0 && b.componentScores) || [];
                if (attempted.length > 0) {
                    latestBatch = attempted[attempted.length - 1];
                }
            }

            // 3. Calculate DPI & Management Intelligence
            if (latestBatch && latestBatch.componentScores) {
                const dpiAnalysis = ManagementActionService.analyzeDPI(latestBatch.componentScores);
                row.push(
                    `${Math.round(latestBatch.componentScores.operation || 0)}%`,
                    `${Math.round(latestBatch.componentScores.discipline || 0)}%`,
                    `${Math.round(latestBatch.componentScores.professionalism || 0)}%`,
                    dpiAnalysis.priority1.label,
                    dpiAnalysis.riskLevel,
                    dpiAnalysis.managementAction
                );
            } else {
                row.push('0%', '0%', '0%', 'N/A', 'High Risk', 'No quiz attempts recorded.');
            }

            return row;
        });

        const ws = XLSX.utils.aoa_to_sheet([row1, row2, ...dataRows]);

        // Define Merges for Row 1
        ws['!merges'] = [
            { s: { r: 0, c: 4 }, e: { r: 0, c: 5 } },   // Batch 1
            { s: { r: 0, c: 6 }, e: { r: 0, c: 7 } },   // Batch 2
            { s: { r: 0, c: 8 }, e: { r: 0, c: 9 } },   // Batch 3
            { s: { r: 0, c: 10 }, e: { r: 0, c: 11 } }, // Batch 4
            { s: { r: 0, c: 12 }, e: { r: 0, c: 13 } }, // Batch 5
            { s: { r: 0, c: 14 }, e: { r: 0, c: 15 } }, // Batch 6
            { s: { r: 0, c: 16 }, e: { r: 0, c: 17 } }, // Batch 7
            { s: { r: 0, c: 18 }, e: { r: 0, c: 19 } }, // Batch 8
            { s: { r: 0, c: 20 }, e: { r: 0, c: 22 } }, // DPI
            { s: { r: 0, c: 23 }, e: { r: 0, c: 25 } }, // Management Intelligence
            // Merge header & subheader for first 4 columns
            { s: { r: 0, c: 0 }, e: { r: 1, c: 0 } },
            { s: { r: 0, c: 1 }, e: { r: 1, c: 1 } },
            { s: { r: 0, c: 2 }, e: { r: 1, c: 2 } },
            { s: { r: 0, c: 3 }, e: { r: 1, c: 3 } },
        ];

        // Column widths
        ws['!cols'] = [
            { wch: 20 }, { wch: 15 }, { wch: 15 }, { wch: 12 }, // Basic Info
            ...Array(16).fill({ wch: 14 }), // 8 batches x 2 cols
            { wch: 36 }, { wch: 34 }, { wch: 32 }, // DPI (Latest Batch)
            { wch: 28 }, { wch: 18 }, { wch: 65 }  // Management Intelligence
        ];

        return ws;
    }
};
