#!/usr/bin/env node
// scripts/skill-cache/verify-urls.cjs
// 처리한 직업의 _sources URL 전수 HTTP 검증.
// status 200/redirect/SSL/keyword match 체크.
//
// 사용:
//   node scripts/skill-cache/verify-urls.cjs --slugs=data/processed-slugs.txt --out=data/url-verify-result.json [--concurrency=15]
//   node scripts/skill-cache/verify-urls.cjs --all --out=data/url-verify-result.json
//
// 출력 형식:
//   {
//     verified_at: "...",
//     total_jobs: N, total_urls: M,
//     broken: [{slug, field, arrIdx, url, status, reason}],
//     suspect: [{slug, field, arrIdx, url, status, redirect_to, no_keyword}],
//     clean: K,
//     by_slug: {slug: {total, broken, suspect, clean, urls: [...]}}
//   }

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');
const https = require('https');
const http = require('http');
const { URL } = require('url');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const CONCURRENCY = parseInt(args.concurrency || '12', 10);
const OUT = args.out || 'data/url-verify-result.json';
const TIMEOUT_MS = 12000;

// 직업명에서 검색용 핵심 키워드 추출
function jobKeywords(slug) {
  // hyphen·및 분리 → 핵심 명사
  const cleaned = slug.replace(/-/g, ' ').replace(/및/g, ' ');
  const tokens = cleaned.split(/\s+/).filter(t => t.length >= 2);
  // 일반 stopword 제거
  const stop = new Set(['전문가', '관리자', '연구원', '기술자', '개발자', '담당자', '서비스']);
  return tokens.filter(t => !stop.has(t));
}

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const r = spawnSync(`npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  const out = (r.stdout || '').trim();
  const start = out.indexOf('[');
  if (start < 0) return [];
  let depth = 0, end = -1, inStr = false, esc = false;
  for (let i = start; i < out.length; i++) {
    const c = out[i];
    if (esc) { esc = false; continue; }
    if (c === '\\') { esc = true; continue; }
    if (c === '"') { inStr = !inStr; continue; }
    if (inStr) continue;
    if (c === '[') depth++;
    else if (c === ']') { depth--; if (depth === 0) { end = i + 1; break; } }
  }
  if (end < 0) end = out.length;
  return JSON.parse(out.slice(start, end))[0]?.results || [];
}

// fetch URL with redirect tracking + body sample (~6KB)
function fetchUrl(urlStr, redirectsLeft = 5, originalUrl = null) {
  return new Promise((resolve) => {
    let parsed;
    try { parsed = new URL(urlStr); } catch (e) {
      return resolve({ ok: false, reason: 'invalid-url', detail: e.message });
    }
    const lib = parsed.protocol === 'https:' ? https : http;
    const opts = {
      method: 'GET',
      hostname: parsed.hostname,
      port: parsed.port || (parsed.protocol === 'https:' ? 443 : 80),
      path: parsed.pathname + parsed.search,
      headers: {
        'User-Agent': 'Mozilla/5.0 (compatible; CareerwikiURLVerifier/1.0)',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'ko,en;q=0.9',
      },
      timeout: TIMEOUT_MS,
    };
    const req = lib.request(opts, (res) => {
      const status = res.statusCode;
      // redirect handling
      if ([301, 302, 303, 307, 308].includes(status) && res.headers.location && redirectsLeft > 0) {
        let nextUrl;
        try { nextUrl = new URL(res.headers.location, urlStr).href; } catch (e) {
          return resolve({ ok: false, status, reason: 'bad-redirect', detail: e.message });
        }
        res.resume();
        return fetchUrl(nextUrl, redirectsLeft - 1, originalUrl || urlStr).then(r => {
          resolve({ ...r, redirect_chain: [...(r.redirect_chain || []), urlStr] });
        });
      }
      // capture body sample
      let body = '';
      let total = 0;
      const MAX = 6 * 1024;
      res.on('data', (chunk) => {
        if (total < MAX) {
          body += chunk.toString('utf8');
          total += chunk.length;
        }
      });
      res.on('end', () => {
        resolve({
          ok: status >= 200 && status < 400,
          status,
          final_url: urlStr,
          original_url: originalUrl || urlStr,
          body: body.slice(0, MAX),
          host: parsed.hostname,
        });
      });
      res.on('error', (e) => resolve({ ok: false, status, reason: 'response-error', detail: e.message }));
    });
    req.on('timeout', () => { req.destroy(); resolve({ ok: false, reason: 'timeout' }); });
    req.on('error', (e) => {
      const msg = e.message || '';
      let reason = 'fetch-error';
      if (msg.includes('CERT')) reason = 'ssl-error';
      else if (msg.includes('ENOTFOUND')) reason = 'dns-error';
      else if (msg.includes('ECONNREFUSED')) reason = 'conn-refused';
      else if (msg.includes('ECONNRESET')) reason = 'conn-reset';
      resolve({ ok: false, reason, detail: msg });
    });
    req.end();
  });
}

function checkKeywordMatch(body, keywords) {
  if (!body || !keywords || keywords.length === 0) return true;
  const lc = body.toLowerCase();
  return keywords.some(kw => lc.includes(kw.toLowerCase()));
}

async function processJob(job, sem) {
  const { slug, sources } = job;
  const keywords = jobKeywords(slug);
  const result = { slug, total: 0, broken: 0, suspect: 0, clean: 0, urls: [] };
  const tasks = [];
  for (const [field, arr] of Object.entries(sources)) {
    if (!Array.isArray(arr)) continue;
    arr.forEach((src, arrIdx) => {
      if (!src.url) return;
      result.total++;
      tasks.push(sem(async () => {
        const fetched = await fetchUrl(src.url);
        const entry = { field, arrIdx, url: src.url, text: src.text };
        if (!fetched.ok) {
          entry.status = 'BROKEN';
          entry.http_status = fetched.status || null;
          entry.reason = fetched.reason || `status-${fetched.status}`;
          entry.detail = (fetched.detail || '').slice(0, 120);
          result.broken++;
        } else if (fetched.status >= 400) {
          entry.status = 'BROKEN';
          entry.http_status = fetched.status;
          entry.reason = `http-${fetched.status}`;
          result.broken++;
        } else {
          // check redirect to root or different host
          const finalParsed = new URL(fetched.final_url);
          const origParsed = new URL(src.url);
          let suspect = false;
          let suspectReason = [];
          if (finalParsed.hostname !== origParsed.hostname) {
            suspect = true;
            suspectReason.push(`redirect-host:${finalParsed.hostname}`);
          }
          // root redirect (path '/')
          if (origParsed.pathname.length > 3 && finalParsed.pathname === '/') {
            suspect = true;
            suspectReason.push('redirect-to-root');
          }
          // keyword match
          const kwMatch = checkKeywordMatch(fetched.body, keywords);
          if (!kwMatch && keywords.length > 0) {
            suspect = true;
            suspectReason.push('no-keyword-match');
          }
          if (suspect) {
            entry.status = 'SUSPECT';
            entry.http_status = fetched.status;
            entry.final_url = fetched.final_url;
            entry.reasons = suspectReason;
            result.suspect++;
          } else {
            entry.status = 'CLEAN';
            entry.http_status = fetched.status;
            result.clean++;
          }
        }
        result.urls.push(entry);
      }));
    });
  }
  await Promise.all(tasks);
  return result;
}

// simple semaphore pool
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

async function main() {
  let slugs = [];
  if (args.all) {
    const rows = d1Query(`SELECT slug FROM jobs WHERE is_active=1 ORDER BY slug`);
    slugs = rows.map(r => r.slug);
  } else if (args.slugs) {
    slugs = fs.readFileSync(path.resolve(REPO_ROOT, args.slugs), 'utf8').split('\n').map(s => s.trim()).filter(Boolean);
  } else {
    console.error('Usage: --all OR --slugs={file}');
    process.exit(2);
  }

  console.log(`[verify-urls] target jobs: ${slugs.length}`);

  // batch fetch UCJ for all slugs
  const slugIn = slugs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
  const rows = d1Query(`SELECT slug, user_contributed_json FROM jobs WHERE slug IN (${slugIn})`);
  console.log(`[verify-urls] fetched UCJ: ${rows.length} rows`);

  const jobs = [];
  for (const r of rows) {
    try {
      const ucj = JSON.parse(r.user_contributed_json || '{}');
      jobs.push({ slug: r.slug, sources: ucj._sources || {} });
    } catch (e) { /* skip parse errors */ }
  }

  const sem = semaphore(CONCURRENCY);
  const results = [];
  let processed = 0;
  const summary = { total_urls: 0, broken: 0, suspect: 0, clean: 0 };
  for (const job of jobs) {
    const p = processJob(job, sem).then(r => {
      processed++;
      summary.total_urls += r.total;
      summary.broken += r.broken;
      summary.suspect += r.suspect;
      summary.clean += r.clean;
      if (processed % 5 === 0 || processed === jobs.length) {
        console.error(`  [${processed}/${jobs.length}] urls=${summary.total_urls} broken=${summary.broken} suspect=${summary.suspect} clean=${summary.clean}`);
      }
      results.push(r);
    });
    results.push(p);
  }
  await Promise.all(results.filter(r => r instanceof Promise));
  // results array now has both promises and values; filter to job results only
  const jobResults = results.filter(r => r && typeof r === 'object' && r.slug);

  // build flat broken/suspect lists
  const broken = [];
  const suspect = [];
  for (const r of jobResults) {
    for (const u of r.urls) {
      if (u.status === 'BROKEN') broken.push({ slug: r.slug, ...u });
      else if (u.status === 'SUSPECT') suspect.push({ slug: r.slug, ...u });
    }
  }

  const output = {
    verified_at: new Date().toISOString(),
    total_jobs: jobResults.length,
    total_urls: summary.total_urls,
    broken_count: broken.length,
    suspect_count: suspect.length,
    clean_count: summary.clean,
    broken,
    suspect,
    by_slug: Object.fromEntries(jobResults.map(r => [r.slug, { total: r.total, broken: r.broken, suspect: r.suspect, clean: r.clean }])),
  };

  fs.writeFileSync(path.resolve(REPO_ROOT, OUT), JSON.stringify(output, null, 2), 'utf8');
  console.log(`\n[verify-urls] DONE — ${OUT}`);
  console.log(`  total: ${summary.total_urls} URLs (${jobResults.length} jobs)`);
  console.log(`  broken: ${broken.length} (${(broken.length/summary.total_urls*100).toFixed(1)}%)`);
  console.log(`  suspect: ${suspect.length} (${(suspect.length/summary.total_urls*100).toFixed(1)}%)`);
  console.log(`  clean: ${summary.clean} (${(summary.clean/summary.total_urls*100).toFixed(1)}%)`);
}

main().catch(e => { console.error(e); process.exit(1); });
