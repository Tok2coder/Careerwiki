/**
 * 이미지 없는 직업들을 가져와서 배치별로 나누는 스크립트
 * - 프롬프트가 없는 직업들만 대상 (이미지 생성 대기 중인 직업들)
 */

const Database = require('better-sqlite3');
const path = require('path');
const fs = require('fs');

const dbPath = path.resolve(__dirname, '../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite');
const db = new Database(dbPath);

try {
  // 이미지와 프롬프트가 모두 없는 직업들 조회 (프롬프트 작성 대상)
  const jobs = db.prepare(`
    SELECT id, slug, name, name_en
    FROM jobs
    WHERE (image_url IS NULL OR image_url = '')
      AND (image_prompt IS NULL OR image_prompt = '')
    ORDER BY id
  `).all();

  console.log(`📊 프롬프트 작성 대상: ${jobs.length}개 직업`);

  // 50개씩 배치로 나누기
  const batchSize = 50;
  const batches = [];

  for (let i = 0; i < jobs.length; i += batchSize) {
    const batch = jobs.slice(i, i + batchSize);
    const batchNumber = Math.floor(i / batchSize) + 1; // 1부터 시작
    batches.push({
      batchNumber,
      jobs: batch
    });
  }

  console.log(`📦 총 ${batches.length}개 배치 생성`);

  // 각 배치별로 파일 생성
  batches.forEach(batch => {
    const batchFilePath = path.resolve(__dirname, `batch_${batch.batchNumber}_jobs.json`);
    fs.writeFileSync(batchFilePath, JSON.stringify(batch.jobs, null, 2));
    console.log(`✅ 배치 ${batch.batchNumber}: ${batch.jobs.length}개 직업 저장`);
  });

  // 배치 요약 파일 생성
  const summaryPath = path.resolve(__dirname, 'batch_summary.json');
  const summary = batches.map(batch => ({
    batch: batch.batchNumber,
    count: batch.jobs.length,
    firstJob: batch.jobs[0]?.name,
    lastJob: batch.jobs[batch.jobs.length - 1]?.name
  }));

  fs.writeFileSync(summaryPath, JSON.stringify(summary, null, 2));
  console.log(`\n📋 배치 요약 파일 생성: batch_summary.json`);

  // 배치 1의 첫 몇 개 항목 확인
  if (batches.length > 0) {
    console.log(`\n🔍 배치 1 샘플:`);
    batches[0].jobs.slice(0, 5).forEach(job => {
      console.log(`  - ${job.name} (${job.name_en})`);
    });
  }

} catch (error) {
  console.error('❌ 오류 발생:', error.message);
} finally {
  db.close();
}
