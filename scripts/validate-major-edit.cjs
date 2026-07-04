#!/usr/bin/env node
/**
 * validate-major-edit.cjs
 *
 * 전공(major) 편집 JSON 사전 검증 게이트 — validate-job-edit.cjs 포크+치환 (B2, 2026-07-02).
 * 설계 진리: data/cycle/major_cycle_design_v1.md §2·§3·§5.
 *
 * Usage: node scripts/validate-major-edit.cjs <json-file-or-stdin>
 *
 * Input JSON format:
 * {
 *   "majorName": "간호학과",
 *   "majorId": "...",
 *   "fields": { ... },
 *   "sources": { ... },
 *   "changeSummary": "[major-data-master] ..."
 * }
 *
 * 직업판과의 주요 차이:
 *  - 마커: [major-data-master] (legacy 마커 없음)
 *  - 산문 필드: whatStudy / howPrepare / jobProspect / summary (summary는 canonical — 출처 등록 금지)
 *  - ALLOWED_SOURCE_FIELDS: whatStudy / howPrepare / jobProspect / mainSubjects / enterField / licenses
 *  - 보호영역 (payload 존재 시 즉시 FAIL): chartData / employmentRate / salaryAfterGraduation /
 *    universities / recruitmentStatus / relatedJobs / relatedMajors / sources / sourceIds /
 *    aptitude / property / careerAct / relateSubject / mainSubject / overviewSalary
 *  - 게이트: totalEntries ≥ 12 / distinct URL ≥ 8 (단일 티어) /
 *    산문 3필드(whatStudy/howPrepare/jobProspect) 각 ≥ 300자 + 본문 [N] 보유
 *  - 제거된 job 전용 룰: sal/wage, careerTree, abilityList, detailReady 5종,
 *    sidebar*, curriculum 각주, detailWlb 등급, SHORT_LABEL/STATS_ONLY, summaryTooLong
 */

const fs = require('fs');
const path = require('path');

// ── 공유 패턴 모듈 (scripts/_shared/detect-patterns.cjs) ──────────────────────
const {
  detectMultipleUrlsInSourceText,
  detectMergedOrgLabel,
  detectMojibake,
  analyzeYoutubeSearchNote,
  detectListPageUrl,
  classifySourceHosts,
  detectOrphanSourceIdx,
  detectBrokenSourceRef,
  detectMarkerOrderViolation,
  detectSourceIdxGap,
  detectRootDomainOnly,
  calcWikiQuota,
  detectSourceTextIsUrl,
  normalizeProseBody,
} = require(path.join(__dirname, '_shared', 'detect-patterns.cjs'));

// ── 전공 도메인 스펙 v1 (major_cycle_design_v1.md §2) ─────────────────────────

// 산문 4 필드 (본문 [N] 마커·각주·문장 검사 대상 — string body)
const MAJOR_PROSE_FIELDS = ['whatStudy', 'howPrepare', 'jobProspect', 'summary'];

// canonical 필드 — 출처 등록 금지 (본문 보강은 허용). API 원문 존중.
const MAJOR_CANONICAL_FIELDS = new Set(['summary']);

// _sources 등록 허용 fieldKey (룰 ZZZZ allowlist — 전공판)
const ALLOWED_SOURCE_FIELDS = new Set([
  'whatStudy',
  'howPrepare',
  'jobProspect',
  'mainSubjects',
  'enterField',
  'licenses',
  'trivia',
]);

// 🔴 보호영역 (전공판 sal) — payload fields에 존재하면 즉시 FAIL
const PROTECTED_MAJOR_FIELDS = [
  'chartData',
  'employmentRate',
  'salaryAfterGraduation',
  'universities',
  'recruitmentStatus',
  'relatedJobs',
  'relatedMajors',
  'sources',      // top-level origin sources (API 원천)
  'sourceIds',
  'aptitude',
  'property',
  'careerAct',
  'relateSubject',
  'mainSubject',  // 단수형 레거시 (복수형 mainSubjects만 보강 허용)
  'overviewSalary',
];

// ── 결정적 게이트 상수 (§2 게이트 수치 — trivia 편입 후 M0 확정 2026-07-02) ─────
const GATE_TOTAL_ENTRIES_MIN = 14;
const GATE_DISTINCT_MIN = 8; // 단일 티어 — job의 niche/major 이원 티어 없음
const GATE_PROSE_MIN_LEN = 300; // whatStudy/howPrepare/jobProspect 각 최소 글자수
const GATE_CORE_PROSE_FIELDS = ['whatStudy', 'howPrepare', 'jobProspect'];

// 본문 표시 순서 (orderViolation 검사용 — unifiedMajorDetail.ts normalizeUserSources
// fieldOrder 기준: 개요 탭 summary→enterField, 상세 탭 whatStudy→mainSubjects→...).
const BODY_FIELDS_FOR_ORDER = [
  'summary',
  'enterField',
  'whatStudy',
  'mainSubjects',
  'howPrepare',
  'jobProspect',
  'licenses',
];

// ── Sentence-level marker cluster detection (validate-job-edit.cjs와 동일 로직) ──
// 한 문장 안에 마커 [N] 2개 이상 → cluster. 본질: 한 의미 단위(=문장)는 1 마커.
function _findSentenceBoundaries(text) {
  const boundaries = [];
  let i = 0;
  while (i < text.length) {
    const c = text[i];
    if (c === '\n') { boundaries.push(i + 1); i++; continue; }
    if (c === '.' || c === '!' || c === '?') {
      let j = i + 1;
      let advanced = true;
      while (advanced && j < text.length) {
        advanced = false;
        const m = text.slice(j).match(/^\[\d+\]/);
        if (m) { j += m[0].length; advanced = true; continue; }
        if (text[j] === '·') { j++; advanced = true; continue; }
        if (/[ \t]/.test(text[j])) {
          let k = j;
          while (k < text.length && /[ \t]/.test(text[k])) k++;
          if (k < text.length && (text[k] === '[' || text[k] === '·')) { j = k; advanced = true; continue; }
        }
      }
      if (j >= text.length) { boundaries.push(j); i = j; continue; }
      if (/\s/.test(text[j])) {
        let k = j;
        while (k < text.length && /[ \t]/.test(text[k])) k++;
        boundaries.push(k); i = k; continue;
      }
      i++; continue;
    }
    i++;
  }
  return boundaries;
}
function _getSentenceId(pos, boundaries) {
  for (let i = 0; i < boundaries.length; i++) { if (pos < boundaries[i]) return i; }
  return boundaries.length;
}
function detectSentenceClusters(text) {
  if (typeof text !== 'string' || !text) return [];
  const markers = [...text.matchAll(/\[\d+\]/g)];
  if (markers.length === 0) return [];
  const boundaries = _findSentenceBoundaries(text);
  const bySentence = new Map();
  for (const m of markers) {
    const sid = _getSentenceId(m.index, boundaries);
    if (!bySentence.has(sid)) bySentence.set(sid, []);
    bySentence.get(sid).push(m);
  }
  const clusters = [];
  for (const [sid, ms] of bySentence) {
    if (ms.length >= 2) {
      const sStart = sid === 0 ? 0 : boundaries[sid - 1];
      const sEnd = sid < boundaries.length ? boundaries[sid] : text.length;
      clusters.push({
        markers: ms.map(m => m[0]).join(''),
        count: ms.length,
        sentence: text.slice(sStart, sEnd).trim(),
      });
    }
  }
  return clusters;
}

// ── URL HEAD fetch (실시간 hallucinated URL 차단 — job판과 동일) ──
// 사용:
//   VALIDATE_CHECK_URLS=1 node scripts/validate-major-edit.cjs file.json
//   VALIDATE_URL_SAMPLE=30 ... (30% sample mode)
async function checkUrlsLive(sources, sampleRate = 100) {
  const allUrls = [];
  for (const [field, arr] of Object.entries(sources || {})) {
    if (!Array.isArray(arr)) continue;
    arr.forEach((s, idx) => {
      if (!s || !s.url) return;
      if (sampleRate < 100 && Math.random() * 100 > sampleRate) return;
      allUrls.push({ field, idx, url: s.url });
    });
  }
  if (allUrls.length === 0) return [];

  const TIMEOUT = 6000;
  const CONCURRENCY = 5;
  const broken = [];

  const semaphore = (n) => {
    const queue = [];
    let active = 0;
    const next = () => {
      while (active < n && queue.length > 0) {
        const { fn, resolve, reject } = queue.shift();
        active++;
        fn().then(resolve, reject).finally(() => { active--; next(); });
      }
    };
    return (fn) => new Promise((resolve, reject) => { queue.push({ fn, resolve, reject }); next(); });
  };
  const sem = semaphore(CONCURRENCY);

  await Promise.all(allUrls.map(u => sem(async () => {
    try {
      const ac = new AbortController();
      const t = setTimeout(() => ac.abort(), TIMEOUT);
      const resp = await fetch(u.url, {
        method: 'HEAD',
        signal: ac.signal,
        redirect: 'follow',
        headers: { 'User-Agent': 'Mozilla/5.0 (CareerwikiValidator/1.0)' },
      }).catch(async () => {
        return await fetch(u.url, {
          method: 'GET',
          signal: ac.signal,
          redirect: 'follow',
          headers: { 'User-Agent': 'Mozilla/5.0 (CareerwikiValidator/1.0)' },
        });
      });
      clearTimeout(t);
      if (!resp || resp.status >= 400) {
        broken.push({ ...u, status: resp ? resp.status : 'NO_RESPONSE' });
      }
    } catch (e) {
      const msg = String(e.message || e);
      if (msg.includes('CERT')) broken.push({ ...u, status: 'SSL_ERROR' });
      else if (msg.includes('ENOTFOUND')) broken.push({ ...u, status: 'DNS_ERROR' });
      else if (msg.includes('aborted') || msg.includes('timeout')) broken.push({ ...u, status: 'TIMEOUT' });
      else broken.push({ ...u, status: `FETCH_ERR(${msg.slice(0, 30)})` });
    }
  })));

  return broken;
}

async function validateAsync(data, opts = {}) {
  const result = validate(data, opts);
  if (process.env.VALIDATE_CHECK_URLS === '1' || data.checkUrls === true) {
    const sampleRate = parseInt(process.env.VALIDATE_URL_SAMPLE || '100', 10);
    const broken = await checkUrlsLive(data.sources || {}, sampleRate);
    for (const b of broken) {
      result.errors.push(`[urlBroken] _sources.${b.field}[${b.idx}] HTTP ${b.status} — ${b.url}`);
    }
    if (broken.length > 0) {
      result.errors.push(`[urlBrokenSummary] ${broken.length}개 URL 검증 실패 (총 ${Object.values(data.sources || {}).reduce((s, a) => s + (Array.isArray(a) ? a.length : 0), 0)}개 중) — hallucinated URL 의심`);
    }
  }
  return result;
}

function validate(data, opts = {}) {
  const errors = [];   // 치명적 — API 호출 차단
  const warnings = []; // 경고 — 수동 확인 필요

  const { fields = {}, sources = {}, changeSummary } = data;

  // ── 0-PRE-A. 보호영역 접촉 즉시 FAIL (전공판 sal-protection) ────────────────
  // §2 보호영역 — payload fields에 키가 존재하기만 해도 FAIL (null/빈값 포함).
  for (const pf of PROTECTED_MAJOR_FIELDS) {
    if (Object.prototype.hasOwnProperty.call(fields, pf)) {
      errors.push(
        `[보호영역] fields에 "${pf}" 존재 — 전공 보호영역(chartData/employmentRate/salaryAfterGraduation/` +
        `universities/recruitmentStatus/relatedJobs/relatedMajors/sources/sourceIds/aptitude/property/` +
        `careerAct/relateSubject/mainSubject/overviewSalary)은 절대 미접촉. payload에서 제거 필수 ` +
        `(major_cycle_design_v1.md §2)`
      );
    }
  }

  // ── 0-PRE-B. changeSummary fields 중첩 FAIL (R39 사고 룰) ────────────────────
  // changeSummary는 반드시 top-level. fields 안에 중첩되면 서버가 기본값
  // ("N개 필드 수정")으로 저장 → 마커 없음 → KPI 탈락 (R39 실측 사고).
  if (Object.prototype.hasOwnProperty.call(fields, 'changeSummary')) {
    errors.push(
      `[changeSummaryNested] changeSummary가 fields 안에 중첩됨 — 반드시 payload top-level에 위치해야 함. ` +
      `fields 중첩 시 서버 기본값("N개 필드 수정")으로 저장되어 [major-data-master] 마커 누락 → KPI 탈락 (R39 사고 룰)`
    );
  }

  // ── 0-PRE-C. Minimal POST 차단 (단축 처리 사고 방지) ────────────────────────
  const isMasterMarker = typeof changeSummary === 'string' && /\[major-data-master\]/.test(changeSummary);
  if (isMasterMarker) {
    const fieldKeys = Object.keys(fields).filter(k => fields[k] !== null && fields[k] !== undefined && fields[k] !== '');
    const sourceKeys = Object.keys(sources).filter(k => sources[k] && (Array.isArray(sources[k]) ? sources[k].length > 0 : true));
    if (fieldKeys.length === 0 && sourceKeys.length === 0) {
      errors.push(`[minimalPOST] changeSummary에 [major-data-master] 마커만 있고 fields/sources 모두 비어있음 — minimal POST는 단축 처리로 간주, 풀 사이클 강제`);
    } else if (fieldKeys.length <= 1 && sourceKeys.length === 0) {
      warnings.push(`[minimalPOST?] fields ${fieldKeys.length}개 + sources 0개 — trivial 변경 의심. enhance가 풀 사이클이면 §2 필드 전수 보강이 정상`);
    }
  }

  // ── 0. Mojibake (인코딩 깨짐) 사전 탐지 ──
  const checkMojibake = (value, label) => {
    if (!value) return;
    if (typeof value === 'string') {
      if (detectMojibake(value)) {
        errors.push(`[Mojibake] ${label} — 한글이 깨진 문자(아랍·키릴·라틴확장 등)로 저장됨. 인코딩 확인 필수 (Windows curl -d 인라인 사용 금지)`);
      }
    } else if (Array.isArray(value)) {
      value.forEach((item, i) => {
        if (typeof item === 'string' && detectMojibake(item)) {
          errors.push(`[Mojibake] ${label}[${i}] — 배열 항목이 깨진 문자로 저장됨`);
        }
      });
    } else if (typeof value === 'object') {
      for (const [k, v] of Object.entries(value)) {
        checkMojibake(v, `${label}.${k}`);
      }
    }
  };
  checkMojibake(fields, 'fields');
  for (const [srcKey, srcArr] of Object.entries(sources)) {
    if (Array.isArray(srcArr)) {
      srcArr.forEach((src, i) => {
        if (src && src.text && detectMojibake(src.text)) {
          errors.push(`[Mojibake] sources["${srcKey}"][${i}].text — 각주 텍스트가 깨진 문자로 저장됨`);
        }
      });
    }
  }

  // ── 1. 산문 필드 타입 검사 (배열 → string 사고 차단, job "way 배열" 룰의 전공판) ──
  for (const pf of MAJOR_PROSE_FIELDS) {
    const v = fields[pf];
    if (v === undefined || v === null) continue;
    if (Array.isArray(v)) {
      errors.push(`[치명] ${pf}가 배열(Array)임 — 반드시 string이어야 함 (산문 필드)`);
    } else if (typeof v !== 'string') {
      errors.push(`[치명] ${pf} 타입이 "${typeof v}" — string이어야 함`);
    }
  }

  // ── 1-B. canonical summary — 출처 등록 금지 + 본문 [N] 마커 금지 ─────────────
  // summary는 API 원문 존중 + 본문 보강만 허용. _sources["summary"] 등록 불가이므로
  // summary 본문에 [N] 마커를 박으면 매핑 불가 orphan → FAIL.
  if (typeof fields.summary === 'string' && /\[\d+\]/.test(fields.summary)) {
    errors.push(
      `[summaryCanonical] summary 본문에 [N] 마커 발견 — summary는 canonical 필드로 출처 등록 금지 ` +
      `(본문 보강만 허용). 마커 제거 필요 (fact 출처는 whatStudy/howPrepare/jobProspect 쪽에 배치)`
    );
  }

  // ── 1-C. heroTags 점검 (job판 승계 — 있으면 유지·보강 허용) ──────────────────
  const NOUN_EXCEPTIONS = ['강의', '설비', '기여', '처리', '관리', '설계', '분석', '개발', '운의', '합의', '회의', '정의', '위의'];
  if (fields.heroTags) {
    const tags = Array.isArray(fields.heroTags) ? fields.heroTags : JSON.parse(fields.heroTags);
    if (tags.length < 3) warnings.push(`[태그] heroTags가 ${tags.length}개 (최소 3개)`);
    if (tags.length > 15) warnings.push(`[태그] heroTags가 ${tags.length}개 (최대 15개 권장)`);
    for (const tag of tags) {
      if (typeof tag !== 'string') { errors.push(`[태그] heroTags 항목이 string 아님: ${JSON.stringify(tag).slice(0, 40)}`); continue; }
      if (tag.length > 15) warnings.push(`[태그] "${tag}" — 15자 초과`);
      if (tag.length < 2) warnings.push(`[태그] "${tag}" — 2자 미만`);
      if (/[을를이은는에서도의]$/.test(tag)) {
        const isNounException = NOUN_EXCEPTIONS.some(noun => tag.endsWith(noun));
        if (!isNounException) {
          errors.push(`[태그] "${tag}" — 조사로 끝남, 명사구여야 함`);
        }
      }
    }
  }

  // ── 4. 각주 검증 (산문 4필드 — markerCluster / 중복 / sources 대응 / blob) ────
  for (const fieldPath of MAJOR_PROSE_FIELDS) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const footnoteMatches = text.match(/\[(\d+)\]/g);
    if (!footnoteMatches) continue;

    // [markerCluster] 한 sentence 1 마커 max
    const sentenceClusters = detectSentenceClusters(text);
    if (sentenceClusters.length > 0) {
      const c = sentenceClusters[0];
      errors.push(`[markerCluster] ${fieldPath}: sentence-level cluster ${sentenceClusters.length}개 (예: "${c.markers}" in "${c.sentence.slice(0, 100)}${c.sentence.length > 100 ? '...' : ''}"). 한 sentence 안에 마커 ${c.count}개 — 본문을 의미 단위로 분리 + 각 sentence에 마커 1개 매핑 필요.`);
    }

    // 각주 중복 검사
    const counts = {};
    footnoteMatches.forEach(m => { counts[m] = (counts[m] || 0) + 1; });
    const dupes = Object.entries(counts).filter(([_, c]) => c > 1);
    if (dupes.length > 0) {
      errors.push(`[각주] ${fieldPath}: 중복 발견! ${dupes.map(([n, c]) => `${n}이 ${c}회`).join(', ')}`);
    }

    // sources 대응 확인 (canonical summary는 위 1-B에서 이미 FAIL — 중복 메시지 회피)
    if (!MAJOR_CANONICAL_FIELDS.has(fieldPath)) {
      if (!sources[fieldPath]) {
        errors.push(`[출처] ${fieldPath}에 [N] 각주가 있지만 sources["${fieldPath}"]가 없음`);
      } else {
        const srcArr = sources[fieldPath];
        if (Array.isArray(srcArr)) {
          for (const src of srcArr) {
            const srcText = typeof src === 'string' ? src : src && src.text;
            if (srcText && (srcText.match(/\[\d+\]/g) || []).length > 1) {
              errors.push(`[출처blob] sources["${fieldPath}"]에 blob 발견: "${srcText.substring(0, 60)}..." — 개별 항목으로 분리 필요`);
            }
          }
          for (const src of srcArr) {
            if (typeof src === 'object' && src && src.text && src.text.includes('http')) {
              errors.push(`[출처형식] sources["${fieldPath}"]의 text에 URL이 포함됨 — text와 url을 분리해야 함`);
            }
            if (typeof src === 'object' && src && src.text && /^https?:\/\//.test(src.text.replace(/^\[\d+\]\s*/, ''))) {
              errors.push(`[출처형식] sources["${fieldPath}"]의 text가 URL로 시작 — "기관명 — 페이지 제목" 형식 사용 필요`);
            }
            if (typeof src === 'object' && src && src.text && /^\[\d+\]/.test(src.text)) {
              errors.push(`[출처마커prefix] sources["${fieldPath}"]의 text가 [N] 마커로 시작 — text에는 기관명만, [N] 마커는 본문에만 사용: "${src.text.substring(0, 80)}..."`);
            }
          }
        }
      }
    }

    // footnote-split: 문단 끝에 각주 몰아박기 금지
    const sentenceCount = (text.match(/[.!?](?:\s|$)/g) || []).length;
    const collapsedTailFootnotes = text.match(/([.!?])\s*(\[\d+\]\s*){2,}$/);
    const textBeforeTailFootnotes = text.replace(/([.!?])\s*(\[\d+\]\s*){2,}$/, "");
    const hasEarlierFootnote = /\[\d+\]/.test(textBeforeTailFootnotes);
    if (sentenceCount >= 2 && collapsedTailFootnotes && !hasEarlierFootnote) {
      errors.push(`[footnote-split] ${fieldPath}: 문단 끝에 각주가 몰려 있음. 문장별로 분산 배치 필요 — 예: 문장A.[1] 문장B.[2]`);
    }
  }

  // ── 6. changeSummary 존재 + 마커 확인 ──
  if (!changeSummary || changeSummary.length < 10) {
    warnings.push(`[기타] changeSummary가 없거나 너무 짧음`);
  } else if (!isMasterMarker) {
    warnings.push(`[마커] changeSummary에 [major-data-master] 마커 없음 — KPI 집계는 이 마커 기준. enhance 사이클이면 필수`);
  }

  // ── 8. 잘린 문장 검사 (산문 4필드) ──
  const TRUNCATED_PATTERNS = [
    /부상\s*시$/,
    /으로\s*인해$/,
    /경우에는$/,
    /에\s*따르면$/,
    /가능하$/,
    /필요하$/,
    /이루어지$/,
    /\d{4}년$/,
    /억\s*원$/,
    /%\s*이상$/,
    /%\s*이하$/,
    /하여$/,
    /이며$/,
    /위해$/,
    /있으며$/,
    /있고$/,
    /하고$/,
    /[가-힣]{1}에$/,
  ];

  const COMPLETE_ENDINGS = [
    /[.다요]\s*(\[\d+\])*\s*$/,
    /습니다\s*(\[\d+\])*\s*$/,
    /입니다\s*(\[\d+\])*\s*$/,
    /됩니다\s*(\[\d+\])*\s*$/,
    /합니다\s*(\[\d+\])*\s*$/,
    /있습니다\s*(\[\d+\])*\s*$/,
    /없습니다\s*(\[\d+\])*\s*$/,
    /받습니다\s*(\[\d+\])*\s*$/,
    /\)\s*(\[\d+\])*\s*$/,
  ];

  for (const fieldPath of MAJOR_PROSE_FIELDS) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const trimmed = text.trim();
    const cleanEnd = trimmed.replace(/(\s*\[\d+\])+\s*$/, '').trim();

    let truncated = false;
    for (const pattern of TRUNCATED_PATTERNS) {
      if (pattern.test(cleanEnd)) {
        errors.push(`[잘린문장] ${fieldPath}: 미완성 문장 — "...${cleanEnd.slice(-25)}"`);
        truncated = true;
        break;
      }
    }

    if (!truncated) {
      const isComplete = COMPLETE_ENDINGS.some(p => p.test(trimmed));
      if (!isComplete) {
        warnings.push(`[잘린문장] ${fieldPath}: 완성형 어미 미확인 — "...${trimmed.slice(-30)}"`);
      }
    }
  }

  // ── 9b-OMIT. master enhance patch는 youtubeLinks 영역 omit 금지 ─────────────
  // job R66 계열 사고 승계: 영역 자체를 빼면 validate 통과 → 빈값 잔존.
  // 면제: yt-fill / cleanup / --field-only= 명시 부분 모드.
  const isPartialMode = typeof changeSummary === 'string' && /(yt-fill|cleanup|--field-only=)/i.test(changeSummary);
  if (isMasterMarker && !isPartialMode && !('youtubeLinks' in fields)) {
    errors.push('[YouTube-영역누락] master enhance patch는 youtubeLinks 영역 필수. 한국어 영상 있으면 [{url,title}], 없으면 []+_youtubeSearchNote. 영역 omit 금지.');
  }

  // ── 9b. youtubeLinks 무언 스킵 금지 (빈값 → _youtubeSearchNote 필수) ─────────
  if ('youtubeLinks' in fields) {
    const ytLinks = Array.isArray(fields.youtubeLinks)
      ? fields.youtubeLinks
      : (fields.youtubeLinks === null || fields.youtubeLinks === undefined ? [] :
         (typeof fields.youtubeLinks === 'string' ? JSON.parse(fields.youtubeLinks) : []));

    if (ytLinks.length === 0) {
      if (!fields._youtubeSearchNote || typeof fields._youtubeSearchNote !== 'string' || fields._youtubeSearchNote.trim().length < 10) {
        errors.push('[YouTube-증거없음] youtubeLinks를 빈 배열로 제출할 때는 _youtubeSearchNote 필드 필수. 형식: "\'전공명\' 0개, \'전공명 학과소개\' 0개 (날짜)". 검색 없이 빈 배열 저장 금지.');
      } else {
        const ytNoteAnalysis = analyzeYoutubeSearchNote(fields._youtubeSearchNote);
        if (!ytNoteAnalysis.pass) {
          errors.push(
            `[YouTubeNote얕음] _youtubeSearchNote 탐색이 충분하지 않음 ` +
            `(탐색어 ${ytNoteAnalysis.termCount}개 / 카테고리 ${ytNoteAnalysis.categoryCount}/4개 커버). ` +
            `조건: 탐색어 ≥6개 OR 카테고리 ≥3개(현직자·인터뷰/직무·실무/강의·교육/진로·면접). ` +
            `미커버 카테고리: ${ytNoteAnalysis.missingCategories.join(', ')}`
          );
        }
      }
    }
  }

  if (fields.youtubeLinks) {
    const ytLinks = Array.isArray(fields.youtubeLinks)
      ? fields.youtubeLinks
      : (typeof fields.youtubeLinks === 'string' ? JSON.parse(fields.youtubeLinks) : []);
    if (ytLinks.length > 3) {
      errors.push(`[YouTube] youtubeLinks 최대 3개 초과 (현재 ${ytLinks.length}개) — 3개 이하로 줄일 것`);
    }
  }

  // ── 9. YouTube URL 포맷 검사 ──
  if (fields.youtubeLinks) {
    const links = Array.isArray(fields.youtubeLinks)
      ? fields.youtubeLinks
      : (typeof fields.youtubeLinks === 'string' ? JSON.parse(fields.youtubeLinks) : []);

    const YOUTUBE_PATTERNS = [
      /^https?:\/\/(www\.)?youtube\.com\/watch\?v=[\w-]+/,
      /^https?:\/\/youtu\.be\/[\w-]+/,
      /^https?:\/\/(www\.)?youtube\.com\/shorts\/[\w-]+/,
      /^https?:\/\/(www\.)?youtube\.com\/embed\/[\w-]+/,
    ];

    for (const link of links) {
      if (typeof link === 'string') {
        errors.push(`[YouTube] 잘못된 형식: "${link}" — 문자열 배열 금지. {url, title} 객체 배열 사용: [{url: "https://...", title: "영상 제목"}]`);
        continue;
      }
      if (!link || typeof link !== 'object' || !link.url) {
        errors.push(`[YouTube] 잘못된 링크 형식: ${JSON.stringify(link)} — {url, title} 객체여야 함`);
        continue;
      }
      const url = link.url;
      const isValid = YOUTUBE_PATTERNS.some(p => p.test(url));
      if (!isValid) {
        errors.push(`[YouTube] 유효하지 않은 URL: "${url}" — youtube.com/watch?v= 또는 youtu.be/ 형식이어야 함`);
      }
      if (link.title) {
        if (/&#\d+;|&amp;|&lt;|&gt;|&quot;/.test(link.title)) {
          errors.push(`[유튜브] 제목에 HTML entity 잔류: "${link.title.substring(0, 40)}..." — 디코딩 필요`);
        }
        if (/%[0-9A-F]{2}/i.test(link.title)) {
          errors.push(`[유튜브] 제목에 퍼센트 인코딩 잔류: "${link.title.substring(0, 40)}..." — 디코딩 필요`);
        }
      }
    }
  }

  // ── 10. _sources 포맷 검사 ──

  // 동일 필드 내 같은 URL 중복 등록 검출
  for (const [sourceKey, srcVal] of Object.entries(sources)) {
    if (!Array.isArray(srcVal)) continue;
    const urlsInField = {};
    for (const src of srcVal) {
      if (src && typeof src === 'object' && src.url) {
        urlsInField[src.url] = (urlsInField[src.url] || 0) + 1;
      }
    }
    const dupUrls = Object.entries(urlsInField).filter(([_, c]) => c > 1);
    for (const [url, count] of dupUrls) {
      errors.push(`[출처중복] sources["${sourceKey}"]에 동일 URL이 ${count}번 등록: "${url}" — 같은 필드에 같은 URL 중복 금지`);
    }

    for (let i = 0; i < srcVal.length; i++) {
      if (detectMultipleUrlsInSourceText(srcVal[i])) {
        errors.push(`[출처URL복수] sources["${sourceKey}"][${i}]: source text에 URL이 2개 이상 포함됨 — text/url 분리 원칙 위반. URL은 url 필드에만 1개, text는 기관명만 기재하세요`);
      }
      const orgHint = detectMergedOrgLabel(srcVal[i]);
      if (orgHint) {
        warnings.push(`[출처라벨병합] sources["${sourceKey}"][${i}]: ${orgHint} — URL이 언급된 모든 기관을 실제로 커버하는지 확인. 한 기관이 빠진 경우 별도 source 항목으로 분리하세요 (한 source = 한 기관 = 한 URL 원칙)`);
      }
    }

    // 검색결과 페이지 URL — 동적 검색결과는 출처로 부적합, FAIL
    // R67 교훈 반영: 잡포털 검색 URL(`/jobs?q=`) + `_csrf` 세션 URL 추가 차단.
    const SEARCH_RESULT_PATTERNS = [
      /work24\.go\.kr\/wk\/a\/b\/\d+\//,
      /worker\.co\.kr\/job\/list/,
      /work\.go\.kr\/.*[?&](query|searchKeyword|keyword)=/,
      /career\.go\.kr\/.*[?&](query|keyword|searchKeyword)=/,
      /saramin\.co\.kr\/.*[?&]cat_kewd=/,
      /jobkorea\.co\.kr\/.*[?&](cat_cd|cat_kewd|occupation)=/,
      /indeed\.com\/jobs\?/i,
      /\/jobs\?q=/i,
      /[?&]_csrf=/i,
    ];
    for (const src of srcVal) {
      if (src && src.url) {
        for (const pat of SEARCH_RESULT_PATTERNS) {
          if (pat.test(src.url)) {
            errors.push(`[검색결과URL] sources["${sourceKey}"]에 동적 검색결과/세션 URL: "${src.url}" — 기관 deep page 또는 구체적 학과·통계 페이지로 교체 필요 (R67 urlUnverified 교훈)`);
            break;
          }
        }
      }
    }

    // ── [policyUrl] 정책위반 URL 사전 게이트 (R67·R68 실측 사고 차단, 2026-07-04) ──
    // 로그인게이트/세션·잡포털 검색·리스트 URL을 POST 전에 차단한다.
    // ⚠️ 과차단 금지: 아래 정확 패턴만 — URL 안에 단순 단어 "search"/"research" 등은 잡지 않음.
    //
    // 패턴 분류:
    //   1) 로그인게이트/세션: _csrf= 파라미터 / nsis.kofons.or.kr 에듀 경로 / /sso/login 또는 /login.do 경로
    //   2) 검색·리스트: indeed 계열(서브도메인 포함) / /jobs?q= / /search?...(q=|query=|keyword=) / articleList+sc_word= / saramin·jobkorea 검색·리스트 경로
    const POLICY_URL_PATTERNS = [
      // 1) 로그인게이트/세션
      { re: /[?&]_csrf=/i,                                    label: '_csrf= 세션 파라미터 포함 URL (로그인 필요 페이지)' },
      { re: /nsis\.kofons\.or\.kr\/.*\/tt\/eduG/i,            label: 'nsis.kofons.or.kr /tt/eduG 경로 (로그인게이트 교육 URL)' },
      { re: /\/sso\/login(?:[/?#]|$)/i,                       label: '/sso/login 경로 (로그인 리다이렉트 URL)' },
      { re: /\/login\.do(?:[/?#]|$)/i,                        label: '/login.do 경로 (로그인 페이지 URL)' },
      // 2) 검색·리스트 (정확 패턴 — indeed 도메인 자체 + 잡포털 검색 파라미터)
      { re: /(?:^|\.)indeed\.com(?:\/|$)/i,                   label: 'indeed.com 계열 도메인 (잡포털 채용 검색 사이트)' },
      { re: /\/jobs\?q=/i,                                     label: '/jobs?q= 잡포털 검색 URL' },
      { re: /\/search\?[^#]*(?:q|query|keyword)=/i,            label: '/search?q= (또는 query=|keyword=) 검색 결과 URL' },
      { re: /articleList.*[?&]sc_word=/i,                      label: 'articleList?sc_word= 검색 리스트 URL' },
      { re: /saramin\.co\.kr\/.*\/(?:search|recruit\/joblist)(?:[/?#]|$)/i,  label: 'saramin 검색·구인 리스트 경로' },
      { re: /jobkorea\.co\.kr\/.*\/(?:search|recruit\/joblist)(?:[/?#]|$)/i, label: 'jobkorea 검색·구인 리스트 경로' },
    ];
    for (const src of srcVal) {
      if (!src || !src.url) continue;
      for (const { re, label } of POLICY_URL_PATTERNS) {
        if (re.test(src.url)) {
          errors.push(
            `[policyUrl] sources["${sourceKey}"] 정책위반 URL: "${src.url}" — ${label}. ` +
            `로그인게이트·세션·잡포털 검색·리스트 URL은 전공 식별자가 없어 출처로 부적합. ` +
            `기관 deep page (대학 학과·협회·정부 정책·언론 기사 등)로 교체 필요 (R67·R68 실측 사고 차단)`
          );
          break;
        }
      }
    }
  }

  for (const [sourceKey, srcVal] of Object.entries(sources)) {
    // delete merge 패턴 — server가 `delete updatedUserData._sources[key]` 처리 (cleanup 정합)
    if (srcVal && typeof srcVal === 'object' && !Array.isArray(srcVal) && srcVal.delete === true) {
      continue;
    }
    if (!Array.isArray(srcVal)) {
      errors.push(`[출처포맷] sources["${sourceKey}"]가 배열이 아님 — Array여야 함`);
      continue;
    }

    for (let i = 0; i < srcVal.length; i++) {
      const src = srcVal[i];
      if (typeof src === 'string') {
        warnings.push(`[출처포맷] sources["${sourceKey}"][${i}]: string 형식 — {text, url} 객체로 변환 필요`);
        continue;
      }
      if (typeof src !== 'object' || src === null) {
        errors.push(`[출처포맷] sources["${sourceKey}"][${i}]: null 또는 비객체`);
        continue;
      }
      // Rule 26 — text 필수 (server silent fallback `text: text || url` → raw URL 사이드바 노출 사고)
      if (!src.text || typeof src.text !== 'string' || src.text.trim().length === 0) {
        errors.push(`[출처text필수] sources["${sourceKey}"][${i}]: text 없음 — Rule 26. 한글 제목 (예: "기관명 — 페이지 제목") 필수. text 누락 시 서버 fallback으로 raw URL이 사이드바에 노출됨`);
      }
      // url 유효 도메인 검사
      if (src.url) {
        let validUrl = false;
        try {
          const parsed = new URL(src.url);
          validUrl = ['http:', 'https:'].includes(parsed.protocol);
        } catch {
          validUrl = false;
        }
        if (!validUrl) {
          errors.push(`[출처포맷] sources["${sourceKey}"][${i}].url 유효하지 않은 URL: "${src.url}"`);
        }
        if (src.text && src.text.includes('http')) {
          errors.push(`[출처포맷] sources["${sourceKey}"][${i}].text에 URL 포함 — text와 url 필드를 분리해야 함`);
        }
      } else if (!src.text) {
        warnings.push(`[출처포맷] sources["${sourceKey}"][${i}]: text와 url 모두 없음`);
      }
    }
  }

  // ── 10-C. 출처 정책 (origin/selfDomain/listPage/allowlist/orphan/broken) ─────
  {
    const flatSources = [];
    for (const [, srcArr] of Object.entries(sources)) {
      if (!Array.isArray(srcArr)) continue;
      for (const src of srcArr) if (src && typeof src === 'object') flatSources.push(src);
    }
    const hostInfo = classifySourceHosts(flatSources);

    // F') careerwiki.org / .kr 자기 사이트 인용 — 절대 금지 (FAIL)
    if (hostInfo.hasSelfDomain) {
      errors.push(`[selfDomain] _sources에 careerwiki.org/.kr URL 포함 — 자기 사이트 인용은 절대 금지. 외부 출처로 교체 필요`);
    }

    // F) [originDomain] — career.go.kr / work.go.kr / work24.go.kr / wagework.go.kr / job.go.kr
    // 전공 데이터 원천(CAREERNET/WORK24_MAJOR) 자기인용 금지 — 1건이라도 FAIL.
    if (hostInfo.originHostCount > 0) {
      const originSet = [...new Set(hostInfo.originUrls.map(u => {
        try { return new URL(u).host.toLowerCase(); } catch { return ''; }
      }).filter(Boolean))];
      errors.push(
        `[originDomain] _sources에 정부 산하 직업·전공정보 origin 도메인 ${hostInfo.originHostCount}건 발견 (${originSet.join(', ')}) — ` +
        `career.go.kr / work.go.kr / work24.go.kr / wagework.go.kr / job.go.kr는 ` +
        `CareerWiki 전공 데이터의 원본(origin)이므로 출처로 절대 사용 금지. ` +
        `대학 학과 .ac.kr deep / 학회·협회 .or.kr deep / 정부 정책 deep / 한국 미디어 deep article로 교체 필수`
      );
    }

    for (const [fieldKey, srcArr] of Object.entries(sources)) {
      if (!Array.isArray(srcArr)) continue;

      // E) listPage URL 차단
      for (let i = 0; i < srcArr.length; i++) {
        const src = srcArr[i];
        if (src && src.url && detectListPageUrl(src.url)) {
          errors.push(
            `[listPageURL] sources["${fieldKey}"][${i}].url 이 인덱스/카테고리/검색 페이지: "${src.url}" — ` +
            `전공 식별자·구체 콘텐츠가 포함된 deep page로 교체 필요`
          );
        }
      }

      // 룰 ZZZZ — fieldKey allowlist (전공판)
      const hasUrlEntry = srcArr.some(s => s && typeof s === 'object' && (s.url || s.text));
      if (hasUrlEntry && !ALLOWED_SOURCE_FIELDS.has(fieldKey)) {
        if (MAJOR_CANONICAL_FIELDS.has(fieldKey)) {
          errors.push(
            `[canonicalSources] sources["${fieldKey}"] 등록 금지 — ${fieldKey}는 canonical 필드 (출처 등록 금지, 본문 보강만 허용). ` +
            `출처는 whatStudy/howPrepare/jobProspect/mainSubjects/enterField/licenses에만 등록`
          );
        } else {
          errors.push(
            `[orphanSources] sources["${fieldKey}"]는 허용된 필드가 아님 — 전공 _sources fieldKey는 ` +
            `${[...ALLOWED_SOURCE_FIELDS].join('/')} 중 하나여야 함. ` +
            `미사용 fieldKey에 출처 등록 시 본문 [N] 매핑 불가 → silent orphan 사고. fieldKey 교정 또는 _sources에서 제거 필요`
          );
        }
      }

      // H·I·ZZZ) 허용 필드 — orphan/broken/sourcesWithoutMarkers 양방향 정합
      if (ALLOWED_SOURCE_FIELDS.has(fieldKey)) {
        const raw = getNestedField(fields, fieldKey);
        const body = normalizeProseBody(raw); // array 필드(mainSubjects 등)도 join하여 검사
        if (typeof body === 'string' && (raw !== undefined && raw !== null)) {
          const orphans = detectOrphanSourceIdx(body, srcArr);
          if (orphans.length > 0) {
            warnings.push(
              `[orphanSrc] sources["${fieldKey}"]에 ${srcArr.length}개 등록됐는데 본문에서 ` +
              `[${orphans.join('], [')}] 마커가 사용되지 않음 — 등록만 하고 본문 미인용. ` +
              `본문에 해당 출처를 인용하거나 _sources에서 제거 필요. ` +
              `(field-local 번호 기준: 본문 [N] ↔ _sources["${fieldKey}"][N-1])`
            );
          }
          const broken = detectBrokenSourceRef(body, srcArr);
          if (broken.length > 0) {
            errors.push(
              `[brokenRef] ${fieldKey} 본문에 [${broken.join('], [')}] 마커 있는데 ` +
              `_sources["${fieldKey}"] 길이 ${srcArr.length}개로 부족 — 본문 마커는 field-local 1..N 연속이어야 함. ` +
              `_sources에 누락 항목 추가하거나 본문 마커 정리 필요`
            );
          }

          // 룰 ZZZ — sourcesWithoutMarkers (등록만 하고 본문 [N] 미주입)
          const urlCount = srcArr.filter(s => s && typeof s === 'object' && s.url).length;
          const markerCount = (body.match(/\[\d+\]/g) || []).length;
          if (body.length >= 100 && urlCount >= 1 && markerCount === 0) {
            errors.push(
              `[sourcesWithoutMarkers] ${fieldKey} 본문 ${body.length}자에 _sources ${urlCount}건 등록됐는데 본문에 [N] 마커 0개 — ` +
              `출처를 등록했으면 본문에 [N] 1개 이상 박혀야 함. ` +
              `(a) fact가 본문에 등장하면 해당 위치에 [N] 추가 (b) 출처가 본문 fact를 cover 못 하면 _sources에서 제거`
            );
          }
        } else if (raw === undefined || raw === null) {
          // 출처만 등록하고 본문 필드 자체를 안 보낸 케이스 — 정합 검증 불가
          warnings.push(
            `[orphanSrc?] sources["${fieldKey}"] 등록됐는데 fields["${fieldKey}"] 본문이 payload에 없음 — ` +
            `본문+출처 함께 전송 필수 (각주 정합 검증 불가). 기존 본문에 [N]이 이미 있다면 본문도 함께 재전송하세요`
          );
        }
      }
    }
  }

  // ── 10-F. _sources 글로벌 idxGap 검사 ──
  {
    const gap = detectSourceIdxGap(sources);
    if (gap && gap.ok === false) {
      const firstMismatch = gap.actual.findIndex((id, i) => id !== gap.expected[i]);
      errors.push(
        `[idxGap] _sources 글로벌 id가 1부터 연속이 아님 — ` +
        `idx ${firstMismatch}: expected ${gap.expected[firstMismatch]}, got ${gap.actual[firstMismatch]}. ` +
        `평탄화 순서: [${gap.actual.slice(0, 20).join(',')}${gap.actual.length > 20 ? ',...' : ''}]. ` +
        `_sources 등록 순서 + id 번호를 페이지 표시 순서대로 1,2,3,... 재정렬 필요`
      );
    }
  }

  // ── 10-G2. _sources[].text URL 자기복제 (Rule 26 — text가 URL 패턴이면 FAIL) ──
  {
    for (const [fieldKey, srcArr] of Object.entries(sources)) {
      if (!Array.isArray(srcArr)) continue;
      for (let i = 0; i < srcArr.length; i++) {
        const src = srcArr[i];
        if (detectSourceTextIsUrl(src)) {
          const txt = (src.text || '').slice(0, 60);
          errors.push(
            `[sourceTextIsUrl] sources["${fieldKey}"][${i}].text가 URL — "${txt}". ` +
            `사이드바 렌더는 source.text만 사용하므로 raw URL이 그대로 노출됨. ` +
            `한글 제목 (예: "기관명 — 페이지 제목") 명시 필수 (Rule 26).`
          );
        }
      }
    }
  }

  // ── 10-I. Root URL Avoidance (룰 13 승계) ──
  {
    const rootHits = [];
    for (const [fieldKey, srcArr] of Object.entries(sources)) {
      if (!Array.isArray(srcArr)) continue;
      for (const src of srcArr) {
        if (src && src.url && detectRootDomainOnly(src.url)) {
          let host = '';
          try { host = new URL(src.url).host.toLowerCase(); } catch {}
          rootHits.push({ field: fieldKey, url: src.url, host });
        }
      }
    }
    if (rootHits.length > 0) {
      const desc = rootHits.slice(0, 5).map(h => `${h.field}: ${h.url}`).join(' / ');
      errors.push(
        `[rootURL] _sources에 root URL ${rootHits.length}건 발견 (${desc}${rootHits.length > 5 ? ' ...' : ''}) — ` +
        `대학/협회/회사 root는 fact cover 못 함. 학과 소개·커리큘럼 등 path depth ≥ 2의 deep page로 교체 필요. ` +
        `못 찾으면 본문 fact 일반화 또는 제거`
      );
    }
  }

  // ── 10-J. Wikipedia Quota (룰 14 승계 — 위키류 점유율 ≤ 30%) ──
  {
    const q = calcWikiQuota(sources);
    if (q.level === 'FAIL') {
      errors.push(
        `[wikiQuota] _sources의 위키 점유율 ${(q.ratio * 100).toFixed(1)}% (${q.count}/${q.total}) > 30% 초과 — ` +
        `1차 출처(대학 학과 deep / 정부 통계 / 학술 자료 / 1차 미디어 deep article)로 보강 필수. ` +
        `위키는 보조 출처로만 허용. (wiki host: *.wikipedia.org / namu.wiki / *.wikia.com / *.fandom.com)`
      );
    }
  }

  // ── 10-G. 본문 [N] 첫 등장 sequential 검사 (orderViolation 승계) ──
  {
    const parts = [];
    for (const f of BODY_FIELDS_FOR_ORDER) {
      const v = getNestedField(fields, f);
      if (typeof v === 'string') {
        parts.push(v);
      } else if (Array.isArray(v)) {
        for (const it of v) {
          const t = typeof it === 'string' ? it : (it && (it.text || it.title || it.name)) || '';
          if (t) parts.push(t);
        }
      }
    }
    const order = detectMarkerOrderViolation(parts.join('\n'));
    if (order && order.ok === false) {
      errors.push(
        `[orderViolation] 본문 [N] 첫 등장 순서가 sequential 아님 — ` +
        `idx ${order.breakAt}에서 expected [${order.breakAt + 1}], got [${order.firstAppear[order.breakAt]}]. ` +
        `첫 등장 순서: [${order.firstAppear.slice(0, 20).join(',')}${order.firstAppear.length > 20 ? ',...' : ''}]. ` +
        `본문 마커 + _sources 등록 순서를 페이지 표시 순서대로 1부터 재번호 필요`
      );
    }
  }

  // ── 10-B. 인라인 도메인 표기 감지 (산문 필드 본문 (도메인) 패턴 금지) ──
  {
    const INLINE_DOM = /\([a-z0-9.-]+\.(co\.kr|go\.kr|re\.kr|or\.kr|ac\.kr|com|net)\)/i;
    for (const fp of MAJOR_PROSE_FIELDS) {
      const val = getNestedField(fields, fp);
      if (val && typeof val === 'string' && INLINE_DOM.test(val)) {
        errors.push(`[인라인도메인] ${fp}에 괄호 안 도메인 표기 — 텍스트에서 제거 필요. 출처는 [N]+_sources로만: "${val.substring(0, 60)}..."`);
      }
    }
  }

  // ── 10-D. 본문-출처 fact 정합성 (factHostMismatch / decorativeSource 승계) ──
  {
    const ORG_KEYWORDS = [
      '사무소', '회사', '은행', '공사', '연구원', '연구소', '병원', '학회', '협회',
      '재단', '기금', '공단', '진흥원', '위원회', '연합회', '총회', '재단법인',
      '그룹', '전자', '반도체', '중공업', '건설', '조선', '항공', '자동차',
      '대학교', '대학', 'KAIST', 'POSTECH',
    ];

    function _romanizeFingerprint(name) {
      if (/^[A-Z]{2,}$/.test(name)) return [name.toLowerCase()];
      const latinHits = name.match(/[A-Za-z]{2,}/g) || [];
      return latinHits.map(s => s.toLowerCase());
    }

    for (const fp of MAJOR_PROSE_FIELDS) {
      if (MAJOR_CANONICAL_FIELDS.has(fp)) continue; // summary는 출처 없음
      const val = getNestedField(fields, fp);
      if (!val || typeof val !== 'string') continue;
      const srcArr = sources[fp];
      if (!Array.isArray(srcArr) || srcArr.length === 0) continue;

      const markerRe = /\[(\d+)\]/g;
      let m;
      while ((m = markerRe.exec(val)) !== null) {
        const N = parseInt(m[1], 10);
        if (N < 1 || N > srcArr.length) continue;
        const src = srcArr[N - 1];
        if (!src || !src.url) continue;
        let host;
        try { host = new URL(src.url).host.toLowerCase(); } catch { continue; }

        const before = val.slice(Math.max(0, m.index - 60), m.index);
        const orgs = [];
        const re1 = new RegExp(`([가-힣A-Za-z0-9]{2,10})(?:${ORG_KEYWORDS.map(k => k.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|')})`, 'g');
        let mm;
        while ((mm = re1.exec(before)) !== null) {
          orgs.push(mm[0]);
        }
        const reLatin = /\b[A-Z]{2,8}\b/g;
        while ((mm = reLatin.exec(before)) !== null) {
          if (mm[0].length >= 2 && !['SHA', 'MBA', 'NCS', 'GPA', 'URL', 'API'].includes(mm[0])) {
            orgs.push(mm[0]);
          }
        }

        for (const org of orgs) {
          const fingerprints = _romanizeFingerprint(org);
          if (fingerprints.length === 0) continue;
          const covered = fingerprints.some(fp2 => host.includes(fp2));
          if (!covered) {
            warnings.push(
              `[factHostMismatch] ${fp} 본문에 "${org}"가 [${N}] 직전에 등장하지만 ` +
              `_sources["${fp}"][${N - 1}].url host(${host})에 매칭 안 됨 — ` +
              `그 기관 공식 페이지로 출처 교체 또는 본문에서 그 기관명 제거 검토`
            );
          }
        }

        // 장식적 출처 패턴 — 서사적/통계적 진술 + root URL/블로그류 출처
        const NARRATIVE_OR_STAT = [
          /취업률\s*\d+(?:\.\d+)?\s*%/,
          /\d{1,2}\s*[~\-]\s*\d{1,2}\s*년/,
          /수출\s*\d+(?:\.\d+)?\s*억\s*달러/,
          /세계\s*[1-9]위|국내\s*[1-9]위/,
          /\d{1,3}(?:,\d{3})*\s*억\s*(?:원|달러)/,
          /\d{1,4}\s*조\s*원/,
          /\d{1,3}(?:,\d{3})*\s*만\s*원/,
        ];
        const beforeWide = val.slice(Math.max(0, m.index - 100), m.index);
        let isRootUrl = false;
        try {
          const u = new URL(src.url);
          const p = u.pathname || '/';
          if (p === '/' || p === '' || p === '/index.html' ||
              /^\/main\.do$/.test(p) || /^\/(intro|about)\/?$/.test(p)) {
            isRootUrl = true;
          }
        } catch {}
        const decorativeHosts = [
          /^(www\.|job\.)?asamaru\.net/i,
          /^(www\.)?jasoseol\.com/i,
          /^(www\.)?linkareer\.com/i,
          /^community\.linkareer\.com/i,
          /^blog\.naver\.com/i,
          /^cafe\.naver\.com/i,
        ];
        const isDecorativeHost = decorativeHosts.some(re => re.test(host));
        if (isRootUrl || isDecorativeHost) {
          for (const re of NARRATIVE_OR_STAT) {
            const hit = beforeWide.match(re);
            if (hit) {
              warnings.push(
                `[decorativeSource] ${fp} 본문 "${hit[0]}"가 [${N}] 직전 서사적/통계적 진술인데 ` +
                `_sources["${fp}"][${N - 1}].url이 ${isRootUrl ? 'root URL' : '장식적 출처(블로그/자소서류)'} (${src.url}) — ` +
                `해당 사실을 직접 보도/기술하는 1차 출처 deep page로 교체 또는 본문 일반화 필수`
              );
              break;
            }
          }
        }
      }
    }
  }

  // ── 11. 무출처 문장 감지 ──
  // Tier A (FULL): whatStudy/howPrepare/jobProspect — [N] 없음 WARN + trailing WARN
  // Tier B (TRAIL): summary — canonical이라 마커 자체 금지 (1-B에서 FAIL) → 검사 제외
  function checkTrailingSentence(text, fieldPath) {
    const allMarkers = [...text.matchAll(/\[\d+\]/g)];
    if (allMarkers.length === 0) return;
    const lastMarker = allMarkers[allMarkers.length - 1];
    const afterLast = text.substring(lastMarker.index + lastMarker[0].length).trim();
    if (afterLast.length >= 10) {
      const hasFinalEnding = /[다요]\.|습니다\.|입니다\.|됩니다\.|합니다\./.test(afterLast);
      const isSubstantial = afterLast.length >= 20;
      if (hasFinalEnding || isSubstantial) {
        warnings.push(`[무출처] ${fieldPath}: 마지막 ${lastMarker[0]} 이후 미출처 문장 (${afterLast.length}자) — "${afterLast.substring(0, 60)}"`);
      }
    }
  }

  for (const fieldPath of GATE_CORE_PROSE_FIELDS) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;
    const trimmed = text.trim();
    if (trimmed.length < 10) continue;

    const allMarkers = [...trimmed.matchAll(/\[\d+\]/g)];

    if (allMarkers.length === 0) {
      const hasSentence = /[가-힣]{3,}[다요]./.test(trimmed);
      if (hasSentence && trimmed.length >= 30) {
        warnings.push(`[무출처] ${fieldPath}: [N] 각주 마커 없음 (${trimmed.length}자) — 모든 서술에 출처 표기 필수`);
      }
    } else {
      checkTrailingSentence(trimmed, fieldPath);
    }
  }

  // ── 13. 결정적 게이트 3종 — totalE / prose / distinct (전공판 §2 게이트 수치) ──
  //
  // 모드 판정: 산문 3필드(whatStudy/howPrepare/jobProspect)가 모두 payload에 존재하면
  // 풀 enhance 모드 → FAIL. 미만이면 부분 패치/cleanup 모드 → WARN 강등.
  {
    const proseStatus = GATE_CORE_PROSE_FIELDS.map(f => {
      const v = getNestedField(fields, f);
      const present = v !== undefined && v !== null;
      return { field: f, present, body: present ? normalizeProseBody(v) : '' };
    });
    const presentCount = proseStatus.filter(s => s.present).length;
    const isFullEnhance = presentCount === GATE_CORE_PROSE_FIELDS.length;
    const modeSuffix = isFullEnhance ? '' : ' (부분 패치 모드 — WARN 강등)';
    const demote = (msg) => (isFullEnhance ? errors : warnings).push(msg);

    // ── 게이트 1 [totalEntries미달] — _sources 총 entry ≥ 12 ──
    let totalEntries = 0;
    const distinctUrls = new Set();
    for (const [, arr] of Object.entries(sources)) {
      if (!Array.isArray(arr)) continue;
      for (const src of arr) {
        if (!src || typeof src !== 'object') continue;
        totalEntries++;
        if (src.url && typeof src.url === 'string') distinctUrls.add(src.url);
      }
    }
    if (totalEntries < GATE_TOTAL_ENTRIES_MIN) {
      demote(
        `[totalEntries미달] _sources 총 entry ${totalEntries}개 < ${GATE_TOTAL_ENTRIES_MIN} — ` +
        `전공 enhance totalE ≥ ${GATE_TOTAL_ENTRIES_MIN} 룰 (major_cycle_design_v1.md §2)${modeSuffix}`
      );
    }

    // ── 게이트 2 [prose영역미달] — 산문 3필드 각 ≥300자 + 본문 [N] 보유 ──
    for (const s of proseStatus) {
      if (!s.present) {
        if (isFullEnhance) {
          // presentCount === 3 이므로 도달 불가 — 방어용
          errors.push(`[prose영역미달] ${s.field} 영역 누락 — 산문 3필드 전수 작성 의무`);
        }
        continue;
      }
      if (s.body.length < GATE_PROSE_MIN_LEN) {
        demote(
          `[prose영역미달] ${s.field} 본문 ${s.body.length}자 < ${GATE_PROSE_MIN_LEN}자 — ` +
          `산문 3필드(whatStudy/howPrepare/jobProspect) 각 ${GATE_PROSE_MIN_LEN}자+ 작성 의무 (§2)${modeSuffix}`
        );
      }
      if (!/\[\d+\]/.test(s.body)) {
        demote(
          `[prose각주없음] ${s.field} 본문에 [N] 각주 마커 0개 — ` +
          `산문 3필드는 본문 내 각주 [N] 보유 의무 (§2)${modeSuffix}`
        );
      }
    }
    // 풀 enhance 모드: 산문 3필드 미존재 시 FAIL (isMasterMarker 풀 모드인데 일부 누락)
    if (isMasterMarker && !isPartialMode && !isFullEnhance) {
      const missing = proseStatus.filter(s => !s.present).map(s => s.field);
      errors.push(
        `[prose영역미달] master enhance patch인데 산문 필드 누락: ${missing.join(', ')} — ` +
        `whatStudy/howPrepare/jobProspect 3필드 전수 작성 의무 (부분 모드는 changeSummary에 cleanup/--field-only= 명시)`
      );
    }

    // ── 게이트 3 [distinct미달] — distinct URL ≥ 8 (단일 티어) ──
    const distinct = distinctUrls.size;
    if (distinct < GATE_DISTINCT_MIN) {
      demote(`[distinct미달] distinct URL ${distinct}개 < ${GATE_DISTINCT_MIN} — 전공은 단일 티어 distinct 출처 URL ${GATE_DISTINCT_MIN}+ 필수 (§2)${modeSuffix}`);
    }
  }

  return { errors, warnings };
}

// ── 유틸리티 ──

function getNestedField(obj, path) {
  if (obj[path] !== undefined) return obj[path];
  const parts = path.split('.');
  let current = obj;
  for (const part of parts) {
    if (current == null) return undefined;
    current = current[part];
  }
  return current;
}

// ── 메인 실행 ──

async function main() {
  let input;

  const cliArgs = process.argv.slice(2);
  const fileArg = cliArgs.find(a => !a.startsWith('--'));

  if (fileArg) {
    input = fs.readFileSync(fileArg, 'utf8');
  } else if (!process.stdin.isTTY) {
    input = fs.readFileSync(0, 'utf8');
  } else {
    console.error('Usage: node scripts/validate-major-edit.cjs <json-file>');
    console.error('   or: echo \'{"fields":...}\' | node scripts/validate-major-edit.cjs');
    console.error('Env: VALIDATE_CHECK_URLS=1 — _sources URL HEAD fetch 검증 (4xx/5xx/timeout = [urlBroken] FAIL)');
    console.error('     VALIDATE_URL_SAMPLE=30 — 30%만 sample 검증');
    process.exit(1);
  }

  let data;
  try {
    data = JSON.parse(input);
  } catch (e) {
    console.error(`JSON 파싱 실패: ${e.message}`);
    process.exit(1);
  }

  const { errors, warnings } = await validateAsync(data, {});

  console.log(`\n=== 검증 결과 (major): ${data.majorName || data.jobName || 'Unknown'} ===\n`);

  if (errors.length === 0 && warnings.length === 0) {
    console.log('✅ ALL PASS — API 호출 가능\n');
    process.exit(0);
  }

  if (errors.length > 0) {
    console.log(`❌ ERRORS (${errors.length}개 — API 호출 차단):`);
    errors.forEach(e => console.log(`  ${e}`));
    console.log();
  }

  if (warnings.length > 0) {
    console.log(`⚠️ WARNINGS (${warnings.length}개 — 수동 확인 필요):`);
    warnings.forEach(w => console.log(`  ${w}`));
    console.log();
  }

  if (errors.length > 0) {
    console.log('❌ FAIL — 에러 수정 후 재검증 필요\n');
    process.exit(1);
  } else {
    console.log('⚠️ PASS WITH WARNINGS — API 호출 가능하지만 경고 확인 권장\n');
    process.exit(0);
  }
}

// Export for programmatic use
module.exports = { validate, validateAsync, checkUrlsLive };

if (require.main === module) {
  main().catch(e => { console.error(e); process.exit(1); });
}
