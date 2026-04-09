#!/usr/bin/env node
/**
 * fix-batch74-sources.cjs
 *
 * 배치 #74-78 직업 5개의 curriculum/training 출처 추가 +
 * 건축가(건축설계사)/건축감리기술자 recruit 출처 URL 수정.
 *
 * 사용법:
 *   node scripts/fix-batch74-sources.cjs --dry-run
 *   node scripts/fix-batch74-sources.cjs --execute
 */

const https = require('https');

const DRY_RUN = process.argv.includes('--dry-run');
const EXECUTE = process.argv.includes('--execute');

if (!DRY_RUN && !EXECUTE) {
  console.error('Usage: node scripts/fix-batch74-sources.cjs --dry-run');
  console.error('       node scripts/fix-batch74-sources.cjs --execute');
  process.exit(1);
}

const API_BASE = 'https://careerwiki.org';
const ADMIN_SECRET = 'careerwiki-admin-2026';

function apiCall(method, path, body) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const url = new URL(API_BASE + path);
    const options = {
      hostname: url.hostname,
      path: url.pathname,
      method,
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data),
        'X-Admin-Secret': ADMIN_SECRET,
      },
    };
    const req = https.request(options, (res) => {
      let buf = '';
      res.on('data', c => buf += c);
      res.on('end', () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(buf) }); }
        catch { resolve({ status: res.statusCode, body: buf }); }
      });
    });
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Payloads (각 직업별)
// ─────────────────────────────────────────────────────────────────────────────

const JOBS = [

  // ── 건축가(건축설계사) ──────────────────────────────────────────────────────
  {
    id: '176528344210340',
    name: '건축가(건축설계사)',
    fields: {
      detailReady: {
        curriculum: [
          '건축설계 스튜디오 — 설계 과정 전반에 걸쳐 공간 구성과 도면 표현 능력 배양',
          '건축구조 — RC·철골·목구조 등 구조 시스템의 원리와 계산법 학습',
          '건축환경 및 설비 — 채광·단열·냉난방·급배수 등 건물 환경 성능 이해',
          'BIM(빌딩정보모델링) — Revit·ArchiCAD 등 소프트웨어를 활용한 3D 통합 설계',
          '건축법규 — 건축법·건축기준·소방법 등 국내외 건축 관련 법령 이해',
          '도시설계 및 단지계획 — 도시 구조와 주거 단지 설계 원리 학습.[1]',
        ],
        training: [
          '건축사 실무 수련 3년 — 건축사사무소에서 건축사 자격시험 응시 전 이수 필수',
          '한국건축사협회 건축사 연수원 교육 — 자격 취득 후 전문성 강화를 위한 계속교육',
          'BIM 기반 통합 설계 실무 교육 — 한국BIM학회 및 민간 교육기관 제공.[1]',
        ],
      },
    },
    sources: {
      'overviewProspect.main': [{ id: 1, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=23' }],
      'overviewSalary.sal': [{ id: 2, text: '[2] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=23' }],
      trivia: [{ id: 3, text: '[3] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=23' }],
      way: [
        { id: 4, text: '[4] 한국건축사협회', url: 'https://www.kira.or.kr/index.do' },
        { id: 5, text: '[5] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=23' },
        { id: 6, text: '[6] 대한건축학회', url: 'https://www.aik.or.kr/' },
      ],
      'detailReady.recruit': [
        // saramin 카테고리 검색 URL → 사람인 메인으로 교체
        { id: 7, text: '[1] 사람인 건축설계 채용정보', url: 'https://www.saramin.co.kr' },
      ],
      'detailReady.curriculum': [
        { id: 8, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=23' },
      ],
      'detailReady.training': [
        { id: 9, text: '[1] 한국건축사협회', url: 'https://www.kira.or.kr/index.do' },
      ],
    },
    changeSummary: 'curriculum/training 출처 추가, recruit 출처 URL 수정 (saramin cat_kewd 검색URL → 메인)',
  },

  // ── 건축감리기술자 ─────────────────────────────────────────────────────────
  {
    id: '1765283440746327',
    name: '건축감리기술자',
    fields: {
      detailReady: {
        curriculum: [
          '건축시공 — 건축물 시공 공정 및 공법에 대한 전반적인 이해',
          '건축구조 — 구조 설계 도면 검토와 현장 적용을 위한 구조역학 이해',
          '건축법규 — 건축법·건설기술진흥법 등 감리 관련 법령 학습',
          '건축재료 및 품질관리 — 건축 자재 선정 기준과 품질 검사 절차 학습',
          '건설안전 — 산업안전보건법 기반의 현장 안전 관리 원칙.[1]',
        ],
        training: [
          '건설기술인 교육 — 한국건설기술인협회 의무 교육 이수(신규·계속 교육)',
          '건설감리 역량 강화 교육 — 대한건설협회 및 건설기술교육원 전문 교육.[1]',
        ],
      },
    },
    sources: {
      'overviewProspect.main': [{ id: 1, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=76' }],
      'overviewSalary.sal': [{ id: 2, text: '[2] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=76' }],
      trivia: [{ id: 3, text: '[3] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=76' }],
      way: [
        { id: 4, text: '[4] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=76' },
        { id: 5, text: '[5] 워크넷 직업정보', url: 'https://www.work24.go.kr/cm/f/cvl/retrieveOccpDtl.do?SEQ=CC1010050' },
      ],
      'detailReady.recruit': [
        // jobkorea 검색결과 URL → jobkorea 메인으로 교체
        { id: 6, text: '[1] 잡코리아 건축감리 채용정보', url: 'https://www.jobkorea.co.kr' },
      ],
      'detailReady.curriculum': [
        { id: 7, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=76' },
      ],
      'detailReady.training': [
        { id: 8, text: '[1] 한국건설기술인협회', url: 'https://www.kocea.or.kr' },
      ],
    },
    changeSummary: 'curriculum/training 출처 추가, recruit 출처 URL 수정 (jobkorea 검색URL → 메인)',
  },

  // ── 건축공학기술자 ─────────────────────────────────────────────────────────
  {
    id: '1765283282556876',
    name: '건축공학기술자',
    fields: {
      detailReady: {
        curriculum: [
          '건축공학과·토목공학과·도시공학과 진학 — 구조역학·유체역학·토목시공 기초 과목 충실 이수',
          '토목기사·건축기사 자격증 취득 준비 — 한국산업인력공단(q-net.or.kr) 시험 일정 및 응시 자격 확인',
          '대형 건설사·엔지니어링 회사 현장 실습·인턴십 — 시공 현장 경험 및 취업 연결.[1]',
        ],
        training: [
          '토목기사·건축기사 자격 취득 후 → 토목시공기술사·건축시공기술사 도전 — 프로젝트 관리직 핵심 자격',
          'BIM(Revit·AutoCAD Civil3D) 전문 교육 — 스마트 건설 시대 디지털 설계 역량 강화',
          'PMP(프로젝트 관리 전문가) 자격 취득 — 글로벌 건설 프로젝트 관리 역량 인정.[1]',
        ],
      },
    },
    sources: {
      'overviewProspect.main': [{ id: 1, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=46' }],
      'overviewSalary.sal': [{ id: 2, text: '[2] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=46' }],
      trivia: [{ id: 3, text: '[3] 한국건설산업연구원', url: 'https://www.cerik.re.kr' }],
      way: [
        { id: 4, text: '[4] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=46' },
        { id: 5, text: '[5] 한국건설기술인협회', url: 'https://www.kocea.or.kr' },
      ],
      'detailReady.recruit': [
        { id: 6, text: '[1] 잡코리아 채용정보', url: 'https://www.jobkorea.co.kr' },
        { id: 7, text: '[2] 사람인 채용정보', url: 'https://www.saramin.co.kr' },
      ],
      'detailReady.curriculum': [
        { id: 8, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=46' },
      ],
      'detailReady.training': [
        { id: 9, text: '[1] 한국산업인력공단 Q-net', url: 'https://www.q-net.or.kr' },
      ],
    },
    changeSummary: 'curriculum/training 출처 추가 (커리어넷, Q-net)',
  },

  // ── 건축구조기술자 ─────────────────────────────────────────────────────────
  {
    id: '1765283441570636',
    name: '건축구조기술자',
    fields: {
      detailReady: {
        curriculum: [
          '건축구조역학 전공 이수',
          '구조해석 프로그램(ETABS, MIDAS) 학습',
          '건축 관련 법규 및 기준 공부',
          'BIM 기반 구조 설계 실습.[1]',
        ],
        training: [
          '건축기사 취득 후 구조 심화 학습',
          '건축구조기술사 자격 취득',
          '내진설계 전문 교육 이수',
          '해외 구조 기준 스터디.[1]',
        ],
      },
    },
    sources: {
      'overviewProspect.main': [{ id: 1, text: '[1] 한국건설기술연구원', url: 'https://www.kict.re.kr' }],
      'overviewSalary.sal': [{ id: 2, text: '[2] 워크넷 직업정보', url: 'https://www.work24.go.kr/cm/f/cvl/retrieveOccpDtl.do?SEQ=CC1020010' }],
      trivia: [{ id: 3, text: '[3] 대한건축학회', url: 'https://www.aik.or.kr' }],
      way: [
        { id: 4, text: '[4] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=77' },
        { id: 5, text: '[5] 워크넷 직업정보', url: 'https://www.work24.go.kr/cm/f/cvl/retrieveOccpDtl.do?SEQ=CC1020010' },
      ],
      'detailReady.recruit': [
        { id: 6, text: '[1] 잡코리아 채용정보', url: 'https://www.jobkorea.co.kr' },
        { id: 7, text: '[2] 사람인 채용정보', url: 'https://www.saramin.co.kr' },
      ],
      'detailReady.curriculum': [
        { id: 8, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=77' },
      ],
      'detailReady.training': [
        { id: 9, text: '[1] 대한건축학회', url: 'https://www.aik.or.kr' },
      ],
    },
    changeSummary: 'curriculum/training 출처 추가 (커리어넷, 대한건축학회)',
  },

  // ── 건축목공 ──────────────────────────────────────────────────────────────
  {
    id: '1765283494731969',
    name: '건축목공',
    fields: {
      detailReady: {
        curriculum: [
          '직업훈련원(폴리텍대학, 건설기술교육원) 목공 기초 과정 이수',
          '내일배움카드 활용 건축목공 직업훈련 수강',
          '건축목공기능사 자격증 취득 준비',
          '현장 조공으로 숙련 기능공 아래 실무 학습',
          '안전 교육(건설근로자공제회) 이수로 현장 자격 획득.[1]',
        ],
        training: [
          '건축목공기능사 자격 취득 (한국산업인력공단)',
          '거푸집기능사 자격 추가 취득으로 단가 향상',
          '한식목공 전통 기술 교육 이수 (문화재 수리 분야 진출)',
          '건설안전기사·산업안전기사 자격 취득으로 안전 관리 역할 확장.[1]',
        ],
      },
    },
    sources: {
      'overviewProspect.main': [
        { id: 1, text: '[1] 커리어넷 직업전망', url: 'https://www.career.go.kr/cloud/w/job/view?seq=78' },
        { id: 2, text: '[2] 한국건설산업연구원', url: 'https://www.cerik.re.kr' },
      ],
      'overviewSalary.sal': [{ id: 3, text: '[3] 워크넷 임금정보', url: 'https://www.work24.go.kr/cm/f/cvl/retrieveOccpDtl.do?SEQ=CC2040010' }],
      trivia: [{ id: 4, text: '[4] 한국산업인력공단 Q-net', url: 'https://www.q-net.or.kr' }],
      way: [
        { id: 5, text: '[5] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=78' },
        { id: 6, text: '[6] 한국산업인력공단 Q-net', url: 'https://www.q-net.or.kr' },
      ],
      'detailReady.recruit': [
        { id: 7, text: '[1] 건설워커 채용정보', url: 'https://www.worker.co.kr' },
        { id: 8, text: '[2] 잡코리아 채용정보', url: 'https://www.jobkorea.co.kr' },
      ],
      'detailReady.curriculum': [
        { id: 9, text: '[1] 커리어넷 직업정보', url: 'https://www.career.go.kr/cloud/w/job/view?seq=78' },
      ],
      'detailReady.training': [
        { id: 10, text: '[1] 한국산업인력공단 Q-net', url: 'https://www.q-net.or.kr' },
      ],
    },
    changeSummary: 'curriculum/training 출처 추가 (커리어넷, Q-net)',
  },
];

async function main() {
  console.log('\n=== fix-batch74-sources ===');
  console.log(`모드: ${DRY_RUN ? 'DRY-RUN' : 'EXECUTE'}`);

  for (const job of JOBS) {
    console.log(`\n── ${job.name} (${job.id}) ──`);
    console.log(`  curriculum 마지막 항목: "${(job.fields.detailReady.curriculum.at(-1) || '').slice(-50)}"`);
    console.log(`  training 마지막 항목:   "${(job.fields.detailReady.training.at(-1) || '').slice(-50)}"`);
    console.log(`  추가 sources: detailReady.curriculum(id:${job.sources['detailReady.curriculum']?.[0]?.id}), detailReady.training(id:${job.sources['detailReady.training']?.[0]?.id})`);
    if (job.sources['detailReady.recruit']?.some(s => s.url && !s.url.includes('?'))) {
      console.log(`  recruit 출처: ${job.sources['detailReady.recruit'].map(s => s.url).join(', ')}`);
    }

    if (DRY_RUN) continue;

    const payload = {
      fields: job.fields,
      sources: job.sources,
      changeSummary: job.changeSummary,
    };

    try {
      const res = await apiCall('POST', `/api/job/${job.id}/edit`, payload);
      if (res.status >= 200 && res.status < 300) {
        console.log(`  ✅ 성공 (HTTP ${res.status})`);
      } else {
        console.log(`  ❌ 실패 (HTTP ${res.status}): ${JSON.stringify(res.body)}`);
      }
    } catch (err) {
      console.log(`  ❌ 에러: ${err.message}`);
    }

    await new Promise(r => setTimeout(r, 600));
  }

  if (DRY_RUN) {
    console.log('\n[DRY-RUN] 실제 변경 없음. --execute 플래그로 재실행하면 저장됩니다.\n');
  } else {
    console.log('\n=== 완료 ===\n');
  }
}

main().catch(err => {
  console.error('Fatal:', err);
  process.exit(1);
});
