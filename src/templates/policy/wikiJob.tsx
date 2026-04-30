/**
 * /policy/wiki/job — 직업위키 편집지침
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderWikiJobPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'scope',
      title: '제1조 적용 범위',
      content: `
        <p>이 지침은 <code>/job/{슬러그}</code>에 위치한 모든 직업 페이지의 작성·편집·분쟁 처리에 적용됩니다.</p>
        <p>전공위키는 <a href="/policy/wiki/major" class="text-blue-300 hover:underline">전공위키 편집지침</a>,
        진로 가이드는 <a href="/policy/howto" class="text-blue-300 hover:underline">HowTo 발행지침</a>,
        댓글은 <a href="/policy/community" class="text-blue-300 hover:underline">커뮤니티 운영지침</a>을 따릅니다.</p>
      `
    },
    {
      id: 'inclusion',
      title: '제2조 등재 기준 — 거의 모든 직업이 등재 가능합니다',
      content: `
        <p>Careerwiki는 등재 기준을 매우 넓게 운용합니다. 다음 중 <strong>하나만 충족</strong>해도 등재 가능합니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>공식 분류 등재</strong> — 한국직업사전, KECO, NCS, 통계청 표준 직업분류 중 하나에 등재된 직업.</li>
          <li><strong>외부 자료 언급</strong> — 정부 보고서, 학술 논문, 5순위 이상 매체에 직업으로 언급된 경우.</li>
          <li><strong>현직자 직접 작성</strong> — 위 분류에 없지만 실제로 존재하는 직업을 종사자가 직접 작성. 이 경우 본문 상단에 "현직자가 작성한 미분류 직업" 명시 의무.</li>
          <li><strong>신생/전망 직업</strong> — 1년 이내 등장한 신생 직업, 또는 가까운 미래에 등장 예정인 직업. 7순위 이상 매체에서 직업으로 다뤄진 흔적 1건 이상.</li>
        </ol>
        <div class="callout-good callout">
          <strong>의도</strong>: 진로를 고민하는 사람에게 정보의 양이 부족한 것보다는,
          출처가 약한 정보라도 "이런 직업도 있다"고 알려주는 게 도움된다고 판단합니다.
          <br>다만 신뢰성 차이는 분명히 표시합니다 — 미분류 직업은 페이지 상단 안내 배너로 명시.
        </div>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">등재가 거절되는 경우</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>직업이 아닌 단순 취미·활동 (예: "집에서 게임하기")</li>
          <li>특정 한 사람만 가능한 자칭 직업 (예: "○○○ 전속 비서")</li>
          <li>불법 활동 (예: 마약상, 보이스피싱 운영자)</li>
          <li>실재하지 않는 가공의 직업 (예: 영화 속 직업)</li>
        </ul>
      `
    },
    {
      id: 'title',
      title: '제3조 표제어(슬러그) 규칙',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li>1순위: 한국직업사전 표준명.</li>
          <li>2순위: 통계청 표준 직업분류 명칭.</li>
          <li>3순위: 업계에서 가장 널리 쓰이는 한글 명칭.</li>
          <li>외래어는 "프로그래머"처럼 한글 표기 우선. 단 "UX 디자이너"처럼 한글 표기가 부자연스러우면 영문 병기.</li>
          <li>동음이의어는 <code>슬러그-구분자</code> 형태 (예: <code>디자이너-게임</code>, <code>디자이너-ux</code>).</li>
          <li>슬러그는 한글 그대로 사용. URL 인코딩됩니다.</li>
        </ol>
      `
    },
    {
      id: 'sources',
      title: '제4조 출처 표기 — 5순위 이상 1건 필수',
      content: `
        <p>모든 사실 주장은 <a href="/policy/source-tier" class="text-blue-300 hover:underline">출처 신뢰성 등급표</a>에 따라 출처를 표기해야 합니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>위키 본문의 모든 사실 주장은 5순위 이상 출처 1개 이상.</li>
          <li>통계·수치는 2순위 이상 직접 인용.</li>
          <li>"개인 의견" 단락은 출처 없이도 가능하되 라벨 의무.</li>
          <li>출처는 본문 [N] 각주 + 페이지 하단 references 목록.</li>
          <li>raw URL을 본문에 그대로 노출 금지 — 반드시 각주 형태.</li>
        </ul>
      `
    },
    {
      id: 'narrative',
      title: '제5조 서술 규칙',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 사실/의견 분리</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>사실: 출처 표기 + 중립 서술. ("○○ 통계청에 따르면 평균 연봉은 5,000만원이다.")</li>
          <li>의견: "개인 의견" 라벨 + 1인칭 또는 attribution. ("[개인 의견] 현직자로서 ○○ 때문에 힘들다고 느낀다.")</li>
          <li>가치판단 형용사("최고의", "유일한", "쉬운") 단독 사용 금지 — 근거와 함께만.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 호평/비판 통합 작성</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>"호평", "비판" 분리 챕터 작성 금지. 한 문단에 균형 있게 통합.</li>
          <li>예: "보수가 높은 편이다 [출처]. 다만 평균 야근 시간이 주 10시간을 넘는다는 조사가 있다 [출처]."</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 안티패턴</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>"추가 바람", "수정 바람" 표시 금지 — 모르면 비워두거나 직접 채우기.</li>
          <li>"~카더라", "~한다고 한다" — attribution 필요 ("○○에 따르면").</li>
          <li>"꿀직업", "헬직업" 같은 가치판단 단정 표현 — 본인 경험 단락이라면 [개인 의견] 라벨로 강등.</li>
          <li>특정 회사·학교·인물 비방 — 댓글에서도 금지(<a href="/policy/community" class="text-blue-300 hover:underline">커뮤니티 운영지침</a>).</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 미래 예측·전망</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>"AI로 사라질 직업" 같은 단정 금지. "○○ 기관은 ~할 가능성이 있다고 본다" 식 attribution.</li>
          <li>4순위 이상 출처 필수 (KEIS 직업전망 보고서 등).</li>
        </ul>
      `
    },
    {
      id: 'sensitive',
      title: '제6조 민감 직업 — 군·종교·성노동·정치인',
      content: `
        <p>다음 직업은 추가적인 작성 원칙을 적용합니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>군인·경찰 특수보직</strong> — 보안 관련 정보는 공개 자료(국방부·경찰청 발표) 한정.</li>
          <li><strong>종교인</strong> — 특정 종교 옹호·비방 금지. 종교인이라는 직업 자체의 일반 특성만.</li>
          <li><strong>성노동·유흥</strong> — 합법 범위 내 직업만 등재. 미성년자 노출 차단 처리.</li>
          <li><strong>정치인</strong> — 직업 자체에 대한 일반 정보만. 특정 정치인 평가는 작성 금지(나무위키 문법 차용 — 정치 관련 별도 정책 추후 마련).</li>
        </ul>
      `
    },
    {
      id: 'mental-health',
      title: '제7조 자살·우울 등 정신건강 관련 서술',
      content: `
        <p>특정 직업의 직무 스트레스·우울·자살 위험을 서술할 때는
        <strong>보건복지부 자살보도 권고기준 5원칙</strong>을 따릅니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>구체적 도구·장소·방법·동기 미서술.</li>
          <li>자극적 제목·표현 금지.</li>
          <li>유명인 사례 모방 효과 자제.</li>
          <li>자살 통계 인용 시 자살예방 정보 동반 표시 (109/1393 안내).</li>
          <li>사진·영상 신중.</li>
        </ul>
        <p class="mt-3">의사·교사·간호사·소방관 등 직무 스트레스가 알려진 직업의 trivia·정신건강 단락에는
        자동으로 109/1393 안내 박스가 추가됩니다.</p>
      `
    },
    {
      id: 'ai-data',
      title: '제8조 AI 생성 데이터 처리',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li>AI가 채운 데이터는 <code>admin_data_json</code>에 격리. <code>user_contributed_json</code>과 구분.</li>
          <li>직업 페이지 우측 신뢰 박스에 AI 생성 비율과 마지막 검수일 표시.</li>
          <li>AI 생성 후 7일 내 사람 검수 없으면 "검수 필요" 상태 자동 전환.</li>
          <li>AI 생성 데이터 분쟁 시 자동으로 존치측 입증 책임 적용 — 5순위 이상 출처 못 대면 삭제.</li>
          <li>AI가 표기한 출처는 실제 존재 여부를 검증해야 함 (AI 환각 방지).</li>
        </ol>
      `
    },
    {
      id: 'edit-flow',
      title: '제9조 편집 절차',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 편집 권한</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>비로그인: 읽기만 가능</li>
          <li>가입 직후 (1일 미만): 토론·댓글 가능, 위키 편집은 제한된 영역만</li>
          <li>가입 1일 이상: 일반 편집 가능</li>
          <li>가입 7일 + 편집 5건 이상: 보호된 페이지 편집 가능</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 편집 요약 의무</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>모든 편집은 5자 이상의 사유 입력 필수.</li>
          <li>비하·반말·비아냥 표현 금지.</li>
          <li>"오타 수정", "통계 업데이트", "현직자 정보 추가" 같은 형태 권장.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 신규/기존 서술 7일 기준선</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>신규 서술</strong>: 추가 후 7일 미만. 분쟁 시 추가자에게 입증 책임.</li>
          <li><strong>기존 서술</strong>: 추가 후 7일 이상. 분쟁 시 양측이 토론 → 합의 → 변경.</li>
          <li>이 기준은 <a href="/policy/dispute" class="text-blue-300 hover:underline">토론·합의 절차서</a>의 핵심 룰입니다.</li>
        </ul>
      `
    },
    {
      id: 'image',
      title: '제10조 이미지·미디어',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>대표 이미지는 R2의 <code>jobs/job-{슬러그}.webp</code> 경로에만 저장.</li>
          <li>업로드 이미지는 저작권 확인 — 본인 촬영, CC 라이선스, 공공저작물만.</li>
          <li>워터마크 있는 타사 이미지·검색 결과 무단 사용 금지.</li>
          <li>인물 사진은 동의 받은 본인 또는 공인의 공식 사진만.</li>
          <li>AI 생성 이미지는 caption에 "AI 생성" + 모델명 명시 (예: "AI 생성 (ComfyUI/Flux)").</li>
          <li>유혈·중상해·성적 노출 이미지 게시 금지.</li>
        </ul>
      `
    },
    {
      id: 'dispute',
      title: '제11조 분쟁 처리',
      content: `
        <p>편집 분쟁이 발생했을 때는 <a href="/policy/dispute" class="text-blue-300 hover:underline">토론·합의 절차서</a>를 따릅니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li>분쟁 대상 서술은 토론 진행 중 <strong>"서술 시점"으로 고정</strong>.</li>
          <li><strong>존치측 입증 책임</strong> — 서술을 유지하려는 쪽이 5순위 이상 출처 제시.</li>
          <li>합의안 → 이의 제기 기간 (최소 48시간 + 6시간 갱신) → 종결.</li>
          <li>합의 무시 편집은 편집권 남용으로 다룸.</li>
        </ol>
      `
    },
    {
      id: 'don-do',
      title: '제12조 자주 하는 실수',
      content: `
        <table>
          <thead>
            <tr><th>안티패턴</th><th>대신 이렇게</th></tr>
          </thead>
          <tbody>
            <tr>
              <td>"추가 바람"</td>
              <td>비워두거나 직접 채우기. 알려달라고 부탁할 거면 토론으로.</td>
            </tr>
            <tr>
              <td>"~한다고 한다"</td>
              <td>"○○ 협회는 ~라고 발표한다 [출처]"</td>
            </tr>
            <tr>
              <td>"이 직업은 별로다"</td>
              <td>"[개인 의견] 야근 빈도 때문에 ○○하다고 느낀다"</td>
            </tr>
            <tr>
              <td>"AI 때문에 사라질 직업"</td>
              <td>"○○ 기관은 ~할 가능성이 있다고 본다 [출처]"</td>
            </tr>
            <tr>
              <td>"꿀직업", "헬직업"</td>
              <td>객관 정보 + 작성자 의견 분리. 의견은 라벨링.</td>
            </tr>
            <tr>
              <td>raw URL 본문 노출</td>
              <td>각주 [N] 형태로</td>
            </tr>
          </tbody>
        </table>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '직업위키 편집',
      icon: 'fa-briefcase',
      title: '직업위키 편집지침',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: '직업위키 편집지침',
      intro: `직업 페이지의 작성·편집·분쟁 처리에 적용되는 규칙입니다.
        헌장 — 출처 등급표 — 이 지침의 순서로 읽으면 전체 그림이 잡힙니다.`,
      addendum: '이 지침은 2026년 4월 30일부터 시행합니다.'
    },
    sections,
    options
  )
}
