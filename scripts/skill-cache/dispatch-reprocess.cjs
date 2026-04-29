#!/usr/bin/env node
// scripts/skill-cache/dispatch-reprocess.cjs
// 깨진 _sources 사고 직업 재처리 dispatch prompt 생성.
// audit-sources.cjs로 식별된 sources_NULL + mojibake 합계 → 5 세션 분할.
//
// 사용:
//   node scripts/skill-cache/dispatch-reprocess.cjs                              (sources_NULL + mojibake = 49 default)
//   node scripts/skill-cache/dispatch-reprocess.cjs --pattern=sources_NULL,mojibake
//   node scripts/skill-cache/dispatch-reprocess.cjs --pattern=raw_url            (단일 패턴)
//   node scripts/skill-cache/dispatch-reprocess.cjs --slugs=A,B,C                (custom 리스트)
//   node scripts/skill-cache/dispatch-reprocess.cjs --sessions=5                 (default 5)
//   node scripts/skill-cache/dispatch-reprocess.cjs --json                       (JSON 출력)

const { spawnSync } = require('child_process');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const SESSIONS = parseInt(args.sessions || '5');
const PATTERNS = args.pattern ? args.pattern.split(',') : ['sources_NULL', 'mojibake'];
const STAGGER = parseInt(args.stagger || '30');

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

const PATTERN_SQL = {
  sources_NULL: `SELECT id, slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
                 AND json_extract(user_contributed_json,'$._sources') IS NULL
                 AND (json_extract(user_contributed_json,'$.way') LIKE '%[1]%'
                      OR json_extract(user_contributed_json,'$.trivia') LIKE '%[1]%'
                      OR json_extract(user_contributed_json,'$.detailReady') LIKE '%[1]%')
                 ORDER BY slug`,
  mojibake: `SELECT id, slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
             AND user_contributed_json LIKE '%�%'
             ORDER BY slug`,
  raw_url: `SELECT id, slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
            AND json_extract(user_contributed_json,'$._sources') LIKE '%"text":"http%'
            ORDER BY slug`,
  bracket_prefix: `SELECT id, slug FROM jobs WHERE is_active=1 AND user_contributed_json IS NOT NULL
                   AND json_extract(user_contributed_json,'$._sources') LIKE '%"text":"[%]%'
                   ORDER BY slug`,
};

// 슬러그 수집
let items = [];
const seen = new Set();

if (args.slugs) {
  // custom 슬러그 리스트
  const slugs = args.slugs.split(',').map(s => s.trim()).filter(Boolean);
  const placeholders = slugs.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
  const rows = d1Query(`SELECT id, slug FROM jobs WHERE slug IN (${placeholders})`);
  for (const r of rows) {
    if (!seen.has(r.slug)) { seen.add(r.slug); items.push({ id: String(r.id), slug: r.slug, pattern: 'custom' }); }
  }
} else {
  for (const p of PATTERNS) {
    if (!PATTERN_SQL[p]) {
      console.error(`알 수 없는 패턴: ${p}. 가능: ${Object.keys(PATTERN_SQL).join(', ')}`);
      process.exit(2);
    }
    const rows = d1Query(PATTERN_SQL[p]);
    for (const r of rows) {
      if (!seen.has(r.slug)) {
        seen.add(r.slug);
        items.push({ id: String(r.id), slug: r.slug, pattern: p });
      } else {
        // 같은 직업이 여러 패턴에 걸리면 _patterns에 추가
        const existing = items.find(i => i.slug === r.slug);
        if (existing && !existing.pattern.includes(p)) existing.pattern = existing.pattern + '+' + p;
      }
    }
  }
}

console.log(`=== dispatch-reprocess ===\n`);
console.log(`패턴: ${args.slugs ? '(custom)' : PATTERNS.join(', ')}`);
console.log(`대상 직업: ${items.length}개`);
console.log(`세션 수: ${SESSIONS}`);
console.log(`권장 stagger: ${STAGGER}초\n`);

if (items.length === 0) {
  console.log('대상 0건 — 종료.');
  process.exit(0);
}

// 5 세션 균등 분배 (10/10/10/10/9 또는 비슷)
const perSession = Math.ceil(items.length / SESSIONS);
const sessions = [];
for (let i = 0; i < SESSIONS && i * perSession < items.length; i++) {
  sessions.push(items.slice(i * perSession, (i + 1) * perSession));
}

if (args.json) {
  console.log(JSON.stringify({
    total: items.length,
    sessions: sessions.length,
    items_per_session: sessions.map(s => s.length),
    sessions_data: sessions,
  }, null, 2));
  process.exit(0);
}

// dispatch prompt 생성
const STANDARD_RULES = [
  '### 표준 룰 (필수 준수 — 재처리 풀 사이클 Phase 0~5)',
  '',
  '**🔴 사고 직업 재처리 — 강화된 검증 필수**:',
  '1. **Phase 0-PRE START_TRACKING** bash 직접 실행',
  '2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기',
  '3. **Phase 1**: 17필드 draft 작성 — 기존 깨진 데이터 덮어쓰기 (PARTIAL 보강 금지)',
  '4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저',
  '5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS **반드시 통과** 후 API 호출 (단축 절대 금지)',
  '6. **Phase 3**: `POST https://careerwiki.org/api/job/{id}/edit` + `X-Admin-Secret: careerwiki-admin-2026`',
  '   - **반드시 Node.js fetch + UTF-8** (curl 절대 금지)',
  '   - JSON.stringify로 한글 안전 전송',
  '7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` + `full-quality-audit.cjs` PASS',
  '8. **Phase 5-DEDUP**: `auto-dedup-sweep.cjs --slug=<slug> --apply` END_TRACKING 전',
  '9. **Phase 5 끝 END_TRACKING** + UCJ 17필드 self-report',
  '10. **[job-data-enhance] 마커 부착**: change_summary에 `[job-data-enhance]` 포함',
  '',
  '**🚨 _sources 사고 4가지 절대 금지** (사용자 발견 사고 — commit a1557c7):',
  '11. **`_sources[*].text` = 기관명만** (raw URL 금지·`[N]` prefix 금지·mojibake 금지)',
  '    ❌ `{"text":"https://www..."}` (raw URL — 사고 사례)',
  '    ❌ `{"text":"[1] (사)한국..."}` ([N] prefix — 사고 사례)',
  '    ❌ `{"text":"�ѱ��"}` (mojibake — CP949 사고 재발 위험)',
  '    ✅ `{"text":"한국직업능력연구원","url":"https://..."}`',
  '12. **본문 [N] 마커 ↔ `_sources` 매핑 필수** — 본문에 `[1]` 있으면 `_sources["way"][0]` 등록 필수',
  '13. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지',
  '14. **homonym disambiguation**: SKILL.md RULE 0 12케이스 + audit-image-prompts.cjs',
  '15. **careerTree 정치인 제외**: 역대 대통령 절대',
].join('\n');

console.log('---\n');
console.log('## 🚀 5 세션 재처리 dispatch prompts (즉시 페이스트)\n');
console.log(`**권장 stagger**: 각 세션 dispatch 사이 ${STAGGER}초 간격\n`);
console.log('---\n');

sessions.forEach((sess, idx) => {
  console.log(`=== 세션 ${idx + 1} prompt (${sess.length}개) ===\n`);
  console.log(`/job-data-enhance 다음 ${sess.length}개 직업 **재처리** 풀 사이클 (Phase 0~5).`);
  console.log(`목표: 깨진 _sources 사고 (sources_NULL/mojibake) 정정 + [job-data-enhance] 마커 부착.`);
  console.log(`사고 패턴: ${PATTERNS.join(', ')}. 강화된 validate Gate (commit a1557c7) 적용 필수.`);
  console.log('');
  sess.forEach(item => {
    const url = `https://careerwiki.org/job/${item.slug}`;
    console.log(`### ${item.slug} (id=${item.id})`);
    console.log(`- URL: ${url}`);
    console.log(`- 사고 패턴: ${item.pattern}`);
    if (item.pattern.includes('mojibake')) {
      console.log(`- ⚠️ mojibake 사고 — UCJ에 깨진 한글 (예: \`�ѱ����ǻ�ȸ\`). 한글 label 새로 작성 + Node.js fetch UTF-8`);
    }
    if (item.pattern.includes('sources_NULL')) {
      console.log(`- ⚠️ sources_NULL 사고 — 본문 [N] 마커 있지만 _sources 매핑 0건. _sources 객체 신규 작성 필수`);
    }
    if (item.pattern.includes('raw_url')) {
      console.log(`- ⚠️ raw URL 사고 — text가 URL. text는 기관명만, URL은 url 필드만`);
    }
    console.log('');
  });
  console.log(STANDARD_RULES);
  console.log('');
  console.log('각 직업 처리 후 validate-job-edit.cjs PASS + Phase 5 검증 + END_TRACKING + 17필드 self-report + [job-data-enhance] 마커 확인.');
  console.log();
});

console.log('---\n## 운영 가이드\n');
console.log(`### 5 세션 동시 운영`);
console.log(`- 세션 1 dispatch → ${STAGGER}초 대기 → 세션 2 → ... → 세션 5`);
console.log(`- 세션당 진행 시간 추산 (재처리, 풀 사이클): 5-10분/직업`);
console.log(`- 세션당 ${perSession}직업 = ${perSession * 7}~${perSession * 10}분 추산`);
console.log('');
console.log(`### 후속 검증`);
console.log(`- 처리 후: \`node scripts/skill-cache/audit-sources.cjs\` 재실행 → 처리한 패턴 0건 확인`);
console.log(`- production page 직접 확인: 5 sample 직업 fetch + sources 정상 노출`);
