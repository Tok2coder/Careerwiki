#!/usr/bin/env node
/**
 * trust-audit.cjs — 콘텐츠 신뢰성 자동 점검 (C8·C9·H1·J1)
 *
 * 사용:
 *   node scripts/trust-audit.cjs --check=ai-stale
 *   node scripts/trust-audit.cjs --check=ai-source-hallucination
 *   node scripts/trust-audit.cjs --check=self-harm-method
 *
 * 권장 운영: GitHub Actions 또는 wrangler cron으로 매일 1회
 */

'use strict';

const args = process.argv.slice(2);
const checkArg = args.find(a => a.startsWith('--check='));
const check = checkArg ? checkArg.split('=')[1] : 'all';

console.log(`\n=== Careerwiki 신뢰성 자동 점검 — check=${check} ===\n`);

// 가용한 체크들
const CHECKS = {
  'ai-stale': {
    desc: 'C8 - AI 생성 후 7일 이상 사람 검수 없는 필드 탐지',
    note: '운영팀 검토 큐에 priority=high로 자동 등록 권장'
  },
  'ai-source-hallucination': {
    desc: 'C9 - AI가 표기한 출처 URL이 실재하는지 샘플 검증',
    note: '주 1회 100건 샘플링 + URL fetch + HTTP 200 확인'
  },
  'self-harm-method': {
    desc: 'J1 - 자살보도 권고기준 5원칙 준수: 구체적 도구·장소·방법 검출',
    note: '직업 trivia, HowTo 본문, 댓글 본문 스캔'
  },
  'duplicate-howto': {
    desc: 'G5 - HowTo 중복 콘텐츠 80% 이상 일치 탐지',
    note: '신규 HowTo 발행 시 사전 검사 + 야간 일괄 검사'
  },
  'admin-data-orphan': {
    desc: 'C7 - admin_data_json·user_contributed_json 일관성 검사',
    note: '두 필드가 동시에 같은 키를 가지면 우선순위 명시 필요'
  }
};

if (check === 'list' || check === 'help') {
  console.log('사용 가능한 체크:');
  for (const [k, v] of Object.entries(CHECKS)) {
    console.log(`  - ${k.padEnd(28)} ${v.desc}`);
    console.log(`    ${' '.repeat(30)}${v.note}`);
  }
  console.log('\n프로덕션 D1 쿼리는 wrangler d1 execute --remote 사용');
  console.log('예: wrangler d1 execute careerwiki-kr --remote --command "SELECT ..."');
  process.exit(0);
}

if (!CHECKS[check] && check !== 'all') {
  console.error(`알 수 없는 체크: ${check}`);
  console.error(`사용 가능한 체크: ${Object.keys(CHECKS).join(', ')}, all, list`);
  process.exit(1);
}

const checksToRun = check === 'all' ? Object.keys(CHECKS) : [check];

console.log('이 스크립트는 자리표시(skeleton)이며, 실제 D1 쿼리는 다음 형태로 작성하면 됩니다:\n');

for (const c of checksToRun) {
  const meta = CHECKS[c];
  console.log(`[${c}] ${meta.desc}`);
  console.log(`  운영 메모: ${meta.note}`);
  if (c === 'ai-stale') {
    console.log(`  쿼리 예시:`);
    console.log(`    SELECT id, slug, last_modified FROM jobs`);
    console.log(`    WHERE admin_data_json IS NOT NULL`);
    console.log(`      AND last_modified < datetime('now', '-7 days')`);
    console.log(`      AND user_last_updated_at IS NULL`);
    console.log(`    LIMIT 100;`);
  }
  console.log('');
}

console.log('\n실제 점검 로직은 운영 일정 확정 후 본 스크립트에 채워넣을 예정입니다.');
console.log('(정책 community §5, source-tier §5, howto §6 §3 참조)');
process.exit(0);
