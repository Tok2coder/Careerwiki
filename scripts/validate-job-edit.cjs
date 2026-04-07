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
    // detailReady 출처 누락 검사 (F2)
    for (const sub of ['curriculum', 'recruit', 'training']) {
      if (dr[sub] && dr[sub].length > 0 && !sources[`detailReady.${sub}`]) {
        warnings.push(`[출처] detailReady.${sub}에 내용이 있지만 sources["detailReady.${sub}"]가 없음 — 반드시 출처 등록 필요`);
      }
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
  const NOUN_EXCEPTIONS = ['강의', '설비', '기여', '처리', '관리', '설계', '분석', '개발', '운의', '합의', '회의', '정의', '위의'];

  if (fields.heroTags) {
    const tags = Array.isArray(fields.heroTags) ? fields.heroTags : JSON.parse(fields.heroTags);
    if (tags.length < 3) warnings.push(`[태그] heroTags가 ${tags.length}개 (최소 3개)`);
    if (tags.length > 10) warnings.push(`[태그] heroTags가 ${tags.length}개 (최대 10개)`);
    for (const tag of tags) {
      if (tag.length > 15) warnings.push(`[태그] "${tag}" — 15자 초과`);
      if (tag.length < 2) warnings.push(`[태그] "${tag}" — 2자 미만`);
      if (/[을를이은는에서도의]$/.test(tag)) {
        const isNounException = NOUN_EXCEPTIONS.some(noun => tag.endsWith(noun));
        if (!isNounException) {
          errors.push(`[태그] "${tag}" — 조사로 끝남, 명사구여야 함`);
        }
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
          // text가 URL로 시작하면 FAIL (기관명이어야 함)
          if (typeof src === 'object' && src.text && /^https?:\/\//.test(src.text.replace(/^\[\d+\]\s*/, ''))) {
            errors.push(`[출처형식] sources["${sourceKey}"]의 text가 URL로 시작 — "[N] 기관명" 형식 사용 필요`);
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

  // ── 7. detailWlb 등급 띄어쓰기 검사 ──
  if (fields.detailWlb) {
    const wlbGrade = fields.detailWlb?.wlb;
    const socialGrade = fields.detailWlb?.social;
    const stuckForms = ['보통이상', '보통이하', '다소높음', '다소낮음'];
    if (wlbGrade && stuckForms.includes(wlbGrade)) {
      errors.push(`[detailWlb.wlb] 붙여쓰기 금지: "${wlbGrade}" → "보통 이상" 또는 "보통 이하" 형식 사용`);
    }
    if (socialGrade && stuckForms.includes(socialGrade)) {
      errors.push(`[detailWlb.social] 붙여쓰기 금지: "${socialGrade}" → "보통 이상" 또는 "보통 이하" 형식 사용`);
    }
  }

  // ── 7. way 타입 검사 (배열이면 즉시 500 에러 — 최상위 치명 오류) ──

  if (fields.way !== undefined && fields.way !== null) {
    if (Array.isArray(fields.way)) {
      errors.push(`[치명] way가 배열(Array)임 — 반드시 string이어야 함. 배포 시 500 에러 발생!`);
    } else if (typeof fields.way !== 'string') {
      errors.push(`[치명] way 타입이 "${typeof fields.way}" — string이어야 함`);
    }
  }

  // ── 8. 잘린 문장 검사 ──

  const TRUNCATED_PATTERNS = [
    /부상\s*시$/,
    /으로\s*인해$/,
    /경우에는$/,
    /에\s*따르면$/,
    /가능하$/,
    /필요하$/,
    /이루어지$/,
    /\d{4}년$/,
    /억\s*원$/,
    /%\s*이상$/,
    /%\s*이하$/,
    /하여$/,
    /이며$/,
    /위해$/,
    /있으며$/,
    /있고$/,
    /하고$/,
  ];

  const COMPLETE_ENDINGS = [
    /[.다요]\s*(\[\d+\])*\s*$/,
    /습니다\s*(\[\d+\])*\s*$/,
    /입니다\s*(\[\d+\])*\s*$/,
    /됩니다\s*(\[\d+\])*\s*$/,
    /합니다\s*(\[\d+\])*\s*$/,
    /있습니다\s*(\[\d+\])*\s*$/,
    /없습니다\s*(\[\d+\])*\s*$/,
    /받습니다\s*(\[\d+\])*\s*$/,
    /\)\s*(\[\d+\])*\s*$/,
  ];

  const sentenceFields = ['way', 'overviewSalary.sal', 'overviewProspect.main', 'trivia',
    'summary', 'overviewAbilities.technKnow',
    'detailWlb.wlbDetail', 'detailWlb.socialDetail'];

  for (const fieldPath of sentenceFields) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;

    const trimmed = text.trim();
    const cleanEnd = trimmed.replace(/(\s*\[\d+\])+\s*$/, '').trim();

    let truncated = false;
    for (const pattern of TRUNCATED_PATTERNS) {
      if (pattern.test(cleanEnd)) {
        errors.push(`[잘린문장] ${fieldPath}: 미완성 문장 — "...${cleanEnd.slice(-25)}"`);
        truncated = true;
        break;
      }
    }

    if (!truncated) {
      const isComplete = COMPLETE_ENDINGS.some(p => p.test(trimmed));
      if (!isComplete) {
        warnings.push(`[잘린문장] ${fieldPath}: 완성형 어미 미확인 — "...${trimmed.slice(-30)}"`);
      }
    }
  }

  // ── 9a. overviewSalary.wage 덮어쓰기 방지 ──

  if (fields.overviewSalary && fields.overviewSalary.wage !== undefined) {
    errors.push('[FAIL] overviewSalary.wage 필드 변경 금지 — 바 차트 데이터 보존 필수. wage는 API 데이터이므로 절대 덮어쓰지 말 것');
  }

  // ── 9b. youtubeLinks 개수 검증 ──

  if (!fields.youtubeLinks || (Array.isArray(fields.youtubeLinks) && fields.youtubeLinks.length < 1) ||
      (typeof fields.youtubeLinks === 'string' && JSON.parse(fields.youtubeLinks).length < 1)) {
    // youtubeLinks 누락은 WARN (없는 경우도 허용 — 빈 배열은 OK)
    // 단, 빈 배열이 아닌 undefined/null이면 경고
    if (fields.youtubeLinks === undefined || fields.youtubeLinks === null) {
      warnings.push('[YouTube] youtubeLinks 없음 — 가능하면 1~3개 추가 권장');
    }
  }

  if (fields.youtubeLinks) {
    const ytLinks = Array.isArray(fields.youtubeLinks)
      ? fields.youtubeLinks
      : (typeof fields.youtubeLinks === 'string' ? JSON.parse(fields.youtubeLinks) : []);
    if (ytLinks.length > 3) {
      errors.push(`[YouTube] youtubeLinks 최대 3개 초과 (현재 ${ytLinks.length}개) — 3개 이하로 줄일 것`);
    }
  }

  // ── 9. YouTube URL 포맷 검사 ──

  if (fields.youtubeLinks) {
    const links = Array.isArray(fields.youtubeLinks)
      ? fields.youtubeLinks
      : (typeof fields.youtubeLinks === 'string' ? JSON.parse(fields.youtubeLinks) : []);

    const YOUTUBE_PATTERNS = [
      /^https?:\/\/(www\.)?youtube\.com\/watch\?v=[\w-]+/,
      /^https?:\/\/youtu\.be\/[\w-]+/,
      /^https?:\/\/(www\.)?youtube\.com\/shorts\/[\w-]+/,
      /^https?:\/\/(www\.)?youtube\.com\/embed\/[\w-]+/,
    ];

    for (const link of links) {
      // 문자열 배열 금지: {url, title} 객체여야 함
      if (typeof link === 'string') {
        errors.push(`[YouTube] 잘못된 형식: "${link}" — 문자열 배열 금지. {url, title} 객체 배열 사용: [{url: "https://...", title: "영상 제목"}]`);
        continue;
      }
      if (!link || typeof link !== 'object' || !link.url) {
        errors.push(`[YouTube] 잘못된 링크 형식: ${JSON.stringify(link)} — {url, title} 객체여야 함`);
        continue;
      }
      const url = link.url;
      const isValid = YOUTUBE_PATTERNS.some(p => p.test(url));
      if (!isValid) {
        errors.push(`[YouTube] 유효하지 않은 URL: "${url}" — youtube.com/watch?v= 또는 youtu.be/ 형식이어야 함`);
      }
      // title 인코딩 깨짐 감지
      if (link.title) {
        if (/&#\d+;|&amp;|&lt;|&gt;|&quot;/.test(link.title)) {
          errors.push(`[유튜브] 제목에 HTML entity 잔류: "${link.title.substring(0, 40)}..." — 디코딩 필요`);
        }
        if (/%[0-9A-F]{2}/i.test(link.title)) {
          errors.push(`[유튜브] 제목에 퍼센트 인코딩 잔류: "${link.title.substring(0, 40)}..." — 디코딩 필요`);
        }
      }
    }
  }

  // ── 10. _sources 포맷 검사 ──

  // 동일 필드 내 같은 URL 중복 등록 검출
  for (const [sourceKey, srcVal] of Object.entries(sources)) {
    if (!Array.isArray(srcVal)) continue;
    const urlsInField = {};
    for (const src of srcVal) {
      if (src && typeof src === 'object' && src.url) {
        urlsInField[src.url] = (urlsInField[src.url] || 0) + 1;
      }
    }
    const dupUrls = Object.entries(urlsInField).filter(([_, c]) => c > 1);
    for (const [url, count] of dupUrls) {
      errors.push(`[출처중복] sources["${sourceKey}"]에 동일 URL이 ${count}번 등록: "${url}" — 같은 필드에 같은 URL 중복 금지`);
    }
  }

  for (const [sourceKey, srcVal] of Object.entries(sources)) {
    if (!Array.isArray(srcVal)) {
      errors.push(`[출처포맷] sources["${sourceKey}"]가 배열이 아님 — Array여야 함`);
      continue;
    }

    for (let i = 0; i < srcVal.length; i++) {
      const src = srcVal[i];
      if (typeof src === 'string') {
        // 구형 string 포맷이면 경고
        warnings.push(`[출처포맷] sources["${sourceKey}"][${i}]: string 형식 — {text, url} 객체로 변환 필요`);
        continue;
      }
      if (typeof src !== 'object' || src === null) {
        errors.push(`[출처포맷] sources["${sourceKey}"][${i}]: null 또는 비객체`);
        continue;
      }
      // url 유효 도메인 검사
      if (src.url) {
        let validUrl = false;
        try {
          const parsed = new URL(src.url);
          validUrl = ['http:', 'https:'].includes(parsed.protocol);
        } catch {
          validUrl = false;
        }
        if (!validUrl) {
          errors.push(`[출처포맷] sources["${sourceKey}"][${i}].url 유효하지 않은 URL: "${src.url}"`);
        }
        // text에 URL이 포함된 경우 (이미 Gate 4에서 잡히지만 이중 확인)
        if (src.text && src.text.includes('http')) {
          errors.push(`[출처포맷] sources["${sourceKey}"][${i}].text에 URL 포함 — text와 url 필드를 분리해야 함`);
        }
      } else if (!src.text) {
        warnings.push(`[출처포맷] sources["${sourceKey}"][${i}]: text와 url 모두 없음`);
      }
    }
  }

  // ── 11. 무출처 문장 감지 ──
  //
  // 2-티어 검사:
  //   Tier A (FULL):    [N] 마커 없음 → WARN  +  마지막 [N] 이후 문장 → WARN
  //   Tier B (TRAIL):   마지막 [N] 이후 문장만 → WARN  (마커 없음은 허용)
  //
  // ※ detailReady.* (curriculum/recruit/training/pathExplore)는 대상 제외
  //    → "== 제목 [N] ==" 헤딩 각주 체계 사용 — 산문 [N] 패턴과 다름
  //
  // ⚠️ 무출처 문장 발견 시 처리 절차 (바로 제거 금지):
  //   1. 바로 앞 [N] 출처 URL을 WebFetch로 방문 → 해당 내용이 있으면 [N]을 문장 끝으로 이동
  //   2. 같은 출처가 아니면 → merged_profile_json 원문·공식 사이트에서 다른 출처 탐색
  //   3. 새 출처 확인되면 → [N+1] 추가 후 _sources 등록
  //   4. 어디서도 확인 불가일 때만 → 제거

  // Tier A: 항상 출처 표기 필수 (통계·사실 중심 필드)
  const FULL_CHECK_FIELDS = [
    'way',
    'overviewSalary.sal',
    'overviewProspect.main',
    'trivia',
  ];

  // Tier B: [N]이 하나라도 있으면 trailing만 검사 (일반 서술도 허용)
  const TRAILING_CHECK_FIELDS = [
    'summary',
    'overviewAbilities.technKnow',
    'detailWlb.wlbDetail',
    'detailWlb.socialDetail',
  ];

  function checkTrailingSentence(text, fieldPath) {
    const allMarkers = [...text.matchAll(/\[\d+\]/g)];
    if (allMarkers.length === 0) return; // Tier B는 마커 없으면 패스
    const lastMarker = allMarkers[allMarkers.length - 1];
    const afterLast = text.substring(lastMarker.index + lastMarker[0].length).trim();
    if (afterLast.length >= 10) {
      const hasFinalEnding = /[다요]\.|습니다\.|입니다\.|됩니다\.|합니다\./.test(afterLast);
      const isSubstantial = afterLast.length >= 20;
      if (hasFinalEnding || isSubstantial) {
        warnings.push(`[무출처] ${fieldPath}: 마지막 ${lastMarker[0]} 이후 미출처 문장 (${afterLast.length}자) — "${afterLast.substring(0, 60)}"`);
      }
    }
  }

  for (const fieldPath of FULL_CHECK_FIELDS) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;
    const trimmed = text.trim();
    if (trimmed.length < 10) continue;

    const allMarkers = [...trimmed.matchAll(/\[\d+\]/g)];

    if (allMarkers.length === 0) {
      const hasSentence = /[가-힣]{3,}[다요]./.test(trimmed);
      if (hasSentence && trimmed.length >= 30) {
        warnings.push(`[무출처] ${fieldPath}: [N] 각주 마커 없음 (${trimmed.length}자) — 모든 서술에 출처 표기 필수`);
      }
    } else {
      checkTrailingSentence(trimmed, fieldPath);
    }
  }

  for (const fieldPath of TRAILING_CHECK_FIELDS) {
    const text = getNestedField(fields, fieldPath);
    if (!text || typeof text !== 'string') continue;
    const trimmed = text.trim();
    if (trimmed.length < 10) continue;
    checkTrailingSentence(trimmed, fieldPath);
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
