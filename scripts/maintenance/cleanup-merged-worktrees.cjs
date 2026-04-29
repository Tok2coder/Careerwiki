#!/usr/bin/env node
// scripts/maintenance/cleanup-merged-worktrees.cjs
// claude/* 브랜치 중 origin/main에 이미 머지된(ahead=0) 브랜치를 정리.
//
// 사용:
//   node scripts/maintenance/cleanup-merged-worktrees.cjs           (dry-run)
//   node scripts/maintenance/cleanup-merged-worktrees.cjs --apply   (실 정리)
//
// 안전장치:
//   - 현재 worktree에서 체크아웃 중인 브랜치는 절대 건드리지 않음
//   - main / origin/main / current HEAD 비교 후 ahead=0만 대상
//   - --force 플래그 없으면 ahead>0 브랜치는 건너뜀(보존)
//   - worktree 디렉토리 잠금 시 git worktree remove --force 사용

const { execSync } = require('child_process');

const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});

const APPLY = !!args.apply;

function git(cmd) {
  try {
    return execSync(`git ${cmd}`, { encoding: 'utf8', stdio: ['pipe', 'pipe', 'pipe'] }).trim();
  } catch (e) {
    return null;
  }
}

console.log(`=== cleanup-merged-worktrees ${APPLY ? '(APPLY)' : '(DRY-RUN)'} ===\n`);

// fetch first to ensure origin/main is fresh
git('fetch origin');

// 현재 worktree에서 체크아웃된 브랜치 (절대 건드리면 안 됨)
const currentBranches = new Set();
const wtList = git('worktree list --porcelain') || '';
let curBranch = null;
for (const line of wtList.split('\n')) {
  if (line.startsWith('branch ')) {
    curBranch = line.slice('branch '.length).replace('refs/heads/', '');
    currentBranches.add(curBranch);
  }
}
console.log(`체크아웃 중인 브랜치 (보호): ${[...currentBranches].join(', ')}\n`);

// claude/* 브랜치 모두 수집
const branches = (git('for-each-ref --format=%(refname:short) refs/heads/claude/') || '')
  .split('\n').filter(Boolean);

console.log(`claude/* 브랜치 총 ${branches.length}개\n`);

const toRemove = [];
const toKeep = [];
for (const b of branches) {
  if (currentBranches.has(b)) {
    toKeep.push({ branch: b, reason: '현재 worktree에 체크아웃 중 (건드리지 않음)' });
    continue;
  }
  const ahead = parseInt(git(`rev-list --count origin/main..${b}`) || '0', 10);
  const behind = parseInt(git(`rev-list --count ${b}..origin/main`) || '0', 10);
  if (ahead === 0) {
    toRemove.push({ branch: b, ahead, behind });
  } else {
    toKeep.push({ branch: b, ahead, behind, reason: `ahead=${ahead} (미머지 작업물 보존)` });
  }
}

console.log(`=== 정리 대상 (ahead=0) ${toRemove.length}개 ===`);
for (const r of toRemove) console.log(`  ${r.branch} (ahead=${r.ahead}, behind=${r.behind})`);

console.log(`\n=== 보존 ${toKeep.length}개 ===`);
for (const k of toKeep) console.log(`  ${k.branch}: ${k.reason || `ahead=${k.ahead} behind=${k.behind}`}`);

if (!APPLY) {
  console.log('\n(dry-run — 실 정리는 --apply)');
  process.exit(0);
}

console.log('\n=== APPLY 모드: 실 정리 시작 ===');
let removed = 0;
let failed = 0;
for (const r of toRemove) {
  // worktree 디렉토리가 있으면 remove (--force는 잠금/dirty 무시)
  const wtPath = `.claude/worktrees/${r.branch.replace('claude/', '')}`;
  console.log(`\n[${r.branch}]`);
  const wtRm = git(`worktree remove "${wtPath}" --force`);
  if (wtRm === null) {
    // worktree가 없거나 이미 prune된 경우 무시
    console.log(`  worktree remove: (없거나 이미 prune됨)`);
  } else {
    console.log(`  worktree remove ✓`);
  }
  // branch 삭제
  const brDel = git(`branch -D ${r.branch}`);
  if (brDel === null) {
    console.log(`  branch -D: 실패`);
    failed++;
  } else {
    console.log(`  branch -D ✓`);
    removed++;
  }
}

git('worktree prune');
console.log(`\n결과: 정리 ${removed}개 / 실패 ${failed}개`);
