/**
 * /policy/wiki/major — 전공위키 편집지침
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderWikiMajorPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'scope',
      title: '제1조 적용 범위',
      content: `
        <p>이 지침은 <code>/major/{슬러그}</code>에 위치한 모든 전공 페이지의 작성·편집에 적용됩니다.</p>
        <p>전공위키는 직업위키와 데이터 성격이 다소 다르지만, 출처 등급·서술 규칙은 거의 동일합니다.
        이 지침에 명시되지 않은 사항은 <a href="/policy/wiki/job" class="text-blue-300 hover:underline">직업위키 편집지침</a>을 준용합니다.</p>
      `
    },
    {
      id: 'inclusion',
      title: '제2조 등재 기준',
      content: `
        <p>다음 중 <strong>하나만 충족</strong>해도 등재 가능합니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li>한국교육개발원(KEDI) 학과 분류에 등재.</li>
          <li>교육부 학과 분류표 등재.</li>
          <li>실제 4년제·전문대·대학원에 개설된 학과·전공.</li>
          <li>해외 대학에 개설된 전공으로, 한국에서 진학 가능한 정규 학사 과정.</li>
          <li>5순위 이상 출처에 학과·전공으로 다뤄진 신규/융합 전공.</li>
        </ol>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">등재가 거절되는 경우</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>비공식 자격증 과정·사설 학원 코스</li>
          <li>학과가 아닌 단순 단기 부트캠프</li>
          <li>특정 한 학교에만 임시 개설되어 폐과된 전공</li>
        </ul>
      `
    },
    {
      id: 'title',
      title: '제3조 표제어 규칙',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li>1순위: 교육부·KEDI 표준 학과명.</li>
          <li>2순위: 다수 대학에서 공통적으로 쓰는 학과명.</li>
          <li>3순위: 한국대학교육협의회 학과명.</li>
          <li>비슷한 이름의 학과는 구분자 사용 (예: <code>경영학과</code>, <code>경영정보학과</code>, <code>국제경영학과</code>).</li>
        </ol>
      `
    },
    {
      id: 'sources',
      title: '제4조 데이터 출처',
      content: `
        <p>전공 데이터는 다음 출처를 우선합니다.</p>
        <ol class="list-decimal list-inside space-y-1">
          <li><strong>1순위</strong>: 교육부 대학공시 정보 (대학알리미), 한국교육개발원(KEDI), 한국직업능력연구원.</li>
          <li><strong>2순위</strong>: 한국대학교육협의회, 고용24, 워크넷의 전공별 취업 정보.</li>
          <li><strong>3순위</strong>: 학교별 공식 학과 홈페이지 (커리큘럼·교수진 정보).</li>
          <li><strong>4순위</strong>: 학과 평가 인증 기관 (ABEEK, ACBSP 등).</li>
          <li><strong>5순위</strong>: 학회·전공 협의회 공식 자료.</li>
          <li><strong>6~8순위</strong>: 직업위키 출처 등급과 동일 기준.</li>
        </ol>
        <p class="mt-3">취업률·첫 월급·만족도 같은 통계는 <strong>대학알리미·KEDI</strong>를 직접 인용 권장.</p>
      `
    },
    {
      id: 'sections',
      title: '제5조 표준 섹션 구조',
      content: `
        <p>전공 페이지는 다음 순서로 구성합니다.</p>
        <ol class="list-decimal list-inside space-y-1">
          <li>개요 — 전공의 정의와 학습 목표</li>
          <li>주요 교육 과정 — 핵심 과목·커리큘럼</li>
          <li>입시·진학 — 수시·정시 전형, 입학 경쟁률</li>
          <li>장학·학비 — 평균 학비, 장학금 제도</li>
          <li>진출 분야 — 졸업 후 진출 가능한 직업·산업</li>
          <li>관련 자격·시험 — 기사·기능사·국가시험</li>
          <li>대학원·해외 진학 — 대학원 진학률, 해외 사례</li>
          <li>현직자·졸업자 후기 (선택) — "[개인 의견]" 라벨 필수</li>
          <li>관련 직업 — 직업위키 페이지 링크</li>
          <li>참고 자료 — 출처 목록</li>
        </ol>
      `
    },
    {
      id: 'school-comparison',
      title: '제6조 학교별 비교 작성 원칙',
      content: `
        <p>같은 전공이라도 학교마다 커리큘럼·취업률·문화가 다릅니다.
        다음 원칙을 따릅니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>학교 간 우열 단정 금지 — "○○대가 ○○대보다 낫다" 식 표현 금지.</li>
          <li>객관 통계 인용은 가능 — "○○대 평균 취업률 80%, △△대 70% (2024 대학알리미)".</li>
          <li>현직자·졸업자 후기는 [개인 의견] 라벨 필수.</li>
          <li>특정 학교를 비방하는 댓글·후기는 <a href="/policy/community" class="text-blue-300 hover:underline">커뮤니티 운영지침</a> 적용.</li>
        </ul>
      `
    },
    {
      id: 'narrative',
      title: '제7조 서술 규칙',
      content: `
        <p>직업위키와 동일합니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>사실/의견 분리 — 의견은 [개인 의견] 라벨.</li>
          <li>호평/비판 통합 작성 — 분리 챕터 금지.</li>
          <li>가치판단 형용사 단독 사용 금지.</li>
          <li>"추가 바람", "수정 바람" 표시 금지.</li>
          <li>학과·교수 비방·비하 금지.</li>
          <li>학과 모집정원·경쟁률·등록금 같은 수치는 매년 업데이트 필요 — "○○년도 기준" 명시.</li>
        </ul>
      `
    },
    {
      id: 'edit-flow',
      title: '제8조 편집 절차',
      content: `
        <p>직업위키와 동일합니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>편집 권한 — 가입 1일 이상 일반 편집, 7일 + 5건 이상 보호된 페이지.</li>
          <li>편집 요약 5자 이상 의무.</li>
          <li>신규/기존 서술 7일 기준선.</li>
        </ul>
      `
    },
    {
      id: 'image',
      title: '제9조 이미지·미디어',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>대표 이미지는 R2의 <code>majors/major-{슬러그}.webp</code> 경로.</li>
          <li>학교 캠퍼스·강의실 사진은 본인 촬영·CC 라이선스·공공저작물만.</li>
          <li>특정 학교 로고를 학과 페이지에 무단 사용 금지 — 학과 일반 이미지로 대체.</li>
          <li>AI 생성 이미지는 caption에 "AI 생성" 명시.</li>
        </ul>
      `
    },
    {
      id: 'dispute',
      title: '제10조 분쟁 처리',
      content: `
        <p>직업위키 편집지침과 동일하게 <a href="/policy/dispute" class="text-blue-300 hover:underline">토론·합의 절차서</a>를 따릅니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>학교 간 우열·등수 분쟁은 객관 통계로만 합의.</li>
          <li>특정 학교에서 "우리 학과 정보가 오류다"라는 신고는 학교 홈페이지·대학알리미와 대조.</li>
          <li>학과 폐과·통합 정보는 학교 공식 발표 우선.</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '전공위키 편집',
      icon: 'fa-graduation-cap',
      title: '전공위키 편집지침',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: '전공위키 편집지침',
      intro: `전공 페이지의 작성·편집에 적용되는 규칙입니다.
        직업위키 편집지침과 거의 같지만, 학과·진학·학교 비교 관련 추가 조항이 있습니다.`,
      addendum: '이 지침은 2026년 4월 30일부터 시행합니다.'
    },
    sections,
    options
  )
}
