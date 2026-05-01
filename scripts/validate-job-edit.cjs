#!/usr/bin/env node
/**
 * validate-job-edit.js
 *
 * Researcher 에이전트가 반환한 JSON을 검증하는 스크립트.
 * 팀 리더가 API 호출 전에 실행하여 치명적 실수를 차단한다.
 *
 * Usage: node scripts/validate-job-edit.js <json-file-or-stdin>
 *
 * Input JSON format:
 * {
 *   "jobName": "가정교사",
 *   "jobId": "1765284120082557",
 *   "fields": { ... },
 *   "sources": { ... },
 *   "careerTree": { ... } | null,
 *   "changeSummary": "..."
 * }
 */

const fs = require('fs');
const path = require('path');

// ── 공유 패턴 모듈 (M3: detect-patterns.cjs) ──────────────────────────────────
// 출처 병합 탐지 함수와 잘린 문장 패턴을 단일 모듈에서 관리.
const {
  detectMultipleUrlsInSourceText,
  detectMergedOrgLabel,
  detectMojibake,
  detectMissingFootnoteInArrayItems,
  analyzeYoutubeSearchNote,
  analyzeCareerTreeNote,
  detectTriviaInlineFootnote,
  // 2026-04-29 source-policy 강화 (deep audit 발견)
  detectListPageUrl,
  classifySourceHosts,
  detectOriginDomain,
  detectOrphanSourceIdx,
  detectBrokenSourceRef,
} = require(path.join(__dirname, '_shared', 'detect-patterns.cjs'));

// ── Sentence-level marker cluster detection (audit-sentence-clusters.cjs와 동일 로직) ──
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

// ── 검증 규칙 ──────────────────────────────────────────

const FORBIDDEN_EXAM_KEYWORDS = ['시험', 'LEET', 'TOEIC', 'TOEFL', 'TEPS', 'IELTS', '수능', '모의고사'];
const SHORT_LABEL_FIELDS = ['overviewWork.workStrong', 'overviewWork.workPlace', 'overviewWork.physicalAct'];
const STATS_ONLY_FIELDS = ['overviewAbilities.abilityList', 'overviewAptitude', 'detailEducation'];
const FOREIGN_NAME_PATTERNS = [
  /^[A-Z][a-z]+ [A-Z][a-z]+/, // "James Herriot"
  /[가-힣]+ [가-힣]+/, // OK - Korean
];

// 역대 대통령 — careerTree에 절대 금지 (is_active=0 인물)
const FORBIDDEN_PRESIDENTS = [
  '이승만', '윤보선', '박정희', '최규하', '전두환', '노태우',
  '김영삼', '김대중', '노무현', '이명박', '박근혜', '문재인', '윤석열',
];

// ── URL HEAD fetch (실시간 hallucinated URL 차단) ──
// validate() async 호출 시 _sources URL 전수 HEAD fetch → 4xx/5xx/timeout이면 [urlBroken] FAIL
// 사용:
//   VALIDATE_CHECK_URLS=1 node scripts/validate-job-edit.cjs file.json
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
        // HEAD 실패 시 GET으로 재시도 (일부 서버는 HEAD 미지원)
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

async function validateAsync(data) {
  const result = validate(data);
  // URL HEAD fetch (옵션)
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

function validate(data) {
  const errors = [];   // 치명적 — API 호출 차단
  const warnings = []; // 경고 — 수동 확인 필요

  const { fields = {}, sources = {}, careerTree, changeSummary } = data;

  // ── 0-PRE. Minimal POST 차단 (단축 처리 사고 방지, 2026-04-29) ──
  // changeSummary에 [job-data-enhance] 마커만 있고 fields가 비어 있거나
  // 1-2개 trivial 변경만이면 단축 처리로 간주하여 FAIL.
  const isEnhanceMarker = typeof changeSummary === 'string' && /\[(job|major)-data-enhance\]/.test(changeSummary);
  if (isEnhanceMarker) {
    const fieldKeys = Object.keys(fields).filter(k => fields[k] !== null && fields[k] !== undefined && fields[k] !== '');
    const sourceKeys = Object.keys(sources).filter(k => sources[k] && (Array.isArray(sources[k]) ? sources[k].length > 0 : true));
    if (fieldKeys.length === 0 && sourceKeys.length === 0) {
      errors.push(`[minimalPOST] changeSummary에 [job-data-enhance] 마커만 있고 fields/sources 모두 비어있음 — minimal POST는 단축 처리로 간주, 풀 사이클 Phase 0~5 강제`);
    } else if (fieldKeys.length <= 1 && sourceKeys.length === 0) {
      warnings.push(`[minimalPOST?] fields ${fieldKeys.length}개 + sources 0개 — trivial 변경 의심. enhance가 풀 사이클이면 17필드 보강이 정상`);
    }
  }

  // ── 0. Mojibake (인코딩 깨짐) 사전 탐지 ──
  // Windows curl CP949 오류 등으로 한글이 아랍/키릴/라틴확장 문자로 깨진 경우를 즉시 차단.
  // fields 내 모든 문자열 필드 + sources 내 text 값을 검사한다.
  const checkMojibake = (value, label) => {
    if (!value) return;
    if (typeof value === 'string') {
      if (detectMojibake(value)) {
        errors.push(`[Mojibake] ${label} — 한글이 깨진 문자(아랍·키릴·라틴확장 등)로 저장됨. 인코딩 확인 필수 (Windows curl -d 사용 금지)`);
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
  // fields 전체 재귀 검사
  checkMojibake(fields, 'fields');
  // sources 내 text 값 검사
  for (const [srcKey, srcArr] of Object.entries(sources)) {
    if (Array.isArray(srcArr)) {
      srcArr.forEach((src, i) => {
        if (src && src.text && detectMojibake(src.text)) {
          errors.push(`[Mojibake] sources["${srcKey}"][${i}].text — 각주 텍스트가 깨진 문자로 저장됨`);
        }
      });
    }
  }

  // ── 1. 필드 완성도 ──

  // way 필수 + 최소 분량
  if (fields.way) {
    if (fields.way.length < 100) {
      errors.push(`[필드] way가 너무 짧음 (${fields.way.length}자, 최소 200자 권장)`);
    }
  } else {
    warnings.push(`[필드] way가 없음 — 가장 중요한 필드`);
  }

  // detailReady 점검
  if (fields.detailReady) {
    const dr = typeof fields.detailReady === 'string' ? JSON.parse(fields.detailReady) : fields.detailReady;
    if (!dr.curriculum || dr.curriculum.length < 3) {
      warnings.push(`[필드] detailReady.curriculum이 ${dr.curriculum?.length || 0}개 (최소 5개 권장)`);
    }
    // detailReady 출처 누락 검사 (F2) — Rule 12 타입 검사는 아래 ── 12 ── 섹션에서 처리
    for (const sub of ['curriculum', 'recruit', 'training']) {
      if (dr[sub] && dr[sub].length > 0 && !sources[`detailReady.${sub}`]) {
        errors.push(`[curriculum-출처누락] detailReady.${sub}에 내용이 있지만 sources["detailReady.${sub}"]가 없음 — 반드시 출처 등록 필요`);
      }
    }

    // OS(Orphan Source) 탐지: sources["detailReady.X"]가 있는데 해당 배열의 어느 항목에도 [N] 마커가 없으면 WARN
    // 원칙: 출처를 등록했으면 마지막 항목 끝에 [1] 마커가 있어야 함
    for (const sub of ['curriculum', 'recruit', 'training', 'certificate']) {
      const srcKey = `detailReady.${sub}`;
      if (sources[srcKey] && sources[srcKey].length > 0 && dr[sub] && dr[sub].length > 0) {
        const items = dr[sub];
        const hasMarker = items.some(item => {
          const text = typeof item === 'string' ? item : (item?.text || '');
          return /\[\d+\]/.test(text);
        });
        if (!hasMarker) {
          errors.push(`[OS-Orphan] detailReady.${sub}: sources["${srcKey}"]가 등록되어 있지만 배열 항목에 [N] 마커가 없음 — 마지막 항목 끝에 [1] 추가 필요`);
        }
      }
    }

    // [markerCluster-array] sentence-level cluster 검사 (배열 항목 내부)
    // 한 항목 안에 마커 2+ → FAIL. 항목 분리 또는 sentence 분리 필요.
    for (const sub of ['curriculum', 'recruit', 'training', 'certificate']) {
      if (!dr[sub] || !Array.isArray(dr[sub])) continue;
      dr[sub].forEach((item, idx) => {
        if (typeof item !== 'string') return;
        const clusters = detectSentenceClusters(item);
        if (clusters.length > 0) {
          const c = clusters[0];
          errors.push(`[markerCluster] detailReady.${sub}[${idx}]: 한 항목 안에 sentence cluster — "${c.markers}" in "${item.slice(0, 100)}${item.length > 100 ? '...' : ''}". 항목 분리 또는 sentence 분리 필요.`);
        }
      });
    }

    // 중복 [N] 탐지: detailReady 배열의 같은 필드에서 동일한 [N] 마커가 2회 이상 등장하면 WARN
    for (const sub of ['curriculum', 'recruit', 'training', 'certificate']) {
      if (!dr[sub] || !Array.isArray(dr[sub])) continue;
      const markerCounts = {};
      dr[sub].forEach(item => {
        const text = typeof item === 'string' ? item : (item?.text || '');
        const markers = text.match(/\[\d+\]/g) || [];
        markers.forEach(m => { markerCounts[m] = (markerCounts[m] || 0) + 1; });
      });
      const dupes = Object.entries(markerCounts).filter(([_, c]) => c > 1);
      if (dupes.length > 0) {
        errors.push(`[각주중복] detailReady.${sub}: ${dupes.map(([n, c]) => `${n}이 ${c}회`).join(', ')} — 마지막 항목에만 1회 표기`);
      }
    }
    // recruit 항목이 {text, url} 객체이면 UI에 URL 도메인이 그대로 노출되는 버그 발생 — WARN
    if (dr.recruit && Array.isArray(dr.recruit)) {
      const objItems = dr.recruit.filter(item => item !== null && typeof item === 'object' && !Array.isArray(item));
      if (objItems.length > 0) {
        errors.push(`[recruit-객체] detailReady.recruit에 {text, url} 객체 항목 ${objItems.length}개 — 반드시 plain string으로 변환. URL은 _sources["detailReady.recruit"]에만 등록`);
      }
    }

    // 인라인 도메인 표기 감지 — 텍스트 본문에 (도메인) 패턴 금지
    // 출처 정보는 각주 [N] + _sources로만 표기해야 함
    const INLINE_DOMAIN_PAT = /\([a-z0-9.-]+\.(co\.kr|go\.kr|re\.kr|or\.kr|com|net)\)/i;
    for (const sub of ['curriculum', 'recruit', 'training', 'certificate']) {
      if (!dr[sub] || !Array.isArray(dr[sub])) continue;
      dr[sub].forEach((item, idx) => {
        const text = typeof item === 'string' ? item : (item?.text || '');
        if (INLINE_DOMAIN_PAT.test(text)) {
          errors.push(`[인라인도메인] detailReady.${sub}[${idx}]에 괄호 안 도메인 표기 — 텍스트에서 제거 필요. 출처는 [N]+_sources로만: "${text.substring(0, 60)}..."`);
        }
      });
    }

    // ── 룰 A: UCJ detailReady 배열 항목별 [N] 필수 ──────────────────────────────
    // curriculum / recruit / training 각 항목에 [N] 마커 필수.
    // researchList는 CareerNet 원본이므로 제외.
    for (const sub of ['curriculum', 'recruit', 'training']) {
      if (!dr[sub] || !Array.isArray(dr[sub])) continue;
      const missingIdxs = detectMissingFootnoteInArrayItems(dr[sub]);
      if (missingIdxs.length > 0) {
        const previews = missingIdxs.map(i => {
          const t = typeof dr[sub][i] === 'string' ? dr[sub][i] : (dr[sub][i]?.text || '');
          return `[${i}]"${t.substring(0, 35)}..."`;
        });
        errors.push(
          `[UCJ각주항목누락] detailReady.${sub} ${previews.join(', ')} — 모든 UCJ 배열 항목에 [N] 각주 필수. ` +
          `항목별 출처가 같으면 같은 [N] 공유 금지 — 항목마다 각각 [N] 부여`
        );
      }
    }

    // detailReady.researchList 수정 금지 — CareerNet 원본 필드
    if (dr.researchList && dr.researchList.length > 0) {
      errors.push(`[detailReady.researchList] CareerNet canonical field. Do not add, edit, or delete it in job-data-enhance drafts.`);
    }

    // detailReady.certificate body content is out of scope for job-data-enhance.
    // Cleanup-only emptying is allowed, but sending sources with it is blocked.
    // Adding or editing body certificate content is blocked.
    if (Array.isArray(dr.certificate)) {
      if (dr.certificate.length > 0) {
        errors.push(`[detailReady.certificate] Body certificate content is out of scope. Update sidebarCerts instead.`);
      } else if (sources['detailReady.certificate'] && sources['detailReady.certificate'].length > 0) {
        errors.push(`[detailReady.certificate] certificate was emptied but sources["detailReady.certificate"] was still sent. Remove those sources for cleanup-only drafts.`);
      }
    } else if (sources['detailReady.certificate'] && sources['detailReady.certificate'].length > 0) {
      errors.push(`[detailReady.certificate] Body certificate sources are not allowed. Use sidebarCerts sources only.`);
    }
  } else {
    warnings.push(`[필드] detailReady가 없음`);
  }

  // trivia 점검
  if (fields.trivia) {
    if (fields.trivia.length < 20) {
      warnings.push(`[필드] trivia가 너무 짧음 (${fields.trivia.length}자)`);
    }

    // ── 룰 D: trivia 각주 배치 검사 ──────────────────────────────────────────
    // (a) 마지막 [N] 뒤에 실질 텍스트가 이어지거나
    // (b) 각주 2개 이상이 맨 끝에 연속 몰려 있으면 FAIL.
    // 각주는 해당 출처가 커버하는 내용의 마지막 문장 뒤에 위치해야 한다.
    const triviaViolation = detectTriviaInlineFootnote(fields.trivia);
    if (triviaViolation) {
      const preview = fields.trivia.replace(/^(.{0,80}).*$/, '$1');
      errors.push(
        `[Trivia/각주배치] ${triviaViolation} — ` +
        `각주는 해당 출처가 커버하는 마지막 문장 뒤에 위치해야 함. ` +
        `각주가 1개면 위치 무관, 여러 개면 각 출처가 커버하는 구간 끝에 분산 배치. ` +
        `미리보기: "${preview}..."`
      );
    }
  }

  // sidebarJobs 수량
  if (fields.sidebarJobs) {
    const jobs = Array.isArray(fields.sidebarJobs) ? fields.sidebarJobs : JSON.parse(fields.sidebarJobs);
    if (jobs.length > 15) {
      errors.push(`[사이드바] sidebarJobs가 ${jobs.length}개 — 7~12개로 정리 필요`);
    } else if (jobs.length > 12) {
      warnings.push(`[사이드바] sidebarJobs가 ${jobs.length}개 — 12개 이하 권장`);
    }
  }

  // sidebarCerts — 최소 수량 + 시험 여부 체크 + [N] 마커 금지
  if (fields.sidebarCerts) {
    const certs = Array.isArray(fields.sidebarCerts) ? fields.sidebarCerts : JSON.parse(fields.sidebarCerts);
    if (certs.length < 2) {
      warnings.push(`[sidebarCerts] 자격증이 ${certs.length}개 — 2개 이상 권장. 기존 DB 값보다 적어졌을 수 있음 — 직접 확인 필요`);
    }
    for (const cert of certs) {
      const name = typeof cert === 'string' ? cert : cert.name;
      // 국가기술자격 등급 접미사가 있으면 "시험" 포함해도 자격증으로 허용
      // 예: "건설재료시험기사", "토목시험기능사" 등
      const isNationalQual = name && /기사$|기능사$|기술사$|산업기사$|지도사$|기능장$/.test(name);
      for (const kw of FORBIDDEN_EXAM_KEYWORDS) {
        if (name && name.includes(kw) && !name.includes('자격') && !name.includes('면허') && !isNationalQual) {
          errors.push(`[자격증] "${name}"은 시험이지 자격증이 아님 — 제거 또는 "~자격증" 형태로`);
        }
      }
      // sidebarCerts 항목 텍스트에 [N] 마커 금지
      if (name && /\[\d+\]/.test(name)) {
        warnings.push(`[sidebarCerts] "${name}" — sidebarCerts 항목 텍스트에 [N] 마커가 포함되어 있습니다. sidebarCerts는 자격증명만 저장하세요. 출처는 sources["sidebarCerts"]에만 등록.`);
      }
    }
  }

  // sidebarMajors — [N] 마커 금지
  if (fields.sidebarMajors) {
    const majors = Array.isArray(fields.sidebarMajors) ? fields.sidebarMajors : JSON.parse(fields.sidebarMajors);
    for (const major of majors) {
      const name = typeof major === 'string' ? major : major.name;
      if (name && /\[\d+\]/.test(name)) {
        warnings.push(`[sidebarMajors] "${name}" — sidebarMajors 항목 텍스트에 [N] 마커가 포함되어 있습니다. 전공명만 저장하세요.`);
      }
    }
  }

  // sidebarOrgs — [N] 마커 금지
  if (fields.sidebarOrgs) {
    const orgs = Array.isArray(fields.sidebarOrgs) ? fields.sidebarOrgs : JSON.parse(fields.sidebarOrgs);
    for (const org of orgs) {
      const name = typeof org === 'string' ? org : org.name;
      if (name && /\[\d+\]/.test(name)) {
        warnings.push(`[sidebarOrgs] "${name}" — sidebarOrgs 항목 텍스트에 [N] 마커가 포함되어 있습니다. 기관명만 저장하세요.`);
      }
    }
  }

  // heroTags 점검
  const NOUN_EXCEPTIONS = ['강의', '설비', '기여', '처리', '관리', '설계', '분석', '개발', '운의', '합의', '회의', '정의', '위의', '아나운서', '캐스터', '리포터', '호스트'];

  if (fields.heroTags) {
    const tags = Array.isArray(fields.heroTags) ? fields.heroTags : JSON.parse(fields.heroTags);
    if (tags.length < 3) warnings.push(`[태그] heroTags가 ${tags.length}개 (최소 3개)`);
    if (tags.length > 10) warnings.push(`[태그] heroTags가 ${tags.length}개 (최대 10개)`);
    for (const tag of tags) {
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

  // ── 2. 짧은 라벨 필드 ──

  for (const fieldPath of SHORT_LABEL_FIELDS) {
    const val = getNestedField(fields, fieldPath);
    if (val && typeof val === 'string' && val.length > 20) {
      errors.push(`[라벨] ${fieldPath}가 "${val.substring(0, 30)}..." — 짧은 라벨이어야 함 (20자 이하)`);
    }
  }

  // ── 3. 공식 통계 전용 필드 ──

  for (const fieldPath of STATS_ONLY_FIELDS) {
    const val = getNestedField(fields, fieldPath);
    if (val && val !== null) {
      // sources에 해당 필드의 출처가 있는지 확인
      const sourceKey = fieldPath.includes('.') ? fieldPath : fieldPath;
      if (!sources[sourceKey] && !sources[fieldPath]) {
        errors.push(`[통계전용] ${fieldPath}에 값이 있지만 출처가 없음 — 공식 통계만 허용`);
      }
    }
  }

  // ── 4. 각주 검증 ──

  const textFields = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'summary',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow'];

  for (const fieldPath of textFields) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const footnoteMatches = text.match(/\[(\d+)\]/g);
    if (!footnoteMatches) continue;

    // [markerCluster] sentence-level cluster 검사 — 본질: 한 sentence(의미 단위) = 1 마커
    // 같은 문장(마침표/!/?/줄바꿈 사이) 안에 마커 2+ → FAIL.
    // chained-at-end (`[1][2]`, `[1]·[2]`), mid-sentence comma (`...전망되며[1], ...있다[2]`) 모두 catch.
    // 해결: 본문을 의미 단위로 분리 + 각 sentence에 마커 1개. 가운뎃점 분리는 본질 미해결 (deprecated).
    // audit: node scripts/skill-cache/audit-sentence-clusters.cjs --slug={X}
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

    // sources 대응 확인
    const sourceKey = getSourceKey(fieldPath);
    if (!sources[sourceKey]) {
      errors.push(`[출처] ${fieldPath}에 [N] 각주가 있지만 sources["${sourceKey}"]가 없음`);
    } else {
      const srcArr = sources[sourceKey];
      if (Array.isArray(srcArr)) {
        // blob 체크 — 하나의 항목에 [1]...[2]... 가 다 들어있으면 blob
        for (const src of srcArr) {
          const srcText = typeof src === 'string' ? src : src.text;
          if (srcText && (srcText.match(/\[\d+\]/g) || []).length > 1) {
            errors.push(`[출처blob] sources["${sourceKey}"]에 blob 발견: "${srcText.substring(0, 60)}..." — 개별 항목으로 분리 필요`);
          }
        }
        // text/url 분리 체크
        for (const src of srcArr) {
          if (typeof src === 'object' && src.text && src.text.includes('http')) {
            errors.push(`[출처형식] sources["${sourceKey}"]의 text에 URL이 포함됨 — text와 url을 분리해야 함`);
          }
          // text가 URL로 시작하면 FAIL (기관명이어야 함)
          if (typeof src === 'object' && src.text && /^https?:\/\//.test(src.text.replace(/^\[\d+\]\s*/, ''))) {
            errors.push(`[출처형식] sources["${sourceKey}"]의 text가 URL로 시작 — "[N] 기관명" 형식 사용 필요`);
          }
          // text가 [N] 마커로 시작하면 FAIL (마커는 본문에만 — sources.text는 기관명만)
          // 사례 (피부관리사): {"text":"[1] (사)한국피부미용사회중앙회"} — [1] prefix는 본문 marker로만 사용
          if (typeof src === 'object' && src.text && /^\[\d+\]/.test(src.text)) {
            errors.push(`[출처마커prefix] sources["${sourceKey}"]의 text가 [N] 마커로 시작 — text에는 기관명만, [N] 마커는 본문에만 사용: "${src.text.substring(0, 80)}..."`);
          }
        }
      }
    }
    // Reject multi-sentence prose that collapses multiple footnotes at the paragraph tail.
    // Bad: sentence A. sentence B.[1][2]  Good: sentence A.[1] sentence B.[2]
    const sentenceCount = (text.match(/[.!?](?:\s|$)/g) || []).length;
    const collapsedTailFootnotes = text.match(/([.!?])\s*(\[\d+\]\s*){2,}$/);
    const textBeforeTailFootnotes = text.replace(/([.!?])\s*(\[\d+\]\s*){2,}$/, "");
    const hasEarlierFootnote = /\[\d+\]/.test(textBeforeTailFootnotes);
    if (sentenceCount >= 2 && collapsedTailFootnotes && !hasEarlierFootnote) {
      errors.push(`[footnote-split] ${fieldPath}: multiple footnotes are stacked only at the paragraph end. Split them by sentence, e.g. sentence A.[1] sentence B.[2]`);
    }
  }

  // ── 5. 커리어트리 검증 ──

  if (careerTree) {
    const trees = Array.isArray(careerTree) ? careerTree : [careerTree];
    for (const tree of trees) {
      // 외국인 체크
      if (tree.person_name_en && !tree.person_name) {
        errors.push(`[커리어트리] 영문명만 있고 한글명 없음 — 외국인 의심`);
      }
      if (tree.person_name && /^[A-Za-z\s]+$/.test(tree.person_name)) {
        errors.push(`[커리어트리] "${tree.person_name}" — 외국인은 절대 금지`);
      }

      // 역대 대통령 체크 — is_active=0 인물 절대 금지 (H3)
      if (tree.person_name) {
        const matchedPresident = FORBIDDEN_PRESIDENTS.find(p => tree.person_name.includes(p));
        if (matchedPresident) {
          errors.push(`[careerTree-대통령금지] "${tree.person_name}" — 역대 대통령은 careerTree에 절대 금지 (is_active=0 인물). SKILL.md Phase 3.6 인물 선정 기준 참조`);
        }
      }

      // stages 점검
      if (tree.stages_json) {
        const stages = typeof tree.stages_json === 'string' ? JSON.parse(tree.stages_json) : tree.stages_json;

        // order 기준 정렬 (DB 저장 순서와 동일하게)
        const sorted = [...stages].sort((a, b) => (a.order ?? 0) - (b.order ?? 0));

        // [careerTree-자기강조] job_slug 설정 확인
        // 반드시 하나 이상의 스테이지에 job_slug가 있어야 함
        const slugStages = sorted.filter(s => s.job_slug);
        if (slugStages.length === 0) {
          errors.push(`[careerTree-자기강조] "${tree.person_name || '?'}" — stages_json에 job_slug가 설정된 스테이지 없음. 해당 직업 입직 스테이지(보통 두 번째)에 job_slug 필수`);
        } else if (sorted.length >= 2) {
          // job_slug 스테이지가 마지막이면 FAIL (거장·전직 강조 금지)
          const lastStage = sorted[sorted.length - 1];
          if (slugStages.some(s => s === lastStage || s.order === lastStage.order)) {
            errors.push(`[careerTree-자기강조] "${tree.person_name || '?'}" — job_slug가 마지막 스테이지("${lastStage.title || '마지막'}") 에 설정됨. 거장·전직 스테이지 강조 금지 — 입직 스테이지에 job_slug 설정 필요`);
          }
          // data.slug와 불일치 감지 (draft에 slug 있을 때만)
          const jobSlug = data.slug;
          if (jobSlug && slugStages.length > 0 && !slugStages.some(s => s.job_slug === jobSlug)) {
            warnings.push(`[careerTree-자기강조] job_slug="${slugStages[0].job_slug}" 이 현재 직업 slug="${jobSlug}" 와 불일치`);
          }
        }

        // 전직 스테이지 체크 (마지막 스테이지가 다른 직업이면 의심)
        if (sorted.length > 0) {
          const lastStage = sorted[sorted.length - 1];
          const suspiciousRoles = ['국회의원', '장관', '대통령', '감독', 'CEO', '회장', '사장', '교수'];
          for (const role of suspiciousRoles) {
            if (lastStage.title && lastStage.title.includes(role)) {
              warnings.push(`[커리어트리] 마지막 스테이지 "${lastStage.title}" — 전직 스테이지 의심. 해당 직업 이후 전직은 제외`);
            }
          }
        }
      }
    }
  }

  // ── 5-B. 커리어트리 DB 중복 링크 검사 (slug 있을 때 선택 실행) ──
  // career_tree_job_links에서 같은 직업에 대한 중복 링크 감지
  if (data.slug) {
    try {
      const { execSync } = require('child_process');
      const result = execSync(
        `npx wrangler d1 execute careerwiki-kr --remote --json --command "SELECT career_tree_id, COUNT(*) as cnt FROM career_tree_job_links WHERE job_slug='${data.slug.replace(/'/g, "''")}' GROUP BY career_tree_id HAVING cnt > 1"`,
        { encoding: 'utf8', cwd: require('path').join(__dirname, '..'), stdio: ['pipe', 'pipe', 'pipe'], timeout: 15000 }
      );
      const parsed = JSON.parse(result);
      const dupes = parsed?.[0]?.results || [];
      for (const dup of dupes) {
        errors.push(`[careerTree-자기강조] career_tree_id=${dup.career_tree_id}에 job_slug="${data.slug}" 중복 링크 ${dup.cnt}개 — career_tree_job_links 중복 제거 필요`);
      }
    } catch {
      // wrangler 미연결 또는 오류 시 조용히 스킵
    }
  }

  // ── 6. changeSummary 존재 ──
  if (!changeSummary || changeSummary.length < 10) {
    warnings.push(`[기타] changeSummary가 없거나 너무 짧음`);
  }

  // ── 7. detailWlb 등급 띄어쓰기 검사 ──
  if (fields.detailWlb) {
    const wlbGrade = fields.detailWlb?.wlb;
    const socialGrade = fields.detailWlb?.social;
    const stuckForms = ['보통이상', '보통이하', '다소높음', '다소낮음'];
    if (wlbGrade && stuckForms.includes(wlbGrade)) {
      errors.push(`[detailWlb.wlb] 붙여쓰기 금지: "${wlbGrade}" → "보통 이상" 또는 "보통 이하" 형식 사용`);
    }
    if (socialGrade && stuckForms.includes(socialGrade)) {
      errors.push(`[detailWlb.social] 붙여쓰기 금지: "${socialGrade}" → "보통 이상" 또는 "보통 이하" 형식 사용`);
    }
  }

  // ── 7. way 타입 검사 (배열이면 즉시 500 에러 — 최상위 치명 오류) ──

  if (fields.way !== undefined && fields.way !== null) {
    if (Array.isArray(fields.way)) {
      errors.push(`[치명] way가 배열(Array)임 — 반드시 string이어야 함. 배포 시 500 에러 발생!`);
    } else if (typeof fields.way !== 'string') {
      errors.push(`[치명] way 타입이 "${typeof fields.way}" — string이어야 함`);
    }
  }

  // ── 8. 잘린 문장 검사 ──

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
    /[가-힣]{1}에$/, // M4: audit과 동기화 — "~에" 로 끝나는 잘린 문장
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

  const sentenceFields = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia',
    'summary', 'overviewAbilities.technKnow',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail'];

  for (const fieldPath of sentenceFields) {
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

  // ── 9a. overviewSalary 전체 수정 금지 ──
  // 스킬은 임금 데이터를 절대 건드리지 않는다.
  // wage(바 차트), wageSource(바 차트 툴팁), sal(임금 서술 텍스트) 모두 포함.

  if (fields.overviewSalary !== undefined) {
    errors.push('[sal-수정금지] overviewSalary 필드 수정 금지 — sal/wage/wageSource 모두 스킬에서 건드리지 않음. 임금 데이터는 API·기존 데이터 그대로 유지');
  }
  if (sources['overviewSalary.sal']) {
    errors.push('[sal-readonly] sources["overviewSalary.sal"] must not be sent by job-data-enhance. Salary annotations and salary sources are read-only here.');
  }

  // ── 9b. youtubeLinks 개수 검증 + 무언 스킵 금지 (2026-04-15 강화) ──

  // youtubeLinks가 draft에 포함된 경우에만 검사 (미포함 시 이번 저장에서 변경 없음 → 검사 생략)
  if ('youtubeLinks' in fields) {
    const ytLinks = Array.isArray(fields.youtubeLinks)
      ? fields.youtubeLinks
      : (fields.youtubeLinks === null || fields.youtubeLinks === undefined ? [] :
         (typeof fields.youtubeLinks === 'string' ? JSON.parse(fields.youtubeLinks) : []));

    if (ytLinks.length === 0) {
      // 빈 배열 제출 시: _youtubeSearchNote 필수 (무언 스킵 금지)
      if (!fields._youtubeSearchNote || typeof fields._youtubeSearchNote !== 'string' || fields._youtubeSearchNote.trim().length < 10) {
        errors.push('[YouTube-증거없음] youtubeLinks를 빈 배열로 제출할 때는 _youtubeSearchNote 필드 필수. 형식: "KEIS \'직업명\' 0개, \'직업명 현직자인터뷰\' 0개 (날짜)". 검색 없이 빈 배열 저장 금지.');
      } else {
        // ── 룰 B: _youtubeSearchNote 탐색 깊이 검사 ──────────────────────────────
        // 탐색어 ≥6개 OR 4개 카테고리 중 ≥3개 커버해야 통과.
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

  // ── 9c. careerTree null 제출 시 _careerTreeNote 필수 (H5) ──
  // careerTree가 명시적으로 null인 경우 (적합 인물 없음 판단) → 탐색 근거 필수
  if ('careerTree' in data && (data.careerTree === null)) {
    if (!data._careerTreeNote || typeof data._careerTreeNote !== 'string' || data._careerTreeNote.trim().length < 10) {
      errors.push('[careerTree-증거없음] careerTree를 null로 제출할 때는 _careerTreeNote 필드 필수. 형식: "직업명 관련 한국인 공인 탐색: 인물A(이유), 인물B(이유). 적합 인물 없음." 탐색 없이 null 저장 금지.');
    } else {
      // ── 룰 C: _careerTreeNote 탐색 깊이 검사 ────────────────────────────────
      // 후보 인물 ≥5명 OR 5개 카테고리 중 ≥3개 커버해야 통과.
      const ctNoteAnalysis = analyzeCareerTreeNote(data._careerTreeNote);
      if (!ctNoteAnalysis.pass) {
        errors.push(
          `[CareerTreeNote얕음] _careerTreeNote 탐색이 충분하지 않음 ` +
          `(후보 인물 ${ctNoteAnalysis.candidateCount}명 / 카테고리 ${ctNoteAnalysis.categoryCount}/5개 커버). ` +
          `조건: 후보 ≥5명(이름(이유) 형식) OR 카테고리 ≥3개(재벌·대기업/컨설팅/공공·정부/학계·연구/스타트업·CxO)`
        );
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
      // 문자열 배열 금지: {url, title} 객체여야 함
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
      // title 인코딩 깨짐 감지
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

    // ── [출처URL복수] source text 내 복수 URL 탐지 — FAIL ──────────────────────
    // source text에 URL을 2개 이상 인라인으로 박으면 구조적 위반 (한 source = 한 URL 원칙).
    // ── [출처라벨병합] source 라벨에 여러 기관 병합 표기 탐지 — INFO ──────────
    // "기관A 및 기관B" 형태. URL이 언급된 기관 모두를 실제 커버하는지는 사람 판단 영역.
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
    const SEARCH_RESULT_PATTERNS = [
      /work24\.go\.kr\/wk\/a\/b\/\d+\//,
      /worker\.co\.kr\/job\/list/,
      /work\.go\.kr\/.*[?&](query|searchKeyword|keyword)=/,
      /career\.go\.kr\/.*[?&](query|keyword|searchKeyword)=/,
      // saramin/jobkorea 카테고리 검색 URL (cat_kewd 등 분류 파라미터 포함)
      /saramin\.co\.kr\/.*[?&]cat_kewd=/,
      /jobkorea\.co\.kr\/.*[?&](cat_cd|cat_kewd|occupation)=/,
    ];
    for (const src of srcVal) {
      if (src && src.url) {
        for (const pat of SEARCH_RESULT_PATTERNS) {
          if (pat.test(src.url)) {
            errors.push(`[검색결과URL] sources["${sourceKey}"]에 동적 검색결과 페이지 URL: "${src.url}" — 기관 메인 또는 구체적 직업 상세 페이지로 교체 필요`);
            break;
          }
        }
      }
    }
  }

  for (const [sourceKey, srcVal] of Object.entries(sources)) {
    if (!Array.isArray(srcVal)) {
      errors.push(`[출처포맷] sources["${sourceKey}"]가 배열이 아님 — Array여야 함`);
      continue;
    }

    for (let i = 0; i < srcVal.length; i++) {
      const src = srcVal[i];
      if (typeof src === 'string') {
        // 구형 string 포맷이면 경고
        warnings.push(`[출처포맷] sources["${sourceKey}"][${i}]: string 형식 — {text, url} 객체로 변환 필요`);
        continue;
      }
      if (typeof src !== 'object' || src === null) {
        errors.push(`[출처포맷] sources["${sourceKey}"][${i}]: null 또는 비객체`);
        continue;
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
        // text에 URL이 포함된 경우 (이미 Gate 4에서 잡히지만 이중 확인)
        if (src.text && src.text.includes('http')) {
          errors.push(`[출처포맷] sources["${sourceKey}"][${i}].text에 URL 포함 — text와 url 필드를 분리해야 함`);
        }
      } else if (!src.text) {
        warnings.push(`[출처포맷] sources["${sourceKey}"][${i}]: text와 url 모두 없음`);
      }
    }
  }

  // ── 10-C. 출처 정책 강화 (2026-04-29, deep audit 발견 사고 차단) ────────────
  //
  // sources.cjs의 4 패턴(rawURL/bracketPrefix/mojibake/sourcesNULL) 위에 추가:
  //   E) listPage URL — 직업 specific 페이지 아닌 인덱스/카테고리 (FAIL)
  //   F) [originDomain] — career.go.kr/work.go.kr/wagework.go.kr 등 origin 1건이라도 (FAIL)
  //      ⚠️ 격상 (2026-04-29) — 기존 [selfCiteOnly] (외부 보충 1+ 통과) → 1건이라도 FAIL
  //   F') self-domain (careerwiki.org/.kr) — 자기 사이트 인용 절대 금지 (FAIL)
  //   H) orphanSrc — 산문 필드 _sources 등록 idx N이 본문에 [N] 미사용 (WARN)
  //   I) brokenRef — 산문 필드 본문 [N]이 _sources[fieldKey] 길이 초과 (FAIL)
  //
  // 본문 [N]은 *field-local* 번호이며 detailTemplateUtils.applyInlineFootnotes의
  // footnoteMap이 글로벌 번호로 변환한다. 검사도 field-local 기준.
  //
  // ⚠️ origin 검사 컨텍스트: _sources 안에서만. sidebarCerts/sidebarOrgs 같은
  // 구조적 필드 자체에 .go.kr URL이 들어가는 케이스(예: q-net.or.kr 자격증 페이지)는
  // _sources가 아니므로 이 룰의 영향 없음.
  {
    // 평탄화된 source 배열 — 전체 host 분류용
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

    // F) [originDomain] FAIL — 격상 (2026-04-29 사용자 의도)
    // career.go.kr/work.go.kr/work24.go.kr/wagework.go.kr/job.go.kr/.go.kr+직업키워드
    // 1건이라도 _sources에 있으면 즉시 FAIL. 외부 보충 여부 무관.
    if (hostInfo.originHostCount > 0) {
      const originSet = [...new Set(hostInfo.originUrls.map(u => {
        try { return new URL(u).host.toLowerCase(); } catch { return ''; }
      }).filter(Boolean))];
      errors.push(
        `[originDomain] _sources에 정부 산하 직업정보 origin 도메인 ${hostInfo.originHostCount}건 발견 (${originSet.join(', ')}) — ` +
        `career.go.kr / work.go.kr / work24.go.kr / wagework.go.kr / job.go.kr 및 .go.kr + 직업정보 path는 ` +
        `CareerWiki가 직접 가져오는 데이터의 원본(origin)이므로 출처로 절대 사용 금지. ` +
        `외부 1차 출처(협회·학회·KOSIS·전문 미디어·학술논문·정부 부처 정책 페이지 등)로 교체 필수`
      );
    }

    // E·H·I) 필드별 검사
    const BODY_FIELDS_FOR_FOOTNOTE = [
      'way', 'trivia', 'overviewProspect.main', 'overviewSalary.sal',
      'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow',
      'summary', 'overviewWork.main',
    ];

    for (const [fieldKey, srcArr] of Object.entries(sources)) {
      if (!Array.isArray(srcArr)) continue;

      // E) listPage URL 차단
      for (let i = 0; i < srcArr.length; i++) {
        const src = srcArr[i];
        if (src && src.url && detectListPageUrl(src.url)) {
          errors.push(
            `[listPageURL] sources["${fieldKey}"][${i}].url 이 인덱스/카테고리 페이지: "${src.url}" — ` +
            `직업 식별자(seq/code/jobsCd 등)가 포함된 구체적 직업 페이지로 교체 필요`
          );
        }
      }

      // H·I) 산문 필드만 — orphan/broken 검사
      if (BODY_FIELDS_FOR_FOOTNOTE.includes(fieldKey)) {
        const body = getNestedField(fields, fieldKey);
        if (typeof body === 'string') {
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
        }
      }
    }
  }

  // ── 10-B. 인라인 도메인 표기 감지 (서술형 필드) ──
  // 텍스트 본문에 (도메인) 패턴 금지 — 출처는 [N]+_sources로만 표기
  {
    const INLINE_DOM = /\([a-z0-9.-]+\.(co\.kr|go\.kr|re\.kr|or\.kr|com|net)\)/i;
    const allTextFields = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia',
      'summary', 'overviewAbilities.technKnow', 'detailWlb.wlbDetail', 'detailWlb.socialDetail'];
    for (const fp of allTextFields) {
      const val = fp.includes('.') ? fp.split('.').reduce((o,k)=>o?.[k], fields) : fields[fp];
      if (val && typeof val === 'string' && INLINE_DOM.test(val)) {
        errors.push(`[인라인도메인] ${fp}에 괄호 안 도메인 표기 — 텍스트에서 제거 필요. 출처는 [N]+_sources로만: "${val.substring(0, 60)}..."`);
      }
    }
  }

  // ── 11. 무출처 문장 감지 ──
  //
  // 2-티어 검사:
  //   Tier A (FULL):    [N] 마커 없음 → WARN  +  마지막 [N] 이후 문장 → WARN
  //   Tier B (TRAIL):   마지막 [N] 이후 문장만 → WARN  (마커 없음은 허용)
  //
  // ※ detailReady.* (curriculum/recruit/training/pathExplore)는 대상 제외
  //    → "== 제목 [N] ==" 헤딩 각주 체계 사용 — 산문 [N] 패턴과 다름
  //
  // ⚠️ 무출처 문장 발견 시 처리 절차 (바로 제거 금지):
  //   1. 바로 앞 [N] 출처 URL을 WebFetch로 방문 → 해당 내용이 있으면 [N]을 문장 끝으로 이동
  //   2. 같은 출처가 아니면 → merged_profile_json 원문·공식 사이트에서 다른 출처 탐색
  //   3. 새 출처 확인되면 → [N+1] 추가 후 _sources 등록
  //   4. 어디서도 확인 불가일 때만 → 제거

  // Tier A: 항상 출처 표기 필수 (통계·사실 중심 필드)
  const FULL_CHECK_FIELDS = [
    'way',
    'overviewSalary.sal',
    'overviewProspect.main',
    'trivia',
  ];

  // Tier B: [N]이 하나라도 있으면 trailing만 검사 (일반 서술도 허용)
  const TRAILING_CHECK_FIELDS = [
    'summary',
    'overviewAbilities.technKnow',
    'detailWlb.wlbDetail',
    'detailWlb.socialDetail',
  ];

  function checkTrailingSentence(text, fieldPath) {
    const allMarkers = [...text.matchAll(/\[\d+\]/g)];
    if (allMarkers.length === 0) return; // Tier B는 마커 없으면 패스
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

  for (const fieldPath of FULL_CHECK_FIELDS) {
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

  for (const fieldPath of TRAILING_CHECK_FIELDS) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;
    const trimmed = text.trim();
    if (trimmed.length < 10) continue;
    checkTrailingSentence(trimmed, fieldPath);
  }

  // ── 12. detailReady 배열 항목 타입 검사 ──
  // curriculum/training 항목은 반드시 plain string
  // {text:"..."} 객체이면 applyInlineFootnotes가 적용되지 않아 각주 렌더링이 깨짐

  if (fields.detailReady) {
    const dr12 = typeof fields.detailReady === 'string' ? JSON.parse(fields.detailReady) : fields.detailReady;
    for (const sub of ['curriculum', 'training']) {
      if (dr12[sub] && Array.isArray(dr12[sub])) {
        for (let i = 0; i < dr12[sub].length; i++) {
          const item = dr12[sub][i];
          if (item !== null && typeof item === 'object') {
            errors.push(`[치명] detailReady.${sub}[${i}]가 객체(object)임 — 반드시 plain string이어야 함. 예: "경영학과 이수" ✅ / {"text":"경영학과 이수"} ❌ (현재: ${JSON.stringify(item).substring(0, 60)})`);
          }
        }
      }
    }
    // recruit: {text,url} 객체 허용. text 없는 객체=FAIL. url 없는 {text}=WARN(plain string 권장)
    if (dr12.recruit && Array.isArray(dr12.recruit)) {
      for (let i = 0; i < dr12.recruit.length; i++) {
        const item = dr12.recruit[i];
        if (item !== null && typeof item === 'object') {
          if (!item.text) {
            errors.push(`[치명] detailReady.recruit[${i}]가 text 없는 객체 — {text:"채용경로명", url:"..."} 또는 plain string이어야 함 (현재: ${JSON.stringify(item).substring(0, 60)})`);
          } else if (!item.url) {
            warnings.push(`[WARN] Rule 12: detailReady.recruit[${i}]가 url 없는 {text} 객체 — URL 없으면 plain string 권장`);
          }
        }
      }
    }
  }

  return { errors, warnings };
}

// ── 유틸리티 ──

function getNestedField(obj, path) {
  // "detailWlb.wlbDetail" → obj.detailWlb?.wlbDetail 또는 obj["detailWlb.wlbDetail"]
  if (obj[path] !== undefined) return obj[path];
  const parts = path.split('.');
  let current = obj;
  for (const part of parts) {
    if (current == null) return undefined;
    current = current[part];
  }
  return current;
}

function getSourceKey(fieldPath) {
  // 소스 키 매핑
  const aliases = {
    'way': 'way',
    'overviewSalary.sal': 'overviewSalary.sal',
    'overviewProspect.main': 'overviewProspect.main',
    'trivia': 'trivia',
    'summary': 'summary',
    'detailWlb.wlbDetail': 'detailWlb.wlbDetail',
    'detailWlb.socialDetail': 'detailWlb.socialDetail',
    'overviewAbilities.technKnow': 'overviewAbilities.technKnow',
  };
  return aliases[fieldPath] || fieldPath;
}

// ── 메인 실행 ──

async function main() {
  let input;

  if (process.argv[2]) {
    input = fs.readFileSync(process.argv[2], 'utf8');
  } else if (!process.stdin.isTTY) {
    input = fs.readFileSync(0, 'utf8');
  } else {
    console.error('Usage: node scripts/validate-job-edit.js <json-file>');
    console.error('   or: echo \'{"fields":...}\' | node scripts/validate-job-edit.js');
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

  const { errors, warnings } = await validateAsync(data);

  console.log(`\n=== 검증 결과: ${data.jobName || 'Unknown'} ===\n`);

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
