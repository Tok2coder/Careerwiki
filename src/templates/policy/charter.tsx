/**
 * /policy/charter — Careerwiki 기본방침 (헌장)
 * 모든 영역별 정책의 토대가 되는 최상위 문서
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderCharterPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'preamble',
      title: '전문 — Careerwiki는 무엇을 위한 곳인가',
      content: `
        <p>Careerwiki는 진로를 고민하는 모든 사람에게 정확하고 실용적인 정보를 제공합니다.
        한국직업사전·NCS·통계청 같은 <strong>공공데이터</strong>를 기본으로 하되,
        실제 그 직업·전공을 살아가는 사람들의 <strong>경험과 시각</strong>이 함께 모일 때
        진짜 도움이 된다고 믿습니다.</p>
        <p>이 문서는 그 약속을 지키기 위한 최소한의 규칙입니다.
        규칙은 사용자를 통제하기 위한 것이 아니라, 서로의 기여가
        다른 사람의 진로 결정에 흠이 되지 않도록 보호하기 위한 장치입니다.</p>
      `
    },
    {
      id: 'values',
      title: '제1장 가치 — 다섯 가지 약속',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>정확성보다 정직함</strong>. 모르는 건 모른다고 적습니다.
          확신이 없는 정보는 출처와 함께, 의견은 의견임을 밝히고 적습니다.</li>
          <li><strong>다양한 목소리 포용</strong>. 한 직업에 대한 평가는 사람마다 다릅니다.
          호평·비판이 한 자리에 공존하는 것을 자연스럽게 봅니다.</li>
          <li><strong>안전한 대화</strong>. 진로 사이트는 학생·구직자가 많이 옵니다.
          누구도 이 사이트에서 상처받지 않도록 운영합니다.</li>
          <li><strong>AI는 도구일 뿐</strong>. AI가 만든 데이터도, 사람이 검수하지 않으면 게시하지 않습니다.</li>
          <li><strong>규정도 토론으로 바뀝니다</strong>. 이 문서를 포함한 모든 정책은
          사용자 의견에 따라 개정될 수 있습니다.</li>
        </ol>
      `
    },
    {
      id: 'five-areas',
      title: '제2장 5대 영역과 정체성',
      content: `
        <p>Careerwiki는 성격이 다른 다섯 가지 콘텐츠 영역으로 구성됩니다.
        영역마다 적용되는 톤과 규칙이 다릅니다.</p>
        <table>
          <thead>
            <tr><th>영역</th><th>성격</th><th>주된 톤</th></tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>직업위키</strong></td>
              <td>사실 기반 사전 — 1차 데이터 + 출처</td>
              <td>중립적, 객관적, 백과사전</td>
            </tr>
            <tr>
              <td><strong>전공위키</strong></td>
              <td>사실 기반 사전 — 학과·교육과정·취업 데이터</td>
              <td>중립적, 객관적, 백과사전</td>
            </tr>
            <tr>
              <td><strong>HowTo 가이드</strong></td>
              <td>관점 있는 진로 가이드 — 작성자 경험·관점 허용</td>
              <td>친근한 존댓말, 1인칭 경험 OK</td>
            </tr>
            <tr>
              <td><strong>댓글 커뮤니티</strong></td>
              <td>익명 또는 가명 토론·후기 공간</td>
              <td>자유로움 + 책임감</td>
            </tr>
            <tr>
              <td><strong>AI 추천</strong></td>
              <td>개인 맞춤 직업·전공 추천</td>
              <td>참고용 — 최종 판단은 사용자</td>
            </tr>
          </tbody>
        </table>
        <div class="callout">
          <strong>영역이 충돌할 때:</strong> 같은 직업이라도 위키는 평균치를,
          HowTo는 작성자 한 사람의 경험을, 댓글은 다양한 후기를 보여줍니다.
          서로 다른 결론을 내릴 수 있고, 그게 정상입니다.
          위키-HowTo가 통계 수치에서 모순되면 본문 자동 비교 박스가 떠서 사용자가 판단할 수 있게 합니다.
        </div>
      `
    },
    {
      id: 'inclusion',
      title: '제3장 등재·작성의 자유 — 무엇이든 쓸 수 있는가',
      content: `
        <p>Careerwiki는 <strong>등재 기준을 매우 넓게</strong> 운용합니다.
        공식 분류에 없는 신생 직업·전공도, 한 사람의 개인적 의견도 등재할 수 있습니다.
        다만 <strong>"무엇으로서" 작성하는지를 분명히 밝혀야 합니다.</strong></p>

        <table>
          <thead>
            <tr><th>유형</th><th>등재 가능?</th><th>조건</th></tr>
          </thead>
          <tbody>
            <tr>
              <td>한국직업사전·NCS·교육부 분류 등재</td>
              <td>✅</td>
              <td>조건 없음</td>
            </tr>
            <tr>
              <td>제도권 언론·학술 자료에 언급된 신생 직업</td>
              <td>✅</td>
              <td>출처 1건 이상</td>
            </tr>
            <tr>
              <td>아직 분류되지 않은 직업 — 본인이 처음 작성</td>
              <td>✅</td>
              <td>본문 상단에 "현직자가 작성한 미분류 직업" 명시</td>
            </tr>
            <tr>
              <td><strong>개인적 의견·경험·평가</strong></td>
              <td><strong>✅</strong></td>
              <td><strong>"개인 의견" 명시 (본문 또는 작성자 라벨)</strong></td>
            </tr>
            <tr>
              <td>HowTo의 1인칭 가이드</td>
              <td>✅</td>
              <td>작성자 경험·자격 표시</td>
            </tr>
            <tr>
              <td>댓글·후기</td>
              <td>✅</td>
              <td>커뮤니티 운영지침 준수</td>
            </tr>
          </tbody>
        </table>

        <div class="callout-good callout">
          <strong>핵심 원칙:</strong> Careerwiki는 정보의 양보다 <em>정직함</em>을 더 중시합니다.
          "이건 내 개인 의견인데..."라고 밝힌 한 줄은,
          출처를 위장한 100줄보다 신뢰가 높습니다.
        </div>

        <p><strong>표시 방식</strong>:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>위키 본문에서 의견 한 단락: <code>[개인 의견]</code> 라벨로 시작하거나, "현직자 본인의 견해입니다" 등 한 줄을 단락 처음에.</li>
          <li>HowTo 글 전체가 의견 기반: 본문 상단 "이 글은 작성자 ○○의 경험·시각으로 쓴 글입니다" 박스.</li>
          <li>댓글: 자연스러운 1인칭이 기본이라 별도 라벨 불필요. 본문에 "저는 ○○ 5년차입니다" 식의 자기 진술을 적는 것은 자유.</li>
        </ul>
        <p class="mt-3 text-sm text-slate-400">
          단, "출처 있는 사실"인 척 의견을 위장하는 행위는
          <a href="/policy/enforcement" class="text-blue-300 hover:underline">신고·이의·제재 절차서</a>에서
          편집권 남용으로 다룹니다. 핵심은 "쓰지 마라"가 아니라 "정직하게 라벨링하라"입니다.
        </p>
      `
    },
    {
      id: 'rights',
      title: '제4장 이용자의 권리',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>열람권</strong> — 비로그인 상태에서도 모든 위키·HowTo·댓글을 읽을 수 있습니다.</li>
          <li><strong>편집권</strong> — 가입 후 직업·전공 페이지를 편집할 수 있습니다. 신생 가입자는 일부 영역에 접근 제한이 있을 수 있습니다.</li>
          <li><strong>의견 표명권</strong> — 댓글·HowTo·위키 의견란에서 자기 의견을 적을 수 있습니다. 단 "개인 의견" 표시 의무.</li>
          <li><strong>이의제기권</strong> — 자기 콘텐츠가 삭제·차단됐을 때 30일 이내 소명할 수 있습니다.</li>
          <li><strong>탈퇴·삭제 요청권</strong> — 회원 탈퇴와 본인 작성물 삭제를 요청할 수 있습니다(개인정보 노출 등 즉시 삭제 사유 외에는 30일 보존 후 영구 삭제).</li>
          <li><strong>토론권</strong> — 정책·편집·데이터 정확성에 대해 토론을 발제할 수 있습니다.</li>
          <li><strong>알 권리</strong> — 자기에 대한 신고·제재 결과를 통지받습니다.</li>
        </ol>
      `
    },
    {
      id: 'duties',
      title: '제5장 이용자의 의무',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li>출처를 표기하지 않은 사실 주장 금지 — 사실로 쓰려면 출처, 의견으로 쓰려면 의견 표시.</li>
          <li>광고·제휴·후원 콘텐츠는 글 시작 부분에 명확히 표시(공정거래위원회 추천보증 심사지침 준수).</li>
          <li>AI로 작성한 글은 AI 사용 사실을 라벨로 표시.</li>
          <li>인신공격·차별·도싱(개인정보 노출) 금지.</li>
          <li>다중계정·자동화 도구로 평판이나 통계를 조작하지 않기.</li>
          <li>저작권 위반 콘텐츠 게시 금지 — 인용은 출처 + 비율 20% 이내.</li>
          <li>다른 사용자의 결정을 존중. "이 직업 가지 마라" 식 단정보다 "내 경험상 ○○ 때문에 힘들었다" 식 서술.</li>
        </ol>
      `
    },
    {
      id: 'license',
      title: '제6장 라이선스 — 가능한 한 자유롭게',
      content: `
        <p>Careerwiki는 진로 정보가 가능한 한 많은 사람에게 닿기를 원합니다. 그래서 다음과 같은 가벼운 라이선스를 채택합니다.</p>
        <table>
          <thead>
            <tr><th>콘텐츠</th><th>라이선스</th><th>이용 조건</th></tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>위키 본문 (직업·전공 페이지)</strong></td>
              <td><strong>CC BY 4.0</strong></td>
              <td>출처 표기만 하면 누구나 자유롭게 인용·재배포·가공·상업적 이용 가능. AI 학습·추천·분석 활용 명시 허용.</td>
            </tr>
            <tr>
              <td>HowTo 가이드 본문</td>
              <td>작성자 보유 (default)</td>
              <td>Careerwiki에 비독점·전 세계·무기한 사용권 부여. 작성자가 원하면 발행 시 CC BY 4.0 옵션 선택 가능.</td>
            </tr>
            <tr>
              <td>댓글·후기</td>
              <td>작성자 보유</td>
              <td>Careerwiki에 비독점·무기한 사용권 부여 (서비스 운영·표시·검색 노출 목적).</td>
            </tr>
            <tr>
              <td>이미지 (R2 업로드)</td>
              <td>업로드자 책임</td>
              <td>저작권 침해 발견 시 즉시 삭제. 본인 촬영·CC 라이선스·공공저작물만 업로드 권장.</td>
            </tr>
            <tr>
              <td>공공데이터 (커리어넷·고용24 등)</td>
              <td>원 제공기관 귀속</td>
              <td>Careerwiki는 가공·재구성하여 제공. 원 출처 표기.</td>
            </tr>
          </tbody>
        </table>
        <div class="callout-good callout">
          <strong>왜 CC BY 4.0인가</strong>
          <ul class="list-disc list-inside mt-2 space-y-1">
            <li>출처만 적으면 누구나 자유롭게 사용 — 진로 정보 확산이 우선이라고 봅니다.</li>
            <li>유료 AI 추천·광고·검색 통합 등 상업적 이용도 자유 (출처 표기 의무만).</li>
            <li>다른 위키 (위키백과 CC BY-SA 등) 와의 호환성도 우수.</li>
            <li>AI 학습·임베딩·재가공 활용 명시 허용 (Careerwiki도 OpenAI 같은 외부 AI를 사용하므로 양방향 OK).</li>
          </ul>
        </div>
        <p class="mt-3 text-sm text-slate-400">출처 표기 형식 예시: <em>"본 글은 Careerwiki(careerwiki.org)에서 인용. CC BY 4.0"</em></p>
      `
    },
    {
      id: 'ads',
      title: '제6.5장 광고·후원 정책',
      content: `
        <p>Careerwiki는 운영비 충당과 무료 서비스 유지를 위해 광고를 게재합니다.
        독자의 가독성·신뢰를 해치지 않는 선에서 다음 원칙을 따릅니다.</p>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 광고 위치·개수 제한</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>본문 콘텐츠 사이 인라인 광고는 페이지당 <strong>최대 2개</strong>까지.</li>
          <li>본문 시작과 끝 사이의 자연스러운 단락 경계에만 배치 — 단락을 끊는 형태 금지.</li>
          <li>댓글·토론·신뢰 박스 영역에는 광고 미배치.</li>
          <li>편집·역사·발제 등 사용자 도구 페이지에는 광고 미배치.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 모바일 가독성</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>모바일 전면광고(인터스티셜) 금지</strong> — 위키·HowTo·댓글 모두.</li>
          <li>고정 위치 배너로 본문 일부를 가리는 것 금지.</li>
          <li>스크롤 시 따라오는 sticky 광고는 본문보다 작게(높이 80px 이하).</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 광고 차단기 사용자 보호</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>광고 차단 프로그램(uBlock Origin·AdBlock 등) 사용자에게 콘텐츠 차단 또는 경고 노출 금지.</li>
          <li>광고 차단 우회 또는 강제 비활성화 요구 금지.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 광고 표시·구분</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>모든 광고는 <code>광고</code> 또는 <code>Sponsored</code> 라벨이 명확히 보이는 형태로만 게재.</li>
          <li>본문과 시각적으로 구분되도록 배경·테두리 차이 또는 별도 구획 사용.</li>
          <li>네이티브 광고(콘텐츠로 위장)는 게재하지 않음.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">E. 후원·제휴</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>HowTo의 광고·제휴 표시는 <a href="/policy/howto#ad-disclosure" class="text-blue-300 hover:underline">HowTo 발행지침 §4</a> 적용 (공정거래위원회 추천보증 심사지침 강행 규정).</li>
          <li>위키 본문 자체에는 제휴·협찬 콘텐츠 게재 불가.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">F. 수익 투명성</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>현재 광고 수익은 Cloudflare 인프라 비용·OpenAI API 비용·도메인 등 운영비 충당에 사용됩니다.</li>
          <li>분기별 운영 투명성 보고서(<a href="/policy/transparency" class="text-blue-300 hover:underline">/policy/transparency</a>)에 광고 수익·지출 요약을 향후 포함 예정.</li>
          <li>광고주의 콘텐츠 편집 개입을 받지 않습니다 — 기사형 광고·후원 콘텐츠 명시적 거부.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">G. 금지 광고 카테고리</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>도박·불법 의약품·성인 콘텐츠</li>
          <li>학력 조작·자격증 부정 발급·시험 부정 행위 알선</li>
          <li>다단계·금융 사기·고수익 보장 투자 권유</li>
          <li>미성년자 대상 부적절 광고 (Google AdSense 정책 외 추가 차단)</li>
          <li>특정 직업·전공·학교에 대한 비방·허위 사실 광고</li>
        </ul>

        <div class="callout">
          <strong>광고 신고:</strong> 위 정책에 어긋나는 광고를 발견하시면
          <a href="mailto:contact@careerwiki.org?subject=%5B%EA%B4%91%EA%B3%A0%EC%8B%A0%EA%B3%A0%5D" style="color:#93c5fd; text-decoration:underline;">contact@careerwiki.org</a>로 신고해 주세요.
          스크린샷·URL 첨부 시 빠르게 처리합니다.
        </div>
      `
    },
    {
      id: 'rule-hierarchy',
      title: '제7장 규정의 위계 — 무엇이 우선인가',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li>이 헌장 (기본방침)</li>
          <li>영역별 정책 — 직업위키·전공위키·HowTo·커뮤니티 편집지침</li>
          <li>운영 절차서 — 토론·합의 절차서, 신고·이의·제재 절차서</li>
          <li>도움말·FAQ</li>
        </ol>
        <p class="mt-3">상위 규정과 하위 규정이 충돌하면 상위 규정이 우선합니다.
        모든 정책은 이 헌장의 5가지 가치와 어긋나면 안 됩니다.</p>
      `
    },
    {
      id: 'amendment',
      title: '제8장 규정 개정 절차',
      content: `
        <p>이 헌장을 포함한 모든 정책은 다음 절차로 개정됩니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>개정안 발의</strong> — 누구든 피드백 게시판에 정책 개정 제안 가능</li>
          <li><strong>의견 수렴 (7일 이상)</strong> — 정책 페이지 또는 피드백 게시판에서 토론</li>
          <li><strong>운영팀 검토</strong> — 의견을 반영하여 최종안 작성</li>
          <li><strong>시행 공지</strong> — 시행 7일 전 공지 (긴급한 사유는 즉시 시행 + 사후 공지)</li>
          <li><strong>안전장치</strong> — 시행 후 24시간 이내에는 새 규정으로 신규 제재 불가</li>
          <li><strong>불소급</strong> — 개정 전 발생 사안은 개정 전 규정으로 처리 (사용자에게 더 유리한 경우 신 규정 적용 가능)</li>
        </ol>
      `
    },
    {
      id: 'precedence-of-law',
      title: '제9장 법령 우선 원칙',
      content: `
        <p>대한민국 법령(개인정보 보호법, 정보통신망법, 저작권법, 청소년 보호법, 공정거래법 등)은
        이 정책보다 우선합니다.</p>
        <p>특히 다음 법령은 강행 규정으로 적용됩니다:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>정보통신망법 제44조의2 — 권리침해 신고 30일 임시조치</li>
          <li>공정거래위원회 추천·보증 심사지침 (2024.12.1 시행) — 광고·제휴 표시 의무</li>
          <li>개인정보 보호법 — 미성년자 가입 시 법정대리인 동의</li>
          <li>자살예방 및 생명존중문화 조성을 위한 법률 — 자살예방상담 109/1393 안내 의무</li>
        </ul>
      `
    },
    {
      id: 'liability',
      title: '제10장 책임의 한계',
      content: `
        <p>Careerwiki는 다음에 대해 책임을 지지 않습니다:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>이용자가 서비스 정보를 활용하여 내린 진로 결정의 결과</li>
          <li>공공데이터 원본의 오류로 인한 정보 부정확</li>
          <li>이용자 간 분쟁 (정책 위반 신고 시 정책 위반 여부만 판단)</li>
          <li>AI 추천·생성 데이터의 정확성·완전성</li>
        </ul>
        <p class="mt-3">서비스를 이용한 진로 결정은 본인의 판단과 책임 하에 이루어집니다.
        의학·법률·세무 등 전문 분야는 반드시 자격을 갖춘 전문가의 상담을 받으세요.</p>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '기본방침',
      icon: 'fa-scale-balanced',
      title: 'Careerwiki 기본방침 (헌장)',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: 'Careerwiki 기본방침',
      intro: `Careerwiki의 모든 정책의 토대가 되는 최상위 문서입니다.
        다른 정책 문서는 이 헌장과 충돌할 수 없으며, 충돌 시 헌장이 우선합니다.`,
      addendum: '이 헌장은 2026년 4월 30일부터 시행합니다. 향후 개정은 제8장 절차에 따릅니다.'
    },
    sections,
    options
  )
}
