#!/usr/bin/env node
// CareerWiki safe-deploy.cjs
// 배포 전 안전 검사:
//   1. 현재 브랜치가 main인지 확인 (worktree/feature 브랜치 차단)
//   2. TypeScript 타입 체크 (tsc --noEmit)
//   3. 빌드 + wrangler pages deploy

'use strict';

const { execSync, spawnSync } = require('child_process');

function run(cmd, label) {
  console.log(`\n▶ ${label || cmd}`);
  const result = spawnSync(cmd, { shell: true, stdio: 'inherit' });
  if (result.status !== 0) {
    console.error(`\n❌ 실패: ${label || cmd}`);
    process.exit(result.status ?? 1);
  }
}

// 1. 브랜치 확인
let branch;
try {
  branch = execSync('git rev-parse --abbrev-ref HEAD', { encoding: 'utf-8' }).trim();
} catch {
  console.error('❌ git 브랜치를 확인할 수 없습니다.');
  process.exit(1);
}

if (branch !== 'main') {
  console.error('');
  console.error('🚫 배포 차단: 현재 브랜치가 main이 아닙니다.');
  console.error(`   현재 브랜치: ${branch}`);
  console.error('');
  console.error('   배포는 main 브랜치에서만 실행할 수 있습니다.');
  console.error('   worktree나 feature 브랜치에서는 배포하지 마세요.');
  console.error('');
  process.exit(1);
}

console.log(`✅ 브랜치 확인: ${branch}`);

// 2. TypeScript 타입 체크
run('npx tsc --noEmit', 'TypeScript 타입 체크');
console.log('✅ TypeScript 타입 체크 통과');

// 3. 빌드 + 배포
run('npm run build', 'npm run build');

// Windows 환경에서 git log의 한글 커밋 메시지가 CP949로 읽혀 wrangler가
// UTF-8 검증에 실패하는 경우가 있음 (code: 8000111).
// ASCII 전용 커밋 메시지를 명시적으로 넘겨 우회한다.
// 실제 commit SHA는 Cloudflare Pages 대시보드에서 확인 가능.
let sha = '';
try {
  sha = execSync('git rev-parse --short HEAD', { encoding: 'utf-8' }).trim();
} catch {}
const commitMsg = sha ? `deploy ${sha}` : 'deploy';
run(`wrangler pages deploy dist --commit-message "${commitMsg}"`, 'wrangler pages deploy dist');

console.log('\n✅ 배포 완료');
