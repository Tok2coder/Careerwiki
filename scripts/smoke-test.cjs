#!/usr/bin/env node
/**
 * smoke-test.cjs — 프로덕션 핵심 사용자 플로우 회귀 자동 검증
 *
 * safe-deploy.cjs가 자동 호출 → 배포 직후 핵심 페이지·API가 깨졌는지 확인.
 * 실패 시 비제로 exit + 명확한 보고. 다음 배포는 사람이 확인 후 진행하도록.
 *
 * 검사 항목:
 *   1. 핵심 페이지 200 OK (직업·전공·HowTo·정책·관리자·온보딩)
 *   2. 가입 API dry-run (validation만 — 실제 가입 안 됨)
 *      - 비로그인 호출 시 명확한 "Unauthorized" 응답이어야 함
 *      - "약관 버전이 일치하지 않습니다" 같은 검증 에러가 빈 페이로드에 나오는지
 *   3. 댓글 API 응답 형식 검증
 *   4. 정책 페이지 콘텐츠 존재 키워드 검사
 *
 * 사용:
 *   node scripts/smoke-test.cjs                  # default base = https://careerwiki.org
 *   node scripts/smoke-test.cjs --base=URL       # 다른 환경
 *   node scripts/smoke-test.cjs --fail-fast      # 첫 실패에서 즉시 종료
 */

'use strict';

const args = process.argv.slice(2);
const baseArg = args.find(a => a.startsWith('--base='));
const BASE = (baseArg ? baseArg.split('=')[1] : 'https://careerwiki.org').replace(/\/$/, '');
const FAIL_FAST = args.includes('--fail-fast');

const results = { pass: [], fail: [] };
const startedAt = Date.now();

function logPass(name, detail) {
  results.pass.push({ name, detail });
  console.log(`  ✅ ${name}${detail ? '  ' + detail : ''}`);
}
function logFail(name, detail) {
  results.fail.push({ name, detail });
  console.log(`  ❌ ${name}  ${detail}`);
  if (FAIL_FAST) process.exit(1);
}

async function fetchText(path, opts = {}) {
  const url = path.startsWith('http') ? path : BASE + path;
  const res = await fetch(url, {
    redirect: 'follow',
    headers: { 'User-Agent': 'careerwiki-smoke-test/1.0' },
    ...opts,
  });
  const text = await res.text();
  return { status: res.status, headers: res.headers, text };
}

async function expectStatus(path, expected, label) {
  try {
    const r = await fetchText(path);
    const ok = Array.isArray(expected) ? expected.includes(r.status) : r.status === expected;
    if (ok) {
      logPass(label || path, `(${r.status})`);
    } else {
      logFail(label || path, `expected ${expected}, got ${r.status}`);
    }
    return r;
  } catch (e) {
    logFail(label || path, `fetch error: ${e.message}`);
    return null;
  }
}

async function expectContains(path, needles, label) {
  try {
    const r = await fetchText(path);
    if (r.status !== 200) {
      logFail(label || path, `status ${r.status} (expected 200)`);
      return;
    }
    const missing = needles.filter(n => !r.text.includes(n));
    if (missing.length === 0) {
      logPass(label || path, `contains ${needles.length} keywords`);
    } else {
      logFail(label || path, `missing keywords: ${missing.join(', ')}`);
    }
  } catch (e) {
    logFail(label || path, `error: ${e.message}`);
  }
}

async function run() {
  console.log(`\n🔥 Careerwiki Smoke Test`);
  console.log(`   base = ${BASE}`);
  console.log(`   ${new Date().toISOString()}\n`);

  // ── 1) 핵심 정책·도움말 페이지 (200 OK)
  console.log('[1] 핵심 정책·도움말 페이지');
  await expectStatus('/policy', 200, '/policy');
  await expectStatus('/policy/charter', 200, '/policy/charter');
  await expectStatus('/policy/community', 200, '/policy/community');
  await expectStatus('/policy/dispute', 200, '/policy/dispute');
  await expectStatus('/policy/enforcement', 200, '/policy/enforcement');
  await expectStatus('/policy/source-tier', 200, '/policy/source-tier');
  await expectStatus('/legal/terms', 200, '/legal/terms');
  await expectStatus('/legal/privacy', 200, '/legal/privacy');
  await expectStatus('/legal/notice', 200, '/legal/notice');
  await expectStatus('/help', 200, '/help');
  await expectStatus('/help/glossary', 200, '/help/glossary');
  await expectStatus('/about', 200, '/about');

  // ── 2) 핵심 콘텐츠 페이지
  console.log('\n[2] 핵심 콘텐츠 페이지');
  await expectStatus('/job/소프트웨어개발자', 200, '/job/소프트웨어개발자');
  await expectStatus('/major/컴퓨터공학과', 200, '/major/컴퓨터공학과');
  await expectStatus('/job', 200, '/job 목록');
  await expectStatus('/major', 200, '/major 목록');
  await expectStatus('/howto', 200, '/howto 목록');

  // ── 3) 관리자·사용자 게이트
  console.log('\n[3] 관리자·사용자 게이트 (인증 필요 → 401 또는 302 정상)');
  await expectStatus('/admin', [200, 302, 401], '/admin');
  await expectStatus('/admin/moderation', [200, 302, 401], '/admin/moderation');
  await expectStatus('/admin/sanctions', [200, 302, 401], '/admin/sanctions');
  await expectStatus('/admin/appeals', [200, 302, 401], '/admin/appeals');
  await expectStatus('/admin/admin-replies', [200, 302, 401], '/admin/admin-replies');
  await expectStatus('/admin/todo', [200, 302, 401], '/admin/todo');
  await expectStatus('/user/appeal', [200, 302, 401], '/user/appeal');
  await expectStatus('/onboarding', [200, 302, 401], '/onboarding');

  // ── 4) 가입 API dry-run (★ 이번 사고와 같은 회귀를 막는 가장 중요한 검사)
  // 비로그인 상태로 POST /api/onboarding을 호출 → 401 Unauthorized가 나와야 정상.
  // 만약 500이나 다른 에러가 나오면 백엔드 로직에 문제 있음.
  console.log('\n[4] 가입 API dry-run');
  try {
    const r = await fetchText('/api/onboarding', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        nickname: 'smoke_test_dummy',
        channel: { self_channel: 'search' },
        consents: [
          { type: 'terms', version: 'v1.0-2025-12-01' },
          { type: 'privacy', version: 'v1.0-2025-12-01' },
        ],
        age14_acknowledged: true,
      }),
    });
    // 비로그인 호출 → 401, success:false, 또는 로그인 페이지 HTML 응답 모두 OK.
    // 200 + success:true 만이 보안 문제.
    const isLoginPage = /로그인.*Careerwiki|<title>.*로그인.*<\/title>|class="login-page"/.test(r.text);
    if (r.status === 401) {
      logPass('POST /api/onboarding (비로그인)', '(401 Unauthorized)');
    } else if (r.status === 200 && isLoginPage) {
      logPass('POST /api/onboarding (비로그인)', '(requireAuth가 로그인 페이지로 전환 — OK)');
    } else if (r.status === 200) {
      let parsed = null;
      try { parsed = JSON.parse(r.text); } catch {}
      if (parsed && parsed.success === false) {
        logPass('POST /api/onboarding (비로그인)', `(success:false: "${parsed.error || 'no msg'}")`);
      } else if (parsed && parsed.success === true) {
        logFail('POST /api/onboarding (비로그인)', '★ 200 + success:true — 비로그인이 가입 가능! 보안 문제');
      } else {
        logFail('POST /api/onboarding (비로그인)', `200 + 알 수 없는 body: ${r.text.slice(0, 200)}`);
      }
    } else {
      logFail('POST /api/onboarding (비로그인)', `예상 외 status ${r.status}: ${r.text.slice(0, 200)}`);
    }

    // ★ 가장 중요한 검사: 로그인 + 정상 페이로드로 호출했을 때 "약관 버전" 류 에러가
    //   나오면 안 됨. 실제 가입 시도는 못하지만, validation 에러 메시지가 정상인지 확인.
    //   여기서 잡힐 만한 회귀: CONSENT_VERSIONS 키 누락, 백엔드 타입 검증 불일치 등.
    const validationOnly = await fetchText('/api/onboarding', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        nickname: 'a',
        channel: { self_channel: 'search' },
        consents: [
          { type: 'terms', version: 'wrong-version' },
          { type: 'privacy', version: 'wrong-version' },
        ],
        age14_acknowledged: true,
      }),
    });
    let parsed2 = null;
    try { parsed2 = JSON.parse(validationOnly.text); } catch {}
    const isLogin2 = /로그인.*Careerwiki|<title>.*로그인.*<\/title>/.test(validationOnly.text);
    if (parsed2 && parsed2.error && /약관 버전/.test(parsed2.error)) {
      logPass('가입 검증 응답', '(잘못된 약관 버전을 정상 거부)');
    } else if (parsed2 && parsed2.error === 'Unauthorized') {
      logPass('가입 검증 응답', '(인증이 먼저 차단 — OK)');
    } else if (isLogin2) {
      logPass('가입 검증 응답', '(requireAuth 차단 — OK, 인증된 호출 검증은 별도 통합 테스트 필요)');
    } else {
      logFail('가입 검증 응답', `예상 외: ${(validationOnly.text || '').slice(0, 200)}`);
    }
  } catch (e) {
    logFail('POST /api/onboarding', `fetch error: ${e.message}`);
  }

  // ── 5) 댓글 API 응답 형식
  console.log('\n[5] 댓글 API 응답 형식');
  try {
    const r = await fetchText('/api/comments?entityType=job&slug=' + encodeURIComponent('소프트웨어개발자') + '&limit=1');
    if (r.status === 200) {
      try {
        const data = JSON.parse(r.text);
        if (data && (Array.isArray(data.data) || Array.isArray(data.items))) {
          logPass('/api/comments', '(JSON 형식 OK)');
        } else {
          logFail('/api/comments', '응답에 data/items 배열 없음');
        }
      } catch {
        logFail('/api/comments', 'JSON parse 실패');
      }
    } else {
      logFail('/api/comments', `status ${r.status}`);
    }
  } catch (e) {
    logFail('/api/comments', `error: ${e.message}`);
  }

  // ── 6) 정책 페이지 핵심 키워드 (배포 직후 콘텐츠 누락 감지)
  console.log('\n[6] 정책 페이지 핵심 키워드 검증');
  await expectContains('/policy/charter', ['CC BY 4.0', '광고·후원 정책'], 'charter 키워드');
  await expectContains('/policy/dispute', ['이의 제기 품질 룰', '다수결'], 'dispute 키워드');
  await expectContains('/policy/community', ['단순 가입제', '자살예방상담'], 'community 키워드');

  // ── 결과 요약
  const elapsed = ((Date.now() - startedAt) / 1000).toFixed(1);
  console.log(`\n${'─'.repeat(60)}`);
  console.log(`📊 결과: ✅ ${results.pass.length} pass  ❌ ${results.fail.length} fail  (${elapsed}s)`);

  if (results.fail.length > 0) {
    console.log(`\n실패 항목:`);
    for (const f of results.fail) {
      console.log(`  ❌ ${f.name}  ${f.detail}`);
    }
    console.log('');
    process.exit(1);
  }
  console.log(`\n✨ 모두 통과\n`);
  process.exit(0);
}

run().catch(e => {
  console.error('\n💥 smoke-test 자체가 죽음:', e);
  process.exit(2);
});
