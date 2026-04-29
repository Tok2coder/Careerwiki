#!/usr/bin/env node
// scripts/skill-cache/auto-dedup-sweep.cjs
// enhance 사이클 끝(Phase 5 후) 자동 dedup 검사.
//
// 검사:
//   1) 본 사이클 직업의 (job_slug, career_tree_id) multi-stage groups (자기강조)
//   2) 글로벌 활성 동명이인 (career_trees is_active=1 GROUP BY person_name HAVING COUNT>1)
//
// 정책:
//   - (1) 본 사이클 직업 자기강조: stages_json 검토 + max stage_index link 자동 DELETE 제안 (apply 모드면 실행)
//   - (2) 글로벌 동명이인: 보고만 (사용자 검토 — 김홍희 같은 의도 보존 케이스 회피)
//
// 사용법:
//   node scripts/skill-cache/auto-dedup-sweep.cjs --slug=<slug>          (dry-run)
//   node scripts/skill-cache/auto-dedup-sweep.cjs --slug=<slug> --apply  (실 DELETE)
//   node scripts/skill-cache/auto-dedup-sweep.cjs --global-only          (글로벌만 보고)

const { execSync } = require('child_process');
const path = require('path');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

function d1Query(sql) {
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command ${JSON.stringify(sql)}`,
    { cwd: path.resolve(__dirname, '..', '..'), encoding: 'utf8', maxBuffer: 50 * 1024 * 1024 }
  );
  // wrangler may print log lines before JSON; extract JSON array
  const m = out.match(/\[\s*\{[\s\S]*\]\s*$/);
  return JSON.parse(m ? m[0] : out)[0].results || [];
}

console.log('=== auto-dedup-sweep ===');

// 1) 본 사이클 자기강조 검사
if (args.slug) {
  const slug = args.slug;
  console.log(`\n[1] 본 사이클 직업 ${slug} self-promotion 검사...`);
  const escSlug = slug.replace(/'/g, "''");
  const groups = d1Query(`SELECT career_tree_id, COUNT(*) cnt, GROUP_CONCAT(stage_index) stages, GROUP_CONCAT(id) link_ids
    FROM career_tree_job_links
    WHERE job_slug='${escSlug}'
    GROUP BY career_tree_id HAVING COUNT(*)>1`);

  if (groups.length === 0) {
    console.log('  ✓ multi-stage 자기강조 0건');
  } else {
    console.log(`  ⚠ ${groups.length}개 그룹 발견:`);
    for (const g of groups) {
      console.log(`    ct_id=${g.career_tree_id} stages=[${g.stages}] count=${g.cnt} link_ids=[${g.link_ids}]`);
    }
    if (args.apply) {
      // 정책: max stage_index link 1개 DELETE (사용자 가이드 룰)
      console.log('\n  apply 모드: max stage_index link DELETE 실행');
      const sql = `DELETE FROM career_tree_job_links WHERE id IN (
        SELECT l.id FROM career_tree_job_links l
        WHERE l.job_slug='${escSlug}'
          AND l.stage_index=(SELECT MAX(stage_index) FROM career_tree_job_links WHERE job_slug='${escSlug}' AND career_tree_id=l.career_tree_id)
          AND (l.job_slug, l.career_tree_id) IN (
            SELECT job_slug, career_tree_id FROM career_tree_job_links
            WHERE job_slug='${escSlug}' GROUP BY job_slug, career_tree_id HAVING COUNT(*)>1)
      )`;
      const out = execSync(
        `npx wrangler d1 execute careerwiki-kr --remote --json --command ${JSON.stringify(sql)}`,
        { cwd: path.resolve(__dirname, '..', '..'), encoding: 'utf8', maxBuffer: 50 * 1024 * 1024 }
      );
      const m = out.match(/"changes":\s*(\d+)/);
      console.log(`  changes: ${m ? m[1] : '(unknown)'}`);
    } else {
      console.log('  (dry-run — apply 안 함. --apply 추가하면 실행)');
    }
  }
}

// 2) 글로벌 동명이인 보고
console.log('\n[2] 글로벌 활성 동명이인 검사...');
const dups = d1Query(`SELECT person_name, COUNT(*) cnt, GROUP_CONCAT(id) ids
  FROM career_trees WHERE is_active=1
  GROUP BY person_name HAVING COUNT(*)>1`);

if (dups.length === 0) {
  console.log('  ✓ 활성 중복 0건');
} else {
  console.log(`  ⚠ ${dups.length}쌍/그룹 발견:`);
  for (const d of dups) {
    console.log(`    ${d.person_name}: ${d.cnt}개 (ids=${d.ids})`);
  }
  console.log('\n  ⚠ 글로벌 dup은 자동 처리 안 함 — 동명이인(예: 김홍희=학예사+해양경찰청장) vs 동일인 구분 사용자 검토 필요.');
  console.log('     stages_json 비교 후 수동 처리: UPDATE career_trees SET is_active=0 WHERE id=<inactive_id>');
}

console.log('\n=== sweep 완료 ===');
