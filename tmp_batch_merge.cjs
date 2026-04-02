/**
 * 배치 직업 병합 스크립트
 * /api/admin/merge-jobs API를 순차 호출하여 중복 직업 합치기
 */
const fs = require('fs');

const BASE_URL = 'https://careerwiki.org';
const SESSION_TOKEN = process.env.SESSION_TOKEN;

if (!SESSION_TOKEN) {
  console.error('ERROR: SESSION_TOKEN 환경변수가 필요합니다.');
  console.error('Usage: SESSION_TOKEN=xxx node tmp_batch_merge.cjs');
  process.exit(1);
}

const mergePairs = JSON.parse(fs.readFileSync('tmp_merge_targets.json', 'utf8'));

async function mergePair(source, target, index, total) {
  const resp = await fetch(`${BASE_URL}/api/admin/merge-jobs`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Cookie': `session_token=${SESSION_TOKEN}`,
    },
    body: JSON.stringify({ sourceName: source, targetName: target }),
  });

  const data = await resp.json();
  if (data.success) {
    console.log(`[${index}/${total}] OK: "${source}" → "${target}"`);
  } else {
    console.log(`[${index}/${total}] FAIL: "${source}" → "${target}" — ${data.error}`);
  }
  return data;
}

async function main() {
  console.log(`\n=== 배치 직업 병합 시작 (${mergePairs.length}건) ===\n`);

  const results = { success: 0, fail: 0, errors: [] };

  for (let i = 0; i < mergePairs.length; i++) {
    const pair = mergePairs[i];
    try {
      const result = await mergePair(pair.source, pair.target, i + 1, mergePairs.length);
      if (result.success) {
        results.success++;
      } else {
        results.fail++;
        results.errors.push({ pair, error: result.error });
      }
    } catch (err) {
      results.fail++;
      results.errors.push({ pair, error: err.message });
      console.log(`[${i + 1}/${mergePairs.length}] ERROR: ${err.message}`);
    }

    // Rate limit: 500ms between requests
    if (i < mergePairs.length - 1) {
      await new Promise(r => setTimeout(r, 500));
    }
  }

  console.log(`\n=== 완료 ===`);
  console.log(`성공: ${results.success}, 실패: ${results.fail}`);
  if (results.errors.length > 0) {
    console.log('\n실패 목록:');
    results.errors.forEach(e => console.log(`  - "${e.pair.source}": ${e.error}`));
  }

  fs.writeFileSync('tmp_merge_results.json', JSON.stringify(results, null, 2), 'utf8');
}

main().catch(console.error);
