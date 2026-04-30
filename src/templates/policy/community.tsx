/**
 * /policy/community — 커뮤니티 운영지침 (댓글)
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderCommunityPolicyPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'philosophy',
      title: '제1조 운영 철학 — 진로를 묻는 사람이 안전한 곳',
      content: `
        <p>Careerwiki 댓글은 학생·구직자가 현직자에게 묻고, 현직자가 솔직하게 답하는 공간입니다.
        익명성을 보장해 솔직한 후기가 가능하게 하되, 회사·인물 비방·차별·자해 조장은
        엄격히 처리합니다.</p>
        <p>아래 정책은 다음 두 가지를 동시에 지키기 위한 것입니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>현직자의 솔직한 후기 작성권 (블라인드·잡플래닛 모델).</li>
          <li>학생·취준생·미성년자의 안전 (에브리타임 사고 교훈).</li>
        </ul>
      `
    },
    {
      id: 'identity-model',
      title: '제2조 익명성 모델 — 단순 가입제',
      content: `
        <p>Careerwiki는 다음 3단계로 사용자 권한을 구분합니다.</p>
        <table>
          <thead>
            <tr><th>구분</th><th>조건</th><th>권한</th></tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>비회원</strong></td>
              <td>비로그인</td>
              <td>읽기만 가능</td>
            </tr>
            <tr>
              <td><strong>일반 회원</strong></td>
              <td>Google 로그인 + 닉네임</td>
              <td>댓글·추천·비추천·신고·HowTo 작성·위키 편집</td>
            </tr>
            <tr>
              <td><strong>운영진</strong></td>
              <td>운영팀 임명</td>
              <td>신고 검토·임시조치·중재 등 운영 권한</td>
            </tr>
          </tbody>
        </table>
        <div class="callout">
          <strong>학교·직업 인증은 현재 정책에 포함되지 않습니다.</strong>
          별도 인증을 통한 신뢰 라벨(예: "○○대 4학년", "현직 5년차") 시스템은
          <strong>커리어트리(Career Tree) 영역에서만</strong> 별도 기획 중이며,
          댓글·위키·HowTo 영역에는 적용되지 않습니다. 본 지침에서는
          본인이 본문에 자기 경력·학년을 직접 적는 자기 진술만 인정합니다.
        </div>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">신고 권한 가드</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>신규 가입 후 24시간 이내: 신고권 제한 (Reddit 모델).</li>
          <li>허위 신고 누적 3회: 신고권 박탈 (링커리어 모델).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">닉네임 정책</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>닉네임은 변경 가능하나, "이전 닉" 흔적은 운영자만 봅니다 (다중계정 추적 가능성 유지).</li>
          <li>닉네임 자체에 욕설·차별·타인 사칭 표현 사용 금지.</li>
        </ul>
      `
    },
    {
      id: 'block-reasons',
      title: '제3조 차단·삭제 사유',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 즉시 삭제 (검토 후 즉시)</h3>
        <ol class="list-decimal list-inside space-y-1">
          <li>음란물·아동성착취물.</li>
          <li>불법 정보(마약·무기·해킹·도박 거래·홍보).</li>
          <li>개인정보 노출(실명·전화·주소·학번·사번 등 식별 가능 정보).</li>
          <li>명백한 혐오·차별 (성별·지역·인종·장애·성적지향·종교·학력·직업 비하).</li>
          <li>폭력·자해·자살 방법 적시 (구체적 도구·장소).</li>
          <li>특정인 협박·스토킹.</li>
        </ol>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 진로 사이트 특수 (검토 후 결정)</h3>
        <ol class="list-decimal list-inside space-y-1">
          <li>특정 회사·학교에 대한 명백한 허위 사실 (객관 검증 가능한 거짓).</li>
          <li>특정 인물 저격 (이름·직책·식별 가능 별명으로 동료·상사·교수·학생 비방).</li>
          <li>회사 기밀·NDA 위반 가능 정보 (미공개 재무·영업비밀·인사 정보).</li>
        </ol>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 품질 문제 (1차 경고)</h3>
        <ol class="list-decimal list-inside space-y-1">
          <li>도배·스팸·광고 (5분 내 동일 내용 반복, 무관 외부 링크 도배).</li>
          <li>욕설·비속어가 본문 핵심 내용을 차지하는 게시물.</li>
          <li>무관 정치·종교 선동, 진로와 무관한 어그로.</li>
          <li>자작 추천·자작 댓글·다중계정 어뷰징.</li>
          <li>해당 페이지 토픽과 무관한 잡담 (직업/전공 페이지에 일상 글).</li>
        </ol>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 회색지대 (검토 → 양측 의견 병기 가능)</h3>
        <ol class="list-decimal list-inside space-y-1">
          <li>부정적 회사 후기 — 사실 기반 + 인신공격 없으면 <strong>유지 원칙</strong> (Glassdoor 모델). 회사 반론권 1회 부여.</li>
          <li>교수·강사 평가 — 강의 내용·진행 평가는 OK, 외모·사생활 언급 NG (에브리타임 강의평 모델).</li>
          <li>익명 폭로성 글 — "있었던 일" 진술은 OK, 단 특정 가능한 정보 동반 시 A·B 적용.</li>
        </ol>
      `
    },
    {
      id: 'report-flow',
      title: '제4조 신고 → 처리 5단계',
      content: `
        <p>자세한 절차는 <a href="/policy/enforcement" class="text-blue-300 hover:underline">신고·이의·제재 절차서</a>를 참조.
        이 조문은 댓글에 특화된 요약입니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>접수</strong> — 신고 버튼 → 사유 6종 드롭다운 (혐오/욕설/허위/개인정보/스팸/기타). "기타"는 20자 이상 텍스트 의무.</li>
          <li><strong>자동 1차 분류 (5분 내)</strong> — AI 분류기로 §3-A(즉시 삭제) 검출 시 자동 임시가림. <strong>회색지대(§3-B/D)는 자동 처리 절대 금지</strong>.</li>
          <li><strong>사람 검토 (24~72시간)</strong> — 운영자 4가지 결과: 유지 / 삭제 / 경고+유지 / 작성자 수정요청. 잡플래닛 모델 — 즉시 삭제보다 "수정 요청"이 1순위.</li>
          <li><strong>이의제기 (30일 임시조치)</strong> — 작성자 30일간 임시 비공개 + 재검토. 회사·학교 측 신고는 별도 채널.</li>
          <li><strong>제재 (단계제)</strong> — 1차 경고 → 2차 7일 정지 → 3차 30일 정지 → 4차 영구. 명백 위반(폭력·아동성착취·반복 허위사실)은 1회 영구.</li>
        </ol>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">SLA</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>자살·자해·아동성착취 신고: <strong>2시간 이내 1차 대응</strong>.</li>
          <li>일반 신고: 72시간 이내 1차 대응.</li>
        </ul>
      `
    },
    {
      id: 'self-harm',
      title: '제5조 자살·자해 콘텐츠 대응 매뉴얼 ⚠️',
      content: `
        <div class="callout-danger callout">
          <strong>가장 중요한 조항입니다.</strong> 에브리타임의 실패(2020 서울여대 사건)에서
          배운 "절대 하지 말아야 할 것"과 "반드시 해야 할 것"이 명시되어 있습니다.
        </div>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 자동 검출</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>키워드 모니터링: "죽고 싶다", "자해", "끝내고 싶다", "사라지고 싶다", "1393", "109" 등.</li>
          <li>단순 키워드 차단 금지 — SOS 발신을 막아버리는 부작용 우려.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 자동 표시 (삭제 X)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>게시물 상단에 자동 배너:<br>
            <code>"혹시 지금 힘드신가요? 자살예방상담전화 109(국번없이) — 24시간"</code></li>
          <li>관련 댓글에는 신고 양식 + "응원 보내기" 버튼 + 운영자 알림 트리거.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 운영자 즉시 대응 (2시간 SLA)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>자해 신호 게시물에 악플이 달리면 <strong>악플 우선 삭제 + 게시물은 유지</strong>.</li>
          <li>작성자에게 109/1393 안내 + 인근 정신건강복지센터 위치 링크.</li>
          <li>반복 호소자에게는 운영자가 익명으로 컨택 (학교 인권센터 연계 옵션 제공).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 보도 윤리 준수</h3>
        <p>보건복지부 자살보도 권고기준 5원칙을 댓글에도 적용:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>구체적 도구·장소·동기 미보도.</li>
          <li>자극적 제목 금지.</li>
          <li>유명인 모방 자제.</li>
          <li>자살예방정보 동반.</li>
          <li>사진·영상 신중.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">E. 절대 금지</h3>
        <div class="callout-danger callout">
          <ul class="list-disc list-inside space-y-1">
            <li>신고 N개 누적 → 자동 삭제 <strong>절대 금지</strong> (에브리타임 실패).</li>
            <li>자해 글 작성자에게 "관심 받으려고 하지 마라" 식 자동 응답.</li>
            <li>운영 채널 부재 (전화·이메일·인권 연계 모두 노출 의무).</li>
          </ul>
        </div>
      `
    },
    {
      id: 'company-review',
      title: '제6조 회사·학교 비방 후기 처리',
      content: `
        <p><strong>원칙</strong>: 사실 기반 부정 후기는 <strong>유지</strong>, 인신공격·허위·기밀은 <strong>삭제</strong>.</p>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 구체 룰</h3>
        <table>
          <thead><tr><th>예시</th><th>판정</th></tr></thead>
          <tbody>
            <tr><td>"워라밸이 안 좋다"</td><td>✅ OK (의견)</td></tr>
            <tr><td>"[부서명] [직책]이 [구체 행위]했다"</td><td>⚠️ 인물 특정 시 삭제 또는 익명화</td></tr>
            <tr><td>"○○회사가 [실명 가능한 일] 했다"</td><td>⚠️ 사실 입증 어려우면 30일 임시조치</td></tr>
            <tr><td>"○○회사 일하기 너무 힘들다"</td><td>✅ OK</td></tr>
            <tr><td>"○○회사 사장 [실명] 지옥 갈 것"</td><td>❌ 삭제 (특정 + 모욕)</td></tr>
            <tr><td>"○○대 △△교수 강의가 나에겐 안 맞았다"</td><td>✅ OK (강의 평가)</td></tr>
            <tr><td>"○○대 △△교수가 [사생활 추정]"</td><td>❌ 삭제 (사생활)</td></tr>
          </tbody>
        </table>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 회사 반론권 (Glassdoor 모델)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>회사가 자사 페이지의 부정 후기에 <strong>1회 답글 가능</strong> (운영팀이 회사 측 신원·소속 확인 후).</li>
          <li>답글도 모더레이션 대상 (작성자 협박·법적 위협 금지).</li>
          <li>분쟁 미해결 시 "양측 의견 병기" 라벨로 처리.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 삭제 요청 처리</h3>
        <div class="callout-warn callout">
          <strong>회사 신고 자동 삭제 절대 금지</strong> (잡플래닛 사례 교훈).
          <br>"허위 입증 책임은 신고자(회사)에게" 명시. 본 운영팀이 직접 검토.
        </div>
      `
    },
    {
      id: 'minors',
      title: '제7조 미성년자 보호',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 가입 연령</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>만 14세 미만: 법정대리인 동의 필요 (정보통신망법).</li>
          <li>만 14~18세: 별도 미성년자 라벨 (운영 내부 표시), 일부 게시판 접근 제한 옵션.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 콘텐츠 노출 제어</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>미성년 가입자에게 노출되는 회사 후기·갑질 트리비아는 클릭 1회 더 필요 (민감 콘텐츠 필터).</li>
          <li>유흥·성인용품 등 성인 직업 페이지는 미성년 차단.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 학생 익명 제보 보호</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>학교폭력·교사 성희롱 폭로 글: 자동 익명화 + 학교폭력 신고 117·청소년사이버상담 1388 동반 표시.</li>
          <li>신고 시 작성자 식별정보 보호 강화 (운영자 2인 동의 + 법적 영장 외 비공개).</li>
        </ul>
      `
    },
    {
      id: 'good-comments',
      title: '제8조 좋은 댓글 유도 메커니즘',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 추천·베스트 시스템</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>추천(👍)</strong>: 일반 회원 누구나. 댓글당 1회.</li>
          <li><strong>비추천(👎)</strong>: 일반 회원 누구나. 단 가입 후 24시간 이내·karma -5 이하는 제한.</li>
          <li><strong>베스트 답변(★)</strong>: 추천 N개(예: 10) + 댓글 3개 → 페이지 상단 자동 등재 (디시 개념글 모델).</li>
          <li><strong>에디터 추천</strong>: 운영자 또는 검증된 전문가가 수동 별표 부여 (디시 실베 + Anthropic Trust 모델).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 자기 진술 (인증 시스템 없음)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>댓글·후기에 "저는 ○○ 회사 5년차입니다" 같은 자기 진술은 자유롭게 가능합니다.</li>
          <li>다만 시스템이 검증하지 않으므로, 다른 독자가 신뢰할지는 글 내용·문맥에 달려 있습니다.</li>
          <li>본인 경험 단락은 <code>[개인 의견]</code> 라벨을 병기하면 출처 등급 룰 적용에서 제외됩니다.</li>
          <li>학교·직업 인증을 통한 자동 라벨 시스템은 본 정책에 포함되지 않습니다(커리어트리 영역에서 별도 기획).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. karma (평판 점수)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>추천 누적 + 베스트 등재로 가산.</li>
          <li>-10 이하면 작성권 일부 제한 (HN 모델).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 작성 폼 안내 (HN 가이드 차용)</h3>
        <p>댓글 입력창 위에 자동 표시:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>"이 직업/전공을 고민하는 사람에게 도움이 되는 정보인가요?"</li>
          <li>"사실인가요, 의견인가요? 의견이라면 그렇게 명시해주세요."</li>
          <li>"당신의 경험(연차/학년)을 함께 적으면 신뢰가 올라갑니다."</li>
          <li>"<strong>'그냥 별로'</strong>보다 <strong>'X 때문에 별로'</strong>가 누군가의 진로를 살립니다."</li>
        </ul>
      `
    },
    {
      id: 'rate-limits',
      title: '제9조 도배·다중계정 방어',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>동일 IP에서 1분당 5개 초과 댓글: 일시 제한 (rate limit).</li>
          <li>5분 내 동일 단어 60% 이상 반복: 도배 의심 → 자동 임시가림.</li>
          <li>다중계정 의심 (동일 IP·디바이스 + 같은 페이지 추천): 운영자 검토 큐.</li>
          <li>1줄 댓글("ㅇㅇ", "동의" 등) 입력 시 부드러운 안내: "내용을 더 써보시면 어떨까요?"</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '커뮤니티 운영',
      icon: 'fa-comments',
      title: '커뮤니티 운영지침',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: '커뮤니티 운영지침',
      intro: `직업·전공·HowTo 페이지의 댓글, 토론, 신고에 적용되는 규칙입니다.
        익명성과 안전을 동시에 지키는 게 목적입니다. 자살·자해 매뉴얼(제5조)은 가장 중요한 조항입니다.`,
      addendum: '이 지침은 2026년 4월 30일부터 시행합니다.'
    },
    sections,
    options
  )
}
