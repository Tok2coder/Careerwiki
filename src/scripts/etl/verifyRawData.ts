/**
 * Raw 데이터 품질 검증
 * - job_sources, major_sources의 데이터 무결성 확인
 */

import { writeFileSync } from 'fs';

interface VerificationResult {
  category: string;
  checks: {
    name: string;
    status: 'PASS' | 'FAIL' | 'WARNING';
    value: any;
    details?: string;
  }[];
}

async function verifyRawData() {
  console.log('\n🔍 Raw 데이터 품질 검증 시작...\n');
  console.log('='.repeat(80));

  const { Miniflare } = await import('miniflare');
  const mf = new Miniflare({
    script: '',
    d1Databases: ['DB'],
    d1Persist: '.wrangler/state/v3/d1',
  });

  const db = await mf.getD1Database('DB');
  const results: VerificationResult[] = [];

  // ========================================
  // 1. 기본 통계
  // ========================================
  console.log('\n📊 1. 기본 통계\n');
  
  const jobSourcesCount = await db
    .prepare('SELECT source_system, COUNT(*) as count FROM job_sources GROUP BY source_system')
    .all();

  const majorSourcesCount = await db
    .prepare('SELECT source_system, COUNT(*) as count FROM major_sources GROUP BY source_system')
    .all();

  console.log('job_sources:');
  jobSourcesCount.results.forEach((r: any) => {
    console.log(`  - ${r.source_system}: ${r.count}개`);
  });

  console.log('\nmajor_sources:');
  majorSourcesCount.results.forEach((r: any) => {
    console.log(`  - ${r.source_system}: ${r.count}개`);
  });

  results.push({
    category: '기본 통계',
    checks: [
      ...jobSourcesCount.results.map((r: any) => ({
        name: `job_sources.${r.source_system}`,
        status: r.count > 0 ? 'PASS' : 'FAIL' as const,
        value: r.count,
      })),
      ...majorSourcesCount.results.map((r: any) => ({
        name: `major_sources.${r.source_system}`,
        status: r.count > 0 ? 'PASS' : 'FAIL' as const,
        value: r.count,
      })),
    ],
  });

  // ========================================
  // 2. 필수 필드 검증 (NULL 체크)
  // ========================================
  console.log('\n📋 2. 필수 필드 검증 (NULL 체크)\n');

  const nullChecks = [
    { table: 'job_sources', field: 'source_system' },
    { table: 'job_sources', field: 'source_key' },
    { table: 'job_sources', field: 'raw_payload' },
    { table: 'major_sources', field: 'source_system' },
    { table: 'major_sources', field: 'source_key' },
    { table: 'major_sources', field: 'raw_payload' },
  ];

  const nullCheckResults = [];

  for (const check of nullChecks) {
    const result = await db
      .prepare(`SELECT COUNT(*) as count FROM ${check.table} WHERE ${check.field} IS NULL`)
      .first<{ count: number }>();

    const nullCount = result?.count || 0;
    const status = nullCount === 0 ? 'PASS' : 'FAIL';

    console.log(`  ${status === 'PASS' ? '✅' : '❌'} ${check.table}.${check.field}: ${nullCount}개 NULL`);

    nullCheckResults.push({
      name: `${check.table}.${check.field} NULL check`,
      status,
      value: nullCount,
      details: nullCount > 0 ? `${nullCount}개의 NULL 값 발견` : undefined,
    });
  }

  results.push({
    category: '필수 필드 검증',
    checks: nullCheckResults,
  });

  // ========================================
  // 3. JSON 파싱 검증
  // ========================================
  console.log('\n🔧 3. JSON 파싱 검증\n');

  const jsonChecks = [
    { table: 'job_sources', system: 'CAREERNET', limit: 10 },
    { table: 'job_sources', system: 'WORK24_JOB', limit: 10 },
    { table: 'job_sources', system: 'WORK24_DJOB', limit: 10 },
    { table: 'major_sources', system: 'CAREERNET', limit: 10 },
    { table: 'major_sources', system: 'WORK24_MAJOR', limit: 10 },
  ];

  const jsonCheckResults = [];

  for (const check of jsonChecks) {
    const samples = await db
      .prepare(`SELECT id, source_key, raw_payload FROM ${check.table} WHERE source_system = ? LIMIT ?`)
      .bind(check.system, check.limit)
      .all();

    let parseErrors = 0;

    for (const sample of samples.results) {
      try {
        JSON.parse((sample as any).raw_payload);
      } catch (error) {
        parseErrors++;
        console.log(`  ❌ ${check.table}.${check.system} - ID ${(sample as any).id}: JSON 파싱 실패`);
      }
    }

    const status = parseErrors === 0 ? 'PASS' : 'FAIL';
    console.log(`  ${status === 'PASS' ? '✅' : '❌'} ${check.table}.${check.system}: ${samples.results.length}개 샘플 중 ${parseErrors}개 파싱 실패`);

    jsonCheckResults.push({
      name: `${check.table}.${check.system} JSON parsing`,
      status,
      value: `${samples.results.length - parseErrors}/${samples.results.length}`,
      details: parseErrors > 0 ? `${parseErrors}개 파싱 실패` : undefined,
    });
  }

  results.push({
    category: 'JSON 파싱 검증',
    checks: jsonCheckResults,
  });

  // ========================================
  // 4. 중복 데이터 검증
  // ========================================
  console.log('\n🔄 4. 중복 데이터 검증\n');

  const duplicateChecks = [
    { table: 'job_sources', groupBy: 'source_system, source_key' },
    { table: 'major_sources', groupBy: 'source_system, source_key' },
  ];

  const duplicateCheckResults = [];

  for (const check of duplicateChecks) {
    const result = await db
      .prepare(`
        SELECT COUNT(*) as dup_count 
        FROM (
          SELECT ${check.groupBy}, COUNT(*) as cnt 
          FROM ${check.table} 
          GROUP BY ${check.groupBy} 
          HAVING cnt > 1
        )
      `)
      .first<{ dup_count: number }>();

    const dupCount = result?.dup_count || 0;
    const status = dupCount === 0 ? 'PASS' : 'WARNING';

    console.log(`  ${status === 'PASS' ? '✅' : '⚠️ '} ${check.table}: ${dupCount}개 중복 그룹`);

    duplicateCheckResults.push({
      name: `${check.table} duplicates`,
      status,
      value: dupCount,
      details: dupCount > 0 ? `${dupCount}개 중복 그룹 발견` : undefined,
    });
  }

  results.push({
    category: '중복 데이터 검증',
    checks: duplicateCheckResults,
  });

  // ========================================
  // 5. 샘플 데이터 확인 (각 소스별 3개)
  // ========================================
  console.log('\n📄 5. 샘플 데이터 확인\n');

  const samples = [];

  // Job Sources
  for (const system of ['CAREERNET', 'WORK24_JOB', 'WORK24_DJOB']) {
    const jobSamples = await db
      .prepare(`
        SELECT id, source_key, raw_payload 
        FROM job_sources 
        WHERE source_system = ? 
        LIMIT 3
      `)
      .bind(system)
      .all();

    console.log(`\n${system}:`);
    for (const sample of jobSamples.results) {
      const data = JSON.parse((sample as any).raw_payload);
      const name = data.jobName || data.name || data.dJobNm || '이름 없음';
      console.log(`  - [${(sample as any).source_key}] ${name}`);
      samples.push({
        source: system,
        type: 'job',
        source_key: (sample as any).source_key,
        name,
        payload_size: (sample as any).raw_payload.length,
      });
    }
  }

  // Major Sources
  for (const system of ['CAREERNET', 'WORK24_MAJOR']) {
    const majorSamples = await db
      .prepare(`
        SELECT id, source_key, raw_payload 
        FROM major_sources 
        WHERE source_system = ? 
        LIMIT 3
      `)
      .bind(system)
      .all();

    console.log(`\n${system}:`);
    for (const sample of majorSamples.results) {
      const data = JSON.parse((sample as any).raw_payload);
      const name = data.majorName || data.name || data.mClass || '이름 없음';
      console.log(`  - [${(sample as any).source_key}] ${name}`);
      samples.push({
        source: system,
        type: 'major',
        source_key: (sample as any).source_key,
        name,
        payload_size: (sample as any).raw_payload.length,
      });
    }
  }

  // ========================================
  // 6. 데이터 크기 검증
  // ========================================
  console.log('\n📏 6. 데이터 크기 검증\n');

  const sizeChecks = [
    { table: 'job_sources', system: 'CAREERNET' },
    { table: 'job_sources', system: 'WORK24_JOB' },
    { table: 'job_sources', system: 'WORK24_DJOB' },
    { table: 'major_sources', system: 'CAREERNET' },
    { table: 'major_sources', system: 'WORK24_MAJOR' },
  ];

  const sizeCheckResults = [];

  for (const check of sizeChecks) {
    const result = await db
      .prepare(`
        SELECT 
          AVG(LENGTH(raw_payload)) as avg_size,
          MIN(LENGTH(raw_payload)) as min_size,
          MAX(LENGTH(raw_payload)) as max_size
        FROM ${check.table}
        WHERE source_system = ?
      `)
      .bind(check.system)
      .first<{ avg_size: number; min_size: number; max_size: number }>();

    if (result) {
      console.log(`  ${check.table}.${check.system}:`);
      console.log(`    평균: ${Math.round(result.avg_size)} bytes`);
      console.log(`    최소: ${result.min_size} bytes`);
      console.log(`    최대: ${result.max_size} bytes`);

      const status = result.min_size > 10 ? 'PASS' : 'WARNING';
      sizeCheckResults.push({
        name: `${check.table}.${check.system} size`,
        status,
        value: `avg: ${Math.round(result.avg_size)}B, min: ${result.min_size}B, max: ${result.max_size}B`,
        details: result.min_size <= 10 ? '일부 데이터가 너무 작음' : undefined,
      });
    }
  }

  results.push({
    category: '데이터 크기 검증',
    checks: sizeCheckResults,
  });

  // ========================================
  // 7. 최종 요약
  // ========================================
  console.log('\n' + '='.repeat(80));
  console.log('\n📊 최종 요약\n');

  let totalChecks = 0;
  let passCount = 0;
  let failCount = 0;
  let warningCount = 0;

  results.forEach((category) => {
    category.checks.forEach((check) => {
      totalChecks++;
      if (check.status === 'PASS') passCount++;
      else if (check.status === 'FAIL') failCount++;
      else if (check.status === 'WARNING') warningCount++;
    });
  });

  console.log(`총 검증 항목: ${totalChecks}개`);
  console.log(`✅ PASS: ${passCount}개`);
  console.log(`⚠️  WARNING: ${warningCount}개`);
  console.log(`❌ FAIL: ${failCount}개`);

  const overallStatus = failCount === 0 ? (warningCount === 0 ? '✅ 완벽' : '⚠️  주의 필요') : '❌ 문제 있음';
  console.log(`\n전체 상태: ${overallStatus}\n`);

  // ========================================
  // 8. 보고서 저장
  // ========================================
  const report = {
    timestamp: new Date().toISOString(),
    summary: {
      total: totalChecks,
      pass: passCount,
      warning: warningCount,
      fail: failCount,
      status: overallStatus,
    },
    results,
    samples,
  };

  writeFileSync('.temp/data_verification_report.json', JSON.stringify(report, null, 2), 'utf-8');
  console.log('📁 상세 보고서: .temp/data_verification_report.json\n');

  process.exit(failCount > 0 ? 1 : 0);
}

verifyRawData().catch((error) => {
  console.error('\n❌ 검증 중 에러 발생:', error);
  process.exit(1);
});

