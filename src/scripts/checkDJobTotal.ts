/**
 * 직업사전 API 총 직업 수 확인 스크립트
 * 다양한 검색 방법으로 총 건수 파악
 */

import { DOMParser } from '@xmldom/xmldom';

const AUTH_KEY = process.env.GOYONG24_JOB_API_KEY || '7635eb78-dc24-4f05-8287-ac391e233b15';

function parseXML(xmlText: string): Document {
  const parser = new DOMParser();
  return parser.parseFromString(xmlText, 'text/xml');
}

function getElementText(doc: Document, tagName: string): string | null {
  const elements = doc.getElementsByTagName(tagName);
  if (elements && elements.length > 0) {
    return elements[0].textContent || null;
  }
  return null;
}

// 직업사전 목록 API 호출 - total 값 확인
async function fetchDJobListTotal(srchType: string, params: Record<string, string>): Promise<{ total: number; display: number; startPage: number }> {
  const url = new URL('https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo212L50.do');
  url.searchParams.append('authKey', AUTH_KEY);
  url.searchParams.append('returnType', 'XML');
  url.searchParams.append('target', 'dJobCD');
  url.searchParams.append('startPage', '1');
  url.searchParams.append('display', '10');
  url.searchParams.append('srchType', srchType);
  
  for (const [key, value] of Object.entries(params)) {
    url.searchParams.append(key, value);
  }
  
  console.log(`\n🔍 API 호출: srchType=${srchType}, params=${JSON.stringify(params)}`);
  console.log(`   URL: ${url.toString().substring(0, 120)}...`);
  
  try {
    const response = await fetch(url.toString());
    const xmlText = await response.text();
    
    // 에러 체크
    if (xmlText.includes('에러') || xmlText.includes('error')) {
      console.log(`   ❌ 에러 응답: ${xmlText.substring(0, 200)}`);
      return { total: 0, display: 0, startPage: 0 };
    }
    
    const doc = parseXML(xmlText);
    const total = parseInt(getElementText(doc, 'total') || '0', 10);
    const display = parseInt(getElementText(doc, 'display') || '0', 10);
    const startPage = parseInt(getElementText(doc, 'startPage') || '0', 10);
    
    console.log(`   ✅ total=${total}, display=${display}, startPage=${startPage}`);
    
    // 샘플 직업명 출력
    const dJobLists = doc.getElementsByTagName('dJobList');
    if (dJobLists.length > 0) {
      console.log(`   📋 샘플 직업 (${Math.min(3, dJobLists.length)}개):`);
      for (let i = 0; i < Math.min(3, dJobLists.length); i++) {
        const jobEl = dJobLists[i];
        const dJobNm = jobEl.getElementsByTagName('dJobNm')[0]?.textContent || '';
        const dJobCd = jobEl.getElementsByTagName('dJobCd')[0]?.textContent || '';
        console.log(`      - ${dJobNm} (${dJobCd})`);
      }
    }
    
    return { total, display, startPage };
  } catch (error) {
    console.log(`   ❌ 요청 실패: ${error}`);
    return { total: 0, display: 0, startPage: 0 };
  }
}

// 교육수준별 검색으로 전체 수 파악 시도
async function countByEducationLevel(): Promise<number> {
  console.log('\n📊 교육수준별 검색으로 총 직업 수 파악...');
  const eduLevels = ['1', '2', '3', '4', '5', '6']; // 1~6 (초졸 이하 ~ 대학원 이상)
  
  let totalCount = 0;
  const countByLevel: Record<string, number> = {};
  
  for (const level of eduLevels) {
    const result = await fetchDJobListTotal('EL', { eduLevel: level });
    countByLevel[level] = result.total;
    totalCount += result.total;
    await new Promise(r => setTimeout(r, 500)); // Rate limiting
  }
  
  console.log('\n📈 교육수준별 직업 수:');
  const eduLevelNames = ['초졸 이하', '중졸 정도', '고졸 정도', '전문대졸', '대졸 정도', '대학원 이상'];
  for (let i = 0; i < eduLevels.length; i++) {
    console.log(`   ${eduLevelNames[i]}: ${countByLevel[eduLevels[i]].toLocaleString()}개`);
  }
  console.log(`   ──────────────────`);
  console.log(`   합계: ${totalCount.toLocaleString()}개`);
  
  return totalCount;
}

// 한국고용직업분류별 검색으로 전체 수 파악
async function countByEmploymentClass(): Promise<number> {
  console.log('\n📊 한국고용직업분류 대분류별 검색으로 총 직업 수 파악...');
  
  // 한국고용직업분류 대분류 코드 (0~9)
  const empJobClCodes = ['01', '02', '03', '04', '05', '06', '07', '08', '09'];
  
  let totalCount = 0;
  const counts: Record<string, number> = {};
  
  for (const code of empJobClCodes) {
    const result = await fetchDJobListTotal('E', { empJobCl: code });
    counts[code] = result.total;
    totalCount += result.total;
    await new Promise(r => setTimeout(r, 500));
  }
  
  console.log('\n📈 한국고용직업분류 대분류별 직업 수:');
  for (const [code, count] of Object.entries(counts)) {
    if (count > 0) {
      console.log(`   ${code}: ${count.toLocaleString()}개`);
    }
  }
  console.log(`   ──────────────────`);
  console.log(`   합계: ${totalCount.toLocaleString()}개`);
  
  return totalCount;
}

// 한국표준직업분류별 검색 - 대분류 레벨
async function countByStandardJobClass(): Promise<number> {
  console.log('\n📊 한국표준직업분류 대분류별 검색으로 총 직업 수 파악...');
  
  // 한국표준직업분류 대분류 (0~9)
  const stdJobClCodes = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  
  let totalCount = 0;
  const counts: Record<string, number> = {};
  
  for (const code of stdJobClCodes) {
    const result = await fetchDJobListTotal('J', { stdJobCl: code });
    counts[code] = result.total;
    totalCount += result.total;
    await new Promise(r => setTimeout(r, 500));
  }
  
  console.log('\n📈 한국표준직업분류 대분류별 직업 수:');
  for (const [code, count] of Object.entries(counts)) {
    if (count > 0) {
      console.log(`   ${code}: ${count.toLocaleString()}개`);
    }
  }
  console.log(`   ──────────────────`);
  console.log(`   합계: ${totalCount.toLocaleString()}개`);
  
  return totalCount;
}

// 키워드 검색 테스트 - 빈 문자열/와일드카드 등
async function testKeywordSearch(): Promise<void> {
  console.log('\n📊 키워드 검색 테스트...');
  
  // 다양한 키워드로 테스트
  const keywords = ['', ' ', '*', '%', '가', '사', '원', '기사', '전문'];
  
  for (const keyword of keywords) {
    const encodedKeyword = encodeURIComponent(keyword);
    const result = await fetchDJobListTotal('K', { keyword: encodedKeyword || ' ' });
    console.log(`   키워드 "${keyword}": ${result.total.toLocaleString()}개`);
    await new Promise(r => setTimeout(r, 500));
  }
}

async function main() {
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('🔍 직업사전 API 총 직업 수 확인');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log(`📌 인증키: ${AUTH_KEY.substring(0, 8)}...`);
  
  // 1. 키워드 검색 테스트
  await testKeywordSearch();
  
  // 2. 교육수준별
  const eduTotal = await countByEducationLevel();
  
  // 3. 한국표준직업분류별
  const stdJobTotal = await countByStandardJobClass();
  
  // 4. 한국고용직업분류별
  const empJobTotal = await countByEmploymentClass();
  
  console.log('\n═══════════════════════════════════════════════════════════════');
  console.log('📊 최종 요약');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log(`   교육수준별 합계: ${eduTotal.toLocaleString()}개`);
  console.log(`   표준직업분류별 합계: ${stdJobTotal.toLocaleString()}개`);
  console.log(`   고용직업분류별 합계: ${empJobTotal.toLocaleString()}개`);
  console.log('\n⚠️  참고: 한국직업사전 공식 발표: 직업 12,823개, 직업명 16,981개');
  console.log('═══════════════════════════════════════════════════════════════');
}

main().catch(console.error);

