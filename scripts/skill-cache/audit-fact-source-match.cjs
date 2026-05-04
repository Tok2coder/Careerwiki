#!/usr/bin/env node
// scripts/skill-cache/audit-fact-source-match.cjs
//
// 본문-출처 정합성 audit (2026-05-04 사고 후 추가).
// 사용자 spot check (조경설계사 KSLA·LH apply) 사고 fix.
//
// 본문에 등장하는 구체 fact (회사명·기관명·통계 수치·연도·순위·금액)에 대해
// 매핑된 [N] _sources host에 그 fact의 fingerprint(latin substring 또는 한글 키워드)가
// 직접 등장하는지 휴리스틱 검사.
//
// host substring으로 1차 스크리닝 — 진짜 본문 fact 등장 여부는 LLM이 별도로 확인 필요.
// 이 audit는 cheap pre-screen 역할.
//
// 사용:
//   node scripts/skill-cache/audit-fact-source-match.cjs                           # 332 풀
//   node scripts/skill-cache/audit-fact-source-match.cjs --slug=조경설계사
//   node scripts/skill-cache/audit-fact-source-match.cjs --json
//   node scripts/skill-cache/audit-fact-source-match.cjs --jsonl --out=data/fact-source-audit.json
//
// 분류:
//   MATCH    — 모든 fact가 host와 매칭 OK
//   PARTIAL  — 일부 fact만 매칭
//   MISMATCH — 매칭 0개 (의심도 高)
//   NO_FACT  — 추출된 구체 fact 0개 (audit 대상 아님)

'use strict';

const { spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

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

// detailReady 배열 필드 — 항목별로 본문 fact 검사
const ARRAY_BODY_FIELDS = [
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
];

// ── d1 query ──
function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
  let depth = 0, end = -1, inStr = false, esc = false;
  for (let i = start; i < out.length; i++) {
    const c = out[i];
    if (esc) { esc = false; continue; }
    if (c === '\\') { esc = true; continue; }
    if (c === '"') { inStr = !inStr; continue; }
    if (inStr) continue;
    if (c === '[') depth++;
    else if (c === ']') { depth--; if (depth === 0) { end = i + 1; break; } }
  }
  if (end < 0) end = out.length;
  const json = out.slice(start, end);
  try {
    return JSON.parse(json)[0]?.results || [];
  } catch (e) {
    throw new Error(`d1Query JSON parse 실패: ${e.message}`);
  }
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

// ── 본문 fact 추출 ──
//
// 추출 종류:
//   1) Korean 회사·기관명 (한글 2-10자 + ORG_KEYWORD)
//   2) Latin 약어 (LH, KAIST, POSTECH, OECD 등 2-8자 대문자)
//   3) 통계 수치 (평균임금 N만원, 종사자 N만명, N% 등)
//   4) 연도 (2024년, 2023년 등)
//   5) 순위 (1위, 상위 N% 등)

const ORG_KEYWORDS = [
  '사무소', '회사', '은행', '공사', '연구원', '연구소', '병원', '학회', '협회',
  '재단', '기금', '공단', '진흥원', '위원회', '연합회', '총회', '재단법인',
  '그룹', '전자', '반도체', '중공업', '건설', '조선', '항공', '자동차', '해운',
  '화학', '제약', '바이오', '카드', '증권', '보험', '캐피탈', '저축은행',
  '대학교', '대학원', '학원', '직업학교',
];

const LATIN_ABBR_BLACKLIST = new Set([
  'SHA', 'MBA', 'NCS', 'GPA', 'URL', 'API', 'CEO', 'CTO', 'CFO', 'CIO',
  'IT', 'AI', 'ML', 'DL', 'NLP', 'CV', 'OS', 'PC', 'TV', 'CD', 'DVD',
  'OK', 'NO', 'GO', 'TO', 'IN', 'ON', 'AT', 'BY', 'OF', 'PR', 'HR', 'DB',
  'OECD', 'WHO', 'WTO', 'IMF', 'UN', 'UNESCO', 'EU', 'US', 'UK',  // 글로벌 일반 (host 매칭은 별도)
]);

function extractFacts(text) {
  if (!text || typeof text !== 'string') return [];
  const facts = [];

  // 1) Korean 회사명 (한글 2-10자 + ORG_KEYWORD)
  const orgKeywordsRe = ORG_KEYWORDS.map(k => k.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|');
  const koreanOrgRe = new RegExp(`([가-힣]{2,10})(?:${orgKeywordsRe})`, 'g');
  let m;
  while ((m = koreanOrgRe.exec(text)) !== null) {
    facts.push({ type: 'korean_org', text: m[0], index: m.index, fingerprint: m[0] });
  }

  // 2) Latin 약어 (LH, KAIST 등)
  const latinRe = /\b[A-Z]{2,8}\b/g;
  while ((m = latinRe.exec(text)) !== null) {
    if (!LATIN_ABBR_BLACKLIST.has(m[0])) {
      facts.push({ type: 'latin_abbr', text: m[0], index: m.index, fingerprint: m[0].toLowerCase() });
    }
  }

  // 3) 통계 수치 (평균임금 N만원, 종사자 N만명)
  const statRe = /(평균임금|평균 임금|초임|연봉|월급|종사자\s*수?|종사자|취업률|채용\s*인원)\s*[은는이가:]?\s*([0-9]{1,5}(?:,[0-9]{3})*(?:\.[0-9]+)?\s*(?:만\s*원|만원|원|만\s*명|만명|명|%))/g;
  while ((m = statRe.exec(text)) !== null) {
    facts.push({ type: 'statistic', text: m[0], index: m.index, fingerprint: m[2] });
  }

  // 4) 연도 (2020-2026)
  const yearRe = /\b(20[12][0-9])년/g;
  while ((m = yearRe.exec(text)) !== null) {
    facts.push({ type: 'year', text: m[0], index: m.index, fingerprint: m[1] });
  }

  // 5) 순위 (1위, 상위 N%)
  const rankRe = /\b(\d{1,3})위\b|상위\s*(\d{1,3})%/g;
  while ((m = rankRe.exec(text)) !== null) {
    facts.push({ type: 'rank', text: m[0], index: m.index, fingerprint: m[0] });
  }

  return facts;
}

// ── fact ↔ 마커 [N] 매핑 ──
//
// fact 위치 직후 60자 이내에 [N] 등장 시 그 fact의 출처는 [N].
// [N] 마커 1개에 여러 fact 매칭 가능.

function mapFactsToMarkers(text, facts) {
  if (!text) return [];
  const markers = [];
  const markerRe = /\[(\d+)\]/g;
  let m;
  while ((m = markerRe.exec(text)) !== null) {
    markers.push({ N: parseInt(m[1], 10), index: m.index, raw: m[0] });
  }
  if (markers.length === 0) return [];

  const mappings = [];
  for (const fact of facts) {
    // fact 위치 이후 가장 가까운 [N] 마커 찾기 (단, 그 사이에 다른 [N] 없을 때만)
    // 그리고 fact가 마커 60자 이내에 있을 때만
    let bestMarker = null;
    for (const mk of markers) {
      if (mk.index < fact.index) continue;
      const dist = mk.index - (fact.index + fact.text.length);
      if (dist < 0) continue;
      if (dist > 60) continue;
      bestMarker = mk;
      break;
    }
    if (bestMarker) {
      mappings.push({ ...fact, marker: bestMarker.N });
    }
  }
  return mappings;
}

// ── host fingerprint cover 검사 ──
//
// fact.fingerprint가 host에 substring으로 등장하면 cover.
// Korean 회사명은 host에 등장 X (host는 latin only) → 휴리스틱: 한글 회사명은 NEUTRAL (cover 여부 모름).
// Latin 약어, 통계 수치, 연도, 순위는 host에 등장하면 cover, 안 하면 NOT_COVER.

function checkCoverage(fact, host) {
  if (!host) return 'NEUTRAL';
  const fp = fact.fingerprint;
  if (!fp) return 'NEUTRAL';

  if (fact.type === 'korean_org') {
    // 한글은 host에 등장 X — neutral (LLM check 필요)
    return 'NEUTRAL';
  }
  if (fact.type === 'statistic' || fact.type === 'rank') {
    // 통계 수치도 host에 보통 등장 X — neutral
    return 'NEUTRAL';
  }
  if (fact.type === 'year') {
    // 연도는 host에 거의 등장 X — neutral
    return 'NEUTRAL';
  }
  if (fact.type === 'latin_abbr') {
    return host.toLowerCase().includes(fp.toLowerCase()) ? 'COVER' : 'NOT_COVER';
  }
  return 'NEUTRAL';
}

// ── general domain blacklist (룰 2 강화) ──
//
// 협회 메인 / 부처 root / 직업백과 → 산업 일반만. 구체 fact 출처 X.

const GENERAL_DOMAIN_PATTERNS = [
  // 부처 root (path 없음 또는 / 만)
  { pattern: /^(www\.)?(mohw|molit|moel|moe|mafra|msit|customs|moef|mois|mosf|kostat)\.go\.kr\/?$/i, label: '부처 메인' },
  // 직업백과 일반
  { pattern: /^(www\.)?asamaru\.net\/jobinfo\//i, label: '직업백과 일반' },
  // 위키 직업 정의 페이지 (path에 직업명만)
  { pattern: /^ko\.wikipedia\.org\/wiki\//i, label: '위키 직업 정의' },
];

function isGeneralDomain(url) {
  if (!url) return null;
  let host, pathname;
  try {
    const u = new URL(url);
    host = u.host;
    pathname = u.pathname;
  } catch { return null; }
  const full = host + pathname;
  for (const { pattern, label } of GENERAL_DOMAIN_PATTERNS) {
    if (pattern.test(full)) return label;
  }
  // 협회 메인 (or.kr root) → 가벼운 휴리스틱: pathname이 / 또는 빈 문자열
  if (/\.(or|co)\.kr$/.test(host) && (pathname === '/' || pathname === '' || pathname === '/index.html' || /^\/main\.do$/.test(pathname))) {
    return '협회/회사 메인 root';
  }
  return null;
}

// ── 한 텍스트 (산문 or 배열 항목) 안의 fact-marker 매핑 검사 ──
function processFieldText(fp, text, sources, result) {
  const facts = extractFacts(text);
  if (facts.length === 0) return;
  const mappings = mapFactsToMarkers(text, facts);
  if (mappings.length === 0) return;

  const srcArr = sources[fp];
  if (!Array.isArray(srcArr)) return;

  for (const mapping of mappings) {
    const N = mapping.marker;
    if (N < 1 || N > srcArr.length) continue;
    const src = srcArr[N - 1];
    if (!src || !src.url) continue;
    let host;
    try { host = new URL(src.url).host.toLowerCase(); } catch { continue; }

    result.factCount++;
    result.totalSourcesChecked++;

    const coverage = checkCoverage(mapping, host);
    if (coverage === 'COVER') result.coveredCount++;
    else if (coverage === 'NOT_COVER') {
      result.notCoveredCount++;
      result.suspectFacts.push({
        field: fp, fact: mapping.text, factType: mapping.type,
        marker: N, srcUrl: src.url, srcHost: host, coverage,
      });
    } else {
      result.neutralCount++;
    }

    // 일반 도메인 사용 검사
    const generalLabel = isGeneralDomain(src.url);
    if (generalLabel) {
      if (mapping.type === 'korean_org' || mapping.type === 'statistic' || mapping.type === 'latin_abbr') {
        result.generalDomainFacts.push({
          field: fp, marker: N, fact: mapping.text, factType: mapping.type,
          srcUrl: src.url, label: generalLabel,
        });
      }
    }
  }
}

// ── 직업별 분석 ──
function analyzeJob(slug, ucjStr) {
  const result = {
    slug,
    classification: 'NO_FACT',
    factCount: 0,
    coveredCount: 0,
    notCoveredCount: 0,
    neutralCount: 0,
    suspectFacts: [],   // [{field, fact, marker, srcHost, coverage, generalDomainFlag}]
    generalDomainFacts: [], // [{field, marker, fact, srcUrl, label}]
    totalSourcesChecked: 0,
  };
  if (!ucjStr) return result;
  let ucj;
  try { ucj = typeof ucjStr === 'string' ? JSON.parse(ucjStr) : ucjStr; } catch { return result; }

  const sources = ucj._sources || {};

  // 산문 필드 검사
  for (const fp of BODY_FIELDS) {
    const text = getNested(ucj, fp);
    if (typeof text !== 'string' || text.length < 20) continue;
    processFieldText(fp, text, sources, result);
  }

  // 배열 필드 검사 (detailReady.*)
  for (const fp of ARRAY_BODY_FIELDS) {
    const arr = getNested(ucj, fp);
    if (!Array.isArray(arr)) continue;
    for (const item of arr) {
      let text;
      if (typeof item === 'string') text = item;
      else if (item && typeof item === 'object' && typeof item.text === 'string') text = item.text;
      else continue;
      if (text.length < 10) continue;
      processFieldText(fp, text, sources, result);
    }
  }

  // 분류
  if (result.factCount === 0) result.classification = 'NO_FACT';
  else if (result.notCoveredCount === 0 && result.generalDomainFacts.length === 0) result.classification = 'MATCH';
  else if (result.coveredCount > 0 && (result.notCoveredCount > 0 || result.generalDomainFacts.length > 0)) result.classification = 'PARTIAL';
  else result.classification = 'MISMATCH';

  return result;
}

// ── 메인 ──
function buildWhereClause() {
  const conds = [`is_active=1`, `user_contributed_json IS NOT NULL`];
  if (args.slug) {
    conds.push(`slug='${String(args.slug).replace(/'/g, "''")}'`);
  } else {
    // 기본: 332 풀 (page_revisions [job-data-enhance] 마커)
    conds.push(`id IN (SELECT DISTINCT entity_id FROM page_revisions WHERE entity_type='job' AND change_summary LIKE '%[job-data-enhance]%')`);
  }
  return conds.join(' AND ');
}

function summarize(jobs) {
  const counts = { total: jobs.length, MATCH: 0, PARTIAL: 0, MISMATCH: 0, NO_FACT: 0 };
  let suspectFactsTotal = 0, generalDomainFactsTotal = 0;
  for (const j of jobs) {
    counts[j.classification]++;
    suspectFactsTotal += j.suspectFacts.length;
    generalDomainFactsTotal += j.generalDomainFacts.length;
  }
  counts.suspectFactsTotal = suspectFactsTotal;
  counts.generalDomainFactsTotal = generalDomainFactsTotal;
  return counts;
}

function main() {
  const where = buildWhereClause();
  const sql = `SELECT slug, user_contributed_json FROM jobs WHERE ${where} ORDER BY slug`;
  console.error(`[audit-fact-source-match] 쿼리 실행 중...`);
  const rows = d1Query(sql);
  console.error(`[audit-fact-source-match] ${rows.length}개 직업 fetch 완료`);

  const jobs = rows.map(r => analyzeJob(r.slug, r.user_contributed_json));
  const summary = summarize(jobs);

  if (args.jsonl) {
    for (const j of jobs) console.log(JSON.stringify(j));
    return;
  }

  if (args.out) {
    const outPath = path.resolve(REPO_ROOT, args.out);
    fs.mkdirSync(path.dirname(outPath), { recursive: true });
    fs.writeFileSync(outPath, JSON.stringify({
      generated_at: new Date().toISOString(),
      summary, jobs,
    }, null, 2), 'utf8');
    console.error(`[audit-fact-source-match] 결과를 ${outPath} 에 저장`);
  }

  if (args.json) {
    console.log(JSON.stringify({ summary, jobs }, null, 2));
    return;
  }

  // 사람용 summary
  console.log('\n=== audit-fact-source-match ===\n');
  console.log(`전체 직업 수: ${summary.total}`);
  console.log(`  MATCH:    ${summary.MATCH} (${pct(summary.MATCH, summary.total)}%)`);
  console.log(`  PARTIAL:  ${summary.PARTIAL} (${pct(summary.PARTIAL, summary.total)}%)`);
  console.log(`  MISMATCH: ${summary.MISMATCH} (${pct(summary.MISMATCH, summary.total)}%)`);
  console.log(`  NO_FACT:  ${summary.NO_FACT} (${pct(summary.NO_FACT, summary.total)}%)`);
  console.log(``);
  console.log(`의심 fact: ${summary.suspectFactsTotal}건 (host substring NOT_COVER)`);
  console.log(`일반 도메인 사용: ${summary.generalDomainFactsTotal}건 (협회 root / 부처 root / 직업백과)`);
  console.log(``);

  // 단일 슬러그면 상세 출력
  if (args.slug && jobs.length === 1) {
    const j = jobs[0];
    console.log(`--- ${j.slug} 상세 ---`);
    console.log(JSON.stringify(j, null, 2));
    return;
  }

  // top 의심 직업
  const sorted = jobs
    .filter(j => j.classification === 'MISMATCH' || j.classification === 'PARTIAL')
    .sort((a, b) => (b.notCoveredCount + b.generalDomainFacts.length) - (a.notCoveredCount + a.generalDomainFacts.length));
  console.log(`\n--- TOP 30 의심 직업 (notCovered + 일반도메인 합 기준) ---`);
  sorted.slice(0, 30).forEach(j => {
    console.log(`  ${j.classification.padEnd(8)} ${j.slug.padEnd(20)} fact=${j.factCount} not=${j.notCoveredCount} gen=${j.generalDomainFacts.length}`);
  });
}

function pct(n, total) {
  return total > 0 ? Math.round(n / total * 100) : 0;
}

main();
