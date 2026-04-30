/**
 * /policy/source-tier — 출처 신뢰성 등급표 (1~8순위)
 * Careerwiki 위키 데이터의 출처를 8단계로 분류한 핵심 기준
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

export function renderSourceTierPage(options?: PolicyPageOptions): string {
  const sections: PolicySection[] = [
    {
      id: 'why',
      title: '왜 출처에 등급을 매기는가',
      content: `
        <p>같은 사실이라도 출처에 따라 신뢰의 무게가 다릅니다. 한국직업사전의 평균 임금과
        개인 블로그의 "내 친구 연봉" 후기는 같은 무게로 다룰 수 없습니다.</p>
        <p>분쟁이 났을 때 어느 쪽이 맞는지 판단하려면 <strong>객관적인 기준</strong>이 필요합니다.
        Careerwiki는 출처를 1순위(가장 신뢰)에서 8순위(낮은 신뢰)로 분류하고,
        분쟁 시 더 높은 순위 출처가 이깁니다.</p>
        <div class="callout-good callout">
          <strong>핵심 룰 5줄:</strong>
          <ol class="list-decimal list-inside mt-2 space-y-1">
            <li>위키 본문의 <strong>모든 사실 주장</strong>은 5순위 이상 출처 1개 이상 필수.</li>
            <li>통계·수치는 <strong>2순위 이상</strong> 출처 직접 인용.</li>
            <li>분쟁 시 <strong>높은 순위가 이긴다</strong>.</li>
            <li>8순위만으로 작성된 서술이 분쟁 대상이면 <strong>존치측 입증 책임</strong> — 5순위 이상 보강 못 하면 삭제.</li>
            <li><strong>개인 의견</strong>은 출처 등급과 무관 — "개인 의견" 라벨만 붙이면 OK.</li>
          </ol>
        </div>
      `
    },
    {
      id: 'tier-table',
      title: '8단계 등급표',
      content: `
        <table>
          <thead>
            <tr><th style="width: 60px;">순위</th><th>분류</th><th>예시</th></tr>
          </thead>
          <tbody>
            <tr>
              <td><strong style="color:#a78bfa;">1순위</strong></td>
              <td><strong>공식 분류·법령</strong><br><span class="text-xs text-slate-400">법조문, 정부 표준 분류, 자격 기본 규정</span></td>
              <td>한국직업사전, NCS, 통계청 표준 산업·직업분류,<br>의료법·자격기본법 등 직접 조문</td>
            </tr>
            <tr>
              <td><strong style="color:#a78bfa;">2순위</strong></td>
              <td><strong>국가 통계·공공 데이터</strong><br><span class="text-xs text-slate-400">정부 발간 통계, 공식 임금 정보</span></td>
              <td>KOSIS, 워크넷 임금정보, 교육부 학과 통계, 통계청 KECO,<br>한국고용정보원(KEIS) 통계 보고서</td>
            </tr>
            <tr>
              <td><strong style="color:#818cf8;">3순위</strong></td>
              <td><strong>학술 논문</strong><br><span class="text-xs text-slate-400">동료 심사 거친 학술지</span></td>
              <td>KCI 등재 학술지, SCI·SCOPUS·SSCI 등재 논문,<br>박사학위 논문</td>
            </tr>
            <tr>
              <td><strong style="color:#818cf8;">4순위</strong></td>
              <td><strong>공공기관·산하기관 보고서</strong><br><span class="text-xs text-slate-400">국책연구원·정부산하기관 발간</span></td>
              <td>한국직업능력연구원, 한국교육개발원(KEDI),<br>각 정부 부처 공식 백서·정책 자료집</td>
            </tr>
            <tr>
              <td><strong style="color:#60a5fa;">5순위</strong></td>
              <td><strong>업계 협회·자격관리기관</strong><br><span class="text-xs text-slate-400">공식 인정받은 직능 단체</span></td>
              <td>대한의사협회, 한국공인회계사회, 변호사회,<br>한국기자협회, 한국게임산업협회 발표 자료</td>
            </tr>
            <tr>
              <td><strong style="color:#60a5fa;">6순위</strong></td>
              <td><strong>기업·공공 채용공고·공시</strong><br><span class="text-xs text-slate-400">공식 발표·공시 자료</span></td>
              <td>DART 사업보고서, 채용공고 직무기술서,<br>공공기관 알리오 공시</td>
            </tr>
            <tr>
              <td><strong style="color:#fbbf24;">7순위</strong></td>
              <td><strong>제도권 언론 + 백과사전</strong><br><span class="text-xs text-slate-400">한국언론진흥재단 등록 매체 등</span></td>
              <td>일간지, 시사주간지, 방송 보도, 위키백과의 사실 부분만,<br>업계 전문 매체(요즘IT, 디스콰이엇 기사 등)</td>
            </tr>
            <tr>
              <td><strong style="color:#f87171;">8순위</strong></td>
              <td><strong>업계 종사자 인터뷰·블로그·SNS</strong><br><span class="text-xs text-slate-400">정성 후기, 개인 진술</span></td>
              <td>잡플래닛 후기, 블라인드 글, 개인 블로그,<br>유튜브 직무 인터뷰, 트위터/X 글</td>
            </tr>
          </tbody>
        </table>
      `
    },
    {
      id: 'usage-rule',
      title: '실제 사용 룰',
      content: `
        <h3 class="text-base font-semibold text-white mt-4 mb-2">A. 통계·수치 (연봉·취업률·만족도 등)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li><strong>2순위 이상</strong>만 인용. KOSIS, 워크넷, 교육부 통계가 1순위 후보.</li>
          <li>5~7순위 매체가 "○○ 통계청 발표에 따르면"이라고 인용한 경우, 가능하면 원 통계청 자료를 직접 링크.</li>
          <li>잡플래닛·블라인드 같은 8순위 출처의 평균치 인용은 <strong>금지</strong>. 그 사이트의 정성 후기 인용은 가능.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">B. 직무 내용·필요 역량</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>NCS(1순위) + 한국직업사전(1순위) 우선.</li>
          <li>업계 협회 발표(5순위)도 OK.</li>
          <li>최신 트렌드 직무는 7순위 매체 + 8순위 인터뷰 보강 가능. 단 본문에 "○○년 기준" 시점 명시.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">C. 평가·전망 (호평·비판·미래 예측)</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>"AI로 사라질 직업" 같은 미래 예측은 <strong>4순위 이상</strong> 출처 필수.</li>
          <li>호평·비판은 한 문단에 균형 있게. attribution 의무 ("○○ 협회는 ~라고 평가한다").</li>
          <li>주관적 평가는 <strong>"개인 의견"으로 라벨링</strong>하면 출처 없이도 가능.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">D. 트리비아·일화·재미있는 사실</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>7순위 이상 출처 1건 이상.</li>
          <li>인터넷 커뮤니티의 "썰"은 7순위 이상 매체에서 인용·언급된 경우에만.</li>
        </ul>

        <div class="callout">
          <strong>예외: 개인 의견 라벨</strong> — "개인 의견" 또는 "현직자 본인의 견해"라고
          한 줄로 표시한 단락은 출처 등급 룰의 적용을 받지 않습니다.
          단, 그 단락이 "사실인 척" 위장하면 편집권 남용으로 다룹니다.
        </div>
      `
    },
    {
      id: 'dispute',
      title: '분쟁 처리 — 더 높은 등급이 이긴다',
      content: `
        <p>같은 직업의 평균 연봉을 두고 8순위 블로그와 2순위 KOSIS 통계가 충돌한다면
        <strong>2순위가 이깁니다</strong>. 단순 명료.</p>

        <p>같은 등급의 출처가 충돌하는 경우에는:</p>
        <ol class="list-decimal list-inside space-y-1">
          <li>최신 자료가 우선 (조사년도 명시).</li>
          <li>표본 크기가 큰 자료가 우선.</li>
          <li>직접 조사 vs 재인용이라면 직접 조사 우선.</li>
          <li>위 셋으로도 결론 안 나면 토론·합의 절차로 처리 (양측 모두 본문 병기 가능).</li>
        </ol>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">존치측 입증 책임</h3>
        <p>이 룰이 가장 강력한 분쟁 정리 도구입니다.</p>
        <ul class="list-disc list-inside space-y-1">
          <li>분쟁이 난 서술이 8순위 출처만으로 작성되어 있으면, <strong>그 서술을 유지하려는 쪽이 5순위 이상 출처를 보강해야</strong> 합니다.</li>
          <li>7일 안에 보강 못 하면 자동 삭제 또는 "개인 의견" 라벨로 강등.</li>
          <li>AI가 채운 서술은 자동으로 이 룰의 대상 — AI가 "1순위 출처 KOSIS"라고 적었어도, 실제 KOSIS에 해당 통계가 없으면 삭제됩니다.</li>
        </ul>
      `
    },
    {
      id: 'ai-data',
      title: 'AI 생성 데이터의 출처 처리',
      content: `
        <p>AI가 직업·전공 데이터를 채울 때는 다음 룰을 따릅니다.</p>
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>출처 직접 인용 의무</strong> — AI가 통계·수치를 적을 때는 반드시 1~2순위 원 출처 URL과 조사년도 명시.</li>
          <li><strong>저장 위치 분리</strong> — AI 생성분은 <code>admin_data_json</code>에, 사용자 기여분은 <code>user_contributed_json</code>에 저장.</li>
          <li><strong>검수 라벨</strong> — 직업 페이지 신뢰 박스에 "AI 생성·검수일 ○○○"으로 노출.</li>
          <li><strong>존치측 입증 책임 자동 적용</strong> — AI 생성 데이터의 출처 검증 실패 시 즉시 삭제.</li>
          <li><strong>7일 미검수 자동 표시</strong> — AI가 채우고 7일 내 사람 검수 없는 필드는 "검수 필요" 상태 전환.</li>
        </ol>
      `
    },
    {
      id: 'examples',
      title: '실제 예시',
      content: `
        <table>
          <thead>
            <tr><th>주장</th><th>출처</th><th>판정</th></tr>
          </thead>
          <tbody>
            <tr>
              <td>"개발자 평균 연봉 5,000만원"</td>
              <td>잡플래닛 8순위</td>
              <td>❌ 통계 인용은 2순위 이상 — KOSIS·워크넷 임금정보 직접 인용 필요</td>
            </tr>
            <tr>
              <td>"개발자 평균 연봉 5,000만원 (2024 KOSIS)"</td>
              <td>KOSIS 직접 링크 2순위</td>
              <td>✅ OK</td>
            </tr>
            <tr>
              <td>"의사가 되려면 의사면허가 필요하다"</td>
              <td>의료법 1순위</td>
              <td>✅ OK (1순위 자체)</td>
            </tr>
            <tr>
              <td>"이 직업은 야근이 많아 워라밸이 안 좋다"</td>
              <td>본인 경험</td>
              <td>✅ OK — 단 "[개인 의견]" 라벨 또는 "현직자 본인 견해" 표시</td>
            </tr>
            <tr>
              <td>"이 직업은 워라밸이 안 좋다"</td>
              <td>표시 없음</td>
              <td>⚠️ 분쟁 시 5순위 이상 출처 보강 필요 또는 "[개인 의견]" 라벨로 강등</td>
            </tr>
            <tr>
              <td>"AI로 인해 5년 내 사라질 직업"</td>
              <td>유튜브 8순위</td>
              <td>❌ 미래 예측은 4순위 이상 (KEIS 직업 전망 보고서 등)</td>
            </tr>
            <tr>
              <td>"이 직무에는 Python 능숙도가 필수"</td>
              <td>NCS 1순위 + 채용공고 6순위</td>
              <td>✅ OK</td>
            </tr>
          </tbody>
        </table>
      `
    },
    {
      id: 'how-to-cite',
      title: '출처 표기 형식',
      content: `
        <p>Careerwiki는 본문 내 [N] 각주 + 페이지 하단 references 목록 형태입니다.</p>
        <p>출처 항목은 다음 정보를 포함해야 합니다:</p>
        <ul class="list-disc list-inside space-y-1">
          <li>출처 이름 (예: 한국직업사전, KOSIS, 의료법)</li>
          <li>발행일 / 조사년도</li>
          <li>URL (가능한 경우)</li>
          <li>관련 페이지 또는 데이터 식별자</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">올바른 표기</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>한국고용정보원 워크넷 임금정보 (2024). https://www.work24.go.kr/...</li>
          <li>의료법 제5조 (2024-04 개정). https://www.law.go.kr/법령/의료법</li>
          <li>한국직업사전 통합본 6판 (2023). 한국고용정보원.</li>
        </ul>

        <h3 class="text-base font-semibold text-white mt-4 mb-2">피해야 할 표기</h3>
        <ul class="list-disc list-inside space-y-1">
          <li>"공식 자료에 따르면" — 어느 자료인지 명시 필요</li>
          <li>"통계청" 한 단어 — 조사년도·통계 이름 누락</li>
          <li>같은 사이트의 다른 페이지를 출처로 사용 (자기 인용)</li>
          <li>죽은 링크 — 링크 검사 후 archive.org 링크로 백업</li>
        </ul>
      `
    }
  ]

  return renderPolicyPage(
    {
      kicker: '출처 등급',
      icon: 'fa-layer-group',
      title: '출처 신뢰성 등급표 (1~8순위)',
      subtitle: '버전 1.0 · 시행 2026-04-30',
      pageTitle: '출처 신뢰성 등급표',
      intro: `Careerwiki에서 직업·전공 데이터의 출처를 어떻게 평가하는지에 대한 기준입니다.
        편집·분쟁 처리·AI 데이터 검증의 핵심 결정 룰입니다.`,
      addendum: '이 정책은 2026년 4월 30일부터 시행합니다.'
    },
    sections,
    options
  )
}
