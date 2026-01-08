# 직업/전공 편집 시스템 전면 개편

## 0. 기존 시스템 분석 결과 (Phase 0 완료)

### 참고할 기존 백엔드 코드 (유지/수정)

| 파일 | 역할 | 상태 |

|------|------|------|

| `src/services/editService.ts` | 편집/생성 로직 | 수정 필요 (필드 구조 변경) |

| `src/services/revisionService.ts` | 버전 히스토리 | 유지 (잘 구현됨) |

| `src/utils/editValidation.ts` | 입력 검증 | 수정 필요 (필드 목록 갱신) |

| `src/utils/anonymousEdit.ts` | 익명 편집 제한 | 유지 |

### 기존 데이터 저장 구조

- `user_contributed_json`: 사용자 기여 데이터 (우선순위 2)
- `admin_data_json`: 관리자 데이터 (우선순위 1)
- `api_data_json`: API 원본 데이터 (우선순위 3)
- 병합 순서: api → user → admin (나중 것이 우선)

### 기존 revision 시스템 (유지)

- `page_revisions` 테이블
- `entity_type`, `entity_id`, `revision_number`
- `data_snapshot`: 전체 스냅샷 또는 변경사항만 저장
- `editor_type`: 'anonymous' | 'user' | 'expert' | 'admin' | 'system'

### 기존 익명 편집 제한 (유지)

- `anonymous_edit_limits` 테이블
- IP별, entity별, 일일 10회 제한
- 로그인 유저는 무제한

### 재구현 필요한 프론트엔드

- `public/static/api-client.js`의 EditSystem → 새로 구현 (`edit-mode.js`)
- 편집 모드 UI 전면 재설계

---

## 1. 편집 가능 필드 정의

### 직업 상세페이지 (Job)

**히어로 섹션** (name 제외 - 읽기 전용):

- `summary` - 직업 설명 (텍스트, 최소 2자 / 최대 7000자)
- `heroTags` - 태그 (쉼표 구분 입력, 중복 제거)
- `heroCategory` - 직업 분류 (텍스트)

**개요 탭** (그룹화된 섹션):

- 주요 업무: `overviewWork.main`, `workStrong`, `workPlace`, `physicalAct`
- 커리어 전망: `overviewProspect.main`
- 핵심 능력·자격: `overviewAbilities` (abilityList, technKnow, eduLevel, skillYear)
- 적성 및 흥미: `overviewAptitude` (aptitudeList, interestList)
- 임금: `overviewSalary` (sal, wage)

**상세정보 탭**:

- 워라밸 & 사회적 평가: `detailWlb` (wlb, social)
- 직업 준비하기: `detailReady` (recruit, certificate, training, curriculum)

**제외 (읽기 전용)**: 업무특성 탭 전체

### 전공 상세페이지 (Major)

**히어로 섹션** (name 제외 - 읽기 전용):

- `summary` - 전공 설명
- `heroTags` - 관련 학과 태그
- `categoryName` - 계열

**개요 탭**:

- 전공 개요: `summary`
- 적성: `aptitude`
- 관련 학과: `relatedMajors`
- 관련 교과목: `mainSubjects`

**상세정보 탭**:

- 배우는 내용: `whatStudy`
- 진출 분야: `enterField`
- 주요 교과목 상세: `mainSubject`
- 고교 추천 교과목: `relateSubject`
- 진로 전망: `jobProspect`
- 진로 탐색 활동: `careerAct`

**제외 (읽기 전용)**: 대학정보 탭 전체

---

## 2. 구현 계획

### Phase 0: 사전 작업 ✅ 완료

- [x] 기존 편집 시스템 분석 및 정리
- [x] 현재 구현된 코드 검토

### Phase 1: 기반 작업 ✅ 완료

- [x] `src/types/editFields.ts` - 편집 가능 필드 타입 정의
- [x] `src/utils/editFieldConfig.ts` - 필드별 메타데이터 (라벨, 입력 타입, 검증 규칙)
- 검증 규칙: 최소 2자, 최대 7000자

### Phase 2: 새 문서 추가 기능 ✅ 완료

- [x] `/job` 페이지에 "새 직업 추가" 버튼
- [x] `/major` 페이지에 "새 전공 추가" 버튼
- [x] 생성 폼: 필수 필드(name, summary)만 입력, "등록" 버튼으로 즉시 생성

### Phase 3: 전체 편집 모드 UI ✅ 완료

- [x] `public/static/edit-mode.js` - 편집 모드 전용 스크립트
- [x] `public/static/edit-mode.css` - 편집 모드 스타일
- [x] URL `?edit=true` 시 편집 가능 필드를 인라인 편집 UI로 전환
- [x] 편집 불가 필드는 읽기 전용 표시 (회색 처리)
- 필드 타입별 입력 컴포넌트:
  - 텍스트: textarea
  - 배열: 쉼표 구분 입력 (중복 자동 제거)
  - 중첩 객체: 섹션명으로 그룹화

### Phase 4: 출처(각주) 시스템 ⏳ 기본 구현 완료

- [x] 필드 편집 시 출처 URL 입력 가능 (선택사항)
- [x] `_sources` 객체로 출처 데이터 저장
- [ ] HowTo 스타일 네비게이션 (추후 개선)
  - 주석 번호 클릭 → 데이터 출처 섹션 이동
  - 출처 클릭 → 해당 주석 위치로 이동
  - 탭 간 연동

### Phase 5: API 엔드포인트 정비 ✅ 완료

- [x] `POST /api/job/create` - 새 직업 생성 (로그인 필수)
- [x] `POST /api/major/create` - 새 전공 생성 (로그인 필수)
- [x] 기존 edit API 수정: 다중 필드 편집 + 출처 데이터 저장 구조 추가

### Phase 6: 권한 및 제한 ✅ 완료 (기존 시스템 활용)

- [x] 비로그인 유저: IP 기반 1일 10회 편집 제한 (기존 `anonymousEdit.ts`)
- [x] 로그인 유저: 무제한
- [x] 생성: 로그인 유저만 가능 (`requireAuth` 미들웨어)
- [x] 문서 역사: 기존 revision 시스템 활용
- [ ] 삭제: 관리자만 (추후 삭제 API 추가 시)

### Phase 7: 테스트 (사용자 담당)

- [ ] 전체 기능 테스트
- [ ] 버그 수정 요청

---

## 3. 주요 파일 변경

| 파일 | 변경 내용 |

|------|----------|

| `src/index.tsx` | /job /major 버튼, 생성 API |

| `src/types/editFields.ts` | 신규 - 필드 타입 정의 |

| `src/utils/editFieldConfig.ts` | 신규 - 필드 메타데이터 |

| `public/static/edit-mode.js` | 신규 - 편집 모드 UI |

| `public/static/edit-mode.css` | 신규 - 편집 모드 스타일 |

| `src/templates/unifiedJobDetail.ts` | 편집 모드 data 속성 |

| `src/templates/unifiedMajorDetail.ts` | 편집 모드 data 속성 |

---

## 4. 데이터 저장 구조

`user_contributed_json`에 효율적으로 저장 (기존 데이터와 충돌 방지):

```json
{
  "summary": "새로운 설명",
  "heroTags": ["태그1", "태그2"],
  "overviewWork": {
    "main": "업무 설명"
  },
  "_sources": {
    "summary": { "id": 1, "text": "출처 설명", "url": "https://..." },
    "overviewWork.main": { "id": 2, "text": "출처 설명", "url": "https://..." }
  }
}
```

---

## 5. 역할 분담

### 사용자 담당

- Phase 0: 기존 편집 시스템 분석 및 정리
- Phase 7: 전체 테스트 진행

### AI 담당

- Phase 1~6: 구현 작업