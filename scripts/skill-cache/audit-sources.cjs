#!/usr/bin/env node
// scripts/skill-cache/audit-sources.cjs
// _sources 4가지 사고 패턴 정기 sweep + 알림.
//
// 사용:
//   node scripts/skill-cache/audit-sources.cjs                  (전체 sweep + summary)
//   node scripts/skill-cache/audit-sources.cjs --json           (JSON 출력)
//   node scripts/skill-cache/audit-sources.cjs --pattern=mojibake  (단일 패턴)

const { spawnSync } = require('child_process');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 100 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

const PATTERNS = {
  sources_null: {
    label: 'sources_NULL_with_marker',
    hint: '본문에 [N] 마커가 있지만 _sources 객체 부재 — enhance subagent가 매핑 작성 skip',
    sql: `SELECT slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
          AND json_extract(user_contributed_json,'$._sources') IS NULL
          AND (json_extract(user_contributed_json,'$.way') LIKE '%[1]%'
               OR json_extract(user_contributed_json,'$.trivia') LIKE '%[1]%'
               OR json_extract(user_contributed_json,'$.detailReady') LIKE '%[1]%')
          ORDER BY slug`,
  },
  raw_url: {
    label: 'raw_URL_in_sources_text',
    hint: '_sources의 text 필드가 raw URL — 기관명 label 부재',
    sql: `SELECT slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
          AND json_extract(user_contributed_json,'$._sources') LIKE '%"text":"http%'
          ORDER BY slug`,
  },
  mojibake: {
    label: 'mojibake_in_user_contributed',
    hint: 'CP949 인코딩 사고로 한글 label 깨짐 (U+FFFD replacement char 등)',
    sql: `SELECT slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
          AND (user_contributed_json LIKE '%�%' OR user_contributed_json LIKE '%ï¿½%')
          ORDER BY slug`,
  },
  bracket_prefix: {
    label: 'sources_with_bracket_prefix',
    hint: '_sources의 text가 [N] 마커로 시작 — 마커는 본문에만, text는 기관명만',
    sql: `SELECT slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
          AND json_extract(user_contributed_json,'$._sources') LIKE '%"text":"[%]%'
          ORDER BY slug`,
  },
};

console.log('=== audit-sources ===\n');

const result = {};
const targets = args.pattern ? [args.pattern] : Object.keys(PATTERNS);

for (const key of targets) {
  const p = PATTERNS[key];
  if (!p) {
    console.error(`알 수 없는 패턴: ${key}. 가능 패턴: ${Object.keys(PATTERNS).join(', ')}`);
    process.exit(2);
  }
  const rows = d1Query(p.sql);
  result[key] = { count: rows.length, slugs: rows.map(r => r.slug), label: p.label, hint: p.hint };
  if (!args.json) {
    console.log(`[${p.label}]`);
    console.log(`  hint: ${p.hint}`);
    console.log(`  count: ${rows.length}`);
    if (rows.length > 0 && rows.length <= 30) {
      console.log(`  slugs: ${rows.slice(0, 30).map(r => r.slug).join(', ')}`);
    } else if (rows.length > 30) {
      console.log(`  sample: ${rows.slice(0, 10).map(r => r.slug).join(', ')}, ...`);
    }
    console.log();
  }
}

if (args.json) {
  console.log(JSON.stringify({ generated_at: new Date().toISOString(), result }, null, 2));
} else {
  const total = Object.values(result).reduce((s, r) => s + r.count, 0);
  console.log(`총 사고 발견: ${total}건 (중복 가능)`);
  console.log('\n권고:');
  console.log('  bracket_prefix → scripts/skill-cache/clean-source-prefix.cjs --apply (자동 정리)');
  console.log('  mojibake → enhance 풀 사이클 재처리 (Node.js fetch + UTF-8)');
  console.log('  raw_url → enhance 재처리 또는 수동 label 추정');
  console.log('  sources_null → enhance 풀 사이클 재처리 (validate Gate 강화 후)');
}
