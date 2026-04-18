# CareerWiki `/api/admin/metrics/v1` — Read-only metrics endpoint SPEC

Status: **SPEC ONLY — no code change in this document's lifecycle.**
Created: 2026-04-17
Owner: Jason (CEO) / implementation to be queued by a future CareerWiki
session under explicit CEO approval.

This document is the interface contract between CareerWiki (producer) and
wikicomu.com (consumer). CareerWiki's runtime code is **not** modified by
the act of creating this file. Implementation is deferred to Phase 1 of
the wikicomu.com roadmap, and guarded by the standing order "CareerWiki is
READ-ONLY from the Wikicomu-Org operating system."

Companion docs (outside this repo):
- `Wikicomu-Org/products/wikicomu-site/SPEC.md` §8 (why the endpoint exists)
- `Wikicomu-Org/products/wikicomu-site/ROADMAP.md` Decisions Log #2, #6
- `Wikicomu-Org/products/wikicomu-site/PHASE0-CHECKLIST.md` §5

---

## 1. Purpose

wikicomu.com (internal ops dashboard) needs **read-only** aggregate metrics
from CareerWiki — total job count, enhance progress, recent processing
activity — to render `/products/careerwiki` and drive a nightly Cron Trigger
that writes time-series rows into wikicomu.com's `status_snapshots` D1 table.

This endpoint gives wikicomu.com exactly that surface, and **nothing else**.
No mutation, no PII, no per-user data.

## 2. Non-goals

This spec deliberately does NOT cover:

- User-level analytics (DAU/MAU by cohort, per-user events). Aggregate
  counts only.
- PII of any kind (no emails, IPs, session IDs in the response).
- Write operations — this is a strict `GET`.
- Exposing raw rows from `jobs` / `majors` / `users` — only counts and
  derived stats.

## 3. Route

```
GET /api/admin/metrics/v1
```

- Path is **versioned**. Any backwards-incompatible schema change requires
  `/v2`; `/v1` stays readable until the consumer cuts over (per ROADMAP
  Decisions Log #6 coupling rule).
- Mount in a **new file** `src/routes/metrics.ts` (not `admin.ts`) to
  keep the admin route's blast radius clean (per RISKS.md §f3).
- Query parameters:
  - `?scope=jobs` | `?scope=majors` | `?scope=all` (default `all`)
    — lets the consumer ask for a subset without paying the full
    aggregation cost.
  - `?fresh=1` — bypass the server-side cache for one request (for
    debugging; rate-limited). Absent by default.

## 4. Authentication

### 4.1 Header

```
X-Metrics-Secret: <value of env METRICS_SECRET>
```

- New env var **`METRICS_SECRET`** — deliberately **separate** from the
  existing `ADMIN_SECRET` / `X-Admin-Secret` pair (per SPEC §8 and
  RISKS.md §b2).
- Rationale: if wikicomu.com's env leaks, the attacker gets read-only
  aggregate metrics access only — **not** the ability to hit CareerWiki's
  admin-write endpoints (`/admin/api/reindex`, `/api/job/:id/edit`, etc.).
- On CareerWiki: register with `wrangler secret put METRICS_SECRET` in
  the same Cloudflare Pages project (careerwiki).
- On wikicomu.com: store the same value under a distinct binding name
  `CAREERWIKI_METRICS_SECRET`. That naming keeps the two sides
  unambiguous in grep / env diffs.
- Rotation: annual. On rotation, both sides must be updated in the same
  deploy window (new value written on CareerWiki first, then wikicomu.com
  redeployed with the new consumer secret).

### 4.2 Failure modes

| Condition | Status | Body |
|---|---|---|
| Header missing | 401 | `{"error":"X-Metrics-Secret header required"}` |
| Header present, mismatch | 403 | `{"error":"invalid metrics secret"}` |
| Secret env not configured on CareerWiki | 503 | `{"error":"metrics endpoint not configured"}` |

No timing-safe compare is required beyond a simple `===` — the secret is a
single consumer's long-lived token; a microsecond timing side channel is
not a meaningful risk at this scope. Keep it simple.

### 4.3 What this endpoint does NOT accept

- Bearer tokens (reserved for future `/api/agents/*` if any).
- Session cookies.
- `X-Admin-Secret` — explicitly rejected even if valid, to preserve
  blast-radius separation. A request carrying ONLY `X-Admin-Secret` (no
  `X-Metrics-Secret`) returns 401.

## 5. Response schema (v1)

### 5.1 JSON shape

```ts
type MetricsV1Response = {
  success: true
  version: "v1"
  generated_at: string   // ISO-8601, UTC
  cache: {
    hit: boolean         // true if served from 60s server-side cache
    age_seconds: number  // 0..60
  }
  totals: {
    jobs_active: number         // COUNT(*) FROM jobs WHERE is_active = 1
    majors_active: number       // COUNT(*) FROM majors WHERE is_active = 1
  }
  enhance: {
    // Derived from wiki_logs rows with `skill_marker LIKE '%[job-data-enhance]%'`
    // and '[major-data-enhance]' respectively, distinct by target id.
    jobs_applied: number
    majors_applied: number
    jobs_today: number          // applied with timestamp within "today" in Asia/Seoul
    majors_today: number
    last_applied_at: string | null  // ISO-8601, MAX across both markers
  }
  quality: {
    // Field-completeness buckets from user_contributed_json parsing
    // (EQUALIZE_FIELDS = 12 fields; see admin.ts job-equalize).
    jobs: QualityBuckets
    majors: QualityBuckets
  }
  youtube_links: {
    // Per admin.ts: youtubeCount = length of parsed.youtubeLinks array;
    // "sufficient" = youtubeCount >= 3.
    jobs_sufficient: number
    jobs_low: number            // < 3 (or missing)
    majors_sufficient: number
    majors_low: number
  }
  phase_progress: {
    // Coarse progress signals for the dashboard top-line.
    // Numerator: enhance.jobs_applied. Denominator: totals.jobs_active.
    jobs_pct: number            // 0..100 integer
    majors_pct: number
  }
}

type QualityBuckets = {
  contributed: number   // rows with user_contributed_json IS NOT NULL
  perfect: number       // fieldCount === 12
  poor: number          // fieldCount < 6
  avg_json_size: number // bytes, rounded
}
```

### 5.2 Sample response

```json
{
  "success": true,
  "version": "v1",
  "generated_at": "2026-04-17T11:50:00.123Z",
  "cache": { "hit": false, "age_seconds": 0 },
  "totals": { "jobs_active": 1247, "majors_active": 683 },
  "enhance": {
    "jobs_applied": 412,
    "majors_applied": 178,
    "jobs_today": 9,
    "majors_today": 3,
    "last_applied_at": "2026-04-17T10:45:31.000Z"
  },
  "quality": {
    "jobs":   { "contributed": 930, "perfect": 188, "poor": 221, "avg_json_size": 2417 },
    "majors": { "contributed": 512, "perfect":  92, "poor": 164, "avg_json_size": 1983 }
  },
  "youtube_links": {
    "jobs_sufficient": 401,
    "jobs_low": 846,
    "majors_sufficient": 158,
    "majors_low": 525
  },
  "phase_progress": { "jobs_pct": 33, "majors_pct": 26 }
}
```

### 5.3 Error shape

All non-2xx responses share the shape:

```json
{ "success": false, "error": "<human-readable>", "code": "<stable-enum>" }
```

Stable error codes:

| code | meaning |
|---|---|
| `AUTH_MISSING` | No `X-Metrics-Secret` header |
| `AUTH_INVALID` | Header present, value does not match |
| `NOT_CONFIGURED` | `METRICS_SECRET` env not set on the worker |
| `RATE_LIMITED` | Per-IP or global cap exceeded |
| `QUERY_FAILED` | D1 error during aggregation |
| `INTERNAL` | Catch-all unexpected error |

## 6. Caching

### 6.1 Server-side (CareerWiki worker)

- Use the `KV` binding (existing `KV` namespace on CareerWiki) with key
  `metrics:v1:<scope>` and TTL = **60 seconds**.
- On cache miss: run all aggregation queries in parallel
  (`Promise.all`), assemble the response, write to KV with
  `expirationTtl: 60`.
- Expose the hit state in `response.cache` (see §5.1).
- `?fresh=1` skips the KV read but still writes the fresh result back
  to KV. Fresh bypass is rate-limited at 10 req/hour per IP (see §7).

### 6.2 Consumer-side (wikicomu.com)

- wikicomu.com additionally caches the response in its own KV namespace
  (`WIKICOMU_KV`) with key `careerwiki:metrics:v1:<scope>`, TTL = 60s.
- This gives wikicomu.com pages sub-50ms render even if CareerWiki's
  KV read is slow.
- Nightly mirror Cron Trigger calls with `?fresh=1`, writes the full
  response JSON to `status_snapshots` (one row per scalar metric, with
  `scope='careerwiki'`, `metric=<field_name>`, `captured_at=now`).

## 7. Rate limiting

- **Per-IP**: 60 requests/minute (generous for a server-to-server
  consumer; tight enough to kill runaway loops).
- **Global (endpoint-wide)**: 600 requests/minute — a defensive ceiling
  that also catches misbehaving cron triggers.
- **`?fresh=1` sub-budget**: 10 requests/hour per IP.
- Exceeding any bucket returns 429 with code `RATE_LIMITED` and a
  `Retry-After` header in seconds.
- Implementation: `KV` counter with 60s expiry, keyed by IP; atomic
  via `get-then-put` (acceptable race at this traffic level).

## 8. Performance budget

- p50 response time with cache hit: **< 50ms** (edge → KV read → return).
- p50 with cache miss: **< 250ms** — 5–7 aggregation queries in parallel
  against D1. None of these are full table scans; all use `is_active`
  and the existing indexes.
- If a query ever exceeds 500ms, it moves to a nightly `metrics_snapshot`
  row (pre-aggregated) and the endpoint becomes a pointer read (per
  RISKS.md §f2).

## 9. Metric-to-table map (implementation reference)

| Metric | Source |
|---|---|
| `totals.jobs_active` | `SELECT COUNT(*) FROM jobs WHERE is_active = 1` |
| `totals.majors_active` | `SELECT COUNT(*) FROM majors WHERE is_active = 1` |
| `enhance.jobs_applied` | `SELECT COUNT(DISTINCT target_id) FROM wiki_logs WHERE note LIKE '%[job-data-enhance]%'` (adjust column names to match existing `wiki_logs` / skill-tracker schema) |
| `enhance.majors_applied` | same, `%[major-data-enhance]%` |
| `enhance.{jobs,majors}_today` | same with `created_at >= start_of_today_seoul_kst` |
| `enhance.last_applied_at` | `SELECT MAX(created_at) FROM wiki_logs WHERE note LIKE ...` |
| `quality.*.contributed` | `COUNT WHERE user_contributed_json IS NOT NULL` |
| `quality.*.perfect` / `.poor` / `.avg_json_size` | Mirror `admin.ts` job-equalize aggregation — parse `user_contributed_json`, count 12-field matches; if cost is high, switch to a pre-computed column or a nightly snapshot table. |
| `youtube_links.*_sufficient` | `... AND json_array_length(json_extract(user_contributed_json,'$.youtubeLinks')) >= 3` |
| `youtube_links.*_low` | `totals.*_active` minus `*_sufficient` (cheap). |
| `phase_progress.*_pct` | Derived: `round(enhance.*_applied / totals.*_active * 100)`. |

Note: column/table names in the "enhance" rows above must be reconciled
with the actual CareerWiki schema during implementation. The authoritative
marker strings (`[job-data-enhance]`, `[major-data-enhance]`) match
`src/routes/admin.ts` line 1019 at time of writing.

## 10. Deployment constraints (per RISKS.md)

- §b1 / §f1: The CareerWiki deploy that ships this route must **not**
  collide with an active `job-data-enhance` skill batch. Jason files a
  directive authorizing the deploy in a quiet window.
- §f3: Route lives in `src/routes/metrics.ts`, **not** in `admin.ts`.
- §b4: Nightly cron on wikicomu.com only; live reads go through the 60s
  KV cache on both sides.

## 11. Test plan (for the implementation session)

1. **Unit-ish**: each aggregation query runs in isolation against a
   local D1 (`wrangler d1 execute careerwiki-kr --local --file=...`),
   verifying the numbers against a hand-counted fixture.
2. **Auth**: five request variants:
   - No header → 401 `AUTH_MISSING`.
   - Header, wrong value → 403 `AUTH_INVALID`.
   - Correct header → 200.
   - `X-Admin-Secret` only (no `X-Metrics-Secret`) → 401.
   - Env not configured → 503 `NOT_CONFIGURED`.
3. **Cache**: two requests within 60s should show `cache.hit=false` then
   `cache.hit=true`; `?fresh=1` forces miss.
4. **Rate limit**: burst 70 requests in 60s from a single IP → expect
   ≥10 × 429 with `Retry-After`.
5. **Regression on admin routes**: full admin route test suite passes
   unchanged — the new file must not shadow or reorder any existing
   Hono middleware.
6. **Consumer smoke test**: after deploy, wikicomu.com's
   `/products/careerwiki` page renders numbers matching a hand
   check against CareerWiki's `/admin/job-equalize` UI.

## 12. Explicitly deferred to later

- Time-series via this endpoint (the nightly mirror on wikicomu.com
  owns that).
- Per-section breakdowns (e.g., enhance count by skill version).
- Auth via OAuth/JWT (kept as a future option; not on critical path).
- Error-rate / latency metrics (Cloudflare Analytics provides those).

## 13. Revisions

Append-only. Newest on top. One line per revision.

- 2026-04-17 — Initial SPEC authored during wikicomu.com Phase 0
  (Step F of the Jason execution plan). No CareerWiki code changes
  in this session.
