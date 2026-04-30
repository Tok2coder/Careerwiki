/**
 * /legal/notice — 권리침해(저작권·명예훼손·개인정보) 신고 안내
 * 정보통신망법 제44조의2 임시조치 절차 안내
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from '../policy/_shared'

export function renderNoticePage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'overview',
      title: '권리침해 신고 절차 한눈에',
      content: `
        <p>본 페이지는 <strong>정보통신망법 제44조의2</strong>에 따라 게시물에 의해
        권리(저작권·명예훼손·개인정보·초상권 등)가 침해된 분이 신고할 수 있는 절차를 안내합니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li>아래 채널로 <strong>서면 신고</strong>를 접수해 주세요.</li>
          <li>접수 후 <strong>30일간 임시조치</strong>(게시 중단)됩니다.</li>
          <li>게시자에게 통지되며, 게시자는 7일 이내 이의신청 가능.</li>
          <li>이의 없으면 30일 후 자동 삭제. 이의 있으면 운영팀이 추가 검토.</li>
        </ol>
      `
    },
    {
      id: 'channel',
      title: '신고 채널',
      content: `
        <div class="callout">
          <strong>이메일 (권장)</strong><br>
          <a href="mailto:contact@careerwiki.org?subject=%5B%EA%B6%8C%EB%A6%AC%EC%B9%A8%ED%95%B4%5D%20%EC%9E%84%EC%8B%9C%EC%A1%B0%EC%B9%98%20%EC%8B%A0%EC%B2%AD" style="color:#93c5fd; text-decoration:underline;">contact@careerwiki.org</a>
          <br>제목: [권리침해] 임시조치 신청
        </div>
        <p class="mt-3">긴급한 사안(아동성착취·살해협박·개인 신상 노출)은 제목에 <code>[긴급]</code>을 붙여주세요. 2시간 이내 1차 대응합니다.</p>
      `
    },
    {
      id: 'required-info',
      title: '신고 시 필요한 정보',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>신청인 정보</strong> — 이름·연락처(이메일 또는 전화). 권리자 본인 또는 정당한 대리인.</li>
          <li><strong>침해 게시물 URL</strong> — 가능한 한 정확히 (예: <code>https://careerwiki.org/job/○○○#comment-12345</code>).</li>
          <li><strong>침해 유형</strong> — 저작권 침해 / 명예훼손 / 개인정보 노출 / 초상권 / 영업비밀 / 기타.</li>
          <li><strong>침해 사유</strong> — 어떤 권리를 어떻게 침해했는지 (구체적 서술).</li>
          <li><strong>증빙 자료</strong> — 권리 보유를 증명할 자료(저작권 등록증·신분증 일부 마스킹 등). 익명 보장 필요 시 운영팀에만 제공한다고 명시.</li>
          <li><strong>위증 시 책임 진다는 동의</strong> — "허위 신고 시 형사·민사 책임을 질 수 있음을 인지합니다."</li>
        </ol>
      `
    },
    {
      id: 'flow',
      title: '처리 흐름 (정보통신망법 제44조의2)',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>접수</strong> (D+0) — 운영팀이 신고 접수 확인 메일 발송.</li>
          <li><strong>임시조치</strong> (D+0~1) — 명백한 권리침해 또는 판단 필요 시, 게시물을
            <strong>최대 30일간 임시 비공개</strong> 처리. 게시자에게 통지.</li>
          <li><strong>게시자 이의신청</strong> (D+1~7) — 게시자가 7일 이내 이의신청 가능.
            이의가 있으면 운영팀이 정보통신서비스 제공자로서 자체 판단.</li>
          <li><strong>최종 결정</strong> (D+7~30) — 이의 없으면 30일 후 영구 삭제.
            이의 있으면 운영팀 검토 후 결정. 분쟁 미해결 시 한국인터넷자율정책기구(KISO) 심의 회부 가능.</li>
          <li><strong>결과 통지</strong> — 신고자·게시자 양측에 결정 통지.</li>
        </ol>
      `
    },
    {
      id: 'kiso',
      title: 'KISO 심의 안내',
      content: `
        <p>운영팀의 결정에 동의하지 않을 경우 <strong>한국인터넷자율정책기구(KISO)</strong>에
        심의를 요청할 수 있습니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>웹사이트: <a href="https://www.kiso.or.kr/" target="_blank" rel="noopener" style="color:#93c5fd;">https://www.kiso.or.kr/</a></li>
          <li>심의는 게시자·신고자 양측 의견을 듣고 중립적으로 판단합니다.</li>
        </ul>
      `
    },
    {
      id: 'minors',
      title: '미성년자·민감 사안 — 우선 처리',
      content: `
        <p>다음 사안은 <strong>2시간 이내 1차 대응</strong>합니다 (커뮤니티 운영지침 §5).</p>
        <ul class="list-disc list-inside space-y-1">
          <li>아동성착취·미성년 대상 성적 게시물.</li>
          <li>구체적 살해·자해 협박.</li>
          <li>미성년자 개인 신상(이름·학교·사진) 동의 없는 노출.</li>
          <li>학교폭력·교사 성희롱 폭로 글에 대한 2차 가해 댓글.</li>
        </ul>
        <p class="mt-3">자살·자해 위기 상황은 별도 안내가 자동 표시되며, 제3자 신고로도 운영팀이 즉시 대응합니다.</p>
      `
    },
    {
      id: 'false-report',
      title: '허위 신고에 대한 안내',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>실제 권리 침해가 없는데 단순히 자기에게 불리한 게시물 삭제 목적으로 신고하는 행위는
            <strong>허위 신고</strong>로 처리됩니다.</li>
          <li>허위 신고가 누적되면 신고 권한이 박탈되며, 손해가 발생한 경우 민·형사 책임이 따를 수 있습니다.</li>
          <li>운영팀은 신고가 명백히 허위인 경우 임시조치를 적용하지 않습니다.</li>
        </ul>
      `
    },
    {
      id: 'related',
      title: '관련 정책',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li><a href="/policy/community" style="color:#93c5fd;">커뮤니티 운영지침</a> — 차단·삭제 사유, 자살자해 매뉴얼</li>
          <li><a href="/policy/enforcement" style="color:#93c5fd;">신고·이의·제재 절차서</a> — 단계별 처리 흐름</li>
          <li><a href="/legal/terms" style="color:#93c5fd;">이용약관</a> — 게시물 관리·면책 조항</li>
          <li><a href="/legal/privacy" style="color:#93c5fd;">개인정보처리방침</a> — 신고자 정보 보호</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '권리침해 신고',
      icon: 'fa-shield-halved',
      title: '권리침해 신고 안내 (정보통신망법 임시조치)',
      subtitle: '시행 2026-04-30',
      pageTitle: '권리침해 신고 안내',
      intro: `저작권·명예훼손·개인정보·초상권 등 본인의 권리가 침해된 게시물을 발견하셨다면 아래 절차로 신고해 주세요.
        정보통신망법 제44조의2에 따라 30일 임시조치가 적용됩니다.`,
      addendum: '본 안내는 2026년 4월 30일부터 시행하며, 변경 시 7일 전 공지합니다.'
    },
    sections,
    options
  )
}
