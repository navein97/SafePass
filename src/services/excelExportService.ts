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
     * Internal helper to create the dynamic worksheet structure
     */
    createMasterUserWorksheet(stats: any[]): XLSX.WorkSheet {
        // Determine batch numbers present in the data (fallback to 1-8)
        const batchNumbers = stats.length > 0 && stats[0].batches
            ? stats[0].batches.map((b: any) => b.batchNumber)
            : [1, 2, 3, 4, 5, 6, 7, 8];

        // ROW 1: Merged Group Headers
        const row1: string[] = [
            '', '', '', '', // Driver Info (4 cols)
            'Overall Performance', '', // Overall Score & Rank (2 cols)
        ];

        // Add Batch Headers
        batchNumbers.forEach((num: number) => {
            row1.push(`Batch ${num}`, '');
        });

        // Add DPI and Management Intelligence headers
        row1.push(
            'DPI (Latest Completed Batch)', '', '', // DPI (3 cols)
            'Management Intelligence', '', '' // Management Intelligence (3 cols)
        );

        // ROW 2: Sub-headers
        const row2: string[] = [
            'Driver Name', 'Staff ID', 'Vehicle Type', 'Region',
            'Overall Score (%)', 'Rank',
        ];

        batchNumbers.forEach((num: number) => {
            row2.push(`B${num} Score`, `B${num} Status`);
        });

        row2.push(
            'Operational Effectiveness (Latest Batch)',
            'Operational Discipline (Latest Batch)',
            'Professional Conduct (Latest Batch)',
            'Priority #1 Focus Area',
            'Current Risk Level',
            'Management Action'
        );

        // Prepare data rows
        const dataRows = stats.map(user => {
            const row: any[] = [
                user.userName,
                user.staffId,
                user.vehicleType || '-',
                user.region,
                `${user.overallScore ?? user.csiPercentage ?? 0}%`,
                `${user.rank || user.proHayatBand || 'D Rank'}`,
            ];

            // 1. Add Batch Data (2 cols per batch: Score, Status)
            batchNumbers.forEach((num: number) => {
                const batch = user.batches?.find((b: any) => b.batchNumber === num);
                if (batch && batch.attemptCount > 0) {
                    const isCompleted = batch.completion >= 100 || batch.isCompleted;
                    const statusText = isCompleted ? 'Completed' : `In Progress (${Math.round(batch.completion)}%)`;
                    row.push(`${batch.accuracy}%`, statusText);
                } else {
                    row.push('-', 'Not Started');
                }
            });

            // 2. Determine Latest Completed Batch
            const completedBatches = user.batches?.filter((b: any) => (b.completion >= 100 || b.isCompleted) && b.componentScores) || [];
            let latestBatch = completedBatches.length > 0 ? completedBatches[completedBatches.length - 1] : null;

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

        // Dynamic Merges for Row 1
        const merges: XLSX.Range[] = [
            // Overall Performance (cols 4, 5)
            { s: { r: 0, c: 4 }, e: { r: 0, c: 5 } },
        ];

        let colIdx = 6;
        batchNumbers.forEach(() => {
            merges.push({ s: { r: 0, c: colIdx }, e: { r: 0, c: colIdx + 1 } });
            colIdx += 2;
        });

        // DPI
        merges.push({ s: { r: 0, c: colIdx }, e: { r: 0, c: colIdx + 2 } });
        colIdx += 3;

        // Management Intelligence
        merges.push({ s: { r: 0, c: colIdx }, e: { r: 0, c: colIdx + 2 } });

        // Merge header & subheader for first 4 columns
        merges.push(
            { s: { r: 0, c: 0 }, e: { r: 1, c: 0 } },
            { s: { r: 0, c: 1 }, e: { r: 1, c: 1 } },
            { s: { r: 0, c: 2 }, e: { r: 1, c: 2 } },
            { s: { r: 0, c: 3 }, e: { r: 1, c: 3 } }
        );

        ws['!merges'] = merges;

        // Column widths
        ws['!cols'] = [
            { wch: 20 }, { wch: 15 }, { wch: 15 }, { wch: 12 }, // Basic Info
            { wch: 36 }, { wch: 34 }, { wch: 32 }, // DPI (Latest Batch)
            { wch: 28 }, { wch: 18 }, { wch: 65 }  // Management Intelligence
        ];

        return ws;
    }
};
