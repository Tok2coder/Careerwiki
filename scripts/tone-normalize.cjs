#!/usr/bin/env node
/**
 * tone-normalize.cjs
 *
 * CareerWiki 경어체 → 평서체(한다/이다체) 일괄 치환 유틸리티.
 *
 * Usage:
 *   node scripts/tone-normalize.cjs                        # --dry-run 기본
 *   node scripts/tone-normalize.cjs --dry-run              # 치환 예정 항목만 출력 (쓰기 없음)
 *   node scripts/tone-normalize.cjs --apply                # 실제 UPDATE 실행
 *   node scripts/tone-normalize.cjs --targets=ucj          # UCJ만 (기존 동작)
 *   node scripts/tone-normalize.cjs --targets=merged       # merged_profile_json만
 *   node scripts/tone-normalize.cjs --targets=both         # 양쪽 (기본값)
 *   node scripts/tone-normalize.cjs --job=간호사            # 특정 직업(slug)만 대상
 *   node scripts/tone-normalize.cjs --field=way            # 특정 필드만 대상 (디버그)
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
  ['났습니다', '났다'],  // 과거형 ㄴ받침 변형 (나타났습니다→나타났다, 일어났습니다→일어났다)
  // 형용사 어간 + 습니다 → 다
  ['많습니다', '많다'],
  ['않습니다', '않다'],
  ['어렵습니다', '어렵다'],
  ['잦습니다', '잦다'],
  ['높습니다', '높다'],
  ['낮습니다', '낮다'],
  ['좋습니다', '좋다'],
  ['싫습니다', '싫다'],
  ['쉽습니다', '쉽다'],
  // 동사 어간 + 습니다 → 는다
  ['받습니다', '받는다'],
  ['얻습니다', '얻는다'],
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
const targetsArg = (args.find(a => a.startsWith('--targets=')) || '').replace('--targets=', '') || 'both';

const doUcj = targetsArg === 'ucj' || targetsArg === 'both';
const doMerged = targetsArg === 'merged' || targetsArg === 'both';

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

/**
 * merged_profile_json처럼 응답이 큰 컬럼을 LIMIT/OFFSET 배치로 조회.
 * @param {string} baseSelect  - "SELECT id, name, slug, merged_profile_json FROM jobs"
 * @param {string} where       - "WHERE is_active=1 AND ..."
 * @param {string} orderBy     - "ORDER BY id"
 * @param {number} batchSize
 */
function sleep(ms) {
  const start = Date.now();
  while (Date.now() - start < ms) { /* busy-wait (sync) */ }
}

function queryD1WithRetry(sql, retries = 3) {
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      return queryD1(sql);
    } catch (e) {
      if (attempt === retries) throw e;
      const delay = attempt * 3000;
      process.stdout.write(`\n  재시도 ${attempt}/${retries - 1} (${delay / 1000}s 대기)...`);
      sleep(delay);
    }
  }
}

function queryD1Paginated(baseSelect, where, orderBy, batchSize = 150) {
  const allRows = [];
  let offset = 0;
  while (true) {
    const sql = `${baseSelect} ${where} ${orderBy} LIMIT ${batchSize} OFFSET ${offset}`;
    const rows = queryD1WithRetry(sql);
    if (!rows || rows.length === 0) break;
    allRows.push(...rows);
    if (rows.length < batchSize) break;
    offset += batchSize;
    process.stdout.write(`\r  배치 로딩: ${allRows.length}개 완료...`);
    // 연속 API 호출 간 짧은 지연으로 rate limit 방지
    sleep(300);
  }
  if (allRows.length > 0) process.stdout.write('\n');
  return allRows;
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

// ── JSON 컬럼 처리 (UCJ 또는 merged_profile_json 공용) ───────────────────────

/**
 * @param {object} job  D1 row
 * @param {'user_contributed_json'|'merged_profile_json'} columnName
 */
function processJsonColumn(job, columnName) {
  const { id, name, slug } = job;
  const jsonStr = job[columnName];
  if (!jsonStr || jsonStr === 'null') return null;

  let parsed;
  try {
    parsed = JSON.parse(jsonStr);
  } catch {
    return null;
  }

  const fieldResults = [];
  const fields = fieldFilter
    ? NARRATIVE_FIELDS.filter(f => f === fieldFilter || f.startsWith(fieldFilter + '.'))
    : NARRATIVE_FIELDS;

  const updated = JSON.parse(JSON.stringify(parsed));

  for (const fieldPath of fields) {
    const value = getNestedValue(parsed, fieldPath);
    if (value == null) continue;

    if (Array.isArray(value)) {
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
      if (arrChanged) setNestedValue(updated, fieldPath, newArr);
    } else if (typeof value === 'string') {
      const { changed, result } = applySubstitutions(value);
      if (changed) {
        fieldResults.push({
          fieldPath,
          before: value,
          after: result,
          grammarIssues: detectGrammarBreaks(result),
        });
        setNestedValue(updated, fieldPath, result);
      }
    }
  }

  if (fieldResults.length === 0) return null;
  return { id, name, slug, columnName, fieldResults, updated };
}

// 기존 호환 래퍼
function processJob(job) {
  return processJsonColumn(job, 'user_contributed_json');
}

// ── 리포트 출력 헬퍼 ─────────────────────────────────────────────────────────

function printReport(label, results) {
  const totalJobs = results.length;
  const allChanges = results.flatMap(r =>
    r.fieldResults.map(f => ({ jobName: r.name, jobSlug: r.slug, ...f }))
  );
  const totalChanges = allChanges.length;
  const flaggedChanges = allChanges.filter(f => f.grammarIssues.length > 0);

  const fieldDist = {};
  for (const c of allChanges) {
    const key = c.fieldPath.replace(/\[\d+\]$/, '[]');
    fieldDist[key] = (fieldDist[key] || 0) + 1;
  }

  console.log(`\n${'─'.repeat(60)}`);
  console.log(`[ ${label} ] 대상 직업: ${totalJobs}개  /  총 변경: ${totalChanges}건`);

  if (totalChanges > 0) {
    console.log('\n  [ 필드별 분포 ]');
    const sortedFields = Object.entries(fieldDist).sort((a, b) => b[1] - a[1]).slice(0, 8);
    for (const [field, count] of sortedFields) {
      console.log(`    ${field.padEnd(40)} ${count}건`);
    }

    console.log(`\n  [ Before → After 샘플 (최대 5건) ]`);
    for (const s of allChanges.slice(0, 5)) {
      console.log(`  직업: ${s.jobName} / 필드: ${s.fieldPath}`);
      const b = s.before.replace(/\n/g, '↵');
      const a = s.after.replace(/\n/g, '↵');
      console.log(`    BEFORE: ${b.substring(0, 100)}${b.length > 100 ? '...' : ''}`);
      console.log(`    AFTER:  ${a.substring(0, 100)}${a.length > 100 ? '...' : ''}`);
    }

    if (flaggedChanges.length > 0) {
      console.log(`\n  [ 문법 깨짐 FLAG — ${flaggedChanges.length}건 ]`);
      for (const f of flaggedChanges.slice(0, 5)) {
        console.log(`  ${f.jobName} (${f.jobSlug}) / ${f.fieldPath}`);
        for (const issue of f.grammarIssues) console.log(`    ! ${issue}`);
      }
    } else {
      console.log(`\n  [ 문법 깨짐 FLAG: 0건 ]`);
    }
  }

  return { totalJobs, totalChanges, flaggedCount: flaggedChanges.length };
}

// ── APPLY 헬퍼 ───────────────────────────────────────────────────────────────

/**
 * merged_profile_json이 너무 커서 전체 교체가 불가할 때
 * json_set()으로 변경된 필드만 패치하는 SQL 생성.
 */
function buildJsonSetSql(r) {
  const changedBasePaths = [...new Set(
    r.fieldResults.map(fr => fr.fieldPath.replace(/\[\d+\]$/, ''))
  )];

  let expr = r.columnName;
  for (const fieldPath of changedBasePaths) {
    const jsonPath = '$.' + fieldPath;
    const value = getNestedValue(r.updated, fieldPath);
    let valueExpr;
    if (Array.isArray(value)) {
      const escapedArr = JSON.stringify(value).replace(/'/g, "''");
      valueExpr = `json('${escapedArr}')`;
    } else if (typeof value === 'string') {
      valueExpr = `'${value.replace(/'/g, "''")}'`;
    } else {
      valueExpr = `'${JSON.stringify(value).replace(/'/g, "''")}'`;
    }
    // SQLite json_set path: '$.parent.child'
    const safePath = jsonPath.replace(/'/g, "''");
    expr = `json_set(${expr}, '${safePath}', ${valueExpr})`;
  }

  return `UPDATE jobs SET ${r.columnName} = ${expr} WHERE id = ${r.id};`;
}

function applyResults(results) {
  let successCount = 0;
  let failCount = 0;

  for (const r of results) {
    const label = r.columnName === 'user_contributed_json' ? 'UCJ' : 'merged';
    const tmpFile = path.join(os.tmpdir(), `tone-normalize-${r.id}-${r.columnName}.sql`);
    try {
      const newJson = JSON.stringify(r.updated);
      const escapedJson = newJson.replace(/'/g, "''");

      let sql;
      if (r.columnName === 'user_contributed_json') {
        sql = `UPDATE jobs SET user_contributed_json = '${escapedJson}', user_last_updated_at = datetime('now') WHERE id = ${r.id};`;
      } else {
        sql = `UPDATE jobs SET merged_profile_json = '${escapedJson}' WHERE id = ${r.id};`;
      }

      fs.writeFileSync(tmpFile, sql, 'utf8');
      executeD1File(tmpFile);
      console.log(`  ✅ ${r.name} (id=${r.id}) [${label}] — ${r.fieldResults.length}개 필드`);
      successCount++;
    } catch (err) {
      // SQLITE_TOOBIG: 전체 JSON 교체 대신 json_set()으로 개별 필드만 패치
      if (err.message.includes('TOOBIG') && r.columnName === 'merged_profile_json') {
        const tmpFile2 = path.join(os.tmpdir(), `tone-normalize-${r.id}-jsonset.sql`);
        try {
          const jsonSetSql = buildJsonSetSql(r);
          fs.writeFileSync(tmpFile2, jsonSetSql, 'utf8');
          executeD1File(tmpFile2);
          console.log(`  ✅ ${r.name} (id=${r.id}) [${label}/json_set] — ${r.fieldResults.length}개 필드`);
          successCount++;
        } catch (err2) {
          console.log(`  ❌ ${r.name} (id=${r.id}) [${label}/json_set] — ${err2.message.substring(0, 100)}`);
          failCount++;
        } finally {
          if (fs.existsSync(tmpFile2)) fs.unlinkSync(tmpFile2);
        }
      } else {
        console.log(`  ❌ ${r.name} (id=${r.id}) [${r.columnName}] — ${err.message.substring(0, 100)}`);
        failCount++;
      }
    } finally {
      if (fs.existsSync(tmpFile)) fs.unlinkSync(tmpFile);
    }
  }

  return { successCount, failCount };
}

// ── 메인 ─────────────────────────────────────────────────────────────────────

function main() {
  console.log(`\n${'='.repeat(60)}`);
  console.log(`tone-normalize.cjs`);
  console.log(`모드: ${isDryRun ? 'DRY-RUN (실제 변경 없음)' : 'APPLY (실제 UPDATE 실행)'}`);
  console.log(`타겟: ${targetsArg}  (UCJ: ${doUcj ? 'Y' : 'N'} / merged: ${doMerged ? 'Y' : 'N'})`);
  if (jobFilter) console.log(`직업 필터: ${jobFilter}`);
  if (fieldFilter) console.log(`필드 필터: ${fieldFilter}`);
  console.log(`${'='.repeat(60)}\n`);

  // 1. 직업 목록 조회 (UCJ와 merged를 별도 쿼리 — 단일 쿼리 시 D1 응답 크기 초과)
  const escapedSlug = jobFilter ? jobFilter.replace(/'/g, "''") : '';
  const jobFilterClause = jobFilter ? `AND slug='${escapedSlug}'` : '';

  const ucjResults = [];
  const mergedResults = [];

  if (doUcj) {
    console.log('D1에서 UCJ 데이터 로딩 중...');
    const ucjWhere = jobFilter
      ? `WHERE is_active=1 ${jobFilterClause}`
      : `WHERE is_active=1 AND user_contributed_json IS NOT NULL AND user_contributed_json != '' AND user_contributed_json != 'null'`;
    const ucjJobs = queryD1(
      `SELECT id, name, slug, user_contributed_json FROM jobs ${ucjWhere} ORDER BY id`
    );
    console.log(`UCJ 직업: ${ucjJobs.length}개`);
    for (const job of ucjJobs) {
      const r = processJsonColumn(job, 'user_contributed_json');
      if (r) ucjResults.push(r);
    }
  }

  if (doMerged) {
    console.log('D1에서 merged_profile_json 데이터 로딩 중 (배치 모드)...');
    const mergedWhere = jobFilter
      ? `WHERE is_active=1 ${jobFilterClause}`
      : `WHERE is_active=1 AND merged_profile_json IS NOT NULL AND merged_profile_json != ''`;
    const mergedJobs = jobFilter
      ? queryD1(`SELECT id, name, slug, merged_profile_json FROM jobs ${mergedWhere} ORDER BY id`)
      : queryD1Paginated(
          'SELECT id, name, slug, merged_profile_json FROM jobs',
          mergedWhere,
          'ORDER BY id',
          150
        );
    console.log(`merged 직업: ${mergedJobs.length}개`);
    for (const job of mergedJobs) {
      const r = processJsonColumn(job, 'merged_profile_json');
      if (r) mergedResults.push(r);
    }
  }
  console.log('');

  // 3. 리포트
  const ucjStats = doUcj ? printReport('UCJ (user_contributed_json)', ucjResults) : null;
  const mergedStats = doMerged ? printReport('merged_profile_json', mergedResults) : null;

  const totalChanges = (ucjStats?.totalChanges || 0) + (mergedStats?.totalChanges || 0);
  const totalFlagged = (ucjStats?.flaggedCount || 0) + (mergedStats?.flaggedCount || 0);

  console.log(`\n${'='.repeat(60)}`);
  console.log(`합계: 총 변경 ${totalChanges}건 / 문법 FLAG ${totalFlagged}건`);
  console.log(`${'='.repeat(60)}\n`);

  // 4. APPLY
  if (!isDryRun) {
    if (totalChanges === 0) {
      console.log('변경 대상 없음. 종료.');
      return;
    }

    console.log(`APPLY 모드 시작...\n`);
    let totalSuccess = 0;
    let totalFail = 0;

    if (doUcj && ucjResults.length > 0) {
      console.log(`[UCJ] ${ucjResults.length}개 직업 업데이트 중...`);
      const { successCount, failCount } = applyResults(ucjResults);
      totalSuccess += successCount;
      totalFail += failCount;
    }
    if (doMerged && mergedResults.length > 0) {
      console.log(`[merged] ${mergedResults.length}개 직업 업데이트 중...`);
      const { successCount, failCount } = applyResults(mergedResults);
      totalSuccess += successCount;
      totalFail += failCount;
    }

    console.log(`\nAPPLY 완료: 성공 ${totalSuccess}건 / 실패 ${totalFail}건`);
  } else {
    console.log(`[DRY-RUN] 위 내용이 --apply 시 실제 적용됩니다.`);
    console.log(`실제 적용: node scripts/tone-normalize.cjs --targets=${targetsArg} --apply`);
  }
}

main();
