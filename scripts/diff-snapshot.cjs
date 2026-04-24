#!/usr/bin/env node
/**
 * diff-snapshot.cjs
 *
 * Phase 0 시작 전 UCJ 스냅샷을 저장하고,
 * Phase 3 저장 후 현재 DB 값과 비교하여 손실·축소·방향 반전을 탐지한다.
 *
 * 사용법:
 *   # 저장 전 스냅샷 찍기 (Phase 0 진단 직후)
 *   node scripts/diff-snapshot.cjs save --slug=건축목공 --ucj='{"way":"...","sidebarCerts":[...]}'
 *
 *   # 저장 후 비교 (Phase 4 검증 시)
 *   node scripts/diff-snapshot.cjs diff --slug=건축목공 --ucj-after='{"way":"...","sidebarCerts":[...]}'
 *
 *   # 스냅샷 목록
 *   node scripts/diff-snapshot.cjs list
 *
 * 스냅샷 저장 경로: .skill-cache/snapshot-{slug}.json
 */

const fs = require('fs');
const path = require('path');

const CACHE_DIR = path.join(__dirname, '..', '.skill-cache');

// ── 배열 필드 (항목 수 감소 감지 대상) ──
const ARRAY_FIELDS = [
  'sidebarCerts',
  'sidebarMajors',
  'sidebarOrgs',
  'sidebarJobs',
  'youtubeLinks',
];
const DETAIL_READY_ARRAY_SUBS = ['curriculum', 'recruit', 'training', 'certificate'];

// ── 텍스트 필드 (방향 반전 감지 대상) ──
const PROSE_FIELDS = [
  'way',
  'overviewSalary.sal',
  'overviewProspect.main',
  'trivia',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
];

// 감소 방향 키워드 (prospect 방향 감지용)
const NEGATIVE_KEYWORDS = ['감소', '줄어', '어렵', '경쟁 심화', '하락', '위축', '저하'];
const POSITIVE_KEYWORDS = ['증가', '성장', '확대', '늘어', '상승', '높아'];

function getNestedField(obj, fieldPath) {
  if (!obj || typeof obj !== 'object') return undefined;
  if (obj[fieldPath] !== undefined) return obj[fieldPath];
  const parts = fieldPath.split('.');
  let cur = obj;
  for (const p of parts) {
    if (cur == null) return undefined;
    cur = cur[p];
  }
  return cur;
}

function detectProspectDirection(text) {
  if (!text || typeof text !== 'string') return 'unknown';
  const neg = NEGATIVE_KEYWORDS.some(k => text.includes(k));
  const pos = POSITIVE_KEYWORDS.some(k => text.includes(k));
  if (neg && !pos) return 'negative';
  if (pos && !neg) return 'positive';
  if (neg && pos) return 'mixed';
  return 'neutral';
}

function saveSnapshot(slug, ucjRaw) {
  if (!fs.existsSync(CACHE_DIR)) {
    fs.mkdirSync(CACHE_DIR, { recursive: true });
  }
  const ucj = typeof ucjRaw === 'string' ? JSON.parse(ucjRaw) : ucjRaw;
  const snapshot = {
    slug,
    savedAt: new Date().toISOString(),
    ucj,
    // 요약: 배열 필드 항목 수, prose 필드 길이, prospect 방향
    summary: buildSummary(slug, ucj),
  };
  const filePath = path.join(CACHE_DIR, `snapshot-${slug}.json`);
  fs.writeFileSync(filePath, JSON.stringify(snapshot, null, 2), 'utf8');
  console.log(`\n✅ 스냅샷 저장: ${filePath}`);
  console.log(`\n[${slug}] 저장 전 상태 요약:`);
  printSummary(snapshot.summary);
}

function buildSummary(slug, ucj) {
  const summary = { slug, arrays: {}, prose: {}, prospectDirection: null };

  // 배열 필드 항목 수
  for (const f of ARRAY_FIELDS) {
    const val = ucj[f];
    summary.arrays[f] = Array.isArray(val) ? val.length : (val ? '있음(비배열)' : null);
  }
  // detailReady 배열
  const dr = ucj.detailReady;
  if (dr && typeof dr === 'object') {
    for (const sub of DETAIL_READY_ARRAY_SUBS) {
      const key = `detailReady.${sub}`;
      summary.arrays[key] = Array.isArray(dr[sub]) ? dr[sub].length : null;
    }
  }

  // prose 필드 길이
  for (const f of PROSE_FIELDS) {
    const val = getNestedField(ucj, f);
    summary.prose[f] = typeof val === 'string' ? val.length : null;
  }

  // prospect 방향
  const prospect = getNestedField(ucj, 'overviewProspect.main');
  summary.prospectDirection = detectProspectDirection(prospect);

  return summary;
}

function printSummary(summary) {
  console.log('\n  배열 필드:');
  for (const [k, v] of Object.entries(summary.arrays)) {
    if (v !== null) console.log(`    ${k}: ${v}개`);
  }
  console.log('\n  텍스트 필드 길이:');
  for (const [k, v] of Object.entries(summary.prose)) {
    if (v !== null) console.log(`    ${k}: ${v}자`);
  }
  if (summary.prospectDirection) {
    console.log(`\n  prospect 방향: ${summary.prospectDirection}`);
  }
}

function diffSnapshot(slug, ucjAfterRaw) {
  const filePath = path.join(CACHE_DIR, `snapshot-${slug}.json`);
  if (!fs.existsSync(filePath)) {
    console.error(`\n❌ 스냅샷 없음: ${filePath}`);
    console.error('Phase 0에서 먼저 "save" 명령으로 스냅샷을 저장하세요.');
    process.exit(1);
  }
  const snapshot = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  const ucjAfter = typeof ucjAfterRaw === 'string' ? JSON.parse(ucjAfterRaw) : ucjAfterRaw;
  const after = buildSummary(slug, ucjAfter);

  const before = snapshot.summary;
  const issues = [];

  console.log(`\n=== diff-snapshot: ${slug} ===`);
  console.log(`스냅샷 시점: ${snapshot.savedAt}`);

  // 배열 항목 수 비교
  console.log('\n[배열 필드 비교]');
  for (const [k, beforeCount] of Object.entries(before.arrays)) {
    const afterCount = after.arrays[k];
    if (beforeCount === null && afterCount === null) continue;
    const bNum = typeof beforeCount === 'number' ? beforeCount : 0;
    const aNum = typeof afterCount === 'number' ? afterCount : 0;
    const status = aNum < bNum ? '❌ LOSS' : (aNum > bNum ? '✅ +추가' : '✅ 동일');
    console.log(`  ${k}: ${beforeCount ?? 'null'} → ${afterCount ?? 'null'}  ${status}`);
    if (aNum < bNum) {
      issues.push(`[LOSS] ${k}: ${bNum}개 → ${aNum}개 (${bNum - aNum}개 손실)`);
    }
  }

  // prose 필드 길이 비교
  console.log('\n[텍스트 필드 길이 비교]');
  for (const [k, beforeLen] of Object.entries(before.prose)) {
    const afterLen = after.prose[k];
    if (beforeLen === null && afterLen === null) continue;
    const bNum = beforeLen ?? 0;
    const aNum = afterLen ?? 0;
    const delta = aNum - bNum;
    const status = aNum < bNum * 0.7 ? '⚠️ 대폭 축소' : (delta >= 0 ? '✅' : '⚠️ 축소');
    console.log(`  ${k}: ${beforeLen ?? 'null'}자 → ${afterLen ?? 'null'}자  (${delta >= 0 ? '+' : ''}${delta})  ${status}`);
    if (aNum < bNum * 0.7 && bNum > 50) {
      issues.push(`[SHRINK] ${k}: ${bNum}자 → ${aNum}자 (30%+ 축소)`);
    }
  }

  // prospect 방향 비교
  const bDir = before.prospectDirection;
  const aDir = after.prospectDirection;
  console.log(`\n[prospect 방향]: ${bDir} → ${aDir}`);
  if (bDir === 'negative' && aDir === 'positive') {
    issues.push(`[DIRECTION] prospect 방향 반전: ${bDir} → ${aDir} — 원문 방향 복원 필요`);
    console.log('  ❌ 방향 반전 감지!');
  } else if (bDir !== aDir) {
    console.log(`  ⚠️ 방향 변경: ${bDir} → ${aDir} — 확인 필요`);
  } else {
    console.log('  ✅ 방향 일치');
  }

  // 결과 요약
  console.log('\n[결과]');
  if (issues.length === 0) {
    console.log('✅ ALL PASS — 데이터 손실 없음\n');
  } else {
    console.log(`❌ ISSUES (${issues.length}개):`);
    issues.forEach(i => console.log(`  ${i}`));
    console.log('\n❌ FAIL — 손실된 항목 복원 후 재저장 필요\n');
    process.exit(1);
  }
}

function listSnapshots() {
  if (!fs.existsSync(CACHE_DIR)) {
    console.log('스냅샷 없음 (.skill-cache 폴더 없음)');
    return;
  }
  const files = fs.readdirSync(CACHE_DIR).filter(f => f.startsWith('snapshot-') && f.endsWith('.json'));
  if (files.length === 0) {
    console.log('저장된 스냅샷 없음');
    return;
  }
  console.log(`\n저장된 스냅샷 (${files.length}개):`);
  for (const f of files) {
    const data = JSON.parse(fs.readFileSync(path.join(CACHE_DIR, f), 'utf8'));
    console.log(`  ${f}  (${data.savedAt})`);
  }
}

// ── 메인 ──

const [,, command, ...args] = process.argv;

function getArg(name) {
  const prefix = `--${name}=`;
  const found = args.find(a => a.startsWith(prefix));
  return found ? found.slice(prefix.length) : null;
}

switch (command) {
  case 'save': {
    const slug = getArg('slug');
    const ucjStr = getArg('ucj');
    if (!slug || !ucjStr) {
      console.error('Usage: node scripts/diff-snapshot.cjs save --slug=SLUG --ucj=\'{"json":"..."}\'');
      process.exit(1);
    }
    saveSnapshot(slug, ucjStr);
    break;
  }
  case 'diff': {
    const slug = getArg('slug');
    const ucjAfterStr = getArg('ucj-after');
    if (!slug || !ucjAfterStr) {
      console.error('Usage: node scripts/diff-snapshot.cjs diff --slug=SLUG --ucj-after=\'{"json":"..."}\'');
      process.exit(1);
    }
    diffSnapshot(slug, ucjAfterStr);
    break;
  }
  case 'list': {
    listSnapshots();
    break;
  }
  default: {
    console.log('Usage:');
    console.log('  node scripts/diff-snapshot.cjs save --slug=SLUG --ucj=\'{"json":"..."}\'');
    console.log('  node scripts/diff-snapshot.cjs diff --slug=SLUG --ucj-after=\'{"json":"..."}\'');
    console.log('  node scripts/diff-snapshot.cjs list');
    process.exit(1);
  }
}
