/**
 * Date utility functions for SafePass.
 * Handles UTC+8 (Malaysia / Singapore / SGT / MYT) timezone boundaries cleanly
 * and consistently, regardless of the client device's local timezone.
 */

export const UTC8_OFFSET_MS = 8 * 60 * 60 * 1000;
export const ONE_DAY_MS = 24 * 60 * 60 * 1000;

/**
 * Returns a Date object corresponding to 00:00:00.000 UTC+8 of today (or given Date),
 * represented as an absolute UTC Date.
 * 
 * Example: On 2026-09-24 in Malaysia (UTC+8), midnight UTC+8 is:
 * 2026-09-24 00:00:00.000 +08:00 === 2026-09-23 16:00:00.000 UTC.
 * 
 * Any event with completed_at >= this timestamp occurred on the current calendar day in UTC+8.
 */
export function getStartOfTodayUtc8(d: Date = new Date()): Date {
    const utc8Time = d.getTime() + UTC8_OFFSET_MS;
    const startOfDayInUtc8Ms = Math.floor(utc8Time / ONE_DAY_MS) * ONE_DAY_MS;
    return new Date(startOfDayInUtc8Ms - UTC8_OFFSET_MS);
}

/**
 * Returns timestamp in milliseconds for 00:00:00.000 UTC+8 of today (or given Date).
 */
export function getStartOfTodayUtc8Ms(d: Date = new Date()): number {
    return getStartOfTodayUtc8(d).getTime();
}

/**
 * Returns the YYYY-MM-DD date string for the given Date in UTC+8 timezone.
 */
export function getUtc8DateString(d: Date = new Date()): string {
    const mytDate = new Date(d.getTime() + UTC8_OFFSET_MS);
    return mytDate.toISOString().split('T')[0];
}
