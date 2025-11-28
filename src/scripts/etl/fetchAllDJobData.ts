/**
 * Work24 직업사전 데이터 수집 (JSON 파일로 저장)
 * Miniflare 없이 순수 Node.js로 실행
 */

import { readFileSync, writeFileSync, mkdirSync } from 'fs';
import { parse } from 'csv-parse/sync';
import { DOMParser } from '@xmldom/xmldom';

const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

function parseXML(xmlText: string): Document {
  const parser = new DOMParser();
  return parser.parseFromString(xmlText, 'text/xml');
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

interface Work24JobCode {
  dJobCd: string;
  dJobCdSeq: string;
  dJobNm: string;
}

async function fetchWork24JobCodesByStdJobCl(
  authKey: string,
  stdJobCl: string
): Promise<Work24JobCode[]> {
  const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212L50.do');
  url.searchParams.append('authKey', authKey);
  url.searchParams.append('returnType', 'XML');
  url.searchParams.append('target', 'dJobCD');
  url.searchParams.append('startPage', '1');
  url.searchParams.append('display', '100');
  url.searchParams.append('srchType', 'J');
  url.searchParams.append('stdJobCl', stdJobCl);

  const response = await fetch(url.toString());
  const xmlText = await response.text();
  const xmlDoc = parseXML(xmlText);

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
}

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

  const response = await fetch(url.toString());
  const xmlText = await response.text();

  if (xmlText.includes('정보가 존재하지 않습니다')) {
    return null;
  }

  const xmlDoc = parseXML(xmlText);
  const dJobsSumElements = xmlDoc.getElementsByTagName('dJobsSum');

  if (!dJobsSumElements || dJobsSumElements.length === 0) {
    return null;
  }

  const dJobSum = dJobsSumElements[0];

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
}

async function main() {
  console.log('\n🚀 Work24 직업사전 데이터 수집 시작...\n');

  const authKey = '7635eb78-dc24-4f05-8287-ac391e233b15';
  const csvPath = 'docs/직업사전_세세분류_코드.csv';
  
  mkdirSync('.temp', { recursive: true });

  const stdJobCodes = extractUniqueJobCodes(csvPath);
  console.log(`📂 추출된 직업분류 코드: ${stdJobCodes.length}개`);
  console.log(`📊 처음 10개: ${stdJobCodes.slice(0, 10).join(', ')}\n`);

  // TEST MODE: Process only first 10 codes
  const TEST_LIMIT = process.argv[2] ? parseInt(process.argv[2]) : stdJobCodes.length;
  const codesToProcess = stdJobCodes.slice(0, TEST_LIMIT);
  console.log(`⚙️  처리할 코드 수: ${codesToProcess.length}개 (전체: ${stdJobCodes.length}개)\n`);

  const allJobData: any[] = [];
  let totalJobsFound = 0;
  let totalJobsFetched = 0;
  let totalErrors = 0;

  for (let i = 0; i < codesToProcess.length; i++) {
    const stdJobCl = codesToProcess[i];
    console.log(`\n[${i + 1}/${stdJobCodes.length}] 분류코드: ${stdJobCl}`);

    try {
      const work24Jobs = await fetchWork24JobCodesByStdJobCl(authKey, stdJobCl);
      console.log(`  ✅ ${work24Jobs.length}개 직업 발견`);

      if (work24Jobs.length === 0) {
        continue;
      }

      totalJobsFound += work24Jobs.length;

      for (const job of work24Jobs) {
        try {
          const detail = await fetchWork24JobDictionaryDetail(authKey, job.dJobCd, job.dJobCdSeq);

          if (detail) {
            allJobData.push(detail);
            totalJobsFetched++;
            console.log(`    ✅ ${job.dJobNm}`);
          } else {
            console.log(`    ⚠️  ${job.dJobNm} - 데이터 없음`);
          }

          await sleep(300);
        } catch (error) {
          console.error(`    ❌ ${job.dJobNm} - 에러: ${error}`);
          totalErrors++;
        }
      }
    } catch (error) {
      console.error(`  ❌ 분류 조회 실패: ${error}`);
      totalErrors++;
    }

    // 진행 상황 저장 (10개마다)
    if ((i + 1) % 10 === 0) {
      console.log(`\n📈 진행: ${i + 1}/${codesToProcess.length} 분류 처리 완료`);
      console.log(`   발견: ${totalJobsFound}개, 수집: ${totalJobsFetched}개, 에러: ${totalErrors}개\n`);
      
      // 중간 저장
      writeFileSync(
        '.temp/djob_data_partial.json',
        JSON.stringify(allJobData, null, 2),
        'utf-8'
      );
    }
  }

  // 최종 저장
  console.log('\n💾 최종 데이터 저장 중...');
  writeFileSync(
    '.temp/djob_data_final.json',
    JSON.stringify(allJobData, null, 2),
    'utf-8'
  );

  console.log('\n✅ 데이터 수집 완료!\n');
  console.log(`📊 최종 통계:`);
  console.log(`   - 처리한 분류: ${stdJobCodes.length}개`);
  console.log(`   - 발견한 직업: ${totalJobsFound}개`);
  console.log(`   - 수집한 직업: ${totalJobsFetched}개`);
  console.log(`   - 에러: ${totalErrors}개`);
  console.log(`\n📁 저장 위치: .temp/djob_data_final.json\n`);
}

main().catch(console.error);

