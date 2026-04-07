/**
 * 콘텐츠 왜곡(content distortion) 전수조사 스크립트
 * API 방식으로 각 직업의 merged_profile vs UCJ 비교
 */

import fs from 'fs';

const BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';

const SLUGS = [
  '3d-프린팅-전문가', '3d프린팅모델러',
  'it-컨설턴트', 'it기술지원전문가', 'it테스터-및-it-qa전문가',
  'mlops-엔지니어', 'sns-마케터', 'ux-디자인-컨설턴트',
  '가구-디자이너', '가구조립-및-검사원', '가구조립원',
  '가사관리사', '가사도우미', '가상현실전문가', '가수',
  '가정교사', '가축사육자', '가축사육종사원',
  '게임-그래픽-디자이너', '게임-기획자',
  '네트워크-시스템-개발자', '네트워크-엔지니어',
  '노년-플래너', '노무사', '노점-및-이동판매원',
  '놀이치료사', '농림어업시험원', '농업교사',
  '농업용-및-기타기계장비설치-및-정비원', '농학연구원',
  '대기환경기술자-및-연구원', '대중가수',
];

async function fetchJSON(url, headers = {}) {
  const res = await fetch(url, { headers });
  if (!res.ok) return null;
  return res.json();
}

// prospect 왜곡 감지
function detectProspectDistortion(forecastText, ucjMain) {
  if (!forecastText || !ucjMain) return [];
  const flags = [];

  if (forecastText.includes('유지하거나 다소 증가') && !ucjMain.includes('유지') && ucjMain.includes('증가')) {
    flags.push('원문 "유지하거나 다소 증가" → UCJ "증가"만 언급 (과장)');
  }
  if (forecastText.includes('유지하거나') && ucjMain.match(/급증|폭발|빠르게 성장|크게 증가/)) {
    flags.push('원문은 보수적 전망인데 UCJ가 강한 증가 표현 사용');
  }
  if (forecastText.includes('감소') && !ucjMain.includes('감소') && ucjMain.includes('증가')) {
    flags.push('원문에 "감소" 있는데 UCJ는 "증가"만 언급');
  }
  if (forecastText.includes('어려울') && ucjMain.match(/증가|성장|확대/)) {
    flags.push('원문에 부정 전망 있는데 UCJ에는 긍정만');
  }
  return flags;
}

// [N] 마커 앞/뒤 출처 없는 문장 감지
function detectUnsourcedSentences(ucjText) {
  if (!ucjText) return [];
  const flags = [];

  // [1] 이후 문장이 2개 이상이면 의심
  const markerIdx = ucjText.indexOf('[1]');
  if (markerIdx >= 0 && markerIdx < ucjText.length * 0.5) {
    const afterMarker = ucjText.substring(markerIdx + 3).trim();
    const afterSentences = afterMarker
      .split(/(?<=[.!?])\s+/)
      .map(s => s.trim())
      .filter(s => s.length > 15 && !s.startsWith('['));
    if (afterSentences.length >= 2) {
      flags.push(`[1] 이후 출처 없는 문장 ${afterSentences.length}개 (첫 문장: "${afterSentences[0].substring(0, 60)}...")`);
    }
  }
  return flags;
}

// sal 기준 연도 누락 감지
function detectSalIssues(ucjSal) {
  if (!ucjSal) return [];
  const flags = [];
  if (!ucjSal.match(/\d{4}년/)) {
    flags.push('기준 연도 미표기 (YYYY년 없음)');
  }
  // sal에도 [1] 이후 무출처 문장 체크
  const unsourced = detectUnsourcedSentences(ucjSal);
  flags.push(...unsourced.map(f => `sal 무출처: ${f}`));
  return flags;
}

async function auditJob(slug) {
  const encoded = encodeURIComponent(slug);

  // merged 데이터 (forecastList, wageSource 등 원본 포함)
  const merged = await fetchJSON(`${BASE}/api/jobs/${encoded}`);
  if (!merged?.success) return { slug, status: 'not_found' };

  const md = merged.data || {};

  // edit-data: UCJ 필드 확인
  const editData = await fetchJSON(
    `${BASE}/api/job/${encoded}/edit-data`,
    { 'X-Admin-Secret': ADMIN_SECRET }
  );
  const ed = editData?.data || {};

  const name = md.name || slug;
  const issues = [];

  // 원본 forecastList 텍스트 추출
  const forecastList = md.overviewProspect?.forecastList || [];
  const forecastText = forecastList.map(f => f.forecast || '').join(' ');
  const jobSumProspect = md.overviewProspect?.jobSumProspect || '';

  // UCJ prospect (edit-data의 overviewProspect.main은 UCJ 값)
  const ucjProspect = ed.overviewProspect?.main || '';
  const ucjSal = ed.overviewSalary?.sal || '';
  const sources = ed._sources || {};

  // prospect 왜곡
  if (ucjProspect) {
    const combined = forecastText + ' ' + jobSumProspect;
    const pFlags = detectProspectDistortion(combined, ucjProspect);
    issues.push(...pFlags.map(f => `[PROSPECT 과장] ${f}`));

    const uFlags = detectUnsourcedSentences(ucjProspect);
    issues.push(...uFlags.map(f => `[PROSPECT 무출처] ${f}`));

    // prospect source가 없는데 내용이 있으면 경고
    if (!sources['overviewProspect.main'] && ucjProspect.length > 20) {
      issues.push('[PROSPECT] sources 등록 없음');
    }
  }

  // sal 이슈
  if (ucjSal) {
    const sFlags = detectSalIssues(ucjSal);
    issues.push(...sFlags.map(f => `[SAL] ${f}`));
  }

  return {
    slug, name,
    status: issues.length > 0 ? 'issues' : 'clean',
    issues,
    // 비교용 원문 요약
    forecast_original: forecastText.substring(0, 200),
    ucj_prospect_preview: ucjProspect.substring(0, 200),
    ucj_sal_preview: ucjSal.substring(0, 150),
    wage_source: (md.overviewSalary?.wageSource || '').substring(0, 150),
  };
}

async function main() {
  console.log('콘텐츠 왜곡 전수조사 시작');
  console.log(`대상: ${SLUGS.length}개 직업\n`);

  const results = [];

  for (const slug of SLUGS) {
    process.stdout.write(`  조사: ${slug}... `);
    const result = await auditJob(slug);

    if (result.status === 'not_found') {
      console.log('❓ DB 없음');
    } else if (result.status === 'issues') {
      console.log(`⚠️  ${result.issues.length}개 이슈`);
    } else {
      console.log('✅');
    }

    results.push(result);
    // rate limiting
    await new Promise(r => setTimeout(r, 300));
  }

  const issues = results.filter(r => r.status === 'issues');
  const clean = results.filter(r => r.status === 'clean');
  const notFound = results.filter(r => r.status === 'not_found');

  console.log('\n' + '='.repeat(60));
  console.log(`전수조사 완료: 총 ${SLUGS.length}개`);
  console.log(`  ⚠️  이슈: ${issues.length}개`);
  console.log(`  ✅ 정상: ${clean.length}개`);
  console.log(`  ❓ 없음: ${notFound.length}개`);
  console.log('='.repeat(60));

  if (issues.length > 0) {
    console.log('\n[이슈 상세]\n');
    for (const j of issues) {
      console.log(`━━ ${j.name} (${j.slug})`);
      for (const i of j.issues) console.log(`   ${i}`);
      if (j.forecast_original) {
        console.log(`   원문: "${j.forecast_original}"`);
      }
      if (j.ucj_prospect_preview) {
        console.log(`   UCJ:  "${j.ucj_prospect_preview}"`);
      }
      console.log('');
    }
  }

  fs.writeFileSync(
    'scripts/content-distortion-report.json',
    JSON.stringify({ generated: new Date().toISOString(), summary: { issues: issues.length, clean: clean.length, notFound: notFound.length }, issues, clean, notFound }, null, 2),
    'utf8'
  );
  console.log('\n리포트 저장: scripts/content-distortion-report.json');
}

main().catch(console.error);
