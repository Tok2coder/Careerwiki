# 필드별 판단 매트릭스 (원칙 4 상세)

CareerWiki 직업에는 이미 커리어넷/고용24 API 데이터가 `merged_profile_json`에 있다. 필드마다 처리가 다르다.

---

## 항상 새로 작성 (API에 대응 데이터 없음 — 가장 중요!)

| 필드 | API 상태 | 행동 | 우선순위 |
|------|---------|------|---------|
| **`way`** (되는 방법) | API에는 학력분포 숫자만 있음 | **반드시 서술형 가이드 작성** (자격요건, 시험, 진입경로) | ★★★ |
| **`detailReady`** | API에 간략한 리스트만 | **curriculum/recruit/training 구체화** | ★★★ |
| **`trivia`** | API에 없음 | **흥미로운 사실 1개** | ★★ |
| **`detailWlb.wlbDetail`** | API에 등급만 | **상세 서술 작성** (130~200자, 근무강도/야근/교대) | ★★ |
| **`detailWlb.socialDetail`** | API에 등급만 | **상세 서술 작성** (100~160자, 사회적 영향/공익) | ★★ |
| **커리어트리** | API에 없음 | **wrangler d1 execute로 DB INSERT** | ★★ |

---

## 보강 가능 (API 데이터 있지만 부족할 수 있음)

| 필드 | API 상태 | 행동 |
|------|---------|------|
| `sidebarCerts` | 1~2개만 | 실제 유용한 자격증 추가. DB 검증 필수 |
| `sidebarMajors` | 일부만 | 관련 학과 추가. DB 검증 필수 |
| `overviewSalary.sal` | 수치만 | 이미 user_contributed_json에 서술이 있으면 유지. 없으면 맥락 서술 추가 |
| `overviewProspect.main` | 전망 텍스트 있음 | 이미 user_contributed_json에 서술이 있으면 유지. 없으면 최신 트렌드 추가 |

---

## API에 있으면 스킵, 없으면 공식 출처가 있을 때만 채움

아래 필드들은 보통 API에서 제공되지만, **마이너 직업은 API 데이터가 없을 수 있다.**

| 필드 | API 있을 때 | API 없을 때 (null) |
|------|-----------|-------------------|
| `overviewWork.main` | 스킵 | 수행 직무 서술형 작성 (출처 필수) |
| `overviewAbilities.technKnow` | 스킵 | 서술형 텍스트 작성 가능 (출처+각주 필수) |
| `detailWlb.wlb` / `detailWlb.social` | 스킵 | **등급 + Detail 모두 작성 필수** (출처 필수) — 페이지 상단 요약 카드에 크게 표시되므로 누락 시 공란 렌더링 |

---

## 공식 통계만 허용 — 추정값/AI 생성 수치 절대 금지

| 필드 | 허용 출처 | 출처 없으면 |
|------|----------|-----------|
| `overviewAbilities.abilityList` (점수) | 커리어넷 KNOW 데이터만 | **null 유지** |
| `overviewAptitude` (적성/흥미/만족도) | 커리어넷 재직자 조사만 | **null 유지** |
| `detailEducation` (학력/전공 분포 %) | 고용24 재직자 조사만 | **null 유지** |
| `detailIndicators` (직업지표 7항목) | 고용24 재직자 조사만 | **null 유지** |
| `customCharts` (커스텀 차트) | 공식 통계만 | **null 유지** |

이 필드들은 수치/퍼센트이므로 출처 없이 지어내면 거짓 정보가 됨. **빈 칸이 거짓 정보보다 100배 낫다.**

---

## 구조화 데이터 타입 참조

| 필드 | JSON 경로 | 데이터 타입 |
|------|----------|------------|
| 적성 목록 | `overviewAptitude.aptitudeList` | `[{name:string}]` |
| 흥미 목록 | `overviewAptitude.interestList` | `[{name:string}]` |
| 직업 만족도 | `overviewAptitude.satisfaction.value` | `number (0~100)` |
| 핵심 역량 | `overviewAbilities.abilityList` | `[{name:string, score?:number}]` |
| 활용 기술 | `overviewAbilities.technKnow` | `string` |
| 학력 분포 | `detailEducation.educationDistribution` | `{highSchool:string, college:string, ...}` |
| 전공 분포 | `detailEducation.majorDistribution` | `{natural:string, education:string, ...}` |
| 워라밸 등급 | `detailWlb.wlb` | `string` (보통미만/보통이상/좋음/매우좋음) |
| 워라밸 상세 | `detailWlb.wlbDetail` | `string` 130~200자, 인라인 각주 지원 |
| 사회기여 등급 | `detailWlb.social` | `string` |
| 사회기여 상세 | `detailWlb.socialDetail` | `string` 100~160자, 인라인 각주 지원 |
| 정규 교육과정 | `detailReady.curriculum` | `string[]` |
| 채용 정보 | `detailReady.recruit` | `string[]` |
| 필요 훈련 | `detailReady.training` | `string[]` |
| 진로 탐색 | `detailReady.researchList` | `[{title:string}]` |
| 관련 영상 | `youtubeLinks` | `[{url:string, title?:string}]` |
| 직업지표 | `detailIndicators` | `{chartType:"horizontalBar", items:[{label:string, value:number}], unit:"점"}` |
| 커스텀 차트 | `customCharts` | `[{title:string, chartType:string, items:[{label:string, value:number}], unit:string}]` |

---

## 각주 렌더링 지원 필드 (formatRichText 적용)

아래 필드들은 인라인 `[N]` 각주가 자동으로 클릭 가능한 superscript + 툴팁으로 변환된다:
- `way`, `overviewProspect.main`, `overviewSalary.sal`, `trivia`, `summary`
- `detailWlb.wlbDetail`, `detailWlb.socialDetail` (2026-03-17 적용)
- `overviewAbilities.technKnow` (2026-03-15 적용)

`curriculum`, `recruit`, `training`은 배열이므로 각주 없이 항목만 나열한다.

---

## 사이드바 필드 선정 기준

### sidebarCerts 선정 기준
- ✅ **필수 자격증**: 이 직업을 하려면 반드시 필요 (예: 변호사→"변호사 자격증")
- ✅ **추천 자격증**: 있으면 경쟁력 상승하는 관련 자격
- ❌ **시험 자체**: LEET, 사법시험, TOEIC 등 자격증이 아닌 시험
- ❌ **명칭**: "~시험" 아닌 "~자격증", "~면허", "~자격" 형태로

### sidebarJobs / sidebarMajors 선정 기준
- **핵심만** — 7~12개 이내, 실제 관련 있는 것만
- **DB 존재 필수** — `is_active=1`인 것만. 없는 직업/전공은 절대 넣지 않음
- **기존 데이터 검증**: 15개+ → 7~12개로 정리, 관련성 낮은 것 제거, 핵심 누락 추가

### heroTags 기준
- 해당 직업의 **별칭/다른 이름**, **세부 분류**, **영문명** 등
- 기존 태그가 부실하거나 모호하면 개선
