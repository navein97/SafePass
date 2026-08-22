import AsyncStorage from '@react-native-async-storage/async-storage';

export interface CacheEntry<T> {
  data: T;
  lastUpdated: number; // Unix timestamp in ms
}

const CACHE_PREFIX = '@safepass_swr_';

/**
 * Utility to format timestamp into human-readable relative time (e.g., '2 minutes ago')
 */
export function formatTimeAgo(timestamp: number | null): string {
  if (!timestamp) return '';
  const now = Date.now();
  const diffSec = Math.max(0, Math.floor((now - timestamp) / 1000));

  if (diffSec < 10) return 'Just now';
  if (diffSec < 60) return `${diffSec}s ago`;
  const diffMin = Math.floor(diffSec / 60);
  if (diffMin < 60) return `${diffMin}m ago`;
  const diffHour = Math.floor(diffMin / 60);
  if (diffHour < 24) return `${diffHour}h ago`;
  const diffDays = Math.floor(diffHour / 24);
  return `${diffDays}d ago`;
}

/**
 * Deep equality check for primitives, arrays, and plain objects
 */
export function isDataEqual<T>(a: T, b: T): boolean {
  try {
    return JSON.stringify(a) === JSON.stringify(b);
  } catch {
    return false;
  }
}

export const CacheService = {
  /**
   * Get cached data and timestamp from AsyncStorage
   */
  async get<T>(key: string): Promise<CacheEntry<T> | null> {
    try {
      const raw = await AsyncStorage.getItem(CACHE_PREFIX + key);
      if (!raw) return null;
      return JSON.parse(raw) as CacheEntry<T>;
    } catch (err) {
      console.warn(`[CacheService] Failed to read key "${key}":`, err);
      return null;
    }
  },

  /**
   * Save data with current timestamp to AsyncStorage
   */
  async set<T>(key: string, data: T): Promise<void> {
    try {
      const entry: CacheEntry<T> = {
        data,
        lastUpdated: Date.now(),
      };
      await AsyncStorage.setItem(CACHE_PREFIX + key, JSON.stringify(entry));
    } catch (err) {
      console.warn(`[CacheService] Failed to write key "${key}":`, err);
    }
  },

  /**
   * Remove a cached item
   */
  async remove(key: string): Promise<void> {
    try {
      await AsyncStorage.removeItem(CACHE_PREFIX + key);
    } catch (err) {
      console.warn(`[CacheService] Failed to remove key "${key}":`, err);
    }
  },

  /**
   * Execute a fetcher with a strict timeout (defaults to 5000ms)
   */
  async fetchWithTimeout<T>(fetcher: () => Promise<T>, timeoutMs = 5000): Promise<T> {
    let timeoutHandle: any;
    const timeoutPromise = new Promise<never>((_, reject) => {
      timeoutHandle = setTimeout(() => {
        reject(new Error(`Fetch timed out after ${timeoutMs}ms`));
      }, timeoutMs);
    });

    try {
      const result = await Promise.race([fetcher(), timeoutPromise]);
      return result;
    } finally {
      clearTimeout(timeoutHandle);
    }
  },
};
