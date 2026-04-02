const fs = require('fs');
const d = JSON.parse(fs.readFileSync('tmp_all_jobs.json', 'utf8'));
const jobs = d[0]?.results || [];
const nameSet = new Set(jobs.map(j => j.name));

const mappings = [];

// 1. "(일반)" 변형: "X(일반)" → "X" 로 매핑
for (const j of jobs) {
  if (j.name.endsWith('(일반)')) {
    const base = j.name.replace(/\(일반\)$/, '').trim();
    if (nameSet.has(base)) {
      mappings.push({
        source: j.name,
        target: base,
        sourceId: j.id,
        reason: 'general_variant',
        score: 1.0,
      });
    }
  }
}

// 2. 괄호 변형: "X(부연)" → "X" 로 매핑 (base가 존재하는 경우만)
for (const j of jobs) {
  const match = j.name.match(/^(.+?)\((.+?)\)$/);
  if (match) {
    const base = match[1].trim();
    const note = match[2].trim();
    if (note === '일반') continue; // 이미 위에서 처리
    if (nameSet.has(base)) {
      // base가 이미 존재하면 괄호 변형은 중복
      mappings.push({
        source: j.name,
        target: base,
        sourceId: j.id,
        reason: 'bracket_variant',
        score: 0.95,
        note,
      });
    }
  }
}

// 중복 제거 (같은 source가 두번 잡히는 경우)
const seen = new Set();
const unique = mappings.filter(m => {
  if (seen.has(m.source)) return false;
  seen.add(m.source);
  return true;
});

console.log(`\n=== 합치기 대상 총 ${unique.length}건 ===\n`);
console.log('--- (일반) 변형 ---');
unique.filter(m => m.reason === 'general_variant').forEach(m => {
  console.log(`  "${m.source}" (id:${m.sourceId}) → "${m.target}"`);
});
console.log('\n--- 괄호 변형 ---');
unique.filter(m => m.reason === 'bracket_variant').forEach(m => {
  console.log(`  "${m.source}" (id:${m.sourceId}) → "${m.target}" [${m.note}]`);
});

// SQL 생성
const sqlLines = unique.map(m => {
  const escapedSource = m.source.replace(/'/g, "''");
  const escapedTarget = m.target.replace(/'/g, "''");
  return `INSERT OR IGNORE INTO name_mappings (type, source_name, target_name, similarity_score, match_reason, created_by, created_at, is_active) VALUES ('job', '${escapedSource}', '${escapedTarget}', ${m.score}, '${m.reason}', 'admin-claude', unixepoch() * 1000, 1);`;
});

const sql = `-- Migration: Merge duplicate job names ((일반) variants + bracket variants)
-- Total: ${unique.length} mappings
-- Date: 2026-03-09

${sqlLines.join('\n')}
`;

fs.writeFileSync('tmp_merge_sql.sql', sql, 'utf8');
console.log(`\nSQL 파일 생성: tmp_merge_sql.sql (${sqlLines.length}건)`);

// JSON도 저장
fs.writeFileSync('tmp_merge_targets.json', JSON.stringify(unique, null, 2), 'utf8');
