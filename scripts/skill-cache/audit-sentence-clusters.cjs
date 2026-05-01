#!/usr/bin/env node
// scripts/skill-cache/audit-sentence-clusters.cjs
// Sentence-level marker cluster detection.
//
// 본질: 한 문장(마침표/물음표/느낌표/줄바꿈 사이) 안에 마커 [N] 2개 이상이면 cluster.
// `[1][2]`, `[1] [2]`, `[1]·[2]`, `[1] and [2]` 모두 catch.
// `합니다.[1] 그리고 비싸다.[2]` 처럼 마커 사이에 문장경계 있으면 cluster 아님.
//
// 사용:
//   node scripts/skill-cache/audit-sentence-clusters.cjs
//   node scripts/skill-cache/audit-sentence-clusters.cjs --slug={X}
//   node scripts/skill-cache/audit-sentence-clusters.cjs --out=data/cluster-audit-XXX.json
//
// 출력: data/cluster-audit-{N}.json + data/cluster-jobs-list.txt (default)

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

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
const ARRAY_FIELDS = [
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
  'detailReady.certificate',
];

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`,
    {
      cwd: REPO_ROOT,
      encoding: 'utf8',
      maxBuffer: 500 * 1024 * 1024,
      shell: true,
      windowsHide: true,
    }
  );
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
  // Bracket-balanced scan to find end of top-level JSON array
  let depth = 0;
  let end = -1;
  let inStr = false;
  let esc = false;
  for (let i = start; i < out.length; i++) {
    const c = out[i];
    if (esc) {
      esc = false;
      continue;
    }
    if (c === '\\') {
      esc = true;
      continue;
    }
    if (c === '"') {
      inStr = !inStr;
      continue;
    }
    if (inStr) continue;
    if (c === '[') depth++;
    else if (c === ']') {
      depth--;
      if (depth === 0) {
        end = i + 1;
        break;
      }
    }
  }
  if (end < 0) end = out.length;
  return JSON.parse(out.slice(start, end))[0]?.results || [];
}

function getNested(obj, dotted) {
  return dotted.split('.').reduce((cur, p) => cur?.[p], obj);
}

// Sentence boundaries: position right AFTER a sentence-ending punctuation chain.
// Sentence end = `.`/`!`/`?` followed by zero or more chained markers/middle-dots/spaces,
// then either whitespace, newline, or end-of-text. Or `\n` alone.
// Returns sorted array of boundary positions (each is the start of the NEXT sentence).
function findSentenceBoundaries(text) {
  const boundaries = [];
  let i = 0;
  while (i < text.length) {
    const c = text[i];
    if (c === '\n') {
      boundaries.push(i + 1);
      i++;
      continue;
    }
    if (c === '.' || c === '!' || c === '?') {
      // Try to extend through chained markers/middle-dots/spaces
      let j = i + 1;
      let advanced = true;
      while (advanced && j < text.length) {
        advanced = false;
        const m = text.slice(j).match(/^\[\d+\]/);
        if (m) {
          j += m[0].length;
          advanced = true;
          continue;
        }
        if (text[j] === '·') {
          j++;
          advanced = true;
          continue;
        }
        // single inter-marker whitespace (e.g. `[1] [2]`)
        if (/[ \t]/.test(text[j])) {
          let k = j;
          while (k < text.length && /[ \t]/.test(text[k])) k++;
          if (k < text.length && (text[k] === '[' || text[k] === '·')) {
            j = k;
            advanced = true;
            continue;
          }
        }
      }
      // Now check: is j at sentence end?
      // Sentence end if: j >= length, or text[j] is whitespace/newline.
      if (j >= text.length) {
        boundaries.push(j);
        i = j;
        continue;
      }
      if (/\s/.test(text[j])) {
        // skip the whitespace, boundary is right after the whitespace cluster (start of next sentence)
        let k = j;
        while (k < text.length && /[ \t]/.test(text[k])) k++;
        boundaries.push(k);
        i = k;
        continue;
      }
      // not sentence end (e.g., `1.5` digit follows period without space)
      i++;
      continue;
    }
    i++;
  }
  return boundaries;
}

// Returns sentence_id (0-indexed) for a position. Markers AT boundary go to previous sentence.
// Specifically: marker at position p belongs to sentence whose range includes p.
// If boundary[i] = b, then sentence i spans [boundaries[i-1] (or 0), boundaries[i]).
// A marker at position p belongs to sentence min{i : p < boundaries[i]} (or last sentence).
function getSentenceId(pos, boundaries) {
  for (let i = 0; i < boundaries.length; i++) {
    if (pos < boundaries[i]) return i;
  }
  return boundaries.length;
}

// 한 텍스트에서 sentence-level cluster들을 추출.
// 같은 sentence_id를 가진 markers 2개 이상 → cluster.
function detectClustersInText(text) {
  if (typeof text !== 'string' || !text) return [];
  const markerIter = [...text.matchAll(/\[\d+\]/g)];
  if (markerIter.length === 0) return [];

  const boundaries = findSentenceBoundaries(text);
  const bySentence = new Map();
  for (const m of markerIter) {
    const sid = getSentenceId(m.index, boundaries);
    if (!bySentence.has(sid)) bySentence.set(sid, []);
    bySentence.get(sid).push(m);
  }

  const groups = [];
  for (const [, markers] of bySentence) {
    if (markers.length >= 2) groups.push(markers);
  }

  return groups.map((group) => {
    const first = group[0];
    const last = group[group.length - 1];
    const startIdx = first.index;
    const endIdx = last.index + last[0].length;

    // Sentence excerpt: get the full sentence containing these markers.
    const sid = getSentenceId(startIdx, boundaries);
    const sStart = sid === 0 ? 0 : boundaries[sid - 1];
    const sEnd = sid < boundaries.length ? boundaries[sid] : text.length;

    return {
      markers: group.map((g) => g[0]).join(''),
      count: group.length,
      sentence: text.slice(sStart, sEnd).trim(),
      startIdx,
      endIdx,
    };
  });
}

function auditJob(row) {
  const ucj = JSON.parse(row.user_contributed_json || '{}');
  const fieldReports = [];

  for (const f of BODY_FIELDS) {
    const v = getNested(ucj, f);
    if (typeof v !== 'string') continue;
    const clusters = detectClustersInText(v);
    if (clusters.length > 0) fieldReports.push({ field: f, kind: 'string', clusters });
  }

  for (const f of ARRAY_FIELDS) {
    const arr = getNested(ucj, f);
    if (!Array.isArray(arr)) continue;
    const itemReports = [];
    arr.forEach((item, idx) => {
      if (typeof item !== 'string') return;
      const clusters = detectClustersInText(item);
      if (clusters.length > 0) itemReports.push({ idx, clusters });
    });
    if (itemReports.length > 0) fieldReports.push({ field: f, kind: 'array', items: itemReports });
  }

  return fieldReports;
}

function main() {
  const slugFilter = args.slug;
  const outFile = args.out || 'data/cluster-audit.json';
  const listFile = args['list-out'] || 'data/cluster-jobs-list.txt';

  let sql;
  if (slugFilter) {
    sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE is_active=1 AND slug='${slugFilter.replace(/'/g, "''")}'`;
  } else {
    sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE is_active=1 AND user_contributed_json LIKE '%[1]%' ORDER BY slug`;
  }

  console.log('[audit-sentence-clusters] querying D1 prod ...');
  const t0 = Date.now();
  const rows = d1Query(sql);
  const tQuery = Date.now() - t0;
  console.log(`  fetched ${rows.length} jobs (with marker [1]) in ${tQuery}ms`);

  const reports = [];
  let totalClusters = 0;
  for (const row of rows) {
    const fieldReports = auditJob(row);
    if (fieldReports.length > 0) {
      const jobClusterCount = fieldReports.reduce((s, fr) => {
        if (fr.kind === 'string') return s + fr.clusters.length;
        return s + fr.items.reduce((ss, it) => ss + it.clusters.length, 0);
      }, 0);
      totalClusters += jobClusterCount;
      reports.push({
        id: row.id,
        slug: row.slug,
        clusterCount: jobClusterCount,
        fields: fieldReports,
      });
    }
  }

  const summary = {
    auditedAt: new Date().toISOString(),
    scope: slugFilter ? `slug=${slugFilter}` : 'is_active=1 AND ucj LIKE %[1]%',
    totalScanned: rows.length,
    totalClusterJobs: reports.length,
    totalClusters,
    bodyFields: BODY_FIELDS,
    arrayFields: ARRAY_FIELDS,
    jobs: reports,
  };

  const outPath = path.resolve(REPO_ROOT, outFile);
  const listPath = path.resolve(REPO_ROOT, listFile);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, JSON.stringify(summary, null, 2));
  fs.writeFileSync(listPath, reports.map((r) => r.slug).join('\n') + '\n');

  console.log('\n[audit-sentence-clusters] DONE');
  console.log(`  scanned: ${rows.length} jobs (with marker [1])`);
  console.log(`  cluster jobs: ${reports.length}`);
  console.log(`  total clusters: ${totalClusters}`);
  console.log(`  out: ${outFile}`);
  console.log(`  list: ${listFile}`);

  if (reports.length > 0 && reports.length <= 100) {
    console.log('\n  cluster job slugs:');
    reports.forEach((r) => console.log(`    ${r.slug}  (${r.clusterCount} cluster)`));
  }
}

main();
