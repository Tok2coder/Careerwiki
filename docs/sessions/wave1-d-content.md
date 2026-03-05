# Wave 1 / Session D — Phase 6: HowTo 콘텐츠 발행

> **이 파일을 읽고 팀을 구성한 뒤 Phase 6 작업을 시작하세요.**
> **Phase 7 (직업 정보 보완), Phase 8 (신규 직업 추가)는 별도 세션으로 분리되었습니다.**

---

## 1. 공통 컨텍스트

### 프로젝트 개요
- **CareerWiki**: 한국어 진로 정보 위키 + AI 직업/전공 추천 플랫폼
- **Production**: https://careerwiki.org
- **Tech Stack**: Cloudflare Workers (Pages) + Hono + D1 (SQLite) + R2 + KV + Vectorize
- **AI/LLM**: Workers AI, OpenAI API (GPT-4o-mini)
- **Frontend**: TailwindCSS 3, TipTap editor
- **Build**: Vite, TypeScript strict mode

### 배포 절차 (이 세션은 코드 수정 없음 — API 호출만)
```
이 세션은 콘텐츠/데이터 작업이므로 코드 수정이 없습니다.
기존 API 엔드포인트를 호출하여 데이터를 생성/수정합니다.
빌드/배포가 필요하지 않습니다.
```

### 절대 금지
- 코드 파일 수정 (이 세션은 API 호출만)
- `DROP TABLE`, `DELETE FROM` (WHERE 없이)
- 출처 없는 통계/수치 사용
- 깨진 링크(dead link) 출처 사용

### 필수 읽기 파일
1. `CLAUDE.md` — 프로젝트 규칙 전체
2. `MASTER_PLAN.md` — Phase 6 섹션
3. `src/editor/editor.ts` — 에디터 확장 목록 (사용 가능한 노드 파악)
4. `src/templates/howtoDetail.ts` — HowTo 페이지 렌더링 구조 (rawHtml 경로)

### 인증 (세션 시작 전 필수)
```
모든 API는 쿠키 기반 인증 (session_token).

획득 방법:
1. 브라우저에서 careerwiki.org 관리자 로그인
2. 개발자 도구(F12) → Application → Cookies → session_token 값 복사
3. 세션 시작 시 Team Leader에게 전달

API 호출 시:
curl -X POST https://careerwiki.org/api/howto/publish-direct \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=여기에_토큰" \
  -d '{ ... }'
```

---

## 2. 팀 구성

| 역할 | 모델 | 실행 방식 | 임무 |
|------|------|----------|------|
| Team Leader | Opus (메인) | 메인 세션 | 조율, 콘텐츠 품질 검수, 최종 발행 승인 |
| Researcher | Sonnet | Task(run_in_background) | Deep Research: 주제별 실전 노하우, 출처 수집 |
| Content Creator | Sonnet | Task(run_in_background) | 리서치 기반 콘텐츠 작성 (Tiptap JSON) |
| Implementer | Sonnet | Task (순차) | API 호출로 발행, 프로덕션 렌더링 확인 |

에이전트 정의: `.claude/agents/researcher.md`, `content-creator.md`, `implementer.md`

### 실행 패턴
```
1. Team Leader: 주제 선정 (기존 사이트 콘텐츠 갭 분석)
2. Researcher → Task(run_in_background): Deep Research
   - 실전 노하우, 통계, 팁을 여러 출처에서 수집
   - 모든 출처 URL의 유효성 검증 (dead link 차단)
3. Content Creator → Task(run_in_background):
   - Researcher 결과 + 에디터 도구를 활용해 콘텐츠 작성
   - Tiptap JSON 포맷 (커스텀 노드 적극 활용)
4. Team Leader: 콘텐츠 품질 검수
   - 초보자에게 도움이 되는가?
   - 전문가가 봐도 말이 되는가?
   - 출처가 valid한가?
5. Implementer → Task: API 발행 → 프로덕션 렌더링 확인
6. 반복 (5-10개 완료까지)
```

---

## 3. Phase 6 목표

실전적이고 전문적인 HowTo 가이드 5-10개 발행.
"잘 모르는 유저가 보면 도움이 되고, 잘 아는 유저가 봐도 괜찮다고 느끼는" 수준.

---

## 4. 에디터 도구 (콘텐츠에 반드시 활용)

HowTo 콘텐츠는 `rawHtml` 경로로 렌더링됨 → Tiptap JSON이 HTML로 변환되어 저장.
아래 도구들을 **적절히 조합**해서 풍부한 콘텐츠를 만들어야 함.

### 기본 서식
```
heading (h1/h2/h3), paragraph, bold, italic, underline, strike
bulletList, orderedList, blockquote, horizontalRule, link
```

### 커스텀 블록 (CareerWiki 전용 — 적극 활용 필수)
```
checkpointBox   — 중요 단계 강조 박스 (핵심 포인트, 꼭 알아야 할 것)
conclusionBox   — 결론/요약 박스 (글 마무리, 핵심 정리)
qnaBlock        — Q&A 블록 (자주 묻는 질문 형태)
careerList      — 관련 직업/전공 목록 (data-slug로 사이트 내 링크 연결)
footnote        — 인라인 각주 (출처 표시, [1] [2] 형태)
```

### 미디어/구조
```
table           — 비교표, 자격증 정리 등
image           — 설명 이미지 (width/height/align 속성)
taskList        — 체크리스트 (준비물, 단계별 확인 등)
```

### Tiptap JSON 예시 (커스텀 노드 포함)
```json
{
  "type": "doc",
  "content": [
    {
      "type": "heading",
      "attrs": { "level": 1 },
      "content": [{ "type": "text", "text": "데이터 분석가 되는 방법: 현직자가 알려주는 로드맵" }]
    },
    {
      "type": "paragraph",
      "content": [{ "type": "text", "text": "데이터 분석가는 기업의 의사결정을 데이터로 뒷받침하는 직업입니다..." }]
    },
    {
      "type": "checkpointBox",
      "content": [
        {
          "type": "paragraph",
          "content": [{ "type": "text", "text": "핵심 포인트: SQL과 Python은 필수. 둘 다 6개월이면 실무 수준 가능." }]
        }
      ]
    },
    {
      "type": "heading",
      "attrs": { "level": 2 },
      "content": [{ "type": "text", "text": "1단계: 기초 스킬 쌓기" }]
    },
    {
      "type": "bulletList",
      "content": [
        { "type": "listItem", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "SQL 기본 문법 (SELECT, JOIN, GROUP BY)" }] }] },
        { "type": "listItem", "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "Python pandas 라이브러리" }] }] }
      ]
    },
    {
      "type": "qnaBlock",
      "content": [
        {
          "type": "qnaQuestion",
          "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "비전공자도 데이터 분석가가 될 수 있나요?" }] }]
        },
        {
          "type": "qnaAnswer",
          "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "네, 현직 데이터 분석가의 약 40%가 비전공자입니다..." }] }]
        }
      ]
    },
    {
      "type": "careerList",
      "content": [
        {
          "type": "careerListItem",
          "attrs": { "data-slug": "데이터-분석가", "data-type": "job" },
          "content": [{ "type": "paragraph", "content": [{ "type": "text", "text": "데이터 분석가" }] }]
        }
      ]
    },
    {
      "type": "conclusionBox",
      "content": [
        {
          "type": "paragraph",
          "content": [{ "type": "text", "text": "정리: SQL+Python 학습 → 포트폴리오 3개 → 인턴/주니어 지원이 가장 현실적인 경로입니다." }]
        }
      ]
    },
    {
      "type": "paragraph",
      "content": [
        { "type": "text", "text": "한국고용정보원 통계" },
        {
          "type": "text",
          "marks": [{ "type": "footnote", "attrs": { "data-footnote-text": "한국고용정보원 2024 직업전망", "data-footnote-url": "https://www.keis.or.kr" } }],
          "text": "[1]"
        }
      ]
    }
  ]
}
```

---

## 5. 발행 API

### 직접 발행 (권장)
```
POST https://careerwiki.org/api/howto/publish-direct
인증: Cookie: session_token=...

필수:
{
  "title": "string",
  "contentJson": "string (JSON.stringify된 Tiptap JSON)"
}

선택:
{
  "summary": "한줄 요약",
  "tags": ["데이터분석", "취업준비"],
  "relatedJobs": [{"slug": "데이터-분석가"}, {"slug": "데이터-사이언티스트"}],
  "relatedMajors": [{"slug": "통계학"}, {"slug": "컴퓨터공학"}],
  "relatedHowtos": [{"slug": "기존-하우투-slug"}]
}

응답:
{ "success": true, "slug": "생성된-slug", "pageId": 123, "status": "published" }
```

### relatedJobs/relatedMajors slug 확인
```bash
# 직업 slug 검색
curl "https://careerwiki.org/api/search?q=데이터+분석가&type=job"

# 전공 slug 검색
curl "https://careerwiki.org/api/search?q=통계학&type=major"
```

---

## 6. 콘텐츠 품질 기준

### 필수 요건
```
□ 제목: 구체적, 클릭하고 싶은 형태 (30자 이내)
  X "면접 준비"
  O "IT 기업 면접에서 자주 나오는 질문 10가지와 모범 답변"

□ 본문: 최소 1000자, 최대 3000자
□ 소제목 (h2): 최소 3개, 단계별 또는 주제별 구분
□ 커스텀 블록 사용: 최소 3종류 (checkpointBox, conclusionBox, qnaBlock, careerList, table 중)
□ 관련 직업: 최소 2개 (slug 존재 확인)
□ 관련 전공: 최소 1개 (slug 존재 확인)
□ 출처 (footnote): 최소 2개, 모두 유효한 URL
□ tags: 최소 2개
□ summary: 한줄 요약 (50자 이내)
```

### 콘텐츠 깊이 기준
```
초보자 기준: "이걸 읽고 나면 다음에 뭘 해야 하는지 알 수 있는가?"
전문가 기준: "팩트가 정확하고, 빠진 중요한 정보가 없는가?"

구체적으로:
- 추상적 조언 금지 → 구체적 액션 아이템 제시
  X "열심히 공부하세요"
  O "SQL 기본 문법을 2주 안에 마스터하세요 (추천: SQLBolt 무료 튜토리얼)"
- 통계/수치는 반드시 출처 명시
- "~라고 합니다" 식의 전해듣기 금지 → 직접 확인한 정보만
```

### Researcher Deep Research 기준
```
각 주제당 최소 확인할 출처:
1. 공식 통계 (커리어넷, 워크넷, 한국고용정보원)
2. 현직자 인터뷰/후기 (블로그, 유튜브, 커뮤니티)
3. 해당 분야 교육 기관 커리큘럼
4. 해외 사례 (참고용)

출처 검증:
- 모든 URL을 WebFetch로 접근 가능 여부 확인
- 404, 403, 리다이렉트 실패 → 대체 출처 필요
- 3년 이상 된 통계 → 최신 데이터 있는지 확인
```

---

## 7. 주제 선정 가이드 (우선순위 순)

### 1순위: 직업별 되는 방법 (사이트 핵심)
```
"[직업명] 되는 방법" — 가장 많이 검색되는 콘텐츠 유형
예시:
- 데이터 분석가 되는 방법: 비전공자도 가능한 로드맵
- UX 디자이너 되는 방법: 포트폴리오부터 취업까지
- 게임 개발자 되는 방법: 필요한 기술과 현실적 조언
```

### 2순위: 실전 취업 가이드
```
- IT 기업 면접에서 자주 나오는 질문과 모범 답변
- 신입 이력서, 이것만 지키면 서류 통과율 2배
- 포트폴리오 없는 문과생을 위한 경력 쌓기 전략
```

### 3순위: 트렌드/시장 분석
```
- 2026년 AI가 만드는 새로운 직업 5가지
- 사라지지 않을 직업의 공통점
- 비전공자가 IT로 전환하는 현실적 방법
```

---

## 8. 실행 흐름 (상세)

```
=== 준비 ===
1. Team Leader: 사용자에게 session_token 요청
2. Team Leader: 기존 HowTo 목록 확인 (careerwiki.org/howto)
   → 어떤 주제가 있고, 어떤 주제가 빠져있는지 파악

=== 1개 콘텐츠 작성 사이클 (5-10회 반복) ===

3. Team Leader: 주제 1개 선정 + Researcher에게 리서치 지시

4. Researcher → Task(run_in_background):
   - 해당 주제 Deep Research (WebSearch + WebFetch)
   - 공식 통계, 현직자 후기, 교육 커리큘럼 수집
   - 모든 출처 URL 유효성 검증
   - 결과 포맷: 주제, 핵심 포인트 5-7개, 출처 목록, Q&A 2-3개

5. Team Leader: Researcher 결과 검수
   - 출처 신뢰성 확인
   - 핵심 포인트 누락 여부

6. Content Creator → Task(run_in_background):
   - Researcher 결과를 기반으로 Tiptap JSON 콘텐츠 작성
   - 커스텀 블록 최소 3종류 사용
   - footnote로 출처 표시
   - careerList로 관련 직업/전공 연결
   - relatedJobs, relatedMajors slug 매핑

7. Team Leader: 콘텐츠 품질 검수 (섹션 6 기준 체크)
   - 수정 필요 시 Content Creator에게 피드백 → 재작성

8. Implementer → Task:
   - POST /api/howto/publish-direct 호출
   - careerwiki.org/howto/{slug} 접속하여 렌더링 확인
     - 커스텀 블록 정상 표시?
     - 출처 링크 동작?
     - 사이드바에 관련 직업/전공 표시?
   - 문제 발견 시 Team Leader에게 보고

9. 다음 주제로 이동 → 3번으로 복귀
```

---

## 9. Context Compact 복원

컨텍스트가 compact되면 반드시:
1. 이 파일 (`docs/sessions/wave1-d-content.md`) 다시 읽기
2. `docs/phase-progress/phase-6-state.md` 읽기
3. Team Leader의 가장 최근 메시지 확인

---

## 10. 완료 기준

- [ ] HowTo 가이드 5-10개 발행
- [ ] 각 가이드 1000자 이상
- [ ] 각 가이드에 커스텀 블록 최소 3종류 사용
- [ ] 각 가이드에 유효한 출처 최소 2개 (footnote)
- [ ] 각 가이드에 관련 직업 2개+ / 관련 전공 1개+ 연결
- [ ] 프로덕션에서 정상 렌더링 확인 (careerwiki.org/howto/{slug})
- [ ] 사이드바 관련 직업/전공/HowTo 표시 확인
- [ ] 완료 보고서 작성
