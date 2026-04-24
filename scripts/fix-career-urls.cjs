/**
 * career.go.kr 구 URL → 신규 URL 교체 스크립트
 *
 * 구 URL: https://www.career.go.kr/cnet/front/base/job/jobView.do?SEQ=XXX
 *         https://www.career.go.kr/cnet/front/base/job/jobList.do
 * 신규 URL: https://www.career.go.kr/cloud/w/job/view?seq={job_cd}
 *          https://www.career.go.kr/cloud/w/search/intro?text={직업명} (jobList.do 대체)
 *
 * 매핑 전략:
 * 1. slug → 직업명 → career-mapping.json nm 매칭 → job_cd → 신규 URL
 * 2. 매칭 실패 시 → 검색 URL 사용
 */

'use strict';

const fs = require('fs');

// ─────────────────────────────────────────────
// 설정
// ─────────────────────────────────────────────
const MAPPING_FILE = './career-mapping.json';
const AFFECTED_FILE = './affected-jobs.json';
const OUTPUT_FILE = './career-url-fixes.json';
const DRY_RUN = process.argv.includes('--dry-run');
const VERBOSE = process.argv.includes('--verbose');

const ADMIN_SECRET = 'careerwiki-admin-2026';
const BASE_API = 'https://careerwiki.org/api/job';

// ─────────────────────────────────────────────
// 로드
// ─────────────────────────────────────────────
const mapping = JSON.parse(fs.readFileSync(MAPPING_FILE, 'utf8'));
const affectedJobs = JSON.parse(fs.readFileSync(AFFECTED_FILE, 'utf8'));

// job_cd 기반 룩업 맵 (정규화된 이름 → job_cd)
function normalize(nm) {
  return nm
    .replace(/[ㆍ·•]/g, '·')
    .replace(/\s+/g, ' ')
    .trim()
    .toLowerCase();
}

// partial 매칭에서 검색 URL로 강제 전환할 직업명 목록 (정규화된 이름)
const FORCE_SEARCH_SLUGS = new Set([
  '각색작가',
  '심리상담전문가',
  '시스템 엔지니어',
  '경찰소방교도관리자',
  '광고홍보마케팅전문가',
  '제품광고영업원',
  '건축목공',
  '자동차부품조립검사원',
]);

const nmToCode = new Map();
for (const j of mapping) {
  nmToCode.set(normalize(j.nm), j.cd);
  // rel_job_nm이 있으면 추가 매핑
  if (j.rel) {
    for (const rel of j.rel.split(',').map(s => s.trim())) {
      if (rel) nmToCode.set(normalize(rel), j.cd);
    }
  }
}

// slug → 직업명 추출
function slugToName(slug) {
  return decodeURIComponent(slug)
    .replace(/-/g, ' ')
    .trim();
}

// 직업명 → job_cd 매칭
function findJobCd(jobName) {
  const norm = normalize(jobName);

  // 강제 검색 URL 목록에 있으면 null 반환 (fallback_search로 처리)
  if (FORCE_SEARCH_SLUGS.has(norm)) return null;

  // 1. 완전 일치
  if (nmToCode.has(norm)) return { cd: nmToCode.get(norm), method: 'exact' };

  // 2. 부분 일치 (직업명이 매핑에 포함)
  for (const [key, cd] of nmToCode) {
    if (key === norm) continue;
    if (key.includes(norm) || norm.includes(key)) {
      return { cd, method: 'partial', matched: key };
    }
  }

  // 3. 단어 교집합 기반 (2글자 이상 단어)
  const words = norm.split(/[\s·]+/).filter(w => w.length >= 2);
  let bestScore = 0, bestCd = null, bestKey = null;
  for (const [key, cd] of nmToCode) {
    const keyWords = key.split(/[\s·]+/).filter(w => w.length >= 2);
    const common = words.filter(w => keyWords.includes(w)).length;
    const score = common / Math.max(words.length, keyWords.length);
    if (score > bestScore && score >= 0.6) {
      bestScore = score;
      bestCd = cd;
      bestKey = key;
    }
  }
  if (bestCd) return { cd: bestCd, method: 'fuzzy', matched: bestKey, score: bestScore };

  return null;
}

// URL 교체 함수
function fixSourcesUrls(sources, jobName) {
  let changed = false;
  const log = [];

  for (const [field, refs] of Object.entries(sources)) {
    if (!Array.isArray(refs)) continue;

    for (const ref of refs) {
      if (!ref.url) continue;

      const oldUrl = ref.url;

      // 구 jobView.do?SEQ= URL
      if (oldUrl.includes('/cnet/front/base/job/jobView.do?SEQ=')) {
        // SEQ 번호로는 직접 변환 불가 → 직업명 매칭으로 job_cd 획득
        const match = findJobCd(jobName);
        if (match) {
          ref.url = `https://www.career.go.kr/cloud/w/job/view?seq=${match.cd}`;
          log.push({ field, old: oldUrl, new: ref.url, method: match.method });
          changed = true;
        } else {
          // 매칭 실패 → 검색 URL
          const encoded = encodeURIComponent(jobName);
          ref.url = `https://www.career.go.kr/cloud/w/search/intro?text=${encoded}`;
          log.push({ field, old: oldUrl, new: ref.url, method: 'fallback_search' });
          changed = true;
        }
        continue;
      }

      // 구 jobList.do URL (SEQ 없음)
      if (oldUrl.includes('/cnet/front/base/job/jobList.do')) {
        const match = findJobCd(jobName);
        if (match) {
          ref.url = `https://www.career.go.kr/cloud/w/job/view?seq=${match.cd}`;
          log.push({ field, old: oldUrl, new: ref.url, method: match.method + '_list' });
        } else {
          const encoded = encodeURIComponent(jobName);
          ref.url = `https://www.career.go.kr/cloud/w/search/intro?text=${encoded}`;
          log.push({ field, old: oldUrl, new: ref.url, method: 'fallback_search_list' });
        }
        changed = true;
        continue;
      }

      // 기타 /cnet/front/base/ URL (jobView.do, jobViewMore 등)
      if (oldUrl.includes('/cnet/front/base/')) {
        const match = findJobCd(jobName);
        if (match) {
          ref.url = `https://www.career.go.kr/cloud/w/job/view?seq=${match.cd}`;
          log.push({ field, old: oldUrl, new: ref.url, method: match.method + '_other' });
        } else {
          const encoded = encodeURIComponent(jobName);
          ref.url = `https://www.career.go.kr/cloud/w/search/intro?text=${encoded}`;
          log.push({ field, old: oldUrl, new: ref.url, method: 'fallback_search_other' });
        }
        changed = true;
      }
    }
  }

  return { changed, log };
}

// ─────────────────────────────────────────────
// API 호출
// ─────────────────────────────────────────────
async function patchJob(jobId, newSources) {
  const body = JSON.stringify({ fields: { _sources: newSources } });
  const res = await fetch(`${BASE_API}/${jobId}/edit`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Admin-Secret': ADMIN_SECRET,
    },
    body,
  });
  return res.json();
}

// ─────────────────────────────────────────────
// 메인
// ─────────────────────────────────────────────
async function main() {
  console.log(`\n${'='.repeat(60)}`);
  console.log(' career.go.kr URL 교체 스크립트');
  console.log(` 대상: ${affectedJobs.length}개 직업`);
  console.log(` 모드: ${DRY_RUN ? 'DRY-RUN (API 호출 없음)' : '실제 업데이트'}`);
  console.log('='.repeat(60));

  const results = [];
  let successCount = 0, skipCount = 0, errorCount = 0;
  const methodStats = {};

  for (const job of affectedJobs) {
    const jobName = slugToName(job.slug);
    let sources;
    try {
      sources = JSON.parse(job.sources);
    } catch {
      console.warn(`[SKIP] ${job.slug} - sources 파싱 오류`);
      skipCount++;
      continue;
    }

    const { changed, log } = fixSourcesUrls(sources, jobName);

    if (!changed) {
      skipCount++;
      continue;
    }

    // 통계
    for (const entry of log) {
      methodStats[entry.method] = (methodStats[entry.method] || 0) + 1;
    }

    if (VERBOSE) {
      console.log(`\n[${job.slug}]`);
      log.forEach(l => console.log(`  ${l.field}: ${l.old}\n    → ${l.new} (${l.method})`));
    }

    results.push({ id: job.id, slug: job.slug, jobName, log, newSources: sources });

    if (!DRY_RUN) {
      try {
        const apiRes = await patchJob(job.id, sources);
        if (apiRes.success) {
          successCount++;
          process.stdout.write('.');
        } else {
          console.error(`\n[ERROR] ${job.slug}: ${JSON.stringify(apiRes)}`);
          errorCount++;
        }
      } catch (e) {
        console.error(`\n[ERROR] ${job.slug}: ${e.message}`);
        errorCount++;
      }
    } else {
      successCount++;
    }
  }

  // 결과 저장
  fs.writeFileSync(OUTPUT_FILE, JSON.stringify(results, null, 2));

  console.log(`\n\n${'='.repeat(60)}`);
  console.log(' 완료 요약');
  console.log('='.repeat(60));
  console.log(`  수정 대상: ${results.length}개`);
  console.log(`  ${DRY_RUN ? '처리 예정' : '성공'}: ${successCount}개`);
  console.log(`  스킵: ${skipCount}개`);
  console.log(`  오류: ${errorCount}개`);
  console.log('\n  매칭 방법 통계:');
  Object.entries(methodStats).sort((a,b)=>b[1]-a[1]).forEach(([k,v]) => {
    console.log(`    ${k}: ${v}건`);
  });
  console.log(`\n  결과 파일: ${OUTPUT_FILE}`);
  console.log('='.repeat(60));
}

main().catch(console.error);
