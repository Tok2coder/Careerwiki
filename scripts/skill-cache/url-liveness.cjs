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
        return request(nextUrl, method, redirectsLeft - 1).then(resolve);
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

// 단일 URL 판정. HEAD 먼저, FAIL/모호 시 GET 1회 재시도.
// returns { url, verdict: 'OK'|'FAIL'|'WARN', status?, reason }
async function checkUrl(urlStr) {
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
  return classify(urlStr, r);
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
// returns { dead: [...], unverified: [...], ok: [...], all: [{url,verdict,...}] }
async function checkUrls(urls) {
  const uniq = [...new Set((urls || []).filter(Boolean))];
  const sem = semaphore(CONCURRENCY);
  const all = await Promise.all(uniq.map((u) => sem(() => checkUrl(u))));
  return {
    dead: all.filter((x) => x.verdict === 'FAIL'),
    unverified: all.filter((x) => x.verdict === 'WARN'),
    ok: all.filter((x) => x.verdict === 'OK'),
    all,
  };
}

module.exports = { checkUrl, checkUrls, semaphore, TIMEOUT_MS, CONCURRENCY };
