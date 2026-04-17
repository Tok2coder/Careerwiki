#!/usr/bin/env node
/**
 * rule-regression-tests.cjs
 *
 * 룰 A/B/C 회귀 테스트.
 * 각 룰에 대해 FAIL 케이스 2건 + PASS 케이스 2건을 fixture로 검증한다.
 *
 * Usage: node scripts/selfcheck/rule-regression-tests.cjs
 * package.json: "test:harness": "node scripts/selfcheck/rule-regression-tests.cjs"
 *
 * Exit codes:
 *   0 = 전체 PASS
 *   1 = 1개 이상 실패
 */

'use strict';

const path = require('path');
const {
  detectMissingFootnoteInArrayItems,
  analyzeYoutubeSearchNote,
  analyzeCareerTreeNote,
  detectMidFootnote,
} = require(path.join(__dirname, '..', '_shared', 'detect-patterns.cjs'));

const { execSync } = require('child_process');
const fs = require('fs');

// ── validate-job-edit.cjs 호출 헬퍼 ───────────────────────────────────────────
const VALIDATE_SCRIPT = path.join(__dirname, '..', 'validate-job-edit.cjs');
const PROJECT_ROOT = path.join(__dirname, '..', '..');

function runValidate(data) {
  const tmpFile = path.join(__dirname, '_test_tmp.json');
  try {
    fs.writeFileSync(tmpFile, JSON.stringify(data), 'utf8');
    const out = execSync(
      `node "${VALIDATE_SCRIPT}" < "${tmpFile}"`,
      { encoding: 'utf8', cwd: PROJECT_ROOT, timeout: 15000 }
    );
    return { exitCode: 0, output: out };
  } catch (e) {
    return { exitCode: e.status || 1, output: e.stdout || '' };
  } finally {
    if (fs.existsSync(tmpFile)) fs.unlinkSync(tmpFile);
  }
}

// ── 테스트 유틸 ───────────────────────────────────────────────────────────────
let passed = 0, failed = 0;

function assert(label, condition, detail = '') {
  if (condition) {
    console.log(`  ✅ ${label}`);
    passed++;
  } else {
    console.log(`  ❌ ${label}${detail ? ` — ${detail}` : ''}`);
    failed++;
  }
}

function assertContains(label, output, keyword) {
  assert(label, output.includes(keyword), `출력에 "${keyword}" 없음`);
}

function assertNotContains(label, output, keyword) {
  assert(label, !output.includes(keyword), `출력에 "${keyword}" 존재`);
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 A: detectMissingFootnoteInArrayItems
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 A: UCJ detailReady 배열 항목별 [N] 필수 ═══');

{
  // FAIL 케이스 1: 첫 번째 항목에 [N] 없음
  const items1 = [
    "대기업 및 중견기업 경영기획팀 채용 공고 지원",  // ← [N] 없음
    "컨설팅펌 컨설턴트 경력 후 이직[1]",
    "공공기관 채용 공고 지원[2]",
  ];
  const result1 = detectMissingFootnoteInArrayItems(items1);
  assert('FAIL-A1: 첫 항목 [N] 없음 감지', result1.length > 0 && result1.includes(0),
    `missing=[${result1}]`);

  // FAIL 케이스 2: 마지막 항목만 [N] 없음
  const items2 = [
    "경영학과 전공 이수[1]",
    "실무 인턴십 경험 축적[2]",
    "MBA 과정 진학",  // ← [N] 없음
  ];
  const result2 = detectMissingFootnoteInArrayItems(items2);
  assert('FAIL-A2: 마지막 항목 [N] 없음 감지', result2.length > 0 && result2.includes(2));

  // PASS 케이스 1: 모든 항목에 [N] 있음
  const items3 = [
    "대기업 경영기획팀 채용[1]",
    "컨설팅펌 이직[2]",
    "공공기관 채용[3]",
  ];
  const result3 = detectMissingFootnoteInArrayItems(items3);
  assert('PASS-A1: 모든 항목 [N] 있음', result3.length === 0, `missing=[${result3}]`);

  // PASS 케이스 2: 빈 배열
  const result4 = detectMissingFootnoteInArrayItems([]);
  assert('PASS-A2: 빈 배열 — 위반 없음', result4.length === 0);
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 B: analyzeYoutubeSearchNote
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 B: _youtubeSearchNote 탐색 깊이 ═══');

{
  // FAIL 케이스 1: 탐색어 2개, 카테고리 1개
  const note1 = "KEIS '기획관리자' 검색 0건, '기획관리자 현황' 검색 0건 (2026-04-16)";
  const r1 = analyzeYoutubeSearchNote(note1);
  assert('FAIL-B1: 탐색어 2개/카테고리 1개 → FAIL', !r1.pass,
    `termCount=${r1.termCount}, categoryCount=${r1.categoryCount}`);

  // FAIL 케이스 2: 탐색어 3개, 카테고리 2개
  const note2 = "KEIS '기획관리자' 0건, '경영기획 직무' 0건, '전략기획 인터뷰' 0건 (2026-04-16)";
  const r2 = analyzeYoutubeSearchNote(note2);
  assert('FAIL-B2: 탐색어 3개/카테고리 2개 → FAIL', !r2.pass,
    `termCount=${r2.termCount}, categoryCount=${r2.categoryCount}`);

  // PASS 케이스 1: 카테고리 3개 커버 (탐색어 4개)
  const note3 = "KEIS '기획관리자' 0건, '경영기획 현직자 인터뷰' 3건, '전략기획 직무' 2건, '경영기획 진로' 0건 (2026-04-16)";
  const r3 = analyzeYoutubeSearchNote(note3);
  assert('PASS-B1: 카테고리 3개(현직자·인터뷰/직무/진로) 커버 → PASS',
    r3.pass && r3.categoryCount >= 3, `termCount=${r3.termCount}, categoryCount=${r3.categoryCount}`);

  // PASS 케이스 2: 탐색어 6개 이상
  const note4 = "KEIS '기획관리자' 0건, '경영기획 직무' 0건, '전략기획 현직자' 0건, '경영기획 인터뷰' 0건, '기획관리자 면접' 0건, '전략기획 교육' 0건 (2026-04-16)";
  const r4 = analyzeYoutubeSearchNote(note4);
  assert('PASS-B2: 탐색어 6개 → PASS', r4.pass && r4.termCount >= 6,
    `termCount=${r4.termCount}`);
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 C: analyzeCareerTreeNote
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 C: _careerTreeNote 탐색 깊이 ═══');

{
  // FAIL 케이스 1: 후보 3명, 카테고리 2개
  const note1 = "조사 인물: 이재용(삼성 직업, 기획 경력 불명확), 최태원(SK 회장, 적합하지 않음), 이건희(대기업 회장, 별세) (2026-04-16)";
  const r1 = analyzeCareerTreeNote(note1);
  assert('FAIL-C1: 후보 3명/카테고리 2개 → FAIL', !r1.pass,
    `candidateCount=${r1.candidateCount}, categoryCount=${r1.categoryCount}`);

  // FAIL 케이스 2: 후보 4명, 카테고리 1개
  const note2 = "대기업 회장 탐색: 이재용(부적합), 최태원(부적합), 구광모(부적합), 정의선(부적합). 재벌 위주 탐색 후 적합 인물 없음.";
  const r2 = analyzeCareerTreeNote(note2);
  assert('FAIL-C2: 후보 4명/카테고리 1개 → FAIL', !r2.pass,
    `candidateCount=${r2.candidateCount}, categoryCount=${r2.categoryCount}`);

  // PASS 케이스 1: 카테고리 3개 커버
  const note3 = "이재용(대기업 삼성, 부적합), 김범석(스타트업 쿠팡 CxO, 외국인), 이진수(카카오 CEO, 적합), 공무원 출신 탐색(정부 관련 없음), 교수 출신 탐색(학계 관련 없음). 적합 인물 없음.";
  const r3 = analyzeCareerTreeNote(note3);
  assert('PASS-C1: 카테고리 3개 커버 → PASS', r3.pass,
    `candidateCount=${r3.candidateCount}, categoryCount=${r3.categoryCount}`);

  // PASS 케이스 2: 후보 5명 이상
  const note4 = "이재용(부적합), 최태원(부적합), 구광모(부적합), 정기선(부적합 — 이미 다른 직업 등록됨), 이정재(배우, 직종 불일치), 김주원(부적합). 적합 인물 없음.";
  const r4 = analyzeCareerTreeNote(note4);
  assert('PASS-C2: 후보 6명 → PASS', r4.pass && r4.candidateCount >= 5,
    `candidateCount=${r4.candidateCount}`);
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 A: validate-job-edit.cjs 통합 테스트
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 A: validate 통합 — FAIL/PASS 케이스 ═══');

{
  // FAIL: recruit 항목 중 [N] 없음
  const failPayload = {
    fields: {
      detailReady: {
        curriculum: ["경영학 전공[1]", "MBA 이수[2]"],
        recruit: [
          "대기업 채용 공고 지원",  // ← [N] 없음
          "컨설팅펌 이직[1]",
        ],
        training: ["한국생산성본부 교육[1]"],
      },
      way: "경영기획관리자가 되려면 관련 학과를 졸업해야 한다.[1]",
      _youtubeSearchNote: "KEIS '기획관리자' 0건, '경영기획 현직자 인터뷰' 0건, '전략기획 직무' 0건 (2026-04-16)",
    },
    sources: {
      way: [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" }],
      "detailReady.curriculum": [
        { id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" },
        { id: 2, text: "[2] 커리어넷", url: "https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=229" },
      ],
      "detailReady.recruit": [
        { id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" },
      ],
      "detailReady.training": [
        { id: 1, text: "[1] 한국생산성본부", url: "https://www.kpc.or.kr/" },
      ],
    },
    changeSummary: "테스트 케이스",
  };
  const r1 = runValidate(failPayload);
  assertContains('FAIL-A validate: [UCJ각주항목누락] 감지', r1.output, '[UCJ각주항목누락]');

  // PASS: 모든 항목에 [N] 있음
  const passPayload = {
    ...failPayload,
    fields: {
      ...failPayload.fields,
      detailReady: {
        curriculum: ["경영학 전공[1]", "MBA 이수[2]"],
        recruit: [
          "대기업 채용 공고 지원[1]",  // ← [N] 있음
          "컨설팅펌 이직[2]",
        ],
        training: ["한국생산성본부 교육[1]"],
      },
    },
    sources: {
      ...failPayload.sources,
      "detailReady.recruit": [
        { id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" },
        { id: 2, text: "[2] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" },
      ],
    },
  };
  const r2 = runValidate(passPayload);
  assertNotContains('PASS-A validate: [UCJ각주항목누락] 없음', r2.output, '[UCJ각주항목누락]');
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 B: validate — YouTubeNote얕음 FAIL/PASS
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 B: validate 통합 — YouTubeNote얕음 ═══');

{
  const basePayload = {
    fields: {
      youtubeLinks: [],
      way: "경영기획관리자가 되려면 관련 학과를 졸업해야 한다.[1]",
      detailReady: { curriculum: ["경영학 전공[1]"], recruit: ["대기업 채용[1]"], training: ["교육[1]"] },
    },
    sources: {
      way: [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" }],
      "detailReady.curriculum": [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/" }],
      "detailReady.recruit": [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/" }],
      "detailReady.training": [{ id: 1, text: "[1] 한국생산성본부", url: "https://www.kpc.or.kr/" }],
    },
    changeSummary: "테스트 케이스",
  };

  // FAIL: 탐색어 1개, 카테고리 0개
  const failPayload = {
    ...basePayload,
    fields: {
      ...basePayload.fields,
      _youtubeSearchNote: "KEIS '기획관리자' 검색 0건 (2026-04-16)",
    },
  };
  const r1 = runValidate(failPayload);
  assertContains('FAIL-B validate: [YouTubeNote얕음] 감지', r1.output, '[YouTubeNote얕음]');

  // PASS: 카테고리 3개 커버
  const passPayload = {
    ...basePayload,
    fields: {
      ...basePayload.fields,
      _youtubeSearchNote: "KEIS '기획관리자' 0건, '경영기획 현직자 인터뷰' 0건, '전략기획 직무' 0건, '경영기획 진로' 0건 (2026-04-16)",
    },
  };
  const r2 = runValidate(passPayload);
  assertNotContains('PASS-B validate: [YouTubeNote얕음] 없음', r2.output, '[YouTubeNote얕음]');
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 C: validate — CareerTreeNote얕음 FAIL/PASS
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 C: validate 통합 — CareerTreeNote얕음 ═══');

{
  const basePayload = {
    careerTree: null,
    fields: {
      way: "기획관리자가 되려면 관련 학과를 졸업해야 한다.[1]",
      detailReady: { curriculum: ["경영학 전공[1]"], recruit: ["대기업 채용[1]"], training: ["교육[1]"] },
      _youtubeSearchNote: "KEIS '기획관리자' 0건, '경영기획 현직자 인터뷰' 0건, '전략기획 직무' 0건, '경영기획 진로' 0건 (2026-04-16)",
    },
    sources: {
      way: [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896" }],
      "detailReady.curriculum": [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/" }],
      "detailReady.recruit": [{ id: 1, text: "[1] 잡코리아", url: "https://www.jobkorea.co.kr/" }],
      "detailReady.training": [{ id: 1, text: "[1] 한국생산성본부", url: "https://www.kpc.or.kr/" }],
    },
    changeSummary: "테스트 케이스",
  };

  // FAIL: 후보 2명, 카테고리 1개
  const failPayload = {
    ...basePayload,
    _careerTreeNote: "이재용(삼성, 부적합), 최태원(SK, 부적합). 적합 인물 없음.",
  };
  const r1 = runValidate(failPayload);
  assertContains('FAIL-C validate: [CareerTreeNote얕음] 감지', r1.output, '[CareerTreeNote얕음]');

  // PASS: 후보 5명 이상
  const passPayload = {
    ...basePayload,
    _careerTreeNote: "이재용(삼성, 부적합), 최태원(SK, 부적합), 구광모(LG, 부적합), 정의선(현대, 부적합), 이진수(카카오, 부적합), 김범석(쿠팡, 외국 거주). 적합 인물 없음.",
  };
  const r2 = runValidate(passPayload);
  assertNotContains('PASS-C validate: [CareerTreeNote얕음] 없음', r2.output, '[CareerTreeNote얕음]');
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 D: detectMidFootnote — trivia 각주 중간 위치 탐지
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 D: trivia 각주 중간 위치 탐지 ═══');

{
  // FAIL 케이스 1: 단일 [1]이 첫 번째 문장 뒤에, 뒤에 2문장이 무출처
  const text1 = '한국에는 임상심리사 관련 자격 체계가 세 가지 병존한다.[1] 한국산업인력공단의 국가기술자격이다. 직무에 따라 취득 순서를 설계해야 한다.';
  const r1 = detectMidFootnote(text1);
  assert('FAIL-D1: [1] 뒤에 두 문장 잔존 → 탐지', r1 !== null && r1.length > 5,
    `remnant="${r1}"`);

  // FAIL 케이스 2: 단일 [2]가 중간에, 뒤에 한 문장 잔존
  const text2 = '약사는 의약품 조제 전문가다.[1] 조제 외에도 상담을 담당한다.[2] 병원 임상 약사 역할도 수행한다.';
  const r2 = detectMidFootnote(text2);
  assert('FAIL-D2: [2] 뒤에 한 문장 잔존 → 탐지', r2 !== null && r2.length > 5,
    `remnant="${r2}"`);

  // PASS 케이스 1: 단일 [1]이 마지막 문장 끝에 위치
  const text3 = '수의사는 동물을 치료한다. 인수공통감염병 예방도 담당한다. 진로 설계가 중요하다.[1]';
  const r3 = detectMidFootnote(text3);
  assert('PASS-D1: [1] 마지막 위치 → null 반환', r3 === null, `remnant="${r3}"`);

  // PASS 케이스 2: 다중 각주 (각 문장에 고유 [N]) — 마지막 [3] 뒤에 텍스트 없음
  const text4 = '수의사는 동물을 치료한다.[1] 인수공통감염병 예방도 담당한다.[2] 입시 경쟁률이 매우 높다.[3]';
  const r4 = detectMidFootnote(text4);
  assert('PASS-D2: 다중 각주 [1][2][3] — 마지막 [3] 뒤 텍스트 없음 → null 반환',
    r4 === null, `remnant="${r4}"`);
}

// ─────────────────────────────────────────────────────────────────────────────
// 룰 D: validate-job-edit.cjs 통합 테스트
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n═══ 룰 D: validate 통합 — trivia-각주중간 FAIL/PASS ═══');

{
  const basePayload = {
    fields: {
      way: '기획관리자가 되려면 관련 학과를 졸업해야 한다.[1]',
      detailReady: { curriculum: ['경영학 전공[1]'], recruit: ['대기업 채용[1]'], training: ['교육[1]'] },
      _youtubeSearchNote: "KEIS '기획관리자' 0건, '경영기획 현직자 인터뷰' 0건, '전략기획 직무' 0건, '경영기획 진로' 0건 (2026-04-16)",
    },
    sources: {
      way: [{ id: 1, text: '[1] 잡코리아', url: 'https://www.jobkorea.co.kr/goodjob/tip/view?News_No=10896' }],
      'detailReady.curriculum': [{ id: 1, text: '[1] 잡코리아', url: 'https://www.jobkorea.co.kr/' }],
      'detailReady.recruit': [{ id: 1, text: '[1] 잡코리아', url: 'https://www.jobkorea.co.kr/' }],
      'detailReady.training': [{ id: 1, text: '[1] 한국생산성본부', url: 'https://www.kpc.or.kr/' }],
    },
    changeSummary: '테스트 케이스',
  };

  // FAIL: trivia에서 [1]이 첫 문장 뒤에 위치, 뒤에 2문장 무출처
  const failPayload = {
    ...basePayload,
    fields: {
      ...basePayload.fields,
      trivia: '한국에는 자격 체계가 세 가지 병존한다.[1] 국가기술자격이다. 취득 순서를 설계해야 한다.',
    },
    sources: {
      ...basePayload.sources,
      trivia: [{ id: 1, text: '[1] Q-net', url: 'https://www.q-net.or.kr/' }],
    },
  };
  const r1 = runValidate(failPayload);
  assertContains('FAIL-D validate: [trivia-각주중간] 감지', r1.output, '[trivia-각주중간]');

  // PASS: trivia에서 [1]이 마지막 문장 끝에 위치
  const passPayload = {
    ...basePayload,
    fields: {
      ...basePayload.fields,
      trivia: '한국에는 자격 체계가 세 가지 병존한다. 국가기술자격이다. 취득 순서를 설계해야 한다.[1]',
    },
    sources: {
      ...basePayload.sources,
      trivia: [{ id: 1, text: '[1] Q-net', url: 'https://www.q-net.or.kr/' }],
    },
  };
  const r2 = runValidate(passPayload);
  assertNotContains('PASS-D validate: [trivia-각주중간] 없음', r2.output, '[trivia-각주중간]');
}

// ─────────────────────────────────────────────────────────────────────────────
// 결과 요약
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n════════════════════════════════════════');
console.log(`결과: PASS ${passed}개 / FAIL ${failed}개 (총 ${passed + failed}개)`);
if (failed > 0) {
  console.log('❌ 일부 테스트 실패 — 룰 구현 확인 필요');
  process.exit(1);
} else {
  console.log('✅ 전체 PASS — 룰 A/B/C 정상 작동 확인');
}
