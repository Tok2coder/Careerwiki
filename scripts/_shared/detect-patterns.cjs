#!/usr/bin/env node
/**
 * detect-patterns.cjs — CareerWiki 공유 검증 패턴 모음
 *
 * validate-job-edit.cjs와 full-quality-audit.cjs가 공통으로 사용하는
 * 출처 병합 탐지 함수 및 잘린 문장 패턴을 단일 모듈로 관리한다.
 *
 * 수정 시 두 스크립트 모두에 반영됨을 의식할 것.
 */

'use strict';

// ── 출처 탐지 — 두 함수로 분리 (2026-04-16) ──────────────────────────────────
//
// a) detectMultipleUrlsInSourceText(src)  → FAIL 신호
//    source text 내에 http:// 또는 https:// 패턴이 2개 이상 포함된 경우.
//    여러 URL을 한 text에 인라인으로 박는 것은 구조적 위반이며 즉시 분리 필요.
//
// b) detectMergedOrgLabel(src)            → INFO 신호 (FAIL 아님)
//    "기관A 및 기관B" 형태의 라벨 패턴을 탐지한다.
//    URL 하나가 여러 기관 언급을 실제 커버하는지는 사람 판단 영역이므로
//    자동 FAIL 대상이 아님 — 안내 메시지로 사람 확인을 유도한다.
//    (FP_SUFFIXES, ORG_NAME_PAT 필터는 b)에만 적용)

// ── a) source text 내 복수 URL 탐지 ──────────────────────────────────────────
// @param {object} src - {text, url} 형식의 source 항목
// @returns {boolean} text에 URL이 2개 이상 포함되어 있으면 true
function detectMultipleUrlsInSourceText(src) {
  if (!src || typeof src !== 'object') return false;
  const text = (src.text || '').trim();
  if (!text) return false;
  const urlMatches = text.match(/https?:\/\//g) || [];
  return urlMatches.length >= 2;
}

// ── b) source 라벨의 기관 병합 패턴 탐지 ────────────────────────────────────
// @param {object} src - {text, url} 형식의 source 항목
// @returns {string|null} 병합 의심 시 "orgA + orgB" 설명 문자열, 아니면 null
const FP_SUFFIXES = /^(현황|전망|안내|운영|구성|기사|정보|내용|일정|과정|분석|결과|현황과|주요현황|지원|활동|방법|기준|규정|조직법|월급|조직|구성원|법령|데이터|서비스|제도|관리|방안|역할|교육|훈련|채용|공고|자격|사항|영향|현황및|전망및)/;
const ORG_NAME_PAT = /넷|Net|관|원|사|청|부|처|협회|재단|연구원|센터|포럼|클럽|학회|공단|공사|진흥|기관|회사|법인|서비스|시스템|플랫폼|아카데미|클리닉|인스티튜트|커뮤니티|랩|Lab|Hub/;
const ORG_MERGE_PAT = /([가-힣A-Za-z0-9\-\.]+)\s+(및|또는|와|과)\s+([가-힣A-Za-z0-9\-\.]+)/;
const SEPARATOR = /\s[—\-–:]\s/;

function detectMergedOrgLabel(src) {
  if (!src || typeof src !== 'object') return null;
  const text = (src.text || '').trim();
  const url  = (src.url  || '').trim();
  if (!text || !url) return null;

  const label = text.replace(/^\[\d+\]\s*/, '');
  const sepMatch = label.match(SEPARATOR);
  let orgPart = label;
  if (sepMatch) {
    const sepIdx = label.indexOf(sepMatch[0]);
    orgPart = label.substring(0, sepIdx).trim();
  }

  const m = ORG_MERGE_PAT.exec(orgPart);
  if (!m) return null;

  const left = m[1].trim(), right = m[3].trim();
  if (left.length < 2 || right.length < 2) return null;

  if (FP_SUFFIXES.test(right)) return null;

  const leftIsOrg  = ORG_NAME_PAT.test(left)  || /[A-Z]/.test(left[0]);
  const rightIsOrg = ORG_NAME_PAT.test(right) || /[A-Z]/.test(right[0]);
  if (!leftIsOrg && !rightIsOrg) return null;

  return `"${left}" + "${right}"`;
}

// 하위 호환 별칭 — 이전에 detectMergedSourceText를 직접 import하던 코드를 위해 유지.
// 새 코드에서는 detectMergedOrgLabel을 직접 사용할 것.
const detectMergedSourceText = detectMergedOrgLabel;

// ── 잘린 문장 패턴 (validate + audit 동기화) ─────────────────────────────────
// 변경 시 양쪽 스크립트에 자동 반영됨.
const TRUNCATED_PATTERNS = [
  /부상\s*시$/,
  /으로\s*인해$/,
  /경우에는$/,
  /에\s*따르면$/,
  /가능하$/,
  /필요하$/,
  /이루어지$/,
  /\d{4}년$/,
  /억\s*원$/,
  /%\s*이상$/,
  /%\s*이하$/,
  /하여$/,
  /이며$/,
  /위해$/,
  /있으며$/,
  /있고$/,
  /하고$/,
  /[가-힣]{1}에$/, // "~에" 로 끝나는 잘린 문장
];

// ── 완성형 어미 패턴 ──────────────────────────────────────────────────────────
const COMPLETE_ENDINGS = [
  /[.다요]\s*(\[\d+\])*\s*$/,
  /습니다\s*(\[\d+\])*\s*$/,
  /입니다\s*(\[\d+\])*\s*$/,
  /됩니다\s*(\[\d+\])*\s*$/,
  /합니다\s*(\[\d+\])*\s*$/,
  /있습니다\s*(\[\d+\])*\s*$/,
  /없습니다\s*(\[\d+\])*\s*$/,
  /받습니다\s*(\[\d+\])*\s*$/,
  /\)\s*(\[\d+\])*\s*$/, // 괄호 닫힘으로 끝나는 경우
];

// ── Mojibake 탐지 ─────────────────────────────────────────────────────────────
// 한글이 있어야 할 텍스트 필드에 깨진 유니코드(아랍/시리아/라틴확장/키릴 문자 등)가
// 섞여 있는 경우를 탐지한다. Windows curl 등 CP949 인코딩 오류 차단용.
//
// 탐지 원리:
//  1. 아랍·시리아·라틴확장-A/B·키릴·아르메니아 등 "mojibake 전형 범위" 문자가 다수 출현하면서
//  2. 한글 자모(AC00-D7A3)가 전혀 없거나 거의 없는 경우 → mojibake로 판정.
//
// @param {string} text - 검사할 텍스트 문자열
// @returns {boolean} true면 mojibake 의심
const MOJI_RANGES = [
  [0x0180, 0x024F], // Latin Extended-B
  [0x0250, 0x02AF], // IPA Extensions
  [0x0300, 0x036F], // Combining Diacritical Marks
  [0x0400, 0x052F], // Cyrillic + Supplement
  [0x0530, 0x058F], // Armenian
  [0x0600, 0x06FF], // Arabic
  [0x0700, 0x074F], // Syriac
  [0x0750, 0x077F], // Arabic Supplement
];

function detectMojibake(text) {
  if (!text || typeof text !== 'string') return false;
  const chars = [...text];
  if (chars.length < 8) return false;

  let mojiCount = 0;
  let koreanCount = 0;
  let nonAsciiCount = 0;

  for (const ch of chars) {
    const cp = ch.codePointAt(0);
    if (cp <= 0x7F) continue; // ASCII
    nonAsciiCount++;
    if (cp >= 0xAC00 && cp <= 0xD7A3) { koreanCount++; continue; } // 한글 완성형
    if (cp >= 0x1100 && cp <= 0x11FF) { koreanCount++; continue; } // 한글 자모
    if (cp >= 0x3130 && cp <= 0x318F) { koreanCount++; continue; } // 한글 호환 자모
    if (MOJI_RANGES.some(([lo, hi]) => cp >= lo && cp <= hi)) mojiCount++;
  }

  if (nonAsciiCount === 0) return false;

  // 조건 A: 비ASCII 문자 8개 이상인데 한글이 전혀 없고, mojibake 범위 문자가 비ASCII의 40% 이상
  if (nonAsciiCount >= 8 && koreanCount === 0 && mojiCount / nonAsciiCount >= 0.4) return true;

  // 조건 B: 비ASCII가 10개 이상인데 한글 비율이 10% 미만이고 mojibake 범위가 30% 이상
  if (nonAsciiCount >= 10 && koreanCount / nonAsciiCount < 0.1 && mojiCount / nonAsciiCount >= 0.3) return true;

  return false;
}

// ── 룰 A: UCJ detailReady 배열 항목별 [N] 필수 검사 ──────────────────────────
//
// user_contributed_json.detailReady.{curriculum,recruit,training} 배열의 각 항목이
// [N] 각주 마커를 포함하는지 검사한다.
// researchList는 CareerNet 원본 데이터이므로 이 검사에서 **제외**.
//
// @param {Array} items - detailReady.{curriculum|recruit|training} 배열
// @returns {number[]} [N] 마커가 없는 항목의 인덱스 배열
function detectMissingFootnoteInArrayItems(items) {
  if (!Array.isArray(items)) return [];
  const missing = [];
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const text = typeof item === 'string' ? item : (item?.text || '');
    if (text.trim() && !/\[\d+\]/.test(text)) {
      missing.push(i);
    }
  }
  return missing;
}

// ── 룰 B: _youtubeSearchNote 탐색 깊이 검사 ────────────────────────────────────
//
// youtubeLinks가 빈 배열일 때, _youtubeSearchNote가 충분한 탐색 증거를 담고 있는지 검사.
// 다음 두 조건 중 하나를 충족해야 통과:
//   (a) 작은따옴표로 감싼 탐색어 ≥6개
//   (b) 4개 카테고리 중 ≥3개 커버 (현직자·인터뷰 / 직무·실무 / 강의·교육 / 진로·면접)
//
// @param {string} note - _youtubeSearchNote 문자열
// @returns {{ pass: boolean, termCount: number, categoryCount: number, missingCategories: string[] }}
const YOUTUBE_SEARCH_CATEGORIES = [
  { name: '현직자·인터뷰', pattern: /현직자|인터뷰/ },
  { name: '직무·실무',     pattern: /직무|실무/ },
  { name: '강의·교육',     pattern: /강의|교육/ },
  { name: '진로·면접',     pattern: /진로|면접/ },
];

function analyzeYoutubeSearchNote(note) {
  if (!note || typeof note !== 'string') {
    return { pass: false, termCount: 0, categoryCount: 0, missingCategories: YOUTUBE_SEARCH_CATEGORIES.map(c => c.name) };
  }
  // 탐색어 카운트: 작은따옴표 '' 쌍 또는 큰따옴표 "" 쌍으로 감싸인 검색어
  const singleQuoteTerms = note.match(/'[^']{2,}'/g) || [];
  const doubleQuoteTerms = note.match(/"[^"]{2,}"/g) || [];
  const termCount = singleQuoteTerms.length + doubleQuoteTerms.length;

  const covered = YOUTUBE_SEARCH_CATEGORIES.filter(c => c.pattern.test(note));
  const categoryCount = covered.length;
  const missingCategories = YOUTUBE_SEARCH_CATEGORIES.filter(c => !c.pattern.test(note)).map(c => c.name);

  const pass = termCount >= 6 || categoryCount >= 3;
  return { pass, termCount, categoryCount, missingCategories };
}

// ── 룰 C: _careerTreeNote 탐색 깊이 검사 ──────────────────────────────────────
//
// careerTree가 null일 때, _careerTreeNote가 충분한 탐색 증거를 담고 있는지 검사.
// 다음 두 조건 중 하나를 충족해야 통과:
//   (a) 후보 인물 ≥5명 검토됨 — "이름(이유)" 패턴으로 감지
//   (b) 5개 카테고리 중 ≥3개 커버 (재벌·대기업 / 컨설팅 / 공공·정부 / 학계·연구 / 스타트업·CxO)
//
// @param {string} note - _careerTreeNote 문자열
// @returns {{ pass: boolean, candidateCount: number, categoryCount: number }}
const CAREER_TREE_SEARCH_CATEGORIES = [
  { name: '재벌·대기업', pattern: /재벌|대기업|그룹\s*회장|[가-힣]+그룹|대기업\s*출신/ },
  { name: '컨설팅',      pattern: /컨설팅|컨설턴트|McKinsey|BCG|Bain|McKinsey|A\.T\. Kearney/ },
  { name: '공공·정부',   pattern: /공공|정부|장관|청장|공기업|공무원|국책/ },
  { name: '학계·연구',   pattern: /학계|교수|연구원|박사|학자|연구소/ },
  { name: '스타트업·CxO', pattern: /스타트업|창업|CEO|CTO|CFO|CMO|COO|유니콘/ },
];

// 한국어 이름(2-4자) + "(" 패턴으로 후보 인물 카운트
// 예: "이재용(적합 없음)", "박지성(전직 축구선수, 직종 불일치)"
const CANDIDATE_PAT = /[가-힣]{2,4}\s*\(/g;

function analyzeCareerTreeNote(note) {
  if (!note || typeof note !== 'string') {
    return { pass: false, candidateCount: 0, categoryCount: 0 };
  }
  const candidates = note.match(CANDIDATE_PAT) || [];
  const candidateCount = candidates.length;

  const covered = CAREER_TREE_SEARCH_CATEGORIES.filter(c => c.pattern.test(note));
  const categoryCount = covered.length;
  const missingCategories = CAREER_TREE_SEARCH_CATEGORIES.filter(c => !c.pattern.test(note)).map(c => c.name);

  const pass = candidateCount >= 5 || categoryCount >= 3;
  return { pass, candidateCount, categoryCount, missingCategories };
}

// ── 룰 D: trivia 각주 위치 검사 ───────────────────────────────────────────────
//
// 원칙: 각주 [N]은 해당 출처가 커버하는 내용의 마지막 문장 뒤에 위치해야 한다.
//
// 정상:
//   - 각주가 0~1개면 위치 무관 (1개면 trivia 전체를 해당 출처가 커버한다고 간주)
//   - 각주가 2개 이상이고 본문 중간중간에 분산 배치되어 있으면 PASS
//     (예: "문장1.[1] 문장2. 문장3.[2]" — [1]은 문장1, [2]는 문장2-3 커버)
//
// 위반:
//   (a) 마지막 [N] 뒤에 실질 텍스트가 이어짐 — trailing 텍스트가 어느 출처 범위인지 불명확
//       예: "문장1.[1] 문장2. 문장3."  (마지막 [N]=[1] 뒤에 문장2-3이 이어짐)
//   (b) 각주 2개 이상이 맨 끝에 연속으로 몰려있음 — 각주별 커버 범위 불명확
//       예: "문장1. 문장2. 문장3.[1][2]"  (어느 문장이 어느 출처인지 알 수 없음)
//
// @param {string} trivia - trivia 필드 문자열
// @returns {string|null} 위반 시 사유 문자열, 정상이면 null
function detectTriviaInlineFootnote(trivia) {
  if (!trivia || typeof trivia !== 'string') return null;
  const trimmed = trivia.trim();
  const all = [...trimmed.matchAll(/\[\d+\]/g)];
  if (all.length <= 1) return null; // 각주 0~1개면 위치 무관 PASS

  // 조건 (a): 마지막 [N] 뒤에 실질 텍스트가 이어지면 위반
  const last = all[all.length - 1];
  const afterLast = trimmed.slice(last.index + last[0].length).trim();
  if (/[가-힣a-zA-Z0-9]/.test(afterLast)) {
    return '마지막 [N] 이후에 출처 귀속이 불명확한 문장이 이어짐';
  }

  // 조건 (b): 모든 [N]이 맨 끝에 연속 배치되었는지 확인
  // first [N]부터 last [N] 끝까지 구간에서 [N] 태그들을 제거했을 때 실질 텍스트가 없으면
  // → 각주들이 연속으로 몰려있음. 단, first [N] 이전에 실질 텍스트가 있어야 위반 (커버할 본문 존재)
  const first = all[0];
  const between = trimmed.slice(first.index, last.index + last[0].length);
  const betweenCleaned = between.replace(/\[\d+\]/g, '').trim();
  if (betweenCleaned.length === 0) {
    const beforeFirst = trimmed.slice(0, first.index).trim();
    if (/[가-힣a-zA-Z0-9]/.test(beforeFirst)) {
      return `각주 ${all.length}개가 맨 끝에 연속 몰려있음 — 각주별 출처 범위 불명확`;
    }
  }

  return null;
}

module.exports = {
  detectMultipleUrlsInSourceText,
  detectMergedOrgLabel,
  detectMergedSourceText,
  TRUNCATED_PATTERNS,
  COMPLETE_ENDINGS,
  FP_SUFFIXES,
  ORG_NAME_PAT,
  detectMojibake,
  MOJI_RANGES,
  // 룰 A/B/C
  detectMissingFootnoteInArrayItems,
  analyzeYoutubeSearchNote,
  analyzeCareerTreeNote,
  YOUTUBE_SEARCH_CATEGORIES,
  CAREER_TREE_SEARCH_CATEGORIES,
  // 룰 D
  detectTriviaInlineFootnote,
};
