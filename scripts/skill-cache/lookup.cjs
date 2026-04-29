#!/usr/bin/env node
// scripts/skill-cache/lookup.cjs
// Phase 1 사이드바 URL 사전 조회 helper.
// 사용법: node scripts/skill-cache/lookup.cjs --type=cert --name="공인노무사"
//        node scripts/skill-cache/lookup.cjs --type=org --name="한국기상학회"
//        node scripts/skill-cache/lookup.cjs --type=cert --names="공인노무사,세무사,관세사" --json
// JSON 출력 옵션: --json (skill에서 파싱하기 좋게).

const fs = require('fs');
const path = require('path');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const MAPPING_PATH = path.join(__dirname, 'cert-org-mapping.json');
if (!fs.existsSync(MAPPING_PATH)) {
  console.error(`mapping 파일 부재: ${MAPPING_PATH}`);
  process.exit(2);
}

const data = JSON.parse(fs.readFileSync(MAPPING_PATH, 'utf8'));

if (!args.type || !['cert', 'org'].includes(args.type)) {
  console.error('--type=cert | org 필수');
  console.error('사용법: --type=cert --name="공인노무사" 또는 --names="A,B,C"');
  process.exit(2);
}

const dict = args.type === 'cert' ? data.certs : data.orgs;

function lookup(name) {
  const trimmed = (name || '').trim();
  if (!trimmed) return { name, found: false, url: null };
  // 정확 매칭 우선
  if (dict[trimmed]) return { name: trimmed, found: true, url: dict[trimmed] };
  // 부분 매칭 (자격증명에 등급 포함된 경우 대응)
  const partial = Object.keys(dict).find(k => !k.startsWith('_') && (trimmed.includes(k) || k.includes(trimmed)));
  if (partial) return { name: trimmed, matched_via: partial, found: true, url: dict[partial] };
  return { name: trimmed, found: false, url: null };
}

const targets = args.names ? args.names.split(',').map(s => s.trim()) : [args.name];
const results = targets.map(lookup);

if (args.json) {
  console.log(JSON.stringify(results, null, 2));
} else {
  for (const r of results) {
    if (r.found) {
      console.log(`${r.name}\t${r.url}${r.matched_via ? ` (via "${r.matched_via}")` : ''}`);
    } else {
      console.log(`${r.name}\t(not found in cache — LLM 리서치 후 mapping에 추가 권장)`);
    }
  }
}
