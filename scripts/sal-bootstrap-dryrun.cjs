#!/usr/bin/env node
// WORK24 sal 부트스트랩 dry-run — 9개 sample 직업의 임금 데이터 + 연도 확인
// DB write 없음, 호출만

const fs = require('fs');
const path = require('path');

// 키 로드: process.env 우선, 없으면 main .dev.vars 자동 탐색
function loadAuthKey() {
  if (process.env.GOYONG24_JOB_API_KEY) return process.env.GOYONG24_JOB_API_KEY.trim();
  // worktree에서 실행되어도 main repo의 .dev.vars를 찾도록 ascend
  let dir = __dirname;
  for (let i = 0; i < 6; i++) {
    const candidate = path.join(dir, '.dev.vars');
    if (fs.existsSync(candidate)) {
      const m = fs.readFileSync(candidate, 'utf8').match(/GOYONG24_JOB_API_KEY=(.+)/);
      if (m) return m[1].trim();
    }
    const parent = path.dirname(dir);
    if (parent === dir) break;
    dir = parent;
  }
  console.error('GOYONG24_JOB_API_KEY missing — set env var or place .dev.vars at repo root');
  process.exit(1);
}
const AUTH_KEY = loadAuthKey();

const BASE = 'https://www.work24.go.kr/cm/openApi/call/wk';

// [원본 슬러그, 대체 키워드들 (WORK24 매칭 시도 우선순위)]
const SAMPLES = [
  ['재활의학과전문의사', ['재활의학과전문의사','전문의','의사']],
  ['조산사', ['조산사']],
  ['약국약사', ['약국약사','약사']],
  ['작사가', ['작사가','대중음악가','음악가']],
  ['희극배우', ['희극배우','코미디언','개그맨','배우']],
  ['박물관관리자', ['박물관관리자','학예사','큐레이터']],
  ['재무설계사', ['재무설계사','자산관리사']],
  ['총무인사관리자', ['총무인사관리자','인사관리자','인사담당자']],
  ['최고재무책임자', ['최고재무책임자','CFO','임원','경영자']],
];

// WORK24 직업 list 검색 (keyword)
async function searchJob(keyword) {
  const url = new URL(`${BASE}/callOpenApiSvcInfo212L01.do`);
  url.searchParams.set('authKey', AUTH_KEY);
  url.searchParams.set('returnType', 'XML');
  url.searchParams.set('target', 'JOBCD');
  url.searchParams.set('srchType', 'K');
  url.searchParams.set('keyword', keyword);
  const res = await fetch(url.toString());
  return await res.text();
}

// salProspect 섹션 (jobCd 기반) — target=JOBDTL + jobGb=1 필수
async function fetchSalProspect(jobCd) {
  const url = new URL(`${BASE}/callOpenApiSvcInfo212D04.do`);
  url.searchParams.set('authKey', AUTH_KEY);
  url.searchParams.set('returnType', 'XML');
  url.searchParams.set('target', 'JOBDTL');
  url.searchParams.set('jobGb', '1');
  url.searchParams.set('jobCd', jobCd);
  url.searchParams.set('dtlGb', '4');
  const res = await fetch(url.toString());
  return await res.text();
}

// XML 단순 parser (top-level tag 첫 매칭)
function getValue(xml, tag) {
  const re = new RegExp(`<${tag}>([\\s\\S]*?)</${tag}>`);
  const m = xml.match(re);
  if (!m) return '';
  return m[1].replace(/<!\[CDATA\[([\s\S]*?)\]\]>/g, '$1').trim();
}

function getAllNodes(xml, tag) {
  const re = new RegExp(`<${tag}>([\\s\\S]*?)</${tag}>`, 'g');
  const out = [];
  let m;
  while ((m = re.exec(xml)) !== null) out.push(m[1]);
  return out;
}

// sal 텍스트에서 연도 추출 (예: "조사년도:2023년")
function extractYear(salText) {
  if (!salText) return null;
  const m = salText.match(/(\d{4})\s*년/);
  return m ? parseInt(m[1], 10) : null;
}

// sal 텍스트에서 임금 데이터 완전성 검사 (하위/평균/상위)
function checkCompleteness(salText) {
  if (!salText) return { complete: false, missing: ['empty'] };
  const has = {
    lower: /하위.*?\d/.test(salText),
    middle: /(평균|중앙값).*?\d/.test(salText),
    upper: /상위.*?\d/.test(salText),
  };
  const missing = Object.entries(has).filter(([_,v]) => !v).map(([k]) => k);
  return { complete: missing.length === 0, missing, has };
}

(async () => {
  const results = [];
  for (const [slug, candidates] of SAMPLES) {
    console.log(`\n━━━ ${slug} ━━━`);
    try {
      let items = [];
      let usedKeyword = null;
      for (const kw of candidates) {
        const listXml = await searchJob(kw);
        const total = Number(getValue(listXml, 'total') || '0');
        items = getAllNodes(listXml, 'jobList').map(itemXml => ({
          jobCd: getValue(itemXml, 'jobCd'),
          jobNm: getValue(itemXml, 'jobNm'),
          jobClcdNm: getValue(itemXml, 'jobClcdNM'),
        }));
        console.log(`  [${kw}] total=${total} items=${items.length}`);
        if (items.length > 0) { usedKeyword = kw; break; }
      }
      items.slice(0,5).forEach(it => console.log(`    - ${it.jobCd} | ${it.jobNm} | ${it.jobClcdNm}`));

      if (items.length === 0) {
        results.push({ slug, status: 'NO_MATCH', tried: candidates });
        continue;
      }

      // 가장 적합한 jobCd 선택 — 직업명 정확 일치 우선
      let best = items.find(it => it.jobNm === slug) || items.find(it => it.jobNm === usedKeyword) || items[0];
      console.log(`  → using jobCd=${best.jobCd} (${best.jobNm}) via "${usedKeyword}"`);

      const detailXml = await fetchSalProspect(best.jobCd);
      const sal = getValue(detailXml, 'sal');
      const jobSatis = getValue(detailXml, 'jobSatis');
      const jobProspect = getValue(detailXml, 'jobProspect');
      // 연도 추출
      const year = extractYear(sal);
      const completeness = checkCompleteness(sal);

      console.log(`  sal: ${sal ? sal.slice(0, 200) : '(empty)'}`);
      console.log(`  연도: ${year || '(unknown)'} | 완전성: ${completeness.complete ? 'OK' : 'PARTIAL ('+completeness.missing.join(',')+')'}`);

      results.push({
        slug,
        jobCd: best.jobCd,
        jobNm: best.jobNm,
        usedKeyword,
        sal,
        year,
        complete: completeness.complete,
        missing: completeness.missing,
        sameName: best.jobNm === slug,
      });
    } catch (e) {
      console.log(`  ERROR: ${e.message}`);
      results.push({ slug, status: 'ERROR', err: e.message });
    }
  }

  // 합격 판정
  console.log(`\n${"━".repeat(70)}`);
  console.log(`📊 합격 판정 (3년 이내 2023~2025 + 데이터 완전)`);
  console.log("━".repeat(70));
  console.log(`slug                 jobCd    연도   완전 사용가능?`);
  let pass = 0;
  for (const r of results) {
    if (r.status === 'NO_MATCH' || r.status === 'ERROR') {
      console.log(`${r.slug.padEnd(20)} -        -      -    NO (${r.status})`);
      continue;
    }
    const yearOK = r.year !== null && r.year >= 2023 && r.year <= 2025;
    const usable = yearOK && r.complete;
    if (usable) pass++;
    console.log(`${r.slug.padEnd(20)} ${(r.jobCd||"").padEnd(11)} ${String(r.year||"-").padEnd(5)} ${r.complete?"✓":"✗"}    ${r.sameName?"✓":"~"}        ${(r.jobNm||"").padEnd(15)} ${usable?"✅":"❌"}`);
  }
  console.log("━".repeat(70));
  console.log(`합격: ${pass}/${results.length}`);
  console.log(`판정: ${pass >= 6 ? '✅ 풀 사이클 진행 가능 (사용자 승인 후)' : '🔶 보류 권장 (5개 이하)'}`);
})();
