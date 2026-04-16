#!/usr/bin/env node
/**
 * audit-today-jobs.cjs
 *
 * 오늘(2026-04-16) enhance한 9개 직업에 룰 A/B/C 위반 여부 전수 감사.
 * 기존 DB 데이터를 직접 조회하여 위반 목록만 생성 (자동 수정 금지).
 *
 * Usage: node scripts/selfcheck/audit-today-jobs.cjs
 */

'use strict';

const { execSync } = require('child_process');
const path = require('path');
const {
  detectMissingFootnoteInArrayItems,
  analyzeYoutubeSearchNote,
  analyzeCareerTreeNote,
} = require(path.join(__dirname, '..', '_shared', 'detect-patterns.cjs'));

const DB_NAME = 'careerwiki-kr';
const ROOT_DIR = path.join(__dirname, '..', '..');

const TARGET_JOBS = [
  '카지노딜러',
  '캐스팅디렉터',
  '최고기술책임자',
  '준법감시인',
  '사설학원원장',
  '경찰서장',
  '광고홍보관리자',
  '바이오화학제품연구기획자',
  '자재구매관리자',
];

function queryD1(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  const raw = execSync(
    `npx wrangler d1 execute ${DB_NAME} --remote --command "${escaped}"`,
    { encoding: 'utf8', timeout: 30000, cwd: ROOT_DIR }
  );
  const jsonStart = raw.indexOf('[');
  if (jsonStart === -1) return [];
  const parsed = JSON.parse(raw.substring(jsonStart));
  return parsed?.[0]?.results || [];
}

function checkJob(job) {
  const violations = [];
  const name = job.name;

  let ucj = {};
  try {
    ucj = typeof job.user_contributed_json === 'string'
      ? JSON.parse(job.user_contributed_json)
      : (job.user_contributed_json || {});
  } catch { ucj = {}; }

  // ── 룰 A: UCJ detailReady 배열 항목별 [N] 필수 ──
  const dr = ucj.detailReady || {};
  for (const sub of ['curriculum', 'recruit', 'training']) {
    if (!dr[sub] || !Array.isArray(dr[sub]) || dr[sub].length === 0) continue;
    const missing = detectMissingFootnoteInArrayItems(dr[sub]);
    if (missing.length > 0) {
      const previews = missing.map(i => {
        const t = typeof dr[sub][i] === 'string' ? dr[sub][i] : (dr[sub][i]?.text || '');
        return `[${i}] "${t.substring(0, 40)}..."`;
      });
      violations.push({ rule: 'A', field: `detailReady.${sub}`, detail: `[N] 없는 항목: ${previews.join(', ')}` });
    }
  }

  // ── 룰 B: _youtubeSearchNote 탐색 깊이 ──
  const ytLinks = ucj.youtubeLinks;
  const ytEmpty = !ytLinks || (Array.isArray(ytLinks) && ytLinks.length === 0);
  if (ytEmpty) {
    const ytNote = ucj._youtubeSearchNote;
    if (ytNote && typeof ytNote === 'string' && ytNote.trim().length >= 10) {
      const analysis = analyzeYoutubeSearchNote(ytNote);
      if (!analysis.pass) {
        violations.push({
          rule: 'B',
          field: '_youtubeSearchNote',
          detail: `탐색어 ${analysis.termCount}개 / 카테고리 ${analysis.categoryCount}/4 커버. 미커버: ${analysis.missingCategories.join(', ')}`,
        });
      }
    } else if (!ytNote) {
      violations.push({ rule: 'B', field: '_youtubeSearchNote', detail: '노트 자체 없음 (기존 저장 문제)' });
    }
  }

  // ── 룰 C: _careerTreeNote 탐색 깊이 ──
  // careerTree가 없고(career_tree_job_links 없음) "적합 인물 없음" 패턴인 경우만 검사
  const ctNote = ucj._careerTreeNote;
  const isNullTree = ctNote && /적합 인물 없음|해당 없음|없음$/.test(ctNote) && !/(등록|선정|추가|INSERT)/.test(ctNote);
  if (isNullTree) {
    const analysis = analyzeCareerTreeNote(ctNote);
    if (!analysis.pass) {
      violations.push({
        rule: 'C',
        field: '_careerTreeNote',
        detail: `후보 ${analysis.candidateCount}명 / 카테고리 ${analysis.categoryCount}/5 커버`,
      });
    }
  }

  return violations;
}

async function main() {
  console.log('═══ 오늘 enhance 9개 직업 룰 A/B/C 전수 감사 ═══\n');

  // 한 번에 조회
  const nameList = TARGET_JOBS.map(n => `'${n}'`).join(', ');
  const rows = queryD1(
    `SELECT name, slug, user_contributed_json FROM jobs WHERE name IN (${nameList}) AND is_active=1`
  );

  const results = [];
  for (const job of rows) {
    const violations = checkJob(job);
    results.push({ name: job.name, violations });
  }

  // 누락된 직업 (DB에 없으면)
  const foundNames = rows.map(r => r.name);
  for (const name of TARGET_JOBS) {
    if (!foundNames.includes(name)) {
      results.push({ name, violations: [{ rule: '?', field: 'DB', detail: 'DB에서 찾을 수 없음' }] });
    }
  }

  // 결과 출력
  let totalViolations = 0;
  let violatingJobs = 0;

  for (const { name, violations } of results) {
    if (violations.length === 0) {
      console.log(`✅ ${name} — 위반 없음`);
    } else {
      console.log(`❌ ${name} — 위반 ${violations.length}건:`);
      for (const v of violations) {
        console.log(`     [룰${v.rule}] ${v.field}: ${v.detail}`);
      }
      totalViolations += violations.length;
      violatingJobs++;
    }
  }

  console.log('\n════════════════════════════════════════');
  console.log(`감사 완료: ${results.length}개 직업 중 ${violatingJobs}개 위반, 총 ${totalViolations}건`);
  if (totalViolations > 0) {
    console.log('\n⚠️  위반 직업은 재enhance 시 FAIL로 걸립니다 (소급 자동 수정 금지).');
    console.log('   우선순위는 사용자가 판단하여 재enhance 일정 결정 필요.');
  }
}

main().catch(console.error);
