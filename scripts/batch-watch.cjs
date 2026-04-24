#!/usr/bin/env node
'use strict';

/**
 * batch-watch.cjs — 배치 재생성 실시간 모니터
 *
 * 사용법: node scripts/batch-watch.cjs
 *
 * 로그 파일을 tail -f 방식으로 감시하며 한글이 깨지지 않게 UTF-8로 출력.
 * Ctrl+C로 종료.
 */

const fs   = require('fs');
const path = require('path');

const LOG_FILE        = path.join(__dirname, 'batch-regenerate-progress.log');
const CHECKPOINT_FILE = path.join(__dirname, '.batch-regenerate-progress.json');
const TOTAL           = 7546;

// Windows 콘솔 UTF-8 강제 (한글 깨짐 방지)
if (process.platform === 'win32') {
  try { require('child_process').execSync('chcp 65001', { stdio: 'ignore' }); } catch {}
}
process.stdout.setEncoding?.('utf8');

function formatDuration(sec) {
  const h = Math.floor(sec / 3600), m = Math.floor((sec % 3600) / 60), s = Math.floor(sec % 60);
  if (h > 0) return `${h}h ${m}m`;
  if (m > 0) return `${m}m ${s}s`;
  return `${s}s`;
}

function printStatus() {
  try {
    const cp = JSON.parse(fs.readFileSync(CHECKPOINT_FILE, 'utf8'));
    const done = cp.completed?.length || 0;
    const fail = cp.failed?.length || 0;
    const pct  = ((done / TOTAL) * 100).toFixed(1);
    const BAR  = 30;
    const filled = Math.round((done / TOTAL) * BAR);
    const bar  = '█'.repeat(filled) + '░'.repeat(BAR - filled);

    // 평균 속도 (로그 파일에서)
    let avgSec = null;
    if (fs.existsSync(LOG_FILE)) {
      const content = fs.readFileSync(LOG_FILE, 'utf8');
      const matches = [...content.matchAll(/✓.*?(\d+\.?\d*)s$/gm)];
      if (matches.length >= 5) {
        const recent = matches.slice(-50).map(m => parseFloat(m[1]));
        avgSec = recent.reduce((a, b) => a + b, 0) / recent.length;
      }
    }
    const remain = TOTAL - done;
    const eta = avgSec ? formatDuration(remain * avgSec) : '계산 중...';

    console.log(`\x1b[2J\x1b[H`); // 화면 클리어
    console.log(`═══════════════════════════════════════════════`);
    console.log(`  CareerWiki 이미지 배치 — 실시간 모니터`);
    console.log(`═══════════════════════════════════════════════`);
    console.log(`  [${bar}] ${pct}%`);
    console.log(`  완료: ${done.toLocaleString()} / ${TOTAL.toLocaleString()}  실패: ${fail}`);
    if (avgSec) console.log(`  속도: ${avgSec.toFixed(1)}초/항목  남은 시간: ~${eta}`);
    console.log(`───────────────────────────────────────────────`);
  } catch {}
}

// 초기 상태 출력
printStatus();

// 로그 파일 tail -f
if (!fs.existsSync(LOG_FILE)) {
  console.log('  로그 파일 대기 중...');
}

let fileSize = fs.existsSync(LOG_FILE) ? fs.statSync(LOG_FILE).size : 0;
// 마지막 5줄 먼저 출력
if (fs.existsSync(LOG_FILE)) {
  const content = fs.readFileSync(LOG_FILE, 'utf8');
  const lines = content.split('\n').filter(l => l.trim());
  lines.slice(-5).forEach(l => {
    // BOM 제거
    const clean = l.replace(/^\uFEFF/, '');
    console.log(`  ${clean}`);
  });
  console.log('');
}

// 파일 변경 감시
fs.watchFile(LOG_FILE, { interval: 1000 }, (curr, prev) => {
  if (curr.size <= prev.size) return;
  // 새로 추가된 부분만 읽기
  const fd = fs.openSync(LOG_FILE, 'r');
  const buf = Buffer.alloc(curr.size - prev.size);
  fs.readSync(fd, buf, 0, buf.length, prev.size);
  fs.closeSync(fd);
  const newText = buf.toString('utf8');
  const newLines = newText.split('\n').filter(l => l.trim());
  newLines.forEach(line => {
    const clean = line.replace(/^\uFEFF/, '');
    // 색상: ✓ = 초록, ✗ = 빨강, 기타 = 노랑
    if (clean.includes('✓')) {
      console.log(`  \x1b[32m${clean}\x1b[0m`);
    } else if (clean.includes('✗')) {
      console.log(`  \x1b[31m${clean}\x1b[0m`);
    } else {
      console.log(`  \x1b[33m${clean}\x1b[0m`);
    }
  });
  // 10줄마다 상태 바 업데이트
  printStatus();
});

console.log(`  (Ctrl+C로 종료 — 배치는 계속 실행됨)`);
console.log('');
