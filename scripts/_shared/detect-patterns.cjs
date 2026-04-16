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

module.exports = { detectMultipleUrlsInSourceText, detectMergedOrgLabel, detectMergedSourceText, TRUNCATED_PATTERNS, COMPLETE_ENDINGS, FP_SUFFIXES, ORG_NAME_PAT, detectMojibake, MOJI_RANGES };
