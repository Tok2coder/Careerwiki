#!/usr/bin/env node
/**
 * 직업 데이터 품질 검토 스크립트 (랜덤 20개)
 *
 * 실제 JSON 구조:
 *   json.wlb: string (e.g. "매우좋음", "보통미만")
 *   json.social: string (e.g. "좋음")
 *   json.wlbDetail: string | undefined (equalize 배치로 추가된 상세 설명)
 *   json.socialDetail: string | undefined (equalize 배치로 추가된 상세 설명)
 *   json.sidebarJobs: string[] (관련 직업 목록)
 *   json.sources: string[] (데이터 출처)
 */

import { execSync } from 'child_process';
import { writeFileSync } from 'fs';
import { join } from 'path';

const BASE_DIR = 'C:\\Users\\PC\\Careerwiki';

const SLUGS = [
  '푸드스타일리스트', '웹디자이너', '유치원교사', '작가', '방송송출장비기사',
  '조향사', '자동차정비원', '주입포장상표부착기계조작원', '항공기정비원', '인력파견관리자',
  '패션소품디자이너', '보건의료관리자', '계기검침원-및-가스점검원', '바리스타', '여행상품개발자',
  '행정부고위공무원', '점토제품생산기계조작원', '농업용-및-기타기계장비설치-및-정비원',
  '유리유리제품생산기계조작원', '철도전동차기관사'
];

// 조사
const EXPLICIT_JOSA = ['이', '가', '을', '를', '은', '는', '의', '에', '와', '과', '로', '으로', '도', '만', '에서', '이고', '이며', '이나'];

// ─── 체크 함수들 ───────────────────────────────────────────────

function checkFootnoteInField(fieldText) {
  /**
   * 단일 텍스트 필드 내에서 각주가 [1]부터 순차적인지 확인
   */
  if (!fieldText || typeof fieldText !== 'string') return null;
  const matches = [...fieldText.matchAll(/\[(\d+)\]/g)].map(m => parseInt(m[1]));
  if (matches.length === 0) return null;
  const unique = [...new Set(matches)].sort((a, b) => a - b);
  if (unique[0] !== 1) return `첫각주[${unique[0]}]`;
  for (let i = 0; i < unique.length; i++) {
    if (unique[i] !== i + 1) return `[${i+1}]누락`;
  }
  return null; // OK
}

function checkFootnoteOrder(json) {
  /**
   * 주요 텍스트 필드들에서 각주 순서 체크
   */
  const fieldsToCheck = [
    json.overviewProspect?.main,
    json.summary,
    json.way,
    json.salary,
    json.prospect,
    ...(json.overviewProspect?.forecastList || []).map(f => f.forecast),
  ];

  const errors = [];
  for (const field of fieldsToCheck) {
    if (!field) continue;
    const err = checkFootnoteInField(typeof field === 'string' ? field : JSON.stringify(field));
    if (err) errors.push(err);
  }

  // 전체 JSON에서 동일 필드 번호 중복이 아닌, 여러 별도 필드에서 각각 [1] 사용은 허용
  if (errors.length > 0) return { ok: false, note: errors.join(' | ') };
  return { ok: true, note: '순서OK' };
}

function checkMarkdownRemnants(json) {
  /**
   * 서술 텍스트 필드에 **볼드** 마크다운이 잔류하는지 확인
   * overviewProspect.main의 전망 등급 볼드(현상태 유지 등)는 허용
   */
  // 검사할 필드들
  const fieldsToCheck = [
    { name: 'overviewProspect.main', val: json.overviewProspect?.main },
    { name: 'way', val: json.way },
    { name: 'salary', val: json.salary },
    { name: 'prospect', val: json.prospect },
    { name: 'summary', val: json.summary },
    { name: 'duties', val: json.duties },
  ];

  const ALLOWED_BOLD = ['현상태 유지', '다소 증가', '다소 감소', '증가', '감소', '현 상태 유지', '다소 줄어'];
  const problems = [];

  for (const { name, val } of fieldsToCheck) {
    if (!val || typeof val !== 'string') continue;
    const boldMatches = val.match(/\*\*[^*]+\*\*/g);
    if (!boldMatches) continue;
    const bad = boldMatches.filter(m => !ALLOWED_BOLD.some(kw => m.includes(kw)));
    if (bad.length > 0) problems.push(`${name}: ${bad.slice(0, 2).join(', ')}`);
  }

  if (problems.length > 0) return { ok: false, note: problems.slice(0, 2).join(' / ') };
  return { ok: true, note: '없음' };
}

function checkHeroTags(tags) {
  if (!tags || tags.length === 0) return { ok: false, note: '태그없음' };
  const bad = [];
  for (const tag of tags) {
    for (const j of EXPLICIT_JOSA) {
      if (tag.endsWith(j) && tag.length > j.length + 1) {
        bad.push(`"${tag}"`);
        break;
      }
    }
  }
  if (bad.length > 0) return { ok: false, note: `조사태그: ${bad.join(', ')}` };
  return { ok: true, note: tags.slice(0, 3).join(', ') };
}

function checkWlbSocial(json) {
  /**
   * json.wlb: 문자열 등급 (필수)
   * json.social: 문자열 등급 (필수)
   * json.wlbDetail: 상세 설명 (equalize 보완, 있으면 200자 이내 확인)
   * json.socialDetail: 상세 설명 (equalize 보완, 있으면 200자 이내 확인)
   */
  const issues = [];

  if (!json.wlb) issues.push('wlb등급없음');
  if (!json.social) issues.push('social등급없음');

  const wlbDetail = json.wlbDetail;
  if (wlbDetail && wlbDetail.length > 200) issues.push(`wlbDetail ${wlbDetail.length}자>200`);

  const socialDetail = json.socialDetail;
  if (socialDetail && socialDetail.length > 200) issues.push(`socialDetail ${socialDetail.length}자>200`);

  if (issues.length > 0) return { ok: false, note: issues.join('|') };

  const wlbStr = `wlb:${json.wlb}(${wlbDetail ? wlbDetail.length+'자' : '미보완'}) social:${json.social}(${socialDetail ? socialDetail.length+'자' : '미보완'})`;
  return { ok: true, note: wlbStr };
}

function checkSidebarJobs(json) {
  const sidebar = json.sidebarJobs;
  if (!sidebar || !Array.isArray(sidebar)) return { ok: false, note: 'sidebar없음' };
  const count = sidebar.length;
  if (count < 7) return { ok: false, note: `${count}개<7` };
  if (count > 12) return { ok: false, note: `${count}개>12` };
  return { ok: true, note: `${count}개` };
}

function checkSources(json) {
  /**
   * 두 가지 체크:
   * 1. sources 배열에 데이터 출처가 있는가
   * 2. 서술 텍스트에 "(자료:" 형태의 인라인 출처가 있는가
   */
  const hasSourceArray = json.sources && json.sources.length > 0;
  const str = JSON.stringify(json);
  const hasInlineSource = str.includes('자료:') || str.includes('출처:');
  const hasFootnote = /\[\d+\]/.test(str);

  if (!hasSourceArray && !hasInlineSource && !hasFootnote) {
    return { ok: false, note: '소스배열없음+인라인출처없음' };
  }

  if (!hasSourceArray) return { ok: false, note: 'sources배열없음' };

  return {
    ok: true,
    note: `${json.sources.join(',')}${hasInlineSource ? ' +인라인' : ''}`
  };
}

function checkYoutube(json) {
  const relVideoList = json.relVideoList;
  if (!relVideoList || relVideoList.length === 0) return { ok: 'N/A', note: 'YouTube없음' };
  return { ok: true, note: `${relVideoList.length}개` };
}

// ─── 메인 ────────────────────────────────────────────────────────

async function main() {
  console.log('=== 직업 데이터 품질 검토 (20개 샘플) ===\n');

  const results = [];

  for (const slug of SLUGS) {
    const escapedSlug = slug.replace(/'/g, "''");
    const sql = `SELECT name, merged_profile_json FROM jobs WHERE slug = '${escapedSlug}' AND is_active = 1 LIMIT 1;`;

    try {
      const raw = execSync(
        `npx wrangler d1 execute careerwiki-kr --remote --command "${sql.replace(/"/g, '\\"')}"`,
        { encoding: 'utf8', timeout: 30000, cwd: BASE_DIR }
      );

      const jsonStart = raw.indexOf('[');
      if (jsonStart === -1) {
        results.push({ name: slug, slug, error: 'DB 응답 없음' });
        process.stdout.write('E');
        continue;
      }
      const parsed = JSON.parse(raw.substring(jsonStart));
      const row = parsed[0]?.results?.[0];
      if (!row) {
        results.push({ name: slug, slug, error: '데이터 없음' });
        process.stdout.write('E');
        continue;
      }

      const name = row.name;
      const json = JSON.parse(row.merged_profile_json);

      const checks = {
        name,
        slug,
        footnote: checkFootnoteOrder(json),
        wlbSocial: checkWlbSocial(json),
        sidebarJobs: checkSidebarJobs(json),
        heroTags: checkHeroTags(json.heroTags),
        markdown: checkMarkdownRemnants(json),
        sources: checkSources(json),
        youtube: checkYoutube(json),
        // 추가 디버그 정보
        _debug: {
          wlb: json.wlb,
          social: json.social,
          wlbDetailLen: json.wlbDetail?.length,
          socialDetailLen: json.socialDetail?.length,
          sidebarCount: Array.isArray(json.sidebarJobs) ? json.sidebarJobs.length : 0,
        }
      };

      results.push(checks);
      process.stdout.write('.');
    } catch (e) {
      results.push({ name: slug, slug, error: e.message.substring(0, 150) });
      process.stdout.write('E');
    }
  }

  console.log('\n\n=== 결과 표 ===\n');

  const PASS = '✅';
  const FAIL = '❌';
  const NA = '➖';

  console.log('| # | 직업 | 각주 | WLB/Social등급 | wlbDetail/socialDetail | sidebar | heroTags | 마크다운 | 출처 | YouTube |');
  console.log('|---|------|------|--------------|----------------------|---------|---------|---------|------|---------|');

  let totalPass = 0;
  let totalChecks = 0;
  const failReasons = {};

  results.forEach((r, i) => {
    if (r.error) {
      console.log(`| ${i+1} | ${r.name || r.slug} | ❌ 오류 | | | | | | | |`);
      return;
    }

    const fn = r.footnote.ok ? PASS : FAIL;
    const wlbRating = (r._debug.wlb && r._debug.social) ? PASS : FAIL;
    const wlbDetail = (() => {
      if (r._debug.wlbDetailLen === undefined) return '➖미보완';
      if (r._debug.wlbDetailLen > 200) return `❌${r._debug.wlbDetailLen}자`;
      return `✅${r._debug.wlbDetailLen}자`;
    })();
    const sb = r.sidebarJobs.ok ? `✅${r._debug.sidebarCount}개` : `❌${r.sidebarJobs.note}`;
    const ht = r.heroTags.ok ? PASS : FAIL;
    const md = r.markdown.ok ? PASS : FAIL;
    const src = r.sources.ok ? PASS : FAIL;
    const yt = r.youtube.ok === 'N/A' ? NA : (r.youtube.ok ? `✅${r.youtube.note}` : FAIL);

    console.log(`| ${i+1} | ${r.name} | ${fn} | ${wlbRating} (${r._debug.wlb}/${r._debug.social}) | ${wlbDetail} | ${sb} | ${ht} | ${md} | ${src} | ${yt} |`);

    // 통계 계산 (wlb rating, wlb detail은 별도 카운트)
    const checkItems = [r.footnote, r.heroTags, r.markdown, r.sources];
    checkItems.forEach(c => {
      totalChecks++;
      if (c.ok) totalPass++;
    });

    // sidebar도 카운트
    totalChecks++;
    if (r.sidebarJobs.ok) totalPass++;

    if (!r.footnote.ok) failReasons['각주순서'] = (failReasons['각주순서'] || 0) + 1;
    if (!r.sidebarJobs.ok) failReasons['sidebarJobs'] = (failReasons['sidebarJobs'] || 0) + 1;
    if (!r.heroTags.ok) failReasons['heroTags'] = (failReasons['heroTags'] || 0) + 1;
    if (!r.markdown.ok) failReasons['마크다운잔류'] = (failReasons['마크다운잔류'] || 0) + 1;
    if (!r.sources.ok) failReasons['출처없음'] = (failReasons['출처없음'] || 0) + 1;
    if (r._debug.wlbDetailLen === undefined) failReasons['wlbDetail미보완'] = (failReasons['wlbDetail미보완'] || 0) + 1;
    if (r._debug.wlbDetailLen > 200) failReasons['wlbDetail길이초과'] = (failReasons['wlbDetail길이초과'] || 0) + 1;
    if (r._debug.socialDetailLen > 200) failReasons['socialDetail길이초과'] = (failReasons['socialDetail길이초과'] || 0) + 1;
  });

  console.log('\n=== 상세 FAIL 내역 ===\n');
  results.forEach((r, i) => {
    if (r.error) return;
    const fails = [];
    if (!r.footnote.ok) fails.push(`각주: ${r.footnote.note}`);
    if (!r.sidebarJobs.ok) fails.push(`sidebar: ${r.sidebarJobs.note}`);
    if (!r.heroTags.ok) fails.push(`heroTags: ${r.heroTags.note}`);
    if (!r.markdown.ok) fails.push(`마크다운: ${r.markdown.note}`);
    if (!r.sources.ok) fails.push(`출처: ${r.sources.note}`);
    if (r._debug.wlbDetailLen === undefined) fails.push(`wlbDetail: 미보완`);
    if (r._debug.socialDetailLen === undefined) fails.push(`socialDetail: 미보완`);
    if (fails.length > 0) {
      console.log(`${i+1}. ${r.name}: ${fails.join(' / ')}`);
    }
  });

  console.log(`\n=== 통계 ===`);
  console.log(`핵심 항목 PASS율 (각주+sidebar+heroTags+마크다운+출처): ${totalPass}/${totalChecks} = ${totalChecks > 0 ? Math.round(totalPass/totalChecks*100) : 0}%`);
  const wlbDetailMissing = results.filter(r => !r.error && r._debug.wlbDetailLen === undefined).length;
  console.log(`wlb/social 등급 존재: ${results.filter(r => !r.error && r._debug.wlb && r._debug.social).length}/20`);
  console.log(`wlbDetail 보완 완료: ${results.filter(r => !r.error && r._debug.wlbDetailLen !== undefined).length}/20`);
  console.log(`\n문제 유형별 빈도:`);
  Object.entries(failReasons).sort((a, b) => b[1] - a[1]).forEach(([k, v]) => {
    console.log(`  ${k}: ${v}개`);
  });

  const outPath = join(BASE_DIR, 'scripts', 'quality-check-result.json');
  writeFileSync(outPath, JSON.stringify(results, null, 2));
  console.log(`\n결과 저장: ${outPath}`);
}

main().catch(console.error);
