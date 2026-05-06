#!/usr/bin/env node
// scripts/skill-cache/audit-via-api.cjs
// audit-sources-deep의 우회 버전 — wrangler D1 인증이 없는 worktree 환경에서
// prod API (/api/job/{slug}/edit-data)로 데이터를 받아 같은 detect 함수를 적용한다.
//
// 사용:
//   node scripts/skill-cache/audit-via-api.cjs slug1 slug2 ...
//   node scripts/skill-cache/audit-via-api.cjs --all  (전체 마커 보유 직업 — page_revisions 통해)

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
  SELF_DOMAINS,
} = require(path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'));

const BODY_FIELDS = [
  'way', 'trivia', 'overviewProspect.main', 'overviewSalary.sal',
  'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow',
  'summary', 'overviewWork.main',
];

function getNested(obj, p) {
  if (!obj) return undefined;
  if (obj[p] !== undefined) return obj[p];
  let cur = obj;
  for (const part of p.split('.')) { if (cur == null) return undefined; cur = cur[part]; }
  return cur;
}

async function fetchJob(slug) {
  const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
  const r = await fetch(url, { headers: { 'Cache-Control': 'no-cache' } });
  if (r.status !== 200) return { error: `HTTP ${r.status}` };
  const j = await r.json();
  if (!j.success) return { error: j.error || 'API failure' };
  return { data: j.data };
}

function analyze(slug, data) {
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
  };

  const flatSources = [];

  let hasBodyMarker = false;
  for (const f of BODY_FIELDS) {
    const v = getNested(data, f);
    if (typeof v === 'string' && /\[\d+\]/.test(v)) { hasBodyMarker = true; break; }
  }
  if (!sources && hasBodyMarker) findings.sourcesNull = true;

  for (const [fieldKey, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr)) continue;
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

    // body 산문 필드
    if (BODY_FIELDS.includes(fieldKey)) {
      const body = getNested(data, fieldKey);
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

  // 룰 K: 본문 [N] 첫 등장 sequential
  const allBodyParts = [];
  for (const f of BODY_FIELDS) {
    const v = getNested(data, f);
    if (typeof v === 'string') allBodyParts.push(v);
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

  return findings;
}

function isFail(j) {
  return (
    j.dupMarkers.length > 0 || j.orphanSrc.length > 0 ||
    j.originDomain.length > 0 || j.listPage.length > 0 || j.rawURL.length > 0 ||
    j.brokenRef.length > 0 || j.bracketPrefix.length > 0 || j.mojibake.length > 0 ||
    j.sourcesNull || j.idxGap || j.arrayBrokenRef.length > 0 || j.orderViolation
  );
}

(async () => {
  const slugs = process.argv.slice(2).filter(a => !a.startsWith('--'));
  if (slugs.length === 0) {
    console.error('사용: node scripts/skill-cache/audit-via-api.cjs slug1 slug2 ...');
    process.exit(1);
  }

  const results = [];
  for (const slug of slugs) {
    const r = await fetchJob(slug);
    if (r.error) { console.log(`ERR  ${slug.padEnd(30)} ${r.error}`); continue; }
    const f = analyze(slug, r.data);
    results.push(f);
    const status = isFail(f) ? 'FAIL' : 'OK  ';
    const flags = [];
    if (f.idxGap) flags.push('idxGap');
    if (f.arrayBrokenRef.length) flags.push(`arrayBrokenRef(${f.arrayBrokenRef.length})`);
    if (f.brokenRef.length) flags.push(`brokenRef(${f.brokenRef.length})`);
    if (f.orderViolation) flags.push('orderViolation');
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
  }

  const failCount = results.filter(isFail).length;
  console.log(`\n=== Summary: ${failCount}/${results.length} FAIL ===`);
})();
