#!/usr/bin/env node
/**
 * validate-job-edit.js
 *
 * Researcher 에이전트가 반환한 JSON을 검증하는 스크립트.
 * 팀 리더가 API 호출 전에 실행하여 치명적 실수를 차단한다.
 *
 * Usage: node scripts/validate-job-edit.js <json-file-or-stdin>
 *
 * Input JSON format:
 * {
 *   "jobName": "가정교사",
 *   "jobId": "1765284120082557",
 *   "fields": { ... },
 *   "sources": { ... },
 *   "careerTree": { ... } | null,
 *   "changeSummary": "..."
 * }
 */

const fs = require('fs');

// ── 검증 규칙 ──────────────────────────────────────────

const FORBIDDEN_EXAM_KEYWORDS = ['시험', 'LEET', 'TOEIC', 'TOEFL', 'TEPS', 'IELTS', '수능', '모의고사'];
const SHORT_LABEL_FIELDS = ['overviewWork.workStrong', 'overviewWork.workPlace', 'overviewWork.physicalAct'];
const STATS_ONLY_FIELDS = ['overviewAbilities.abilityList', 'overviewAptitude', 'detailEducation'];
const FOREIGN_NAME_PATTERNS = [
  /^[A-Z][a-z]+ [A-Z][a-z]+/, // "James Herriot"
  /[가-힣]+ [가-힣]+/, // OK - Korean
];

function validate(data) {
  const errors = [];   // 치명적 — API 호출 차단
  const warnings = []; // 경고 — 수동 확인 필요

  const { fields = {}, sources = {}, careerTree, changeSummary } = data;

  // ── 1. 필드 완성도 ──

  // way 필수 + 최소 분량
  if (fields.way) {
    if (fields.way.length < 100) {
      errors.push(`[필드] way가 너무 짧음 (${fields.way.length}자, 최소 200자 권장)`);
    }
  } else {
    warnings.push(`[필드] way가 없음 — 가장 중요한 필드`);
  }

  // detailReady 점검
  if (fields.detailReady) {
    const dr = typeof fields.detailReady === 'string' ? JSON.parse(fields.detailReady) : fields.detailReady;
    if (!dr.curriculum || dr.curriculum.length < 3) {
      warnings.push(`[필드] detailReady.curriculum이 ${dr.curriculum?.length || 0}개 (최소 5개 권장)`);
    }
  } else {
    warnings.push(`[필드] detailReady가 없음`);
  }

  // trivia 점검
  if (fields.trivia) {
    if (fields.trivia.length < 20) {
      warnings.push(`[필드] trivia가 너무 짧음 (${fields.trivia.length}자)`);
    }
  }

  // sidebarJobs 수량
  if (fields.sidebarJobs) {
    const jobs = Array.isArray(fields.sidebarJobs) ? fields.sidebarJobs : JSON.parse(fields.sidebarJobs);
    if (jobs.length > 15) {
      errors.push(`[사이드바] sidebarJobs가 ${jobs.length}개 — 7~12개로 정리 필요`);
    } else if (jobs.length > 12) {
      warnings.push(`[사이드바] sidebarJobs가 ${jobs.length}개 — 12개 이하 권장`);
    }
  }

  // sidebarCerts — 시험 여부 체크
  if (fields.sidebarCerts) {
    const certs = Array.isArray(fields.sidebarCerts) ? fields.sidebarCerts : JSON.parse(fields.sidebarCerts);
    for (const cert of certs) {
      const name = typeof cert === 'string' ? cert : cert.name;
      for (const kw of FORBIDDEN_EXAM_KEYWORDS) {
        if (name && name.includes(kw) && !name.includes('자격') && !name.includes('면허')) {
          errors.push(`[자격증] "${name}"은 시험이지 자격증이 아님 — 제거 또는 "~자격증" 형태로`);
        }
      }
    }
  }

  // heroTags 점검
  if (fields.heroTags) {
    const tags = Array.isArray(fields.heroTags) ? fields.heroTags : JSON.parse(fields.heroTags);
    if (tags.length < 3) warnings.push(`[태그] heroTags가 ${tags.length}개 (최소 3개)`);
    if (tags.length > 10) warnings.push(`[태그] heroTags가 ${tags.length}개 (최대 10개)`);
    for (const tag of tags) {
      if (tag.length > 15) warnings.push(`[태그] "${tag}" — 15자 초과`);
      if (tag.length < 2) warnings.push(`[태그] "${tag}" — 2자 미만`);
      if (/[을를이은는에서도의]$/.test(tag)) {
        errors.push(`[태그] "${tag}" — 조사로 끝남, 명사구여야 함`);
      }
    }
  }

  // ── 2. 짧은 라벨 필드 ──

  for (const fieldPath of SHORT_LABEL_FIELDS) {
    const val = getNestedField(fields, fieldPath);
    if (val && typeof val === 'string' && val.length > 20) {
      errors.push(`[라벨] ${fieldPath}가 "${val.substring(0, 30)}..." — 짧은 라벨이어야 함 (20자 이하)`);
    }
  }

  // ── 3. 공식 통계 전용 필드 ──

  for (const fieldPath of STATS_ONLY_FIELDS) {
    const val = getNestedField(fields, fieldPath);
    if (val && val !== null) {
      // sources에 해당 필드의 출처가 있는지 확인
      const sourceKey = fieldPath.includes('.') ? fieldPath : fieldPath;
      if (!sources[sourceKey] && !sources[fieldPath]) {
        errors.push(`[통계전용] ${fieldPath}에 값이 있지만 출처가 없음 — 공식 통계만 허용`);
      }
    }
  }

  // ── 4. 각주 검증 ──

  const textFields = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia', 'summary',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail', 'overviewAbilities.technKnow'];

  for (const fieldPath of textFields) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const footnoteMatches = text.match(/\[(\d+)\]/g);
    if (!footnoteMatches) continue;

    // 각주 중복 검사
    const counts = {};
    footnoteMatches.forEach(m => { counts[m] = (counts[m] || 0) + 1; });
    const dupes = Object.entries(counts).filter(([_, c]) => c > 1);
    if (dupes.length > 0) {
      errors.push(`[각주] ${fieldPath}: 중복 발견! ${dupes.map(([n, c]) => `${n}이 ${c}회`).join(', ')}`);
    }

    // sources 대응 확인
    const sourceKey = getSourceKey(fieldPath);
    if (!sources[sourceKey]) {
      errors.push(`[출처] ${fieldPath}에 [N] 각주가 있지만 sources["${sourceKey}"]가 없음`);
    } else {
      const srcArr = sources[sourceKey];
      if (Array.isArray(srcArr)) {
        // blob 체크 — 하나의 항목에 [1]...[2]... 가 다 들어있으면 blob
        for (const src of srcArr) {
          const srcText = typeof src === 'string' ? src : src.text;
          if (srcText && (srcText.match(/\[\d+\]/g) || []).length > 1) {
            errors.push(`[출처blob] sources["${sourceKey}"]에 blob 발견: "${srcText.substring(0, 60)}..." — 개별 항목으로 분리 필요`);
          }
        }
        // text/url 분리 체크
        for (const src of srcArr) {
          if (typeof src === 'object' && src.text && src.text.includes('http')) {
            errors.push(`[출처형식] sources["${sourceKey}"]의 text에 URL이 포함됨 — text와 url을 분리해야 함`);
          }
        }
      }
    }
  }

  // ── 5. 커리어트리 검증 ──

  if (careerTree) {
    const trees = Array.isArray(careerTree) ? careerTree : [careerTree];
    for (const tree of trees) {
      // 외국인 체크
      if (tree.person_name_en && !tree.person_name) {
        errors.push(`[커리어트리] 영문명만 있고 한글명 없음 — 외국인 의심`);
      }
      if (tree.person_name && /^[A-Za-z\s]+$/.test(tree.person_name)) {
        errors.push(`[커리어트리] "${tree.person_name}" — 외국인은 절대 금지`);
      }

      // stages 점검
      if (tree.stages_json) {
        const stages = typeof tree.stages_json === 'string' ? JSON.parse(tree.stages_json) : tree.stages_json;

        // 전직 스테이지 체크 (마지막 스테이지가 다른 직업이면 의심)
        if (stages.length > 0) {
          const lastStage = stages[stages.length - 1];
          const suspiciousRoles = ['국회의원', '장관', '대통령', '감독', 'CEO', '회장', '사장', '교수'];
          for (const role of suspiciousRoles) {
            if (lastStage.title && lastStage.title.includes(role)) {
              warnings.push(`[커리어트리] 마지막 스테이지 "${lastStage.title}" — 전직 스테이지 의심. 해당 직업 이후 전직은 제외`);
            }
          }
        }
      }
    }
  }

  // ── 6. changeSummary 존재 ──
  if (!changeSummary || changeSummary.length < 10) {
    warnings.push(`[기타] changeSummary가 없거나 너무 짧음`);
  }

  return { errors, warnings };
}

// ── 유틸리티 ──

function getNestedField(obj, path) {
  // "detailWlb.wlbDetail" → obj.detailWlb?.wlbDetail 또는 obj["detailWlb.wlbDetail"]
  if (obj[path] !== undefined) return obj[path];
  const parts = path.split('.');
  let current = obj;
  for (const part of parts) {
    if (current == null) return undefined;
    current = current[part];
  }
  return current;
}

function getSourceKey(fieldPath) {
  // 소스 키 매핑
  const aliases = {
    'way': 'way',
    'overviewSalary.sal': 'overviewSalary.sal',
    'overviewProspect.main': 'overviewProspect.main',
    'trivia': 'trivia',
    'summary': 'summary',
    'detailWlb.wlbDetail': 'detailWlb.wlbDetail',
    'detailWlb.socialDetail': 'detailWlb.socialDetail',
    'overviewAbilities.technKnow': 'overviewAbilities.technKnow',
  };
  return aliases[fieldPath] || fieldPath;
}

// ── 메인 실행 ──

function main() {
  let input;

  if (process.argv[2]) {
    input = fs.readFileSync(process.argv[2], 'utf8');
  } else if (!process.stdin.isTTY) {
    input = fs.readFileSync(0, 'utf8');
  } else {
    console.error('Usage: node scripts/validate-job-edit.js <json-file>');
    console.error('   or: echo \'{"fields":...}\' | node scripts/validate-job-edit.js');
    process.exit(1);
  }

  let data;
  try {
    data = JSON.parse(input);
  } catch (e) {
    console.error(`JSON 파싱 실패: ${e.message}`);
    process.exit(1);
  }

  const { errors, warnings } = validate(data);

  console.log(`\n=== 검증 결과: ${data.jobName || 'Unknown'} ===\n`);

  if (errors.length === 0 && warnings.length === 0) {
    console.log('✅ ALL PASS — API 호출 가능\n');
    process.exit(0);
  }

  if (errors.length > 0) {
    console.log(`❌ ERRORS (${errors.length}개 — API 호출 차단):`);
    errors.forEach(e => console.log(`  ${e}`));
    console.log();
  }

  if (warnings.length > 0) {
    console.log(`⚠️ WARNINGS (${warnings.length}개 — 수동 확인 필요):`);
    warnings.forEach(w => console.log(`  ${w}`));
    console.log();
  }

  if (errors.length > 0) {
    console.log('❌ FAIL — 에러 수정 후 재검증 필요\n');
    process.exit(1);
  } else {
    console.log('⚠️ PASS WITH WARNINGS — API 호출 가능하지만 경고 확인 권장\n');
    process.exit(0);
  }
}

// Export for programmatic use
module.exports = { validate };

main();
