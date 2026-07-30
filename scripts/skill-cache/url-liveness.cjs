#!/usr/bin/env node
// scripts/skill-cache/url-liveness.cjs
// _sources URL 생존 확인 공유 모듈 (R41 사후 신설).
//
// audit-via-api.cjs (URL 생존 게이트) + master-verify-cycle.cjs (cycle 검증)가
// 동일 로직을 import하여 사용 — 복붙 금지, 단일 진리.
//
// 판정 (R41 broken URL 11건 사고 + Windows schannel/anti-bot 거짓양성 이력 기반):
//   404 / 410 / DNS실패(NXDOMAIN/ENOTFOUND)         → FAIL  [urlDead]   (확실한 죽은 URL)
//   000(연결불가) / 403 / timeout / TLS(CERT) 오류  → WARN  [urlUnverified] (거짓양성 가능 — FAIL 승격 금지)
//   200 / 30x                                        → OK
//
// HEAD 먼저 시도, 실패 시 GET 1회 재시도. 동시 5개 제한, timeout 10초, 브라우저 UA.

'use strict';

const https = require('https');
const http = require('http');
const { URL } = require('url');

const TIMEOUT_MS = 10000;
const CONCURRENCY = 5;
const BROWSER_UA =
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36';

// 단일 요청 (HEAD 또는 GET). resolve never rejects.
function request(urlStr, method, redirectsLeft = 5, minimalHeaders = false) {
  return new Promise((resolve) => {
    let parsed;
    try { parsed = new URL(urlStr); } catch (e) {
      return resolve({ kind: 'invalid', detail: e.message });
    }
    if (parsed.protocol !== 'https:' && parsed.protocol !== 'http:') {
      return resolve({ kind: 'invalid', detail: `bad-protocol:${parsed.protocol}` });
    }
    const lib = parsed.protocol === 'https:' ? https : http;
    const opts = {
      method,
      hostname: parsed.hostname,
      port: parsed.port || (parsed.protocol === 'https:' ? 443 : 80),
      path: (parsed.pathname || '/') + parsed.search,
      headers: minimalHeaders
        ? { 'User-Agent': BROWSER_UA, 'Accept': 'text/html,*/*;q=0.8' }
        : {
            'User-Agent': BROWSER_UA,
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'ko,en;q=0.9',
          },
      timeout: TIMEOUT_MS,
    };
    const req = lib.request(opts, (res) => {
      const status = res.statusCode;
      if ([301, 302, 303, 307, 308].includes(status) && res.headers.location && redirectsLeft > 0) {
        let nextUrl;
        try { nextUrl = new URL(res.headers.location, urlStr).href; } catch (e) {
          res.resume();
          return resolve({ kind: 'status', status });
        }
        res.resume();
        return request(nextUrl, method, redirectsLeft - 1, minimalHeaders).then(resolve);
      }
      res.resume(); // drain
      resolve({ kind: 'status', status });
    });
    req.on('timeout', () => { req.destroy(); resolve({ kind: 'timeout' }); });
    req.on('error', (e) => {
      const msg = e.message || '';
      let reason = 'conn'; // 000-류 연결 불가
      if (/ENOTFOUND|EAI_AGAIN/i.test(msg)) reason = 'dns';
      else if (/CERT|SSL|TLS|self-signed|altnames/i.test(msg) || (e.code && /CERT/i.test(e.code))) reason = 'tls';
      resolve({ kind: 'error', reason, detail: msg.slice(0, 120) });
    });
    req.end();
  });
}

// R126~R131 6-cycle 연속 urlUnverified 거짓양성 대응 (2026-07): TLS 체인 문제·anti-bot·
// 리다이렉트 미추적이 대부분이고 실제로는 Chrome UA 사람 브라우저로는 200인 경우가 다수였다.
// urlUnverified(WARN) 선언 직전, 재시도 사다리를 순차로 태워 살아있으면 OK로 승격한다.
// dead(FAIL: 404/410/dns) 판정 로직은 건드리지 않는다 — 사다리는 WARN 케이스에만 적용.
const CHROME_UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36';
const RETRY_OK_MIN_BYTES = 3000;

// HEAD/GET + 리다이렉트 추적(최대 5회) + rejectUnauthorized 옵션을 지원하며, 본문 길이를 센다.
function requestWithBody(urlStr, method, opts = {}) {
  const { redirectsLeft = 5, headers, rejectUnauthorized = true } = opts;
  return new Promise((resolve) => {
    let parsed;
    try { parsed = new URL(urlStr); } catch (e) {
      return resolve({ kind: 'invalid', detail: e.message });
    }
    if (parsed.protocol !== 'https:' && parsed.protocol !== 'http:') {
      return resolve({ kind: 'invalid', detail: `bad-protocol:${parsed.protocol}` });
    }
    const lib = parsed.protocol === 'https:' ? https : http;
    const reqOpts = {
      method,
      hostname: parsed.hostname,
      port: parsed.port || (parsed.protocol === 'https:' ? 443 : 80),
      path: (parsed.pathname || '/') + parsed.search,
      headers,
      timeout: TIMEOUT_MS,
    };
    if (parsed.protocol === 'https:') reqOpts.rejectUnauthorized = rejectUnauthorized;
    const req = lib.request(reqOpts, (res) => {
      const status = res.statusCode;
      if ([301, 302, 303, 307, 308].includes(status) && res.headers.location && redirectsLeft > 0) {
        let nextUrl;
        try { nextUrl = new URL(res.headers.location, urlStr).href; } catch (e) {
          res.resume();
          return resolve({ kind: 'status', status, bodyLen: 0 });
        }
        res.resume();
        return requestWithBody(nextUrl, method, { redirectsLeft: redirectsLeft - 1, headers, rejectUnauthorized }).then(resolve);
      }
      let len = 0;
      res.on('data', (chunk) => { len += chunk.length; });
      res.on('end', () => resolve({ kind: 'status', status, bodyLen: len }));
      res.on('error', () => resolve({ kind: 'status', status, bodyLen: len }));
    });
    req.on('timeout', () => { req.destroy(); resolve({ kind: 'timeout' }); });
    req.on('error', (e) => {
      const msg = e.message || '';
      let reason = 'conn';
      if (/ENOTFOUND|EAI_AGAIN/i.test(msg)) reason = 'dns';
      else if (/CERT|SSL|TLS|self-signed|altnames/i.test(msg) || (e.code && /CERT/i.test(e.code))) reason = 'tls';
      resolve({ kind: 'error', reason, detail: msg.slice(0, 120) });
    });
    req.end();
  });
}

function isLiveResult(r) {
  return r.kind === 'status' && r.status >= 200 && r.status < 400 && r.bodyLen >= RETRY_OK_MIN_BYTES;
}

// 재시도 사다리: ① Chrome UA + ko-KR ② 리다이렉트 추적(사다리 전 단계에 내장) ③ TLS 완화 ④ http/https 스킴 전환.
// 살아있으면 { ok: true, via } / 끝까지 죽어있으면 { ok: false }.
async function retryLadder(urlStr) {
  const headers = {
    'User-Agent': CHROME_UA,
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'ko-KR,ko;q=0.9,en;q=0.8',
  };
  // ① Chrome UA + ko-KR (리다이렉트 추적 포함, TLS 검증 정상)
  let r = await requestWithBody(urlStr, 'GET', { headers });
  if (isLiveResult(r)) return { ok: true, via: 'chrome-ua' };

  let parsed;
  try { parsed = new URL(urlStr); } catch (e) { parsed = null; }

  // ③ TLS 체인 완화 (https만 의미 있음)
  if (parsed && parsed.protocol === 'https:') {
    r = await requestWithBody(urlStr, 'GET', { headers, rejectUnauthorized: false });
    if (isLiveResult(r)) return { ok: true, via: 'tls-relaxed' };
  }

  // ④ http ↔ https 스킴 전환 1회
  if (parsed) {
    const altScheme = parsed.protocol === 'https:' ? 'http:' : 'https:';
    const altUrl = altScheme + urlStr.slice(parsed.protocol.length);
    r = await requestWithBody(altUrl, 'GET', { headers, rejectUnauthorized: false });
    if (isLiveResult(r)) return { ok: true, via: `scheme-switch(${altScheme.replace(':', '')})` };
  }

  return { ok: false };
}

// 단일 URL 판정. HEAD 먼저, FAIL/모호 시 GET 1회 재시도.
// domainState: checkUrls가 배치 전체에서 공유하는 Map(도메인 → {count503, limited}) — 레이트리밋 묶음 판정용.
// returns { url, verdict: 'OK'|'FAIL'|'WARN', status?, reason }
async function checkUrl(urlStr, domainState) {
  if (!urlStr || typeof urlStr !== 'string') {
    return { url: urlStr, verdict: 'WARN', reason: 'empty-url' };
  }
  // 1차: HEAD
  let r = await request(urlStr, 'HEAD');
  // HEAD가 200/30x 아니면 GET 1회 재시도 (HEAD 미지원 서버 다수)
  const headOk = r.kind === 'status' && r.status >= 200 && r.status < 400;
  if (!headOk) {
    const g = await request(urlStr, 'GET');
    // GET 결과를 우선 채택 (HEAD 거부 서버 흔함)
    r = g;
  }
  // R124 실사고: staffingbridge.co.kr/feeds/10 이 풀 헤더(Accept-Language 등) GET에는 404 shell(4.7KB),
  // 최소 헤더 GET에는 200 실콘텐츠(42KB)를 반환 → urlDead FAIL 오탐.
  // dead 선언 직전에만 최소 헤더로 1회 재확인 (통과분엔 영향 없음, 진짜 dead는 그대로 404).
  if (r.kind === 'status' && (r.status === 404 || r.status === 410)) {
    const m = await request(urlStr, 'GET', 5, true);
    if (m.kind === 'status' && m.status >= 200 && m.status < 400) r = m;
  }
  const c = classify(urlStr, r);
  if (c.verdict !== 'WARN') return c; // dead(FAIL)/OK는 그대로 — 사다리는 WARN(urlUnverified) 전용

  // 레이트리밋 도메인 묶음 처리: 같은 도메인 503이 3회 이상 누적되면 이후 그 도메인은
  // 개별 재시도 사다리를 생략하고 rate-limited(도메인)로 묶어 표기 (무익한 재시도 시간 낭비 방지).
  let domain = null;
  try { domain = new URL(urlStr).hostname; } catch (e) { /* invalid는 위에서 걸러짐 */ }
  if (domain && domainState) {
    let st = domainState.get(domain);
    if (!st) { st = { count503: 0, limited: false }; domainState.set(domain, st); }
    if (r.kind === 'status' && r.status === 503) st.count503++;
    if (st.limited || st.count503 >= 3) {
      st.limited = true;
      return { url: urlStr, verdict: 'WARN', status: r.status, reason: `rate-limited(${domain})` };
    }
  }

  // 재시도 사다리
  const retry = await retryLadder(urlStr);
  if (retry.ok) {
    return { url: urlStr, verdict: 'OK', reason: `retry-ok(${retry.via})` };
  }
  return c;
}

function classify(urlStr, r) {
  if (r.kind === 'invalid') {
    return { url: urlStr, verdict: 'FAIL', reason: `invalid(${r.detail || ''})` };
  }
  if (r.kind === 'status') {
    if (r.status >= 200 && r.status < 400) return { url: urlStr, verdict: 'OK', status: r.status };
    if (r.status === 404 || r.status === 410) {
      return { url: urlStr, verdict: 'FAIL', status: r.status, reason: `http-${r.status}` };
    }
    if (r.status === 403) {
      return { url: urlStr, verdict: 'WARN', status: r.status, reason: 'http-403(anti-bot 가능)' };
    }
    // 기타 4xx/5xx — 거짓양성 가능 (일시 5xx, 401 등) → WARN
    return { url: urlStr, verdict: 'WARN', status: r.status, reason: `http-${r.status}` };
  }
  if (r.kind === 'error') {
    if (r.reason === 'dns') {
      return { url: urlStr, verdict: 'FAIL', reason: `dns(NXDOMAIN)` };
    }
    // conn(000) / tls → WARN (Windows schannel 거짓양성)
    return { url: urlStr, verdict: 'WARN', reason: r.reason === 'tls' ? 'tls' : 'conn(000)' };
  }
  if (r.kind === 'timeout') {
    return { url: urlStr, verdict: 'WARN', reason: 'timeout' };
  }
  return { url: urlStr, verdict: 'WARN', reason: 'unknown' };
}

// 간단 semaphore pool
function semaphore(n) {
  const queue = [];
  let active = 0;
  const next = () => {
    while (active < n && queue.length > 0) {
      const { fn, resolve, reject } = queue.shift();
      active++;
      fn().then(resolve, reject).finally(() => { active--; next(); });
    }
  };
  return (fn) => new Promise((resolve, reject) => { queue.push({ fn, resolve, reject }); next(); });
}

// URL 배열 동시 검사 (중복 제거 후).
// sharedDomainState: 여러 checkUrls() 호출(예: cycle 내 여러 직업 순회) 사이에 도메인별 503
//   누적 카운트를 이어가고 싶으면 호출자가 Map()을 만들어 넘긴다. 생략 시 이번 호출 범위로 한정.
// returns { dead: [...], unverified: [...], ok: [...], all: [{url,verdict,...}] }
async function checkUrls(urls, sharedDomainState) {
  const uniq = [...new Set((urls || []).filter(Boolean))];
  const sem = semaphore(CONCURRENCY);
  const domainState = sharedDomainState || new Map();
  const all = await Promise.all(uniq.map((u) => sem(() => checkUrl(u, domainState))));
  return {
    dead: all.filter((x) => x.verdict === 'FAIL'),
    unverified: all.filter((x) => x.verdict === 'WARN'),
    ok: all.filter((x) => x.verdict === 'OK'),
    all,
  };
}

module.exports = { checkUrl, checkUrls, semaphore, TIMEOUT_MS, CONCURRENCY };
