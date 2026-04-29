#!/usr/bin/env node
// scripts/skill-cache/print-batch-prompts.cjs
// data/dispatch-batch-N.json 읽어서 5 세션 prompt 본문만 깔끔하게 출력.
//
// 사용:
//   node scripts/skill-cache/print-batch-prompts.cjs              (data/dispatch-batch-1.json)
//   node scripts/skill-cache/print-batch-prompts.cjs --batch=2

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.resolve(__dirname, '..', '..');
const args = process.argv.slice(2).reduce((acc, a) => {
  const m = a.match(/^--([^=]+)(?:=(.+))?$/);
  if (m) acc[m[1]] = m[2] ?? true;
  return acc;
}, {});
const BATCH = args.batch || '1';

const batchPath = path.join(REPO_ROOT, 'data', `dispatch-batch-${BATCH}.json`);
if (!fs.existsSync(batchPath)) {
  console.error(`파일 부재: ${batchPath}`);
  console.error('먼저 실행: node scripts/skill-cache/dispatch-next-25.cjs --cohort-priority --save-batch=' + BATCH);
  process.exit(2);
}
const d = JSON.parse(fs.readFileSync(batchPath, 'utf8'));

function careerTreeHint(cohort) {
  const map = {
    '의료/보건': '의대 교수·병원장·해외 의사 (정치인 전향자 회피)',
    'IT/SW': '국내외 SW 엔지니어·CTO·창업자 (예: 이해진, 김범수 등 검증 후)',
    '디자인/예술': '국내외 디자이너·예술인 (정치 활동 없는 인물)',
    '학자/연구': '학회 회장·정부출연연 원장·해외 석학',
    '미디어/방송': '기자·PD·작가 (방송 활동 우선)',
    '스포츠': '국가대표·올림픽 메달리스트·코치',
    '법조': '판사·변호사 (정치인 전향 인물 회피)',
    '금융': '은행장·증권사 임원·CFO·재무담당',
    '동물/반려': '수의사·동물 행동 전문가',
    '식음료/요식': '셰프·바리스타 챔피언·미슐랭 인증',
    '미용/뷰티': 'K-뷰티 아티스트·인플루언서 (검증된 직업 활동)',
    '관광/호텔': '호텔 대표·관광 명장·여행 인플루언서',
    '건축/건설': '건축가·시공 명장·문화재 수리 전문',
    '기계/정비': '기능 명장·정비 전문 인플루언서',
    '운송/물류': '운송업 임원·전문 드라이버',
    '농림수산': '농부·어부·임업인 (검증된 직업 활동)',
    '교육': '교사·교수·강사 (정치 활동 회피)',
  };
  return map[cohort] || '직업 도메인 인물 (역대 대통령 절대 제외, 다른 정치인은 직업 적합성 검토)';
}

const HOMONYM_NOTES = {
  '신부': '신부=Catholic priest (NOT bride)',
  '검사': '검사=prosecutor (NOT inspection/test)',
  '약사': '약사=pharmacist',
  '사육사': '사육사=animal trainer at zoo',
  '모델': '모델=runway model (NOT 3D model/schema)',
  '박사': '박사=PhD scholar (NOT medical doctor)',
  '강사': '강사=lecturer/instructor',
  '기사': '기사=technician/engineer/driver (NOT newspaper article)',
  '심판': '심판=sports referee (NOT courtroom judge)',
  '감독': '감독=film director or sports head coach',
  '간호사': '간호사 ↔ 간호조무사 ↔ 간호인 분리 직업',
  '수의사': '수의사 ↔ 수의사보조원 ↔ 수의테크니션 분리',
  '간판': '간판제작 vs 광고 디자인 분리',
};

const STANDARD_RULES = [
  '### 표준 룰 (필수 준수 — 모든 5 직업 공통, 풀 사이클 Phase 0~5)',
  '1. **Phase 0-PRE START_TRACKING** bash 직접 실행 — `data/skill-runs.jsonl` append 의무',
  '2. **Phase 0-DIAG**: `merged_profile_json` 기준 + `json_type` 분기 — text 형식은 `length()` 검사',
  '3. **Phase 1**: 17필드 draft 작성 (모든 누락 필드 보강 — way·trivia·sidebarOrgs/Certs·youtubeLinks·careerTree 등)',
  '4. **Phase 1-PRE**: `scripts/skill-cache/lookup.cjs --type=cert|org --names="..."` 먼저 (LLM WebFetch 전)',
  '5. **Phase 2**: `scripts/validate-job-edit.cjs` PASS 통과 후 편집 API 호출',
  '6. **Phase 3**: `POST https://careerwiki.org/api/job/{id}/edit` + 헤더 `X-Admin-Secret: careerwiki-admin-2026` (fields+sources 동시 전송)',
  '7. **Phase 4 검증**: Node.js fetch + `encodeURIComponent` (curl 한글 URL 절대 금지) + `full-quality-audit.cjs` PASS',
  '8. **Phase 5-DEDUP**: `scripts/skill-cache/auto-dedup-sweep.cjs --slug=<slug> --apply` END_TRACKING 전',
  '9. **Phase 5 끝 END_TRACKING** bash 직접 실행 + UCJ 17필드 self-report',
  '10. **[job-data-enhance] 마커 부착**: change_summary에 `[job-data-enhance]` 포함 — 사용자 KPI 게이트',
  '11. **[sal-수정금지]**: `overviewSalary` 절대 덮어쓰기 금지 (sal=NULL이면 보강 안 함)',
  '12. **homonym disambiguation**: SKILL.md RULE 0 12케이스 + `audit-image-prompts.cjs` 사전 점검',
  '13. **careerTree 정치인 제외**: 역대 대통령 절대, 다른 정치인은 직업 적합성 검토 후',
].join('\n');

d.sessions.forEach((sess, idx) => {
  console.log('');
  console.log(`=== 세션 ${idx + 1} prompt ===`);
  console.log('');
  console.log(`/job-data-enhance 다음 ${sess.items.length}개 직업 풀 사이클 (Phase 0~5) enhance 처리 (cohort: ${sess.cohort}).`);
  console.log('목표: [job-data-enhance] 마커 부착 + 17필드 보완 + admin "스킬 적용" 컬럼 ✓.');
  console.log('');
  sess.items.forEach((item) => {
    const url = 'https://careerwiki.org/job/' + item.slug;
    console.log(`### ${item.slug} (id=${item.id})`);
    console.log(`- URL: ${url}`);
    console.log(`- 카테고리: ${item._src} | sal: ${item.sal_status} | 참고 누락: ${item.missing_fields.join(', ')}`);
    if (item.missing_fields.includes('careerTree')) {
      console.log(`- careerTree 인물 권고: ${careerTreeHint(item.cohort)}`);
    }
    if (item.missing_fields.includes('sidebarOrgs') || item.missing_fields.includes('sidebarCerts')) {
      const types = [];
      if (item.missing_fields.includes('sidebarOrgs')) types.push('org');
      if (item.missing_fields.includes('sidebarCerts')) types.push('cert');
      console.log('- URL 룩업 권장: `node scripts/skill-cache/lookup.cjs --type=' + types.join('|') + ' --names="..."`');
    }
    if (HOMONYM_NOTES[item.slug]) {
      console.log(`- ⚠️ homonym 주의: ${HOMONYM_NOTES[item.slug]}`);
    }
    console.log('');
  });
  console.log(STANDARD_RULES);
  console.log('');
  console.log('각 직업 처리 후 Phase 5 검증 통과 + END_TRACKING 호출 + 17필드 self-report + [job-data-enhance] 마커 확인.');
});

console.log('');
console.log('=== END ===');
