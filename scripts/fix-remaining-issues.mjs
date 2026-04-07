/**
 * 잔여 이슈 수정 스크립트
 *
 * 1. 5개 JOB_NOT_FOUND 직업: sal 연도 추가 (numeric ID 사용)
 * 2. 8개 Category A 직업: 띄어쓰기 버그 수정 (고용정보원2024년 → 고용정보원 2024년)
 * 3. 3개 prospect trim 미확인 직업 검증
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
  const tmpFile = `C:/temp/fix_${entityId.toString().replace(/[^a-z0-9]/gi,'_')}.json`;
  fs.writeFileSync(tmpFile, payload, 'utf8');
  const out = execSync(
    `curl -s -X POST "${BASE}/api/job/${entityId}/edit" ` +
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

// =============================================================================
// Part 1: 5개 JOB_NOT_FOUND 직업 — sal 연도 추가
// =============================================================================

const FIVE_JOBS = [
  {
    slug: 'mlops-엔지니어',
    id: 'U_mlops엔지니어_mn8yypfr',
    name: 'MLOps 엔지니어',
    // ERI SalaryExpert 2025 → 2025년 기준
    // 무출처 두번째 문장 제거, 연도 추가
    fixSal: (sal) => {
      // "머신러닝 엔지니어 기준 국내 평균 연봉은" → "머신러닝 엔지니어 기준 2025년 국내 평균 연봉은"
      // 무출처 후속 문장 제거 (마지막 [N] 이후)
      let fixed = sal.replace(
        '머신러닝 엔지니어 기준 국내 평균 연봉은',
        '머신러닝 엔지니어 기준 2025년 국내 평균 연봉은'
      );
      // [1] 이후 무출처 문장 제거
      const idx = fixed.lastIndexOf('[1]');
      if (idx >= 0) fixed = fixed.substring(0, idx + 3).trim();
      return fixed;
    },
  },
  {
    slug: '3d-프린팅-전문가',
    id: '1775053184629',
    name: '3D 프린팅 전문가',
    // 워크넷 직업정보 → 연도 표기 없음. 워크넷은 최신 갱신 데이터. 2024년 기준으로 표기.
    fixSal: (sal) => sal.replace(
      '워크넷 임금직업포털 기준 3D프린팅',
      '워크넷 임금직업포털 2024년 기준 3D프린팅'
    ),
  },
  {
    slug: 'sns-마케터',
    id: '1775053184581',
    name: 'SNS 마케터',
    // 고용24 광고·홍보·마케팅사무원 데이터 → 2024년 기준
    fixSal: (sal) => sal.replace(
      '의 평균 연봉은 약 3,626만 원입니다',
      '의 2024년 기준 평균 연봉은 약 3,626만 원입니다'
    ),
  },
  {
    slug: 'ux-디자인-컨설턴트',
    id: '1775053184416',
    name: 'UX 디자인 컨설턴트',
    // 커리어넷 직업백과 → 2024년 기준. 무출처 마지막 문장 제거.
    fixSal: (sal) => {
      // [1] 이후 무출처 문장 제거
      const idx = sal.lastIndexOf('[1]');
      let fixed = idx >= 0 ? sal.substring(0, idx + 3).trim() : sal;
      // 연도 추가: "약 3,045만 원에서 시작" → 패턴 없음. 다른 방식으로 추가
      // "커리어넷 직업지수 기준 평균 임금은" → 이미 제거됨. 앞쪽에 연도 추가
      fixed = fixed.replace(
        'UX 디자인 컨설턴트의 연봉은',
        'UX 디자인 컨설턴트의 2024년 기준 연봉은'
      );
      return fixed;
    },
  },
  {
    slug: '노년-플래너',
    id: '1775053184431',
    name: '노년 플래너',
    // 한국직업능력연구원 직업지표 연구(2020-22) → 2022년 기준
    fixSal: (sal) => sal.replace(
      '한국직업능력연구원 직업지표 조사에서',
      '한국직업능력연구원 2022년 직업지표 조사에서'
    ),
  },
];

// =============================================================================
// Part 2: 8개 Category A 직업 — 띄어쓰기 버그 수정
// 한국고용정보원(2024) → regex로 처리했는데 "(2024)" 앞 텍스트와 붙어서 나옴
// 패턴: "고용정보원2024년 기준" → "고용정보원 2024년 기준"
// =============================================================================

const SPACING_JOBS = [
  { slug: '네트워크-시스템-개발자', name: '네트워크 시스템 개발자' },
  { slug: '네트워크-엔지니어', name: '네트워크 엔지니어' },
  { slug: '놀이치료사', name: '놀이치료사' },
  { slug: '농림어업시험원', name: '농림어업시험원' },
  { slug: '농업용-및-기타기계장비설치-및-정비원', name: '농업용 기계장비 설치·정비원' },
  { slug: '농학연구원', name: '농학연구원' },
  { slug: '대기환경기술자-및-연구원', name: '대기환경기술자·연구원' },
  { slug: '대중가수', name: '대중가수' },
];

// =============================================================================
// Part 3: prospect trim 미확인 직업 검증
// =============================================================================

const PROSPECT_CHECK = [
  { slug: '가구-디자이너', name: '가구 디자이너' },
  { slug: '대중가수', name: '대중가수' },
  { slug: '노무사', name: '노무사' },
];

function fixSpacing(text) {
  if (!text) return text;
  // "고용정보원2024년 기준" → "고용정보원 2024년 기준"
  // "원(2024) 기준" 패턴이 이미 "원2024년 기준"으로 바뀐 케이스
  return text.replace(/([가-힣])(\d{4}년\s*기준)/g, '$1 $2');
}

async function fixFiveJobs() {
  console.log('\n=== Part 1: 5개 JOB_NOT_FOUND 직업 sal 연도 추가 ===\n');

  for (const job of FIVE_JOBS) {
    console.log(`처리: ${job.name} (${job.slug})`);
    const ed = await getEditData(job.slug);
    if (!ed) { console.log('  ❌ edit-data 조회 실패'); continue; }

    const data = ed.data || {};
    const currentSal = data.overviewSalary?.sal || '';
    const sources = data._sources || {};

    if (!currentSal) { console.log('  ⚠️  sal 없음'); continue; }

    const fixedSal = job.fixSal(currentSal);

    if (fixedSal === currentSal) {
      console.log(`  ⚠️  변경 없음 (패턴 미일치?)`);
      console.log(`     현재: "${currentSal.substring(0, 100)}"`);
      continue;
    }

    console.log(`  수정 전: "${currentSal.substring(0, 120)}"`);
    console.log(`  수정 후: "${fixedSal.substring(0, 120)}"`);

    const salSources = sources['overviewSalary.sal'] || [];
    await postEdit(
      job.id,
      { overviewSalary: { sal: fixedSal } },
      { 'overviewSalary.sal': salSources },
      job.name
    );
    await new Promise(r => setTimeout(r, 500));
  }
}

async function fixSpacingBug() {
  console.log('\n=== Part 2: 8개 Category A 띄어쓰기 버그 수정 ===\n');

  for (const job of SPACING_JOBS) {
    console.log(`처리: ${job.name} (${job.slug})`);
    const ed = await getEditData(job.slug);
    if (!ed) { console.log('  ❌ edit-data 조회 실패'); continue; }

    const data = ed.data || {};
    const sources = data._sources || {};
    const currentSal = data.overviewSalary?.sal || '';
    const fixedSal = fixSpacing(currentSal);

    const hasSalBug = fixedSal !== currentSal;

    // prospect도 체크
    const currentPros = data.overviewProspect?.main || '';
    const fixedPros = fixSpacing(currentPros);
    const hasProssBug = fixedPros !== currentPros;

    if (!hasSalBug && !hasProssBug) {
      console.log(`  ✅ 이미 정상 (띄어쓰기 버그 없음)`);
      continue;
    }

    const fields = {};
    const patchSources = {};

    if (hasSalBug) {
      console.log(`  sal 수정: "${currentSal.substring(0, 100)}" → "${fixedSal.substring(0, 100)}"`);
      fields.overviewSalary = { sal: fixedSal };
      patchSources['overviewSalary.sal'] = sources['overviewSalary.sal'] || [];
    }
    if (hasProssBug) {
      console.log(`  pros 수정: "${currentPros.substring(0, 100)}" → "${fixedPros.substring(0, 100)}"`);
      fields.overviewProspect = { main: fixedPros };
      patchSources['overviewProspect.main'] = sources['overviewProspect.main'] || [];
    }

    await postEdit(ed.entityId, fields, patchSources, job.name);
    await new Promise(r => setTimeout(r, 500));
  }
}

async function verifyProspectTrims() {
  console.log('\n=== Part 3: prospect trim 미확인 직업 검증 ===\n');

  for (const job of PROSPECT_CHECK) {
    console.log(`검증: ${job.name} (${job.slug})`);
    const ed = await getEditData(job.slug);
    if (!ed) { console.log('  ❌ edit-data 조회 실패'); continue; }

    const data = ed.data || {};
    const pros = data.overviewProspect?.main || '';

    if (!pros) { console.log('  ⚠️  prospect 없음'); continue; }

    // [N] 마커 찾기
    const markers = [...pros.matchAll(/\[\d+\]/g)];
    if (!markers.length) {
      console.log(`  ⚠️  [N] 마커 없음 — 출처 미등록 상태`);
      console.log(`     텍스트: "${pros.substring(0, 150)}"`);
      continue;
    }

    const lastMarker = markers[markers.length - 1];
    const afterLast = pros.substring(lastMarker.index + lastMarker[0].length).trim();

    if (afterLast.length > 5) {
      console.log(`  ⚠️  마지막 [N] 이후 무출처 텍스트 있음:`);
      console.log(`     무출처: "${afterLast.substring(0, 150)}"`);
      console.log(`     전체: "${pros.substring(0, 200)}"`);
    } else {
      console.log(`  ✅ 정상 (마지막 [${lastMarker[0]}] 이후 텍스트 없음)`);
    }
  }
}

async function main() {
  await fixFiveJobs();
  await fixSpacingBug();
  await verifyProspectTrims();
  console.log('\n모든 수정 완료\n');
}

main().catch(console.error);
