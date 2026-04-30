/**
 * /policy/enforcement — 신고·이의·제재 절차서
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderEnforcementPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'overview',
      title: '제1조 개요',
      content: `
        <p>이 절차서는 신고 접수, 검토, 제재 결정, 이의제기까지의 전 과정을 다룹니다.</p>
        <p>대상은 댓글뿐만 아니라 위키·HowTo 편집권 남용도 포함합니다.</p>
      `
    },
    {
      id: 'phase1',
      title: '제2조 Phase 1 — 신고 접수',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 사용자 신고</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>댓글·게시물 옆 "신고" 버튼 → 사유 6종 드롭다운:
            <ul class="list-disc list-inside ml-6 mt-1 text-sm">
              <li>혐오·차별</li>
              <li>욕설·인신공격</li>
              <li>허위 사실·명예훼손</li>
              <li>개인정보 노출</li>
              <li>스팸·광고·도배</li>
              <li>기타 (20자 이상 텍스트 의무)</li>
            </ul>
          </li>
          <li>"기타" 선택 시 텍스트 입력 20자 이상 강제 — 묻지마 신고 어뷰징 방어.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 신고권 가드</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>신규 가입 24시간 이내: 신고권 제한.</li>
          <li>허위 신고 누적 3회: 신고권 박탈 (링커리어 모델).</li>
          <li>같은 IP에서 같은 게시물에 다중 신고 시 1건으로 합산.</li>
        </ul>
      `
    },
    {
      id: 'phase2',
      title: '제3조 Phase 2 — 자동 1차 분류 (5분 내)',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>AI 분류기로 명백 위반(<a href="/policy/community#block-reasons" class="text-blue-300 hover:underline">커뮤니티 §3-A 즉시 삭제 사유</a>) 검출 → <strong>자동 임시가림</strong> (즉시 삭제 X).</li>
          <li>회색지대(§3-B/D)는 자동 처리 보류 → Phase 3로.</li>
          <li><strong>금지: 신고 N개 누적 → 자동 삭제</strong> (에브리타임 실패 차용 금지).</li>
        </ul>
      `
    },
    {
      id: 'phase3',
      title: '제4조 Phase 3 — 사람 검토 (24~72시간)',
      content: `
        <p>운영자가 검토 후 4가지 결과 중 하나로 결정합니다.</p>
        <table>
          <thead><tr><th>결과</th><th>의미</th></tr></thead>
          <tbody>
            <tr><td><strong>유지</strong></td><td>위반 아님. 임시가림 해제, 신고자에게 사유 통지.</td></tr>
            <tr><td><strong>삭제</strong></td><td>명백 위반 또는 다수 위반. 작성자에게 위반 조항+이의제기 안내.</td></tr>
            <tr><td><strong>경고+유지</strong></td><td>경계선 위반 — 한 번만 봐주고 작성자에게 경고.</td></tr>
            <tr><td><strong>작성자 수정요청</strong></td><td>(잡플래닛 모델 — 1순위) 작성자에게 수정 요청. 활동내역에 사유 기록.</td></tr>
          </tbody>
        </table>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">SLA</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>자살·자해·아동성착취 신고: <strong>2시간 이내 1차 대응</strong>.</li>
          <li>일반 신고: 72시간 이내 1차 대응.</li>
        </ul>
      `
    },
    {
      id: 'phase4',
      title: '제5조 Phase 4 — 이의제기 (30일 임시조치)',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 작성자 이의</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>삭제·차단 결정 후 30일 이내 이의제기 가능.</li>
          <li>이의 접수 시 30일간 임시 비공개 유지하며 재검토 (블라인드 임시조치 모델).</li>
          <li>재검토는 1차 결정자가 아닌 다른 운영자가 담당 (나무위키 회피 원칙 차용).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 회사·학교 측 신고</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>별도 채널: <code>contact@careerwiki.org</code> (서면 신고 가능).</li>
          <li>회사 답글권 1회 부여 (Glassdoor 모델). 답글도 모더레이션 대상.</li>
          <li>분쟁 미해결 시 "회색 라벨"로 양측 의견 병기 (사실 판정 회피).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 권리침해 신고 (정보통신망법 임시조치)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>저작권·명예훼손·개인정보 침해 신고 시 30일 임시조치.</li>
          <li>작성자 이의신청 7일 → 운영팀 결정 → KISO 심의 가능.</li>
        </ul>
      `
    },
    {
      id: 'phase5',
      title: '제6조 Phase 5 — 사용자 제재 단계제',
      content: `
        <p>위반 횟수에 따라 단계적으로 제재를 강화합니다 (Reddit 모델).</p>
        <table>
          <thead>
            <tr><th>차수</th><th>제재</th><th>적용</th></tr>
          </thead>
          <tbody>
            <tr><td>1차</td><td><strong>경고</strong></td><td>해당 콘텐츠 삭제 + 사유 통지</td></tr>
            <tr><td>2차</td><td><strong>7일 작성 정지</strong></td><td>댓글·편집·HowTo 발행 모두 정지</td></tr>
            <tr><td>3차</td><td><strong>30일 정지</strong></td><td>읽기는 가능</td></tr>
            <tr><td>4차</td><td><strong>영구 정지</strong></td><td>인증 라벨 박탈 포함</td></tr>
          </tbody>
        </table>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">즉시 영구 정지 사유 (단계 건너뛰기)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>아동성착취물 게시·유포.</li>
          <li>구체적 폭력·살해 협박.</li>
          <li>재직/재학 사칭 — 인증 라벨 거짓 사용 적발.</li>
          <li>차단 회피를 위한 다중계정 운영 적발.</li>
          <li>해킹·악성코드 유포 시도.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">감경 사유</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>규정 미숙지·착오·경미한 위반 — 1단계 감경 가능.</li>
          <li>소명 1회 감경 가능, 재소명 불가.</li>
          <li>3개월 이내 재범 없음 + 자진 시정 — 단계 누적 초기화 가능.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">가중 사유</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>3개월 이내 재범 — 이전 차단 기간 이상으로 가중.</li>
          <li>동시 다중 위반 — 합산 적용.</li>
          <li>유사 규정 위반(편집 분쟁 → 댓글 도배 등) 가중.</li>
        </ul>
      `
    },
    {
      id: 'appeal',
      title: '제7조 소명 절차',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li>제재 결정 통지 (이메일 + 마이페이지).</li>
          <li>30일 이내 소명서 작성 — 작성자 본인이 위반 인식·재발 방지 의지 표명.</li>
          <li>처리 관리자 회피 (자기 사안 처리 금지).</li>
          <li>1차 검토 — 다른 운영자.</li>
          <li>기각 시 운영위원회 회부 (3인 합의 시 결정).</li>
          <li>기각 시 30일 재소명 금지.</li>
        </ol>
      `
    },
    {
      id: 'channel',
      title: '제8조 신고·문의 채널',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li><strong>댓글·게시물 신고</strong>: 각 댓글·페이지의 신고 버튼.</li>
          <li><strong>편집권 남용 신고</strong>: <code>contact@careerwiki.org</code> 또는 <a href="/feedback" class="text-blue-300 hover:underline">피드백 게시판</a>.</li>
          <li><strong>권리침해(저작권·명예훼손·개인정보)</strong>: <code>contact@careerwiki.org</code>로 서면 신고. 정보통신망법 임시조치 적용.</li>
          <li><strong>긴급 사안(자살·자해·아동성착취)</strong>: <code>contact@careerwiki.org</code> + 제목에 [긴급] 표시 → 2시간 SLA.</li>
          <li><strong>이의제기</strong>: 마이페이지 또는 <code>contact@careerwiki.org</code>.</li>
        </ul>
      `
    },
    {
      id: 'records',
      title: '제9조 기록·통지',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>모든 신고·결정·제재는 내부 로그에 기록 (관계 법령에 따른 보존 기간).</li>
          <li>당사자(신고자·작성자)에게 결과 통지.</li>
          <li>신고자 정보는 작성자에게 비공개.</li>
          <li>분기별 통계는 <a href="/policy/transparency" class="text-blue-300 hover:underline">투명성 보고서</a>에 익명화하여 공개.</li>
        </ul>
      `
    },
    {
      id: 'admin-conduct',
      title: '제10조 운영자 행동 강령',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>자기 의견을 표명한 사안에 권한 행사 금지 (이해충돌 회피).</li>
          <li>자기 신고·소명·이의 심사 참여 금지.</li>
          <li>외부 커뮤니티에서 운영자 신분으로 활동 금지 (또는 운영자임을 비공개).</li>
          <li>운영 보안 자료(신고자 정보·소명 내역 등) 외부 유출 금지.</li>
          <li>위반 시 운영자 자격 박탈.</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '신고·제재',
      icon: 'fa-gavel',
      title: '신고·이의·제재 절차서',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: '신고·이의·제재 절차서',
      intro: `위반 행위에 대한 신고 접수부터 제재 결정, 이의제기까지의 전 과정에 대한 표준 절차입니다.
        커뮤니티 운영지침의 차단 사유와 이 절차서의 처리 단계가 함께 작동합니다.`,
      addendum: '이 절차서는 2026년 4월 30일부터 시행합니다.'
    },
    sections,
    options
  )
}
