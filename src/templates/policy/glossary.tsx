/**
 * /help/glossary — Careerwiki 용어 사전
 * 정책 문서에 자주 등장하는 용어를 한 페이지에서 풀이
 */

import { renderPolicyPage, type PolicySection, type PolicyPageOptions } from './_shared'

type Term = {
  term: string
  desc: string
  related?: string
}

const TERMS: Record<string, Term[]> = {
  '편집·서술': [
    { term: '편집 요약', desc: '편집 시 변경 사유 한 줄. 5자 이상 의무. 비하·반말 금지.' },
    { term: '편집권 남용', desc: '편집 기능을 훼손·규정 위반·여론조작 목적으로 쓰는 것.' },
    { term: '편집 분쟁', desc: '여러 편집자가 서로 다른 방향으로 같은 서술을 반복 편집하는 상태.' },
    { term: '편집 합의', desc: '편집 분쟁 후 토론을 거쳐 도달한 결론. 본문에 반영되며 변경 시 새 토론 필요.' },
    { term: '편집 요청', desc: '권한 부족자가 편집권 보유자에게 변경을 요청하는 기능.' },
    { term: '신규 서술', desc: '추가 후 7일 미만의 본문. 분쟁 시 추가자에게 입증 책임이 있음.' },
    { term: '기존 서술', desc: '추가 후 7일 이상의 본문. 분쟁 시 양측이 토론·합의해야 변경 가능.' },
    { term: '독자연구', desc: '출처 없는 본인 추론·분석. 위키 본문 게시 금지.' },
    { term: '존치 측 / 삭제 측', desc: '분쟁 시 서술을 유지하려는 쪽 / 빼려는 쪽.' },
    { term: '존치측 입증 책임', desc: '8순위 출처만으로 작성된 분쟁 서술은 유지하려는 쪽이 5순위 이상 출처를 보강해야 한다는 룰.' }
  ],
  '출처·근거': [
    { term: '출처 신뢰성 등급', desc: '1~8순위로 구성된 출처 위계. 1순위는 법령·공식 분류, 8순위는 개인 블로그·SNS.' },
    { term: '1순위 출처', desc: '한국직업사전, NCS, 통계청 표준분류, 의료법·자격기본법 같은 공식 분류·법령.' },
    { term: '2순위 출처', desc: 'KOSIS, 워크넷 임금정보 같은 국가 통계·공공 데이터.' },
    { term: '5순위 출처', desc: '대한의사협회 같은 업계 협회·자격관리기관 공식 발표.' },
    { term: '8순위 출처', desc: '잡플래닛·블라인드·개인 블로그 같은 정성 후기·개인 진술.' },
    { term: 'attribution', desc: '서술의 출처를 본문에 명시하는 것. "○○ 협회는 ~라고 평가한다" 식.' },
    { term: '제도권 언론', desc: '한국언론진흥재단·한국기자협회 등록 매체. 7순위 등재 기준의 핵심.' },
    { term: '각주 [N]', desc: '본문 중 출처 표시. 페이지 하단 references 목록과 연결됨.' }
  ],
  '토론·합의': [
    { term: '발제', desc: '토론을 여는 행위 또는 그 게시물. "발제하다", "발제자".' },
    { term: '서술 시점 고정', desc: '토론 진행 중 분쟁 대상 서술을 특정 시점으로 고정해 변경 불가하게 하는 것.' },
    { term: '합의안', desc: '토론 끝에 양측이 동의한 결론. 이의 제기 기간을 통과해야 효력 발생.' },
    { term: '이의 제기 기간', desc: '합의안에 대한 새 의견을 받는 대기 시간. 최소 48시간 + 6시간 갱신.' },
    { term: '중재', desc: '운영자(중재자)가 토론에 개입해 결론 도출을 돕는 절차.' },
    { term: '합의 무효화', desc: '사실관계 변경·부정 접속·운영 방해 발견 시 기존 합의를 무효로 하는 절차.' }
  ],
  '신고·제재': [
    { term: '신고', desc: '위반 콘텐츠를 운영팀에 알리는 행위. 사유 6종 + "기타"는 20자 이상.' },
    { term: '임시조치', desc: '신고 접수 후 30일간 게시물을 비공개 처리하는 정보통신망법상 절차.' },
    { term: '소명', desc: '제재된 이용자가 해명·반성하는 절차. 30일 이내 1회.' },
    { term: '제재 단계제', desc: '경고 → 7일 정지 → 30일 정지 → 영구 정지의 4단계 누적 제재.' },
    { term: '즉시 영구 정지', desc: '아동성착취·폭력 협박·차단 회피·해킹 등 명백 위반에 단계 건너뛰고 즉시 영구.' },
    { term: '차단 회피', desc: '제재 중에 부계정·다른 IP로 활동하는 행위. 적발 시 즉시 영구.' },
    { term: '신고권 박탈', desc: '허위 신고 누적 3회 시 신고 권한을 박탈하는 어뷰징 방어 조치.' }
  ],
  '커뮤니티·익명성': [
    { term: '비회원 / 일반 회원 / 운영진', desc: 'Careerwiki의 3단계 사용자 구분. 학교·직업 인증 시스템은 별도이며 본 정책에 포함되지 않음.' },
    { term: '자기 진술', desc: '댓글·후기에 본인이 직접 적는 경력·학년 등의 진술. 시스템이 검증하지 않으며, 신뢰는 글의 내용·문맥으로 평가됨.' },
    { term: 'karma', desc: '평판 점수. 추천·베스트 등재로 가산. -10 이하면 작성권 일부 제한.' },
    { term: '베스트 답변', desc: '추천 N개 + 댓글 N개 도달 시 페이지 상단에 자동 등재되는 답변.' },
    { term: '에디터 추천', desc: '운영자·검증된 전문가가 수동으로 별표 부여하는 정성 큐레이션.' }
  ],
  'AI·콘텐츠': [
    { term: 'AI 라벨', desc: 'HowTo의 AI 사용도에 따른 3단계 표시. 보조 / 초안+검수 / AI 생성.' },
    { term: 'AI 보조', desc: '사람 작성 + AI 일부 보조. AI 비율 ≤ 50%.' },
    { term: 'AI 초안 + 사람 검수', desc: 'AI가 초안 + 편집자 검수·보강. 본문 상단 박스 표시 의무.' },
    { term: '[개인 의견]', desc: '의견 단락임을 표시하는 라벨. 출처 등급 룰 적용 안 함.' },
    { term: '광고 표시', desc: '제목 또는 본문 첫 줄에 본문보다 큰 글자로 "광고/협찬/유료광고 포함" 표기. 공정거래위원회 추천보증 심사지침.' },
    { term: '제휴 링크', desc: 'affiliate 링크. rel="sponsored nofollow" 부여 + 명시적 disclosure 의무.' }
  ],
  '운영·관리': [
    { term: '운영 방해', desc: '외부 동원·근거 없는 비방·자의적 규정 해석 등으로 운영을 방해하는 행위.' },
    { term: '이해충돌', desc: '운영자가 자기 사안에 권한을 행사하는 것. 행동 강령상 회피 의무.' },
    { term: '권리침해 임시조치', desc: '저작권·명예훼손·개인정보 신고 시 30일 게시 중단. 정보통신망법 제44조의2.' },
    { term: '투명성 보고서', desc: '분기별로 신고 처리·차단·토론 통계를 공개하는 보고서.' }
  ]
}

export function renderGlossaryPage(options?: PolicyPageOptions): string {
  const sections = Object.entries(TERMS).map(([category, terms]) => ({
    id: 'cat-' + category.replace(/[^a-zA-Z가-힣]/g, ''),
    title: category,
    content: `
      <dl class="space-y-3">
        ${terms.map(t => `
          <div class="border-l-2 border-blue-500/30 pl-4 py-1">
            <dt class="font-semibold text-white">${escapeHtml(t.term)}</dt>
            <dd class="text-sm text-slate-300 mt-1">${escapeHtml(t.desc)}</dd>
            ${t.related ? `<dd class="text-xs text-slate-400 mt-1">→ ${escapeHtml(t.related)}</dd>` : ''}
          </div>
        `).join('')}
      </dl>
    `
  }))

  return renderPolicyPage(
    {
      kicker: '용어 사전',
      icon: 'fa-book',
      title: 'Careerwiki 용어 사전',
      subtitle: `${Object.values(TERMS).flat().length}개 용어`,
      pageTitle: '용어 사전',
      intro: `정책 문서에 자주 등장하는 용어를 한 페이지에서 풀이합니다.
        한국 위키 문화에서 통용되는 용어와 Careerwiki 고유 용어가 함께 있습니다.`
    },
    sections,
    options
  )
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }
  return String(text).replace(/[&<>"']/g, (m) => map[m])
}
