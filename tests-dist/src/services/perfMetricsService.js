const PERF_LOG_PREFIX = 'perf:log:';
const PERF_LOG_INDEX_KEY = 'perf:log:index';
const PERF_LOG_TTL_SECONDS = 60 * 60 * 24 * 7; // 7일 보관
const PERF_INDEX_MAX = 200;
const truncate = (value, max = 500) => {
    if (!value)
        return undefined;
    return value.length > max ? `${value.slice(0, max)}…` : value;
};
const hashUserAgent = async (ua) => {
    if (!ua || typeof crypto?.subtle === 'undefined')
        return undefined;
    const encoder = new TextEncoder();
    const data = encoder.encode(ua);
    const digest = await crypto.subtle.digest('SHA-256', data);
    const bytes = Array.from(new Uint8Array(digest));
    return bytes.map((b) => b.toString(16).padStart(2, '0')).join('').slice(0, 32);
};
const sanitizeMetrics = (payload) => {
    const result = {};
    if (payload.metrics?.nav) {
        result.nav = payload.metrics.nav;
    }
    if (payload.metrics?.vitals) {
        result.vitals = payload.metrics.vitals;
    }
    if (payload.metrics?.hydration) {
        result.hydration = payload.metrics.hydration;
    }
    return result;
};
const sanitizeMarks = (marks) => {
    if (!marks)
        return undefined;
    const allowed = {};
    for (const [key, value] of Object.entries(marks)) {
        if (typeof value === 'number' || typeof value === 'string') {
            allowed[key] = value;
        }
    }
    return Object.keys(allowed).length ? allowed : undefined;
};
const sanitizeEventString = (value, max = 200) => {
    if (typeof value !== 'string')
        return undefined;
    const trimmed = value.trim();
    if (!trimmed)
        return undefined;
    return truncate(trimmed, max);
};
const sanitizeEventNumber = (value) => {
    if (typeof value !== 'number' || !Number.isFinite(value))
        return undefined;
    return value;
};
const sanitizeEventBoolean = (value) => {
    if (typeof value !== 'boolean')
        return undefined;
    return value;
};
const sanitizeEventStringArray = (value, options = {}) => {
    if (!Array.isArray(value))
        return undefined;
    const maxItems = options.maxItems ?? 12;
    const maxLength = options.maxLength ?? 120;
    const items = value
        .filter((item) => typeof item === 'string')
        .map((item) => sanitizeEventString(item, maxLength))
        .filter((item) => !!item)
        .slice(0, maxItems);
    return items.length ? items : undefined;
};
const sanitizeEventDetail = (value, depth = 0) => {
    if (depth > 3)
        return undefined;
    if (typeof value === 'string') {
        return sanitizeEventString(value, 500);
    }
    if (typeof value === 'number') {
        return sanitizeEventNumber(value);
    }
    if (typeof value === 'boolean') {
        return value;
    }
    if (!value || typeof value !== 'object') {
        return undefined;
    }
    if (Array.isArray(value)) {
        const items = value
            .map((item) => sanitizeEventDetail(item, depth + 1))
            .filter((item) => item !== undefined)
            .slice(0, 20);
        return items.length ? items : undefined;
    }
    const result = {};
    for (const [key, val] of Object.entries(value)) {
        const sanitized = sanitizeEventDetail(val, depth + 1);
        if (sanitized !== undefined) {
            result[key] = sanitized;
        }
    }
    return Object.keys(result).length ? result : undefined;
};
const sanitizeEventEntry = (entry) => {
    if (!entry || typeof entry !== 'object') {
        return undefined;
    }
    const raw = entry;
    const type = sanitizeEventString(raw.type, 80) ?? 'unknown';
    const result = { type };
    const page = sanitizeEventString(raw.page, 200);
    if (page !== undefined) {
        result.page = page;
    }
    const at = sanitizeEventNumber(raw.at);
    if (at !== undefined) {
        result.at = at;
    }
    const detail = sanitizeEventDetail(raw.detail);
    if (detail !== undefined) {
        result.detail = detail;
    }
    const rawPayload = raw.payload && typeof raw.payload === 'object' && raw.payload !== null
        ? raw.payload
        : undefined;
    const action = sanitizeEventString(raw.action, 200) ?? (rawPayload ? sanitizeEventString(rawPayload.action, 200) : undefined);
    if (action !== undefined) {
        result.action = action;
    }
    const rawEntity = raw.entity && typeof raw.entity === 'object' && raw.entity !== null
        ? raw.entity
        : undefined;
    const entityType = sanitizeEventString(raw.entityType, 60) ?? (rawEntity ? sanitizeEventString(rawEntity.type, 60) : undefined);
    if (entityType !== undefined) {
        result.entityType = entityType;
    }
    const entityId = sanitizeEventString(raw.entityId, 120) ?? (rawEntity ? sanitizeEventString(rawEntity.id, 120) : undefined);
    if (entityId !== undefined) {
        result.entityId = entityId;
    }
    const entityName = sanitizeEventString(raw.entityName, 120) ?? (rawEntity ? sanitizeEventString(rawEntity.name, 120) : undefined);
    if (entityName !== undefined) {
        result.entityName = entityName;
    }
    const entityCategory = sanitizeEventString(raw.entityCategory, 120) ?? (rawEntity ? sanitizeEventString(rawEntity.category, 120) : undefined);
    if (entityCategory !== undefined) {
        result.entityCategory = entityCategory;
    }
    const entitySources = sanitizeEventStringArray(raw.entitySources ?? (rawEntity ? rawEntity.sources : undefined), { maxItems: 10, maxLength: 60 });
    if (entitySources !== undefined) {
        result.entitySources = entitySources;
    }
    const tabId = sanitizeEventString(raw.tabId, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.tabId, 60) : undefined);
    if (tabId !== undefined) {
        result.tabId = tabId;
    }
    const previousTab = sanitizeEventString(raw.previousTab, 60) ??
        (rawPayload ? sanitizeEventString(rawPayload.previousTab, 60) : undefined);
    if (previousTab !== undefined) {
        result.previousTab = previousTab;
    }
    const totalTabs = sanitizeEventNumber(raw.totalTabs) ?? (rawPayload ? sanitizeEventNumber(rawPayload.totalTabs) : undefined);
    if (totalTabs !== undefined) {
        result.totalTabs = totalTabs;
    }
    const tabCount = sanitizeEventNumber(raw.tabCount) ?? (rawPayload ? sanitizeEventNumber(rawPayload.tabCount) : undefined);
    if (tabCount !== undefined) {
        result.tabCount = tabCount;
    }
    const duration = sanitizeEventNumber(raw.duration) ?? (rawPayload ? sanitizeEventNumber(rawPayload.duration) : undefined);
    if (duration !== undefined) {
        result.duration = duration;
    }
    const perPage = sanitizeEventNumber(raw.perPage) ?? (rawPayload ? sanitizeEventNumber(rawPayload.perPage) : undefined);
    if (perPage !== undefined) {
        result.perPage = perPage;
    }
    const resultsValue = sanitizeEventNumber(raw.results) ?? (rawPayload ? sanitizeEventNumber(rawPayload.results) : undefined);
    if (resultsValue !== undefined) {
        result.results = resultsValue;
    }
    const keywordLength = sanitizeEventNumber(raw.keywordLength) ??
        (rawPayload ? sanitizeEventNumber(rawPayload.keywordLength) : undefined);
    if (keywordLength !== undefined) {
        result.keywordLength = keywordLength;
    }
    const phase = sanitizeEventString(raw.phase, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.phase, 60) : undefined);
    if (phase !== undefined) {
        result.phase = phase;
    }
    const sortKey = sanitizeEventString(raw.sortKey, 120) ?? (rawPayload ? sanitizeEventString(rawPayload.sortKey, 120) : undefined);
    if (sortKey !== undefined) {
        result.sortKey = sortKey;
    }
    const cacheStatus = sanitizeEventString(raw.cacheStatus, 60) ??
        (rawPayload ? sanitizeEventString(rawPayload.cacheStatus, 60) : undefined);
    if (cacheStatus !== undefined) {
        result.cacheStatus = cacheStatus;
    }
    const ctaType = sanitizeEventString(raw.ctaType, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.ctaType, 60) : undefined);
    if (ctaType !== undefined) {
        result.ctaType = ctaType;
    }
    const href = sanitizeEventString(raw.href, 500) ?? (rawPayload ? sanitizeEventString(rawPayload.href, 500) : undefined);
    if (href !== undefined) {
        result.href = href;
    }
    const method = sanitizeEventString(raw.method, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.method, 60) : undefined);
    if (method !== undefined) {
        result.method = method;
    }
    const outcome = sanitizeEventString(raw.outcome, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.outcome, 60) : undefined);
    if (outcome !== undefined) {
        result.outcome = outcome;
    }
    const status = sanitizeEventString(raw.status, 60) ?? (rawPayload ? sanitizeEventString(rawPayload.status, 60) : undefined);
    if (status !== undefined) {
        result.status = status;
    }
    const intent = sanitizeEventString(raw.intent, 120) ?? (rawPayload ? sanitizeEventString(rawPayload.intent, 120) : undefined);
    if (intent !== undefined) {
        result.intent = intent;
    }
    const visible = sanitizeEventBoolean(raw.visible) ?? (rawPayload ? sanitizeEventBoolean(rawPayload.visible) : undefined);
    if (visible !== undefined) {
        result.visible = visible;
    }
    const expanded = sanitizeEventBoolean(raw.expanded) ?? (rawPayload ? sanitizeEventBoolean(rawPayload.expanded) : undefined);
    if (expanded !== undefined) {
        result.expanded = expanded;
    }
    const tabs = sanitizeEventStringArray(raw.tabs ?? (rawPayload ? rawPayload.tabs : undefined), {
        maxItems: 16,
        maxLength: 60
    });
    if (tabs !== undefined) {
        result.tabs = tabs;
    }
    const partials = sanitizeEventStringArray(raw.partials ?? (rawPayload ? rawPayload.partials : undefined), {
        maxItems: 16,
        maxLength: 60
    });
    if (partials !== undefined) {
        result.partials = partials;
    }
    const sourceStatus = sanitizeEventStringArray(raw.sourceStatus ?? (rawPayload ? rawPayload.sourceStatus : undefined), { maxItems: 16, maxLength: 60 });
    if (sourceStatus !== undefined) {
        result.sourceStatus = sourceStatus;
    }
    return result;
};
const sanitizeEvents = (events) => {
    if (!Array.isArray(events) || events.length === 0) {
        return undefined;
    }
    const rawEvents = events;
    const sanitized = rawEvents
        .slice(0, 100)
        .map((entry) => sanitizeEventEntry(entry))
        .filter((entry) => entry !== undefined);
    return sanitized.length ? sanitized : undefined;
};
export const storePerfMetrics = async (kv, payload, options = {}) => {
    if (!payload || typeof payload !== 'object') {
        throw new Error('Invalid payload');
    }
    const receivedAt = Date.now();
    const uniqueSuffix = typeof crypto?.randomUUID === 'function' ? crypto.randomUUID() : Math.random().toString(36).slice(2);
    const id = `${receivedAt}-${uniqueSuffix}`;
    const userAgent = truncate(payload.userAgent, 500);
    const metrics = sanitizeMetrics(payload);
    if (!metrics.nav && !metrics.vitals && !metrics.hydration) {
        throw new Error('No metrics provided');
    }
    const record = {
        id,
        receivedAt,
        clientTimestamp: payload.timestamp,
        reason: truncate(payload.reason, 120),
        url: truncate(payload.url, 500),
        userAgent,
        sampleRate: payload.sampleRate,
        sampled: payload.sampled,
        metrics,
        marks: sanitizeMarks(payload.metrics?.marks),
        events: sanitizeEvents(payload.metrics?.events),
        meta: {
            ip: options.ip,
            userAgentHash: userAgent ? await hashUserAgent(userAgent) : undefined
        }
    };
    const storageKey = `${PERF_LOG_PREFIX}${id}`;
    await kv.put(storageKey, JSON.stringify(record), { expirationTtl: PERF_LOG_TTL_SECONDS });
    await updatePerfMetricsIndex(kv, {
        id,
        receivedAt,
        reason: record.reason,
        url: record.url
    });
    return { id };
};
const updatePerfMetricsIndex = async (kv, entry) => {
    let current = {
        entries: [],
        updatedAt: Date.now()
    };
    try {
        const raw = await kv.get(PERF_LOG_INDEX_KEY);
        if (raw) {
            const parsed = JSON.parse(raw);
            if (Array.isArray(parsed.entries)) {
                current.entries = parsed.entries;
            }
        }
    }
    catch (error) {
        console.warn('[perf-metrics] index parse failed', error);
    }
    current.entries = [entry, ...current.entries].slice(0, PERF_INDEX_MAX);
    current.updatedAt = Date.now();
    await kv.put(PERF_LOG_INDEX_KEY, JSON.stringify(current), { expirationTtl: PERF_LOG_TTL_SECONDS });
};
