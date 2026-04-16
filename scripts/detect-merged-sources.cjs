#!/usr/bin/env node
/**
 * detect-merged-sources.cjs
 *
 * 출처 병합 패턴 탐지 스크립트.
 * UCJ _sources 배열에서 한 항목에 여러 기관명이 묶여있고
 * URL은 하나만 달린 패턴을 탐지한다.
 *
 * Usage:
 *   node scripts/detect-merged-sources.cjs
 *   node scripts/detect-merged-sources.cjs --limit=200
 *   node scripts/detect-merged-sources.cjs --json   (JSON 출력)
 *
 * Dry-run only: DB 수정 없음
 *
 * ── 역할 분담 ────────────────────────────────────────────────────────────────
 * 이 스크립트는 DB 전체 직업을 대상으로 하는 **정기 점검용 bulk 탐지** 도구다.
 * 저장 전·후 per-job 검증은 아래 도구가 담당 (동일 v3 로직 내장):
 *   - validate-job-edit.cjs  → 저장 전  WARN [출처병합경고]
 *   - full-quality-audit.cjs → 저장 후  WARN [Gate5/출처병합]
 * 세 도구의 탐지 알고리즘(separator-split + FP_SUFFIXES + ORG_NAME_PAT)은 동일하다.
 */

'use strict';

const { execSync } = require('child_process');
const path = require('path');

const DB_NAME = 'careerwiki-kr';
const ROOT_DIR = path.resolve(__dirname, '..');

// ── 병합 키워드 패턴 ─────────────────────────────────────────────────────────
// source.text에서 [N] 번호 이후 "기관A 및 기관B" 형태 탐지
// 조건: 병합 키워드 포함 + 기관명 후보 2개 이상 + URL 1개
const MERGE_KEYWORDS = [
  /및\s/,           // "및 " (공백 필수 — 조사 "및하여" 제외)
  /또는\s/,         // "또는 "
  /\s과\s/,         // " 과 " (공백 양쪽 — "교육과정" 등 복합어 제외)
  /\s와\s/,         // " 와 "
  /\s·\s/,          // " · " (가운뎃점 공백 동반)
  /(?<!https?:)\/(?!\/)/,  // "/" (URL 아닌 것만)
];

// false positive 줄이기: 이 패턴이 text에 있으면 기관 병합이 아닌 정상 케이스
const SAFE_PATTERNS = [
  /^\[\d+\]\s*[가-힣A-Za-z]+$/,  // 기관명 단일 (한글/영문만)
  /통계청/,                       // "통계청 KOSIS" 같은 단일 기관 영문 부제
];

// ── D1 쿼리 헬퍼 ────────────────────────────────────────────────────────────

function queryD1(sql) {
  const escaped = sql.replace(/"/g, '\\"');
  try {
    const raw = execSync(
      `npx wrangler d1 execute ${DB_NAME} --remote --command "${escaped}"`,
      { encoding: 'utf8', timeout: 120000, maxBuffer: 100 * 1024 * 1024, cwd: ROOT_DIR }
    );
    const jsonStart = raw.indexOf('[');
    if (jsonStart === -1) throw new Error(`JSON 없음: ${raw.substring(0, 200)}`);
    const parsed = JSON.parse(raw.substring(jsonStart));
    return parsed[0]?.results || [];
  } catch (e) {
    throw new Error(`D1 실패: ${e.message.substring(0, 300)}`);
  }
}

// ── 병합 탐지 코어 ──────────────────────────────────────────────────────────

/**
 * source 하나를 검사해서 병합 의심 여부와 이유를 반환.
 *
 * 탐지 원칙: "기관A 및 기관B" 구조만 HIGH — 즉, "및/또는/와/과" 앞뒤로
 * 독립적인 기관/사이트명이 2개 이상 나열된 경우.
 * 제목/직업명 내 "및"(예: "학원강사 및 학습지교사 직업전망")은 제외.
 *
 * 핵심 구별 기준:
 * - "기관 - 타이틀" 형식에서 기관명 부분(대시 앞)에만 "및" 있으면 True Positive
 * - 타이틀 부분(대시 뒤)에만 "및" 있으면 False Positive (문서 제목 내 및)
 *
 * @returns {null | {reason: string, confidence: 'HIGH'|'MED'}}
 */
function detectMerge(src) {
  if (!src || typeof src !== 'object') return null;
  const text = (src.text || '').trim();
  const url  = (src.url  || '').trim();

  if (!text || !url) return null;

  // [N] 뒤의 실제 기관명 부분만 추출
  const label = text.replace(/^\[\d+\]\s*/, '');

  // 기관명 구분자(—, -, :) 앞/뒤 분리
  // 형식: "[N] 기관명 — 문서제목" or "[N] 기관명 - 문서제목"
  const SEPARATOR = /\s[—\-–:]\s/;
  const sepMatch = label.match(SEPARATOR);

  let orgPart   = label;   // 기관명 부분
  let titlePart = '';       // 문서제목 부분

  if (sepMatch) {
    const sepIdx = label.indexOf(sepMatch[0]);
    orgPart   = label.substring(0, sepIdx).trim();
    titlePart = label.substring(sepIdx + sepMatch[0].length).trim();
  }

  // ── 패턴 A: 기관명 부분에 "기관A 및 기관B" (True Positive 핵심) ──
  // 예: "HRD-Net 및 한국카지노업관광협회", "잡코리아 및 사람인"
  // 구분: 기관명 구분자(—)가 없거나, 구분자 앞(orgPart)에 "및" 포함
  const ORG_MERGE_PAT = /([가-힣A-Za-z0-9\-\.]+)\s+(및|또는|와|과)\s+([가-힣A-Za-z0-9\-\.]+)/;
  const orgMergeMatch = ORG_MERGE_PAT.exec(orgPart);

  if (orgMergeMatch) {
    // 양쪽 기관명 후보 길이 검증: 최소 2자 이상이어야 기관명
    const left  = orgMergeMatch[1].trim();
    const right = orgMergeMatch[3].trim();
    if (left.length >= 2 && right.length >= 2) {
      // ── False positive 필터 ──
      // 1) "및" 이후가 단순 명사(현황, 전망, 안내, 운영, 구성 등)이면 문서제목 내 "및" → 패스
      const FP_SUFFIXES = /^(현황|전망|안내|운영|구성|기사|정보|내용|일정|과정|분석|결과|현황과|주요현황|지원|활동|방법|기준|규정|조직법|월급|조직|현황과|구성원|법령|데이터|서비스|제도|관리|방안|역할|교육|훈련|채용|공고|자격|사항|기준|영향|현황및|전망및)/.test(right);
      if (FP_SUFFIXES) return null;

      // 2) 기관명이 구분자(—,-,:) 없이 혼재된 경우 — text 전체가 짧고 기관명 패턴 없으면 패스
      //    진짜 병합: "HRD-Net 및 한국카지노업관광협회" (left=HRD-Net, right=한국카지노업관광협회)
      //    각 기관명 후보가 사이트명·협회명 패턴인지 확인
      const ORG_NAME_PAT = /넷|Net|관|원|사|청|부|처|협회|재단|연구원|센터|포럼|클럽|학회|공단|공사|진흥|기관|회사|법인|서비스|시스템|플랫폼|아카데미|클리닉|인스티튜트|커뮤니티|랩|Lab|Hub|Go|고|처|청|부/;
      const leftIsOrg  = ORG_NAME_PAT.test(left)  || /[A-Z]/.test(left[0]);
      const rightIsOrg = ORG_NAME_PAT.test(right) || /[A-Z]/.test(right[0]);

      if (!leftIsOrg && !rightIsOrg) return null;

      let urlDomain = '';
      try { urlDomain = new URL(url).hostname.replace('www.', ''); } catch { return null; }
      return {
        reason: `기관명 부분에 병합: "${orgPart}" → "${left}" + "${right}", URL: ${urlDomain}`,
        confidence: 'HIGH',
        parts: [left, right],
        urlDomain,
      };
    }
  }

  // ── 패턴 B: 구분자 없이 전체 label에 "/" (URL 아닌 슬래시) ──
  // 예: "바이오/제약 분야 직무 맵" → False positive 많으므로 MED
  if (!sepMatch && /(?<!https?:)\/(?!\/)/.test(label)) {
    const slashParts = label.split('/').map(s => s.trim()).filter(s => s.length > 1);
    if (slashParts.length >= 2 && slashParts.every(p => p.length >= 3)) {
      let urlDomain = '';
      try { urlDomain = new URL(url).hostname.replace('www.', ''); } catch { return null; }
      // 슬래시 분리 양쪽이 둘 다 한글 명사면 MED
      const isKorean = slashParts.every(p => /[가-힣]/.test(p));
      if (isKorean) {
        return {
          reason: `슬래시 분리 의심: "${label}", URL: ${urlDomain}`,
          confidence: 'MED',
          parts: slashParts,
          urlDomain,
        };
      }
    }
  }

  return null;
}

// ── 메인 ───────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  const limitArg = args.find(a => a.startsWith('--limit='));
  const limit = limitArg ? parseInt(limitArg.split('=')[1]) : 500;
  const jsonOutput = args.includes('--json');

  console.error(`\n🔍 출처 병합 패턴 탐지 시작 (최대 ${limit}개 직업)\n`);

  const jobs = queryD1(
    `SELECT id, name, slug, user_contributed_json FROM jobs ` +
    `WHERE is_active=1 AND user_contributed_json IS NOT NULL ` +
    `AND user_contributed_json LIKE '%_sources%' ` +
    `ORDER BY user_last_updated_at DESC LIMIT ${limit}`
  );

  console.error(`총 ${jobs.length}개 직업 검사 중...\n`);

  const findings = [];
  let jobsChecked = 0;

  for (const job of jobs) {
    let ucj;
    try { ucj = JSON.parse(job.user_contributed_json); } catch { continue; }
    const sources = ucj._sources;
    if (!sources || typeof sources !== 'object') continue;

    jobsChecked++;

    for (const [fieldKey, srcArr] of Object.entries(sources)) {
      if (!Array.isArray(srcArr)) continue;
      for (let i = 0; i < srcArr.length; i++) {
        const result = detectMerge(srcArr[i]);
        if (!result) continue;
        findings.push({
          jobName: job.name,
          jobSlug: job.slug,
          jobId: job.id,
          fieldKey,
          srcIndex: i,
          srcText: (srcArr[i].text || '').substring(0, 80),
          srcUrl: srcArr[i].url || '',
          confidence: result.confidence,
          reason: result.reason,
          parts: result.parts,
          urlDomain: result.urlDomain,
        });
      }
    }
  }

  // ── 결과 출력 ─────────────────────────────────────────────────────────────

  if (jsonOutput) {
    console.log(JSON.stringify(findings, null, 2));
    return;
  }

  const high = findings.filter(f => f.confidence === 'HIGH');
  const med  = findings.filter(f => f.confidence === 'MED');

  console.log(`\n${'═'.repeat(70)}`);
  console.log(`탐지 결과: 총 ${findings.length}건 의심`);
  console.log(`  🔴 HIGH (확실한 병합): ${high.length}건`);
  console.log(`  🟡 MED  (가능성 있음): ${med.length}건`);
  console.log(`  검사 직업 수: ${jobsChecked}개`);
  console.log(`${'═'.repeat(70)}\n`);

  if (findings.length === 0) {
    console.log('✅ 병합 패턴 없음\n');
    return;
  }

  // HIGH 먼저 출력
  if (high.length > 0) {
    console.log('🔴 HIGH confidence (분리 필요):');
    console.log('─'.repeat(70));
    for (const f of high) {
      console.log(`  직업: ${f.jobName} (${f.jobSlug})`);
      console.log(`  필드: _sources["${f.fieldKey}"][${f.srcIndex}]`);
      console.log(`  text: ${f.srcText}`);
      console.log(`  url : ${f.srcUrl}`);
      console.log(`  분석: ${f.reason}`);
      console.log();
    }
  }

  // MED 출력
  if (med.length > 0) {
    console.log('🟡 MED confidence (확인 필요):');
    console.log('─'.repeat(70));
    for (const f of med.slice(0, 20)) {  // MED는 20개까지만
      console.log(`  직업: ${f.jobName} / 필드: ${f.fieldKey}[${f.srcIndex}]`);
      console.log(`  text: ${f.srcText}`);
      console.log(`  url : ${f.urlDomain}`);
      console.log();
    }
    if (med.length > 20) console.log(`  ... 외 ${med.length - 20}건\n`);
  }

  // CSV 요약
  console.log('\n📋 CSV (jobName,field,srcIndex,confidence,text):');
  console.log('jobName,fieldKey,srcIndex,confidence,srcText');
  for (const f of findings) {
    const text = `"${f.srcText.replace(/"/g, '""')}"`;
    console.log(`"${f.jobName}","${f.fieldKey}",${f.srcIndex},${f.confidence},${text}`);
  }
}

main();
