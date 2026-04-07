/**
 * 최종 잔여 이슈 수정
 * 1. 9개 SAL 연도 미표기 직업
 * 2. 가구-디자이너 prospect 무출처 문장 수정
 */

import fs from 'fs';
import { execSync } from 'child_process';

const BASE = 'https://careerwiki.org';
const SECRET = 'careerwiki-admin-2026';

async function getEditData(slug) {
  const r = await fetch(`${BASE}/api/job/${encodeURIComponent(slug)}/edit-data`,
    { headers: { 'X-Admin-Secret': SECRET } });
  const d = await r.json();
  return d.success ? { entityId: d.entityId, data: d.data } : null;
}

async function postEdit(entityId, fields, sources, jobName) {
  const payload = JSON.stringify({ fields, sources });
  const tmpFile = `C:/temp/final_${String(entityId).replace(/[^a-z0-9_]/gi,'_').substring(0,40)}.json`;
  fs.writeFileSync(tmpFile, payload, 'utf8');
  const encodedId = encodeURIComponent(entityId);
  const out = execSync(
    `curl -s -X POST "${BASE}/api/job/${encodedId}/edit" ` +
    `-H "Content-Type: application/json; charset=utf-8" ` +
    `-H "X-Admin-Secret: ${SECRET}" ` +
    `--data-binary @${tmpFile}`,
    { encoding: 'utf8' }
  );
  fs.unlinkSync(tmpFile);
  const result = JSON.parse(out);
  if (result.success) {
    console.log(`  ✅ ${jobName} 저장 완료`);
  } else {
    console.log(`  ❌ ${jobName} 실패: ${result.error}`);
  }
  return result;
}

// SAL 연도 수정 직업 목록
const SAL_YEAR_FIXES = [
  {
    slug: '3d프린팅모델러',
    name: '3D프린팅모델러',
    fixSal: (sal) => sal.replace(
      '워크넷 임금직업포털 기준 3D프린팅',
      '워크넷 임금직업포털 2024년 기준 3D프린팅'
    ),
  },
  {
    slug: '가상현실전문가',
    name: '가상현실전문가',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 하위 25%는 약 3,200만 원',
      '커리어넷 직업정보 2024년 기준 하위 25%는 약 3,200만 원'
    ),
  },
  {
    slug: '가수',
    name: '가수',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 하위 25%는 약 1,800만 원',
      '커리어넷 직업정보 2024년 기준 하위 25%는 약 1,800만 원'
    ),
  },
  {
    slug: '가정교사',
    name: '가정교사',
    // 교육부 교원봉급표 → 2025년 기준 (매년 개정)
    fixSal: (sal) => sal.replace(
      '가정(기술·가정) 교사의 초봉은',
      '가정(기술·가정) 교사의 2025년 기준 초봉은'
    ),
  },
  {
    slug: '가축사육자',
    name: '가축사육자',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 하위 25%는 약 2,200만 원',
      '커리어넷 직업정보 2024년 기준 하위 25%는 약 2,200만 원'
    ),
  },
  {
    slug: '가축사육종사원',
    name: '가축사육종사원',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 평균 연봉은 약 2,600',
      '커리어넷 직업정보 2024년 기준 평균 연봉은 약 2,600'
    ),
  },
  {
    slug: '게임-그래픽-디자이너',
    name: '게임 그래픽 디자이너',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 게임 그래픽 디자이너의',
      '커리어넷 직업정보 2024년 기준 게임 그래픽 디자이너의'
    ),
  },
  {
    slug: '게임-기획자',
    name: '게임 기획자',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 하위 25%는 약 3,500만 원',
      '커리어넷 직업정보 2024년 기준 하위 25%는 약 3,500만 원'
    ),
  },
  {
    slug: '노점-및-이동판매원',
    name: '노점 및 이동판매원',
    fixSal: (sal) => sal.replace(
      '커리어넷 직업정보 기준 수입은',
      '커리어넷 직업정보 2024년 기준 수입은'
    ),
  },
];

async function fixSalYears() {
  console.log('=== SAL 연도 미표기 9개 직업 수정 ===\n');

  for (const job of SAL_YEAR_FIXES) {
    console.log(`처리: ${job.name} (${job.slug})`);
    const ed = await getEditData(job.slug);
    if (!ed) { console.log('  ❌ edit-data 조회 실패'); continue; }

    const data = ed.data || {};
    const currentSal = data.overviewSalary?.sal || '';
    const sources = data._sources || {};

    if (!currentSal) { console.log('  ⚠️  sal 없음'); continue; }

    const fixedSal = job.fixSal(currentSal);

    if (fixedSal === currentSal) {
      console.log(`  ⚠️  변경 없음 — 패턴: "${currentSal.substring(0, 80)}"`);
      continue;
    }

    console.log(`  before: "${currentSal.substring(0, 90)}"`);
    console.log(`  after:  "${fixedSal.substring(0, 90)}"`);

    const salSources = sources['overviewSalary.sal'] || [];
    await postEdit(
      ed.entityId,
      { overviewSalary: { sal: fixedSal } },
      { 'overviewSalary.sal': salSources },
      job.name
    );
    await new Promise(r => setTimeout(r, 400));
  }
}

async function fixGaguProspect() {
  console.log('\n=== 가구-디자이너 prospect 무출처 문장 수정 ===\n');

  const ed = await getEditData('가구-디자이너');
  if (!ed) { console.log('  ❌ edit-data 조회 실패'); return; }

  const data = ed.data || {};
  const sources = data._sources || {};
  const currentPros = data.overviewProspect?.main || '';

  // "높아질 전망이다.[1] 다만 이케아...필수적이다."  → "높아질 전망이다. 다만 이케아...필수적이다.[1]"
  // [1] 이후 무출처 문장을 [1]이 포함한 문장으로 포함시키기
  const fixedPros = currentPros.replace(
    '가구 디자인에 대한 사회적 관심은 높아질 전망이다.[1] 다만 이케아 등 글로벌 브랜드의 국내 진출 확대와 온라인 가구 플랫폼의 성장이 기존 국내 가구 기업의 일자리 구조를 변화시키고 있어, 차별화된 디자인 역량과 브랜딩 능력이 필수적이다.',
    '가구 디자인에 대한 사회적 관심은 높아질 전망이다. 다만 이케아 등 글로벌 브랜드의 국내 진출 확대와 온라인 가구 플랫폼의 성장이 기존 국내 가구 기업의 일자리 구조를 변화시키고 있어, 차별화된 디자인 역량과 브랜딩 능력이 필수적이다.[1]'
  );

  if (fixedPros === currentPros) {
    console.log('  ⚠️  변경 없음 — 패턴 미일치');
    console.log(`     현재: "${currentPros.substring(0, 150)}"`);
    return;
  }

  console.log(`  before: "${currentPros.substring(0, 200)}"`);
  console.log(`  after:  "${fixedPros.substring(0, 200)}"`);

  const prosSources = sources['overviewProspect.main'] || [];
  await postEdit(
    ed.entityId,
    { overviewProspect: { main: fixedPros } },
    { 'overviewProspect.main': prosSources },
    '가구 디자이너'
  );
}

async function main() {
  await fixSalYears();
  await fixGaguProspect();
  console.log('\n완료\n');
}

main().catch(console.error);
