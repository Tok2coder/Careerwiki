/**
 * Work24 직업사전 시딩 테스트 (1개 분류만)
 */

import { readFileSync } from 'fs';
import { parse } from 'csv-parse/sync';
import type { D1Database } from '@cloudflare/workers-types';

const sleep = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

function parseXML(xmlText: string): Document {
  if (typeof DOMParser !== 'undefined') {
    const parser = new DOMParser();
    return parser.parseFromString(xmlText, 'text/xml');
  } else {
    const { DOMParser: NodeDOMParser } = require('@xmldom/xmldom');
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

async function testSingleJobCode() {
  console.log('\n🧪 Testing Work24 Job Dictionary Seeding...\n');

  const { Miniflare } = await import('miniflare');
  const mf = new Miniflare({
    script: '',
    d1Databases: ['DB'],
    d1Persist: '.wrangler/state/v3/d1',
  });

  const db = (await mf.getD1Database('DB')) as D1Database;
  const authKey = '7635eb78-dc24-4f05-8287-ac391e233b15';
  const testStdJobCl = '1110'; // 의회 의원·고위 공무원

  console.log(`📊 Test: stdJobCl = ${testStdJobCl}\n`);

  // Step 1: Fetch job codes
  const listUrl = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212L50.do');
  listUrl.searchParams.append('authKey', authKey);
  listUrl.searchParams.append('returnType', 'XML');
  listUrl.searchParams.append('target', 'dJobCD');
  listUrl.searchParams.append('startPage', '1');
  listUrl.searchParams.append('display', '100');
  listUrl.searchParams.append('srchType', 'J');
  listUrl.searchParams.append('stdJobCl', testStdJobCl);

  console.log('🔍 Step 1: Fetching job list...');
  const listResponse = await fetch(listUrl.toString());
  const listXml = await listResponse.text();
  console.log(`   Response: ${listXml.length} bytes`);

  const listDoc = parseXML(listXml);
  const dJobListElements = listDoc.getElementsByTagName('dJobList');
  console.log(`   ✅ Found ${dJobListElements.length} jobs\n`);

  if (dJobListElements.length === 0) {
    console.log('❌ No jobs found. Exiting.');
    process.exit(1);
  }

  // Test first 3 jobs only
  const testJobs = Array.from({ length: Math.min(3, dJobListElements.length) }, (_, i) => {
    const jobEl = dJobListElements[i];
    return {
      dJobCd: getElementText(jobEl, 'dJobCd')!,
      dJobCdSeq: getElementText(jobEl, 'dJobCdSeq')!,
      dJobNm: getElementText(jobEl, 'dJobNm')!,
    };
  });

  console.log('📋 Testing jobs:');
  testJobs.forEach((j, i) => console.log(`   ${i + 1}. ${j.dJobNm} (${j.dJobCd}:${j.dJobCdSeq})`));
  console.log();

  // Step 2: Fetch details and save
  console.log('🔍 Step 2: Fetching details and saving...\n');

  for (const job of testJobs) {
    const detailUrl = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212D50.do');
    detailUrl.searchParams.append('authKey', authKey);
    detailUrl.searchParams.append('returnType', 'XML');
    detailUrl.searchParams.append('target', 'dJobDTL');
    detailUrl.searchParams.append('dJobCd', job.dJobCd);
    detailUrl.searchParams.append('dJobCdSeq', job.dJobCdSeq);

    try {
      console.log(`   📥 Fetching ${job.dJobNm}...`);
      const detailResponse = await fetch(detailUrl.toString());
      const detailXml = await detailResponse.text();

      if (detailXml.includes('정보가 존재하지 않습니다')) {
        console.log(`      ⚠️  No data available\n`);
        continue;
      }

      const detailDoc = parseXML(detailXml);
      const dJobsSumElements = detailDoc.getElementsByTagName('dJobsSum');

      if (!dJobsSumElements || dJobsSumElements.length === 0) {
        console.log(`      ⚠️  Failed to parse XML\n`);
        continue;
      }

      const dJobSum = dJobsSumElements[0];
      const detail = {
        dJobCd: getElementText(dJobSum, 'dJobCd'),
        dJobNm: getElementText(dJobSum, 'dJobNm'),
        workSum: getElementText(dJobSum, 'workSum'),
        doWork: getElementText(dJobSum, 'doWork'),
      };

      console.log(`      ✅ Parsed: ${detail.dJobNm}`);
      console.log(`         workSum: ${detail.workSum?.substring(0, 50)}...`);

      // Save to DB
      const sourceKey = `${job.dJobCd}:${job.dJobCdSeq}`;
      await db
        .prepare(
          `INSERT INTO job_sources (
            source_system, source_type, source_key, raw_payload, last_fetched_at
          ) VALUES (?, ?, ?, ?, datetime('now'))
          ON CONFLICT(source_system, source_key) DO UPDATE SET
            raw_payload = excluded.raw_payload,
            last_fetched_at = excluded.last_fetched_at`
        )
        .bind('WORK24_DJOB', 'DICTIONARY', sourceKey, JSON.stringify(detail))
        .run();

      console.log(`      💾 Saved to DB\n`);

      await sleep(300);
    } catch (error) {
      console.error(`      ❌ Error: ${error}\n`);
    }
  }

  // Verify
  console.log('🔍 Step 3: Verifying DB...\n');
  const result = await db
    .prepare(`SELECT COUNT(*) as count FROM job_sources WHERE source_system = 'WORK24_DJOB'`)
    .first<{ count: number }>();

  console.log(`   ✅ Total WORK24_DJOB records in DB: ${result?.count}\n`);
  console.log('✅ Test complete!\n');

  process.exit(0);
}

testSingleJobCode();

