/**
 * /policy/howto — HowTo 발행지침
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderHowtoPolicyPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'scope',
      title: '제1조 적용 범위',
      content: `
        <p>이 지침은 <code>/howto/{슬러그}</code>에 발행되는 모든 진로 가이드(HowTo)에 적용됩니다.</p>
        <p>HowTo는 위키와 다릅니다. <strong>작성자 한 사람의 경험·관점·CTA가 허용</strong>됩니다.
        그 자유의 전제가 이 지침입니다.</p>
      `
    },
    {
      id: 'principles',
      title: '제2조 작성 원칙 (5조)',
      content: `
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>목적성</strong> — 특정 직업·전공에 진입하려는 독자에게 <em>실행 가능한 단계</em>와 정보를 제공. 단순 광고 글 금지.</li>
          <li><strong>1차 출처 우선</strong> — 통계·수치·인용은 KOSIS·통계청·NCS·워크넷 같은 1차 출처 직접 링크. "어디서 봤는지" 명시.</li>
          <li><strong>경험 표시 (E-E-A-T)</strong> — 직접 경험·자격이 있으면 본문 상단 또는 작성자 프로필에 명시. 없으면 정보 종합형으로.</li>
          <li><strong>독창성</strong> — 다른 글·생성형 AI 출력 그대로 복제 금지. 인용은 전체의 20% 이내 + 출처.</li>
          <li><strong>분량</strong> — 본문 1,500~3,000자 권장. 750자 미만은 발행 차단.</li>
        </ol>
      `
    },
    {
      id: 'ai-label',
      title: '제3조 AI 라벨 3단계 — 의무',
      content: `
        <p>HowTo의 본문에 AI가 얼마나 관여했는지에 따라 다음 3단계로 라벨링합니다.</p>
        <table>
          <thead>
            <tr><th style="width: 28%;">라벨</th><th style="width: 22%;">정의</th><th>표시 방식</th></tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>AI 보조</strong></td>
              <td>사람 작성 + AI 일부 보조 (번역·교정·아이디어). AI 비율 ≤ 50%.</td>
              <td>메타 영역에만 표시 (선택), 본문 상단 표시 권장.</td>
            </tr>
            <tr>
              <td><strong>AI 초안 + 사람 검수</strong></td>
              <td>AI가 초안 + 편집자가 검수·보강. AI 비율 50~95%.</td>
              <td><strong>본문 상단 박스 의무</strong>: "이 글은 AI 초안을 편집자(○○○)가 검수·보강했습니다. 마지막 검수: YYYY-MM-DD"</td>
            </tr>
            <tr>
              <td><strong>AI 생성 (사람 검수 없음)</strong></td>
              <td>AI 비율 95%+ + 사람 검수 거의 없음.</td>
              <td><strong>발행 차단</strong> 또는 별도 디렉토리(<code>/ai-draft/</code>) 격리 + noindex.</td>
            </tr>
          </tbody>
        </table>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">AI 생성 이미지</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>caption 또는 alt에 "AI 생성 (모델명)" 표기 (예: "AI 생성 (ComfyUI/Flux1.dev)").</li>
          <li>실제 인물·기관 이미지로 오해할 수 있는 AI 사진은 게시 금지.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">메타데이터</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><code>&lt;meta name="ai-content-level" content="ai-draft-human-edited"&gt;</code> 자동 삽입.</li>
          <li>리스트 카드에 AI 라벨 배지(🤖) 노출.</li>
        </ul>
      `
    },
    {
      id: 'ad-disclosure',
      title: '제4조 광고·제휴·후원 표시 — 법적 의무',
      content: `
        <div class="callout-danger callout">
          <strong>⚖️ 법적 강행 규정</strong> — 공정거래위원회 추천보증 심사지침(2024.12.1 시행).
          위반 시 <strong>시정명령·공표명령·과징금</strong> 부과될 수 있음.
        </div>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 표시 위치</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>제목 또는 본문 첫 줄</strong> (스크롤 없이 보이는 영역).</li>
          <li>본문 끝에 <code>#광고</code> 한 줄만 다는 것은 <strong>위반</strong>.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 표시 형식</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>본문보다 <strong>큰 글자</strong> 또는 <strong>다른 색</strong>.</li>
          <li>이미지 위에 글자를 넣을 경우, 흰 배경에 검정 글자처럼 명확한 대비.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 표시 표현</h3>
        <p>다음 중 하나 (의미가 명확해야 함):</p>
        <ul class="list-disc list-inside space-y-1">
          <li>"광고"</li>
          <li>"협찬"</li>
          <li>"유료광고 포함"</li>
          <li>"○○로부터 수수료를 지급받음"</li>
          <li>"○○로부터 제품을 제공받음"</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 제휴 링크 (Affiliate Links)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>모든 affiliate 링크에 <code>rel="sponsored nofollow"</code> 자동 부여 (편집기 처리).</li>
          <li>제휴 링크 옆 또는 단락 시작에 "쿠팡 파트너스 활동의 일환으로, 일정액의 수수료를 제공받을 수 있습니다" 등 명시.</li>
        </ul>
      `
    },
    {
      id: 'forbidden',
      title: '제5조 금지 콘텐츠',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>학력·자격·소득에 대한 차별·비하 표현.</li>
          <li>보호받는 특성(성별·지역·연령·장애·국적·종교·성적지향) 기반 혐오 표현.</li>
          <li>특정 학원·학교·자격증의 광고를 후기로 위장한 글 (§4 광고 표시 적용 시에도 별도 금지).</li>
          <li>공인되지 않은 자격증·시험을 공인 자격처럼 안내하는 글.</li>
          <li>의료·법률·세무 관련 단정 — 자격 있는 전문가 상담 권유 문구 동반 의무.</li>
          <li>자살·자해·폭력의 구체적 방법·도구·장소 적시 (직업위키 §7 동일).</li>
          <li>미성년 대상 위험 직업(군 특수보직 등) 글 — 연령 안내 명시 의무.</li>
        </ul>
      `
    },
    {
      id: 'anti-abuse',
      title: '제6조 어뷰징 방지',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 중복 콘텐츠</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>동일 직업·전공에 사실상 동일 본문을 슬러그만 바꿔 발행 금지.</li>
          <li>다른 사이트에 발행한 글과 80% 이상 일치 시 발행 차단.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 키워드 도배</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>메인 키워드가 본문 단어수의 3% 초과 시 자동 검사 → 발행 차단 또는 경고.</li>
          <li>제목·H2·H3에 메인 키워드가 자연스럽게 포함되는 것은 OK (3% 룰의 예외).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 자동화</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>자동 댓글·자동 좋아요·자동 발행 도구 사용 금지.</li>
          <li>위반 시 작성자 계정 일시정지.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 발행 한도</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>1일 1인 발행 한도 5건 (티스토리 'bad' 등급 차용). 검수자 권한 사용자만 예외.</li>
          <li>AI로 한 직업당 N개 이상 일괄 발행 시 자동으로 "검수 대기" 상태로 holding.</li>
        </ul>
      `
    },
    {
      id: 'style-guide',
      title: '제7조 작성 스타일 가이드 (한국 블로그 통념)',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 구조 (도입-본문-마무리)</h3>
        <pre class="bg-slate-800/50 p-3 rounded-lg text-xs text-slate-300 overflow-x-auto">
[도입 200~400자]
- 1줄 공감 후크 ("수의대 입시, 막막하시죠?")
- 2~3줄 스코프 안내
- 첫 사진(직관적 이미지) 1장

[본문 1,200~2,500자]
- H2: 단계/장 (3~7개)
- H3: 세부 항목
- 단락 4~5줄, 한 문장 50자 내외
- 단계마다 이미지/표/리스트 1개

[마무리 200~300자]
- 핵심 3줄 요약
- 다음 글 추천 2~3개
- 위키 페이지 CTA
        </pre>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 길이 가이드</h3>
        <table>
          <thead><tr><th>카테고리</th><th>권장 길이</th></tr></thead>
          <tbody>
            <tr><td>입시 가이드</td><td>2,500~3,500자</td></tr>
            <tr><td>직업 진입 가이드</td><td>1,800~2,500자</td></tr>
            <tr><td>경력 전환 가이드</td><td>1,500~2,200자</td></tr>
            <tr><td>자격증·강의 후기</td><td>1,200~1,800자 (광고 표시 시 §4 적용)</td></tr>
          </tbody>
        </table>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 이미지</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>첫 사진: 직관적·공감 이미지 1장 (단순 텍스트 없는 것).</li>
          <li>본문 이미지: 단계마다 1장. 스크린샷·다이어그램·인포그래픽.</li>
          <li>R2 경로: <code>howto/{슬러그}/cover.webp</code>, <code>howto/{슬러그}/step-{n}.webp</code>.</li>
          <li>워터마크 있는 타사 이미지·출처 불명 이미지 금지.</li>
          <li>alt 속성 필수.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 헤딩</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>H1: 글 제목 1개만 (페이지 자동).</li>
          <li>H2: 단계·장 3~7개.</li>
          <li>H3: H2 하위 세부 항목.</li>
          <li>H2/H3에 메인 키워드 자연 포함.</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">E. 가독성·모바일</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>한 단락 4~5줄, 한 문장 50자 내외.</li>
          <li>굵게 강조는 단락당 1~2개.</li>
          <li>모바일 가로 320px 기준 가독성 우선 — 표는 가로 스크롤.</li>
          <li>모바일 인터스티셜 전면광고 금지 (티스토리 2025.9.3 정책 차용).</li>
        </ul>
        <h3 class="text-base font-semibold text-white mt-4 mb-2">F. 톤</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>존댓말 기본. 친근하지만 가볍지 않게.</li>
          <li>"~한다고 합니다" 대신 "○○통계청 2025년 자료에 따르면 ~입니다".</li>
          <li>"최고의", "유일한" 절대 표현 자제 (공정위 표시·광고 위반 가능).</li>
          <li>국립국어원 한글 맞춤법, 외래어 표기법 준수.</li>
        </ul>
      `
    },
    {
      id: 'wiki-comparison',
      title: '제8조 위키와 모순될 때 — 자동 비교 박스',
      content: `
        <p>HowTo 본문이 위키 데이터와 통계·사실에서 모순될 경우,
        본문에 자동 "위키와 비교" 박스가 삽입됩니다.</p>
        <div class="callout-warn callout">
          <strong>예시 박스</strong>:<br>
          위키 평균 연봉 4,500만원 / 본 글 주장 6,000만원 — 출처 차이 확인 필요
        </div>
        <p class="mt-3">이 메커니즘은 <strong>위키의 신뢰성을 훼손하지 않으면서 HowTo의 자유를 보장</strong>하기 위한 장치입니다.
        HowTo 작성자는 자기 주장의 출처를 보강하거나, "[개인 경험]" 라벨로 강등하면 됩니다.</p>
      `
    },
    {
      id: 'author-rights',
      title: '제9조 작성자 권리',
      content: `
        <ul class="list-disc list-inside space-y-1">
          <li>작성자는 자기 HowTo의 저작권을 보유합니다 (Careerwiki에 비독점 사용권 부여).</li>
          <li>작성자는 언제든 자기 HowTo를 수정·비공개 처리할 수 있습니다.</li>
          <li>비공개 처리된 글의 데이터는 30일간 복원 가능 상태로 보존 후 영구 삭제 (권리침해·개인정보 노출 등 즉시삭제 사유는 예외).</li>
          <li>외부 사이트에 같은 글을 발행할 권리는 작성자에게 있습니다 (단 §6-A 중복 콘텐츠 룰은 새 발행 글에 적용).</li>
        </ul>
      `
    },
    {
      id: 'enforcement',
      title: '제10조 위반 시 처리',
      content: `
        <p><a href="/policy/enforcement" class="text-blue-300 hover:underline">신고·이의·제재 절차서</a>를 따릅니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>광고 미표시(§4 위반): 1차 경고 + 표시 추가 → 반복 시 작성자 자격 정지.</li>
          <li>AI 라벨 누락(§3 위반): 발행 보류 → 라벨 추가 시 재공개.</li>
          <li>중복·자동화 어뷰징(§6 위반): 1차 경고 → 7일 정지 → 30일 정지 → 영구.</li>
          <li>금지 콘텐츠(§5 위반): 즉시 비공개 + 사유 통지 + 이의제기 30일.</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: 'HowTo 발행',
      icon: 'fa-route',
      title: 'HowTo 발행지침',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: 'HowTo 발행지침',
      intro: `진로 가이드(HowTo) 작성·발행에 적용되는 규칙입니다.
        위키와 달리 작성자의 경험·관점이 허용되며, 그 자유의 전제로 AI 라벨·광고 표시·어뷰징 방지 의무가 명확히 정해져 있습니다.`,
      addendum: '이 지침은 2026년 4월 30일부터 시행합니다. 공정거래위원회 추천보증 심사지침은 2024년 12월 1일부터 이미 시행 중인 법적 의무입니다.'
    },
    sections,
    options
  )
}
