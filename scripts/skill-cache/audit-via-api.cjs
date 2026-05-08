#!/usr/bin/env node
// scripts/skill-cache/audit-via-api.cjs
// audit-sources-deep의 우회 버전 — wrangler D1 인증이 없는 worktree 환경에서
// prod API (/api/job/{slug}/edit-data)로 데이터를 받아 같은 detect 함수를 적용한다.
//
// 사용:
//   node scripts/skill-cache/audit-via-api.cjs slug1 slug2 ...
//   node scripts/skill-cache/audit-via-api.cjs --all  (전체 마커 보유 직업 — page_revisions 통해)
//   node scripts/skill-cache/audit-via-api.cjs slug1 --exclude-sal
//
// --exclude-sal: sal-protection 정책 영역(`overviewSalary.sal`)을 audit 범위에서 제외.
//   enhance 사이클이 sal 영역을 절대 손대지 않으므로 (Sal Protection Strict + [sal-readonly]),
//   audit 14 룰과 sal-readonly 정책 충돌 회피용. default OFF (기존 동작 보존).

'use strict';

const path = require('path');
const REPO_ROOT = path.resolve(__dirname, '..', '..');
const {
  detectMojibake,
  detectListPageUrl,
  classifySourceHosts,
  detectOriginDomain,
  detectOrphanSourceIdx,
  detectBrokenSourceRef,
  detectSourceIdxGap,
  detectBrokenSourceRefArrayItems,
  detectMarkerOrderViolation,
  detectSidebarSources,
  detectRootDomainOnly,
  calcWikiQuota,
  SELF_DOMAINS,
  PROSE_BODY_FIELDS,
} = require(path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'));

// PROSE_BODY_FIELDS는 detect-patterns.cjs export — validate-job-edit.cjs와 공유 (proseBodyOrphan 룰 정합성).
const BODY_FIELDS = PROSE_BODY_FIELDS;

const SAL_PROTECTED_FIELDS = ['overviewSalary.sal'];

function getNested(obj, p) {
  if (!obj) return undefined;
  if (obj[p] !== undefined) return obj[p];
  let cur = obj;
  for (const part of p.split('.')) { if (cur == null) return undefined; cur = cur[part]; }
  return cur;
}

// 산문 본문 raw string 조회 — _proseRaw 우선 (PR 1, 2026-05-08), fallback to getNested.
//
// 배경: /api/job/:id/edit-data 응답에서 trivia / overviewWork.main 은 array 형식으로
// split되며, way / detailWlb.wlbDetail / detailWlb.socialDetail 은 응답에 미노출.
// 이로 인해 산문 영역 audit 룰 (orphanSrc / brokenRef / dup / orderViolation)이 silent
// skip 발생 → 9 BODY_FIELDS 중 4개만 실제 검사. PR 1 (a43ac7)에서 _proseRaw namespace
// 추가하여 9 필드 raw string 노출. 본 함수는 _proseRaw 우선 사용 후 getNested fallback.
//
// @param {object} data - /edit-data 응답의 data 객체
// @param {string} fieldKey - 'way', 'trivia', 'detailWlb.wlbDetail' 등
// @returns {string} raw body string ('' if not present or non-string)
function getProseBody(data, fieldKey) {
  const proseRaw = data && data._proseRaw;
  if (proseRaw && typeof proseRaw === 'object' && typeof proseRaw[fieldKey] === 'string') {
    return proseRaw[fieldKey];
  }
  // fallback — _proseRaw 미배포 환경 (옛 prod 응답 호환)
  const v = getNested(data, fieldKey);
  return typeof v === 'string' ? v : '';
}

async function fetchJob(slug) {
  const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
  const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
  if (r.status !== 200) return { error: `HTTP ${r.status}` };
  const j = await r.json();
  if (!j.success) return { error: j.error || 'API failure' };
  return { data: j.data };
}

function analyze(slug, data, opts = {}) {
  const excludeSal = !!opts.excludeSal;
  const sources = data._sources || {};
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
    rootURL: [],          // 2026-05-07 룰 13
    wikiQuota: null,      // 2026-05-07 룰 14
  };

  const flatSources = [];

  let hasBodyMarker = false;
  for (const f of BODY_FIELDS) {
    if (excludeSal && SAL_PROTECTED_FIELDS.includes(f)) continue;
    const v = getProseBody(data, f);
    if (typeof v === 'string' && /\[\d+\]/.test(v)) { hasBodyMarker = true; break; }
  }
  if (!sources && hasBodyMarker) findings.sourcesNull = true;

  for (const [fieldKey, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr)) continue;
    if (excludeSal && SAL_PROTECTED_FIELDS.includes(fieldKey)) continue;
    for (let i = 0; i < srcArr.length; i++) {
      const src = srcArr[i];
      if (!src || typeof src !== 'object') continue;
      flatSources.push(src);
      const id = typeof src.id === 'number' ? src.id : (i + 1);

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
            findings.originDomain.push({ field: fieldKey, url: src.url, host });
            findings.selfCite.push({ field: fieldKey, url: src.url, host, kind: 'origin' });
          }
        } catch {}
      }
    }

    // body 산문 필드 — _proseRaw 우선 사용 (PR 1, 2026-05-08).
    // 기존 getNested는 way / wlbDetail / socialDetail 미노출 + trivia·overviewWork.main array 형식이라 silent skip 발생.
    // _proseRaw 도입 후 9 BODY_FIELDS 모두 raw string으로 검사 (proseBodyOrphan 룰 활성화).
    // typeof === 'string' 체크는 empty string 케이스도 포함 — 빈 본문 + _sources 등록 시 orphan으로 검출.
    if (BODY_FIELDS.includes(fieldKey)) {
      const body = getProseBody(data, fieldKey);
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

  // 룰 J: detailReady 배열 brokenRef
  const dr = data.detailReady || {};
  for (const sub of ['curriculum', 'recruit', 'training']) {
    const items = dr[sub];
    if (!Array.isArray(items) || items.length === 0) continue;
    const fieldKey = `detailReady.${sub}`;
    const srcArr = sources[fieldKey];
    const broken = detectBrokenSourceRefArrayItems(items, srcArr);
    if (broken.length > 0) {
      findings.arrayBrokenRef.push({
        field: fieldKey,
        broken,
        srcLen: Array.isArray(srcArr) ? srcArr.length : 0,
      });
    }
  }

  // 룰 K: 본문 [N] 첫 등장 sequential — _proseRaw 우선 사용 (PR 1)
  const allBodyParts = [];
  for (const f of BODY_FIELDS) {
    const v = getProseBody(data, f);
    if (typeof v === 'string' && v.length > 0) allBodyParts.push(v);
  }
  for (const sub of ['curriculum', 'recruit', 'training']) {
    const items = dr[sub];
    if (Array.isArray(items)) {
      for (const it of items) {
        const t = typeof it === 'string' ? it : (it && (it.text || it.title)) || '';
        if (t) allBodyParts.push(t);
      }
    }
  }
  findings.orderViolation = detectMarkerOrderViolation(allBodyParts.join('\n'));

  // 룰 L: sidebar 영역 _sources 등록 금지
  findings.sidebarSources = detectSidebarSources(sources);

  // 룰 14 (2026-05-07): Wikipedia 점유율 ≤ 30%
  if (excludeSal) {
    const filtered = {};
    for (const [k, v] of Object.entries(sources)) {
      if (SAL_PROTECTED_FIELDS.includes(k)) continue;
      filtered[k] = v;
    }
    findings.wikiQuota = calcWikiQuota(filtered);
  } else {
    findings.wikiQuota = calcWikiQuota(sources);
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
    (j.wikiQuota && j.wikiQuota.level === 'FAIL')
  );
}

(async () => {
  const argv = process.argv.slice(2);
  const slugs = argv.filter(a => !a.startsWith('--'));
  const excludeSal = argv.includes('--exclude-sal');
  if (slugs.length === 0) {
    console.error('사용: node scripts/skill-cache/audit-via-api.cjs slug1 slug2 ... [--exclude-sal]');
    process.exit(1);
  }
  if (excludeSal) {
    console.log(`[audit-via-api] --exclude-sal: sal-protection 영역(${SAL_PROTECTED_FIELDS.join(', ')}) 검증 skip`);
  }

  const results = [];
  for (const slug of slugs) {
    const r = await fetchJob(slug);
    if (r.error) { console.log(`ERR  ${slug.padEnd(30)} ${r.error}`); continue; }
    const f = analyze(slug, r.data, { excludeSal });
    results.push(f);
    const status = isFail(f) ? 'FAIL' : 'OK  ';
    const flags = [];
    if (f.idxGap) flags.push('idxGap');
    if (f.arrayBrokenRef.length) flags.push(`arrayBrokenRef(${f.arrayBrokenRef.length})`);
    if (f.brokenRef.length) flags.push(`brokenRef(${f.brokenRef.length})`);
    if (f.orderViolation) flags.push('orderViolation');
    if (f.sidebarSources && f.sidebarSources.length) flags.push(`sidebarSources(${f.sidebarSources.length})`);
    if (f.rootURL && f.rootURL.length) flags.push(`rootURL(${f.rootURL.length})`);
    if (f.wikiQuota && f.wikiQuota.level === 'FAIL') flags.push(`wikiQuota(${(f.wikiQuota.ratio*100).toFixed(0)}%)`);
    else if (f.wikiQuota && f.wikiQuota.level === 'WARN') flags.push(`wikiQuotaWARN(${(f.wikiQuota.ratio*100).toFixed(0)}%)`);
    if (f.orphanSrc.length) flags.push(`orphan(${f.orphanSrc.length})`);
    if (f.originDomain.length) flags.push(`origin(${f.originDomain.length})`);
    if (f.dupMarkers.length) flags.push(`dup(${f.dupMarkers.length})`);
    if (f.mojibake.length) flags.push(`mojibake(${f.mojibake.length})`);
    console.log(`${status} ${slug.padEnd(30)} ${flags.join(', ') || 'clean'}`);
    f.arrayBrokenRef.forEach(b =>
      console.log(`         ${b.field}: broken=[${b.broken.join(',')}] srcLen=${b.srcLen}`));
    f.brokenRef.forEach(b => console.log(`         ${b.field}#${b.idx} broken`));
    if (f.idxGap) {
      const i = f.idxGap.actual.findIndex((id, k) => id !== f.idxGap.expected[k]);
      console.log(`         idxGap @${i}: expected ${f.idxGap.expected[i]}, got ${f.idxGap.actual[i]}`);
    }
    if (f.orderViolation) {
      console.log(`         orderViolation @${f.orderViolation.breakAt}: expected ${f.orderViolation.breakAt + 1}, got ${f.orderViolation.firstAppear[f.orderViolation.breakAt]}`);
    }
    (f.sidebarSources || []).forEach(h =>
      console.log(`         sidebarSources ${h.field}: count=${h.count}, ids=[${h.ids.join(',')}] (orphan — sidebar 본문 [N] 마커 없음)`));
  }

  const failCount = results.filter(isFail).length;
  console.log(`\n=== Summary: ${failCount}/${results.length} FAIL ===`);
})();
