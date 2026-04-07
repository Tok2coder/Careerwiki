/**
 * 무출처 문장 감지 로직 테스트 스크립트
 *
 * 대상: 기존 처리된 32개 직업의 현재 DB 데이터
 * 검증 필드: way, overviewSalary.sal, overviewProspect.main, trivia
 *
 * 감지 로직:
 * 1. 마지막 [N] 이후에 10자 이상의 완성 문장 존재 → WARN
 * 2. [N] 마커가 전혀 없는데 30자 이상의 서술 텍스트 존재 → WARN
 */

const BASE = 'https://careerwiki.org';

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

// 검증 대상 필드 (필드경로 → merged JSON 접근 경로)
const CHECK_FIELDS = [
  { key: 'way',                   path: d => d.way },
  { key: 'overviewSalary.sal',    path: d => d.overviewSalary?.sal },
  { key: 'overviewProspect.main', path: d => d.overviewProspect?.main },
  { key: 'trivia',                path: d => d.trivia },
];

// ──────────────────────────────────────────────
// 무출처 문장 감지 함수 (검증 로직 핵심)
// ──────────────────────────────────────────────
function detectUnsourcedSentences(text, fieldKey) {
  const issues = [];
  if (!text || typeof text !== 'string') return issues;

  const trimmed = text.trim();
  if (trimmed.length < 10) return issues;

  // 모든 [N] 마커 위치 추출
  const allMarkers = [...trimmed.matchAll(/\[\d+\]/g)];

  // Case 1: [N] 마커가 전혀 없는 서술 텍스트
  if (allMarkers.length === 0) {
    // 완성 문장 여부 확인 (한국어 "~다." / "~습니다." 패턴)
    const hasSentence = /[가-힣]{3,}[다요]./.test(trimmed);
    if (hasSentence && trimmed.length >= 30) {
      issues.push({
        type: 'NO_MARKER',
        field: fieldKey,
        detail: `[N] 마커 없음 (${trimmed.length}자) — 전체 미출처`,
        preview: trimmed.substring(0, 80),
      });
    }
    return issues;
  }

  // Case 2: 마지막 [N] 이후 trailing 텍스트 감지
  const lastMarker = allMarkers[allMarkers.length - 1];
  const afterLast = trimmed.substring(lastMarker.index + lastMarker[0].length).trim();

  if (afterLast.length >= 10) {
    // 완성 문장 여부: "~다." / "~습니다." / "~입니다." 로 끝나거나 20자 이상
    const hasFinalEnding = /[다요]\.|습니다\.|입니다\.|됩니다\.|합니다\./.test(afterLast);
    const isSubstantial = afterLast.length >= 20;

    if (hasFinalEnding || isSubstantial) {
      issues.push({
        type: 'TRAILING_SENTENCE',
        field: fieldKey,
        detail: `마지막 ${lastMarker[0]} 이후 미출처 문장 (${afterLast.length}자)`,
        preview: afterLast.substring(0, 100),
      });
    }
  }

  return issues;
}

// ──────────────────────────────────────────────
// 직업별 조회 및 검증
// ──────────────────────────────────────────────
async function checkJob(slug) {
  const enc = encodeURIComponent(slug);
  const res = await fetch(`${BASE}/api/jobs/${enc}`);
  if (!res.ok) return { slug, status: 'not_found', issues: [] };

  const d = await res.json();
  if (!d.success) return { slug, status: 'not_found', issues: [] };

  const data = d.data || {};
  const allIssues = [];

  for (const { key, path } of CHECK_FIELDS) {
    const text = path(data);
    const issues = detectUnsourcedSentences(text, key);
    allIssues.push(...issues);
  }

  return {
    slug,
    name: data.name || slug,
    status: allIssues.length > 0 ? 'warn' : 'pass',
    issues: allIssues,
  };
}

// ──────────────────────────────────────────────
// 실행
// ──────────────────────────────────────────────
async function main() {
  console.log('무출처 문장 감지 테스트 시작');
  console.log(`대상: ${SLUGS.length}개 직업, 필드: ${CHECK_FIELDS.map(f=>f.key).join(', ')}\n`);

  const results = [];

  for (const slug of SLUGS) {
    process.stdout.write(`  ${slug}... `);
    const r = await checkJob(slug);

    if (r.status === 'not_found') {
      console.log('❓ 없음');
    } else if (r.status === 'warn') {
      console.log(`⚠️  ${r.issues.length}개`);
    } else {
      console.log('✅');
    }

    results.push(r);
    await new Promise(r => setTimeout(r, 200));
  }

  const warns = results.filter(r => r.status === 'warn');
  const passes = results.filter(r => r.status === 'pass');
  const notFound = results.filter(r => r.status === 'not_found');

  console.log('\n' + '='.repeat(60));
  console.log(`결과: 총 ${SLUGS.length}개`);
  console.log(`  ✅ PASS: ${passes.length}개`);
  console.log(`  ⚠️  WARN: ${warns.length}개`);
  console.log(`  ❓ 없음: ${notFound.length}개`);
  console.log('='.repeat(60));

  // 경고 상세 출력
  if (warns.length > 0) {
    console.log('\n[경고 상세]\n');
    for (const r of warns) {
      console.log(`━━ ${r.name} (${r.slug})`);
      for (const issue of r.issues) {
        console.log(`  [${issue.type}] ${issue.field}: ${issue.detail}`);
        console.log(`  preview: "${issue.preview}"`);
      }
      console.log('');
    }
  }

  // 오탐 가능성 분석
  console.log('\n[오탐 가능성 분석]');
  console.log('- TRAILING_SENTENCE: 마지막 [N] 이후 문장 → 실제 무출처일 가능성 높음');
  console.log('- NO_MARKER: 마커 없음 → sal에서 연도만 있는 텍스트, wlb 등에서 오탐 가능');
  console.log(`\n경고 발생률: ${warns.length}/${SLUGS.length} (${Math.round(warns.length/SLUGS.length*100)}%)`);

  // 유형별 통계
  const byType = {};
  for (const r of warns) {
    for (const issue of r.issues) {
      byType[issue.type] = (byType[issue.type] || 0) + 1;
    }
  }
  console.log('유형별:', Object.entries(byType).map(([k,v])=>`${k}=${v}개`).join(', '));
}

main().catch(console.error);
