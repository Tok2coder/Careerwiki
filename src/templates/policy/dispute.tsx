/**
 * /policy/dispute — 토론·합의 절차서
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderDisputePage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'when',
      title: '제1조 토론을 여는 경우',
      content: `
        <p>다음 4가지 경우에만 정식 토론(발제)을 열 수 있습니다.
        토론 남용·잡담 발제를 막기 위함입니다.</p>
        <ol class="list-decimal list-inside space-y-1">
          <li><strong>편집 분쟁</strong> — 같은 서술을 두고 두 명 이상이 다른 방향으로 반복 편집.</li>
          <li><strong>합의 변경</strong> — 기존 합의의 내용을 바꾸려는 경우.</li>
          <li><strong>이동·삭제</strong> — 페이지 표제어 변경, 페이지 통합·삭제 제안.</li>
          <li><strong>규정 개정</strong> — 정책 문서 자체의 개정 제안.</li>
        </ol>
        <p class="mt-3">단순 질문·요청·통보 목적의 발제는 토론이 아닌 <strong>피드백 게시판</strong>으로.</p>
      `
    },
    {
      id: 'objection-quality-rule',
      title: '제1.5조 이의 제기 품질 룰 (다수결 보완)',
      content: `
        <p>나무위키의 토론 시스템에서 가장 자주 비판받는 부분은 "한 사람이 무한 갱신으로
        토론을 막을 수 있다"는 점이었습니다. Careerwiki는 다수결 원칙을 명시적으로 도입하지
        않는 대신, 다음 두 가지 룰로 그 문제를 차단합니다.</p>

        <ol class="list-decimal list-inside space-y-2">
          <li><strong>이의 제기 시 새 근거 30자 이상 필수</strong> — 단순 반대 표시(👎 또는 빈 댓글)는 받지 않습니다. 새 출처·대안·반박 근거를 함께 제시해야 이의로 인정되며, 그 이의만 이의 제기 기간을 6시간 갱신합니다.</li>
          <li><strong>동일인 1합의안 1이의 원칙</strong> — 같은 합의안에 같은 사람이 두 번째 이의를 제기하는 것은 자동 차단됩니다. 새 근거가 추가됐다면 별도 합의안으로 발의해 별도 토론을 여세요.</li>
        </ol>

        <p class="mt-3">이 두 룰이 충족되지 않으면 시스템이 자동으로 거부합니다(<code>OBJECTION_REQUIRES_EVIDENCE</code> /
        <code>OBJECTION_DUPLICATE_OBJECTOR</code>). 운영자 개입 없이도 토론 무한 연장 시도를 막습니다.</p>
      `
    },
    {
      id: 'flow',
      title: '제2조 토론 흐름',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>발제</strong> — 분쟁 페이지 우측 또는 하단의 "토론 열기" 버튼. 분쟁 대상 서술과 자기 입장 명시.</li>
          <li><strong>서술 시점 고정</strong> — 분쟁 대상 서술은 토론 진행 중 변경 불가 (양측 합의로 임시 합의안 적용 가능).</li>
          <li><strong>의견 교환</strong> — 양측이 출처와 함께 입장 제시.</li>
          <li><strong>합의안 제시</strong> — 한쪽 또는 양측이 절충안 제안.</li>
          <li><strong>동의자 1명 이상</strong> — 발제자 외 1명 이상이 합의안에 동의.</li>
          <li><strong>이의 제기 기간</strong> — 최소 48시간 + 6시간 간격 2회 갱신 (이의 제기 시 갱신).</li>
          <li><strong>종결</strong> — 이의 제기 기간 내 새 의견 없으면 합의 성립. 본문 반영.</li>
        </ol>
      `
    },
    {
      id: 'burden',
      title: '제3조 입증 책임 — 누가 출처를 대야 하나',
      content: `
        <p>분쟁 처리의 핵심은 "누가 출처를 댈 책임이 있는가"입니다.</p>
        <table>
          <thead><tr><th>상황</th><th>입증 책임</th></tr></thead>
          <tbody>
            <tr>
              <td>신규 서술 (추가 후 7일 미만)</td>
              <td>추가자 (입증 책임 추가)</td>
            </tr>
            <tr>
              <td>기존 서술 (추가 후 7일 이상) — 양측 출처 동등</td>
              <td>양측 토론·합의</td>
            </tr>
            <tr>
              <td>8순위 출처만으로 작성된 서술</td>
              <td>존치측 (5순위 이상 보강 의무)</td>
            </tr>
            <tr>
              <td>AI 생성 데이터</td>
              <td>존치측 자동 적용 (AI 출처 검증 책임)</td>
            </tr>
            <tr>
              <td>"개인 의견" 라벨 단락</td>
              <td>출처 등급 룰 적용 안 함 — 라벨 명시만 확인</td>
            </tr>
          </tbody>
        </table>
        <p class="mt-3"><a href="/policy/source-tier" class="text-blue-300 hover:underline">출처 신뢰성 등급표</a>를 참조하세요.</p>
      `
    },
    {
      id: 'consensus-form',
      title: '제4조 합의안 작성 형식',
      content: `
        <p>합의안은 다음 형식으로 토론 댓글에 직접 작성합니다.</p>
        <pre class="bg-slate-800/50 p-3 rounded-lg text-xs text-slate-300 overflow-x-auto">
[합의안]
- 분쟁 대상: [원래 서술]
- 변경 후: [합의된 서술]
- 출처: [N순위 출처 URL]
- 발효 시점: 이의 제기 기간 종료 후
        </pre>
        <p class="mt-3">합의안은 사용자 문서·외부 링크로 대체할 수 없습니다 (검증 가능성 보장).</p>
      `
    },
    {
      id: 'multi-discussion',
      title: '제5조 같은 주제 반복 토론',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>같은 페이지의 같은 서술에 대해 이전 토론이 종결된 후 7일 이내 재발제 시:
            발제자가 이전 토론 링크 + 새 근거(이전에 제시 안 됐던 출처) 의무.</li>
          <li>3회째 발제부터 운영자 사전 승인 필요.</li>
          <li>새 사실관계 발견 (예: 공공데이터 갱신) 시에는 위 룰 예외.</li>
        </ul>
      `
    },
    {
      id: 'mediation',
      title: '제6조 중재',
      content: `
        <p>토론이 진척되지 않을 때 중재자(운영자)가 개입할 수 있습니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>중재자는 양측에 근거 제시 강제.</li>
          <li>발언권 제한·정리 가능.</li>
          <li>토론당 최대 3회·참여자당 1회 중재자 교체 요청 가능.</li>
          <li>중재자 자기 사안 회피 의무 (이해충돌).</li>
        </ul>
      `
    },
    {
      id: 'invalidation',
      title: '제7조 합의 무효화',
      content: `
        <p>다음 사유로 합의가 무효화될 수 있습니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>합의 근거가 된 사실관계가 변경됨 (예: 인용 통계가 변경).</li>
          <li>합의 참여자 중 부정 접속(다중계정·차단 회피)이 발견됨.</li>
          <li>합의 과정에 운영 방해(외부 동원 등)가 있었음이 확인됨.</li>
        </ul>
        <p class="mt-3">무효화 후 7일 이내 이의 제기 가능. 그 후에는 새 토론으로.</p>
      `
    },
    {
      id: 'manners',
      title: '제8조 토론 매너',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>존댓말. 인신공격 금지.</li>
          <li>근거 없는 주장 금지 — 사실 주장에는 출처.</li>
          <li><strong>생성형 AI로 댓글·반박 작성 금지</strong> (나무위키 차용 — 토론은 사람의 판단이 우선).</li>
          <li>외부 커뮤니티에서 동원해 토론에 영향 주는 행위 금지.</li>
          <li>같은 사람이 닉네임만 바꿔 가짜 동의 만들기 금지.</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '토론·합의',
      icon: 'fa-comments-dollar',
      title: '토론·합의 절차서',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: '토론·합의 절차서',
      intro: `편집 분쟁이 났을 때 어떻게 토론하고 합의하는지에 대한 절차입니다.
        분쟁 자체는 자연스러운 일이고, 좋은 합의가 위키의 품질을 만듭니다.`,
      addendum: '이 절차서는 2026년 4월 30일부터 시행합니다.'
    },
    sections,
    options
  )
}
