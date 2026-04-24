'use strict';

/**
 * work.go.kr → wagework.go.kr URL 교체 스크립트
 * 대상: _sources 안의 work.go.kr URL 전체
 * 주의: _sources 외의 필드 절대 건드리지 않음
 */

const fs = require('fs');
const { execSync } = require('child_process');

const DRY_RUN = process.argv.includes('--dry-run');
const ADMIN_SECRET = 'careerwiki-admin-2026';
const BASE_API = 'https://careerwiki.org/api/job';

// work.go.kr URL → 교체 URL 결정
function replaceWorkUrl(url, text) {
  if (!url || !url.includes('work.go.kr')) return null;

  // jobMain → 메인 페이지
  if (url.includes('work.go.kr/jobMain')) {
    return { newUrl: 'https://www.wagework.go.kr/pt/index.do', newText: fixText(text) };
  }

  // seekWantedMain → 메인 페이지
  if (url.includes('seekWantedMain')) {
    return { newUrl: 'https://www.wagework.go.kr/pt/index.do', newText: fixText(text) };
  }

  // 나머지 모두 → 직업정보 검색 페이지
  return { newUrl: 'https://www.wagework.go.kr/pt/b/a/retrieveOccpSrchByJobCare.do', newText: fixText(text) };
}

function fixText(text) {
  if (!text) return text;
  // 워크넷 관련 텍스트를 임금직업포털로 교체
  return text
    .replace(/워크넷\s*(직업정보|직업전망|고용전망|직업사전|취업정보|정보|채용정보)?/g, '임금직업포털(워크피디아)')
    .replace(/work\.go\.kr/gi, '임금직업포털(워크피디아)');
}

// 쿼리 실행
function queryD1(sql) {
  const result = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --command "${sql.replace(/"/g, '\\"')}"`,
    { maxBuffer: 50 * 1024 * 1024, cwd: 'C:\\Users\\user\\Careerwiki' }
  ).toString();
  const match = result.match(/\[\s*\{[\s\S]+\}\s*\]/);
  if (!match) return [];
  return JSON.parse(match[0])[0]?.results || [];
}

async function patchJob(jobId, newSources) {
  const body = JSON.stringify({ fields: { _sources: newSources } });
  const res = await fetch(`${BASE_API}/${jobId}/edit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'X-Admin-Secret': ADMIN_SECRET },
    body,
  });
  return res.json();
}

async function main() {
  console.log('work.go.kr URL 교체 시작...');

  // 전체 work.go.kr 포함 직업 조회
  const rows = queryD1(
    "SELECT id, slug, json_extract(user_contributed_json, '$._sources') as sources FROM jobs WHERE user_contributed_json LIKE '%work.go.kr%' AND is_active=1"
  );
  console.log(`대상: ${rows.length}개 직업 (active만)`);

  let successCount = 0, skipCount = 0, errorCount = 0;
  const log = [];

  for (const row of rows) {
    let sources;
    try { sources = JSON.parse(row.sources); } catch { skipCount++; continue; }

    let changed = false;
    const changes = [];

    for (const [field, refs] of Object.entries(sources)) {
      if (!Array.isArray(refs)) continue;
      for (const ref of refs) {
        if (!ref.url || !ref.url.includes('work.go.kr')) continue;
        const result = replaceWorkUrl(ref.url, ref.text);
        if (!result) continue;

        changes.push({ field, old: ref.url, new: result.newUrl, oldText: ref.text, newText: result.newText });
        ref.url = result.newUrl;
        if (result.newText !== ref.text) ref.text = result.newText;
        changed = true;
      }
    }

    if (!changed) { skipCount++; continue; }

    log.push({ slug: row.slug, changes });

    if (!DRY_RUN) {
      const res = await patchJob(row.id, sources);
      if (res.success) {
        successCount++;
        process.stdout.write('.');
      } else {
        console.error(`\n[ERROR] ${row.slug}: ${JSON.stringify(res)}`);
        errorCount++;
      }
    } else {
      successCount++;
    }
  }

  fs.writeFileSync('workgokr-url-fixes.json', JSON.stringify(log, null, 2));
  console.log(`\n\n${'='.repeat(50)}`);
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN' : '실제 업데이트'}`);
  console.log(`성공: ${successCount}, 스킵: ${skipCount}, 오류: ${errorCount}`);
  console.log(`로그: workgokr-url-fixes.json`);
}

main().catch(console.error);
