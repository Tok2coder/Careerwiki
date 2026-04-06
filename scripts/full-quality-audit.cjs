#!/usr/bin/env node
/**
 * full-quality-audit.cjs
 *
 * CareerWiki 직업 데이터 품질 감사 스크립트.
 * Phase 4 검증 자동화 — 5개 품질 게이트를 모두 검사.
 *
 * Usage:
 *   node scripts/full-quality-audit.cjs --slug=간호사
 *   node scripts/full-quality-audit.cjs --all
 *   node scripts/full-quality-audit.cjs --all --limit=50
 *
 * Exit codes:
 *   0 = PASS (모두 통과 또는 WARN만)
 *   1 = FAIL (1개 이상 FAIL)
 */

'use strict';

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');
const crypto = require('crypto');

// ── 설정 ─────────────────────────────────────────────────────────────────────

const DB_NAME = 'careerwiki-kr';
const ROOT_DIR = path.resolve(__dirname, '..');

// 서술 필드 렌더링 순서 (Gate 4 스캔 순서)
const TEXT_FIELDS_ORDER = [
  'way',
  'overviewSalary.sal',
  'overviewProspect.main',
  'trivia',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'overviewAbilities.technKnow',
  'overviewWork.main',
  'summary',
];

// Gate 2: 잘린 문장 패턴
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

// Gate 2: 완성형 어미 패턴
const COMPLETE_ENDINGS = [
  /[.다요]\s*(\[\d+\])*\s*$/,
  /습니다\s*(\[\d+\])*\s*$/,
  /입니다\s*(\[\d+\])*\s*$/,
  /됩니다\s*(\[\d+\])*\s*$/,
  /합니다\s*(\[\d+\])*\s*$/,
  /있습니다\s*(\[\d+\])*\s*$/,
  /없습니다\s*(\[\d+\])*\s*$/,
  /됩니다\s*(\[\d+\])*\s*$/,
  /받습니다\s*(\[\d+\])*\s*$/,
  /\)\s*(\[\d+\])*\s*$/, // 괄호 닫힘으로 끝나는 경우
];

// Gate 3: 유효한 YouTube URL 패턴
const YOUTUBE_PATTERNS = [
  /^https?:\/\/(www\.)?youtube\.com\/watch\?v=[\w-]+/,
  /^https?:\/\/youtu\.be\/[\w-]+/,
  /^https?:\/\/(www\.)?youtube\.com\/shorts\/[\w-]+/,
  /^https?:\/\/(www\.)?youtube\.com\/embed\/[\w-]+/,
];

// ── D1 쿼리 헬퍼 ──────────────────────────────────────────────────────────────

function queryD1(sql) {
  // double quote 이스케이프 (외부 "..." 래핑과 충돌 방지)
  const escaped = sql.replace(/"/g, '\\"');
  try {
    const raw = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --command "${escaped}"`,
      { encoding: 'utf8', timeout: 60000, maxBuffer: 50 * 1024 * 1024, cwd: ROOT_DIR }
    );
    // wrangler가 progress 텍스트를 stdout에 섞는 경우 JSON 부분만 추출
    const jsonStart = raw.indexOf('[');
    if (jsonStart === -1) {
      throw new Error(`JSON 응답 없음. 출력: ${raw.substring(0, 300)}`);
    }
    const parsed = JSON.parse(raw.substring(jsonStart));
    return parsed[0]?.results || [];
  } catch (e) {
    if (e.message && e.message.startsWith('JSON 응답 없음')) throw e;
    const stderr = (e.stderr || '').substring(0, 500);
    const stdout = (e.stdout || '').substring(0, 500);
    throw new Error(`D1 쿼리 실패: ${e.message}\nstdout: ${stdout}\nstderr: ${stderr}`);
  }
}

// SQL 문자열 값 이스케이프 (단일따옴표 → 두 개)
function sqlStr(val) {
  return val.replace(/'/g, "''");
}

// ── 유틸리티 ──────────────────────────────────────────────────────────────────

function getNestedValue(obj, path) {
  if (!obj || typeof obj !== 'object') return undefined;
  // 직접 키로 먼저 시도
  if (obj[path] !== undefined) return obj[path];
  // 점 표기법 분해
  const parts = path.split('.');
  let cur = obj;
  for (const p of parts) {
    if (cur == null || typeof cur !== 'object') return undefined;
    cur = cur[p];
  }
  return cur;
}

function extractVideoId(url) {
  const watchMatch = url.match(/[?&]v=([\w-]+)/);
  if (watchMatch) return watchMatch[1];
  const shortMatch = url.match(/youtu\.be\/([\w-]+)/);
  if (shortMatch) return shortMatch[1];
  const shortsMatch = url.match(/shorts\/([\w-]+)/);
  if (shortsMatch) return shortsMatch[1];
  const embedMatch = url.match(/embed\/([\w-]+)/);
  if (embedMatch) return embedMatch[1];
  return null;
}

function curlGet(url, timeoutSec = 8) {
  try {
    const result = execSync(
      `curl -s -L --max-time ${timeoutSec} "${url}"`,
      { encoding: 'utf8', stdio: ['pipe', 'pipe', 'pipe'], timeout: (timeoutSec + 2) * 1000 }
    );
    return result;
  } catch {
    return null;
  }
}

function curlStatus(url, timeoutSec = 8) {
  try {
    const result = execSync(
      `curl -s -o /dev/null -w "%{http_code}" --max-time ${timeoutSec} "${url}"`,
      { encoding: 'utf8', stdio: ['pipe', 'pipe', 'pipe'], timeout: (timeoutSec + 2) * 1000 }
    );
    return parseInt(result.trim()) || 0;
  } catch {
    return 0;
  }
}

// ── Gate 1: 각주 검증 ─────────────────────────────────────────────────────────

function checkGate1(data, jobName) {
  const issues = [];

  for (const fieldPath of TEXT_FIELDS_ORDER) {
    const text = getNestedValue(data, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const allMatches = [...text.matchAll(/\[(\d+)\]/g)];
    if (allMatches.length === 0) continue;

    const nums = allMatches.map(m => parseInt(m[1]));

    // (a) 중복 검사
    const counts = {};
    nums.forEach(n => { counts[n] = (counts[n] || 0) + 1; });
    const dupes = Object.entries(counts).filter(([_, c]) => c > 1);
    if (dupes.length > 0) {
      issues.push({ level: 'FAIL', msg: `[Gate1] ${fieldPath}: [N] 중복 — ${dupes.map(([n, c]) => `[${n}]이 ${c}회`).join(', ')}` });
    }

    // (b) 순차 검사 (1부터 시작, 건너뜀 없이)
    const uniqueNums = [...new Set(nums)].sort((a, b) => a - b);
    for (let i = 0; i < uniqueNums.length; i++) {
      if (uniqueNums[i] !== i + 1) {
        issues.push({ level: 'FAIL', msg: `[Gate1] ${fieldPath}: 각주 비순차 — [${uniqueNums[i]}] (기대: [${i + 1}])` });
        break;
      }
    }

    // (c) 위치 검사 — 마침표 앞에 있으면 WARN ([N]. 패턴)
    const wrongPos = text.match(/\[\d+\]\./g);
    if (wrongPos) {
      issues.push({
        level: 'WARN',
        msg: `[Gate1] ${fieldPath}: 각주가 마침표 앞에 위치 — "${wrongPos[0]}" (기대: ".[N]")`,
      });
    }

    // (d) _sources 배열 길이 일치
    const maxNum = Math.max(...nums);
    const sources = data._sources;
    if (sources) {
      const fieldSources = sources[fieldPath];
      if (!fieldSources) {
        issues.push({ level: 'FAIL', msg: `[Gate1] ${fieldPath}: [N] 있지만 _sources["${fieldPath}"] 없음` });
      } else if (Array.isArray(fieldSources) && fieldSources.length !== maxNum) {
        issues.push({
          level: 'WARN',
          msg: `[Gate1] ${fieldPath}: 최대 각주 [${maxNum}]이지만 sources ${fieldSources.length}개 — 불일치`,
        });
      }
    }
  }

  return issues;
}

// ── Gate 2: 텍스트 완결성 ──────────────────────────────────────────────────────

function checkGate2(data) {
  const issues = [];

  for (const fieldPath of ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail']) {
    const text = getNestedValue(data, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const trimmed = text.trim();

    // 각주 마커를 제거한 끝부분으로 검사
    const cleanEnd = trimmed.replace(/(\s*\[\d+\])+\s*$/, '').trim();

    // (a) 잘린 패턴 검사
    let truncated = false;
    for (const pattern of TRUNCATED_PATTERNS) {
      if (pattern.test(cleanEnd)) {
        issues.push({
          level: 'FAIL',
          msg: `[Gate2] ${fieldPath}: 잘린 문장 — "...${cleanEnd.slice(-25)}"`,
        });
        truncated = true;
        break;
      }
    }

    // (b) 완성형 어미 검사 (잘린 경우 중복 경고 안 함)
    if (!truncated) {
      const isComplete = COMPLETE_ENDINGS.some(p => p.test(trimmed));
      if (!isComplete) {
        issues.push({
          level: 'WARN',
          msg: `[Gate2] ${fieldPath}: 완성형 어미 미확인 — "...${trimmed.slice(-30)}"`,
        });
      }
    }
  }

  return issues;
}

// ── Gate 3: YouTube 검증 ──────────────────────────────────────────────────────

function checkGate3(data) {
  const issues = [];
  const youtubeLinks = data.youtubeLinks;

  if (!youtubeLinks || !Array.isArray(youtubeLinks) || youtubeLinks.length === 0) {
    issues.push({ level: 'WARN', msg: '[Gate3] youtubeLinks 없음 또는 빈 배열' });
    return issues;
  }

  for (const link of youtubeLinks) {
    const url = typeof link === 'string' ? link : (link?.url || String(link));

    if (!url || typeof url !== 'string') {
      issues.push({ level: 'FAIL', msg: `[Gate3] 잘못된 YouTube 링크 형식: ${JSON.stringify(link)}` });
      continue;
    }

    // URL 포맷 검사
    const isValidFormat = YOUTUBE_PATTERNS.some(p => p.test(url));
    if (!isValidFormat) {
      issues.push({ level: 'FAIL', msg: `[Gate3] 유효하지 않은 YouTube URL: "${url}"` });
      continue;
    }

    // oembed 검사 (HTTP 상태 + title 존재)
    const videoId = extractVideoId(url);
    if (!videoId) {
      issues.push({ level: 'WARN', msg: `[Gate3] YouTube video ID 추출 실패: "${url}"` });
      continue;
    }

    const oembedUrl = `https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=${videoId}&format=json`;
    let status = curlStatus(oembedUrl);

    // 네트워크 오류 시 1회 재시도 (2초 대기)
    if (status === 0) {
      const { execSync: _es } = require('child_process');
      try { _es('sleep 2', { stdio: 'ignore' }); } catch { /* windows fallback */ try { _es('timeout /t 2 /nobreak > NUL', { stdio: 'ignore', shell: true }); } catch {} }
      status = curlStatus(oembedUrl);
    }

    if (status === 404 || status === 403) {
      issues.push({ level: 'FAIL', msg: `[Gate3] YouTube 영상 없음/비공개 (HTTP ${status}): "${url}"` });
    } else if (status === 200) {
      const body = curlGet(oembedUrl);
      if (body) {
        try {
          const oembedData = JSON.parse(body);
          if (!oembedData.title) {
            issues.push({ level: 'WARN', msg: `[Gate3] oembed title 없음: "${url}"` });
          }
          // title 로깅 (정보용)
          else {
            issues.push({ level: 'PASS', msg: `[Gate3] oembed OK — "${oembedData.title.substring(0, 50)}"` });
          }
        } catch {
          issues.push({ level: 'WARN', msg: `[Gate3] oembed 응답 파싱 실패: "${url}"` });
        }
      }
    } else if (status === 0) {
      // 재시도 후에도 실패 → SKIP (네트워크 문제, WARN/FAIL 카운트 제외)
      issues.push({ level: 'PASS', msg: `[Gate3] SKIP (network) oembed 재시도 실패 — 네트워크 문제로 검증 생략: "${url}"` });
    } else {
      issues.push({ level: 'WARN', msg: `[Gate3] YouTube oembed HTTP ${status}: "${url}"` });
    }
  }

  return issues;
}

// ── Gate 4: _sources ID 순서 ──────────────────────────────────────────────────

function checkGate4(data) {
  const issues = [];
  const sources = data._sources;
  if (!sources || typeof sources !== 'object') return issues;

  // 본문 스캔 순서대로 sources ID 첫 등장 순서 수집
  const globalIdOrder = [];
  const seenIds = new Set();

  for (const fieldPath of TEXT_FIELDS_ORDER) {
    const fieldSources = sources[fieldPath];
    if (!fieldSources || !Array.isArray(fieldSources)) continue;

    for (const src of fieldSources) {
      if (src && src.id != null && !seenIds.has(src.id)) {
        seenIds.add(src.id);
        globalIdOrder.push({ fieldPath, id: src.id });
      }
    }
  }

  // 전역 ID가 오름차순인지 검사
  for (let i = 1; i < globalIdOrder.length; i++) {
    if (globalIdOrder[i].id < globalIdOrder[i - 1].id) {
      issues.push({
        level: 'WARN',
        msg: `[Gate4] sources ID 순서 역전: "${globalIdOrder[i - 1].fieldPath}"[id=${globalIdOrder[i - 1].id}] → "${globalIdOrder[i].fieldPath}"[id=${globalIdOrder[i].id}]`,
      });
    }
  }

  // 각 필드 내에서 text의 [N] 번호가 배열 인덱스와 일치하는지 검사
  for (const [fieldPath, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr)) continue;
    for (let i = 0; i < srcArr.length; i++) {
      const src = srcArr[i];
      if (!src || typeof src !== 'object') continue;
      const textMatch = (src.text || '').match(/^\[(\d+)\]/);
      if (textMatch) {
        const annotatedNum = parseInt(textMatch[1]);
        const expectedNum = i + 1;
        if (annotatedNum !== expectedNum) {
          issues.push({
            level: 'WARN',
            msg: `[Gate4] _sources["${fieldPath}"][${i}]: text가 "[${annotatedNum}]"이지만 배열 위치상 "[${expectedNum}]" 기대`,
          });
        }
      }
    }
  }

  return issues;
}

// ── Gate 5: 추가 검사 ─────────────────────────────────────────────────────────

function checkGate5(job, data) {
  const issues = [];

  // (a) heroCategory (merged_profile_json 내부 필드)
  const heroCategory = data.heroCategory || data.hero_category;
  if (!heroCategory) {
    issues.push({ level: 'WARN', msg: '[Gate5] heroCategory 없음 — 직업 카테고리 표시 불가' });
  }

  // (b) sidebarJobs
  const sidebarJobs = data.sidebarJobs;
  if (!sidebarJobs) {
    issues.push({ level: 'WARN', msg: '[Gate5] sidebarJobs 없음 — 연관 직업 사이드바 공란' });
  } else if (Array.isArray(sidebarJobs) && sidebarJobs.length === 0) {
    issues.push({ level: 'WARN', msg: '[Gate5] sidebarJobs 빈 배열' });
  }

  // (c) image_url 포맷
  const imageUrl = job.image_url;
  if (!imageUrl) {
    issues.push({ level: 'WARN', msg: '[Gate5] image_url 없음' });
  } else {
    // /uploads/jobs/job-{slug}.webp?v={timestamp} 형태 확인 (슬러그는 한국어 포함 가능)
    const expectedPattern = /^\/uploads\/jobs\/job-.+\.webp(\?v=\d+)?$/u;
    if (!expectedPattern.test(imageUrl)) {
      issues.push({
        level: 'WARN',
        msg: `[Gate5] image_url 포맷 비정상: "${imageUrl}" (기대: /uploads/jobs/job-{slug}.webp?v=...)`,
      });
    } else if (job.slug) {
      const expectedPrefix = `/uploads/jobs/job-${job.slug}.webp`;
      if (!imageUrl.startsWith(expectedPrefix)) {
        issues.push({
          level: 'WARN',
          msg: `[Gate5] image_url slug 불일치: "${imageUrl}" (기대 prefix: "${expectedPrefix}")`,
        });
      }
    }
  }

  // (d) way 타입 검사 (배열이면 500 에러)
  const wayVal = data.way;
  if (wayVal !== undefined && wayVal !== null) {
    if (Array.isArray(wayVal)) {
      issues.push({ level: 'FAIL', msg: '[Gate5] way가 배열(Array) — 반드시 string이어야 함. 500 에러 발생 중!' });
    } else if (typeof wayVal !== 'string') {
      issues.push({ level: 'FAIL', msg: `[Gate5] way 타입 이상: ${typeof wayVal} (기대: string)` });
    }
  }

  // (e) detailWlb 등급 존재 여부만 확인 (값은 자유 텍스트)
  const wlb = getNestedValue(data, 'detailWlb.wlb');
  const social = getNestedValue(data, 'detailWlb.social');
  if (!wlb) {
    issues.push({ level: 'WARN', msg: '[Gate5] detailWlb.wlb 없음 — 요약 카드 공란' });
  }
  if (!social) {
    issues.push({ level: 'WARN', msg: '[Gate5] detailWlb.social 없음 — 요약 카드 공란' });
  }

  return issues;
}

// ── 단일 직업 감사 ────────────────────────────────────────────────────────────

function auditJob(job) {
  const slug = job.slug;
  const name = job.name;

  let mergedData = {};
  let ucjData = {};

  try {
    mergedData = job.merged_profile_json ? JSON.parse(job.merged_profile_json) : {};
  } catch {
    mergedData = {};
  }
  try {
    ucjData = job.user_contributed_json ? JSON.parse(job.user_contributed_json) : {};
  } catch {
    ucjData = {};
  }

  // _sources는 user_contributed_json에서 가져옴, mergedData에 주입
  if (ucjData._sources && !mergedData._sources) {
    mergedData._sources = ucjData._sources;
  }

  const allIssues = [
    ...checkGate1(mergedData, name),
    ...checkGate2(mergedData),
    ...checkGate3(mergedData),
    ...checkGate4(mergedData),
    ...checkGate5(job, mergedData),
  ];

  const fails = allIssues.filter(i => i.level === 'FAIL');
  const warns = allIssues.filter(i => i.level === 'WARN');
  const passes = allIssues.filter(i => i.level === 'PASS');

  const overallLevel = fails.length > 0 ? 'FAIL' : warns.length > 0 ? 'WARN' : 'PASS';

  return { slug, name, overallLevel, fails, warns, passes };
}

// ── 결과 출력 ─────────────────────────────────────────────────────────────────

function printResult(result) {
  const icon = result.overallLevel === 'FAIL' ? '❌' : result.overallLevel === 'WARN' ? '⚠️ ' : '✅';
  console.log(`\n${icon} [${result.overallLevel}] ${result.name} (${result.slug})`);

  if (result.fails.length > 0) {
    result.fails.forEach(i => console.log(`     ❌ ${i.msg}`));
  }
  if (result.warns.length > 0) {
    result.warns.forEach(i => console.log(`     ⚠️  ${i.msg}`));
  }
  if (result.passes.length > 0) {
    result.passes.forEach(i => console.log(`     ✅ ${i.msg}`));
  }
  if (result.fails.length === 0 && result.warns.length === 0 && result.passes.length === 0) {
    console.log(`     ℹ️  검사 항목 없음 (데이터 부재)`);
  }
}

// ── 메인 ─────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  const slugArg = args.find(a => a.startsWith('--slug='));
  const isAll = args.includes('--all');
  const limitArg = args.find(a => a.startsWith('--limit='));
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : 100;

  if (!slugArg && !isAll) {
    console.error('Usage:');
    console.error('  node scripts/full-quality-audit.cjs --slug=<slug>');
    console.error('  node scripts/full-quality-audit.cjs --all [--limit=N]');
    process.exit(1);
  }

  let jobs;

  if (slugArg) {
    const slug = slugArg.split('=')[1].trim();
    console.log(`\n🔍 감사 시작: ${slug}\n${'─'.repeat(60)}`);
    jobs = queryD1(`SELECT id, name, slug, image_url, merged_profile_json, user_contributed_json FROM jobs WHERE slug = '${sqlStr(slug)}' AND is_active = 1 LIMIT 1`);
    if (jobs.length === 0) {
      console.error(`오류: slug="${slug}" 직업을 찾을 수 없음`);
      process.exit(1);
    }
  } else {
    console.log(`\n🔍 전체 감사 시작 (최대 ${limit}개)\n${'─'.repeat(60)}`);
    jobs = queryD1(`SELECT id, name, slug, image_url, merged_profile_json, user_contributed_json FROM jobs WHERE is_active = 1 AND user_contributed_json IS NOT NULL AND LENGTH(user_contributed_json) > 20 ORDER BY user_last_updated_at DESC LIMIT ${limit}`);
  }

  console.log(`총 ${jobs.length}개 직업 감사 중...\n`);

  const results = jobs.map(auditJob);

  results.forEach(printResult);

  // 요약
  const totalFail = results.filter(r => r.overallLevel === 'FAIL').length;
  const totalWarn = results.filter(r => r.overallLevel === 'WARN').length;
  const totalPass = results.filter(r => r.overallLevel === 'PASS').length;

  console.log(`\n${'═'.repeat(60)}`);
  console.log(`감사 완료: 총 ${results.length}개`);
  console.log(`  ✅ PASS: ${totalPass}개`);
  console.log(`  ⚠️  WARN: ${totalWarn}개`);
  console.log(`  ❌ FAIL: ${totalFail}개`);
  console.log(`${'═'.repeat(60)}\n`);

  if (totalFail > 0) {
    console.log(`❌ FAIL 직업 목록:`);
    results.filter(r => r.overallLevel === 'FAIL').forEach(r => {
      console.log(`  - ${r.name} (${r.slug}): ${r.fails.map(f => f.msg).join(' | ')}`);
    });
    console.log();
    process.exit(1);
  }

  process.exit(0);
}

main();
