#!/usr/bin/env node
// scripts/skill-cache/audit-image-prompts.cjs
// 직업명 한국어 동음이의어 ↔ image_prompt 도메인 mismatch 자동 검출.
//
// 배경:
//   - "신부" → bride/wedding gown 사고 재발 (commit ed2f73f)
//   - JOB_PROMPT_TEMPLATE RULE 0 12케이스 사전 차단 가능
//
// 사용:
//   node scripts/skill-cache/audit-image-prompts.cjs --slug=신부
//   node scripts/skill-cache/audit-image-prompts.cjs --all
//   node scripts/skill-cache/audit-image-prompts.cjs --all --json > out.json
//
// 출력:
//   PASS — required 키워드 모두 포함 + forbidden 0건
//   WARN — required 일부 누락 OR forbidden 발견 (재생성 권고)
//   SKIP — image_prompt NULL/비어있음
//
// MVP 범위:
//   - 12개 RULE 0 케이스 + 추가 (개그맨/희극인 등)
//   - DB write 0건, dry-run only

const { spawnSync } = require('child_process');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');

// 동음이의어 사전: { slug: { required: [...], forbidden: [...], hint } }
//  - required: 동의어 그룹 (OR 매칭 — 하나라도 포함되면 PASS)
//  - forbidden: 하나라도 positive context로 발견되면 WARN
//      (NOT bride / never bride 같은 negative context는 detectForbidden에서 우회)
//  - hint: 재생성 시 prompt에 포함되어야 할 권장 phrase
const HOMONYMS = {
  '신부': {
    required: ['catholic priest', 'cassock'],
    forbidden: ['bride', 'wedding gown', 'wedding dress', 'veil'],
    hint: 'Catholic priest in black cassock and Roman collar (NOT bride / wedding gown / veil)',
  },
  '검사': {
    required: ['prosecutor', 'judicial robe', 'legal dossier'],
    forbidden: ['inspection', 'medical test', 'lab test', 'quality control'],
    hint: 'prosecutor in judicial robe with legal dossier',
  },
  '약사': {
    required: ['pharmacist', 'lab coat', 'medicinal tablet', 'medication'],
    forbidden: ['weak person'],
    hint: 'pharmacist in white coat at pharmacy counter',
  },
  '사육사': {
    required: ['animal trainer', 'zoo', 'aquarium', 'zookeeper'],
    forbidden: [],
    hint: 'animal trainer at a zoo or aquarium',
  },
  '모델': {
    required: ['runway', 'fashion model', 'posing', 'studio'],
    forbidden: ['3d model', 'wireframe', 'schema', 'data model'],
    hint: 'professional human model on runway or in studio',
  },
  '박사': {
    required: ['phd', 'scholar', 'academic gown', 'doctorate'],
    forbidden: ['surgeon', 'stethoscope'],
    hint: 'scholar with PhD diploma in academic gown',
  },
  '강사': {
    required: ['lecturer', 'instructor', 'podium', 'teaching'],
    forbidden: [],
    hint: 'lecturer or instructor at a podium',
  },
  '기사': {
    required: ['technician', 'engineer', 'driver', 'mechanic'],
    forbidden: ['newspaper article', 'journalist', 'reporter'],
    hint: 'technician or engineer or driver (NOT newspaper article)',
  },
  '보살': {
    required: ['buddhist nun', 'buddhist', 'temple'],
    forbidden: [],
    hint: 'Buddhist nun in robes',
  },
  '조산사': {
    required: ['midwife', 'scrub', 'fetal', 'maternity'],
    forbidden: ['mountain birth'],
    hint: 'midwife in scrubs at hospital',
  },
  '심판': {
    required: ['referee', 'umpire', 'whistle', 'sports arena'],
    forbidden: ['courtroom judgment', 'gavel'],
    hint: 'sports referee on the field',
  },
  '감독': {
    required: ['director', 'coach', 'film set', 'megaphone'],
    forbidden: ['abstract overseer'],
    hint: 'film director on set OR sports head coach',
  },
  // 추가 (자주 헷갈리는 직업명)
  '개그맨': {
    required: ['comedian', 'stand-up', 'comedy'],
    forbidden: [],
    hint: 'stand-up comedian with microphone on stage',
  },
  '큐레이터': {
    required: ['curator', 'museum', 'exhibition', 'gallery'],
    forbidden: [],
    hint: 'museum curator with exhibition pieces',
  },
  '이용사': {
    required: ['barber', 'haircut', 'hair shears', 'barbershop'],
    forbidden: [],
    hint: 'traditional male barber at barbershop',
  },
};

// CLI args
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

if (!args.slug && !args.all) {
  console.log('사용:');
  console.log('  node scripts/skill-cache/audit-image-prompts.cjs --slug=<slug>');
  console.log('  node scripts/skill-cache/audit-image-prompts.cjs --all');
  console.log('  --json: 결과를 JSON 출력');
  process.exit(0);
}

// d1Query: Windows 호환 (memory: feedback / windows / npx / handle assertion)
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

// 키워드 매칭 (대소문자 무시, 단어 경계 비강제 — 부분 문자열 OK)
function hasKeyword(prompt, keyword) {
  return prompt.toLowerCase().includes(keyword.toLowerCase());
}

// forbidden 검출은 negative context 우회: "NOT bride" / "never bride" / "no bride" 등이면 OK
function detectForbidden(prompt, keyword) {
  const lower = prompt.toLowerCase();
  const kw = keyword.toLowerCase();
  let idx = lower.indexOf(kw);
  while (idx !== -1) {
    // 직전 30자 확인 — NOT / never / no / without 패턴이면 negative context로 판단
    const ctx = lower.substring(Math.max(0, idx - 30), idx);
    const negative = /\b(not|never|no|without|exclude|avoid)\b[^.]{0,15}$/.test(ctx);
    if (!negative) return true;
    idx = lower.indexOf(kw, idx + kw.length);
  }
  return false;
}

function auditOne(slug, dict, prompt) {
  if (!prompt || prompt.trim().length === 0) {
    return { slug, status: 'SKIP', reason: 'image_prompt NULL/empty', missingRequired: [], foundForbidden: [] };
  }
  // OR 매칭: required 중 하나라도 발견되면 OK
  const matchedRequired = dict.required.filter(k => hasKeyword(prompt, k));
  const requiredOk = matchedRequired.length > 0 || dict.required.length === 0;
  const foundForbidden = dict.forbidden.filter(k => detectForbidden(prompt, k));

  let status = 'PASS';
  const reasons = [];
  if (!requiredOk) {
    status = 'WARN';
    reasons.push(`required keyword 부재 (any of: [${dict.required.join(' | ')}])`);
  }
  if (foundForbidden.length > 0) {
    status = 'WARN';
    reasons.push(`forbidden found: [${foundForbidden.join(', ')}]`);
  }
  return {
    slug,
    status,
    reason: reasons.join(' | ') || `matched: [${matchedRequired.join(', ')}]`,
    missingRequired: requiredOk ? [] : dict.required,
    foundForbidden,
    hint: dict.hint,
  };
}

console.log('=== audit-image-prompts ===\n');

// 대상 직업 결정
let targets;
if (args.slug) {
  if (!HOMONYMS[args.slug]) {
    console.error(`사전에 등록되지 않은 직업: ${args.slug}`);
    console.error(`등록된 직업: ${Object.keys(HOMONYMS).join(', ')}`);
    process.exit(2);
  }
  targets = [args.slug];
} else {
  targets = Object.keys(HOMONYMS);
}

// DB 조회 (single round-trip)
const slugList = targets.map(s => `'${s.replace(/'/g, "''")}'`).join(',');
const rows = d1Query(`SELECT slug, image_prompt FROM jobs WHERE slug IN (${slugList})`);
const promptMap = new Map(rows.map(r => [r.slug, r.image_prompt]));

const results = targets.map(slug => auditOne(slug, HOMONYMS[slug], promptMap.get(slug) || ''));

if (args.json) {
  console.log(JSON.stringify({
    summary: {
      total: results.length,
      pass: results.filter(r => r.status === 'PASS').length,
      warn: results.filter(r => r.status === 'WARN').length,
      skip: results.filter(r => r.status === 'SKIP').length,
    },
    results,
  }, null, 2));
} else {
  for (const r of results) {
    const icon = r.status === 'PASS' ? '✓' : r.status === 'WARN' ? '⚠' : '○';
    console.log(`${icon} ${r.slug.padEnd(8)} ${r.status.padEnd(4)} ${r.reason}`);
    if (r.status === 'WARN') {
      console.log(`     hint: ${r.hint}`);
    }
  }
  const summary = {
    total: results.length,
    pass: results.filter(r => r.status === 'PASS').length,
    warn: results.filter(r => r.status === 'WARN').length,
    skip: results.filter(r => r.status === 'SKIP').length,
  };
  console.log(`\n총 ${summary.total}개: PASS=${summary.pass} WARN=${summary.warn} SKIP=${summary.skip}`);
  if (summary.warn > 0) {
    console.log('\n⚠ WARN 직업은 재생성 권고:');
    console.log('   bridge.careerwiki.org POST /api/generate-image with customPrompt + customNegativePrompt');
    console.log('   (참조: feedback / image regen / via bridge memory)');
  }
}

process.exit(0);
