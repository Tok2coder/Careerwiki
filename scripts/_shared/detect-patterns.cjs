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

  // U+FFFD replacement char — UTF-8 디코딩 실패의 명시적 표지. 1개라도 있으면 즉시 mojibake.
  // 사례: 수의사보조원 sources 'text': '�ѱ����ǻ�ȸ' (한국수의사회가 CP949→UTF-8 변환 실패)
  if (text.includes('�')) return true;

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

// ── 룰 E: list-page citation 탐지 (2026-04-29) ─────────────────────────────────
//
// _sources URL이 직업 specific 페이지가 아닌 인덱스/카테고리 페이지인지 검사.
// CareerWiki의 출처는 반드시 해당 직업 고유 식별자(seq/code/id)를 포함한 URL이어야 함.
// (이미 검색결과 페이지는 SEARCH_RESULT_PATTERNS로 차단되지만, "직업 인덱스 페이지"는 별도)
//
// 사례 (사용자 deep audit, 2026-04-29):
//   - https://www.career.go.kr/cloud/w/job          ← 인덱스 (seq 없음)
//   - https://www.career.go.kr/cnet/front/base/job/jobList.do  ← 리스트
//   - https://www.work.go.kr/empInfo/jobInfo/jobList.do        ← 리스트
//   - https://www.q-net.or.kr/crf005.do (id 없음)
//
// @param {string} url - 검사할 URL 문자열
// @returns {boolean} list-page 의심이면 true (FAIL 신호)
const LIST_PAGE_PATTERNS = [
  // 커리어넷 신형/구형 직업/전공 인덱스 (seq/SEQ 파라미터 없음)
  /^https?:\/\/(www\.)?career\.go\.kr\/cloud\/w\/(job|major)\/?(\?(?!.*\bseq=)[^#]*)?(\#.*)?$/i,
  /^https?:\/\/(www\.)?career\.go\.kr\/cnet\/front\/base\/(job|major)\/(jobList|majorList|jobView|majorView)\.do(\?(?!.*\bSEQ=)[^#]*)?(\#.*)?$/i,
  // 워크넷 직업 인덱스 (jobsCd 없음)
  /^https?:\/\/(www\.)?work\.go\.kr\/empInfo\/jobInfo\/(jobInfoDetailView|jobList)\.do(\?(?!.*\bjobsCd=)[^#]*)?(\#.*)?$/i,
  // 워크넷/고용24 자격·임금 정보 인덱스 (jobsCd 또는 식별자 없음)
  /^https?:\/\/(www\.)?work\.go\.kr\/empInfo\/wageJobInfo\/wageJobInfoDetailView\.do(\?(?!.*\bjobsCd=)[^#]*)?(\#.*)?$/i,
  // 마지막 path 세그먼트가 list/category/index 류 (식별자 없는 인덱스)
  /^https?:\/\/[^\/]+\/[^?#]*\/(list|listView|category|index|main)\/?(\?[^#]*)?(\#.*)?$/i,
  // Q-Net 자격증 인덱스 (jmCd 또는 id 없음)
  /^https?:\/\/(www\.)?q-net\.or\.kr\/crf005\.do(\?(?!.*\b(jmCd|id)=)[^#]*)?(\#.*)?$/i,
  // 사람인/잡코리아 카테고리 인덱스 (cat_kewd, occupation 등)
  /^https?:\/\/(www\.)?(saramin|jobkorea)\.co\.kr\/(zf_user\/)?[^?#]*\/(jobs|job-category|recruit-list)(\?[^#]*)?(\#.*)?$/i,
  // 2026-05-01 격상: 일반 도메인 search/list URL 사고 방지
  // 사례: kfb.or.kr/search?query=은행사무원, kbi.or.kr/search?query=..., kofta.org/search?query=...,
  //       bhent.co.kr/search?query=..., kglass.or.kr/search?query=..., kto.visitkorea.or.kr/search?query=...,
  //       hrdkorea.or.kr/search?query=..., kila.or.kr/search?query=...
  // hostname 무관, path 마지막 segment가 search 또는 list (.ext optional), query 파라미터에 검색어
  // (query/keyword/q/searchword/text/word/kw/term/searchKeyword/searchValue/sw)
  /^https?:\/\/[^\/?#]+\/(?:[^?#]+\/)?(search|list)(\.[a-z]{1,5})?\?[^#]*\b(query|keyword|q|searchword|searchKeyword|searchvalue|searchValue|text|word|kw|kwd|term|sw)=/i,
  // 게시판 검색결과 사고: klnews.co.kr/news/articleList.html?sc_word=...
  /^https?:\/\/[^\/?#]+\/(?:[^?#]+\/)?articleList(\.[a-z]{1,5})?\?[^#]*\b(sc_word|searchword|searchKeyword|sc_section|sc_sub_section|searchValue)=/i,
  // 커리어넷 신형 검색 사고: career.go.kr/cloud/w/search/intro?text=...
  /^https?:\/\/(www\.)?career\.go\.kr\/cloud\/w\/search\//i,
  // 워크피디아 검색 form 사고: wagework.go.kr/pt/b/a/retrieveOccpSrch... or retrieveJobSrch...
  /^https?:\/\/(www\.)?wagework\.go\.kr\/pt\/b\/a\/(retrieveOccp|retrieveJob)/i,
];

function detectListPageUrl(url) {
  if (!url || typeof url !== 'string') return false;
  return LIST_PAGE_PATTERNS.some(p => p.test(url));
}

// ── 룰 F: origin 도메인 (정부 산하 직업정보 포털) 탐지 ─────────────────────────
//
// CareerWiki는 career.go.kr / work.go.kr 등 공공 직업포털 데이터를 원본으로 가져온다.
// 이 도메인은 우리 데이터의 *origin*이므로 출처로 절대 사용 금지 (1건이라도 있으면 FAIL).
//
// 정책 격상 (2026-04-29 사용자 의도 반영):
//   - 기존 `selfCiteOnly` (외부 보충 1+ 있으면 통과) → `originDomain` (1건이라도 있으면 FAIL)
//   - careerwiki.org / careerwiki.kr — 자기 도메인 절대 금지 (FAIL)
//
// 검출 방법 (이중):
//   (a) DEFINITE_ORIGIN_HOSTS — 알려진 직업정보 origin 도메인 명시 리스트
//   (b) Heuristic — host endsWith '.go.kr' AND path 키워드 (job/career/work/wage/employ) 매칭
//
// 사고 사례: 의료코디네이터 _sources에 `wagework.go.kr` 등록 — 사용자 발견
const SELF_DOMAINS = ['careerwiki.org', 'careerwiki.kr', 'www.careerwiki.org', 'www.careerwiki.kr'];
const DEFINITE_ORIGIN_HOSTS = [
  // 커리어넷 (구버전 + 신버전)
  'career.go.kr', 'www.career.go.kr',
  // 워크넷 (구) + 모바일
  'work.go.kr', 'www.work.go.kr', 'm.work.go.kr',
  // 고용24 (워크넷 후속)
  'work24.go.kr', 'www.work24.go.kr',
  // 한국노동연구원 임금직업정보 (워크피디아) — 의료코디네이터 사고 사례
  'wagework.go.kr', 'www.wagework.go.kr',
  // 직업포털
  'job.go.kr', 'www.job.go.kr',
];

// 정부 부처·기관 ALLOWLIST — heuristic이 잡아도 origin 아닌 정상 1차 출처
// 사고 사례 (2026-04-30): 법원공무원/판사 _sources에 scourt.go.kr URL이 path에 ASP/JSP 확장자 ".work"
// 포함 (예: NewsListAction.work) → 기존 heuristic의 substring 매칭으로 false positive
const ORIGIN_HOST_ALLOWLIST = [
  // 사법부
  'scourt.go.kr', 'www.scourt.go.kr',     // 대법원
  'ccourt.go.kr', 'www.ccourt.go.kr',     // 헌법재판소
  // 행정부 부처 (정책 페이지 — 직업정보 origin 아님)
  'moel.go.kr', 'www.moel.go.kr',         // 고용노동부
  'mohw.go.kr', 'www.mohw.go.kr',         // 보건복지부
  'moe.go.kr', 'www.moe.go.kr',           // 교육부
  'moef.go.kr', 'www.moef.go.kr',         // 기획재정부
  'mof.go.kr', 'www.mof.go.kr',           // 해양수산부
  'mofa.go.kr', 'www.mofa.go.kr',         // 외교부
  'mois.go.kr', 'www.mois.go.kr',         // 행정안전부
  'molit.go.kr', 'www.molit.go.kr',       // 국토교통부
  'mafra.go.kr', 'www.mafra.go.kr',       // 농림축산식품부
  'msit.go.kr', 'www.msit.go.kr',         // 과학기술정보통신부
  'mcst.go.kr', 'www.mcst.go.kr',         // 문화체육관광부
  'mss.go.kr', 'www.mss.go.kr',           // 중소벤처기업부
  'me.go.kr', 'www.me.go.kr',             // 환경부
  'unikorea.go.kr', 'www.unikorea.go.kr', // 통일부
];

// .go.kr 도메인에서 path에 직업정보 키워드가 path segment로 들어 있으면 origin 후보.
// 정규식 boundary 강화 (2026-04-30): path 끝의 ASP/JSP `.work` 확장자처럼 substring 매칭
// false positive를 차단. slash/end/?/.with-non-letter boundary로 keyword 단독 segment 매칭.
const ORIGIN_PATH_KEYWORDS = /\/(job|jobs|career|careers|work|works|wage|wages|employ|employment)(\/|$|\?|#)/i;
// 하위호환 — 기존 코드가 ORIGIN_DATA_DOMAINS 참조 시 그대로 사용 가능
const ORIGIN_DATA_DOMAINS = DEFINITE_ORIGIN_HOSTS;

// @param {string} url
// @returns {boolean} origin 도메인이면 true
function detectOriginDomain(url) {
  if (!url || typeof url !== 'string') return false;
  let parsed;
  try { parsed = new URL(url); } catch { return false; }
  const host = parsed.host.toLowerCase();
  // 1) 명시 origin 리스트 — 우선
  if (DEFINITE_ORIGIN_HOSTS.includes(host)) return true;
  // 2) ALLOWLIST — origin 아님 (heuristic 적용 안 함)
  if (ORIGIN_HOST_ALLOWLIST.includes(host)) return false;
  // 3) heuristic — .go.kr endsWith + path keyword (path segment 기반)
  if (host.endsWith('.go.kr') && ORIGIN_PATH_KEYWORDS.test(parsed.pathname)) {
    return true;
  }
  return false;
}

// @param {Array<{url:string}>} sourceArr
// @returns {{selfHostCount, originHostCount, externalHostCount, externalHosts,
//             hasSelfDomain, allUrls, uniqueHostCount, originUrls}}
function classifySourceHosts(sourceArr) {
  const all = Array.isArray(sourceArr) ? sourceArr : [];
  const allUrls = [];
  const hosts = new Set();
  let selfHostCount = 0;
  let originHostCount = 0;
  let externalHostCount = 0;
  let hasSelfDomain = false;
  const externalHosts = new Set();
  const originUrls = [];

  for (const src of all) {
    if (!src || typeof src !== 'object' || !src.url) continue;
    let host = '';
    try {
      host = new URL(src.url).host.toLowerCase();
    } catch {
      continue;
    }
    allUrls.push(src.url);
    hosts.add(host);
    if (SELF_DOMAINS.includes(host)) {
      hasSelfDomain = true;
      selfHostCount++;
    } else if (detectOriginDomain(src.url)) {
      originHostCount++;
      originUrls.push(src.url);
    } else {
      externalHostCount++;
      externalHosts.add(host);
    }
  }

  return {
    selfHostCount,
    originHostCount,
    externalHostCount,
    externalHosts: [...externalHosts],
    hasSelfDomain,
    allUrls,
    uniqueHostCount: hosts.size,
    originUrls,
  };
}

// ── 룰 G: orphan source idx 탐지 ───────────────────────────────────────────────
//
// 본문 [N]은 *field-local* 번호이고 detailTemplateUtils.applyInlineFootnotes에서
// footnoteMap을 통해 글로벌 번호로 변환된다. 즉 본문 [N] ↔ _sources[fieldKey][N-1].
// (sources[i].id의 값과 무관하게 배열 위치 기준)
//
// orphan: _sources[fieldKey] 배열 길이가 N인데 본문에 [N]으로 등장하지 않는
// 'i+1' (i.e. 등록만 하고 본문 미사용)이 있으면 orphan으로 간주.
//
// @param {string} bodyText - 본문 문자열
// @param {Array} sourceArr - 해당 필드 _sources 배열
// @returns {number[]} body에 등장하지 않는 field-local 번호 목록
function detectOrphanSourceIdx(bodyText, sourceArr) {
  if (!Array.isArray(sourceArr) || sourceArr.length === 0) return [];
  const text = typeof bodyText === 'string' ? bodyText : '';
  const used = new Set();
  for (const m of text.matchAll(/\[(\d+)\]/g)) {
    used.add(Number(m[1]));
  }
  const orphans = [];
  for (let i = 0; i < sourceArr.length; i++) {
    const localNum = i + 1;
    if (!used.has(localNum)) orphans.push(localNum);
  }
  return orphans;
}

// ── 룰 H: broken source ref 탐지 ───────────────────────────────────────────────
//
// 본문에 [N] 마커가 있는데 _sources[fieldKey] 길이가 N보다 작은 경우.
// (본문 local [N] → _sources[fieldKey][N-1] 매핑 시도, out-of-bounds이면 broken)
//
// @param {string} bodyText - 본문 문자열
// @param {Array} sourceArr - 해당 필드 _sources 배열
// @returns {number[]} _sources에 매핑이 없는 본문 local 번호 목록
function detectBrokenSourceRef(bodyText, sourceArr) {
  if (!bodyText || typeof bodyText !== 'string') return [];
  const matches = [...bodyText.matchAll(/\[(\d+)\]/g)];
  if (matches.length === 0) return [];
  const sourcesLen = Array.isArray(sourceArr) ? sourceArr.length : 0;
  const broken = new Set();
  for (const m of matches) {
    const n = Number(m[1]);
    if (n < 1 || n > sourcesLen) broken.add(n);
  }
  return [...broken];
}

// ── 룰 I: source idx gap 탐지 (글로벌 id 연속성) ───────────────────────────────
//
// _sources의 모든 source 항목을 평탄화한 뒤 glocal id (1부터 연속)을 검사.
// 사용자 정책: id는 전체 JSON 내 전역 고유 순번으로 1부터 연속이어야 한다.
//
// @param {object} sources - _sources 객체 (fieldKey → 배열)
// @returns {{ok:boolean, expected:number[], actual:Array<number|null>}|null}
//          정상이면 null, gap이면 expected/actual을 담은 객체
function detectSourceIdxGap(sources) {
  if (!sources || typeof sources !== 'object') return null;
  const flat = [];
  // sources의 fieldKey 순서대로 평탄화 (객체 enumeration 순서 = 보존순서, ES2015+)
  for (const fieldKey of Object.keys(sources)) {
    const arr = sources[fieldKey];
    if (!Array.isArray(arr)) continue;
    for (const src of arr) {
      const id = (src && typeof src === 'object' && typeof src.id === 'number') ? src.id : null;
      flat.push(id);
    }
  }
  if (flat.length === 0) return null;
  // id가 모두 누락이면 gap 검사 의미 없음 (구형 구조)
  if (flat.every(id => id == null)) return null;
  const expected = flat.map((_, i) => i + 1);
  const ok = flat.every((id, i) => id === expected[i]);
  if (ok) return null;
  return { ok: false, expected, actual: flat };
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
  // 룰 E/F/G/H/I (2026-04-29 source-policy 강화)
  detectListPageUrl,
  LIST_PAGE_PATTERNS,
  classifySourceHosts,
  SELF_DOMAINS,
  ORIGIN_DATA_DOMAINS,
  // 룰 F 격상 (2026-04-29 — origin 도메인 1건이라도 FAIL)
  DEFINITE_ORIGIN_HOSTS,
  ORIGIN_HOST_ALLOWLIST,
  ORIGIN_PATH_KEYWORDS,
  detectOriginDomain,
  detectOrphanSourceIdx,
  detectBrokenSourceRef,
  detectSourceIdxGap,
};
