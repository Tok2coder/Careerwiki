/**
 * Rule OMEGA (2026-05-15) — 통합 body-source-marker mismatch 자동 스캔
 *
 * 화이트리스트 폐기 — _proseRaw·detailReady·_sources 키 자동 enumerate.
 * ZZ/ZZZ/ZZZZ는 특정 필드만 검사. OMEGA는 abilities·summary·duties 등
 * 새 영역도 별도 룰 추가 없이 검출.
 *
 * scripts/_shared/detect-patterns.cjs의 detectAllBodySourceMarkerMismatch TS port.
 * Cloudflare Workers (Hono) 런타임 호환.
 */

export type OmegaSeverity = 'FAIL' | 'WARN';

export type OmegaFinding = {
  rule:
    | 'bodyWithoutSources'
    | 'sourcesWithoutMarkers'
    | 'arrayBodyWithoutSources'
    | 'arrayBrokenRef'
    | 'arrayCluster'
    | 'orphanSources';
  area: 'prose' | 'array' | 'meta';
  field: string;
  bodyLen?: number;
  itemCount?: number;
  markerCount?: number;
  totalMarkers?: number;
  coveredItems?: number;
  srcsCount?: number;
  severity: OmegaSeverity;
};

const SIDEBAR_FIELDS_FORBIDDEN = new Set<string>([
  'sidebarJobs',
  'sidebarMajors',
  'sidebarCerts',
  'sidebarOrgs',
  'heroTags',
  'youtubeLinks',
  'careerTree',
]);

const SAL_PROTECTED = new Set<string>(['overviewSalary.sal']);

// careernet 원본 영역 — 사용자 편집 X, 출처 의무 약. prose 검사 제외.
const OMEGA_PROSE_EXCLUDE = new Set<string>([
  'summary',
  'overviewWork.main',
  'overviewWork.detail',
]);

function countMarkers(s: string): number {
  const m = s.match(/\[\d+\]/g);
  return m ? m.length : 0;
}

function isValidSource(s: unknown): s is { url?: string; text?: string } {
  return !!s && typeof s === 'object' && typeof (s as any).url === 'string' && (s as any).url.length > 0;
}

export function detectAllBodySourceMarkerMismatch(
  proseRaw: Record<string, any> | null | undefined,
  detailReady: Record<string, any> | null | undefined,
  sources: Record<string, any> | null | undefined,
): OmegaFinding[] {
  const findings: OmegaFinding[] = [];
  const pr = proseRaw && typeof proseRaw === 'object' ? proseRaw : {};
  const dr = detailReady && typeof detailReady === 'object' ? detailReady : {};
  const srcs = sources && typeof sources === 'object' ? sources : {};

  // 1) _proseRaw 전체 키 자동 스캔 (careernet 원본 minimal exclude)
  for (const fieldKey of Object.keys(pr)) {
    if (SAL_PROTECTED.has(fieldKey)) continue;
    if (OMEGA_PROSE_EXCLUDE.has(fieldKey)) continue;
    const body = pr[fieldKey];
    if (typeof body !== 'string' || body.length < 100) continue;
    const raw = (srcs as any)[fieldKey];
    const arr = Array.isArray(raw) ? raw.filter(isValidSource) : [];
    const markerCount = countMarkers(body);
    if (arr.length === 0) {
      findings.push({
        rule: 'bodyWithoutSources',
        area: 'prose',
        field: fieldKey,
        bodyLen: body.length,
        markerCount,
        srcsCount: 0,
        severity: 'FAIL',
      });
    } else if (markerCount === 0) {
      findings.push({
        rule: 'sourcesWithoutMarkers',
        area: 'prose',
        field: fieldKey,
        bodyLen: body.length,
        markerCount: 0,
        srcsCount: arr.length,
        severity: 'FAIL',
      });
    }
  }

  // 2) detailReady array 자동 스캔
  for (const arrayKey of Object.keys(dr)) {
    const items = Array.isArray((dr as any)[arrayKey]) ? (dr as any)[arrayKey] : null;
    if (!items) continue;
    const norm: string[] = items
      .map((i: any) => (typeof i === 'string' ? i : (i && (i.text || i.title)) || ''))
      .filter((t: string) => t && t.length >= 30);
    if (norm.length === 0) continue;
    const fieldKey = 'detailReady.' + arrayKey;
    const raw = (srcs as any)[fieldKey];
    const arr = Array.isArray(raw) ? raw.filter(isValidSource) : [];
    const markerCounts = norm.map((t) => countMarkers(t));
    const totalMarkers = markerCounts.reduce((a, b) => a + b, 0);
    const coveredItems = markerCounts.filter((c) => c > 0).length;

    if (arr.length === 0 && totalMarkers === 0 && norm.some((t) => t.length >= 50)) {
      findings.push({
        rule: 'arrayBodyWithoutSources',
        area: 'array',
        field: fieldKey,
        itemCount: norm.length,
        totalMarkers: 0,
        srcsCount: 0,
        severity: 'FAIL',
      });
    } else if (totalMarkers > 0 && arr.length < coveredItems) {
      findings.push({
        rule: 'arrayBrokenRef',
        area: 'array',
        field: fieldKey,
        itemCount: norm.length,
        totalMarkers,
        coveredItems,
        srcsCount: arr.length,
        severity: 'FAIL',
      });
    } else if (coveredItems > 0 && coveredItems < norm.length) {
      findings.push({
        rule: 'arrayCluster',
        area: 'array',
        field: fieldKey,
        itemCount: norm.length,
        coveredItems,
        srcsCount: arr.length,
        severity: 'WARN',
      });
    } else if (arr.length > 0 && totalMarkers === 0) {
      findings.push({
        rule: 'sourcesWithoutMarkers',
        area: 'array',
        field: fieldKey,
        itemCount: norm.length,
        totalMarkers: 0,
        srcsCount: arr.length,
        severity: 'FAIL',
      });
    }
  }

  // 3) _sources orphan 스캔 — body 미존재 영역에 sources만 잔존
  for (const srcKey of Object.keys(srcs)) {
    if (SIDEBAR_FIELDS_FORBIDDEN.has(srcKey)) continue;
    if (SAL_PROTECTED.has(srcKey)) continue;
    const arr = Array.isArray((srcs as any)[srcKey])
      ? (srcs as any)[srcKey].filter(isValidSource)
      : [];
    if (arr.length === 0) continue;
    let bodyExists = false;
    if (Object.prototype.hasOwnProperty.call(pr, srcKey)) {
      const v = pr[srcKey];
      if (typeof v === 'string' && v.length >= 30) bodyExists = true;
    }
    if (!bodyExists && srcKey.startsWith('detailReady.')) {
      const sub = srcKey.slice('detailReady.'.length);
      const items = (dr as any)[sub];
      if (Array.isArray(items) && items.length > 0) bodyExists = true;
    }
    if (!bodyExists) {
      findings.push({
        rule: 'orphanSources',
        area: 'meta',
        field: srcKey,
        srcsCount: arr.length,
        severity: 'FAIL',
      });
    }
  }

  return findings;
}

/**
 * patch가 직접 만든 변경 영역에 한정해서 OMEGA finding 필터링.
 * - patch.fields가 변경한 fieldKey + 그 fieldKey의 sources
 * - 잔존 prod 영역 (patch 안 보낸 fieldKey)은 skip
 *
 * 사용법: server-side guard가 patch + merged 결과에 detectAllBodySourceMarkerMismatch
 * 호출 후, 이 함수로 patch 영역만 추출 → FAIL 있으면 reject.
 */
export function filterPatchTouchedFindings(
  findings: OmegaFinding[],
  touchedFieldKeys: string[],
): OmegaFinding[] {
  const touched = new Set(touchedFieldKeys);
  return findings.filter((f) => {
    if (touched.has(f.field)) return true;
    // detailReady.curriculum 식 경로 — root 'detailReady'도 매치
    if (f.field.startsWith('detailReady.') && touched.has('detailReady')) return true;
    return false;
  });
}
