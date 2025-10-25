import { storePerfMetrics } from '../src/services/perfMetricsService.js';
class MockKV {
    constructor() {
        this.storage = new Map();
    }
    async get(key) {
        return this.storage.has(key) ? this.storage.get(key) : null;
    }
    async put(key, value, _options) {
        if (typeof value === 'string') {
            this.storage.set(key, value);
            return;
        }
        if (value instanceof ArrayBuffer) {
            const decoded = Buffer.from(value).toString('utf8');
            this.storage.set(key, decoded);
            return;
        }
        if (value instanceof ReadableStream) {
            const reader = value.getReader();
            const chunks = [];
            for (;;) {
                const result = await reader.read();
                if (result.done)
                    break;
                if (result.value) {
                    chunks.push(result.value);
                }
            }
            const combined = Buffer.concat(chunks);
            this.storage.set(key, combined.toString('utf8'));
            return;
        }
        throw new Error('Unsupported value type for MockKV.put');
    }
    async delete(key) {
        this.storage.delete(key);
    }
    async list() {
        return {
            keys: Array.from(this.storage.keys()).map((key) => ({ name: key, expiration: null, metadata: null })),
            list_complete: true
        };
    }
}
function assert(condition, message) {
    if (!condition) {
        throw new Error(`Assertion failed: ${message}`);
    }
}
const createLargePayload = () => {
    const baseEvents = [
        {
            type: 'detail-action',
            action: 'x'.repeat(300),
            payload: {
                tabId: 'overview',
                previousTab: 'skills',
                duration: 1280,
                extra: { invalid: true }
            },
            entity: {
                type: 'job',
                id: 'job-growth-marketing-director',
                name: 'Growth Marketing Director',
                category: 'Marketing Leadership',
                sources: ['CAREERNET', 'GOYONG24']
            }
        },
        {
            type: 'hydration-complete',
            page: '/job',
            at: 123456.78,
            detail: {
                foo: 'bar',
                nested: {
                    count: 2,
                    flags: [true, false, 'ok']
                }
            },
            extraProperty: 'should be removed'
        }
    ];
    const overflowEvents = Array.from({ length: 118 }, (_, index) => ({
        type: 'detail-action',
        action: `extra-event-${index}`,
        duration: index
    }));
    return {
        timestamp: new Date('2025-10-08T12:34:56.000Z').toISOString(),
        reason: 'pagehide',
        url: `https://careerwiki.org/detail/${'a'.repeat(600)}`,
        userAgent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)',
        sampleRate: 0.3,
        sampled: true,
        metrics: {
            nav: {
                ttfb: 120,
                domInteractive: 340,
                domContentLoaded: 560,
                loadEvent: 890,
                transferSize: 45678
            },
            vitals: {
                fcp: { value: 123.45, reportedAt: 234.56 },
                lcp: { value: 789.01, size: 2048, reportedAt: 890.12 },
                cls: { value: 0.14, reportedAt: 321.09 }
            },
            hydration: {
                '/job/growth-marketing-director': {
                    duration: 2345.67,
                    completedAt: 3456.78,
                    detail: {
                        totalItems: 32,
                        sortKey: 'relevance'
                    }
                }
            },
            marks: {
                scriptLoadedAt: 12.34,
                extraMark: 'ok',
                invalidMark: { nested: true }
            },
            events: [...baseEvents, ...overflowEvents]
        }
    };
};
const run = async () => {
    const kv = new MockKV();
    const payload = createLargePayload();
    const { id } = await storePerfMetrics(kv, payload, { ip: '203.0.113.5' });
    assert(typeof id === 'string' && id.length > 0, 'storePerfMetrics should return an id');
    const storedRecordRaw = await kv.get(`perf:log:${id}`);
    assert(storedRecordRaw, 'perf record should be stored in KV');
    const storedRecord = JSON.parse(storedRecordRaw);
    assert(storedRecord.id === id, 'stored record id matches returned id');
    assert(storedRecord.meta.ip === '203.0.113.5', 'client IP persisted in meta');
    assert(storedRecord.metrics.nav.ttfb === 120, 'navigation metric preserved');
    assert(storedRecord.metrics.vitals.lcp.size === 2048, 'LCP size preserved');
    assert(storedRecord.metrics.hydration['/job/growth-marketing-director'].detail.sortKey === 'relevance', 'hydration detail preserved');
    // URL should be truncated to 500 characters plus ellipsis
    assert(typeof storedRecord.url === 'string', 'URL stored as string');
    assert(storedRecord.url.length <= 501, 'URL truncated to 500 characters plus ellipsis');
    assert(storedRecord.url.endsWith('…'), 'URL truncated with ellipsis');
    // Marks should filter out non string/number values
    assert(storedRecord.marks.scriptLoadedAt === 12.34, 'numeric mark preserved');
    assert(storedRecord.marks.extraMark === 'ok', 'string mark preserved');
    assert(!('invalidMark' in storedRecord.marks), 'invalid mark removed');
    // Events should be capped at 100 entries and sanitized
    assert(Array.isArray(storedRecord.events), 'events array exists');
    assert(storedRecord.events.length === 100, 'events capped at 100 entries');
    const firstEvent = storedRecord.events[0];
    assert(firstEvent.type === 'detail-action', 'first event type preserved');
    assert(firstEvent.action.length <= 201, 'action truncated to max length plus ellipsis');
    assert(firstEvent.entityType === 'job', 'entityType derived from entity payload');
    assert(Array.isArray(firstEvent.entitySources) && firstEvent.entitySources.length === 2, 'entity sources preserved and sanitized');
    assert(firstEvent.tabId === 'overview', 'tabId extracted from payload');
    assert(!('extra' in (firstEvent.detail ?? {})), 'unexpected nested detail removed');
    const secondEvent = storedRecord.events[1];
    assert(secondEvent.type === 'hydration-complete', 'second event sanitized with correct type');
    assert(secondEvent.page === '/job', 'page preserved');
    assert(secondEvent.detail.nested.flags.length === 3, 'nested arrays preserved up to depth limit');
    const lastEvent = storedRecord.events[storedRecord.events.length - 1];
    assert(lastEvent.action === 'extra-event-97', 'last included event corresponds to capping logic');
    const indexRaw = await kv.get('perf:log:index');
    assert(indexRaw, 'perf index should be stored');
    const index = JSON.parse(indexRaw);
    assert(Array.isArray(index.entries) && index.entries.length >= 1, 'index contains at least one entry');
    assert(index.entries[0].id === id, 'latest entry id stored at index head');
    assert(index.entries[0].url === storedRecord.url, 'index stores truncated URL');
    let errorCaught = false;
    try {
        await storePerfMetrics(kv, { reason: 'no-metrics' }, {});
    }
    catch (error) {
        errorCaught = error instanceof Error && error.message === 'No metrics provided';
    }
    assert(errorCaught, 'storePerfMetrics should reject payload without metrics');
    console.log('✅ Telemetry pipeline storage validation passed');
};
run().catch((error) => {
    console.error('❌ Telemetry pipeline validation failed');
    console.error(error);
    process.exit(1);
});
