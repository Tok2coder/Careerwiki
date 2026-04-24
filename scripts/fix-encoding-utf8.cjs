'use strict';
// UTF-8 인코딩 수정 스크립트
// curl -d 로 전송 시 CP949 저장된 데이터를 Node.js fetch로 재저장

const API_BASE = 'https://careerwiki.org/api/job';
const HEADERS = {
  'Content-Type': 'application/json',
  'X-Admin-Secret': 'careerwiki-admin-2026',
};

async function editJob(id, payload) {
  const res = await fetch(`${API_BASE}/${id}/edit`, {
    method: 'POST',
    headers: HEADERS,
    body: JSON.stringify(payload),
  });
  const json = await res.json();
  console.log(`[${id}] →`, JSON.stringify(json));
  return json;
}

async function main() {
  // ── 1. 게임시나리오작가 (ID: 1765284123866152) ──────────────────
  console.log('\n=== 게임시나리오작가 수정 ===');
  await editJob('1765284123866152', {
    fields: {
      detailReady: {
        curriculum: [
          '문예창작학과 또는 국어·국문학과에서 서사 구성력 교육 이수',
          '게임공학과에서 게임 시스템·엔진 이해 기반 시나리오 기획 역량 교육',
          '게임콘텐츠과에서 게임 기획 실무 전문학사 과정 이수',
          '만화·애니메이션학과에서 스토리보드 및 캐릭터 서사 설계 역량 연계',
          '한국콘텐츠진흥원 게임인재원 기획학과 무료 2년 과정 이수 (연 1회 공개모집)[1]',
        ],
        recruit: [
          '게임잡을 통해 게임사 시나리오·기획 직군 채용공고 지원[1]',
          '넷마블 공식 채용 페이지에서 게임기획·시나리오 직무 공개채용 지원[2]',
          '모바일 게임 스타트업 채용 공고 상시 지원[3]',
        ],
        training: [
          '한국콘텐츠진흥원 게임인재원 기획학과 2년 과정 이수 (무료, 채용 연계)[1]',
        ],
      },
      overviewProspect: {
        main: '한국 게임산업은 연 매출 약 23조 원(2023년 기준)의 세계 4위 규모로 지속 성장하고 있어 게임시나리오작가의 고용 전망은 중장기적으로 안정적이다. 서사형 오픈월드 RPG와 대형 멀티플레이 게임의 확대로 시나리오 수요가 늘어나는 반면, AI 글쓰기 도구가 단순 반복 대사 작업 일부를 보조할 가능성도 있어 세계관 설계·캐릭터 심리 묘사 등 창의적 서사 역량이 더욱 중요해지고 있다.[1]',
      },
    },
    sources: {
      'detailReady.curriculum': [
        { id: 1, text: '한국콘텐츠진흥원 게임인재원 기획학과', url: 'https://www.kocca.kr/kocca/subPage.do?menuNo=204951' },
      ],
      'detailReady.recruit': [
        { id: 1, text: '게임잡 채용공고', url: 'https://www.gamejob.co.kr/Recruit/Main' },
        { id: 2, text: '넷마블 공식 채용', url: 'https://career.netmarble.com/announce' },
        { id: 3, text: '원티드 게임 기획·시나리오 채용공고', url: 'https://www.wanted.co.kr/search?query=게임+시나리오' },
      ],
      'detailReady.training': [
        { id: 1, text: '한국콘텐츠진흥원 게임인재원 기획학과', url: 'https://www.kocca.kr/kocca/subPage.do?menuNo=204951' },
      ],
      'overviewProspect.main': [
        { id: 1, text: '한국콘텐츠진흥원 2024 게임백서', url: 'https://www.kocca.kr/kocca/koccanews/reportview.do?menuNo=204767&nttNo=869' },
      ],
    },
    changeSummary: 'CP949 인코딩 오류 수정: detailReady 전체 + overviewProspect UTF-8 재저장',
  });

  // ── 2. 나무의사 (ID: 1765283654596147) ─────────────────────────
  console.log('\n=== 나무의사 수정 ===');
  await editJob('1765283654596147', {
    fields: {
      sidebarCerts: [
        { name: '나무의사', url: 'https://namudr.kofpi.or.kr/intro/ExamIntro.do?MENU_ID=A-01-00' },
      ],
      overviewProspect: {
        main: '나무의사 국가 면허는 2019년 신설된 이래 면허 보유자가 꾸준히 증가하고 있다. 도시화로 인한 수목 관리 수요 확대와 기후변화에 따른 병해충·고사 피해 증가, 천연기념물·보호수 보전 정책 강화로 전문 수목 진료 서비스에 대한 수요는 지속적으로 늘 전망이다.[1] 면허직 특성상 의무 정년이 없어 60대 이상 취업자 비율이 69.6%에 달하는 중장년 친화 직업으로, 은퇴 후 제2 직업으로도 각광받고 있다.[2]',
      },
    },
    sources: {
      'overviewProspect.main': [
        { id: 1, text: '한국임업진흥원 나무의사 시험안내', url: 'https://namudr.kofpi.or.kr/intro/ExamIntro.do?MENU_ID=A-01-00' },
        { id: 2, text: '나무의사 현황 및 전망 기사', url: 'https://v.daum.net/v/20260228110158467' },
      ],
    },
    changeSummary: 'CP949 인코딩 오류 수정: sidebarCerts + overviewProspect UTF-8 재저장',
  });

  // ── 3. 차량용데이터플랫폼응용개발자 (ID: 1765283704259479) ────────
  console.log('\n=== 차량용데이터플랫폼응용개발자 수정 ===');
  await editJob('1765283704259479', {
    fields: {
      detailReady: {
        curriculum: [
          '컴퓨터공학·소프트웨어공학·전자공학·자동차공학 등 관련 4년제 학과 졸업',
          'C/C++ 임베디드 시스템 프로그래밍 심화 학습',
          'AUTOSAR·RTOS(실시간 운영체제) 관련 교육 이수',
          'ISO 26262·A-SPICE 자동차 기능안전 과정 이수[1]',
          '현대오토에버 모빌리티 임베디드 SW 스쿨 등 채용연계형 집중 교육(6개월, 1,000시간) 이수[2]',
        ],
        recruit: [
          '현대오토에버·현대모비스 등 현대차그룹 SW 계열사 공식 채용 지원[1]',
          'LG전자·삼성전자 등 자동차 전장 부품사 공채 및 수시 채용 지원[2]',
          '자동차 SW 전문 중소·중견 기업에 포트폴리오로 지원[3]',
        ],
        training: [
          '현대오토에버 모빌리티 임베디드 SW 스쿨 — 6개월·1,000시간 집중 교육, 내일배움카드 활용 무료 수강, 우수 수료생 채용 연계',
          '한국전파진흥협회 DX캠퍼스에서 임베디드 SW 관련 교육과정 운영[1]',
        ],
      },
      sidebarCerts: [
        { name: '정보처리기사', url: 'https://www.q-net.or.kr/crf005.do?id=crf00503&jmCd=1320' },
        { name: '임베디드소프트웨어개발자격증(CESD)', url: 'https://www.oss.kr/cesd' },
      ],
    },
    sources: {
      'detailReady.curriculum': [
        { id: 1, text: '원티드 현대오토에버 SDV Platform SW Developer 채용공고', url: 'https://www.wanted.co.kr/wd/288238' },
        { id: 2, text: '한국경제 현대오토에버 모빌리티 임베디드 SW 스쿨 4기', url: 'https://www.hankyung.com/article/2024103105895' },
      ],
      'detailReady.recruit': [
        { id: 1, text: '현대오토에버 공식 채용사이트', url: 'https://career.hyundai-autoever.com' },
        { id: 2, text: 'LG전자 채용사이트', url: 'https://careers.lg.com/kr/' },
        { id: 3, text: '잡코리아 신입·경력 채용정보', url: 'https://www.jobkorea.co.kr/starter/' },
      ],
      'detailReady.training': [
        { id: 1, text: '한국경제 현대오토에버 모빌리티 임베디드 SW 스쿨 4기', url: 'https://www.hankyung.com/article/2024103105895' },
      ],
    },
    changeSummary: 'CP949 인코딩 오류 수정: detailReady 전체 + sidebarCerts UTF-8 재저장',
  });

  console.log('\n✅ 수정 완료. DB 확인 권장.');
}

main().catch(err => { console.error(err); process.exit(1); });
