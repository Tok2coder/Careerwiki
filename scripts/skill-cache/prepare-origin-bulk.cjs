#!/usr/bin/env node
// scripts/skill-cache/prepare-origin-bulk.cjs
// 잔존 originDomain 직업 list + 각 직업의 LLM helper input context 생성.
//
// 사용:
//   node scripts/skill-cache/prepare-origin-bulk.cjs                       (전체 list)
//   node scripts/skill-cache/prepare-origin-bulk.cjs --slug=캐디            (단일 직업 input json)
//   node scripts/skill-cache/prepare-origin-bulk.cjs --out=data/...         (결과 저장)

'use strict';

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

// cycle 1·2·3 + 마취병리/경제학 retry 처리 직업 (52)
const PROCESSED = new Set([
  '수의사보조원','만화가','사서','경제학연구원','리포터',
  '입학사정관','보험계리사','의료코디네이터','수상운송사무원','드라마작가',
  '사회단체활동가','집배원','마취병리과의사','법원공무원','네일아티스트',
  '마케팅전문가','전문의사','방송연출가','사회학연구원','역사학연구원',
  '전화교환원',
  '서예가','직업상담사','번역가','바리스타','영화시나리오작가',
  '재료공학기술자','화학공학기술자','섬유제조기계조작원','방송작가','항공기조종사',
  '자동차공학기술자','성직자','피부관리사','방사선과의사','토목감리기술자',
  '전자공학기술자','유치원-원장-및-원감','외교관','패션모델','교도관',
  '전기가스수도관리자','조사전문가','선박기관사','일반의사','소믈리에',
  '행사기획자','전기공학기술자','기상연구원','섬유공학기술자','토목공학기술자','항공공학기술자',
]);

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

const audit = JSON.parse(fs.readFileSync(path.join(REPO_ROOT, 'data', 'audit-sources-deep.json'), 'utf8'));

// 잔존 154건 = audit에서 originDomain ≥ 1 + 미처리
let pool = audit.jobs.filter(j => j.originDomain.length > 0 && !PROCESSED.has(j.slug));

if (args.slug) {
  pool = pool.filter(j => j.slug === args.slug);
  if (pool.length === 0) {
    console.error(`slug '${args.slug}'은 잔존 풀에 없거나 이미 처리됨`);
    process.exit(2);
  }
}

// 단일 직업 모드 — UCJ fetch + LLM input context 생성
async function buildJobContext(slug) {
  const sql = `SELECT id, slug, user_contributed_json FROM jobs WHERE slug='${slug.replace(/'/g, "''")}'`;
  const rows = d1Query(sql);
  if (rows.length === 0) throw new Error(`slug '${slug}' DB에서 못 찾음`);
  const row = rows[0];
  const ucj = JSON.parse(row.user_contributed_json);
  const sources = ucj._sources || {};
  const auditEntry = pool.find(j => j.slug === slug);

  // 본문 fields keyword 추출 (직업 분야 추정용)
  const fields = {};
  for (const f of ['way', 'trivia', 'overviewProspect.main', 'detailWlb.wlbDetail', 'detailWlb.socialDetail']) {
    const v = f.includes('.') ? f.split('.').reduce((o, k) => o?.[k], ucj) : ucj[f];
    if (typeof v === 'string') fields[f] = v.slice(0, 500); // 본문 첫 500자
  }

  // 외부 host 분포 (현재 _sources에 어떤 외부 출처가 있는지 — 같은 직업의 외부 출처 패턴 학습용)
  const externalHosts = new Set();
  for (const arr of Object.values(sources)) {
    if (!Array.isArray(arr)) continue;
    for (const src of arr) {
      if (!src || typeof src !== 'object' || !src.url) continue;
      try {
        const host = new URL(src.url).host.toLowerCase();
        if (!host.includes('career.go.kr') && !host.includes('work.go.kr') &&
            !host.includes('work24.go.kr') && !host.includes('wagework.go.kr') &&
            !host.includes('job.go.kr') && !host.endsWith('.careerwiki.org') &&
            !host.endsWith('.careerwiki.kr')) {
          externalHosts.add(host);
        }
      } catch {}
    }
  }

  // origin URL 위치 + 현재 등록 정보
  const originReplacements = [];
  for (const o of auditEntry.originDomain) {
    const arr = sources[o.field];
    if (!Array.isArray(arr)) continue;
    // arr 내 url 매칭하는 idx 찾기
    for (let i = 0; i < arr.length; i++) {
      if (arr[i] && arr[i].url === o.url) {
        originReplacements.push({
          field: o.field,
          arrIdx: i,                // _sources[field][arrIdx]가 origin
          localMarker: i + 1,       // 본문에서 [N] 마커 (field-local)
          originUrl: o.url,
          originHost: o.host,
          currentText: arr[i].text || '',
          currentId: arr[i].id || (i + 1),
        });
      }
    }
  }

  return {
    slug: row.slug,
    id: row.id,
    fields,
    externalHosts: [...externalHosts],
    originReplacements,
    summary: `${slug} (id=${row.id}) — origin URL ${originReplacements.length}건 교체 필요`,
  };
}

(async () => {
  if (args.slug) {
    // 단일 직업 — context json 출력
    const ctx = await buildJobContext(args.slug);
    if (args.out) {
      fs.writeFileSync(path.resolve(REPO_ROOT, args.out), JSON.stringify(ctx, null, 2), 'utf8');
      console.error(`saved: ${args.out}`);
    } else {
      console.log(JSON.stringify(ctx, null, 2));
    }
    return;
  }

  // 전체 list — summary 출력
  console.log('\n=== 잔존 originDomain 직업 list (52 처리 제외) ===\n');
  console.log(`total: ${pool.length}`);
  console.log('');

  // host 분포
  const hostDist = {};
  for (const j of pool) {
    for (const o of j.originDomain) {
      hostDist[o.host] = (hostDist[o.host] || 0) + 1;
    }
  }
  console.log('host 분포 (origin URL 발생 건수):');
  for (const [h, c] of Object.entries(hostDist).sort((a, b) => b[1] - a[1])) {
    console.log(`  ${h.padEnd(35)} ${c}`);
  }
  console.log('');

  // origin count별 distribution
  const countDist = {};
  for (const j of pool) {
    const c = j.originDomain.length;
    countDist[c] = (countDist[c] || 0) + 1;
  }
  console.log('직업당 origin URL 수 분포:');
  for (const c of Object.keys(countDist).sort((a, b) => parseInt(b) - parseInt(a))) {
    console.log(`  ${c}건: ${countDist[c]} 직업`);
  }
  console.log('');

  // top 10 + bottom 10
  pool.sort((a, b) => b.originDomain.length - a.originDomain.length);
  console.log('Top 10 (origin URL 수 많음):');
  for (const j of pool.slice(0, 10)) {
    const hosts = [...new Set(j.originDomain.map(o => o.host))];
    console.log(`  ${j.slug.padEnd(20)} origin=${j.originDomain.length} hosts=${hosts.join(',')}`);
  }
  console.log('');
  console.log('Bottom 10 (origin URL 1-2건):');
  for (const j of pool.slice(-10)) {
    const hosts = [...new Set(j.originDomain.map(o => o.host))];
    console.log(`  ${j.slug.padEnd(20)} origin=${j.originDomain.length} hosts=${hosts.join(',')}`);
  }

  if (args.out) {
    const list = pool.map(j => ({
      slug: j.slug,
      originCount: j.originDomain.length,
      originHosts: [...new Set(j.originDomain.map(o => o.host))],
      details: j.originDomain,
      totalUrls: j.totalUrls,
      externalHostCount: j.externalHostCount,
    }));
    fs.writeFileSync(path.resolve(REPO_ROOT, args.out), JSON.stringify({ generated_at: new Date().toISOString(), total: list.length, host_dist: hostDist, jobs: list }, null, 2), 'utf8');
    console.log(`\nsaved: ${args.out}`);
  }
})().catch(e => { console.error(e); process.exit(1); });
