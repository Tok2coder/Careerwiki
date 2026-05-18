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

// ── 룰 J: detailReady 배열 항목 brokenRef 탐지 ──────────────────────────────
//
// detailReady.curriculum / recruit / training 같은 배열 필드의 각 항목 안에
// 등장하는 [N] 마커가 _sources["detailReady.X"] 길이를 초과하면 broken.
// (산문 필드용 detectBrokenSourceRef와 동일한 로직, 입력만 배열로 변환)
//
// 사고 사례 (2026-05-06): 국무총리/게임-기획자/산부인과의사가 detailReady 배열에
// 글로벌 idx ([4][12][2] 등)를 박았으나 _sources["detailReady.X"]에는 field-local
// 길이(1~3개)만 등록되어 본문 마커가 srcLen 초과 → brokenRef 누락 사고.
//
// @param {Array} arrayItems - detailReady.X 배열 (string 또는 {text})
// @param {Array} sourceArr - _sources["detailReady.X"]
// @returns {number[]} broken 마커 list (deduped)
function detectBrokenSourceRefArrayItems(arrayItems, sourceArr) {
  if (!Array.isArray(arrayItems) || arrayItems.length === 0) return [];
  const allText = arrayItems
    .map(x => (typeof x === 'string' ? x : (x && (x.text || x.title)) || ''))
    .join(' ');
  return detectBrokenSourceRef(allText, sourceArr);
}

// ── 룰 L: sidebar 영역 _sources 등록 금지 (2026-05-06 후속 사고 차단) ────────
//
// SKILL 정책: sidebarCerts/sidebarOrgs/sidebarMajors/sidebarJobs 본문에 [N] 마커
// 절대 금지 (sidebar 자체 `{name, url}` 객체 배열 사용). 따라서 _sources에
// 등록해도 본문 sup이 안 만들어져 orphan 발생 → 사용자 시각 사고.
//
// 사고 사례: 게임-기획자 _sources.sidebarCerts[0] (id=15) — 본문에 [15] 마커
// 없는데 출처 섹션엔 [15] 표시. 사용자가 orphan으로 인식.
//
// @param {object} sources - _sources 객체
// @returns {Array<{field, ids, count}>} sidebar 영역에 등록된 항목 list (있으면 사고)
const SIDEBAR_FIELDS_FORBIDDEN = ['sidebarCerts', 'sidebarOrgs', 'sidebarMajors', 'sidebarJobs'];
function detectSidebarSources(sources) {
  if (!sources || typeof sources !== 'object') return [];
  const found = [];
  for (const f of SIDEBAR_FIELDS_FORBIDDEN) {
    const arr = sources[f];
    if (Array.isArray(arr) && arr.length > 0) {
      const ids = arr.map(s => (s && typeof s.id === 'number') ? s.id : null).filter(x => x != null);
      found.push({ field: f, ids, count: arr.length });
    }
  }
  return found;
}

// ── 룰 K: 본문 [N] 첫 등장 sequential 검사 ─────────────────────────────────
//
// 본문 전체(산문 필드 + 배열 필드) 합본에서 [N] 마커가 처음 등장하는 순서가
// 1, 2, 3, ... 순으로 sequential 인지 검사.
//
// 사고 사례: 본문에 [3][1][2] 순으로 등장하는 패턴은 사용자가 위에서 아래로 읽을 때
// "주석 순서 엉망"으로 보임. 글로벌 idx 시스템에서는 첫 등장 순서가 _sources 등록
// 순서와 일치해야 자연스럽다.
//
// @param {string} bodyText - 모든 산문/배열 본문을 join한 문자열
// @returns {{ok:boolean, expected:number[], firstAppear:number[], breakAt:number}|null}
//          정상이면 null. 깨지면 break 위치 포함 객체 반환.
function detectMarkerOrderViolation(bodyText) {
  if (typeof bodyText !== 'string' || bodyText.length === 0) return null;
  const matches = [...bodyText.matchAll(/\[(\d+)\]/g)].map(m => Number(m[1]));
  if (matches.length === 0) return null;
  const seen = new Set();
  const firstAppear = [];
  for (const n of matches) { if (!seen.has(n)) { seen.add(n); firstAppear.push(n); } }
  const expected = firstAppear.map((_, i) => i + 1);
  const ok = firstAppear.every((n, i) => n === expected[i]);
  if (ok) return null;
  let breakAt = -1;
  for (let i = 0; i < firstAppear.length; i++) {
    if (firstAppear[i] !== i + 1) { breakAt = i; break; }
  }
  return { ok: false, expected, firstAppear, breakAt };
}

// ── proseBodyOrphan: 산문 영역 본문 [N] vs _sources 정합 wrapper (2026-05-08) ───
//
// 산문 9 필드 (way / trivia / overviewProspect.main / overviewSalary.sal /
// detailWlb.wlbDetail / detailWlb.socialDetail / overviewAbilities.technKnow /
// summary / overviewWork.main) 본문 [N] vs _sources[fieldKey] 정합 검사.
//
// 기존 detectOrphanSourceIdx + detectBrokenSourceRef + dup marker 검사를 한 번에
// 실행하는 wrapper. validate / audit 양쪽이 일관된 결과 반환.
//
// 사고 차단: 산문 영역에서 body [N] 마커가 _sources 길이를 초과하거나, 등록된
// _sources idx가 본문에 미인용된 경우, 같은 마커가 한 필드 안에 2회+ 등장 모두
// 통합 검출. /api/job/:id/edit-data 응답의 _proseRaw namespace로 9 필드 모두 raw
// string 노출 (PR #13, 2026-05-08) — 기존 trivia·overviewWork.main array 형식
// silent skip 사고 차단.
//
// @param {string} body - 산문 raw string
// @param {Array} srcArr - 해당 필드 _sources 배열
// @returns {{orphans:number[], broken:number[], dupMarkers:Array<{marker, count}>}}
function detectProseBodyMismatch(body, srcArr) {
  const orphans = detectOrphanSourceIdx(body, srcArr);
  const broken = detectBrokenSourceRef(body, srcArr);
  const dupMarkers = [];
  if (typeof body === 'string') {
    const matches = body.match(/\[(\d+)\]/g) || [];
    const cnt = {};
    for (const m of matches) cnt[m] = (cnt[m] || 0) + 1;
    for (const [marker, c] of Object.entries(cnt)) {
      if (c >= 2) dupMarkers.push({ marker, count: c });
    }
  }
  return { orphans, broken, dupMarkers };
}

// 산문 영역 fieldKey list — validate-job-edit.cjs / audit-via-api.cjs / audit-sources-deep.cjs / job-data-master 스킬 모두 동일 사용.
const PROSE_BODY_FIELDS = [
  'way',
  'summary',
  'trivia',
  'overviewWork.main',
  'overviewProspect.main',
  'overviewAbilities.technKnow',
  'overviewSalary.sal',
  'detailWlb.wlbDetail',
  'detailWlb.socialDetail',
];

// ── 룰 13: Root URL Avoidance (협회·회사·학술 publisher root 차단, 2026-05-07) ──
//
// 사용자 8 pilot 피드백 (2026-05-07): "협회·회사 홈페이지 root만 나오는 출처 아쉬웠다"
// 조치: fact별 deep page 강제. root URL은 fact cover 못 함.
//
// 룰 F (originDomain) 우선 — 정부 산하 직업포털 (career.go.kr 등) 및 정부 부처
// (.go.kr ALLOWLIST)의 root는 룰 F가 차단/허용. 룰 13은 그 외 host만 검사:
// 협회 (.or.kr) / 기업 (.co.kr) / 학술 publisher / 일반 .com/.org root.
//
// Root path 정의 — 다음 중 하나 매칭 시 root:
//   - '' 또는 '/' (디폴트 landing)
//   - '/index' / '/main' (확장자 없음)
//   - '/index.{html|htm|php|asp|do|jsp}' / '/main.{...}'
//
// @param {string} url
// @returns {boolean} root URL이고 origin 아니면 true (FAIL 신호)
const ROOT_PATH_PATTERNS = [
  /^\/?$/,
  /^\/(index|main)(\.html?|\.php|\.asp|\.do|\.jsp)?\/?$/i,
];
function detectRootDomainOnly(url) {
  if (!url || typeof url !== 'string') return false;
  // 룰 F 우선 — 정부 부처 root는 origin 룰이 처리, 룰 13에서 skip
  if (detectOriginDomain(url)) return false;
  let parsed;
  try { parsed = new URL(url); } catch { return false; }
  return ROOT_PATH_PATTERNS.some(p => p.test(parsed.pathname));
}

// ── 룰 14: Wikipedia Quota (위키류 점유율 ≤ 30%, 2026-05-07) ───────────────
//
// 사용자 8 pilot 피드백 (2026-05-07): "위키 내용이 링크의 대부분을 차지하는 것
// 아쉬웠다". 조치: 글로벌 출처 풀에서 위키류 비율 ≤ 30% 강제.
//
// Wiki host 정의: *.wikipedia.org / namu.wiki / *.wikia.com / *.fandom.com
//   - en.wikipedia.org, ko.wikipedia.org 등 모든 lang variant 포함
//   - namu.wiki는 sub-domain 없음 (정확 매칭)
//
// Threshold:
//   - ratio > 0.3 → FAIL (1차 출처 보강 필수)
//   - 0.2 < ratio ≤ 0.3 → WARN (1차 출처 권장)
//   - ratio ≤ 0.2 → OK
//   - total < 5 → SKIP (분모 너무 작아 의미 없음)
//
// @param {object} sources - _sources 객체 (모든 fieldKey)
// @returns {{count, total, ratio, level: 'FAIL'|'WARN'|'OK'|'SKIP'}}
const WIKI_HOST_REGEX = /(^|\.)(wikipedia\.org|wikia\.com|fandom\.com)$|^namu\.wiki$/i;
function calcWikiQuota(sources) {
  if (!sources || typeof sources !== 'object') {
    return { count: 0, total: 0, ratio: 0, level: 'SKIP' };
  }
  const allUrls = [];
  for (const arr of Object.values(sources)) {
    if (Array.isArray(arr)) {
      for (const s of arr) {
        if (s && typeof s === 'object' && s.url) allUrls.push(s.url);
      }
    }
  }
  if (allUrls.length < 5) {
    return { count: 0, total: allUrls.length, ratio: 0, level: 'SKIP' };
  }
  let count = 0;
  for (const url of allUrls) {
    try {
      const host = new URL(url).host.toLowerCase();
      if (WIKI_HOST_REGEX.test(host)) count++;
    } catch {}
  }
  const ratio = count / allUrls.length;
  let level = 'OK';
  if (ratio > 0.3) level = 'FAIL';
  else if (ratio > 0.2) level = 'WARN';
  return { count, total: allUrls.length, ratio, level };
}

// ── 룰 X: detailReady array 항목 끝 마침표 검출 (2026-05-09) ───────────────
//
// SKILL 명시 룰 (job-data-master Safety Rule 14): detailReady.{curriculum,recruit,
// training} array 항목 끝에 마침표(`.` / `。`) 금지. [N] 출처 마커가 항목 종결자
// 역할. 산문 영역(way/trivia 등)은 적용 X — array만.
//
// 검출 패턴: 항목 본문 끝의 `[N]` 마커를 strip한 뒤 마지막 문자가 `.` 또는 `。`
//
// @param {object} detailReady - {curriculum, recruit, training, ...} 객체
// @returns {Array<{field: string, idx: number, preview: string}>} 마침표 끝 항목 list
const ARRAY_FIELDS_FOR_PERIOD = ['curriculum', 'recruit', 'training'];
function detectArrayItemPeriod(detailReady) {
  if (!detailReady || typeof detailReady !== 'object') return [];
  const hits = [];
  for (const sub of ARRAY_FIELDS_FOR_PERIOD) {
    const items = detailReady[sub];
    if (!Array.isArray(items)) continue;
    items.forEach((it, idx) => {
      const text = typeof it === 'string' ? it : (it && typeof it === 'object' ? (it.text || '') : '');
      if (!text) return;
      const stripped = text.replace(/\s*\[\d+\]\s*$/, '').trim();
      if (stripped.endsWith('.') || stripped.endsWith('。')) {
        hits.push({
          field: `detailReady.${sub}`,
          idx,
          preview: stripped.slice(-30),
        });
      }
    });
  }
  return hits;
}

// ── 룰 Y: detailReady array 출처 위치 cluster 검출 (2026-05-09) ─────────────
//
// SKILL 명시 룰 (job-data-master Safety Rule 15): 1 출처가 N 항목 cover하면서
// 마지막 항목에만 [N] 박힌 cluster 패턴 금지. **1 항목 = 1 [N] 마커**.
//
// 검출 조건 (모두 만족):
//   - detailReady.{sub} 항목 수 ≥ 2
//   - 출처 수 (sources['detailReady.{sub}'].length) < 항목 수
//   - 마커 보유 항목 수 < 항목 수 (일부 항목에만 마커)
//
// 즉 출처가 모든 항목 cover 못하면서 일부에만 [N] 박힌 패턴.
//
// @param {object} detailReady - {curriculum, recruit, training, ...} 객체
// @param {object} sources - _sources 객체 (fieldKey → 배열)
// @returns {Array<{field, items, sources, markedItems, preview}>} cluster 검출 list
// ── 룰 ZZ (2026-05-10 — Body Without Sources 차단) ────────────────────────────
//
// 산문 영역 본문 100자+ 또는 detailReady array 항목 2+ 인데 _sources 부재 사고 차단.
// 2026-05-10 사고 (사용자 발견): 경찰관 detailWlb.wlbDetail(157자) / socialDetail(115자) /
// detailReady.curriculum(3) / training(3) — 본문은 충실한데 [N]+_sources 모두 0.
// 원인: master force-enhance가 detailReady.recruit만 처리, 다른 영역 무시.
// 룰 Z (urlCountInsufficient)는 _sources 등록 fieldKey만 카운트라 fieldKey 부재 silent.
//
// 103 직업 sample: 42% (43/103) 영향. detailWlb.wlbDetail 34건 / socialDetail 28건 /
// overviewProspect.main 11건 / trivia 4건 / way 3건 / curriculum 1건.
//
// @param {object} proseRaw - data._proseRaw (산문 fieldKey raw string)
// @param {object} detailReady - data.detailReady ({ curriculum:[], recruit:[], training:[] })
// @param {object} sources - data._sources
// @returns {Array} findings (빈 배열이면 통과). 각 finding: { rule, area, field, bodyLen|items }
function detectBodyWithoutSources(proseRaw, detailReady, sources) {
  const findings = [];
  // 5 산문 필드만 — UCJ 작성 의무 영역. overviewWork.main / overviewAbilities.technKnow /
  // summary는 CareerNet API 원본 영역 (api_data_json) — UCJ 출처 의무 X (false positive 회피).
  // sal 영역 제외 — sal-protection.
  const proseFields = [
    'way', 'overviewProspect.main', 'trivia',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail',
  ];
  // 산문 영역
  if (proseRaw && typeof proseRaw === 'object') {
    for (const f of proseFields) {
      const body = typeof proseRaw[f] === 'string' ? proseRaw[f] : '';
      const srcArr = sources && Array.isArray(sources[f]) ? sources[f] : [];
      const urlCount = srcArr.filter(s => s && typeof s === 'object' && s.url).length;
      if (body.length >= 100 && urlCount === 0) {
        findings.push({ rule: 'bodyWithoutSources', area: 'prose', field: f, bodyLen: body.length });
      }
    }
  }
  // detailReady array
  if (detailReady && typeof detailReady === 'object') {
    for (const sub of ['curriculum', 'recruit', 'training']) {
      const arr = Array.isArray(detailReady[sub]) ? detailReady[sub] : [];
      if (arr.length < 2) continue;
      const fieldKey = `detailReady.${sub}`;
      const srcArr = sources && Array.isArray(sources[fieldKey]) ? sources[fieldKey] : [];
      const urlCount = srcArr.filter(s => s && typeof s === 'object' && s.url).length;
      // 모든 항목에 [N] 마커 부재 + _sources 0 → 본문만 잔존, 출처 0
      const itemsWithoutMarker = arr.filter(it => {
        const t = typeof it === 'string' ? it : (it && typeof it === 'object' ? (it.text || '') : '');
        return !/\[\d+\]/.test(t);
      }).length;
      if (itemsWithoutMarker === arr.length && urlCount === 0) {
        findings.push({ rule: 'bodyWithoutSources', area: 'detailReady', field: fieldKey, items: arr.length });
      }
    }
  }
  return findings;
}

// ── 룰 Z (2026-05-10 — URL Count Insufficient 차단) ───────────────────────────
//
// force-enhance 후 직업당 _sources URL count가 부족한 사고 재발 방지.
// 2026-05-09 사고: 103 직업 force-enhance 중 6 직업이 URL <10
//   - 기업고위임원 2 (way 글자수만)
//   - 대학교수 4 (cleanup 8개 제거 후 미보강)
//   - 의료정보시스템개발자 4 (4단계 인정)
//   - 물리치료사 5 (cleanup 6 cluster 제거)
//   - 간호조무사 7 (wiki 교체)
//   - 리포터 7 (careerTree만 집중)
//
// target: max(12, fieldsCount × 1.5). 미달 시 WARN (FAIL X — patch 차단 X, 다음 cycle 트리거).
//
// fieldsCount: _sources 객체의 키 수 (sidebar* 제외 권장이지만 단순화 위해 모든 fieldKey 포함)
//
// **2026-05-18 강화** (Rule WL-FULL-CYCLE 후속):
//   - count는 **distinct URL count** (Set 기반) — 같은 URL N번 재사용 사고 차단
//   - target minimum 12 → 18 강화 (사용자 명시 — 풀 사이클 force-enhance target)
//   - 옛 totalUrls (단순 합산)는 ref count로만 사용, count는 distinct
//
// @param {object} sources - _sources 객체 ({ "way": [...], "trivia": [...] })
// @returns {object|null} 부족 시 { rule, count, target, fieldsCount, refCount }, 충분 시 null
function detectUrlCountInsufficient(sources) {
  if (!sources || typeof sources !== 'object') return null;
  const fieldKeys = Object.keys(sources).filter(k => Array.isArray(sources[k]));
  const fieldsCount = fieldKeys.length;
  const distinctUrls = new Set();
  let refCount = 0;
  for (const fk of fieldKeys) {
    for (const s of sources[fk]) {
      if (s && typeof s === 'object' && typeof s.url === 'string' && s.url.length > 0) {
        distinctUrls.add(s.url);
        refCount += 1;
      }
    }
  }
  const count = distinctUrls.size;
  const minTarget = Math.max(18, Math.ceil(fieldsCount * 1.5));
  if (count < minTarget) {
    return { rule: 'urlCountInsufficient', count, refCount, target: minTarget, fieldsCount };
  }
  return null;
}

// ── 룰 24 (WL-FULL-CYCLE): detailReady array 마커 갯수 감소 검출 ─────────
//
// 사용자 사고 2026-05-18:
// 풀 사이클 force-enhance 시 detailReady 본문 [N] 마커 제거하면서 sources 보강 핑계 회피.
// 마커 갯수 감소는 곧 cover 영역 축소 — 데이터 가치 하락.
//
// patch.fields.detailReady[sub].items[*] 본문의 [N] 마커 갯수가
// prod merged_profile_json.detailReady[sub].items[*] 의 [N] 마커 갯수보다 적으면 사고.
//
// 사용법: server-side guard 또는 client validate에서
//   detectArrayMarkerCountDecrease(prodDetailReady, patchDetailReady)
//   → 감소 array 목록 반환
//
// @param {object} prodDr - prod merged_profile_json.detailReady
// @param {object} patchDr - patch.fields.detailReady (없으면 미적용)
// @returns {Array<{field, prodCount, patchCount, gap}>}
function detectArrayMarkerCountDecrease(prodDr, patchDr) {
  if (!prodDr || typeof prodDr !== 'object') return [];
  if (!patchDr || typeof patchDr !== 'object') return [];
  const hits = [];
  for (const sub of ARRAY_FIELDS_FOR_PERIOD) {
    if (!Array.isArray(patchDr[sub])) continue; // patch 영역 안 만진 경우 skip
    const prodItems = Array.isArray(prodDr[sub]) ? prodDr[sub] : [];
    const patchItems = patchDr[sub];
    const cntMarkers = (items) => items.reduce((acc, it) => {
      const t = typeof it === 'string' ? it : (it && typeof it === 'object' ? (it.text || '') : '');
      const m = t.match(/\[\d+\]/g);
      return acc + (m ? m.length : 0);
    }, 0);
    const prodCount = cntMarkers(prodItems);
    const patchCount = cntMarkers(patchItems);
    if (prodCount > 0 && patchCount < prodCount) {
      hits.push({
        field: `detailReady.${sub}`,
        prodCount,
        patchCount,
        gap: prodCount - patchCount,
      });
    }
  }
  return hits;
}

// ── 룰 ZZZZ (2026-05-11 — Orphan Sources FAIL) ────────────────────────────────
//
// 사용자 발견 사고 (경찰관, 2026-05-11): _sources에 `detailGrowth.growth` /
// `detailWork.workDetail` 영역 4건 등록되어 있는데 본문이 _proseRaw에 미노출,
// API top-level에도 detailGrowth / detailWork 자체가 없음. 본문 0인데 _sources만
// 잔존 → 사용자 시각 [11][12][13][14] orphan.
//
// Rule ZZZ (sourcesWithoutMarkers)는 본문 body.length>=100 케이스만 검출. 본문 자체가
// 0/미존재인 경우는 silent. Rule ZZZZ가 이 사고 영역 보강.
//
// 검출 조건:
//   - sources fieldKey가 sidebar*면 skip (룰 L 별도 검출)
//   - sources fieldKey가 overviewSalary.sal이면 skip (sal-protection)
//   - sources fieldKey가 detailReady.{curriculum|recruit|training}이면:
//       items 배열이 빈/모두 empty면 orphan
//   - 그 외 fieldKey:
//       _proseRaw[fieldKey] 또는 getNested(apiData, fieldKey)가
//         (a) 미존재 또는 (b) string이지만 length<50 또는 (c) array 항목 모두 length<50
//       → orphan
//
// 사고 차단: _sources에 등록은 됐는데 본문이 아예 없는 영역. 사용자 출처 섹션에서
// [N] 마커가 보이지만 본문에서 인용 위치를 못 찾는 케이스.
//
// @param {object} proseRaw - data._proseRaw
// @param {object} detailReady - data.detailReady
// @param {object} sources - data._sources
// @param {object} apiData - data 전체 (top-level fallback 용 — getNested)
// @returns {Array<{rule, area, field, srcsCount, severity}>} orphan findings
const SIDEBAR_FIELDS_SET = new Set(['sidebarCerts', 'sidebarOrgs', 'sidebarMajors', 'sidebarJobs']);
const SAL_PROTECTED_FIELDS_ZZZZ = new Set(['overviewSalary.sal']);
const MIN_BODY_LEN_FOR_NON_ORPHAN = 50;

function _getNestedZZZZ(obj, p) {
  if (!obj) return undefined;
  if (obj[p] !== undefined) return obj[p];
  let cur = obj;
  for (const part of p.split('.')) { if (cur == null) return undefined; cur = cur[part]; }
  return cur;
}

// ── normalizeProseBody: prose 필드 값을 audit용 raw string으로 통일 ────────────
//
// 배경: trivia / overviewWork.main 등 일부 prose 필드는 DB에 string 또는 array로
// 저장될 수 있다 (편집 UI / 사용자 POST 형식에 따라). 옛 detector가 `typeof v
// === 'string'`만 받아들이면 array 케이스에서 빈 본문으로 잘못 판정 → orphanSources
// false positive (R1 B4 금융상품개발자 2026-05-12 사고).
//
// 본 헬퍼는 array일 때 element 텍스트(string / .text / .title / .list_content
// / .value)를 join하여 server-side `pickString` (src/routes/api-data.ts)과
// 동일한 normalization을 detector layer에도 적용한다.
//
// @param {unknown} v - prose 필드 raw 값 (string | array | object | undefined)
// @returns {string} normalized body string (없으면 '')
function normalizeProseBody(v) {
  if (typeof v === 'string') return v;
  if (Array.isArray(v)) {
    return v
      .map((x) => {
        if (typeof x === 'string') return x;
        if (x && typeof x === 'object') {
          const o = x;
          if (typeof o.text === 'string') return o.text;
          if (typeof o.title === 'string') return o.title;
          if (typeof o.list_content === 'string') return o.list_content;
          if (typeof o.value === 'string') return o.value;
        }
        return '';
      })
      .filter((s) => s && s.length > 0)
      .join('\n');
  }
  return '';
}

function detectOrphanSources(proseRaw, detailReady, sources, apiData) {
  const findings = [];
  if (!sources || typeof sources !== 'object') return findings;
  for (const [fieldKey, srcArr] of Object.entries(sources)) {
    if (!Array.isArray(srcArr) || srcArr.length === 0) continue;
    if (SIDEBAR_FIELDS_SET.has(fieldKey)) continue;
    if (SAL_PROTECTED_FIELDS_ZZZZ.has(fieldKey)) continue;
    const urlCount = srcArr.filter(s => s && typeof s === 'object' && s.url).length;
    if (urlCount === 0) continue;

    // detailReady.{sub} array — items 검사
    if (fieldKey.startsWith('detailReady.')) {
      const sub = fieldKey.slice('detailReady.'.length);
      const items = detailReady && Array.isArray(detailReady[sub]) ? detailReady[sub] : [];
      const itemsLen = items.length;
      const nonEmpty = items.filter(it => {
        const t = typeof it === 'string' ? it : (it && typeof it === 'object' ? (it.text || it.title || '') : '');
        return t && t.trim().length > 0;
      }).length;
      if (itemsLen === 0 || nonEmpty === 0) {
        findings.push({
          rule: 'orphanSources',
          area: 'detailReady-empty',
          field: fieldKey,
          srcsCount: urlCount,
          itemsLen,
          severity: 'FAIL',
        });
      }
      continue;
    }

    // prose 영역 — _proseRaw 우선 (array도 normalize), 없으면 top-level getNested
    // proseRaw[fieldKey]가 string/array 어느 쪽이든 normalizeProseBody가 처리.
    let body = null;
    if (proseRaw && typeof proseRaw === 'object' && proseRaw[fieldKey] !== undefined) {
      body = normalizeProseBody(proseRaw[fieldKey]); // '' 가능
    } else if (apiData) {
      const v = _getNestedZZZZ(apiData, fieldKey);
      const norm = normalizeProseBody(v);
      if (norm) body = norm;
      else if (v !== undefined) body = ''; // 존재하지만 빈 array/object
    }
    if (body == null) {
      // 본문 자체가 미존재 (API top-level에도 없는 영역 — detailGrowth.growth, detailWork.workDetail 등)
      findings.push({
        rule: 'orphanSources',
        area: 'body-missing',
        field: fieldKey,
        srcsCount: urlCount,
        bodyLen: 0,
        severity: 'FAIL',
      });
      continue;
    }
    if (typeof body === 'string' && body.trim().length < MIN_BODY_LEN_FOR_NON_ORPHAN) {
      findings.push({
        rule: 'orphanSources',
        area: 'body-too-short',
        field: fieldKey,
        srcsCount: urlCount,
        bodyLen: body.trim().length,
        severity: 'FAIL',
      });
    }
  }
  return findings;
}

// ── 룰 ZZZ (2026-05-11 — Sources Without Markers FAIL) ─────────────────────────
//
// 사용자 발견 사고 (경찰관, 2026-05-11): "_sources 14개 등록되어 있는데 본문 [N]
// 인라인 각주에 안 박혀 있다". 사용자 관점 즉시 누락 사고.
//
// Rule ZZ (bodyWithoutSources)는 body 100+ AND _sources 0 케이스를 잡지만,
// _sources >= 1 인데 [N] 마커가 본문에 1개도 없는 케이스 (정반대 사고)는 silent.
//
// Rule ZZZ 정의:
//   - prose 8 필드 (way / overviewProspect.main / trivia / detailWlb.wlbDetail /
//     detailWlb.socialDetail / overviewWork.main / summary / overviewAbilities.technKnow)
//   - body.length >= 100 AND _sources[field].url 수 >= 1 AND body 안 /\[\d+\]/g = 0
//   - → FAIL (사용자 시각 누락 사고)
//
// 레벨: FAIL (WARN 아님). 사용자가 곧바로 본문에서 발견하는 사고.
//
// proseRaw 우선 (PR 1, 2026-05-08). detail* / Growth.growth 등 _proseRaw 미노출
// 필드의 orphan 사고는 별도 (detectOrphanSourceIdx에서 처리해야 하지만 BODY_FIELDS
// 미포함으로 silent — 추후 별도 보강 영역).
//
// sal-protection: overviewSalary.sal 제외 (proseFields list에서 빼놓음).
//
// @param {object} proseRaw - data._proseRaw (산문 fieldKey raw string)
// @param {object} detailReady - data.detailReady (선택 — 현재 detector는 prose만)
// @param {object} sources - data._sources
// @returns {Array} findings (빈 배열이면 통과). 각 finding: { rule, area, field, bodyLen, srcsCount, severity }
function detectSourcesWithoutMarkers(proseRaw, detailReady, sources) {
  const findings = [];
  const proseFields = [
    'way',
    'overviewProspect.main',
    'trivia',
    'detailWlb.wlbDetail',
    'detailWlb.socialDetail',
    'overviewWork.main',
    'summary',
    'overviewAbilities.technKnow',
  ];
  if (!proseRaw || typeof proseRaw !== 'object') return findings;
  for (const f of proseFields) {
    const body = typeof proseRaw[f] === 'string' ? proseRaw[f] : '';
    if (body.length < 100) continue;
    const srcArr = sources && Array.isArray(sources[f]) ? sources[f] : [];
    const srcsCount = srcArr.filter(s => s && typeof s === 'object' && s.url).length;
    if (srcsCount === 0) continue; // Rule ZZ 영역
    const markerCount = (body.match(/\[\d+\]/g) || []).length;
    if (markerCount === 0) {
      findings.push({
        rule: 'sourcesWithoutMarkers',
        area: 'prose',
        field: f,
        bodyLen: body.length,
        srcsCount,
        severity: 'FAIL',
      });
    }
  }
  return findings;
}

function detectSourcePositionCluster(detailReady, sources) {
  if (!detailReady || typeof detailReady !== 'object') return [];
  if (!sources || typeof sources !== 'object') return [];
  const hits = [];
  for (const sub of ARRAY_FIELDS_FOR_PERIOD) {
    const items = detailReady[sub];
    if (!Array.isArray(items) || items.length < 2) continue;
    const srcArr = sources[`detailReady.${sub}`];
    if (!Array.isArray(srcArr) || srcArr.length === 0) continue;
    const markedItems = items.reduce((acc, it) => {
      const text = typeof it === 'string' ? it : (it && typeof it === 'object' ? (it.text || '') : '');
      return acc + (/\[\d+\]/.test(text) ? 1 : 0);
    }, 0);
    if (srcArr.length < items.length && markedItems < items.length) {
      hits.push({
        field: `detailReady.${sub}`,
        items: items.length,
        sources: srcArr.length,
        markedItems,
        preview: typeof items[items.length - 1] === 'string'
          ? items[items.length - 1].slice(-30)
          : '',
      });
    }
  }
  return hits;
}

// ──────────────────────────────────────────────────────────────────────
// 룰 OMEGA (2026-05-15) — 통합 body-source-marker mismatch 자동 스캔
// 화이트리스트 폐기: _proseRaw/detailReady/_sources 키 자동 enumerate.
// abilities·duties 등 새 영역도 별도 룰 추가 없이 검출.
//
// 단, careernet 원본 영역 (사용자 편집 X, 출처 등록 의무 약)은 prose 검사 제외.
// 이 영역은 audit 노이즈 무한 양산 — 사용자 편집 영역만 검사 대상.
// ──────────────────────────────────────────────────────────────────────
const OMEGA_PROSE_EXCLUDE = new Set([
  'summary',                  // careernet 직무 정의 — 원본 데이터
  'overviewWork.main',        // careernet 직무 상세
  'overviewWork.detail',      // careernet 직무 세부
]);
// detailReady array 중 careernet 원본 보존 영역 — LLM 출처 등록 불가. OMEGA array 검사 제외.
const OMEGA_ARRAY_EXCLUDE = new Set([
  'researchList',
  'certificate',
  'pathExplore',
]);

function detectAllBodySourceMarkerMismatch(proseRaw, detailReady, sources) {
  const findings = [];
  const pr = proseRaw && typeof proseRaw === 'object' ? proseRaw : {};
  const dr = detailReady && typeof detailReady === 'object' ? detailReady : {};
  const srcs = sources && typeof sources === 'object' ? sources : {};

  // 1. _proseRaw 전체 키 자동 스캔 (화이트리스트 X — careernet 원본 영역만 minimal exclude)
  // 2026-05-12: array trivia 등 normalize — string만 받으면 array body는 silent skip되어
  // bodyWithoutSources / sourcesWithoutMarkers false negative + section 3 orphan false positive.
  for (const fieldKey of Object.keys(pr)) {
    if (OMEGA_PROSE_EXCLUDE.has(fieldKey)) continue;
    const body = normalizeProseBody(pr[fieldKey]);
    if (body.length < 100) continue;
    const arr = Array.isArray(srcs[fieldKey]) ? srcs[fieldKey].filter(s => s && s.url) : [];
    const markerCount = (body.match(/\[\d+\]/g) || []).length;

    if (arr.length === 0) {
      findings.push({ rule: 'bodyWithoutSources', area: 'prose', field: fieldKey, bodyLen: body.length, markerCount, srcsCount: 0, severity: 'FAIL' });
    } else if (markerCount === 0) {
      findings.push({ rule: 'sourcesWithoutMarkers', area: 'prose', field: fieldKey, bodyLen: body.length, markerCount: 0, srcsCount: arr.length, severity: 'FAIL' });
    }
  }

  // 2. detailReady array 자동 스캔 (careernet 원본 보존 영역 exclude)
  for (const arrayKey of Object.keys(dr)) {
    if (OMEGA_ARRAY_EXCLUDE.has(arrayKey)) continue;
    const items = Array.isArray(dr[arrayKey]) ? dr[arrayKey] : null;
    if (!items) continue;
    const norm = items
      .map(i => (typeof i === 'string' ? i : (i && (i.text || i.title)) || ''))
      .filter(t => t && t.length >= 30);
    if (norm.length === 0) continue;
    const fieldKey = 'detailReady.' + arrayKey;
    const arr = Array.isArray(srcs[fieldKey]) ? srcs[fieldKey].filter(s => s && s.url) : [];
    const markerCounts = norm.map(t => (t.match(/\[\d+\]/g) || []).length);
    const totalMarkers = markerCounts.reduce((a, b) => a + b, 0);
    const coveredItems = markerCounts.filter(c => c > 0).length;

    if (arr.length === 0 && totalMarkers === 0 && norm.some(t => t.length >= 50)) {
      findings.push({ rule: 'arrayBodyWithoutSources', area: 'array', field: fieldKey, itemCount: norm.length, totalMarkers: 0, srcsCount: 0, severity: 'FAIL' });
    } else if (totalMarkers > 0 && arr.length < coveredItems) {
      findings.push({ rule: 'arrayBrokenRef', area: 'array', field: fieldKey, itemCount: norm.length, totalMarkers, coveredItems, srcsCount: arr.length, severity: 'FAIL' });
    } else if (coveredItems > 0 && coveredItems < norm.length) {
      findings.push({ rule: 'arrayCluster', area: 'array', field: fieldKey, itemCount: norm.length, coveredItems, srcsCount: arr.length, severity: 'WARN' });
    } else if (arr.length > 0 && totalMarkers === 0) {
      findings.push({ rule: 'sourcesWithoutMarkers', area: 'array', field: fieldKey, itemCount: norm.length, totalMarkers: 0, srcsCount: arr.length, severity: 'FAIL' });
    }
  }

  // 3. _sources 키 자동 스캔 — body 미존재 시 orphan
  const sidebarOrphanForbidden = new Set(SIDEBAR_FIELDS_FORBIDDEN || []);
  for (const srcKey of Object.keys(srcs)) {
    if (sidebarOrphanForbidden.has(srcKey)) continue; // sidebar는 별도 룰 L에서 처리
    if (srcKey === 'overviewSalary.sal') continue; // sal 영역은 별도 보호
    const arr = Array.isArray(srcs[srcKey]) ? srcs[srcKey].filter(s => s && s.url) : [];
    if (arr.length === 0) continue;
    let bodyExists = false;
    // 2026-05-12: array trivia 등 normalize — 옛 `typeof v === 'string'`만 받던 검사가
    // array body를 false 판정 → orphanSources false positive (R1 B4 금융상품개발자 사고).
    if (Object.prototype.hasOwnProperty.call(pr, srcKey)) {
      const norm = normalizeProseBody(pr[srcKey]);
      if (norm.length >= 30) bodyExists = true;
    }
    if (!bodyExists && srcKey.startsWith('detailReady.')) {
      const sub = srcKey.slice('detailReady.'.length);
      const items = Array.isArray(dr[sub]) ? dr[sub] : null;
      if (items && items.length > 0) bodyExists = true;
    }
    if (!bodyExists) {
      findings.push({ rule: 'orphanSources', area: 'meta', field: srcKey, srcsCount: arr.length, severity: 'FAIL' });
    }
  }

  return findings;
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
  // 룰 J/K (2026-05-06 detailReady arrays 사고 + 본문 순서 사고 차단)
  detectBrokenSourceRefArrayItems,
  detectMarkerOrderViolation,
  // 룰 L (2026-05-06 후속 — sidebar 영역 _sources orphan 차단)
  detectSidebarSources,
  SIDEBAR_FIELDS_FORBIDDEN,
  // 룰 13/14 (2026-05-07 — root URL 회피 + Wikipedia 점유율 ≤ 30%)
  detectRootDomainOnly,
  ROOT_PATH_PATTERNS,
  calcWikiQuota,
  WIKI_HOST_REGEX,
  // proseBodyOrphan wrapper + 산문 fieldKey list (2026-05-08, PR 14)
  detectProseBodyMismatch,
  PROSE_BODY_FIELDS,
  // 룰 X/Y (2026-05-09 — array 마침표 + 출처 위치 cluster)
  detectArrayItemPeriod,
  detectSourcePositionCluster,
  ARRAY_FIELDS_FOR_PERIOD,
  // 룰 Z (2026-05-10 — URL Count Insufficient WARN)
  detectUrlCountInsufficient,
  // 룰 ZZ (2026-05-10 — Body Without Sources WARN)
  detectBodyWithoutSources,
  // 룰 ZZZ (2026-05-11 — Sources Without Markers FAIL)
  detectSourcesWithoutMarkers,
  // 룰 ZZZZ (2026-05-11 — Orphan Sources FAIL — 본문 없는 영역에 _sources만 잔존)
  detectOrphanSources,
  // 룰 OMEGA (2026-05-15 — 통합 자동 스캔, 화이트리스트 폐기)
  detectAllBodySourceMarkerMismatch,
  OMEGA_PROSE_EXCLUDE,
  OMEGA_ARRAY_EXCLUDE,
  // prose 본문 normalize 헬퍼 (2026-05-12 — array trivia 등 false positive 차단)
  normalizeProseBody,
  // 룰 24 WL-FULL-CYCLE (2026-05-18 — array 마커 갯수 감소 검출)
  detectArrayMarkerCountDecrease,
};
