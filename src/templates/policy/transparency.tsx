/**
 * /policy/transparency — 운영 투명성 보고서 (자리표시자)
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderTransparencyPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'why',
      title: '왜 투명성 보고서를 발간하는가',
      content: `
        <p>한국 익명커뮤니티의 가장 큰 약점은 "운영 불투명"이라고 봅니다.
        디시·블라인드·에브리타임 모두 신고 처리 통계를 외부에 공개하지 않습니다.</p>
        <p>Careerwiki는 분기별로 다음 통계를 공개합니다:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>신고 접수·처리 통계 (사유별 / 처리 시간별).</li>
          <li>차단 통계 (단계별).</li>
          <li>토론 진행/종결 통계.</li>
          <li>권리침해 신고 처리 건수.</li>
          <li>잘못 처리된 사례 자기비판.</li>
        </ul>
        <p class="mt-3">사용자 개인정보는 비식별화하여 공개하며,
        운영 결정의 근거를 사용자가 검증할 수 있게 하는 것이 목적입니다.</p>
      `
    },
    {
      id: 'frequency',
      title: '발간 주기',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>분기별 (3개월) — 매 분기 마지막 달 말일 기준.</li>
          <li>발간 시점: 분기 종료 후 30일 이내.</li>
          <li>예: 1분기(1~3월) 보고서 → 4월 30일까지 발간.</li>
        </ul>
      `
    },
    {
      id: 'first-report',
      title: '첫 보고서 — 2026년 2분기',
      content: `
        <div class="callout">
          <strong>준비 중 (자리표시 단계)</strong><br>
          첫 분기별 보고서는 2026년 7월 30일에 발간됩니다.
          그 전까지는 이 페이지에 보고서 양식과 발간 일정만 공개합니다.
        </div>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">표준 양식 (예정)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>1. 사용자·콘텐츠 통계</strong> — 활성 사용자, 위키·HowTo·댓글 신규 발행 수, AI 생성·검수 비율.</li>
          <li><strong>2. 신고 처리</strong> — 사유별 접수 건수, 결정 분포(유지·삭제·경고·수정요청), 평균 처리 시간, SLA 준수율.</li>
          <li><strong>3. 제재 통계</strong> — 단계별 제재 건수, 즉시 영구 정지 사유별 분포, 소명 인용·기각 비율.</li>
          <li><strong>4. 토론·합의</strong> — 발제 건수, 합의 도달 비율, 평균 종결 기간.</li>
          <li><strong>5. 권리침해 신고</strong> — 정보통신망법 임시조치 건수, 저작권 신고 건수.</li>
          <li><strong>6. 자살·자해 대응</strong> — 자동 배너 노출 횟수, SLA 준수율, 109/1393 안내 건수.</li>
          <li><strong>7. 자기비판</strong> — 운영 결정이 잘못됐다고 판단된 사례, 개선 조치.</li>
          <li><strong>8. 정책 변경</strong> — 분기 중 개정된 정책, 개정 사유.</li>
        </ul>
      `
    },
    {
      id: 'real-time',
      title: '실시간 공개 (예정)',
      content: `
        <p>분기별 보고서 외에 다음은 가능하면 실시간 또는 월별로 공개할 예정입니다:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>현재 처리 중인 신고 건수 (집계만, 내용 비공개).</li>
          <li>이번 달 신규 등재된 직업·전공 수.</li>
          <li>이번 달 AI 검수 완료 건수.</li>
        </ul>
      `
    },
    {
      id: 'limits',
      title: '공개의 한계',
      content: `
        <p>다음은 보고서에 포함되지 않습니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>개별 사용자 식별이 가능한 정보.</li>
          <li>개별 신고·소명의 구체 내용.</li>
          <li>현재 진행 중인 권리침해 분쟁의 당사자 정보.</li>
          <li>법령상 비공개 의무가 있는 자료.</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '투명성 보고서',
      icon: 'fa-chart-bar',
      title: '운영 투명성 보고서',
      subtitle: '자리표시 단계 · 첫 발간 2026-07-30 예정',
      pageTitle: '운영 투명성 보고서',
      intro: `Careerwiki는 분기별로 신고 처리·차단·토론 통계를 공개합니다.
        한국 익명커뮤니티에서 보기 드문 시도입니다 — 운영 결정의 근거를 사용자가 검증할 수 있도록.`,
      addendum: '이 페이지는 2026년 4월 30일부터 운영되며, 첫 분기별 보고서는 2026년 7월 30일에 발간됩니다.'
    },
    sections,
    options
  )
}
