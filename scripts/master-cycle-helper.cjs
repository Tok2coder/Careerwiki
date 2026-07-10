#!/usr/bin/env node
/*
 * master-cycle-helper.cjs — CareerWiki master skill cycle 자동화 helper
 *
 * ⚠️ 이름 주의: cycle-script-block.cjs hook 이 /^_?cycle.../ 패턴(underscore optional)으로
 *   "cycle"로 시작하는 파일명을 차단함. 그래서 "master-cycle-helper" (master 접두) 사용.
 *   이 스크립트는 자작 enhance dispatcher가 아니라 batch list/prompt 생성 + DB 현황 측정 도구.
 *   실제 데이터 보강은 .claude/skills/job-data-master/SKILL.md 가 수행 (WebFetch 우회 X).
 *
 * 기능:
 *   node scripts/master-cycle-helper.cjs --status
 *       → DB master 적용 카운트 측정 (drift 검증)
 *   node scripts/master-cycle-helper.cjs --cycle=12
 *       → R12 batch list + prompt 생성 (명시 cycle)
 *   node scripts/master-cycle-helper.cjs --next-cycle
 *       → 처리 안 된 다음 cycle 자동 결정 + 생성
 *   node scripts/master-cycle-helper.cjs --emit-progress --r=50
 *       → 단일 진실 진행 마커 1줄 출력 (데몬이 파싱→KV forward).
 *         검증 PASS + KPI 산수 일치 직후 1회만 실행. stdout은 마커 라인 단 1줄.
 *         kpi_done = admin job-equalize CTE(권위), jobs_done = master_list R7..r 누적합.
 *
 * 산출물 (v5, 2026-06-13 — 5직업-1세션 배치 복원, Jason 결정. 토큰 효율 회귀 수습):
 *   data/cycle/R{N}_queue.txt             (배치 큐 — B1~B5 × 5직업 enqueue 순서)
 *   data/cycle/r{N}_prompts/R{N}_B{1..5}_prompt.md  (5 batch dispatch prompt, 각 5직업)
 *   stdout: summary + dispatcher가 복붙할 25 spawn 명령 (전량 일괄 투입, 데몬 워커풀 동시성 7)
 */

const fs = require('fs');
const path = require('path');
const { execSync, execFileSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..');
const MASTER_LIST = path.join(ROOT, 'data/cycle/master_list_R7_R229.jsonl');
const DISPATCH_TEMPLATE = path.join(ROOT, 'data/cycle/_dispatch_template_v5.md');

// ─── arg parse ───
const args = process.argv.slice(2);
const getArg = (name) => {
  const a = args.find((x) => x.startsWith(`--${name}=`));
  return a ? a.split('=')[1] : null;
};
const hasFlag = (name) => args.includes(`--${name}`);

// ─── master_list 로드 ───
function loadCycles() {
  const lines = fs.readFileSync(MASTER_LIST, 'utf8').split('\n').filter(Boolean);
  const byCycle = {};
  for (const l of lines) {
    const o = JSON.parse(l);
    if (!byCycle[o.cycle]) byCycle[o.cycle] = [];
    byCycle[o.cycle][o.batch - 1] = o.jobs;
  }
  return byCycle;
}

// ─── DB: master 적용 slug Set + 카운트 ───
function fetchProcessedSlugs() {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT DISTINCT pr.entity_id FROM page_revisions pr WHERE pr.entity_type='job' AND pr.change_summary LIKE '%[job-data-master]%enhance%' AND pr.change_summary NOT LIKE '%yt-fill%';" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 64 * 1024 * 1024 });
    const j = JSON.parse(out);
    const rows = j[0]?.results || [];
    return new Set(rows.map((r) => String(r.entity_id)));
  } catch (e) {
    console.error('[warn] DB 쿼리 실패 (오프라인이면 --cycle=N 명시 사용):', e.message.slice(0, 120));
    return null;
  }
}

function fetchMasterCount() {
  // A = 모든 master 마커 (yt-fill/cleanup 포함) — 메모리 "누적" 정의
  // B = enhance 풀 사이클만 (yt-fill 제외) — 진짜 보강 완료 직업
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT 'A' AS def, COUNT(DISTINCT entity_id) AS cnt FROM page_revisions WHERE entity_type='job' AND change_summary LIKE '%[job-data-master]%' UNION ALL SELECT 'B', COUNT(DISTINCT entity_id) FROM page_revisions WHERE entity_type='job' AND change_summary LIKE '%[job-data-master]%enhance%' AND change_summary NOT LIKE '%yt-fill%';" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
    const j = JSON.parse(out);
    const rows = j[0]?.results || [];
    const a = rows.find((r) => r.def === 'A')?.cnt ?? null;
    const b = rows.find((r) => r.def === 'B')?.cnt ?? null;
    return { a, b };
  } catch (e) {
    return { a: null, b: null };
  }
}

// ─── STRICT 룰 블록 (dispatch_template_v4.md의 ``` 펜스 내부) 추출 ───
function loadStrictBlock() {
  const md = fs.readFileSync(DISPATCH_TEMPLATE, 'utf8');
  const m = md.match(/```\s*\n(# 🚨 STRICT[\s\S]*?)\n```/);
  if (!m) {
    // fallback: 처리 대상 헤더 전까지
    const idx = md.indexOf('# 처리 대상');
    return md.slice(md.indexOf('# 🚨 STRICT'), idx).trim();
  }
  // 템플릿 placeholder (처리 대상 표 + 처리 절차) 제거 — 룰만
  const block = m[1];
  const cut = block.indexOf('# 처리 대상');
  return cut > 0 ? block.slice(0, cut).trim() : block.trim();
}

// ─── 산업별 URL pool hint 매핑 테이블 ───
// 키: 직업명에 부분 문자열 매칭할 키워드 배열 (범용어 금지 — "원", "사", "기사", "관리" 등)
// 값: 특화 pool 사이트 문자열 (세션에 주입)
const INDUSTRY_POOL_MAP = [
  {
    keywords: ['방송', '미디어', '아나운서', '기자', '앵커', '촬영감독', '영상편집', '프로듀서', '라디오', 'PD'],
    pool: 'kcc.go.kr(방통위) · kofice.or.kr(한국국제문화교류진흥원) · kba.or.kr(한국방송협회) · kpf.or.kr(한국언론진흥재단) · kbs.co.kr · mbc.co.kr · sbs.co.kr',
  },
  {
    keywords: ['금융', '은행', '보험', '증권', '펀드', '투자', '신용', '대출', '외환', '자산운용'],
    pool: 'fss.or.kr(금융감독원) · fsc.go.kr(금융위원회) · kafa.or.kr(금융투자협회) · kofia.or.kr(금융투자협회) · kfb.or.kr(은행연합회) · knia.or.kr(손해보험협회)',
  },
  {
    keywords: ['소프트웨어', '개발자', '프로그래머', '보안', '정보통신', '네트워크', '클라우드', '데이터', '인공지능', 'AI', 'IT', '사이버'],
    pool: 'kisa.or.kr(한국인터넷진흥원) · pipc.go.kr(개인정보위) · nia.or.kr(한국지능정보사회진흥원) · spri.kr(소프트웨어정책연구소) · nipa.kr(정보통신산업진흥원)',
  },
  {
    keywords: ['의사', '간호', '약사', '한의', '치과', '물리치료', '작업치료', '임상', '병원', '보건', '의료', '수술', '진료'],
    pool: 'mohw.go.kr(보건복지부) · kma.or.kr(대한의사협회) · koreanurse.or.kr(대한간호협회) · kpa.or.kr(대한약사회) · kha.or.kr(대한병원협회) · hira.or.kr(건강보험심사평가원)',
  },
  {
    keywords: ['교사', '강사', '교육', '학교', '유치원', '보육', '교수', '강의', '훈련'],
    pool: 'moe.go.kr(교육부) · kice.re.kr(한국교육과정평가원) · kedi.re.kr(한국교육개발원) · nile.or.kr(국가평생교육진흥원) · kfae.re.kr(한국교육학술정보원)',
  },
  {
    keywords: ['건설', '건축', '토목', '시공', '설계', '구조', '측량', '도시계획', '부동산개발'],
    pool: 'molit.go.kr(국토교통부) · kict.re.kr(한국건설기술연구원) · kiaebs.or.kr(대한건축사협회) · kce.or.kr(한국건설기술인협회)',
  },
  {
    keywords: ['식품', '조리', '영양', '제과', '제빵', '요리', '외식', '급식'],
    pool: 'mfds.go.kr(식품의약품안전처) · kfia.or.kr(한국식품산업협회) · foodnara.or.kr(식품영양성분DB) · nifds.go.kr(국가식품클러스터)',
  },
  {
    keywords: ['전기', '에너지', '발전', '송전', '배전', '전력', '태양광', '풍력', '신재생'],
    pool: 'kepco.co.kr(한국전력) · khnp.co.kr(한국수력원자력) · kemco.or.kr(한국에너지공단) · motie.go.kr(산업통상자원부) · energy.or.kr',
  },
  {
    keywords: ['반도체', '디스플레이', '웨이퍼', '칩', '파운드리', '패키징', '반도체장비'],
    pool: 'ksia.or.kr(한국반도체산업협회) · motie.go.kr(산업부) · keti.re.kr(한국전자기술연구원) · etri.re.kr',
  },
  {
    keywords: ['농업', '농작물', '축산', '수산', '임업', '원예', '농촌', '양식'],
    pool: 'rda.go.kr(농촌진흥청) · mafra.go.kr(농림축산식품부) · nifs.go.kr(국립수산과학원) · naas.go.kr(국립농업과학원)',
  },
  {
    keywords: ['안전', '소방', '방재', '재난', '산업보건', '위험물', '환경안전'],
    pool: 'kosha.or.kr(안전보건공단) · moel.go.kr(고용노동부) · nema.go.kr · nfds.go.kr(소방청) · kiha.or.kr',
  },
  {
    keywords: ['변호사', '검사', '판사', '법무', '법조', '사법', '법률', '형사', '민사'],
    pool: 'koreanbar.or.kr(대한변호사협회) · moj.go.kr(법무부) · scourt.go.kr(대법원) · kppa.or.kr(한국검사협회)',
  },
  {
    keywords: ['항공', '파일럿', '승무원', '항공교통', '정비사', '공항운영'],
    pool: 'molit.go.kr/항공정책 · airport.kr(인천공항) · koreanair.com/채용 · icao.int · kcab.go.kr(항공안전기술원)',
  },
  {
    keywords: ['원자력', '방사선', '방사성', '핵연료', '방폐', '방사능'],
    pool: 'kins.re.kr(한국원자력안전기술원) · korad.or.kr(한국원자력환경공단) · kofons.or.kr · khnp.co.kr(한국수력원자력) · nssc.go.kr(원자력안전위원회)',
  },
  {
    keywords: ['사회복지', '복지사', '상담사', '청소년', '노인', '장애', '자활'],
    pool: 'mohw.go.kr(복지부) · kcwa.or.kr(한국사회복지협의회) · welfare.go.kr · nysc.or.kr(청소년활동진흥원) · nirc.or.kr',
  },
  {
    keywords: ['물류', '유통', '배송', '운송', '창고', '무역', '관세', '통관', '포워딩'],
    pool: 'molit.go.kr · klta.or.kr(한국물류협회) · korcham.net(대한상의) · customs.go.kr(관세청) · kita.net(무역협회)',
  },
  {
    keywords: ['환경', '대기', '수질', '폐기물', '생태', '기후', '탄소', '온실가스'],
    pool: 'me.go.kr(환경부) · nier.go.kr(국립환경과학원) · keiti.re.kr(한국환경산업기술원) · gir.go.kr(온실가스종합정보센터)',
  },
  {
    keywords: ['디자인', '패션', '의류', '섬유', '봉제', '텍스타일'],
    pool: 'motie.go.kr · kofoti.or.kr(한국패션산업연구원) · kfda.or.kr(한국패션디자이너협회) · kdfi.or.kr(한국디자인진흥원)',
  },
  {
    keywords: ['관광', '호텔', '여행사', '컨벤션', '카지노', '레저'],
    pool: 'mcst.go.kr(문화체육관광부) · knto.or.kr(한국관광공사) · kata.or.kr(한국여행업협회) · hira.or.kr',
  },
  {
    keywords: ['문화', '예술', '공연', '음악', '미술', '영화', '게임', '콘텐츠', '웹툰', '작가', '극작'],
    pool: 'mcst.go.kr(문화체육관광부) · kofic.or.kr(영화진흥위원회) · kocca.or.kr(한국콘텐츠진흥원) · arko.or.kr(한국문화예술위원회)',
  },
  {
    keywords: ['스포츠', '체육', '선수', '코치', '심판', '트레이너'],
    pool: 'ksoc.or.kr(대한체육회) · mcst.go.kr · sports.or.kr · ksa.or.kr · kspo.or.kr(국민체육진흥공단)',
  },
  {
    keywords: ['기계', '금속', '제조', '주조', '단조', '용접', '선반', '공작', '사출', '프레스'],
    pool: 'motie.go.kr · koami.or.kr(한국기계산업진흥회) · kims.re.kr(한국재료연구원) · kitech.re.kr(한국생산기술연구원)',
  },
  {
    keywords: ['화학', '석유화학', '정유', '고분자', '플라스틱', '도료', '촉매'],
    pool: 'motie.go.kr · krict.re.kr(화학연구원) · kiic.or.kr(한국화학공학회) · kcma.or.kr(한국화학물질관리협회)',
  },
  {
    keywords: ['철도', '지하철', '기관사', '열차', '전동차'],
    pool: 'molit.go.kr · korail.com(한국철도공사) · kric.or.kr(한국철도기술연구원) · seoulmetro.co.kr',
  },
  {
    keywords: ['해운', '선박', '항만', '조선', '선원', '도선'],
    pool: 'kmof.go.kr(해양수산부) · kmi.re.kr(한국해양수산개발원) · ksr.or.kr(한국선급) · portmis.go.kr',
  },
];

// 텍스트(직업명 or 산업분류)에서 매칭되는 INDUSTRY_POOL_MAP 항목을 반환. 미매칭 시 null.
// (Tier 1: 산업분류 텍스트로 호출하면 이름 동음이의 함정 회피)
function resolvePoolEntry(text) {
  if (!text) return null;
  for (const entry of INDUSTRY_POOL_MAP) {
    for (const kw of entry.keywords) {
      if (text.includes(kw)) return entry;
    }
  }
  return null;
}

// 직업명에서 산업별 특화 pool hint를 반환. 미매칭 시 null. (레거시 호환)
function resolvePoolHint(jobName) {
  const e = resolvePoolEntry(jobName);
  return e ? `특화 pool: ${e.pool} + 추가 발굴` : null;
}

// ─── DB: cycle 직업들의 heroCategory(산업분류) 조회 → Map(id → 산업텍스트) ───
// 명칭 함정 사전차단(Tier 1+2)의 진리 신호. merged_profile_json.heroCategory 는 single/multi 두 형태.
function fetchHeroCategories(ids) {
  if (!ids || !ids.length) return null;
  const inList = ids.map((x) => String(x)).join(',');
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT id, json_extract(merged_profile_json,'$.heroCategory') AS hc FROM jobs WHERE id IN (${inList});" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 32 * 1024 * 1024 });
    const j = JSON.parse(out);
    const rows = j[0]?.results || [];
    const map = new Map();
    for (const r of rows) {
      let txt = null;
      if (r.hc) {
        try {
          const o = typeof r.hc === 'string' ? JSON.parse(r.hc) : r.hc;
          if (o && typeof o === 'object') {
            if (o.value) txt = String(o.value);
            else if (Array.isArray(o.values)) txt = o.values.map((v) => (v && v.value) || v).filter(Boolean).join(' / ');
          } else if (typeof o === 'string') txt = o;
        } catch { txt = String(r.hc); }
      }
      map.set(String(r.id), txt);
    }
    return map;
  } catch (e) {
    console.error('[warn] heroCategory 조회 실패 (명칭함정 사전차단 생략, 워커 Phase 0 방어에 의존):', e.message.slice(0, 100));
    return null;
  }
}

// ─── batch prompt 생성 (v5: 5직업-1세션, 순차 POST 체크포인트) ───
function buildBatchPrompt(cycleNum, batchNum, jobs, strictBlock, heroCatMap) {
  const sessionName = `R${cycleNum}_B${batchNum}`;
  const GENERIC_HINT = '산업 소관 부처(.go.kr)·직능 협회/학회(.or.kr)·대표 기업(.co.kr) deep page + KOSIS·언론 deep article 우선. root/검색 URL 금지. **niche도 distinct≥10 필수(d<10 검증 FAIL)**';
  const TAIL = 'root/검색 URL 금지. **niche도 distinct≥10 필수(d<10 검증 FAIL)**';
  const rows = jobs.map((job, i) => {
    // Tier 1: hint는 DB 산업분류(heroCategory) 기준으로 우선 생성 (이름 동음이의 함정 회피).
    const industry = heroCatMap ? (heroCatMap.get(String(job.id)) || null) : null;
    const nameEntry = resolvePoolEntry(job.name);
    const indEntry = resolvePoolEntry(industry);
    const indTag = industry ? `DB 산업분류(heroCategory): "${industry}". ` : '';
    // Tier 2: 산업분류를 아는데 직업명 기반 pool이 그와 어긋나면(다른 pool이거나 산업분류는 미매칭) 명칭 함정.
    const nameTrap = !!industry && !!nameEntry && nameEntry !== indEntry;
    let hint;
    if (nameTrap) {
      const ref = indEntry
        ? `참고 pool: ${indEntry.pool} + 추가 발굴`
        : `map 특화 pool 없음 — 위 산업분류 텍스트 기준으로 소관부처(.go.kr)/협회·학회(.or.kr) deep page 직접 발굴`;
      hint = `🔴 명칭 중의성 경고 — 직업명 기반 hint가 DB 산업분류와 불일치. **직업명 신호 무시**, ${indTag}이 산업분류 기준으로 실직무 확정 후 출처 발굴. ${ref}. ${TAIL}`;
    } else {
      const primary = indEntry || nameEntry; // 산업분류 매칭 우선, 없으면 이름 매칭 fallback
      hint = primary ? `${indTag}특화 pool: ${primary.pool} + 추가 발굴. ${TAIL}` : `${indTag}${GENERIC_HINT}`;
    }
    return `| ${i + 1} | ${job.name} | ${job.id} | ${job.slug} | (자체 분류: niche/major — 모호 시 default major. minor 금지: 게이트 외 분류) | ${hint} |`;
  }).join('\n');
  const reportRows = jobs.map((job) => `${job.slug}  | rev=NNNN | distinct=NN | totalE=NN | class | CLEAN | 마커OK`).join('\n');

  // ─── 활동 가시화: wave(=이 세션) 단위 emit (대시보드 '세부 작업' 개별 행) ───
  const actFile = `data/cycle/r${cycleNum}_activity/b${batchNum}.json`;

  return `${strictBlock}

---

# 🟢 활동 보고 (필수 — 생략 금지, 대시보드 '세부 작업' 실시간 가시화)

이 세션은 대시보드에 1개의 wave 행으로 뜬다. 아래 2개를 **반드시** 실행한다(실패해도 배치는 계속 — emit 실패는 무해).

- **STEP 0 (작업 시작 즉시, 첫 직업 처리 전):**
  \`node scripts/emit-activity.cjs --file ${actFile} --status running\`
- **STEP LAST (세션 종료 직전, 모든 직업 처리/보고 후):**
  성공: \`node scripts/emit-activity.cjs --file ${actFile} --status done --tool-calls <대략 tool-call 수> --detail "<완료직업수>/${jobs.length} done"\`
  일부/실패: \`node scripts/emit-activity.cjs --file ${actFile} --status failed --detail "<완료>/${jobs.length}, 미완=<slug 사유>"\`

(\`--tool-calls\`/\`--detail\`는 가능하면 채우고, 모르면 생략 가능. external_id·group_key·label·model은 base 파일에 이미 박혀 있으니 건드리지 않는다.)

---

# 처리 대상 직업 (${sessionName} — ENHANCE 모드, marker 미보유 신규, ${jobs.length}직업-1세션 배치)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
${rows}

# 처리 절차

\`.claude/skills/job-data-master/SKILL.md\` Phase 0~7 흐름 (ENHANCE 모드). 위 표의 직업을 **1건씩 순차** 처리 — 한 직업을 POST·검증 완료한 뒤 다음 직업으로 (POST 체크포인트: 세션 중간 사망 시 완료분은 prod 보존, 검증세션이 미완분 식별).
- POST: \`https://careerwiki.org/api/job/{id}/edit\` + \`X-Admin-Secret: careerwiki-admin-2026\`
- POST body: 파일 기반 (인라인 한글 본문 절대 X — mojibake-block hook)
- POST 전 \`node scripts/validate-job-edit.cjs payload.json --class=<분류>\` ALL PASS 의무 (룰 19 결정적 게이트)
- POST 후 \`node scripts/skill-cache/audit-via-api.cjs <slug> --exclude-sal\` CLEAN + 마커 확인 — **직업당 1라운드** (룰 20 과검증 금지, 세션 생존)
- change_summary: \`[job-data-master] enhance — way·trivia·detailReady·sidebar·youtubeLinks·...\` (top-level camelCase)
- distinct URL ≥ 18 + totalEntries ≥ 19 강제 (룰 4·15). 한 직업 막히면 사유 보고 + skip하고 다음 직업 계속(세션 전체 abort X).

표의 직업 전부 끝나면 즉시 종료. 자동 다음 cycle 진입 X.

# 보고 형식

\`\`\`
${sessionName} 결과:
${reportRows}

JOBS DONE: ${jobs.length}/${jobs.length} ok   (미완 시: JOBS: M/${jobs.length} ok, 미완=<slug + 사유>)
\`\`\`
`;
}

// ─── cycle 생성 ───
function generateCycle(cycleNum, opts = {}) {
  const byCycle = loadCycles();
  const cycleKey = `R${cycleNum}`;
  const batches = byCycle[cycleKey];
  if (!batches) {
    console.error(`[error] ${cycleKey} 가 master_list에 없음. 범위: R7~R229.`);
    process.exit(1);
  }

  const strictBlock = loadStrictBlock();
  const allJobs = batches.flat();

  // DB cross-check (옵션)
  let processed = null;
  if (!opts.skipDb) processed = fetchProcessedSlugs();

  // 명칭 함정 사전차단(Tier 1+2): cycle 직업들의 heroCategory(산업분류) 조회
  let heroCatMap = null;
  if (!opts.skipDb) heroCatMap = fetchHeroCategories(allJobs.map((j) => j.id));
  const alreadyDone = [];
  if (processed) {
    for (const j of allJobs) {
      if (processed.has(String(j.id))) alreadyDone.push(j.slug);
    }
  }

  // 배치 큐 txt + batch prompt 생성 (v5: 5직업-1세션 배치 복원, 순차 POST 체크포인트)
  const promptDir = path.join(ROOT, `data/cycle/r${cycleNum}_prompts`);
  fs.mkdirSync(promptDir, { recursive: true });

  const queueLines = [];
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const jobs = batches[bi];
    const prompt = buildBatchPrompt(cycleNum, bn, jobs, strictBlock, heroCatMap);
    fs.writeFileSync(path.join(promptDir, `R${cycleNum}_B${bn}_prompt.md`), prompt);
    queueLines.push(`# B${bn} (${jobs.length}직업)`);
    jobs.forEach((j) => queueLines.push(`B${bn} | ${j.slug} | id=${j.id}`));
  }
  fs.writeFileSync(path.join(ROOT, `data/cycle/R${cycleNum}_queue.txt`), queueLines.join('\n'));

  // ─── 보고 ───
  console.log(`\n=== ${cycleKey} cycle 생성 완료 (v5: 5직업-1세션 배치 복원) ===`);
  console.log(`직업: ${allJobs.length}건 → 배치 ${batches.length}개 (각 ~${Math.round(allJobs.length / batches.length)}직업/세션) — 전량 일괄 enqueue (데몬 워커풀 동시성 7, 슬롯 비는 대로 연속 투입)`);
  console.log(`queue:        data/cycle/R${cycleNum}_queue.txt`);
  console.log(`prompt:       data/cycle/r${cycleNum}_prompts/R${cycleNum}_B{1..${batches.length}}_prompt.md`);

  if (alreadyDone.length) {
    console.log(`\n⚠️  이미 master 적용된 직업 ${alreadyDone.length}건 (cross-check):`);
    alreadyDone.forEach((s) => console.log(`   - ${s} (skip 또는 force-enhance 판단 필요)`));
  } else if (processed) {
    console.log(`\n✓ ${allJobs.length} 직업 모두 미적용 (정상 신규 enhance 대상)`);
  }

  console.log(`\n=== Dispatcher spawn 명령 (5직업-1세션 × ${batches.length} 배치, 전량 일괄 enqueue) ===`);
  console.log(`${batches.length}개 배치 세션을 한 번에 작업큐에 투입 — 데몬 워커풀(동시성 7)이 슬롯 비는 대로 연속 처리:`);
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const slugs = batches[bi].map((j) => j.slug).join(', ');
    console.log(`  B${bn}: cat data/cycle/r${cycleNum}_prompts/R${cycleNum}_B${bn}_prompt.md  → prompt (${slugs})`);
  }

  // ─── 활동 가시화 (app.wikicomu.com /activity) — wave(=병렬 세션) 단위 세분화 ───
  // 옵션 A (Jason 확정 2026-06-14): cycle 1행이 아니라 B1~B5 + 검증 = 유닛별 개별 행.
  // 각 유닛마다 base 이벤트 파일을 생성 → 해당 세션이 STEP0(running)/STEP_LAST(done) 자동 emit.
  // (source, external_id) 유니크 키라 같은 external_id의 running→done이 같은 행을 upsert(라이프사이클).
  // group_key가 같아 한 cycle의 6개가 대시보드에서 한 그룹으로 묶임. cycle 단위 r{N}-work 1행은 폐기(중복).
  const d = new Date();
  const isoDate = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`; // 로컬 날짜(KST) — UTC toISOString는 자정 부근 하루 어긋남
  const groupKey = `cycle-R${cycleNum}-${isoDate}`;
  const activityDir = path.join(ROOT, `data/cycle/r${cycleNum}_activity`);
  fs.mkdirSync(activityDir, { recursive: true });
  const writeBase = (extId, label) =>
    fs.writeFileSync(
      path.join(activityDir, `${extId.replace(`r${cycleNum}-`, '')}.json`),
      JSON.stringify({ events: [{ source: 'batch', external_id: extId, group_key: groupKey, agent_slug: 'hangyeol', label, model: 'sonnet', status: 'running' }] }, null, 2),
    );
  for (let bi = 0; bi < batches.length; bi++) {
    const bn = bi + 1;
    const b = batches[bi];
    writeBase(`r${cycleNum}-b${bn}`, `R${cycleNum} B${bn}: ${b[0].slug}~${b[b.length - 1].slug}`);
  }
  writeBase(`r${cycleNum}-verify`, `R${cycleNum} 검증: ${allJobs.length}직업 전수 실측`);
  console.log(`\n=== Activity 가시화 (wave 단위, 옵션 A) — base 이벤트 파일 생성 완료 ===`);
  console.log(`group_key: ${groupKey}  (B1~B${batches.length} + verify = ${batches.length + 1}개 유닛이 한 그룹으로 묶임)`);
  console.log(`base dir:  data/cycle/r${cycleNum}_activity/  (b1..b${batches.length}.json + verify.json)`);
  console.log(`각 배치 세션은 prompt의 STEP0/STEP_LAST에서 자동 emit (running→done). 검증 세션은 아래 명령 사용:`);
  console.log(`  검증 running: node scripts/emit-activity.cjs --file data/cycle/r${cycleNum}_activity/verify.json --status running`);
  console.log(`  검증 done:    node scripts/emit-activity.cjs --file data/cycle/r${cycleNum}_activity/verify.json --status done --detail "<25/25 PASS, KPI ...>"`);

  console.log(`\n완료 후: ${allJobs.length} 직업 rev 수집 + 검증 세션(sonnet, master-verify-cycle 전수 실측 + 다중 rev 전수 보고) + R${cycleNum}_report.md + 메모리 갱신 (project_careerwiki_cycle_progress.md).`);
}

// ─── 마지막 완료 cycle + 다음 미처리 cycle 계산 (DB processed Set 기반) ───
function computeCyclePosition(processed) {
  const byCycle = loadCycles();
  const cycleNums = Object.keys(byCycle)
    .map((k) => parseInt(k.slice(1), 10))
    .sort((a, b) => a - b);
  let lastDone = null;
  let next = null;
  for (const n of cycleNums) {
    const jobs = byCycle[`R${n}`].flat();
    const doneCount = jobs.filter((j) => processed.has(String(j.id))).length;
    if (doneCount >= jobs.length / 2) {
      lastDone = { n, doneCount, total: jobs.length, lastSlug: jobs[jobs.length - 1]?.slug };
    } else if (next === null) {
      next = { n, doneCount, total: jobs.length, firstSlug: jobs[0]?.slug };
    }
  }
  return { lastDone, next };
}

// ─── --next-cycle: 처리 안 된 다음 cycle 자동 결정 ───
function findNextCycle() {
  const processed = fetchProcessedSlugs();
  if (!processed) {
    console.error('[error] DB 쿼리 실패 — --cycle=N 명시 사용 권장.');
    process.exit(1);
  }
  const { next } = computeCyclePosition(processed);
  if (!next) {
    console.error('[info] 모든 cycle 처리 완료된 것으로 보임.');
    process.exit(0);
  }
  console.log(`[next-cycle] R${next.n} 결정 (${next.doneCount}/${next.total} 처리됨 → 미처리 cycle, 시작=${next.firstSlug})`);
  return next.n;
}

// ─── --status ───
function showStatus() {
  const { a, b } = fetchMasterCount();
  console.log('=== CareerWiki master cycle 현황 ===');
  console.log(`A. 모든 master 마커 (yt-fill/cleanup 포함, DISTINCT 직업): ${a ?? 'DB 쿼리 실패'}   ← 메모리 "누적 진행" 정의`);
  console.log(`B. enhance 풀 사이클만 (yt-fill 제외, DISTINCT 직업):    ${b ?? 'DB 쿼리 실패'}   ← 실제 보강 완료`);
  if (a != null && b != null) console.log(`   차이 ${a - b} = yt-fill/cleanup만 적용 (풀 enhance 미완)`);

  // 마지막 처리 / 다음 cycle 위치 (DB 진리값)
  const processed = fetchProcessedSlugs();
  if (processed) {
    const { lastDone, next } = computeCyclePosition(processed);
    console.log(`\n=== cycle 위치 (DB 기준) ===`);
    if (lastDone) console.log(`마지막 처리 cycle: R${lastDone.n} (${lastDone.doneCount}/${lastDone.total}, 끝=${lastDone.lastSlug})`);
    if (next) console.log(`다음 cycle:        R${next.n} (시작=${next.firstSlug})  → 'node scripts/master-cycle-helper.cjs --cycle=${next.n}' 또는 '--next-cycle'`);
    else console.log(`다음 cycle:        없음 (전체 처리 완료)`);
  }

  console.log(`\n다음 단계: data/cycle/_dispatcher_manual.md 의 ENTRY POINT 6 step 따라 진행.`);
  console.log(`(보조 메모리: agent/memory/project_careerwiki_cycle_progress.md — drift 시 A 값으로 갱신)`);
}

// ─── 마커 판정 ───
const isMasterMarker = (cs) => !!cs && (/\[job-data-master\]/.test(cs) || /\[job-data-enhance\]/.test(cs));

// ─── --reset-delay: 리밋 사망 메시지에서 리셋 시각 파싱 → ScheduleWakeup delay(초) 계산 (KST 기준) ───
// 입력 예: "...session limit · resets 3:10am (Asia/Seoul)"  → 리셋까지 남은 초 + 버퍼
function computeResetDelay(msg) {
  const m = (msg || '').match(/resets\s+(\d{1,2}):(\d{2})\s*(am|pm)?\s*\(Asia\/Seoul\)/i);
  if (!m) return null;
  let hh = parseInt(m[1], 10);
  const mm = parseInt(m[2], 10);
  const ap = (m[3] || '').toLowerCase();
  if (ap === 'pm' && hh !== 12) hh += 12;
  if (ap === 'am' && hh === 12) hh = 0;
  const KST = 9 * 3600 * 1000;
  const nowKstMs = Date.now() + KST;            // UTC epoch를 KST 벽시계로 shift
  const d = new Date(nowKstMs);                  // d의 getUTC* = KST 벽시계 값
  let targetKstMs = Date.UTC(d.getUTCFullYear(), d.getUTCMonth(), d.getUTCDate(), hh, mm, 0);
  if (targetKstMs <= nowKstMs) targetKstMs += 24 * 3600 * 1000; // 이미 지난 시각이면 내일
  const rawSec = Math.ceil((targetKstMs - nowKstMs) / 1000);
  const delaySec = rawSec + 45;                  // 리셋 직후 버퍼 45초
  return { hh, mm, rawSec, delaySec };
}

// ─── --resume=N: cycle N의 25직업 중 이미 master 적용(KPI 카운트)된 것 vs 미완 산출 ───
function fetchResumeStatus(ids) {
  const inList = ids.map((id) => `'${id}'`).join(',');
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "WITH cr AS (SELECT entity_id, change_summary, ROW_NUMBER() OVER(PARTITION BY entity_id ORDER BY id DESC) rn FROM page_revisions WHERE entity_type='job' AND change_summary NOT LIKE '%[sidebar-fill]%' AND entity_id IN (${inList})) SELECT entity_id, change_summary FROM cr WHERE rn=1;" --json`;
  const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
  const rows = JSON.parse(out)[0]?.results || [];
  const map = new Map();
  for (const r of rows) map.set(String(r.entity_id), r.change_summary);
  return map;
}

function resumeCycle(n) {
  const cycles = loadCycles();
  const batches = cycles[`R${n}`];
  if (!batches) {
    console.error(`[error] R${n} master_list에 없음.`);
    process.exit(1);
  }
  const allJobs = batches.flatMap((b, bi) => (b || []).map((j) => ({ ...j, batch: bi + 1 })));
  let statusMap;
  try {
    statusMap = fetchResumeStatus(allJobs.map((j) => String(j.id)));
  } catch (e) {
    console.error('[error] DB 쿼리 실패:', e.message.slice(0, 120));
    process.exit(1);
  }
  const done = [], remain = [];
  for (const j of allJobs) (isMasterMarker(statusMap.get(String(j.id))) ? done : remain).push(j);

  console.log(`=== R${n} 재개 상태 (DB 기준, latest non-sidebar rev 마커 판정) ===`);
  console.log(`완료: ${done.length}/${allJobs.length} | 미완: ${remain.length}\n`);
  console.log(`완료 직업(재처리 금지): ${done.map((j) => j.name).join(', ') || '(없음)'}\n`);
  if (!remain.length) {
    console.log('✅ 미완 0 — 이 cycle은 완료됨. 재개 불필요.');
    return;
  }
  console.log('미완 직업 (배치별):');
  for (let b = 1; b <= batches.length; b++) {
    const rs = remain.filter((j) => j.batch === b);
    if (rs.length) console.log(`  B${b}: ${rs.map((j) => j.name).join(', ')}`);
  }
  // 재개 Workflow REMAIN 맵 (그대로 붙여넣기용)
  const remainMap = {};
  for (let b = 1; b <= batches.length; b++) {
    const rs = remain.filter((j) => j.batch === b).map((j) => j.name);
    if (rs.length) remainMap[b] = rs;
  }
  console.log(`\n재개 Workflow REMAIN(JS):\nconst REMAIN = ${JSON.stringify(remainMap)};`);
  console.log(`완료 7직업 등 DONE 가드: 각 직업 POST 전 'SELECT MAX(id) WHERE entity_id={id} AND change_summary LIKE %[job-data-master]% 그리고 latest여부' 재확인 (idempotent).`);
}

// ─── --emit-progress: 단일 진실 진행 마커 1줄 emit (데몬 파싱 → KV careerwiki:rbatch:v1 forward) ───
// 계약(7키, JSON.stringify 삽입순서 = 계약순서): last_completed_r·kpi_done·kpi_total·
//   cycles_done·cycles_total·jobs_done·jobs_total·as_of
// 권위 규칙:
//   kpi_done  = admin /admin/job-equalize skillApplied CTE 와 1:1 동일 쿼리 (src/routes/admin.ts L1090).
//               latest non-[sidebar-fill] rev 가 [job-data-master] 마커 + jobs.user_contributed_json NOT NULL.
//               --status A/B 카운트는 절대 쓰지 않음(over-count).
//   kpi_total = jobs WHERE is_active=1 (admin totalResult, L1072와 동일).
//   jobs_done = master_list R7..last_r 직업수 누적합 (25×cycle 금지 — 초기 cycle 크기 불균일).
// stdout 에는 마커 라인 1줄만 출력(데몬 정규식 ^STORE_CAREERWIKI_PROGRESS:\s*(\{.*\})$ 매칭). 경고는 stderr.

// admin job-equalize skillApplied CTE 와 동일 (권위 KPI). src/routes/admin.ts L1090 미러.
function fetchKpiDone() {
  const sql = `WITH latest AS (SELECT entity_id, MAX(id) AS max_id FROM page_revisions WHERE entity_type='job' AND change_summary NOT LIKE '%[sidebar-fill]%' GROUP BY entity_id) SELECT COUNT(DISTINCT pr.entity_id) AS cnt FROM page_revisions pr JOIN latest l ON l.entity_id=pr.entity_id AND l.max_id=pr.id JOIN jobs j ON j.id=pr.entity_id WHERE pr.change_summary LIKE '%[job-data-master]%' AND j.user_contributed_json IS NOT NULL;`;
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "${sql}" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
    const rows = JSON.parse(out)[0]?.results || [];
    return rows[0]?.cnt ?? null;
  } catch (e) {
    console.error('[error] KPI 권위 쿼리 실패:', e.message.slice(0, 120));
    return null;
  }
}

// kpi_total = admin totalResult 와 동일 (jobs WHERE is_active=1). src/routes/admin.ts L1072 미러.
function fetchActiveJobCount() {
  const cmd = `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT COUNT(*) AS cnt FROM jobs WHERE is_active=1;" --json`;
  try {
    const out = execSync(cmd, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'], maxBuffer: 16 * 1024 * 1024 });
    const rows = JSON.parse(out)[0]?.results || [];
    return rows[0]?.cnt ?? null;
  } catch (e) {
    console.error('[error] 활성 직업 총수 쿼리 실패:', e.message.slice(0, 120));
    return null;
  }
}

function emitProgress() {
  const byCycle = loadCycles();
  const cycleNums = Object.keys(byCycle).map((k) => parseInt(k.slice(1), 10)).sort((a, b) => a - b);

  // last_completed_r: --r 명시가 진리(검증 직후 dispatcher가 방금 끝낸 cycle 번호를 안다).
  //   미지정 시 DB processed Set 기반 lastDone 로 추론(보조).
  let lastR = getArg('r') != null ? parseInt(getArg('r'), 10) : null;
  if (lastR == null) {
    const processed = fetchProcessedSlugs();
    if (!processed) {
      console.error('[error] --r 미지정 + DB 추론 실패. --r=N 명시 필요.');
      process.exit(1);
    }
    const { lastDone } = computeCyclePosition(processed);
    if (!lastDone) {
      console.error('[error] 완료 cycle 추론 불가. --r=N 명시 필요.');
      process.exit(1);
    }
    lastR = lastDone.n;
  }
  if (!cycleNums.includes(lastR)) {
    console.error(`[error] R${lastR} 가 master_list에 없음. 범위 R${cycleNums[0]}~R${cycleNums[cycleNums.length - 1]}.`);
    process.exit(1);
  }

  // KPI(권위): admin CTE 와 동일. 실패 시 마커 미생성(추측 emit 금지).
  const kpiDone = fetchKpiDone();
  const kpiTotal = fetchActiveJobCount();
  if (kpiDone == null || kpiTotal == null) {
    console.error('[error] 권위 KPI 측정 실패 → 마커 미생성. (추측값 emit 금지)');
    process.exit(1);
  }

  // cycles: R7..last_r 갯수 / 전체 cycle 갯수
  const cyclesTotal = cycleNums.length;
  const cyclesDone = cycleNums.filter((n) => n <= lastR).length;

  // jobs: master_list 직업수 누적합 (25×cycle 금지)
  const jobsOf = (n) => byCycle[`R${n}`].flat().length;
  const jobsTotal = cycleNums.reduce((s, n) => s + jobsOf(n), 0);
  const jobsDone = cycleNums.filter((n) => n <= lastR).reduce((s, n) => s + jobsOf(n), 0);

  // as_of: 로컬(KST) 날짜 — UTC toISOString는 자정 부근 하루 어긋남
  const d = new Date();
  const asOf = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;

  // 키 순서 = 계약 순서 (JSON.stringify 삽입순서 보존)
  const payload = {
    last_completed_r: lastR,
    kpi_done: kpiDone,
    kpi_total: kpiTotal,
    cycles_done: cyclesDone,
    cycles_total: cyclesTotal,
    jobs_done: jobsDone,
    jobs_total: jobsTotal,
    as_of: asOf,
  };
  // stdout: 마커 라인 1줄만 (데몬 정규식 매칭)
  console.log(`STORE_CAREERWIKI_PROGRESS: ${JSON.stringify(payload)}`);
}

// ─── main ───
if (hasFlag('emit-progress')) {
  emitProgress();
} else if (hasFlag('status')) {
  showStatus();
} else if (hasFlag('next-cycle')) {
  const n = findNextCycle();
  generateCycle(n);
} else if (getArg('cycle')) {
  generateCycle(parseInt(getArg('cycle'), 10), { skipDb: hasFlag('skip-db') });
} else if (getArg('resume')) {
  resumeCycle(parseInt(getArg('resume'), 10));
} else if (getArg('reset-delay') != null) {
  const r = computeResetDelay(getArg('reset-delay'));
  if (!r) {
    console.error('[error] 리셋 시각 파싱 실패. 입력에 "resets H:MMam (Asia/Seoul)" 포함 필요.');
    process.exit(1);
  }
  const hop = r.delaySec > 3600;
  console.log(`리셋 ${String(r.hh).padStart(2,'0')}:${String(r.mm).padStart(2,'0')} KST 까지 ${r.rawSec}s (버퍼 포함 ${r.delaySec}s)`);
  if (hop) console.log(`ScheduleWakeup delaySeconds=3300 (1h 초과 → 멀티홉: 깨어나 아직 리밋이면 --reset-delay 재계산 후 재예약)`);
  else console.log(`ScheduleWakeup delaySeconds=${r.delaySec} (리셋 직후 1회 재기동)`);
} else {
  console.log(`master-cycle-helper.cjs — 사용법:
  node scripts/master-cycle-helper.cjs --status        DB master 카운트 + drift 안내
  node scripts/master-cycle-helper.cjs --cycle=12      R12 batch list + prompt 생성
  node scripts/master-cycle-helper.cjs --cycle=12 --skip-db   DB cross-check 생략 (오프라인)
  node scripts/master-cycle-helper.cjs --next-cycle    미처리 다음 cycle 자동 결정 + 생성
  node scripts/master-cycle-helper.cjs --resume=48     R48 미완 직업 산출 (리밋 사망 후 재개용)
  node scripts/master-cycle-helper.cjs --emit-progress --r=50   진행 마커 1줄 emit (검증 PASS 직후 1회, 데몬→KV forward)
  node scripts/master-cycle-helper.cjs --reset-delay="resets 3:10am (Asia/Seoul)"  리셋까지 ScheduleWakeup delay 계산`);
}
