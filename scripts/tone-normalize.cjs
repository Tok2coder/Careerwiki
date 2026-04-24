#!/usr/bin/env node
/**
 * tone-normalize.cjs
 *
 * CareerWiki UCJ 경어체 → 평서체(한다/이다체) 일괄 치환 유틸리티.
 *
 * Usage:
 *   node scripts/tone-normalize.cjs              # --dry-run 기본
 *   node scripts/tone-normalize.cjs --dry-run    # 치환 예정 항목만 출력 (쓰기 없음)
 *   node scripts/tone-normalize.cjs --apply      # 실제 UPDATE 실행
 *   node scripts/tone-normalize.cjs --job=간호사  # 특정 직업(slug)만 대상
 *   node scripts/tone-normalize.cjs --field=way  # 특정 필드만 대상 (디버그)
 *
 * 제외:
 *   - _sources 배열 text/url (원문 그대로)
 *   - youtubeLinks title (원제 그대로)
 *   - "..." / 『...』 내부 인용구
 */

'use strict';

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

const DB_NAME = 'careerwiki-kr';
const ROOT_DIR = path.resolve(__dirname, '..');

// ── 치환 맵 (긴 패턴 먼저 — 부분 매칭 방지) ────────────────────────────────
// 각 항목: [from, to]
// 경계 조건: 어미 뒤에 [.!\s\[\n] 또는 문자열 끝이 오는 경우에만 치환
const SUBSTITUTION_MAP = [
  ['하였었습니다', '하였었다'],
  ['하였습니다', '하였다'],
  ['됐습니다', '됐다'],
  ['했습니다', '했다'],
  ['줬습니다', '줬다'],
  ['왔습니다', '왔다'],
  ['갔습니다', '갔다'],
  ['었습니다', '었다'],  // 과거형 catch-all (먹었습니다→먹었다, 읽었습니다→읽었다)
  ['았습니다', '았다'],  // 과거형 catch-all (받았습니다→받았다, 앉았습니다→앉았다)
  ['였습니다', '였다'],
  ['드립니다', '드린다'],
  ['있습니다', '있다'],
  ['없습니다', '없다'],
  ['됩니다', '된다'],
  ['합니다', '한다'],
  ['입니다', '이다'],
];

// ── 서술 필드 목록 (sources / youtubeLinks 제외) ─────────────────────────────
const NARRATIVE_FIELDS = [
  'way',
  'trivia',
  'overviewProspect.main',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
  'overviewSalary.sal',
  'summary',
  'overviewWork.main',
  'overviewAbilities.technKnow',
  'detailReady.curriculum',
  'detailReady.recruit',
  'detailReady.training',
  '_careerTreeNote',
  '_youtubeSearchNote',
];

// ── CLI 파라미터 ──────────────────────────────────────────────────────────────
const args = process.argv.slice(2);
const isDryRun = !args.includes('--apply');
const jobFilter = (args.find(a => a.startsWith('--job=')) || '').replace('--job=', '') || null;
const fieldFilter = (args.find(a => a.startsWith('--field=')) || '').replace('--field=', '') || null;

// ── D1 헬퍼 ──────────────────────────────────────────────────────────────────

function queryD1(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  try {
    const raw = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --command "${escaped}"`,
      { encoding: 'utf8', timeout: 120000, maxBuffer: 100 * 1024 * 1024, cwd: ROOT_DIR }
    );
    const jsonStart = raw.indexOf('[');
    if (jsonStart === -1) throw new Error(`JSON 응답 없음. 출력: ${raw.substring(0, 300)}`);
    const parsed = JSON.parse(raw.substring(jsonStart));
    return parsed[0]?.results || [];
  } catch (e) {
    if (e.message?.startsWith('JSON 응답 없음')) throw e;
    const stdout = (e.stdout || '').substring(0, 300);
    const stderr = (e.stderr || '').substring(0, 300);
    throw new Error(`D1 쿼리 실패: ${e.message}\nstdout: ${stdout}\nstderr: ${stderr}`);
  }
}

function executeD1File(sqlFilePath) {
  try {
    return execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --file "${sqlFilePath}"`,
      { encoding: 'utf8', timeout: 120000, maxBuffer: 10 * 1024 * 1024, cwd: ROOT_DIR }
    );
  } catch (e) {
    const stdout = (e.stdout || '').substring(0, 300);
    const stderr = (e.stderr || '').substring(0, 300);
    throw new Error(`D1 파일 실행 실패: ${e.message}\nstdout: ${stdout}\nstderr: ${stderr}`);
  }
}

// ── 텍스트 정규화 ─────────────────────────────────────────────────────────────

/**
 * 단일 문자열에 경어체 → 평서체 치환 적용.
 * 인용구("..." / 『...』) 내부는 보호.
 * @returns {{ changed: boolean, result: string }}
 */
function applySubstitutions(text) {
  if (typeof text !== 'string' || !text.trim()) return { changed: false, result: text };

  // 1. 인용구 보호
  const protectedRegions = [];
  let temp = text
    .replace(/"([^"]{0,300})"/g, (m) => {
      protectedRegions.push(m);
      return `\x00Q${protectedRegions.length - 1}\x00`;
    })
    .replace(/『([^』]{0,300})』/g, (m) => {
      protectedRegions.push(m);
      return `\x00Q${protectedRegions.length - 1}\x00`;
    });

  // 2. 치환 (문장 경계에서만: 마침표/공백/각주마커/줄바꿈/문자열끝 앞)
  let changed = false;
  for (const [from, to] of SUBSTITUTION_MAP) {
    const re = new RegExp(from + '(?=[.!\\s\\[\\n]|$)', 'g');
    const next = temp.replace(re, to);
    if (next !== temp) {
      changed = true;
      temp = next;
    }
  }

  // 3. 인용구 복원
  temp = temp.replace(/\x00Q(\d+)\x00/g, (_, i) => protectedRegions[parseInt(i)]);

  return { changed, result: temp };
}

// ── 문법 깨짐 탐지 ────────────────────────────────────────────────────────────

function detectGrammarBreaks(normalized) {
  const issues = [];

  // (1) 이다이다 — 치환 중복 산출물
  if (/이다이다/.test(normalized)) {
    issues.push(`"이다이다" 연속 패턴 발견`);
  }

  // (2) 문장 내 종결형 "이다" 2회 이상 (단, 이다음/이다지 같은 복합어 제외)
  const sentences = normalized.split(/(?<=[.!?])\s+/).filter(s => s.trim());
  for (const sentence of sentences) {
    // 문장 종결 위치 "이다" 패턴만 카운트 (뒤에 비한글이 오거나 끝인 경우)
    const endingMatches = sentence.match(/이다(?=[.!\s\[\n]|$)/g) || [];
    if (endingMatches.length >= 2) {
      issues.push(`문장 내 "이다" 종결 ${endingMatches.length}회: "${sentence.substring(0, 60).trim()}"`);
    }
  }

  // (3) 전체 텍스트가 이상한 조사/어미로 끝나는 경우
  const stripped = normalized.replace(/(\s*(\[\d+\])*\s*)$/, '').trim();
  if (stripped && !/[.!?)\]다]$/.test(stripped)) {
    issues.push(`비정상 종결: "...${stripped.slice(-20)}"`);
  }

  return issues;
}

// ── 중첩 객체 경로 접근 ───────────────────────────────────────────────────────

function getNestedValue(obj, fieldPath) {
  const parts = fieldPath.split('.');
  let cur = obj;
  for (const p of parts) {
    if (cur == null || typeof cur !== 'object') return undefined;
    cur = cur[p];
  }
  return cur;
}

function setNestedValue(obj, fieldPath, value) {
  const parts = fieldPath.split('.');
  let cur = obj;
  for (let i = 0; i < parts.length - 1; i++) {
    if (cur[parts[i]] == null || typeof cur[parts[i]] !== 'object') cur[parts[i]] = {};
    cur = cur[parts[i]];
  }
  cur[parts[parts.length - 1]] = value;
}

// ── 직업 처리 ─────────────────────────────────────────────────────────────────

function processJob(job) {
  const { id, name, slug, user_contributed_json } = job;
  if (!user_contributed_json) return null;

  let ucj;
  try {
    ucj = JSON.parse(user_contributed_json);
  } catch {
    return null;
  }

  const fieldResults = [];
  const fields = fieldFilter
    ? NARRATIVE_FIELDS.filter(f => f === fieldFilter || f.startsWith(fieldFilter + '.'))
    : NARRATIVE_FIELDS;

  const updatedUcj = JSON.parse(JSON.stringify(ucj));

  for (const fieldPath of fields) {
    const value = getNestedValue(ucj, fieldPath);
    if (value == null) continue;

    if (Array.isArray(value)) {
      // string[] 필드
      let arrChanged = false;
      const newArr = value.map((item, idx) => {
        if (typeof item !== 'string') return item;
        const { changed, result } = applySubstitutions(item);
        if (changed) {
          arrChanged = true;
          fieldResults.push({
            fieldPath: `${fieldPath}[${idx}]`,
            before: item,
            after: result,
            grammarIssues: detectGrammarBreaks(result),
          });
        }
        return result;
      });
      if (arrChanged) setNestedValue(updatedUcj, fieldPath, newArr);
    } else if (typeof value === 'string') {
      const { changed, result } = applySubstitutions(value);
      if (changed) {
        fieldResults.push({
          fieldPath,
          before: value,
          after: result,
          grammarIssues: detectGrammarBreaks(result),
        });
        setNestedValue(updatedUcj, fieldPath, result);
      }
    }
  }

  if (fieldResults.length === 0) return null;
  return { id, name, slug, fieldResults, updatedUcj };
}

// ── 메인 ─────────────────────────────────────────────────────────────────────

function main() {
  console.log(`\n${'='.repeat(60)}`);
  console.log(`tone-normalize.cjs`);
  console.log(`모드: ${isDryRun ? 'DRY-RUN (실제 변경 없음)' : 'APPLY (실제 UPDATE 실행)'}`);
  if (jobFilter) console.log(`직업 필터: ${jobFilter}`);
  if (fieldFilter) console.log(`필드 필터: ${fieldFilter}`);
  console.log(`${'='.repeat(60)}\n`);

  // 1. 직업 목록 조회
  const escapedSlug = jobFilter ? jobFilter.replace(/'/g, "''") : '';
  const whereClause = jobFilter
    ? `WHERE is_active=1 AND slug='${escapedSlug}'`
    : `WHERE is_active=1 AND user_contributed_json IS NOT NULL AND user_contributed_json != '' AND user_contributed_json != 'null'`;

  console.log('D1에서 직업 데이터 로딩 중...');
  const jobs = queryD1(
    `SELECT id, name, slug, user_contributed_json FROM jobs ${whereClause} ORDER BY id`
  );
  console.log(`조회된 직업: ${jobs.length}개\n`);

  // 2. 처리
  const results = [];
  for (const job of jobs) {
    const result = processJob(job);
    if (result) results.push(result);
  }

  // 3. 통계
  const totalJobs = results.length;
  const totalChanges = results.reduce((sum, r) => sum + r.fieldResults.length, 0);
  const allChanges = results.flatMap(r => r.fieldResults.map(f => ({ jobName: r.name, jobSlug: r.slug, ...f })));
  const flaggedChanges = allChanges.filter(f => f.grammarIssues.length > 0);

  const fieldDist = {};
  for (const c of allChanges) {
    const key = c.fieldPath.replace(/\[\d+\]$/, '[]');
    fieldDist[key] = (fieldDist[key] || 0) + 1;
  }

  // 4. 리포트
  console.log(`대상 직업 수: ${totalJobs}개  /  총 변경 건수: ${totalChanges}건`);
  console.log('');

  console.log('[ 필드별 분포 ]');
  const sortedFields = Object.entries(fieldDist).sort((a, b) => b[1] - a[1]);
  for (const [field, count] of sortedFields) {
    console.log(`  ${field.padEnd(40)} ${count}건`);
  }
  console.log('');

  console.log(`[ Before → After 샘플 (최대 10건 / 총 ${allChanges.length}건) ]`);
  const samples = allChanges.slice(0, 10);
  for (const s of samples) {
    console.log(`  직업: ${s.jobName} / 필드: ${s.fieldPath}`);
    const b = s.before.replace(/\n/g, '↵');
    const a = s.after.replace(/\n/g, '↵');
    console.log(`    BEFORE: ${b.substring(0, 100)}${b.length > 100 ? '...' : ''}`);
    console.log(`    AFTER:  ${a.substring(0, 100)}${a.length > 100 ? '...' : ''}`);
    console.log('');
  }

  if (flaggedChanges.length > 0) {
    console.log(`[ 문법 깨짐 FLAG — ${flaggedChanges.length}건 (별도 검토 필요) ]`);
    for (const f of flaggedChanges) {
      console.log(`  직업: ${f.jobName} (${f.jobSlug}) / 필드: ${f.fieldPath}`);
      for (const issue of f.grammarIssues) {
        console.log(`    ! ${issue}`);
      }
    }
    console.log('');
  } else {
    console.log(`[ 문법 깨짐 FLAG: 0건 ]\n`);
  }

  // 5. APPLY
  if (!isDryRun) {
    if (results.length === 0) {
      console.log('변경 대상 없음. 종료.');
      return;
    }

    console.log(`APPLY 모드: ${totalJobs}개 직업 업데이트 시작...\n`);
    let successCount = 0;
    let failCount = 0;

    for (const r of results) {
      const tmpFile = path.join(os.tmpdir(), `tone-normalize-${r.id}.sql`);
      try {
        const newJson = JSON.stringify(r.updatedUcj);
        const escapedJson = newJson.replace(/'/g, "''");
        const sql = `UPDATE jobs SET user_contributed_json = '${escapedJson}', user_last_updated_at = datetime('now') WHERE id = ${r.id};`;
        fs.writeFileSync(tmpFile, sql, 'utf8');
        executeD1File(tmpFile);
        console.log(`  ✅ ${r.name} (id=${r.id}) — ${r.fieldResults.length}개 필드`);
        successCount++;
      } catch (err) {
        console.log(`  ❌ ${r.name} (id=${r.id}) — ${err.message.substring(0, 100)}`);
        failCount++;
      } finally {
        if (fs.existsSync(tmpFile)) fs.unlinkSync(tmpFile);
      }
    }

    console.log(`\nAPPLY 완료: 성공 ${successCount}건 / 실패 ${failCount}건`);
  } else {
    console.log(`${'─'.repeat(60)}`);
    console.log(`[DRY-RUN] 위 내용이 --apply 시 실제 적용됩니다.`);
    console.log(`실제 적용: node scripts/tone-normalize.cjs --apply`);
  }
}

main();
