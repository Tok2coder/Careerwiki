#!/usr/bin/env node
// scripts/skill-cache/audit-numeric-provenance.cjs
// 본문 수치 주장(fact) ↔ 출처 원문 대조 게이트 (R122~R126 5 cycle 연속 수치 오류 사고 후속).
//
// self-report ("출처 원문과 대조하라" 프롬프트)로는 3 cycle째 재발 — 결정적 스크립트로 강제한다.
//
// 사용:
//   node scripts/skill-cache/audit-numeric-provenance.cjs <slug1> [slug2 ...]
//   node scripts/skill-cache/audit-numeric-provenance.cjs --cycle=126
//   node scripts/skill-cache/audit-numeric-provenance.cjs <slug> --strict   (NOT_FOUND>0 → exit 1)
//
// 동작:
//   1) GET /api/job/{slug}/edit-data 로 _proseRaw(본문)·_sources 를 받는다.
//   2) 산문 필드(PROSE_BODY_FIELDS)별 문장 분리 → 문장별 수치 주장(숫자+단위) 추출.
//   3) 문장에 붙은 각주 [N] → 필드-로컬 _sources[field][N-1] 매핑 → URL fetch.
//   4) 판정: FOUND / UNIT_MISMATCH / NOT_FOUND / UNFETCHABLE / NO_FOOTNOTE.
//   5) read-only — DB/prod 편집 없음.
//
// READ-ONLY: 이 스크립트는 어떤 POST/PUT/DELETE도 수행하지 않는다.

'use strict';

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');
const { URL } = require('url');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const { PROSE_BODY_FIELDS, normalizeProseBody } = require(
  path.join(REPO_ROOT, 'scripts', '_shared', 'detect-patterns.cjs')
);

// /edit-data 는 인증 불필요(master-verify-cycle.cjs 와 동일) — 비밀키 하드코딩 금지.
// 필요 시에만 환경변수로 주입한다: ADMIN_SECRET=... node scripts/skill-cache/audit-numeric-provenance.cjs ...
const ADMIN_SECRET = process.env.ADMIN_SECRET || '';
const CYCLE_LIST_FILE = path.join(REPO_ROOT, 'data', 'cycle', 'master_list_R7_R229.jsonl');

// ── 1. 수치 주장 추출 ─────────────────────────────────────────────────────────

// 단위 토큰 — 긴 것부터 매칭되도록 길이 내림차순 정렬해 alternation에 사용.
const UNIT_TOKENS = [
  '조', '억', '만', '천', '원', '%', '퍼센트', '톤', 'kg', '㎏', 'g', 'mm', '㎜',
  'cm', 'm', '㎛', '년', '개월', '일', '명', '개사', '곳', '건', '대', '회', '배',
  '시간', '분', '℃', '배럴', '㎥',
];
function escapeRe(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}
const UNIT_SORTED = [...UNIT_TOKENS].sort((a, b) => b.length - a.length);
const UNIT_ALT = UNIT_SORTED.map(escapeRe).join('|');
const NUM_PART = '\\d[\\d,]*(?:\\.\\d+)?';
const CLAIM_RE = new RegExp(`(${NUM_PART})(?:\\s*[~\\-–]\\s*(${NUM_PART}))?(${UNIT_ALT})`, 'g');

// 문장 분리 — 마침표/느낌표/물음표(각주 마커 동반 가능) 뒤 공백, 또는 개행 기준.
function splitSentences(text) {
  if (!text || typeof text !== 'string') return [];
  const paragraphs = text.split(/\n+/);
  const sentences = [];
  for (const para of paragraphs) {
    const trimmedPara = para.trim();
    if (!trimmedPara) continue;
    const parts = trimmedPara.split(/(?<=[.!?](?:\[\d+\])*)\s+(?=\S)/);
    for (const p of parts) {
      const s = p.trim();
      if (s) sentences.push(s);
    }
  }
  return sentences;
}

// 문장 하나에서 수치 주장 목록 추출. 단위가 붙지 않은 순수 숫자는 애초에 매치되지 않음
// (요구사항 "1~2자리 소수/단위 없는 작은 정수 제외"는 이 규칙으로 자동 충족).
function extractClaims(sentenceText) {
  const claims = [];
  CLAIM_RE.lastIndex = 0;
  let m;
  while ((m = CLAIM_RE.exec(sentenceText))) {
    const [full, n1, n2, unit] = m;
    // 법령 조문 인용 오탐 억제 — "제4조"/"제77조"의 "조"는 兆(trillion)이 아니라
    // 법률 조문 번호("Article N")다. 직전 글자가 "제"이면 금액 단위 "조"가 아니므로 제외.
    // (외과전문의사 실사고: 「…규정 시행규칙」 제4조 → "4조"를 조(兆) 단위로 오인해 NOT_FOUND 오탐)
    if (unit === '조' && sentenceText[m.index - 1] === '제') continue;
    claims.push({
      raw: full,
      numbers: n2 ? [n1, n2] : [n1],
      unit,
      isRange: !!n2,
      start: m.index,
      end: m.index + full.length,
    });
  }
  return claims;
}

function extractFootnotes(sentenceText) {
  const nums = [];
  for (const m of sentenceText.matchAll(/\[(\d+)\]/g)) nums.push(Number(m[1]));
  return nums;
}

// ── 복합 한글 대수 표현 오탐 억제 (예: "6억 9,158만") ──────────────────────────
//
// 사고 사례 e): "6억 9,158만 톤" vs 출처 "690,000천톤" — 표기 형식이 다를 뿐
// 실제로는 등가 수치일 수 있음. 단위 매핑 그대로 개별 검사하면 자릿수 표기 차이
// 때문에 정당한 케이스도 NOT_FOUND(=날조 의심)로 잘못 분류될 위험이 있다.
// → "조>억>만>천" 순으로 인접(공백만 개재)한 숫자+단위 쌍은 "복합 표현"으로
//   묶어 개별적으로 NOT_FOUND 판정하지 않고, 두 숫자가 모두 원문에 존재하면
//   FOUND, 아니면 UNFETCHABLE(compoundAmbiguous — 판정 보류)로 처리한다.
// 주의: 같은 단위가 반복되는 경우(예: "10조→19조")는 대상이 아니다 — 그건
// 실제 사고(제지 생산액 10조→19조 날조)를 그대로 잡아야 하므로 제외해야 한다.
const MAGNITUDE_ORDER = ['조', '억', '만', '천'];
const MAGNITUDE_MULT = { 천: 1e3, 만: 1e4, 억: 1e8, 조: 1e12 };

// R131 실측 사고(복합수 분해 ①/④): "2만 9,072명" → "2만"(만)/"9,072명"(명) 두 claim으로
// 쪼개지는데, 기존 로직은 두 번째 claim의 unit이 조/억/만/천(MAGNITUDE_ORDER)이 아니면
// (예: "명") 아예 복합군으로 묶지 않아 개별 대조로 새 버려 UNIT_MISMATCH/NOT_FOUND 오탐을
// 냈다("7만3260" ↔ "7만"+"3260원" 같은 무공백 인접 케이스도 동일). c1이 순수 대수 단위
// (조/억/만/천)이기만 하면, c2는 더 큰/같은 대수 단위만 아니면(=반복 케이스 제외) 어떤
// 단위든(대수 단위 포함 더 작은 단위, 또는 개체 단위) 묶어 결합값을 계산한다.
function findCompoundGroups(claims, sentenceText) {
  const groups = [];
  const used = new Set();
  for (let i = 0; i < claims.length - 1; i++) {
    if (used.has(i)) continue;
    const c1 = claims[i];
    const c2 = claims[i + 1];
    const r1 = MAGNITUDE_ORDER.indexOf(c1.unit);
    if (r1 === -1) continue; // c1은 반드시 순수 대수 단위(조/억/만/천)여야 함
    const r2 = MAGNITUDE_ORDER.indexOf(c2.unit);
    // 같은/더 큰 대수 단위 반복(예: 제지 생산액 "10조→19조" 사고)은 실제 별개 수치이므로 제외.
    if (r2 !== -1 && r2 <= r1) continue;
    if (c1.isRange || c2.isRange) continue;
    const between = sentenceText.slice(c1.end, c2.start);
    if (!/^\s*$/.test(between)) continue; // 공백(또는 무공백) 인접만 복합 표현으로 간주
    groups.push([i, i + 1]);
    used.add(i);
    used.add(i + 1);
  }
  return groups;
}

// 복합 표현의 결합 수치값 계산 — c2가 대수 단위면 두 배수를 더하고(예: "6억"+"9,158만"),
// c2가 개체 단위(명/원 등)면 c1의 배수값에 c2의 원 숫자를 그대로 더한다(예: "2만"+"9,072명"→29072).
function combineMagnitudeValue(c1, c2) {
  const r1 = MAGNITUDE_ORDER.indexOf(c1.unit);
  if (r1 === -1 || c1.isRange || c2.isRange) return null;
  const base1 = Number(digitsOnly(c1.numbers[0])) * MAGNITUDE_MULT[c1.unit];
  const r2 = MAGNITUDE_ORDER.indexOf(c2.unit);
  const base2 = r2 !== -1
    ? Number(digitsOnly(c2.numbers[0])) * MAGNITUDE_MULT[c2.unit]
    : Number(digitsOnly(c2.numbers[0]));
  const total = base1 + base2;
  return isFinite(total) ? Math.round(total) : null;
}

// ── 2. 숫자 매칭 ─────────────────────────────────────────────────────────────

function digitsOnly(s) {
  return String(s).replace(/[,\s]/g, '');
}

// 전각(全角) 숫자·콤마·마침표 → 반각 변환 — 원문(원자재 판매 사이트 등)이 전각으로 표기하는
// 경우 본문(반각)과 표기만 다를 뿐 동일 수치인데 NOT_FOUND로 오판되는 사고 방지(요구사항 ④).
function toHalfWidthDigitsAndComma(s) {
  if (!s) return s;
  return s
    .replace(/[０-９]/g, (c) => String.fromCharCode(c.charCodeAt(0) - 0xff10 + 0x30))
    .replace(/，/g, ',')
    .replace(/．/g, '.');
}

// 숫자 문자열(콤마 유무 양쪽 시도)이 text 안에 등장하는 모든 위치의 ±25자 윈도우를 반환.
// 다른 숫자 안에 부분열로 우연히 걸리지 않도록 앞뒤 non-digit 경계를 강제한다
// (예: "1500"이 "15000" 안에서 우연히 매치되는 것을 방지).
function findNumberWindows(numStr, text) {
  if (!text) return [];
  const variants = new Set([numStr, digitsOnly(numStr)]);
  const stripped = text.replace(/,/g, '');
  const windows = [];
  for (const variant of variants) {
    if (!variant) continue;
    const re = new RegExp(`(?<!\\d)${escapeRe(variant)}(?!\\d)`, 'g');
    for (const t of [text, stripped]) {
      let m;
      re.lastIndex = 0;
      while ((m = re.exec(t))) {
        const start = Math.max(0, m.index - 25);
        const end = Math.min(t.length, m.index + variant.length + 25);
        windows.push(t.slice(start, end));
      }
    }
  }
  return windows;
}

const VERDICT_RANK = { FOUND: 0, UNIT_MISMATCH: 1, NOT_FOUND: 2, UNFETCHABLE: 3 };

// 단위 글리프 동치군 — 조판용 합자(U+338F ㎏ 등)와 ASCII 표기를 같은 단위로 본다.
// (R126 실측 오탐: 본문 "1,500kg" vs 원문 "1500㎏" 이 UNIT_MISMATCH로 잡혔다)
const UNIT_EQUIV = [
  ['kg', '㎏', 'KG', 'Kg'],
  ['mm', '㎜', 'MM'],
  ['cm', '㎝'],
  ['m', 'ｍ'],
  ['㎛', 'um', 'μm'],
  ['g', 'ｇ'],
  ['%', '％', '퍼센트'],
  ['톤', 't', 'ton', 'TON'],
  ['㎥', 'm3'],
];
function unitVariants(unit) {
  const grp = UNIT_EQUIV.find((g) => g.includes(unit));
  return grp ? grp : [unit];
}

// 한글 대수 단위는 원문이 전개형으로 쓰는 경우가 많다("5만 톤" ↔ "50,000톤", "6,500톤" ↔ "6500").
// 본문 표기만으로 NOT_FOUND를 내면 오탐이 되므로 전개형도 함께 조회한다. (R126 전수 실측으로 추가)
// MAGNITUDE_MULT는 findCompoundGroups 근처(위)에서 이미 선언됨 — 재사용.
function expandedForms(numStr, unit) {
  const mult = MAGNITUDE_MULT[unit];
  if (!mult) return [];
  const base = Number(String(numStr).replace(/,/g, ''));
  if (!isFinite(base)) return [];
  const v = base * mult;
  if (!isFinite(v) || v > 1e15) return [];
  const plain = String(Math.round(v));
  const withComma = plain.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  return [plain, withComma];
}

function matchSingleNumber(numStr, unit, sourceText) {
  const variants = unitVariants(unit);
  const windows = findNumberWindows(numStr, sourceText);
  if (windows.length > 0) {
    return windows.some((w) => variants.some((u) => w.includes(u))) ? 'FOUND' : 'UNIT_MISMATCH';
  }
  // 대수 단위 전개형 재조회 — 찾으면 FOUND(단위 토큰은 전개형에선 달라지므로 단위 검사 생략)
  for (const form of expandedForms(numStr, unit)) {
    if (findNumberWindows(form, sourceText).length > 0) return 'FOUND';
  }
  return 'NOT_FOUND';
}

// 범위 주장("30~50시간")은 양끝 숫자 모두 확인 — 더 나쁜(=신뢰도 낮은) 쪽 채택.
function matchClaim(claim, sourceText) {
  if (claim.isRange) {
    const v1 = matchSingleNumber(claim.numbers[0], claim.unit, sourceText);
    const v2 = matchSingleNumber(claim.numbers[1], claim.unit, sourceText);
    return VERDICT_RANK[v1] >= VERDICT_RANK[v2] ? v1 : v2;
  }
  return matchSingleNumber(claim.numbers[0], claim.unit, sourceText);
}

// 연도 단독 표기 오탐 억제 — "2024년" 같은 값이 본문에는 있으나 출처 URL/라벨에만
// 있는 경우(예: 게시 연도 URL 세그먼트) FOUND로 처리.
function isYearException(claim, sourceMeta) {
  if (claim.unit !== '년' || claim.isRange) return false;
  const n = digitsOnly(claim.numbers[0]);
  if (!/^(19|20)\d{2}$/.test(n)) return false;
  const hay = `${(sourceMeta && sourceMeta.url) || ''} ${(sourceMeta && sourceMeta.text) || ''}`;
  return hay.includes(n);
}

// ── 연도 축약 표기 대조 (요구사항 ②) ────────────────────────────────────────
// 원문이 보도자료 관행상 "'26년"/"’26.6.1." 처럼 두 자리로 축약해 쓰는 경우가 많다.
// 본문은 "2026년"으로 완전 표기하므로 그대로 대조하면 NOT_FOUND/UNIT_MISMATCH로 오판된다.
function yearAbbrevMatch(numStr, sourceText) {
  const n = digitsOnly(numStr);
  if (!/^(19|20)\d{2}$/.test(n)) return false;
  const last2 = n.slice(2);
  const re = new RegExp(`[’'‘’\`]\\s*${last2}(?!\\d)`);
  return re.test(sourceText);
}

// ── 법령·공시 날짜 표기차 대조 (요구사항 ③) ─────────────────────────────────
// 본문 "2018년 10월 8일" ↔ 원문(법제처 등) "[시행 2018. 10. 8.]" — 같은 날짜를
// 문장 부호만 다르게 쓴다. 문장에서 "YYYY년 M월 D일" 패턴을 통째로 찾아 그 범위
// 안에 있는 claim(년/일 단위)에 한해 점(.)/하이픈(-) 변형으로도 원문을 대조한다.
const DATE_CONTEXT_RE = /(\d{4})\s*년\s*(\d{1,2})\s*월\s*(\d{1,2})\s*일/g;
function extractDateContexts(sentenceText) {
  const contexts = [];
  let m;
  DATE_CONTEXT_RE.lastIndex = 0;
  while ((m = DATE_CONTEXT_RE.exec(sentenceText))) {
    contexts.push({
      start: m.index,
      end: m.index + m[0].length,
      year: Number(m[1]),
      month: Number(m[2]),
      day: Number(m[3]),
    });
  }
  return contexts;
}
function dateVariants(y, m, d) {
  const mm = String(m).padStart(2, '0');
  const dd = String(d).padStart(2, '0');
  const out = new Set();
  for (const mv of new Set([String(m), mm])) {
    for (const dv of new Set([String(d), dd])) {
      out.add(`${y}. ${mv}. ${dv}`);
      out.add(`${y}. ${mv}. ${dv}.`);
      out.add(`${y}.${mv}.${dv}`);
      out.add(`${y}.${mv}.${dv}.`);
      out.add(`${y}-${mv}-${dv}`);
    }
  }
  return [...out];
}
function dateContextMatch(claim, sentenceText, sourceText) {
  if (claim.unit !== '년' && claim.unit !== '일') return false;
  const contexts = extractDateContexts(sentenceText);
  const ctx = contexts.find((c) => claim.start >= c.start && claim.end <= c.end);
  if (!ctx) return false;
  const normalizedSource = sourceText.replace(/\s+/g, ' ');
  return dateVariants(ctx.year, ctx.month, ctx.day).some((v) => normalizedSource.includes(v));
}

// ── 3. HTML → plain text ────────────────────────────────────────────────────

function decodeEntities(s) {
  return s
    .replace(/&nbsp;/gi, ' ')
    .replace(/&amp;/gi, '&')
    .replace(/&lt;/gi, '<')
    .replace(/&gt;/gi, '>')
    .replace(/&quot;/gi, '"')
    .replace(/&#39;|&apos;/gi, "'")
    .replace(/&#(\d+);/g, (_, d) => {
      try { return String.fromCodePoint(parseInt(d, 10)); } catch { return ''; }
    })
    .replace(/&#x([0-9a-fA-F]+);/g, (_, h) => {
      try { return String.fromCodePoint(parseInt(h, 16)); } catch { return ''; }
    });
}

function htmlToText(html) {
  if (!html || typeof html !== 'string') return '';
  let s = html;
  s = s.replace(/<script[\s\S]*?<\/script>/gi, ' ');
  s = s.replace(/<style[\s\S]*?<\/style>/gi, ' ');
  s = s.replace(/<!--[\s\S]*?-->/g, ' ');
  s = s.replace(/<[^>]+>/g, ' ');
  s = decodeEntities(s);
  s = s.replace(/\s+/g, ' ').trim();
  return s;
}

// ── 4. URL fetch (브라우저 UA, 리다이렉트 5, timeout 15s, 최소헤더 재시도) ─────

const FETCH_TIMEOUT_MS = 15000;
const MAX_BODY_BYTES = 3 * 1024 * 1024;
const BROWSER_UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36';

function httpGet(urlStr, { minimalHeaders = false, redirectsLeft = 5 } = {}) {
  return new Promise((resolve) => {
    let parsed;
    try { parsed = new URL(urlStr); } catch (e) { return resolve({ ok: false, reason: 'invalid-url' }); }
    if (parsed.protocol !== 'http:' && parsed.protocol !== 'https:') {
      return resolve({ ok: false, reason: 'bad-protocol' });
    }
    const lib = parsed.protocol === 'https:' ? https : http;
    const headers = minimalHeaders
      ? { 'User-Agent': BROWSER_UA, Accept: 'text/html,*/*;q=0.8' }
      : {
          'User-Agent': BROWSER_UA,
          Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language': 'ko,en;q=0.9',
        };
    let settled = false;
    const req = lib.request(
      {
        method: 'GET',
        hostname: parsed.hostname,
        port: parsed.port || (parsed.protocol === 'https:' ? 443 : 80),
        path: (parsed.pathname || '/') + parsed.search,
        headers,
        timeout: FETCH_TIMEOUT_MS,
        rejectUnauthorized: false,
      },
      (res) => {
        const status = res.statusCode;
        if ([301, 302, 303, 307, 308].includes(status) && res.headers.location && redirectsLeft > 0) {
          let nextUrl;
          try { nextUrl = new URL(res.headers.location, urlStr).href; } catch (e) {
            res.resume();
            if (!settled) { settled = true; resolve({ ok: false, reason: 'bad-redirect' }); }
            return;
          }
          res.resume();
          httpGet(nextUrl, { minimalHeaders, redirectsLeft: redirectsLeft - 1 }).then((r) => {
            if (!settled) { settled = true; resolve(r); }
          });
          return;
        }
        if (status < 200 || status >= 400) {
          res.resume();
          if (!settled) { settled = true; resolve({ ok: false, status, reason: `http-${status}` }); }
          return;
        }
        const chunks = [];
        let size = 0;
        res.on('data', (c) => {
          size += c.length;
          if (size <= MAX_BODY_BYTES) chunks.push(c);
          else req.destroy();
        });
        res.on('end', () => {
          if (!settled) {
            settled = true;
            resolve({ ok: true, status, bodyBuffer: Buffer.concat(chunks), contentType: res.headers['content-type'] });
          }
        });
        res.on('error', () => {
          if (!settled) { settled = true; resolve({ ok: false, reason: 'stream-error' }); }
        });
      }
    );
    req.on('timeout', () => {
      req.destroy();
      if (!settled) { settled = true; resolve({ ok: false, reason: 'timeout' }); }
    });
    req.on('error', (e) => {
      if (!settled) { settled = true; resolve({ ok: false, reason: (e && e.message) || 'error' }); }
    });
    req.end();
  });
}

// PDF·JS 렌더 페이지(SPA shell) 오탐 억제 — 실사고(외과전문의사 law.go.kr): HTTP 200 이지만
// 실제 조문은 클라이언트 JS가 그려서 원시 HTML엔 17~21자 shell만 있음. 이걸 "원문"으로 보고
// 숫자 매칭을 시도하면 항상 NOT_FOUND(날조 오판)가 나온다. 추출 텍스트가 임계치 미만이면
// 판정 불가(UNFETCHABLE)로 처리 — fetch 자체는 성공했어도 본문 추출 실패와 동일 취급.
// v2: 200→500 상향(가시 텍스트 500자 미만 = JS 셸 의심, 요구사항 1).
const MIN_USABLE_TEXT_LEN = 500;

function isPdfResponse(contentTypeHeader, urlStr) {
  if (contentTypeHeader && /application\/pdf/i.test(contentTypeHeader)) return true;
  if (/\.pdf(?:[?#]|$)/i.test(urlStr)) return true;
  return false;
}

// EUC-KR 인코딩 사이트 mojibake 오탐 억제 — 실사고(와이어커팅기조작원 spmedm.cafe24.com):
// 본문에 "33년 동안 ..."이 실제로 있는데도 EUC-KR 바이트를 UTF-8로 오디코딩하면 한글이
// 깨져(mojibake) 단위 토큰 "년"이 매칭 실패 → 정상 출처가 UNIT_MISMATCH로 오판된다.
// Content-Type 헤더 또는 <meta charset> 선언에서 EUC-KR/CP949 계열을 감지해 올바르게 디코딩.
function detectCharset(buffer, contentTypeHeader) {
  const fromHeader = contentTypeHeader && /charset=([a-zA-Z0-9_-]+)/i.exec(contentTypeHeader);
  if (fromHeader) return normalizeCharset(fromHeader[1]);
  const head = buffer.slice(0, 4096).toString('latin1');
  const fromMeta = /<meta[^>]+charset\s*=\s*["']?([a-zA-Z0-9_-]+)/i.exec(head);
  if (fromMeta) return normalizeCharset(fromMeta[1]);
  return 'utf-8';
}
function normalizeCharset(cs) {
  const c = String(cs).toLowerCase();
  if (/euc-?kr|ks_c_5601|ksc5601|cp949|uhc|x-windows-949/.test(c)) return 'euc-kr';
  if (/utf-?8/.test(c)) return 'utf-8';
  return c;
}
// U+FFFD(치환문자) 개수/비율 — charset 선언이 없거나 틀렸는데도 EUC-KR 바이트를 UTF-8로
// 디코딩한 경우를 잡아낸다(요구사항 2). 선언 기반 감지로 못 잡는 케이스의 보강 폴백.
function replacementStats(s) {
  if (!s) return { count: 0, ratio: 0 };
  const count = (s.match(/�/g) || []).length;
  return { count, ratio: count / Math.max(1, s.length) };
}
function decodeBody(buffer, contentTypeHeader) {
  const charset = detectCharset(buffer, contentTypeHeader);
  let text;
  try {
    text = new TextDecoder(charset, { fatal: false }).decode(buffer);
  } catch (e) {
    text = buffer.toString('utf8'); // 미지원 인코딩 — utf8 fallback
  }
  if (charset !== 'euc-kr') {
    const stats = replacementStats(text);
    if (stats.count >= 3 && stats.ratio > 0.01) {
      try {
        const retryText = new TextDecoder('euc-kr', { fatal: false }).decode(buffer);
        if (replacementStats(retryText).ratio < stats.ratio) return retryText;
      } catch (e) { /* euc-kr 미지원 환경 — 원래 text 유지 */ }
    }
  }
  return text;
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// ── 재시도 사다리 (요구사항 4) ───────────────────────────────────────────────
// 1차 fetch가 403/503이면 (Chrome UA+Accept-Language ko / 리다이렉트 추적 5회 /
// rejectUnauthorized:false — 이 세 설정은 httpGet 기본값에 이미 포함) 짧은 대기 후
// 1회만 재시도한다(일시적 차단·부하 완화 목적). 그 외 실패(404 등)는 기존 R124
// 최소-헤더 재시도 패턴을 그대로 유지한다. 도메인당/URL당 재시도는 항상 최대 1회.
// R124 실사고(staffingbridge.co.kr): 풀 헤더 GET은 404, 최소 헤더 GET은 200.
async function fetchAndExtractText(urlStr) {
  let r = await httpGet(urlStr);
  if (!r.ok) {
    if (r.reason === 'http-403' || r.reason === 'http-503') {
      await sleep(500);
      const retry = await httpGet(urlStr, { minimalHeaders: false, redirectsLeft: 5 });
      if (retry.ok) r = retry;
      else return { ok: false, reason: retry.reason || r.reason || 'unknown' };
    } else {
      const m = await httpGet(urlStr, { minimalHeaders: true });
      if (m.ok) r = m;
      else return { ok: false, reason: r.reason || 'unknown' };
    }
  }
  if (isPdfResponse(r.contentType, urlStr)) return { ok: false, reason: 'pdf' };
  const decoded = decodeBody(r.bodyBuffer, r.contentType);
  let text = htmlToText(decoded);
  text = toHalfWidthDigitsAndComma(text);
  if (text.length < MIN_USABLE_TEXT_LEN) return { ok: false, reason: 'js-shell' }; // 판정 보류
  return { ok: true, text };
}

// ── 동시성 제한 실행 (≤5) ────────────────────────────────────────────────────
async function runPool(items, limit, worker) {
  let idx = 0;
  async function next() {
    while (idx < items.length) {
      const cur = idx++;
      await worker(items[cur], cur);
    }
  }
  const n = Math.max(1, Math.min(limit, items.length));
  await Promise.all(Array.from({ length: n }, () => next()));
}

// ── 5. 핵심 분석 (네트워크 주입형 — fixture 테스트에서 재사용) ─────────────────
//
// data: /api/job/{slug}/edit-data 응답의 `.data` 객체 (_proseRaw, _sources 포함)
// fetchTextFn: async (url) => string|null  — 실전에서는 fetchAndExtractText, 테스트에서는 stub
async function analyzeProseData(data, fetchTextFn) {
  const proseRaw = (data && data._proseRaw) || {};
  const sources = (data && data._sources) || {};

  function getBody(field) {
    if (proseRaw && Object.prototype.hasOwnProperty.call(proseRaw, field)) {
      return normalizeProseBody(proseRaw[field]);
    }
    return '';
  }

  const records = [];
  const neededUrls = new Set();

  for (const field of PROSE_BODY_FIELDS) {
    const body = getBody(field);
    if (!body) continue;
    const sourcesArr = Array.isArray(sources[field]) ? sources[field] : [];
    const sentences = splitSentences(body);
    for (const sentence of sentences) {
      const claims = extractClaims(sentence);
      if (claims.length === 0) continue;
      const footnoteIdxs = extractFootnotes(sentence);
      const mappedSources = footnoteIdxs
        .map((i) => sourcesArr[i - 1])
        .filter((s) => s && typeof s === 'object' && s.url)
        .map((s) => ({ url: s.url, text: s.text || '' }));

      const compoundGroups = findCompoundGroups(claims, sentence);
      const compoundIdxSet = new Set(compoundGroups.flat());

      for (const [i1, i2] of compoundGroups) {
        records.push({
          field, sentence, isCompound: true,
          claims: [claims[i1], claims[i2]],
          footnoteIdxs, sources: mappedSources,
        });
      }
      claims.forEach((c, i) => {
        if (compoundIdxSet.has(i)) return;
        records.push({ field, sentence, isCompound: false, claims: [c], footnoteIdxs, sources: mappedSources });
      });

      if (footnoteIdxs.length > 0) {
        for (const s of mappedSources) neededUrls.add(s.url);
      }
    }
  }

  // fetchTextFn은 { ok, text, reason } 형태를 반환한다(v2 — UNFETCHABLE 사유 코드 전파).
  const cache = new Map();
  await runPool([...neededUrls], 5, async (u) => {
    cache.set(u, await fetchTextFn(u));
  });

  const counts = { claims: 0, FOUND: 0, UNIT_MISMATCH: 0, NOT_FOUND: 0, UNFETCHABLE: 0, NO_FOOTNOTE: 0 };
  const unfetchableReasons = {};
  const details = [];

  for (const rec of records) {
    if (rec.footnoteIdxs.length === 0 || rec.sources.length === 0) {
      counts.claims += rec.claims.length;
      counts.NO_FOOTNOTE += rec.claims.length;
      continue;
    }

    if (rec.isCompound) {
      counts.claims += 2;
      const fetchedAll = rec.sources.map((s) => ({ url: s.url, r: cache.get(s.url) }));
      const okFetched = fetchedAll.filter((f) => f.r && f.r.ok);
      let verdict = 'UNFETCHABLE';
      let note = okFetched.length === 0 ? 'fetchFailed' : 'compoundAmbiguous';
      let usedUrl = rec.sources[0].url;
      const combined = combineMagnitudeValue(rec.claims[0], rec.claims[1]);
      const combinedVariants = combined != null
        ? [String(combined), String(combined).replace(/\B(?=(\d{3})+(?!\d))/g, ',')]
        : [];
      const n1 = digitsOnly(rec.claims[0].numbers[0]);
      const n2 = digitsOnly(rec.claims[1].numbers[0]);
      for (const f of okFetched) {
        if (combinedVariants.some((v) => findNumberWindows(v, f.r.text).length > 0)) {
          verdict = 'FOUND'; note = 'compound-combined'; usedUrl = f.url;
          break;
        }
        if (findNumberWindows(n1, f.r.text).length > 0 && findNumberWindows(n2, f.r.text).length > 0) {
          verdict = 'FOUND'; note = 'compound-lenient'; usedUrl = f.url;
          break;
        }
      }
      counts[verdict] += 2;
      if (note === 'compoundAmbiguous' || note === 'fetchFailed') {
        details.push({
          level: 'INFO', field: rec.field, sentence: rec.sentence.slice(0, 80),
          claim: rec.claims.map((c) => c.raw).join(' + '), url: usedUrl, note,
        });
      }
      continue;
    }

    const claim = rec.claims[0];
    counts.claims += 1;
    const localVerdicts = [];
    for (const src of rec.sources) {
      const fetched = cache.get(src.url);
      if (!fetched || !fetched.ok) {
        localVerdicts.push({ v: 'UNFETCHABLE', url: src.url, reason: (fetched && fetched.reason) || 'unknown' });
        continue;
      }
      const text = fetched.text;
      let v = matchClaim(claim, text);
      if (v !== 'FOUND' && isYearException(claim, src)) v = 'FOUND';
      // 연도 축약('26 등)·법령 날짜 표기차 정규화 — 범위(claim.isRange) 주장은 대상 제외.
      if (v !== 'FOUND' && !claim.isRange && claim.unit === '년' && yearAbbrevMatch(claim.numbers[0], text)) v = 'FOUND';
      if (v !== 'FOUND' && !claim.isRange && dateContextMatch(claim, rec.sentence, text)) v = 'FOUND';
      localVerdicts.push({ v, url: src.url });
    }
    localVerdicts.sort((a, b) => VERDICT_RANK[a.v] - VERDICT_RANK[b.v]);
    const best = localVerdicts[0];
    counts[best.v] += 1;
    if (best.v === 'UNFETCHABLE') {
      unfetchableReasons[best.reason] = (unfetchableReasons[best.reason] || 0) + 1;
    }
    if (best.v === 'NOT_FOUND' || best.v === 'UNIT_MISMATCH' || best.v === 'UNFETCHABLE') {
      details.push({
        level: best.v, field: rec.field, sentence: rec.sentence.slice(0, 80),
        claim: claim.raw, url: best.url, reason: best.reason,
      });
    }
  }

  return { counts, details, unfetchableReasons };
}

// ── 6. CLI ───────────────────────────────────────────────────────────────────

function loadCycleSlugs(cycleNum) {
  if (!fs.existsSync(CYCLE_LIST_FILE)) return [];
  const lines = fs.readFileSync(CYCLE_LIST_FILE, 'utf8').split('\n').filter(Boolean);
  const target = `R${cycleNum}`;
  const slugs = [];
  for (const line of lines) {
    let obj;
    try { obj = JSON.parse(line); } catch { continue; }
    if (obj.cycle === target && Array.isArray(obj.jobs)) {
      for (const j of obj.jobs) if (j && j.slug) slugs.push(j.slug);
    }
  }
  return slugs;
}

async function fetchJobData(slug) {
  const url = `https://careerwiki.org/api/job/${encodeURIComponent(slug)}/edit-data`;
  let resp;
  try {
    const headers = { 'Cache-Control': 'no-cache' };
    if (ADMIN_SECRET) headers['X-Admin-Secret'] = ADMIN_SECRET;
    resp = await fetch(url, { headers });
  } catch (e) {
    return { error: `fetch-fail: ${e.message}` };
  }
  if (resp.status !== 200) return { error: `HTTP ${resp.status}` };
  let j;
  try { j = await resp.json(); } catch (e) { return { error: `json-parse-fail: ${e.message}` }; }
  if (!j.success) return { error: j.error || 'API failure' };
  return { data: j.data };
}

async function processJob(slug) {
  const { data, error } = await fetchJobData(slug);
  if (error) return { slug, error };
  const { counts, details, unfetchableReasons } = await analyzeProseData(data, fetchAndExtractText);
  return { slug, counts, details, unfetchableReasons };
}

function formatReasons(reasons) {
  const keys = Object.keys(reasons || {});
  if (keys.length === 0) return '';
  return ` (${keys.map((k) => `${k}:${reasons[k]}`).join(', ')})`;
}

function printJobResult(r) {
  if (r.error) {
    console.log(`${r.slug} | ERROR: ${r.error}`);
    return;
  }
  const c = r.counts;
  console.log(
    `${r.slug} | 수치 ${c.claims}건 | FOUND ${c.FOUND} | UNIT_MISMATCH ${c.UNIT_MISMATCH} | ` +
    `NOT_FOUND ${c.NOT_FOUND} | UNFETCHABLE ${c.UNFETCHABLE}${formatReasons(r.unfetchableReasons)} | NO_FOOTNOTE ${c.NO_FOOTNOTE}`
  );
  for (const d of r.details) {
    if (d.level === 'INFO') {
      console.log(`  [INFO][${d.note}] field=${d.field} "${d.sentence}" claim="${d.claim}" source=${d.url || '-'}`);
    } else if (d.level === 'UNFETCHABLE') {
      console.log(`  [UNFETCHABLE][${d.reason}] field=${d.field} "${d.sentence}" claim="${d.claim}" source=${d.url || '-'}`);
    } else {
      console.log(`  [${d.level}] field=${d.field} "${d.sentence}" claim="${d.claim}" source=${d.url || '-'}`);
    }
  }
}

async function main() {
  const argv = process.argv.slice(2);
  const strict = argv.includes('--strict');
  const cycleArg = argv.find((a) => a.startsWith('--cycle='));
  let slugs = argv.filter((a) => !a.startsWith('--'));

  if (cycleArg) {
    const n = cycleArg.split('=')[1];
    slugs = loadCycleSlugs(n);
    if (slugs.length === 0) {
      console.error(`cycle R${n} 명단을 찾지 못함 (${CYCLE_LIST_FILE})`);
      process.exit(1);
    }
  }

  if (slugs.length === 0) {
    console.error('사용법: node audit-numeric-provenance.cjs <slug1> [slug2 ...] | --cycle=N [--strict]');
    process.exit(1);
  }

  const totals = { claims: 0, FOUND: 0, UNIT_MISMATCH: 0, NOT_FOUND: 0, UNFETCHABLE: 0, NO_FOOTNOTE: 0 };
  const totalReasons = {};
  const results = [];

  for (const slug of slugs) {
    const r = await processJob(slug);
    printJobResult(r);
    results.push(r);
    if (!r.error) {
      for (const k of Object.keys(totals)) totals[k] += r.counts[k];
      for (const [reason, n] of Object.entries(r.unfetchableReasons || {})) {
        totalReasons[reason] = (totalReasons[reason] || 0) + n;
      }
    }
  }

  const errored = results.filter((r) => r.error).length;
  console.log('---');
  console.log(
    `Summary | 직업 ${results.length}건(에러 ${errored}) | 수치 ${totals.claims}건 | FOUND ${totals.FOUND} | ` +
    `UNIT_MISMATCH ${totals.UNIT_MISMATCH} | NOT_FOUND ${totals.NOT_FOUND} | UNFETCHABLE ${totals.UNFETCHABLE}${formatReasons(totalReasons)} | ` +
    `NO_FOOTNOTE ${totals.NO_FOOTNOTE}`
  );

  if (strict && totals.NOT_FOUND > 0) process.exit(1);
  process.exit(0);
}

module.exports = {
  splitSentences,
  extractClaims,
  extractFootnotes,
  findCompoundGroups,
  combineMagnitudeValue,
  matchClaim,
  matchSingleNumber,
  findNumberWindows,
  digitsOnly,
  isYearException,
  yearAbbrevMatch,
  extractDateContexts,
  dateContextMatch,
  toHalfWidthDigitsAndComma,
  isPdfResponse,
  htmlToText,
  analyzeProseData,
  VERDICT_RANK,
};

if (require.main === module) {
  main().catch((e) => { console.error(e); process.exit(1); });
}
