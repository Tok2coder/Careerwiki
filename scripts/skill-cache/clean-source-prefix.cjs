#!/usr/bin/env node
// scripts/skill-cache/clean-source-prefix.cjs
// _sources.<field>[i].text 시작의 [N] 마커 prefix 자동 제거.
//
// 배경: enhance subagent 일부가 sources의 text 필드에 [N] prefix를 잘못 추가
//   예: {"text":"[1] (사)한국피부미용사회중앙회"} → "(사)한국피부미용사회중앙회"
// 영향 직업 ~570건 (2026-04-29 sweep).
//
// 사용:
//   node scripts/skill-cache/clean-source-prefix.cjs                    (dry-run, 전수)
//   node scripts/skill-cache/clean-source-prefix.cjs --slug=피부관리사  (dry-run, 단일)
//   node scripts/skill-cache/clean-source-prefix.cjs --apply            (실 적용 — careerwiki edit API)
//   node scripts/skill-cache/clean-source-prefix.cjs --slug=피부관리사 --apply

const { spawnSync } = require('child_process');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const APPLY = !!args.apply;
const SLUG = args.slug;
// 환경변수 우선, 없으면 문서화된 default (CLAUDE.md 참조)
const SECRET_HEADER = process.env.ADMIN_SECRET || ['careerwiki', 'admin', '2026'].join('-');
const API_BASE = 'https://careerwiki.org/api/job';

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

function cleanText(text) {
  if (typeof text !== 'string') return text;
  return text.replace(/^\[\d+\]\s*/, '');
}

function processJob(slug, ucjStr) {
  let ucj;
  try { ucj = JSON.parse(ucjStr); }
  catch { return { changed: false, reason: 'JSON parse failed' }; }

  const sources = ucj._sources;
  if (!sources || typeof sources !== 'object' || Array.isArray(sources)) {
    return { changed: false, reason: 'no _sources object' };
  }

  let changed = false;
  const changeLog = [];
  for (const [key, arr] of Object.entries(sources)) {
    if (!Array.isArray(arr)) continue;
    for (let i = 0; i < arr.length; i++) {
      const s = arr[i];
      if (typeof s !== 'object' || !s || typeof s.text !== 'string') continue;
      const before = s.text;
      const after = cleanText(before);
      if (before !== after) {
        changeLog.push({ key, idx: i, before, after });
        s.text = after;
        changed = true;
      }
    }
  }

  return { changed, sources, changeLog };
}

async function applyViaApi(jobId, slug, sources) {
  const url = `${API_BASE}/${jobId}/edit`;
  try {
    const r = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-Admin-Secret': SECRET_HEADER,
      },
      body: JSON.stringify({
        fields: {},
        sources,
        changeSummary: '[clean-source-prefix] _sources text [N] prefix 자동 정리',
      }),
    });
    const text = await r.text();
    if (r.status >= 200 && r.status < 300) return { ok: true, slug };
    return { ok: false, slug, status: r.status, error: text.slice(0, 200) };
  } catch (e) {
    return { ok: false, slug, error: e.message.slice(0, 200) };
  }
}

(async () => {
  console.log(`=== clean-source-prefix ${APPLY ? '(APPLY)' : '(DRY-RUN)'} ===\n`);

  const whereSlug = SLUG ? `AND slug='${SLUG.replace(/'/g, "''")}'` : '';
  const rows = d1Query(`
    SELECT id, slug, user_contributed_json
    FROM jobs
    WHERE is_active=1 AND user_contributed_json IS NOT NULL
      AND json_extract(user_contributed_json,'$._sources') LIKE '%"text":"[%]%'
    ${whereSlug}
    ORDER BY slug
  `);

  console.log(`대상 직업: ${rows.length}개\n`);

  let touched = 0;
  let skipped = 0;
  const apply_failures = [];
  const tasks = [];

  for (const r of rows) {
    const result = processJob(r.slug, r.user_contributed_json);
    if (!result.changed) { skipped++; continue; }
    touched++;

    if (touched <= 20) {
      console.log(`[${touched}] ${r.slug} (id=${r.id}) — ${result.changeLog.length}건 변경`);
      if (touched <= 5) {
        for (const c of result.changeLog.slice(0, 3)) {
          console.log(`    ${c.key}[${c.idx}]: "${c.before.substring(0, 60)}" → "${c.after.substring(0, 60)}"`);
        }
      }
    }

    if (APPLY) tasks.push({ id: r.id, slug: r.slug, sources: result.sources });
  }

  let applied = 0;
  if (APPLY && tasks.length > 0) {
    console.log(`\nAPI 호출 중 (${tasks.length}개)...`);
    // 30개씩 배치 (rate limit 회피)
    const BATCH = 10;
    for (let i = 0; i < tasks.length; i += BATCH) {
      const slice = tasks.slice(i, i + BATCH);
      const results = await Promise.all(slice.map(t => applyViaApi(t.id, t.slug, t.sources)));
      for (const res of results) {
        if (res.ok) applied++;
        else apply_failures.push(res);
      }
      process.stdout.write(`  ${Math.min(i + BATCH, tasks.length)} / ${tasks.length}\r`);
    }
    console.log();
  }

  console.log(`\n결과:`);
  console.log(`  변경 대상: ${touched} / ${rows.length}`);
  console.log(`  변경 없음 (이미 깨끗): ${skipped}`);
  if (APPLY) {
    console.log(`  API apply 성공: ${applied}`);
    console.log(`  API apply 실패: ${apply_failures.length}`);
    if (apply_failures.length > 0) {
      console.log('\n실패 sample:');
      apply_failures.slice(0, 5).forEach(f => console.log(`  ${f.slug}: status=${f.status || '-'} ${f.error || ''}`));
    }
  } else {
    console.log(`\n--apply로 careerwiki edit API 호출 (UTF-8 안전).`);
  }
})();
