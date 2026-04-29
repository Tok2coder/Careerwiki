#!/usr/bin/env node
// scripts/skill-cache/clean-source-prefix.cjs
// _sources.<field>[i].text 시작의 [N] 또는 [N] (마커 prefix) 자동 제거.
//
// 배경:
//   enhance subagent 일부가 sources의 text 필드에 [N] prefix를 잘못 추가.
//   예: {"text":"[1] (사)한국피부미용사회중앙회"} → "(사)한국피부미용사회중앙회"
//   영향 직업 ~570건 (전수 sweep, 2026-04-29).
//
// 안전:
//   - dry-run (기본): SQL UPDATE 미실행, 변경 sample 출력
//   - --apply: 사용자 승인 후 D1 UPDATE
//   - --slug=<slug>: 단일 직업 처리
//   - 백업 — UCJ 변경 전 admin_data_json 같은 다른 컬럼은 건드리지 않음 (UCJ만 수정)
//
// 사용:
//   node scripts/skill-cache/clean-source-prefix.cjs                    (dry-run, 전수)
//   node scripts/skill-cache/clean-source-prefix.cjs --slug=피부관리사  (dry-run, 단일)
//   node scripts/skill-cache/clean-source-prefix.cjs --apply            (실 적용)
//   node scripts/skill-cache/clean-source-prefix.cjs --slug=피부관리사 --apply

const { spawnSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const APPLY = !!args.apply;
const SLUG = args.slug;

function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 200 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) {
    throw new Error(`wrangler failed: ${(r.stderr || '').slice(0, 500)}`);
  }
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  return JSON.parse(out.slice(startIdx))[0]?.results || [];
}

function cleanText(text) {
  if (typeof text !== 'string') return text;
  // "[N] " or "[N]" prefix 제거 (한 번만)
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

  return { changed, ucj, changeLog };
}

console.log(`=== clean-source-prefix ${APPLY ? '(APPLY)' : '(DRY-RUN)'} ===\n`);

// 대상 직업 조회
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

for (const r of rows) {
  const result = processJob(r.slug, r.user_contributed_json);
  if (!result.changed) { skipped++; continue; }
  touched++;

  // sample log (앞 20개만 자세히)
  if (touched <= 20 || APPLY) {
    console.log(`[${touched}] ${r.slug} (id=${r.id}) — ${result.changeLog.length}건 변경`);
    if (touched <= 5) {
      for (const c of result.changeLog.slice(0, 3)) {
        console.log(`    ${c.key}[${c.idx}]: "${c.before.substring(0, 60)}" → "${c.after.substring(0, 60)}"`);
      }
    }
  }

  if (APPLY) {
    // UCJ 갱신
    const newUcj = JSON.stringify(result.ucj).replace(/'/g, "''");
    try {
      d1Query(`UPDATE jobs SET user_contributed_json='${newUcj}', user_last_updated_at=CURRENT_TIMESTAMP WHERE id=${r.id}`);
    } catch (e) {
      apply_failures.push({ slug: r.slug, error: e.message.slice(0, 200) });
    }
  }
}

console.log(`\n결과:`);
console.log(`  변경 대상: ${touched} / ${rows.length}`);
console.log(`  변경 없음 (이미 깨끗): ${skipped}`);
if (APPLY) {
  console.log(`  apply 성공: ${touched - apply_failures.length}`);
  console.log(`  apply 실패: ${apply_failures.length}`);
  if (apply_failures.length > 0) {
    console.log('\n실패 sample:');
    apply_failures.slice(0, 5).forEach(f => console.log(`  ${f.slug}: ${f.error}`));
  }
} else {
  console.log(`\n--apply로 실 D1 UPDATE 실행. 권장 — 단일 직업 먼저 (--slug=피부관리사 --apply)로 검증 후 전수 apply.`);
}
