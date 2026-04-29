#!/usr/bin/env node
// scripts/skill-cache/audit-sources-deep.cjs
// _sources 9 패턴 deep audit — audit-sources.cjs(4 패턴) 확장.
//
// 사용:
//   node scripts/skill-cache/audit-sources-deep.cjs                       (전체 sweep + summary)
//   node scripts/skill-cache/audit-sources-deep.cjs --json                (JSON 요약)
//   node scripts/skill-cache/audit-sources-deep.cjs --jsonl               (per-job JSON lines)
//   node scripts/skill-cache/audit-sources-deep.cjs --slug=수의사보조원   (단일 직업)
//   node scripts/skill-cache/audit-sources-deep.cjs --markers-only        (마커 보유 풀만)
//   node scripts/skill-cache/audit-sources-deep.cjs --max-urls=10         (URL 수 ≤ 10 풀만)
//   node scripts/skill-cache/audit-sources-deep.cjs --out=data/audit-sources-deep.json
//
// 패턴:
//   1) dup body markers — 한 필드 안에 같은 [N] 2회+
//   2) orphanSrc        — _sources idx 등록됐는데 본문 [N] 없음
//   3) selfCite         — _sources URL이 career.go.kr / work.go.kr / careerwiki.org 등 자기 데이터 origin
//   4) selfCiteOnly     — 외부 출처 0개 (origin/self만 있음)
//   5) listPage         — _sources URL이 인덱스/카테고리 페이지 (seq/code 없는 인덱스)
//   6) rawURL           — _sources[i].text가 raw URL로 시작
//   7) brokenRef        — 본문 [N] 있는데 _sources에 매핑 없음
//   8) bracketPrefix    — _sources[i].text가 [N] 마커로 시작
//   9) mojibake         — 깨진 유니코드(아랍·키릴·라틴확장 등)

'use strict';

const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const {
  detectMojibake,
  detectListPageUrl,
  classifySourceHosts,
  detectOrphanSourceIdx,
  detectBrokenSourceRef,
  detectSourceIdxGap,
  SELF_DOMAINS,
  ORIGIN_DATA_DOMAINS,
} = require(path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs'));

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

// 본문이 있는(검사 대상) 산문 필드.
// detailReady.* 는 배열 필드라 별도 처리.
const BODY_FIELDS = [
  'way',
  'trivia',
  'overviewProspect.main',
  'overviewSalary.sal',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'overviewAbilities.technKnow',
  'summary',
];

const ARRAY_FIELDS = [
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
];

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

function getNested(obj, dottedPath) {
  if (!obj) return undefined;
  if (obj[dottedPath] !== undefined) return obj[dottedPath];
  let cur = obj;
  for (const part of dottedPath.split('.')) {
    if (cur == null) return undefined;
    cur = cur[part];
  }
  return cur;
}

function analyzeJob(slug, ucjStr) {
  const findings = {
    slug,
    dupMarkers: [],       // [{field, marker, count}]
    orphanSrc: [],        // [{field, idx}]
    selfCite: [],         // [{field, url, host, kind:'origin'|'self'}]
    selfCiteOnly: false,  // boolean (전체 _sources에 외부 host 0)
    listPage: [],         // [{field, url}]
    rawURL: [],           // [{field, idx, text}]
    brokenRef: [],        // [{field, idx}]
    bracketPrefix: [],    // [{field, idx, text}]
    mojibake: [],         // [{location, sample}]
    sourcesNull: false,   // _sources 자체가 NULL이지만 본문에 [N] 있음
    idxGap: null,         // 글로벌 id 연속성 (gap이면 {expected, actual})
    totalUrls: 0,
    uniqueHosts: 0,
    externalHostCount: 0,
  };

  if (!ucjStr) return findings;
  let ucj;
  try {
    ucj = typeof ucjStr === 'string' ? JSON.parse(ucjStr) : ucjStr;
  } catch {
    return findings;
  }

  const sources = ucj._sources || null;

  // sources NULL + body marker 검사
  let hasBodyMarker = false;
  for (const f of BODY_FIELDS) {
    const v = getNested(ucj, f);
    if (typeof v === 'string' && /\[\d+\]/.test(v)) { hasBodyMarker = true; break; }
  }
  if (!sources && hasBodyMarker) findings.sourcesNull = true;

  // mojibake 전역 (UCJ 문자열 raw 검사)
  if (detectMojibake(ucjStr)) {
    findings.mojibake.push({ location: 'user_contributed_json (raw)', sample: extractMojibakeSample(ucjStr) });
  }

  // sources 미존재 → 다음 검사 스킵
  if (!sources || typeof sources !== 'object') {
    return finalizeMetrics(findings);
  }

  const flatSources = [];

  for (const [fieldKey, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr)) continue;
    for (let i = 0; i < srcArr.length; i++) {
      const src = srcArr[i];
      if (!src || typeof src !== 'object') continue;
      flatSources.push(src);

      const id = typeof src.id === 'number' ? src.id : (i + 1);

      // rawURL — text가 raw URL로 시작
      if (typeof src.text === 'string' && /^\s*https?:\/\//.test(src.text)) {
        findings.rawURL.push({ field: fieldKey, idx: id, text: src.text.slice(0, 80) });
      }
      // bracketPrefix — text가 [N] 마커로 시작
      if (typeof src.text === 'string' && /^\s*\[\d+\]/.test(src.text)) {
        findings.bracketPrefix.push({ field: fieldKey, idx: id, text: src.text.slice(0, 80) });
      }
      // mojibake (text 단위)
      if (typeof src.text === 'string' && detectMojibake(src.text)) {
        findings.mojibake.push({ location: `_sources.${fieldKey}[${id}].text`, sample: src.text.slice(0, 60) });
      }

      // listPage URL
      if (src.url && detectListPageUrl(src.url)) {
        findings.listPage.push({ field: fieldKey, url: src.url });
      }

      // selfCite (origin or self host)
      if (src.url) {
        try {
          const host = new URL(src.url).host.toLowerCase();
          if (SELF_DOMAINS.includes(host)) {
            findings.selfCite.push({ field: fieldKey, url: src.url, host, kind: 'self' });
          } else if (ORIGIN_DATA_DOMAINS.includes(host)) {
            findings.selfCite.push({ field: fieldKey, url: src.url, host, kind: 'origin' });
          }
        } catch {}
      }
    }

    // orphan & broken — 산문 필드만 (배열 필드는 항목별 검사 별도 정책)
    if (BODY_FIELDS.includes(fieldKey)) {
      const body = getNested(ucj, fieldKey);
      if (typeof body === 'string') {
        const orphans = detectOrphanSourceIdx(body, srcArr);
        for (const idx of orphans) findings.orphanSrc.push({ field: fieldKey, idx });
        const broken = detectBrokenSourceRef(body, srcArr);
        for (const idx of broken) findings.brokenRef.push({ field: fieldKey, idx });

        // dup body markers (한 필드 내 같은 [N] 2회+)
        const matches = body.match(/\[(\d+)\]/g) || [];
        const cnt = {};
        for (const m of matches) cnt[m] = (cnt[m] || 0) + 1;
        for (const [marker, c] of Object.entries(cnt)) {
          if (c >= 2) findings.dupMarkers.push({ field: fieldKey, marker, count: c });
        }
      }
    }
  }

  // selfCiteOnly — 전체 _sources에서 외부 host 0
  const allHosts = classifySourceHosts(flatSources);
  findings.totalUrls = allHosts.allUrls.length;
  findings.uniqueHosts = allHosts.uniqueHostCount;
  findings.externalHostCount = allHosts.externalHostCount;
  if (allHosts.allUrls.length > 0 && allHosts.externalHostCount === 0) {
    findings.selfCiteOnly = true;
  }

  // idxGap — 글로벌 id 연속성
  findings.idxGap = detectSourceIdxGap(sources);

  return finalizeMetrics(findings);
}

function finalizeMetrics(f) { return f; }

function extractMojibakeSample(s) {
  const idx = s.indexOf('�');
  if (idx >= 0) return s.slice(Math.max(0, idx - 10), idx + 30);
  // arbitrary slice — 시각적 진단 위해 처음 70자
  return s.slice(0, 70);
}

function summarize(jobs) {
  const counts = {
    total_jobs: jobs.length,
    dupMarkers: 0,
    orphanSrc: 0,
    selfCite: 0,
    selfCiteOnly: 0,
    listPage: 0,
    rawURL: 0,
    brokenRef: 0,
    bracketPrefix: 0,
    mojibake: 0,
    sourcesNull: 0,
    idxGap: 0,
    clean: 0,
  };
  for (const j of jobs) {
    if (j.dupMarkers.length > 0) counts.dupMarkers++;
    if (j.orphanSrc.length > 0) counts.orphanSrc++;
    if (j.selfCite.length > 0) counts.selfCite++;
    if (j.selfCiteOnly) counts.selfCiteOnly++;
    if (j.listPage.length > 0) counts.listPage++;
    if (j.rawURL.length > 0) counts.rawURL++;
    if (j.brokenRef.length > 0) counts.brokenRef++;
    if (j.bracketPrefix.length > 0) counts.bracketPrefix++;
    if (j.mojibake.length > 0) counts.mojibake++;
    if (j.sourcesNull) counts.sourcesNull++;
    if (j.idxGap) counts.idxGap++;

    const anyIssue = j.dupMarkers.length > 0 || j.orphanSrc.length > 0 || j.selfCite.length > 0 ||
      j.selfCiteOnly || j.listPage.length > 0 || j.rawURL.length > 0 ||
      j.brokenRef.length > 0 || j.bracketPrefix.length > 0 || j.mojibake.length > 0 ||
      j.sourcesNull || j.idxGap;
    if (!anyIssue) counts.clean++;
  }
  return counts;
}

function buildWhereClause() {
  const conds = [`is_active=1`, `user_contributed_json IS NOT NULL`];
  if (args.slug) {
    conds.push(`slug='${String(args.slug).replace(/'/g, "''")}'`);
  }
  if (args['markers-only']) {
    // changeSummary에 [job-data-enhance] 마커 보유 직업 (page_revisions 통해)
    conds.push(`id IN (SELECT DISTINCT entity_id FROM page_revisions WHERE entity_type='job' AND change_summary LIKE '%[job-data-enhance]%')`);
  }
  return conds.join(' AND ');
}

function main() {
  const where = buildWhereClause();
  const sql = `SELECT slug, user_contributed_json FROM jobs WHERE ${where} ORDER BY slug`;

  console.error(`[audit-sources-deep] 쿼리 실행 중...`);
  const rows = d1Query(sql);
  console.error(`[audit-sources-deep] ${rows.length}개 직업 fetch 완료`);

  let jobs = rows.map(r => analyzeJob(r.slug, r.user_contributed_json));

  // URL 갯수 필터 (옵션) — 마커 풀 중 URL ≤ N
  if (args['max-urls']) {
    const maxN = parseInt(args['max-urls'], 10);
    jobs = jobs.filter(j => j.totalUrls <= maxN);
    console.error(`[audit-sources-deep] URL ≤ ${maxN} 필터 후 ${jobs.length}개`);
  }

  const summary = summarize(jobs);

  if (args.jsonl) {
    for (const j of jobs) console.log(JSON.stringify(j));
    return;
  }

  const out = {
    generated_at: new Date().toISOString(),
    filter: { slug: args.slug || null, markersOnly: !!args['markers-only'], maxUrls: args['max-urls'] || null },
    summary,
    jobs: args.json ? jobs : undefined,
  };

  if (args.out) {
    const outPath = path.resolve(REPO_ROOT, args.out);
    fs.mkdirSync(path.dirname(outPath), { recursive: true });
    fs.writeFileSync(outPath, JSON.stringify({ ...out, jobs }, null, 2), 'utf8');
    console.error(`[audit-sources-deep] 결과를 ${outPath} 에 저장`);
  }

  if (args.json) {
    console.log(JSON.stringify(out, null, 2));
    return;
  }

  // 사람용 summary
  console.log('\n=== audit-sources-deep ===\n');
  console.log(`전체 직업 수: ${summary.total_jobs}`);
  console.log(`이슈 없음:     ${summary.clean} (${summary.total_jobs > 0 ? Math.round(summary.clean / summary.total_jobs * 100) : 0}%)\n`);
  console.log(`패턴별 위반 직업 수:`);
  const order = [
    ['dupMarkers',   '한 필드 내 같은 [N] 중복'],
    ['orphanSrc',    '_sources idx 등록됐는데 본문 [N] 없음'],
    ['selfCite',     'career.go.kr / work.go.kr 자기 origin 인용'],
    ['selfCiteOnly', '외부 출처 0개 (origin/self만)'],
    ['listPage',     '인덱스 페이지 URL'],
    ['rawURL',       'sources.text가 raw URL'],
    ['brokenRef',    '본문 [N]에 _sources 매핑 없음'],
    ['bracketPrefix','sources.text가 [N] prefix'],
    ['mojibake',     '인코딩 깨짐'],
    ['sourcesNull',  '본문 [N] 있는데 _sources NULL'],
    ['idxGap',       '_sources 글로벌 id 1부터 연속 아님'],
  ];
  for (const [key, label] of order) {
    const n = summary[key];
    const pct = summary.total_jobs > 0 ? Math.round(n / summary.total_jobs * 100) : 0;
    const bar = '█'.repeat(Math.min(40, Math.floor(pct / 2.5)));
    console.log(`  ${label.padEnd(40)} ${String(n).padStart(4)} (${String(pct).padStart(3)}%) ${bar}`);
  }
  console.log('');

  // 단일 슬러그면 상세 출력
  if (args.slug && jobs.length === 1) {
    const j = jobs[0];
    console.log(`\n--- ${j.slug} 상세 ---`);
    console.log(JSON.stringify(j, null, 2));
  }
}

main();
