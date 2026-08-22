import { useState, useEffect, useCallback, useRef } from 'react';
import { CacheService, formatTimeAgo, isDataEqual } from '../services/cacheService';

export interface UseCachedDataOptions<T> {
  timeoutMs?: number; // Background fetch timeout (default 5000ms)
  enabled?: boolean; // Condition to run (default true)
  intervalUpdateMs?: number; // How often to update the "X ago" label (default 30000ms)
  onSuccess?: (data: T) => void;
  onError?: (err: any) => void;
}

export interface UseCachedDataResult<T> {
  data: T | null;
  isLoading: boolean; // True only if NO cached data is available yet
  isRevalidating: boolean; // True while background network fetch is in progress
  lastUpdated: number | null; // Unix timestamp
  lastUpdatedText: string; // e.g. "Just now", "2m ago"
  refresh: () => Promise<void>; // Trigger manual revalidation
}

/**
 * Custom hook implementing Cache-First (Stale-While-Revalidate) strategy.
 *
 * 1. Immediately renders data from AsyncStorage if available (0 network wait).
 * 2. If no cache exists, sets isLoading: true (skeleton / spinner).
 * 3. In parallel, fetches fresh data in the background with a 5-second timeout.
 * 4. Deep-compares fresh data against cached data — only updates storage & state if data changed.
 * 5. Fails silently on network errors or timeouts without blocking the user.
 * 6. Updates a live "Last updated X ago" string on a 30s interval.
 */
export function useCachedData<T>(
  key: string | null,
  fetcher: () => Promise<T>,
  options: UseCachedDataOptions<T> = {}
): UseCachedDataResult<T> {
  const {
    timeoutMs = 5000,
    enabled = true,
    intervalUpdateMs = 30000,
    onSuccess,
    onError,
  } = options;

  const [data, setData] = useState<T | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [isRevalidating, setIsRevalidating] = useState<boolean>(false);
  const [lastUpdated, setLastUpdated] = useState<number | null>(null);
  const [lastUpdatedText, setLastUpdatedText] = useState<string>('');

  const dataRef = useRef<T | null>(null);
  dataRef.current = data;

  const fetcherRef = useRef(fetcher);
  fetcherRef.current = fetcher;

  // Background revalidation
  const revalidate = useCallback(
    async (cachedData: T | null) => {
      if (!key) return;
      setIsRevalidating(true);

      try {
        const freshData = await CacheService.fetchWithTimeout(
          () => fetcherRef.current(),
          timeoutMs
        );

        if (freshData !== undefined && freshData !== null) {
          // Compare against cached data — only update if actually changed
          if (!cachedData || !isDataEqual(cachedData, freshData)) {
            await CacheService.set(key, freshData);
            setData(freshData);
            const now = Date.now();
            setLastUpdated(now);
            setLastUpdatedText(formatTimeAgo(now));
          }
          onSuccess?.(freshData);
        }
      } catch (error) {
        // Fail silently — keep showing cached data without blocking or showing an error
        console.warn(`[useCachedData] Background revalidation failed for "${key}":`, error);
        onError?.(error);
      } finally {
        setIsRevalidating(false);
        setIsLoading(false);
      }
    },
    [key, timeoutMs, onSuccess, onError]
  );

  // Initial load
  useEffect(() => {
    if (!enabled || !key) {
      setIsLoading(false);
      return;
    }

    let isMounted = true;

    const init = async () => {
      // 1. Immediately read from cache
      const cached = await CacheService.get<T>(key);

      if (!isMounted) return;

      if (cached && cached.data !== null && cached.data !== undefined) {
        // Immediately render cached data
        setData(cached.data);
        setLastUpdated(cached.lastUpdated);
        setLastUpdatedText(formatTimeAgo(cached.lastUpdated));
        setIsLoading(false); // No skeleton needed since we have cached data
      } else {
        setIsLoading(true); // Show skeleton until first fetch completes
      }

      // 2. Fetch fresh data in the background
      revalidate(cached ? cached.data : null);
    };

    init();

    return () => {
      isMounted = false;
    };
  }, [key, enabled, revalidate]);

  // Live timer update for "Last updated X ago"
  useEffect(() => {
    if (!lastUpdated) return;

    // Immediately update text
    setLastUpdatedText(formatTimeAgo(lastUpdated));

    // Update on interval (e.g. every 30s)
    const interval = setInterval(() => {
      setLastUpdatedText(formatTimeAgo(lastUpdated));
    }, intervalUpdateMs);

    return () => clearInterval(interval);
  }, [lastUpdated, intervalUpdateMs]);

  // Manual refresh trigger
  const refresh = useCallback(async () => {
    if (!key) return;
    const cached = await CacheService.get<T>(key);
    await revalidate(cached ? cached.data : dataRef.current);
  }, [key, revalidate]);

  return {
    data,
    isLoading,
    isRevalidating,
    lastUpdated,
    lastUpdatedText,
    refresh,
  };
}
