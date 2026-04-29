#!/usr/bin/env node
// scripts/sal-bootstrap-mvp.cjs
// WORK24 sal 부트스트랩 MVP — dry-run 검증 통과(year≥2023 + 완전) 직업만 admin_data_json 패치.
//
// 안전장치:
//   - 기본 dry-run (DB write 0)
//   - --apply 명시 시에만 commit
//   - 패치 전 admin_data_json 백업 → data/sal-backups/<timestamp>/<slug>.json
//   - [sal-수정금지] 영향 없음: user_contributed_json 미터치, admin_data_json만 patch
//   - 단일 직업 단위 처리 (--slug=<slug>) + 일괄 처리 (--from=results.json)
//
// 사용:
//   1) dry-run 검사 결과 JSON 산출:
//      node scripts/sal-bootstrap-dryrun.cjs > /tmp/dryrun.txt
//      (또는 --json 옵션 추가 후 jsonl 파싱)
//   2) MVP dry-run (변경 SQL 미실행):
//      node scripts/sal-bootstrap-mvp.cjs --slug=재활의학과전문의사 --year=2024 --sal-text="조사년도:2024년..."
//      node scripts/sal-bootstrap-mvp.cjs --from=data/sal-bootstrap-pass.json   (일괄)
//   3) apply (사용자 승인 후):
//      node scripts/sal-bootstrap-mvp.cjs --from=data/sal-bootstrap-pass.json --apply
//
// 입력 JSON 포맷 (--from):
//   [
//     { "slug": "재활의학과전문의사", "jobCd": "...", "year": 2024, "sal_text": "조사년도:2024년..." },
//     ...
//   ]

const fs = require('fs');
const path = require('path');
const { spawnSync } = require('child_process');

const REPO_ROOT = path.resolve(__dirname, '..');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const APPLY = !!args.apply;

// d1Query: Windows 호환
function d1Query(sql) {
  const escaped = sql.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\s+/g, ' ').trim();
  const cmdline = `npx wrangler d1 execute careerwiki-kr --remote --json --command "${escaped}"`;
  const r = spawnSync(cmdline, {
    cwd: REPO_ROOT, encoding: 'utf8', maxBuffer: 50 * 1024 * 1024,
    shell: true, windowsHide: true,
  });
  if (r.status !== 0 && !r.stdout) {
    throw new Error(`wrangler d1 execute failed: ${(r.stderr || '').slice(0, 500)}`);
  }
  const out = (r.stdout || '').trim();
  const startIdx = out.indexOf('[');
  if (startIdx < 0) return [];
  try { return JSON.parse(out.slice(startIdx))[0]?.results || []; }
  catch { return []; }
}

// 후보 수집
function collectCandidates() {
  if (args.from) {
    const data = JSON.parse(fs.readFileSync(args.from, 'utf8'));
    if (!Array.isArray(data)) throw new Error('--from 파일은 배열이어야 함');
    return data.map(d => ({
      slug: d.slug,
      jobCd: d.jobCd || null,
      year: d.year || null,
      sal_text: d.sal_text || d.sal || '',
    }));
  }
  if (args.slug && args['sal-text']) {
    return [{ slug: args.slug, year: parseInt(args.year || '0'), sal_text: args['sal-text'] }];
  }
  console.error('사용법: --from=<json> 또는 --slug=<slug> --year=<yyyy> --sal-text="..."');
  process.exit(2);
}

// 합격 판정 — year≥2023 + sal_text 비어있지 않음 + 임금 데이터 완전(하위/평균/상위)
function isPass(c) {
  if (!c.sal_text || c.sal_text.length === 0) return { pass: false, reason: 'sal_text empty' };
  if (!c.year || c.year < 2023) return { pass: false, reason: `year=${c.year} (3년 이내 아님)` };
  const has = {
    lower: /하위.*?\d/.test(c.sal_text),
    middle: /(평균|중앙값).*?\d/.test(c.sal_text),
    upper: /상위.*?\d/.test(c.sal_text),
  };
  const missing = Object.entries(has).filter(([_, v]) => !v).map(([k]) => k);
  if (missing.length > 0) return { pass: false, reason: `완전성 부족: missing=${missing.join(',')}` };
  return { pass: true };
}

// 현재 admin_data_json 조회
function fetchCurrentAdmin(slug) {
  const escSlug = slug.replace(/'/g, "''");
  const rows = d1Query(`SELECT id, slug, admin_data_json FROM jobs WHERE slug='${escSlug}' AND is_active=1 LIMIT 1`);
  if (rows.length === 0) return null;
  return rows[0];
}

// 패치 (admin_data_json.overviewSalary.sal = sal_text)
function buildPatch(currentAdminJson, sal_text, year) {
  let admin = {};
  if (currentAdminJson) {
    try { admin = JSON.parse(currentAdminJson); }
    catch { admin = {}; }
  }
  if (!admin.overviewSalary) admin.overviewSalary = {};
  admin.overviewSalary.sal = sal_text;
  admin._sal_bootstrap = {
    bootstrapped_at: new Date().toISOString(),
    source: 'WORK24 callOpenApiSvcInfo212D04 dtlGb=4',
    year,
  };
  return admin;
}

// 백업 파일 저장
function saveBackup(timestamp, slug, original) {
  const dir = path.join(REPO_ROOT, 'data', 'sal-backups', timestamp);
  fs.mkdirSync(dir, { recursive: true });
  const fp = path.join(dir, `${slug}.json`);
  fs.writeFileSync(fp, JSON.stringify({ slug, admin_data_json: original }, null, 2));
  return fp;
}

console.log(`=== sal-bootstrap-mvp ${APPLY ? '(APPLY)' : '(DRY-RUN)'} ===\n`);

const candidates = collectCandidates();
console.log(`후보: ${candidates.length}개\n`);

const pass = [];
const fail = [];
for (const c of candidates) {
  const res = isPass(c);
  if (res.pass) {
    pass.push(c);
    console.log(`  ✓ ${c.slug} (year=${c.year})`);
  } else {
    fail.push({ ...c, reason: res.reason });
    console.log(`  ✗ ${c.slug} — ${res.reason}`);
  }
}

console.log(`\n합격 ${pass.length} / 탈락 ${fail.length}`);
if (pass.length === 0) {
  console.log('패치할 직업 없음. 종료.');
  process.exit(0);
}

const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
const backupDir = path.join('data', 'sal-backups', timestamp);
console.log(`\n백업 디렉토리: ${backupDir}`);

const patches = [];
for (const c of pass) {
  const cur = fetchCurrentAdmin(c.slug);
  if (!cur) {
    console.log(`  ⚠ ${c.slug}: DB에 active row 없음 — 건너뜀`);
    continue;
  }
  const newAdmin = buildPatch(cur.admin_data_json, c.sal_text, c.year);

  if (APPLY) {
    const backupFp = saveBackup(timestamp, c.slug, cur.admin_data_json);
    console.log(`  💾 백업: ${path.relative(REPO_ROOT, backupFp)}`);
  }

  patches.push({
    slug: c.slug,
    id: cur.id,
    sal_preview: c.sal_text.slice(0, 100),
    year: c.year,
    new_admin: newAdmin,
  });
  console.log(`\n  [${c.slug}] (id=${cur.id})`);
  console.log(`    sal preview: ${c.sal_text.slice(0, 100)}...`);
  console.log(`    year: ${c.year}`);
}

if (!APPLY) {
  console.log(`\n--- DRY-RUN: ${patches.length}개 패치 미실행 ---`);
  console.log('실 적용: --apply');
  process.exit(0);
}

console.log(`\n=== APPLY: ${patches.length}개 패치 실행 ===`);
let applied = 0;
let failed = 0;
for (const p of patches) {
  const adminJson = JSON.stringify(p.new_admin).replace(/'/g, "''");
  const sql = `UPDATE jobs SET admin_data_json='${adminJson}', admin_last_updated_at=CURRENT_TIMESTAMP WHERE id=${p.id}`;
  try {
    d1Query(sql);
    console.log(`  ✓ ${p.slug} 패치됨`);
    applied++;
  } catch (e) {
    console.log(`  ✗ ${p.slug} 실패: ${e.message}`);
    failed++;
  }
}

console.log(`\n결과: 적용 ${applied} / 실패 ${failed}`);
console.log(`백업: ${backupDir}/`);
console.log(`롤백: 백업 JSON 읽어서 admin_data_json 복원`);
