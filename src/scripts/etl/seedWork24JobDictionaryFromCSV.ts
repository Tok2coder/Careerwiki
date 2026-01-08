/**
 * Work24 직업사전 시딩 (CSV 기반)
 * 
 * 전략:
 * 1. CSV에서 유니크한 표준직업분류 코드 추출
 * 2. 각 코드로 목록 API 호출 → Work24 코드(K~) 수집
 * 3. 각 Work24 코드로 상세 API 호출 → job_sources에 저장
 */

import { readFileSync } from 'fs';
import { parse } from 'csv-parse/sync';
import type { D1Database } from '@cloudflare/workers-types';

interface JobDictionaryCode {
  stdJobCl: string; // 직업코드 (1110, 2111 등)
}

interface Work24JobCode {
  dJobCd: string;    // K000007117
  dJobCdSeq: string; // 1
  dJobNm: string;    // 직업명
}

const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

// XML 파싱 헬퍼
async function parseXML(xmlText: string): Promise<Document> {
  if (typeof DOMParser !== 'undefined') {
    const parser = new DOMParser();
    return parser.parseFromString(xmlText, 'text/xml');
  } else {
    const { DOMParser: NodeDOMParser } = await import('@xmldom/xmldom');
    const parser = new NodeDOMParser();
    return parser.parseFromString(xmlText, 'text/xml');
  }
}

function getElementText(parent: Element, tagName: string): string | undefined {
  const elements = parent.getElementsByTagName(tagName);
  if (elements && elements.length > 0) {
    return elements[0].textContent || undefined;
  }
  return undefined;
}

// CSV에서 유니크한 직업코드 추출
function extractUniqueJobCodes(csvPath: string): string[] {
  const csvContent = readFileSync(csvPath, 'utf-8');
  const records = parse(csvContent, {
    skip_empty_lines: true,
    relax_column_count: true,
  });

  const uniqueCodes = new Set<string>();

  // Skip header rows (first 3 rows)
  for (let i = 3; i < records.length; i++) {
    const jobCode = records[i][3]?.toString().trim(); // 직업코드 (컬럼 4)
    if (jobCode && /^\d{4}$/.test(jobCode)) {
      uniqueCodes.add(jobCode);
    }
  }

  return Array.from(uniqueCodes).sort();
}

// 목록 API: 표준직업분류 코드로 Work24 코드 검색
async function fetchWork24JobCodesByStdJobCl(
  authKey: string,
  stdJobCl: string
): Promise<Work24JobCode[]> {
  const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212L50.do');
  url.searchParams.append('authKey', authKey);
  url.searchParams.append('returnType', 'XML');
  url.searchParams.append('target', 'dJobCD');
  url.searchParams.append('startPage', '1');
  url.searchParams.append('display', '100'); // Max per page
  url.searchParams.append('srchType', 'J'); // 표준직업분류별 검색
  url.searchParams.append('stdJobCl', stdJobCl);

  try {
    const response = await fetch(url.toString());
    if (!response.ok) {
      throw new Error(`API 요청 실패 [${response.status}]: ${response.statusText}`);
    }

    const xmlText = await response.text();
    const xmlDoc = await parseXML(xmlText);

    const dJobListElements = xmlDoc.getElementsByTagName('dJobList');
    const jobs: Work24JobCode[] = [];

    for (let i = 0; i < dJobListElements.length; i++) {
      const jobEl = dJobListElements[i];
      const dJobCd = getElementText(jobEl, 'dJobCd');
      const dJobCdSeq = getElementText(jobEl, 'dJobCdSeq');
      const dJobNm = getElementText(jobEl, 'dJobNm');

      if (dJobCd && dJobCdSeq && dJobNm) {
        jobs.push({ dJobCd, dJobCdSeq, dJobNm });
      }
    }

    return jobs;
  } catch (error) {
    console.error(`[fetchWork24JobCodesByStdJobCl] Error for ${stdJobCl}:`, error);
    throw error;
  }
}

// 상세 API: Work24 코드로 직업사전 상세 조회
async function fetchWork24JobDictionaryDetail(
  authKey: string,
  dJobCd: string,
  dJobCdSeq: string
): Promise<any | null> {
  const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212D50.do');
  url.searchParams.append('authKey', authKey);
  url.searchParams.append('returnType', 'XML');
  url.searchParams.append('target', 'dJobDTL');
  url.searchParams.append('dJobCd', dJobCd);
  url.searchParams.append('dJobCdSeq', dJobCdSeq);

  try {
    const response = await fetch(url.toString());
    if (!response.ok) {
      throw new Error(`API 요청 실패 [${response.status}]: ${response.statusText}`);
    }

    const xmlText = await response.text();
    
    // Check for "정보가 존재하지 않습니다"
    if (xmlText.includes('정보가 존재하지 않습니다')) {
      console.warn(`[fetchWork24JobDictionaryDetail] No data for ${dJobCd}:${dJobCdSeq}`);
      return null;
    }

    const xmlDoc = await parseXML(xmlText);
    const dJobsSumElements = xmlDoc.getElementsByTagName('dJobsSum');

    if (!dJobsSumElements || dJobsSumElements.length === 0) {
      return null;
    }

    const dJobSum = dJobsSumElements[0];

    // Extract all fields
    const detail: any = {
      dJobCd: getElementText(dJobSum, 'dJobCd'),
      dJobCdSeq: getElementText(dJobSum, 'dJobCdSeq'),
      dJobNm: getElementText(dJobSum, 'dJobNm'),
      workSum: getElementText(dJobSum, 'workSum'),
      doWork: getElementText(dJobSum, 'doWork'),
    };

    // Extract optionJobInfo
    const optionJobInfoElements = dJobSum.getElementsByTagName('optionJobInfo');
    if (optionJobInfoElements && optionJobInfoElements.length > 0) {
      const optionJobInfo = optionJobInfoElements[0];
      detail.optionJobInfo = {
        eduLevel: getElementText(optionJobInfo, 'eduLevel'),
        skillYear: getElementText(optionJobInfo, 'skillYear'),
        workStrong: getElementText(optionJobInfo, 'workStrong'),
        workPlace: getElementText(optionJobInfo, 'workPlace'),
        physicalAct: getElementText(optionJobInfo, 'physicalAct'),
        workEnv: getElementText(optionJobInfo, 'workEnv'),
        workFunc1: getElementText(optionJobInfo, 'workFunc1'),
        workFunc2: getElementText(optionJobInfo, 'workFunc2'),
        workFunc3: getElementText(optionJobInfo, 'workFunc3'),
        similarNm: getElementText(optionJobInfo, 'similarNm'),
        connectJob: getElementText(optionJobInfo, 'connectJob'),
        certLic: getElementText(optionJobInfo, 'certLic'),
        dJobECd: getElementText(optionJobInfo, 'dJobECd'),
        dJobECdNm: getElementText(optionJobInfo, 'dJobECdNm'),
        dJobJCd: getElementText(optionJobInfo, 'dJobJCd'),
        dJobJCdNm: getElementText(optionJobInfo, 'dJobJCdNm'),
        dJobICd: getElementText(optionJobInfo, 'dJobICd'),
        dJobICdNm: getElementText(optionJobInfo, 'dJobICdNm'),
        inqYear: getElementText(optionJobInfo, 'inqYear'),
        etc: getElementText(optionJobInfo, 'etc'),
      };
    }

    return detail;
  } catch (error) {
    console.error(`[fetchWork24JobDictionaryDetail] Error for ${dJobCd}:${dJobCdSeq}:`, error);
    throw error;
  }
}

// job_sources에 저장
async function upsertJobSource(
  db: D1Database,
  dJobCd: string,
  dJobCdSeq: string,
  rawPayload: any
): Promise<void> {
  const sourceKey = `${dJobCd}:${dJobCdSeq}`;
  
  const now = Math.floor(Date.now() / 1000);
  await db
    .prepare(
      `INSERT INTO job_sources (
        source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?)
      ON CONFLICT(source_system, source_key) DO UPDATE SET
        raw_payload = excluded.raw_payload,
        updated_at = excluded.updated_at`
    )
    .bind('WORK24_DJOB', 'DICTIONARY', sourceKey, JSON.stringify(rawPayload), '{}', now, now)
    .run();
}

// Seed 로그 기록 (스키마 호환성 이슈로 로깅 스킵)
async function logSeedStart(db: D1Database, stdJobCl: string, jobCount: number): Promise<void> {
  // 스키마 호환성 문제로 로깅 스킵
  // console.log(`  [LOG] Started ${stdJobCl} with ${jobCount} jobs`)
}

async function logSeedComplete(db: D1Database, stdJobCl: string, successCount: number): Promise<void> {
  // 스키마 호환성 문제로 로깅 스킵
  // console.log(`  [LOG] Completed ${stdJobCl} with ${successCount} success`)
}

async function logSeedError(
  db: D1Database,
  stdJobCl: string,
  dJobCd: string,
  dJobCdSeq: string,
  error: string
): Promise<void> {
  // 스키마 호환성 문제로 로깅 스킵
  // console.log(`  [LOG] Error ${dJobCd}:${dJobCdSeq} - ${error}`)
}

// 메인 시딩 함수
export async function seedWork24JobDictionaryFromCSV(
  db: D1Database,
  authKey: string
): Promise<void> {
  console.log('\n🚀 Starting Work24 Job Dictionary Seeding (CSV-based)...\n');

  const csvPath = 'docs/직업사전_세세분류_코드.csv';
  const stdJobCodes = extractUniqueJobCodes(csvPath);

  console.log(`📂 Extracted ${stdJobCodes.length} unique job classification codes`);
  console.log(`📊 First 10 codes: ${stdJobCodes.slice(0, 10).join(', ')}\n`);

  let totalJobsFound = 0;
  let totalJobsSeeded = 0;
  let totalErrors = 0;

  for (let i = 0; i < stdJobCodes.length; i++) {
    const stdJobCl = stdJobCodes[i];
    console.log(`\n[${i + 1}/${stdJobCodes.length}] Processing stdJobCl: ${stdJobCl}`);

    try {
      // Step 1: Fetch Work24 job codes for this classification
      const work24Jobs = await fetchWork24JobCodesByStdJobCl(authKey, stdJobCl);
      console.log(`  ✅ Found ${work24Jobs.length} jobs`);

      if (work24Jobs.length === 0) {
        continue;
      }

      totalJobsFound += work24Jobs.length;
      await logSeedStart(db, stdJobCl, work24Jobs.length);

      let successCount = 0;

      // Step 2: Fetch details for each job
      for (const job of work24Jobs) {
        try {
          const detail = await fetchWork24JobDictionaryDetail(authKey, job.dJobCd, job.dJobCdSeq);

          if (detail) {
            await upsertJobSource(db, job.dJobCd, job.dJobCdSeq, detail);
            successCount++;
            totalJobsSeeded++;
            console.log(`    ✅ ${job.dJobNm} (${job.dJobCd}:${job.dJobCdSeq})`);
          } else {
            console.log(`    ⚠️  ${job.dJobNm} - No data available`);
          }

          await sleep(300); // Rate limiting
        } catch (error) {
          const errorMsg = error instanceof Error ? error.message : String(error);
          console.error(`    ❌ ${job.dJobNm} - Error: ${errorMsg}`);
          await logSeedError(db, stdJobCl, job.dJobCd, job.dJobCdSeq, errorMsg);
          totalErrors++;
        }
      }

      await logSeedComplete(db, stdJobCl, successCount);
      console.log(`  📊 ${successCount}/${work24Jobs.length} seeded successfully`);

    } catch (error) {
      const errorMsg = error instanceof Error ? error.message : String(error);
      console.error(`  ❌ Failed to fetch jobs for ${stdJobCl}: ${errorMsg}`);
      totalErrors++;
    }

    // Progress checkpoint every 10 codes
    if ((i + 1) % 10 === 0) {
      console.log(`\n📈 Progress: ${i + 1}/${stdJobCodes.length} codes processed`);
      console.log(`   Total jobs found: ${totalJobsFound}`);
      console.log(`   Total jobs seeded: ${totalJobsSeeded}`);
      console.log(`   Total errors: ${totalErrors}\n`);
    }
  }

  console.log('\n✅ Work24 Job Dictionary Seeding Complete!\n');
  console.log(`📊 Final Stats:`);
  console.log(`   - Job codes processed: ${stdJobCodes.length}`);
  console.log(`   - Jobs found: ${totalJobsFound}`);
  console.log(`   - Jobs seeded: ${totalJobsSeeded}`);
  console.log(`   - Errors: ${totalErrors}\n`);
}

// CLI execution with Miniflare
if (import.meta.main) {
  (async () => {
    const { Miniflare } = await import('miniflare');
    const mf = new Miniflare({
      script: '',
      // 로컬 wrangler와 동일한 D1 식별자 사용
      d1Databases: { DB: 'edc21e23-c2ac-4693-bb79-389b6914e173' },
      d1Persist: '.wrangler/state/v3/d1',
    });

    const db = (await mf.getD1Database('DB')) as D1Database;
    const authKey = process.env.GOYONG24_JOB_API_KEY || '7635eb78-dc24-4f05-8287-ac391e233b15';

    await seedWork24JobDictionaryFromCSV(db, authKey);
    process.exit(0);
  })();
}

