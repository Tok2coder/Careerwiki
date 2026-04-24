#!/usr/bin/env node
'use strict';

/**
 * batch-regenerate-status.cjs
 *
 * 이미지 배치 재생성 진행 상황을 체크포인트 파일에서 읽어 출력.
 *
 * 사용법:
 *   node scripts/batch-regenerate-status.cjs
 *
 * 로그 실시간 확인 (PowerShell):
 *   Get-Content scripts/batch-regenerate-progress.log -Wait -Tail 20
 */

const fs   = require('fs');
const path = require('path');

const CHECKPOINT_FILE = path.join(__dirname, '.batch-regenerate-progress.json');
const LOG_FILE        = path.join(__dirname, 'batch-regenerate-progress.log');
const TOTAL           = 7546; // 직업 6939 + 전공 607 (is_active=1 기준, alias 97개 제외)

function formatDuration(sec) {
  if (!sec || sec < 0) return '알 수 없음';
  const h = Math.floor(sec / 3600);
  const m = Math.floor((sec % 3600) / 60);
  const s = Math.floor(sec % 60);
  if (h > 0) return `${h}시간 ${m}분`;
  if (m > 0) return `${m}분 ${s}초`;
  return `${s}초`;
}

function timeAgo(isoStr) {
  if (!isoStr) return '알 수 없음';
  const diffSec = (Date.now() - new Date(isoStr).getTime()) / 1000;
  if (diffSec < 60)   return `${Math.floor(diffSec)}초 전`;
  if (diffSec < 3600) return `${Math.floor(diffSec / 60)}분 전`;
  return `${Math.floor(diffSec / 3600)}시간 ${Math.floor((diffSec % 3600) / 60)}분 전`;
}

function main() {
  console.log('');
  console.log('══════════════════════════════════════════');
  console.log('  CareerWiki 이미지 배치 — 진행 현황');
  console.log(`  대상: ${TOTAL.toLocaleString()}개 (is_active=1, alias 97개 제외)`);
  console.log('══════════════════════════════════════════');

  // ── 체크포인트 파일 읽기 ─────────────────────────────────────────────────
  if (!fs.existsSync(CHECKPOINT_FILE)) {
    console.log('  체크포인트 파일 없음. 배치가 아직 시작되지 않았습니다.');
    console.log('  실행: node scripts/batch-regenerate-all-images.cjs');
    console.log('');
    return;
  }

  let cp;
  try {
    cp = JSON.parse(fs.readFileSync(CHECKPOINT_FILE, 'utf8'));
  } catch {
    console.log('  체크포인트 파일 읽기 실패.');
    return;
  }

  const completedCount = cp.completed?.length || 0;
  const failedList     = cp.failed || [];
  const failedCount    = failedList.length;
  const lastAt         = cp.lastAt;
  const pct            = ((completedCount / TOTAL) * 100).toFixed(1);

  // ── 평균 속도 계산 (로그 첫 줄 ~ 마지막 줄 시간 차) ──────────────────────
  let avgSec = null;
  let startTs = null;
  if (fs.existsSync(LOG_FILE)) {
    const lines = fs.readFileSync(LOG_FILE, 'utf8').split('\n').filter(l => l.trim());
    // 시작 타임스탬프
    const startLine = lines.find(l => l.includes('배치 시작'));
    if (startLine) {
      const m = startLine.match(/\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\]/);
      if (m) startTs = new Date(m[1].replace(' ', 'T') + 'Z');
    }
    // 완료 라인에서 초 값 수집
    const elapsedVals = [];
    for (const line of lines) {
      if (!line.includes('✓')) continue;
      const m = line.match(/(\d+(?:\.\d+)?)s$/);
      if (m) elapsedVals.push(parseFloat(m[1]));
    }
    if (elapsedVals.length >= 3) {
      avgSec = elapsedVals.reduce((a, b) => a + b, 0) / elapsedVals.length;
    }
  }

  const remaining     = TOTAL - completedCount;
  const estRemainSec  = avgSec ? remaining * avgSec : remaining * 60;

  // 최근 처리 항목 (로그 마지막 완료/실패 줄)
  let lastItem = null;
  if (fs.existsSync(LOG_FILE)) {
    const lines = fs.readFileSync(LOG_FILE, 'utf8').split('\n').filter(l => l.trim());
    for (let i = lines.length - 1; i >= 0; i--) {
      if (lines[i].includes('✓') || lines[i].includes('✗')) {
        lastItem = lines[i];
        break;
      }
    }
  }

  // ── 출력 ─────────────────────────────────────────────────────────────────
  console.log('');
  console.log(`  진행: ${completedCount.toLocaleString()} / ${TOTAL.toLocaleString()} (${pct}%)`);
  console.log(`  성공: ${(completedCount - failedCount).toLocaleString()} | 실패: ${failedCount}`);
  if (lastAt) {
    console.log(`  마지막 업데이트: ${timeAgo(lastAt)}`);
  }
  if (lastItem) {
    // 타임스탬프 부분 제거하고 핵심만
    const clean = lastItem.replace(/^\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\] /, '');
    console.log(`  최근 처리: ${clean}`);
  }
  if (avgSec) {
    console.log(`  평균 속도: ${avgSec.toFixed(1)}초/항목`);
  }
  console.log(`  남은 항목: ${remaining.toLocaleString()}개`);
  console.log(`  남은 예상: 약 ${formatDuration(estRemainSec)}`);

  // 진행 바
  const BAR_WIDTH = 36;
  const filled = Math.round((completedCount / TOTAL) * BAR_WIDTH);
  const bar = '█'.repeat(filled) + '░'.repeat(BAR_WIDTH - filled);
  console.log('');
  console.log(`  [${bar}] ${pct}%`);

  // 실패 목록 (최근 5개)
  if (failedList.length > 0) {
    console.log('');
    console.log(`  최근 실패 (최대 5개):`);
    failedList.slice(-5).forEach(f => {
      console.log(`    ✗ [${f.type}] ${f.slug}: ${(f.reason || '').slice(0, 60)}`);
    });
  }

  console.log('');
  console.log('──────────────────────────────────────────');
  console.log('  로그 실시간 확인 (PowerShell):');
  console.log('    Get-Content scripts\\batch-regenerate-progress.log -Wait -Tail 20');
  console.log('  상태 재확인:');
  console.log('    node scripts/batch-regenerate-status.cjs');
  console.log('══════════════════════════════════════════');
  console.log('');
}

main();
