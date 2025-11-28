/**
 * DJOB 시딩 진행 상황 모니터링
 */

import { readFileSync, existsSync } from 'fs';

function monitorProgress() {
  console.log('\n📊 DJOB 시딩 진행 상황 모니터링\n');
  console.log('='.repeat(60));

  // 1. JSON 파일 확인
  const partialPath = '.temp/djob_data_partial.json';
  const finalPath = '.temp/djob_data_final.json';

  if (existsSync(finalPath)) {
    const data = JSON.parse(readFileSync(finalPath, 'utf-8'));
    console.log(`\n✅ 최종 데이터 파일 발견!`);
    console.log(`   📁 파일: ${finalPath}`);
    console.log(`   📊 수집된 직업: ${data.length}개`);
    console.log(`\n🎉 시딩 완료!`);
    process.exit(0);
  } else if (existsSync(partialPath)) {
    const data = JSON.parse(readFileSync(partialPath, 'utf-8'));
    console.log(`\n⏳ 진행 중...`);
    console.log(`   📁 파일: ${partialPath}`);
    console.log(`   📊 현재까지 수집: ${data.length}개`);
    console.log(`\n💡 10개 분류마다 중간 저장됩니다.`);
    console.log(`   예상 총 수집: ~4,000개`);
    console.log(`   예상 소요 시간: 20-25분`);
  } else {
    console.log(`\n⏳ 시작 대기 중...`);
    console.log(`   아직 데이터 파일이 생성되지 않았습니다.`);
  }

  // 2. 로그 파일 확인
  const logPath = '.temp/djob_full_log.txt';
  if (existsSync(logPath)) {
    const log = readFileSync(logPath, 'utf-8');
    const lines = log.split('\n');
    const lastLines = lines.slice(-30).join('\n');
    console.log(`\n📄 최근 로그 (마지막 30줄):`);
    console.log('─'.repeat(60));
    console.log(lastLines);
  }

  console.log('\n' + '='.repeat(60) + '\n');
}

monitorProgress();

