(function () {
  const METRICS_ENDPOINT = '/api/perf-metrics';
  const ENABLE_BEACON = true;
  const SAMPLING_RATE = 0.3; // 30% 샘플링
  const isSampled = Math.random() < SAMPLING_RATE;

  const metrics = {
    nav: {},
    vitals: {},
    hydration: {},
    marks: {
      scriptLoadedAt: typeof performance !== 'undefined' ? performance.now() : 0
    },
    events: [],
    sampling: {
      rate: SAMPLING_RATE,
      sampled: isSampled
    }
  };

  const state = {
    flushed: false,
    hydrationSeen: new Set()
  };

  window.CareerWikiMetrics = metrics;

  const safeNow = () => (typeof performance !== 'undefined' ? performance.now() : Date.now());

  const sanitizeString = (value, max = 200) => {
    if (typeof value !== 'string') {
      return undefined;
    }
    const trimmed = value.trim();
    if (!trimmed) {
      return undefined;
    }
    return trimmed.length > max ? trimmed.slice(0, max) : trimmed;
  };

  const sanitizeNumber = (value) => {
    if (typeof value !== 'number' || !Number.isFinite(value)) {
      return undefined;
    }
    return value;
  };

  const sanitizeBoolean = (value) => {
    if (typeof value !== 'boolean') {
      return undefined;
    }
    return value;
  };

  const sanitizeStringArray = (value, maxItems = 12, maxLength = 120) => {
    if (!Array.isArray(value)) {
      return undefined;
    }
    const normalized = value
      .filter((item) => typeof item === 'string')
      .map((item) => sanitizeString(item, maxLength))
      .filter((item) => item !== undefined)
      .slice(0, maxItems);
    return normalized.length ? normalized : undefined;
  };

  const recordDetailAction = (event) => {
    const detail = (event && event.detail) || {};
    const payload = detail && typeof detail.payload === 'object' && detail.payload !== null ? detail.payload : {};
    const entity = detail && typeof detail.entity === 'object' && detail.entity !== null ? detail.entity : null;

    const normalized = {
      type: 'detail-action',
      at: sanitizeNumber(detail.at) ?? safeNow()
    };

    const action = sanitizeString(detail.action, 80);
    if (action !== undefined) {
      normalized.action = action;
    }

    const entityType = sanitizeString(entity?.type, 60);
    if (entityType !== undefined) {
      normalized.entityType = entityType;
    }

    const entityId = sanitizeString(entity?.id, 120);
    if (entityId !== undefined) {
      normalized.entityId = entityId;
    }

    const entityName = sanitizeString(entity?.name, 120);
    if (entityName !== undefined) {
      normalized.entityName = entityName;
    }

    const entityCategory = sanitizeString(entity?.category, 120);
    if (entityCategory !== undefined) {
      normalized.entityCategory = entityCategory;
    }

    const entitySources = sanitizeStringArray(entity?.sources, 10, 60);
    if (entitySources !== undefined) {
      normalized.entitySources = entitySources;
    }

    const tabId = sanitizeString(payload.tabId, 60);
    if (tabId !== undefined) {
      normalized.tabId = tabId;
    }

    const previousTab = sanitizeString(payload.previousTab, 60);
    if (previousTab !== undefined) {
      normalized.previousTab = previousTab;
    }

    const totalTabs = sanitizeNumber(payload.totalTabs);
    if (totalTabs !== undefined) {
      normalized.totalTabs = totalTabs;
    }

    const tabCount = sanitizeNumber(payload.tabCount);
    if (tabCount !== undefined) {
      normalized.tabCount = tabCount;
    }

    const duration = sanitizeNumber(payload.duration);
    if (duration !== undefined) {
      normalized.duration = duration;
    }

    const perPage = sanitizeNumber(payload.perPage);
    if (perPage !== undefined) {
      normalized.perPage = perPage;
    }

    const results = sanitizeNumber(payload.results);
    if (results !== undefined) {
      normalized.results = results;
    }

    const keywordLength = sanitizeNumber(payload.keywordLength);
    if (keywordLength !== undefined) {
      normalized.keywordLength = keywordLength;
    }

    const phase = sanitizeString(payload.phase, 60);
    if (phase !== undefined) {
      normalized.phase = phase;
    }

    const sortKey = sanitizeString(payload.sortKey, 120);
    if (sortKey !== undefined) {
      normalized.sortKey = sortKey;
    }

    const cacheStatus = sanitizeString(payload.cacheStatus, 60);
    if (cacheStatus !== undefined) {
      normalized.cacheStatus = cacheStatus;
    }

    const ctaType = sanitizeString(payload.ctaType, 60);
    if (ctaType !== undefined) {
      normalized.ctaType = ctaType;
    }

    const href = sanitizeString(payload.href, 500);
    if (href !== undefined) {
      normalized.href = href;
    }

    const method = sanitizeString(payload.method, 60);
    if (method !== undefined) {
      normalized.method = method;
    }

    const outcome = sanitizeString(payload.outcome, 60);
    if (outcome !== undefined) {
      normalized.outcome = outcome;
    }

    const status = sanitizeString(payload.status, 60);
    if (status !== undefined) {
      normalized.status = status;
    }

    const intent = sanitizeString(payload.intent, 120);
    if (intent !== undefined) {
      normalized.intent = intent;
    }

    const tabs = sanitizeStringArray(detail.tabs, 12, 60);
    if (tabs !== undefined) {
      normalized.tabs = tabs;
    }

    const partials = sanitizeStringArray(detail.partials, 12, 60);
    if (partials !== undefined) {
      normalized.partials = partials;
    }

    const sourceStatus = sanitizeStringArray(detail.sourceStatus, 12, 60);
    if (sourceStatus !== undefined) {
      normalized.sourceStatus = sourceStatus;
    }

    const visible = sanitizeBoolean(payload.visible);
    if (visible !== undefined) {
      normalized.visible = visible;
    }

    const expanded = sanitizeBoolean(payload.expanded);
    if (expanded !== undefined) {
      normalized.expanded = expanded;
    }

    metrics.events.push(normalized);
  };

  const recordNavigationMetrics = () => {
    if (typeof performance === 'undefined') {
      return;
    }

    const navigationEntry = performance.getEntriesByType && performance.getEntriesByType('navigation')[0];
    const timing = navigationEntry || performance.timing;
    if (!timing) return;

    const start = navigationEntry ? navigationEntry.startTime : 0;
    const requestStart = timing.requestStart || timing.fetchStart || 0;

    metrics.nav = {
      ttfb: timing.responseStart && requestStart ? Math.max(timing.responseStart - requestStart, 0) : null,
      domInteractive: timing.domInteractive ? Math.max(timing.domInteractive - start, 0) : null,
      domContentLoaded: timing.domContentLoadedEventEnd ? Math.max(timing.domContentLoadedEventEnd - start, 0) : null,
      loadEvent: timing.loadEventEnd ? Math.max(timing.loadEventEnd - start, 0) : null,
      transferSize: navigationEntry?.transferSize ?? null,
      encodedBodySize: navigationEntry?.encodedBodySize ?? null,
      decodedBodySize: navigationEntry?.decodedBodySize ?? null
    };
  };

  const observePerformance = () => {
    if (typeof PerformanceObserver === 'undefined') {
      return;
    }

    try {
      const paintObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
          if (entry.name === 'first-contentful-paint') {
            metrics.vitals.fcp = {
              value: entry.startTime,
              reportedAt: safeNow()
            };
          }
          if (entry.name === 'first-paint') {
            metrics.vitals.fp = {
              value: entry.startTime,
              reportedAt: safeNow()
            };
          }
        });
      });
      paintObserver.observe({ type: 'paint', buffered: true });
    } catch (error) {
      console.debug('[perf-metrics] paint observer unavailable', error);
    }

    try {
      const lcpObserver = new PerformanceObserver((list) => {
        const entries = list.getEntries();
        if (!entries.length) return;
        const lastEntry = entries[entries.length - 1];
        metrics.vitals.lcp = {
          value: lastEntry.startTime,
          size: lastEntry.size,
          reportedAt: safeNow()
        };
      });
      lcpObserver.observe({ type: 'largest-contentful-paint', buffered: true });
    } catch (error) {
      console.debug('[perf-metrics] lcp observer unavailable', error);
    }

    try {
      let clsValue = 0;
      const clsObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
          if (entry.hadRecentInput) return;
          clsValue += entry.value;
          metrics.vitals.cls = {
            value: clsValue,
            reportedAt: safeNow()
          };
        });
      });
      clsObserver.observe({ type: 'layout-shift', buffered: true });
    } catch (error) {
      console.debug('[perf-metrics] cls observer unavailable', error);
    }

    try {
      const fidObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
          metrics.vitals.fid = {
            value: entry.processingStart - entry.startTime,
            reportedAt: safeNow(),
            event: entry.name
          };
        });
      });
      fidObserver.observe({ type: 'first-input', buffered: true });
    } catch (error) {
      console.debug('[perf-metrics] fid observer unavailable', error);
    }
  };

  const recordHydration = (event) => {
    const detail = event?.detail || {};
    const pageKey = (detail.page || window.location.pathname || 'unknown').replace(/\/+$/, '') || '/';
    if (state.hydrationSeen.has(pageKey)) {
      return;
    }
    state.hydrationSeen.add(pageKey);

    const completedAt = safeNow();
    const startedAt = metrics.marks.scriptLoadedAt;
    metrics.hydration[pageKey] = {
      duration: Math.max(completedAt - startedAt, 0),
      completedAt,
      detail: {
        totalItems: detail.total ?? null,
        sortKey: detail.sort ?? null
      }
    };

    metrics.events.push({
      type: 'hydration-complete',
      page: pageKey,
      at: completedAt,
      detail: metrics.hydration[pageKey]
    });
  };

  const recordHydrationAction = (event) => {
    const detail = event?.detail || {};
    const payload = detail.payload || {};
    metrics.events.push({
      type: 'hydration-action',
      page: detail.page || null,
      action: detail.action || null,
      at: safeNow(),
      phase: payload.phase || null,
      duration: typeof payload.duration === 'number' ? payload.duration : null,
      perPage: typeof payload.perPage === 'number' ? payload.perPage : null,
      sortKey: payload.sortKey || null,
      keywordLength: typeof payload.keywordLength === 'number' ? payload.keywordLength : null,
      results: typeof payload.results === 'number' ? payload.results : null,
      cacheStatus: payload.cacheStatus || null
    });
  };

  const buildPayload = (reason) => {
    const snapshot = {
      timestamp: new Date().toISOString(),
      reason,
      url: window.location.href,
      userAgent: navigator.userAgent,
      sampleRate: SAMPLING_RATE,
      sampled: isSampled,
      metrics: {
        nav: metrics.nav,
        vitals: metrics.vitals,
        hydration: metrics.hydration,
        marks: metrics.marks,
        events: metrics.events
      }
    };
    return JSON.stringify(snapshot);
  };

  const flushMetrics = (reason = 'manual', options = {}) => {
    if (state.flushed) return;
    const force = options.force === true;
    if (!isSampled && !force) {
      return;
    }
    state.flushed = true;
    metrics.marks.flushedAt = safeNow();
    metrics.marks.flushReason = reason;

    const payload = buildPayload(reason);

    if (ENABLE_BEACON && navigator.sendBeacon) {
      try {
        const blob = new Blob([payload], { type: 'application/json' });
        navigator.sendBeacon(METRICS_ENDPOINT, blob);
      } catch (error) {
        console.warn('[perf-metrics] beacon failed, falling back to console', error);
        console.info('[perf-metrics]', JSON.parse(payload));
      }
    } else {
      console.info('[perf-metrics]', JSON.parse(payload));
    }
  };

  if (document.readyState === 'complete') {
    recordNavigationMetrics();
  } else {
    window.addEventListener('load', recordNavigationMetrics, { once: true });
  }

  observePerformance();

  window.addEventListener('cw-hydration-complete', recordHydration);
  window.addEventListener('cw-hydration-action', recordHydrationAction);
  window.addEventListener('cw-detail-action', recordDetailAction);

  window.addEventListener('pagehide', () => flushMetrics('pagehide'));
  document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'hidden') {
      flushMetrics('hidden');
    }
  });

  window.CareerWikiMetrics.flush = (reason = 'manual', force = false) => flushMetrics(reason, { force });
})();
