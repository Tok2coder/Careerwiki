#!/usr/bin/env node
// scripts/skill-cache/audit-major-via-api.cjs
// audit-via-api.cjs(직업)의 전공(major) 포크 — B3 (data/cycle/major_cycle_design_v1.md §5).
// prod GET API로 데이터를 받아 job 감사와 동일한 detect 패턴을 major 필드 스펙으로 적용한다.
//
// 데이터 소스 (둘 다 GET — POST 절대 없음):
//   1. /api/major/{slug}/edit-data  → _sources(진리값), entityId, trivia/enterField 등 편집 필드
//   2. /api/majors/{slug}           → merged profile (whatStudy/howPrepare/jobProspect/summary
//                                     raw string + 보호영역 chartData/universities 등)
//   ⚠️ edit-data는 howPrepare/jobProspect를 미노출(2026-07-02 실측) — 산문 본문은
//   /api/majors/{slug} merged profile에서 취득 (UCJ 병합됨: user > admin > api,
//   profileDataService.ts deepMergeProfile 확인).
//
// 사용:
//   node scripts/skill-cache/audit-major-via-api.cjs slug1 slug2 ...
//   (job판 --exclude-sal 플래그는 없음 — 전공판 sal(보호영역)은 exclude가 아니라
//    접촉 감지 시 무조건 FAIL: protectedSources / protectedFieldMarker)

'use strict';

const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const {
  detectMojibake,
  detectListPageUrl,
  detectOriginDomain,
  detectOrphanSourceIdx,
  detectBrokenSourceRef,
  detectSourceIdxGap,
  detectBrokenSourceRefArrayItems,
  detectMarkerOrderViolation,
  detectRootDomainOnly,
  calcWikiQuota,
  SELF_DOMAINS,
} = require(path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'));

// URL 생존 게이트 (R41 사후 신설, job판과 동일 공유 모듈).
const { checkUrls } = require(path.join(REPO_ROOT, 'scripts', 'skill-cache', 'url-liveness.cjs'));

// ── 전공 도메인 필드 스펙 v1 (major_cycle_design_v1.md §2) ──────────────────
//
// 산문 본문 필드 — job판 PROSE_BODY_FIELDS(9필드)의 전공 치환.
// (detect-patterns.cjs의 PROSE_BODY_FIELDS는 job 전용이라 import하지 않고 로컬 정의)
const BODY_FIELDS = ['whatStudy', 'howPrepare', 'jobProspect', 'summary'];

// ZZ(bodyWithoutSources)용 — UCJ 신규 작성 의무 영역만. summary는 API 원천(605/607 기존재)
// → 보강 대상이지 신규 아님. 포함 시 미보강 전공 전원 false positive (job판 ZZ가
// summary/overviewWork.main을 제외한 것과 동일 근거).
const UCJ_PROSE_FIELDS = ['whatStudy', 'howPrepare', 'jobProspect'];

// 배열 본문 필드 — job판 detailReady.{curriculum,recruit,training}의 전공 등가.
// edit-data 응답 키 기준 (2026-07-02 실측). trivia만 순수 UCJ 영역, 나머지는 API 원천
// (careernet/goyong 병합)이라 "본문만 있고 출처 0" 류 검사는 trivia만 적용.
const ARRAY_BODY_FIELDS = [
  'trivia', 'enterField', 'mainSubject', 'careerAct',
  'licenses', 'relateSubject', 'basicSubjects', 'advancedSubjects', 'mainSubjects',
];
const UCJ_ARRAY_FIELDS = ['trivia']; // API 원천 배열은 no-source 검사 제외 (false positive 차단)

// 🔴 보호영역 (전공판 sal — job판 SAL_PROTECTED 'overviewSalary.sal' 대체, 설계 §2)
// 접촉 감지(= _sources 등록 또는 본문 내 [N] 마커 출현) 시 FAIL.
const PROTECTED_FIELDS = [
  'chartData', 'employmentRate', 'salaryAfterGraduation', 'universities', 'recruitmentStatus',
];

// 룰 L 전공판 — sidebar 영역 _sources 등록 금지 (job판 SIDEBAR_FIELDS_FORBIDDEN 치환)
const SIDEBAR_FIELDS_FORBIDDEN = ['sidebarJobs', 'sidebarMajors', 'sidebarHowtos'];

// 룰 Z 전공판 — distinct URL 최소치. 설계 §2: 전공 단일 기준 8 (직업 18/niche 10과 별도,
// M0 파일럿 후 확정 예정 잠정값).
const MIN_DISTINCT_URLS = 8;

function getNested(obj, p) {
  if (!obj) return undefined;
  if (obj[p] !== undefined) return obj[p];
  let cur = obj;
  for (const part of p.split('.')) { if (cur == null) return undefined; cur = cur[part]; }
  return cur;
}

// ── 전공용 본문 normalize ─────────────────────────────────────────────────────
// detect-patterns.cjs normalizeProseBody의 전공 확장 — 전공 pairList({title, description})는
// description에도 [N] 마커가 실릴 수 있어 title+description을 함께 join한다.
// (공백 join — \n을 넣으면 detailReadyMalformed류 multiline 검사가 false positive)
function normalizeMajorBody(v) {
  if (typeof v === 'string') return v;
  if (Array.isArray(v)) {
    return v
      .map((x) => normalizeMajorItemText(x))
      .filter((s) => s && s.length > 0)
      .join('\n');
  }
  return '';
}

// 배열 항목 1건의 텍스트 (string | {title, description, text, name, value, desc})
function normalizeMajorItemText(x) {
  if (typeof x === 'string') return x;
  if (x && typeof x === 'object') {
    const parts = [x.title, x.name, x.text, x.value, x.description, x.desc]
      .filter((s) => typeof s === 'string' && s.trim().length > 0);
    return parts.join(' ');
  }
  return '';
}

// 보호영역 접촉 감지용 — 객체/배열의 string leaf만 재귀 수집 (JSON.stringify로 마커 검사 시
// chartData 숫자 배열 "[1990]" 등이 /\[\d+\]/에 걸리는 false positive 차단).
function collectStringLeaves(v, depth = 0, acc = []) {
  if (depth > 4 || acc.length > 3000) return acc;
  if (typeof v === 'string') { acc.push(v); return acc; }
  if (Array.isArray(v)) { for (const x of v) collectStringLeaves(x, depth + 1, acc); return acc; }
  if (v && typeof v === 'object') { for (const x of Object.values(v)) collectStringLeaves(x, depth + 1, acc); return acc; }
  return acc;
}

// 산문/배열 필드 본문 조회 — merged profile(산문 raw) 우선, edit-data 필드 fallback.
// job판 getProseBody(_proseRaw 우선)의 전공 등가. 반환 null = 본문 영역 자체 미존재.
function getBodyForField(editData, profile, fieldKey) {
  // 1. 산문 4필드 — merged profile이 raw string 진리값 (edit-data는 howPrepare/jobProspect 미노출)
  if (BODY_FIELDS.includes(fieldKey)) {
    const v = profile ? profile[fieldKey] : undefined;
    if (v !== undefined) return normalizeMajorBody(v);
    // profile 미취득 시 edit-data fallback ('summary'는 edit-data에선 'overview.summary')
    const alt = fieldKey === 'summary' ? getNested(editData, 'overview.summary') : getNested(editData, fieldKey);
    return alt === undefined ? null : normalizeMajorBody(alt);
  }
  // 2. edit-data flat 키 ('overview.summary' 포함 — edit-data는 flat key로 노출)
  if (editData && editData[fieldKey] !== undefined) return normalizeMajorBody(editData[fieldKey]);
  // 3. edit-data nested / profile fallback
  const nested = getNested(editData, fieldKey);
  if (nested !== undefined) return normalizeMajorBody(nested);
  const prof = getNested(profile, fieldKey);
  if (prof !== undefined) return normalizeMajorBody(prof);
  return null; // 본문 영역 자체가 없음 → orphanSources(body-missing)
}

// 배열 필드 항목 리스트 (string[]) — edit-data 우선, profile fallback
function getArrayItems(editData, profile, fieldKey) {
  let v = editData ? editData[fieldKey] : undefined;
  if (!Array.isArray(v)) v = getNested(editData, fieldKey);
  if (!Array.isArray(v)) v = profile ? profile[fieldKey] : undefined;
  if (!Array.isArray(v)) return [];
  return v.map((x) => normalizeMajorItemText(x)).filter((t) => t && t.length > 0);
}

async function fetchMajor(slug) {
  const enc = encodeURIComponent(slug);
  // 1. edit-data — _sources 진리값 + entityId
  const editUrl = `https://careerwiki.org/api/major/${enc}/edit-data`;
  const r1 = await fetch(editUrl, { headers: { 'Cache-Control': 'no-cache' } });
  if (r1.status !== 200) return { error: `edit-data HTTP ${r1.status}` };
  const j1 = await r1.json();
  if (!j1.success) return { error: j1.error || 'edit-data API failure' };

  // 2. merged profile — 산문 raw(whatStudy/howPrepare/jobProspect/summary) + 보호영역
  const profUrl = `https://careerwiki.org/api/majors/${enc}`;
  const r2 = await fetch(profUrl, { headers: { 'Cache-Control': 'no-cache' } });
  if (r2.status !== 200) return { error: `profile HTTP ${r2.status}` };
  const j2 = await r2.json();
  if (!j2.success) return { error: j2.error || 'profile API failure' };

  return { data: j1.data, profile: j2.data, entityId: j1.entityId };
}

function analyze(slug, data, profile) {
  // _sources: edit-data가 진리값 (UCJ 병합 노출), 없으면 merged profile fallback
  const sources = (data && data._sources) || (profile && profile._sources) || {};
  const findings = {
    slug,
    dupMarkers: [],
    orphanSrc: [],
    originDomain: [],
    selfCite: [],
    listPage: [],
    rawURL: [],
    brokenRef: [],
    bracketPrefix: [],
    mojibake: [],
    sourcesNull: false,
    idxGap: null,
    arrayBrokenRef: [],
    orderViolation: null,
    sidebarSources: [],
    rootURL: [],               // 룰 13
    wikiQuota: null,           // 룰 14
    protectedSources: [],      // 🔴 전공판 sal — 보호영역 fieldKey에 _sources 등록 (FAIL)
    protectedFieldMarker: [],  // 🔴 전공판 sal — 보호영역 본문에 [N] 마커 출현 (FAIL)
    arrayItemPeriod: [],       // 룰 X — 마커 보유 항목만 검사 (API 원천 배열 마침표 false positive 차단)
    arrayMalformed: [],        // 룰 W1 전공판 (job detailReadyMalformed) — 마커 보유 항목만
    bareMajorCurriculum: [],   // 룰 W2 — 전공엔 curriculum 등가 필드 없음 (mainSubjects bare 명칭이 정상) → 항상 []
    sourcePositionCluster: [], // 룰 Y — WARN level
    urlCountInsufficient: null, // 룰 Z — WARN level (distinct < 8, 설계 §2)
    bodyWithoutSources: [],    // 룰 ZZ — WARN level
    sourcesWithoutMarkers: [], // 룰 ZZZ — FAIL level
    orphanSources: [],         // 룰 ZZZZ — FAIL level
    omegaFindings: [],         // 룰 OMEGA — 통합 자동 스캔
    urlDead: [],               // R41 룰 — FAIL (404/410/NXDOMAIN). main 루프에서 async 채움
    urlUnverified: [],         // R41 룰 — WARN (000/403/timeout/TLS)
    _allUrls: [],              // 내부 — URL 생존 검사 대상
  };

  // 산문 본문 map (merged profile raw — job판 _proseRaw 등가)
  const proseRaw = {};
  for (const f of BODY_FIELDS) {
    const b = getBodyForField(data, profile, f);
    proseRaw[f] = typeof b === 'string' ? b : '';
  }

  let hasBodyMarker = false;
  for (const f of BODY_FIELDS) {
    if (/\[\d+\]/.test(proseRaw[f])) { hasBodyMarker = true; break; }
  }
  if (!sources && hasBodyMarker) findings.sourcesNull = true;

  // ── per-source 검사 (rawURL/bracketPrefix/mojibake/listPage/rootURL/origin/selfCite) ──
  for (const [fieldKey, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr)) continue;

    // 🔴 보호영역 fieldKey에 _sources 등록 = 접촉 사고 (FAIL)
    if (srcArr.length > 0 && PROTECTED_FIELDS.some((p) => fieldKey === p || fieldKey.startsWith(p + '.'))) {
      findings.protectedSources.push({ field: fieldKey, count: srcArr.length });
    }

    for (let i = 0; i < srcArr.length; i++) {
      const src = srcArr[i];
      if (!src || typeof src !== 'object') continue;
      const id = typeof src.id === 'number' ? src.id : (i + 1);

      if (src.url && typeof src.url === 'string') findings._allUrls.push(src.url);

      if (typeof src.text === 'string' && /^\s*https?:\/\//.test(src.text)) {
        findings.rawURL.push({ field: fieldKey, idx: id, text: src.text.slice(0, 80) });
      }
      if (typeof src.text === 'string' && /^\s*\[\d+\]/.test(src.text)) {
        findings.bracketPrefix.push({ field: fieldKey, idx: id, text: src.text.slice(0, 80) });
      }
      if (typeof src.text === 'string' && detectMojibake(src.text)) {
        findings.mojibake.push({ location: `_sources.${fieldKey}[${id}].text`, sample: src.text.slice(0, 60) });
      }
      if (src.url && detectListPageUrl(src.url)) {
        findings.listPage.push({ field: fieldKey, url: src.url });
      }
      if (src.url && detectRootDomainOnly(src.url)) {
        try {
          const host = new URL(src.url).host.toLowerCase();
          findings.rootURL.push({ field: fieldKey, idx: id, url: src.url, host });
        } catch {}
      }
      if (src.url) {
        try {
          const host = new URL(src.url).host.toLowerCase();
          if (SELF_DOMAINS.includes(host)) {
            findings.selfCite.push({ field: fieldKey, url: src.url, host, kind: 'self' });
          } else if (detectOriginDomain(src.url)) {
            // origin 금지: career/work/work24/wagework/job.go.kr — 전공 원천(CAREERNET/WORK24_MAJOR)
            // 자기인용 금지 (설계 §3). detectOriginDomain이 동일 host 목록 + .go.kr heuristic 커버.
            findings.originDomain.push({ field: fieldKey, url: src.url, host });
            findings.selfCite.push({ field: fieldKey, url: src.url, host, kind: 'origin' });
          }
        } catch {}
      }
    }

    // 본문 [N] ↔ _sources 정합 (orphan/broken/dup) — 산문 4필드 + 배열 필드 + overview.summary
    const coherenceTarget =
      BODY_FIELDS.includes(fieldKey) || ARRAY_BODY_FIELDS.includes(fieldKey) || fieldKey === 'overview.summary';
    if (coherenceTarget) {
      const body = BODY_FIELDS.includes(fieldKey) ? proseRaw[fieldKey] : getBodyForField(data, profile, fieldKey);
      if (typeof body === 'string') {
        const orphans = detectOrphanSourceIdx(body, srcArr);
        for (const idx of orphans) findings.orphanSrc.push({ field: fieldKey, idx });
        const broken = detectBrokenSourceRef(body, srcArr);
        for (const idx of broken) findings.brokenRef.push({ field: fieldKey, idx });
        const matches = body.match(/\[(\d+)\]/g) || [];
        const cnt = {};
        for (const m of matches) cnt[m] = (cnt[m] || 0) + 1;
        for (const [marker, c] of Object.entries(cnt)) {
          if (c >= 2) findings.dupMarkers.push({ field: fieldKey, marker, count: c });
        }
      }
    }
  }

  findings.idxGap = detectSourceIdxGap(sources);

  // 🔴 보호영역 본문 [N] 마커 접촉 감지 (string leaf만 스캔 — chartData 숫자배열 false positive 차단)
  for (const p of PROTECTED_FIELDS) {
    const v = profile ? profile[p] : undefined;
    if (v === undefined || v === null) continue;
    const leaves = collectStringLeaves(v);
    const joined = leaves.join('\n');
    const m = joined.match(/\[\d+\]/g);
    if (m && m.length > 0) {
      findings.protectedFieldMarker.push({ field: p, markers: m.length, sample: (leaves.find((s) => /\[\d+\]/.test(s)) || '').slice(0, 60) });
    }
  }

  // 룰 J 전공판: 배열 필드 항목 brokenRef (job detailReady.{curriculum,recruit,training} 치환)
  for (const sub of ARRAY_BODY_FIELDS) {
    const items = getArrayItems(data, profile, sub);
    if (items.length === 0) continue;
    const srcArr = sources[sub];
    const broken = detectBrokenSourceRefArrayItems(items, srcArr);
    if (broken.length > 0) {
      findings.arrayBrokenRef.push({
        field: sub,
        broken,
        srcLen: Array.isArray(srcArr) ? srcArr.length : 0,
      });
    }
  }

  // 룰 K: 본문 [N] 첫 등장 sequential (산문 4필드 + 배열 필드 합본)
  const allBodyParts = [];
  for (const f of BODY_FIELDS) {
    if (proseRaw[f].length > 0) allBodyParts.push(proseRaw[f]);
  }
  for (const sub of ARRAY_BODY_FIELDS) {
    for (const t of getArrayItems(data, profile, sub)) allBodyParts.push(t);
  }
  findings.orderViolation = detectMarkerOrderViolation(allBodyParts.join('\n'));

  // 룰 L 전공판: sidebar 영역 _sources 등록 금지 (sidebarJobs/sidebarMajors/sidebarHowtos)
  for (const f of SIDEBAR_FIELDS_FORBIDDEN) {
    const arr = sources[f];
    if (Array.isArray(arr) && arr.length > 0) {
      const ids = arr.map((s) => (s && typeof s.id === 'number') ? s.id : null).filter((x) => x != null);
      findings.sidebarSources.push({ field: f, ids, count: arr.length });
    }
  }

  // 룰 14: Wikipedia 점유율 ≤ 30% (필드 무관 — 그대로)
  findings.wikiQuota = calcWikiQuota(sources);

  // 룰 X 전공판: 배열 항목 끝 마침표 — [N] 마커 보유 항목만 검사.
  // (전공 배열은 careerAct/enterField 등 API 원천 서술이 마침표로 끝나는 게 정상.
  //  마커 보유 = cycle이 작성한 항목만 SKILL 형식 룰 적용 — false positive 차단)
  // 룰 W1 전공판: 마커 보유 항목의 == 헤더 / 개행 / 불릿 뭉침 (job detailReadyMalformed 치환)
  for (const sub of ARRAY_BODY_FIELDS) {
    const items = getArrayItems(data, profile, sub);
    items.forEach((text, idx) => {
      if (!/\[\d+\]/.test(text)) return; // cycle 미접촉(API 원천) 항목 skip
      const stripped = text.replace(/\s*\[\d+\]\s*$/, '').trim();
      if (stripped.endsWith('.') || stripped.endsWith('。')) {
        findings.arrayItemPeriod.push({ field: sub, idx, preview: stripped.slice(-30) });
      }
      const preview = text.replace(/\n/g, '\\n').slice(0, 50);
      if (text.includes('==')) findings.arrayMalformed.push({ field: sub, idx, type: 'mdHeader', preview });
      else if (/\n/.test(text)) findings.arrayMalformed.push({ field: sub, idx, type: 'multiline', preview });
      else if (/^\s*[-•]\s/.test(text)) findings.arrayMalformed.push({ field: sub, idx, type: 'bullet', preview });
    });
  }

  // 룰 W2 (bareMajorCurriculum): 전공에 curriculum 등가 필드 없음 — mainSubjects 등은
  // bare 과목/전공명이 정상 형식이라 검사 대상 없음. 패턴 보존 위해 키만 유지 (항상 []).

  // 룰 Y 전공판: 배열 출처 위치 cluster (1 출처가 N 항목 cover, 일부 항목에만 [N]) — WARN
  for (const sub of ARRAY_BODY_FIELDS) {
    const items = getArrayItems(data, profile, sub);
    if (items.length < 2) continue;
    const srcArr = sources[sub];
    if (!Array.isArray(srcArr) || srcArr.length === 0) continue;
    const markedItems = items.reduce((acc, t) => acc + (/\[\d+\]/.test(t) ? 1 : 0), 0);
    if (srcArr.length < items.length && markedItems < items.length) {
      findings.sourcePositionCluster.push({
        field: sub,
        items: items.length,
        sources: srcArr.length,
        markedItems,
        preview: items[items.length - 1].slice(-30),
      });
    }
  }

  // 룰 Z 전공판: distinct URL count < 8 → WARN (설계 §2 잠정치 — job max(18, fields×1.5) 치환)
  {
    const fieldKeys = Object.keys(sources).filter((k) => Array.isArray(sources[k]));
    const distinctUrls = new Set();
    let refCount = 0;
    for (const fk of fieldKeys) {
      for (const s of sources[fk]) {
        if (s && typeof s === 'object' && typeof s.url === 'string' && s.url.length > 0) {
          distinctUrls.add(s.url);
          refCount += 1;
        }
      }
    }
    if (distinctUrls.size < MIN_DISTINCT_URLS) {
      findings.urlCountInsufficient = {
        rule: 'urlCountInsufficient',
        count: distinctUrls.size,
        refCount,
        target: MIN_DISTINCT_URLS,
        fieldsCount: fieldKeys.length,
      };
    }
  }

  // 룰 ZZ 전공판: Body Without Sources (WARN) — UCJ 작성 의무 산문(whatStudy/howPrepare/
  // jobProspect) 본문 100자+ 인데 _sources 0. summary는 API 원천이라 제외 (job판 동일 근거).
  for (const f of UCJ_PROSE_FIELDS) {
    const body = proseRaw[f];
    const srcArr = Array.isArray(sources[f]) ? sources[f] : [];
    const urlCount = srcArr.filter((s) => s && typeof s === 'object' && s.url).length;
    if (body.length >= 100 && urlCount === 0) {
      findings.bodyWithoutSources.push({ rule: 'bodyWithoutSources', area: 'prose', field: f, bodyLen: body.length });
    }
  }
  // 배열 파트 — 순수 UCJ 배열(trivia)만 (API 원천 배열은 미보강 전공 전원 false positive)
  for (const sub of UCJ_ARRAY_FIELDS) {
    const items = getArrayItems(data, profile, sub);
    if (items.length < 2) continue;
    const srcArr = Array.isArray(sources[sub]) ? sources[sub] : [];
    const urlCount = srcArr.filter((s) => s && typeof s === 'object' && s.url).length;
    const itemsWithoutMarker = items.filter((t) => !/\[\d+\]/.test(t)).length;
    if (itemsWithoutMarker === items.length && urlCount === 0) {
      findings.bodyWithoutSources.push({ rule: 'bodyWithoutSources', area: 'array', field: sub, items: items.length });
    }
  }

  // 룰 ZZZ 전공판: Sources Without Markers (FAIL) — 산문 4필드 (summary 포함, job판 동일)
  // body≥100 AND _sources.url≥1 AND 본문 [N] 0개
  for (const f of BODY_FIELDS) {
    const body = proseRaw[f];
    if (body.length < 100) continue;
    const srcArr = Array.isArray(sources[f]) ? sources[f] : [];
    const srcsCount = srcArr.filter((s) => s && typeof s === 'object' && s.url).length;
    if (srcsCount === 0) continue; // 룰 ZZ 영역
    const markerCount = (body.match(/\[\d+\]/g) || []).length;
    if (markerCount === 0) {
      findings.sourcesWithoutMarkers.push({
        rule: 'sourcesWithoutMarkers', area: 'prose', field: f,
        bodyLen: body.length, srcsCount, severity: 'FAIL',
      });
    }
  }

  // 룰 ZZZZ 전공판: Orphan Sources (FAIL) — 본문 미존재/과소 영역에 _sources만 잔존.
  // sidebar*(룰 L 별도) + 보호영역(protectedSources 별도) skip — job판 sal skip 대응.
  const MIN_BODY_LEN_FOR_NON_ORPHAN = 50;
  for (const [fieldKey, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr) || srcArr.length === 0) continue;
    if (SIDEBAR_FIELDS_FORBIDDEN.includes(fieldKey)) continue;
    if (PROTECTED_FIELDS.some((p) => fieldKey === p || fieldKey.startsWith(p + '.'))) continue;
    const urlCount = srcArr.filter((s) => s && typeof s === 'object' && s.url).length;
    if (urlCount === 0) continue;
    const body = getBodyForField(data, profile, fieldKey);
    if (body == null) {
      findings.orphanSources.push({
        rule: 'orphanSources', area: 'body-missing', field: fieldKey,
        srcsCount: urlCount, bodyLen: 0, severity: 'FAIL',
      });
      continue;
    }
    if (body.trim().length < MIN_BODY_LEN_FOR_NON_ORPHAN) {
      findings.orphanSources.push({
        rule: 'orphanSources', area: 'body-too-short', field: fieldKey,
        srcsCount: urlCount, bodyLen: body.trim().length, severity: 'FAIL',
      });
    }
  }

  // 룰 OMEGA 전공판: 통합 body-source-marker mismatch 자동 스캔.
  // (detect-patterns.cjs detectAllBodySourceMarkerMismatch는 job 필드 하드코딩
  //  (_proseRaw/detailReady/overviewSalary.sal) — 전공 필드 스펙으로 로컬 재구현.
  //  job 자산 미수정 원칙: 공유 모듈에 major 분기 추가 금지)
  {
    const omega = [];
    // 1. 산문 스캔 — summary 제외 (API 원천, job OMEGA_PROSE_EXCLUDE 대응)
    for (const f of UCJ_PROSE_FIELDS) {
      const body = proseRaw[f];
      if (body.length < 100) continue;
      const arr = Array.isArray(sources[f]) ? sources[f].filter((s) => s && s.url) : [];
      const markerCount = (body.match(/\[\d+\]/g) || []).length;
      if (arr.length === 0) {
        omega.push({ rule: 'bodyWithoutSources', area: 'prose', field: f, bodyLen: body.length, markerCount, srcsCount: 0, severity: 'FAIL' });
      } else if (markerCount === 0) {
        omega.push({ rule: 'sourcesWithoutMarkers', area: 'prose', field: f, bodyLen: body.length, markerCount: 0, srcsCount: arr.length, severity: 'FAIL' });
      }
    }
    // 2. 배열 스캔 — 마커 기반 조건은 전 배열, no-source 조건은 UCJ 배열(trivia)만
    for (const sub of ARRAY_BODY_FIELDS) {
      const norm = getArrayItems(data, profile, sub).filter((t) => t.length >= 30);
      if (norm.length === 0) continue;
      const arr = Array.isArray(sources[sub]) ? sources[sub].filter((s) => s && s.url) : [];
      const markerCounts = norm.map((t) => (t.match(/\[\d+\]/g) || []).length);
      const totalMarkers = markerCounts.reduce((a, b) => a + b, 0);
      const coveredItems = markerCounts.filter((c) => c > 0).length;
      if (arr.length === 0 && totalMarkers === 0 && norm.some((t) => t.length >= 50)) {
        if (UCJ_ARRAY_FIELDS.includes(sub)) {
          omega.push({ rule: 'arrayBodyWithoutSources', area: 'array', field: sub, itemCount: norm.length, totalMarkers: 0, srcsCount: 0, severity: 'FAIL' });
        }
      } else if (totalMarkers > 0 && arr.length < coveredItems) {
        omega.push({ rule: 'arrayBrokenRef', area: 'array', field: sub, itemCount: norm.length, totalMarkers, coveredItems, srcsCount: arr.length, severity: 'FAIL' });
      } else if (coveredItems > 0 && coveredItems < norm.length) {
        omega.push({ rule: 'arrayCluster', area: 'array', field: sub, itemCount: norm.length, coveredItems, srcsCount: arr.length, severity: 'WARN' });
      } else if (arr.length > 0 && totalMarkers === 0) {
        omega.push({ rule: 'sourcesWithoutMarkers', area: 'array', field: sub, itemCount: norm.length, totalMarkers: 0, srcsCount: arr.length, severity: 'FAIL' });
      }
    }
    // 3. _sources 키 스캔 — body 미존재 orphan (sidebar/보호영역 skip, 별도 룰이 처리)
    for (const srcKey of Object.keys(sources)) {
      if (SIDEBAR_FIELDS_FORBIDDEN.includes(srcKey)) continue;
      if (PROTECTED_FIELDS.some((p) => srcKey === p || srcKey.startsWith(p + '.'))) continue;
      const arr = Array.isArray(sources[srcKey]) ? sources[srcKey].filter((s) => s && s.url) : [];
      if (arr.length === 0) continue;
      const body = getBodyForField(data, profile, srcKey);
      const bodyExists = typeof body === 'string' && body.length >= 30;
      if (!bodyExists) {
        omega.push({ rule: 'orphanSources', area: 'meta', field: srcKey, srcsCount: arr.length, severity: 'FAIL' });
      }
    }
    findings.omegaFindings = omega;
  }

  return findings;
}

function isFail(j) {
  return (
    j.dupMarkers.length > 0 || j.orphanSrc.length > 0 ||
    j.originDomain.length > 0 || j.listPage.length > 0 || j.rawURL.length > 0 ||
    j.brokenRef.length > 0 || j.bracketPrefix.length > 0 || j.mojibake.length > 0 ||
    j.sourcesNull || j.idxGap || j.arrayBrokenRef.length > 0 || j.orderViolation ||
    (j.sidebarSources && j.sidebarSources.length > 0) ||
    (j.rootURL && j.rootURL.length > 0) ||
    (j.wikiQuota && j.wikiQuota.level === 'FAIL') ||
    (j.protectedSources && j.protectedSources.length > 0) ||
    (j.protectedFieldMarker && j.protectedFieldMarker.length > 0) ||
    (j.sourcesWithoutMarkers && j.sourcesWithoutMarkers.length > 0) ||
    (j.orphanSources && j.orphanSources.length > 0) ||
    (j.arrayItemPeriod && j.arrayItemPeriod.length > 0) ||
    (j.arrayMalformed && j.arrayMalformed.length > 0) ||
    (j.urlDead && j.urlDead.length > 0) ||
    (j.omegaFindings && j.omegaFindings.some((f) => f.severity === 'FAIL'))
  );
}

(async () => {
  const argv = process.argv.slice(2);
  const slugs = argv.filter((a) => !a.startsWith('--'));
  if (slugs.length === 0) {
    console.error('사용: node scripts/skill-cache/audit-major-via-api.cjs slug1 slug2 ...');
    process.exit(1);
  }

  const results = [];
  for (const slug of slugs) {
    const r = await fetchMajor(slug);
    if (r.error) { console.log(`ERR  ${slug.padEnd(30)} ${r.error}`); continue; }
    const f = analyze(slug, r.data, r.profile);
    // URL 생존 게이트 (R41) — _sources 모든 URL fetch 후 dead(FAIL)/unverified(WARN) 분류
    {
      const live = await checkUrls(f._allUrls);
      f.urlDead = live.dead;
      f.urlUnverified = live.unverified;
    }
    results.push(f);
    const status = isFail(f) ? 'FAIL' : 'OK  ';
    const flags = [];
    if (f.idxGap) flags.push('idxGap');
    if (f.arrayBrokenRef.length) flags.push(`arrayBrokenRef(${f.arrayBrokenRef.length})`);
    if (f.brokenRef.length) flags.push(`brokenRef(${f.brokenRef.length})`);
    if (f.orderViolation) flags.push('orderViolation');
    if (f.sidebarSources.length) flags.push(`sidebarSources(${f.sidebarSources.length})`);
    if (f.rootURL.length) flags.push(`rootURL(${f.rootURL.length})`);
    if (f.wikiQuota && f.wikiQuota.level === 'FAIL') flags.push(`wikiQuota(${(f.wikiQuota.ratio * 100).toFixed(0)}%)`);
    else if (f.wikiQuota && f.wikiQuota.level === 'WARN') flags.push(`wikiQuotaWARN(${(f.wikiQuota.ratio * 100).toFixed(0)}%)`);
    if (f.orphanSrc.length) flags.push(`orphan(${f.orphanSrc.length})`);
    if (f.originDomain.length) flags.push(`origin(${f.originDomain.length})`);
    if (f.dupMarkers.length) flags.push(`dup(${f.dupMarkers.length})`);
    if (f.mojibake.length) flags.push(`mojibake(${f.mojibake.length})`);
    // 🔴 보호영역 접촉 (전공판 sal)
    if (f.protectedSources.length) {
      const fields = f.protectedSources.map((p) => p.field).join(',');
      flags.push(`protectedSources(${f.protectedSources.length}: ${fields})`);
    }
    if (f.protectedFieldMarker.length) {
      const fields = f.protectedFieldMarker.map((p) => `${p.field}[${p.markers}]`).join(',');
      flags.push(`protectedFieldMarker(${f.protectedFieldMarker.length}: ${fields})`);
    }
    if (f.arrayItemPeriod.length) flags.push(`arrayItemPeriod(${f.arrayItemPeriod.length})`);
    if (f.sourcePositionCluster.length) flags.push(`sourcePositionCluster(${f.sourcePositionCluster.length})`);
    if (f.arrayMalformed.length) {
      const types = [...new Set(f.arrayMalformed.map((h) => h.type))].join('/');
      flags.push(`arrayMalformed(${f.arrayMalformed.length}:${types})`);
    }
    if (f.bareMajorCurriculum.length) flags.push(`bareMajorCurriculum(${f.bareMajorCurriculum.length})`);
    if (f.urlCountInsufficient) {
      const z = f.urlCountInsufficient;
      flags.push(`urlCountInsufficient(${z.count}<${z.target})`);
    }
    if (f.bodyWithoutSources.length) {
      const fields = f.bodyWithoutSources.map((b) => b.field).join(',');
      flags.push(`bodyWithoutSources(${f.bodyWithoutSources.length}: ${fields})`);
    }
    if (f.sourcesWithoutMarkers.length) {
      const fields = f.sourcesWithoutMarkers.map((b) => `${b.field}(${b.bodyLen}/${b.srcsCount})`).join(',');
      flags.push(`sourcesWithoutMarkers(${f.sourcesWithoutMarkers.length}: ${fields})`);
    }
    if (f.orphanSources.length) {
      const fields = f.orphanSources.map((b) => `${b.field}[${b.area}/${b.srcsCount}]`).join(',');
      flags.push(`orphanSources(${f.orphanSources.length}: ${fields})`);
    }
    if (f.omegaFindings.length) {
      const fail = f.omegaFindings.filter((o) => o.severity === 'FAIL');
      const warn = f.omegaFindings.filter((o) => o.severity === 'WARN');
      if (fail.length) {
        const summary = fail.slice(0, 5).map((o) => `${o.rule}:${o.field}`).join(',');
        const more = fail.length > 5 ? `,+${fail.length - 5}` : '';
        flags.push(`OMEGA-FAIL(${fail.length}: ${summary}${more})`);
      }
      if (warn.length) flags.push(`OMEGA-WARN(${warn.length})`);
    }
    if (f.urlDead.length) flags.push(`urlDead(${f.urlDead.length})`);
    if (f.urlUnverified.length) flags.push(`urlUnverified(${f.urlUnverified.length})`);
    console.log(`${status} ${slug.padEnd(30)} ${flags.join(', ') || 'clean'}`);
    f.urlDead.forEach((u) =>
      console.log(`         [urlDead] ${u.reason}: ${u.url}`));
    f.urlUnverified.forEach((u) =>
      console.log(`         [urlUnverified] ${u.reason}: ${u.url}`));
    f.arrayBrokenRef.forEach((b) =>
      console.log(`         ${b.field}: broken=[${b.broken.join(',')}] srcLen=${b.srcLen}`));
    f.brokenRef.forEach((b) => console.log(`         ${b.field}#${b.idx} broken`));
    if (f.idxGap) {
      const i = f.idxGap.actual.findIndex((id, k) => id !== f.idxGap.expected[k]);
      console.log(`         idxGap @${i}: expected ${f.idxGap.expected[i]}, got ${f.idxGap.actual[i]}`);
    }
    if (f.orderViolation) {
      console.log(`         orderViolation @${f.orderViolation.breakAt}: expected ${f.orderViolation.breakAt + 1}, got ${f.orderViolation.firstAppear[f.orderViolation.breakAt]}`);
    }
    f.sidebarSources.forEach((h) =>
      console.log(`         sidebarSources ${h.field}: count=${h.count}, ids=[${h.ids.join(',')}] (orphan — sidebar 본문 [N] 마커 없음)`));
    f.protectedSources.forEach((p) =>
      console.log(`         🔴 protectedSources ${p.field}: ${p.count}건 — 보호영역(전공판 sal) _sources 등록 금지`));
    f.protectedFieldMarker.forEach((p) =>
      console.log(`         🔴 protectedFieldMarker ${p.field}: [N] ${p.markers}개 — 보호영역 본문 접촉 의심 "${p.sample}"`));
  }

  const failCount = results.filter(isFail).length;
  console.log(`\n=== Summary: ${failCount}/${results.length} FAIL ===`);
})();
