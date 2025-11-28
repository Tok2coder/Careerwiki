# CareerWiki 빠른 참조 가이드

**프로젝트 구조와 핵심 개념을 한눈에!**

---

## 📁 핵심 파일 구조

```
Careerwiki/
├── src/
│   ├── index.tsx                    # 메인 앱 (Hono)
│   ├── services/
│   │   ├── profileMerge.ts          # ETL 병합 유틸리티 ⭐
│   │   ├── profileDataService.ts    # 렌더링 데이터 로더 ⭐
│   │   └── jobDataMerger.ts         # 편집 UI용 (ETL과 별개)
│   ├── templates/
│   │   ├── unifiedJobDetail.ts      # 직업 상세 템플릿
│   │   └── unifiedMajorDetail.ts    # 전공 상세 템플릿
│   ├── scripts/
│   │   ├── etl/
│   │   │   ├── mergeJobProfiles.ts  # 직업 병합 ETL ⭐
│   │   │   └── mergeMajorProfiles.ts # 전공 병합 ETL ⭐
│   │   ├── runJobMerge.ts           # 직업 병합 실행기
│   │   └── runMajorMerge.ts         # 전공 병합 실행기
│   └── constants/
│       └── template-versions.ts     # ISR 캐시 버전
├── migrations/
│   └── 0018_complete_etl_system.sql # 최신 스키마
└── docs/                            # 상세 문서들
```

---

## 🔄 데이터 흐름

### 오프라인 병합 방식 (현재)

```
1. Raw 데이터 (API)
   ↓
2. job_sources / major_sources (DB 저장)
   ↓
3. ETL 스크립트 실행 (mergeJobProfiles.ts)
   ↓
4. jobs.merged_profile_json (병합된 데이터)
   ↓
5. profileDataService.ts (렌더링 시 조회)
   ↓
6. 템플릿 렌더링 (unifiedJobDetail.ts)
```

**핵심**: 유저 요청 시 병합 안 함! ETL로 미리 병합된 데이터만 사용.

---

## ⚡ 자주 쓰는 명령어

### 개발

```bash
# 로컬 서버 시작
npm run dev

# 빌드
npm run build

# PM2로 실행
pm2 start ecosystem.config.cjs
```

### ETL 병합

```bash
# 직업 전체 병합
npm run etl:merge-jobs

# 직업 100개만 (테스트)
npm run etl:merge-jobs:limit

# 전공 전체 병합
npm run etl:merge-majors

# 직업 + 전공 모두
npm run etl:merge-all
```

### 배포

```bash
# 프로덕션 배포
npm run deploy:prod
```

---

## 🗂️ 데이터베이스 핵심 테이블

| 테이블 | 용도 | 비고 |
|--------|------|------|
| `jobs` | 병합된 직업 데이터 | `merged_profile_json` 사용 ⭐ |
| `majors` | 병합된 전공 데이터 | `merged_profile_json` 사용 ⭐ |
| `job_sources` | Raw 직업 원본 | ETL 전용 (렌더링 X) |
| `major_sources` | Raw 전공 원본 | ETL 전용 (렌더링 X) |
| `users` | 사용자 계정 | Google OAuth |
| `comments` | 댓글 | 직업/전공/가이드 페이지 |
| `page_revisions` | 편집 이력 | Revision 시스템 |

---

## 🎯 병합 규칙

### 소스 우선순위

**직업**:
```
CAREERNET > WORK24_JOB > WORK24_DJOB
```

**전공**:
```
CAREERNET > WORK24_MAJOR
```

### 필드별 전략

- **단일 값** (name, summary): 우선순위 높은 소스 선택
- **배열** (skills, tasks): 중복 제거 후 병합
- **객체** (salary, satisfaction): 우선순위 높은 소스 선택

### 그룹화 기준

- **이름 완전 일치** (`normalized_payload.name`)
- 유사어, fuzzy matching 사용 안 함

---

## 🚨 중요한 개념들

### 1️⃣ ISR 캐시

- **파일**: `src/constants/template-versions.ts`
- **원리**: 템플릿 변경 시 버전 증가 → 캐시 무효화
- **주의**: 템플릿 수정 후 **반드시 버전 증가!**

```typescript
export const TEMPLATE_VERSIONS = {
  MAJOR: 48,  // 전공 템플릿 버전
  JOB: 47,    // 직업 템플릿 버전
  HOWTO: 1    // 가이드 템플릿 버전
}
```

### 2️⃣ 병합 위치

| 시나리오 | 사용 파일 | 비고 |
|----------|-----------|------|
| ETL 병합 | `profileMerge.ts` | 오프라인, DB 저장 |
| 편집 UI | `jobDataMerger.ts` | 실시간, API 응답 변환 |
| 렌더링 | `profileDataService.ts` | `merged_profile_json` 조회 |

### 3️⃣ Fallback 로직

```typescript
// profileDataService.ts
if (merged_profile_json) {
  return JSON.parse(merged_profile_json)  // ETL 병합 데이터
} else {
  return mergeFromApiData(api_data_json)  // 하위 호환 (옛날 방식)
}
```

---

## 📚 문서 가이드

### 시작하기
1. **처음 시작**: `CURSOR_QUICKSTART.md`
2. **프로젝트 현황**: `PROJECT_STATUS.md`
3. **ETL 병합**: `ETL_GUIDE.md`

### 개발
1. **API 통합**: `docs/API_INTEGRATION.md`
2. **아키텍처**: `docs/ARCHITECTURE.md`
3. **데이터베이스**: `docs/D1_DATABASE_STRUCTURE.md`

### 운영
1. **트러블슈팅**: `TROUBLESHOOTING.md`
2. **작업 요청**: `HOW_TO_REQUEST_WORK.md`
3. **기술 스펙**: `TECH_SPEC.md`

---

## 🔗 주요 URL

### 로컬 개발
- 홈: http://localhost:3000
- 직업: http://localhost:3000/job/lawyer
- 전공: http://localhost:3000/major/computer-science

### 디버그
- 캐시 새로고침: `?cache=refresh`
- 디버그 모드: `?debug=true`

---

## 💡 헷갈리기 쉬운 것들

### Q: `jobDataMerger.ts`는 뭐야? ETL이랑 다른 거야?

**A**: 네, 다릅니다!
- **ETL** (`profileMerge.ts`): 오프라인 병합, DB 저장
- **편집 UI** (`jobDataMerger.ts`): API 응답을 편집 가능한 구조로 변환

### Q: 왜 `job_sources` 테이블을 프론트에서 조회 안 해?

**A**: `job_sources`는 ETL 전용 원본 저장소입니다. 렌더링은 병합된 `jobs.merged_profile_json`만 사용합니다.

### Q: ETL 병합 후 페이지에 반영이 안 돼요!

**A**: ISR 캐시 때문입니다.
1. 템플릿 버전 증가 (`template-versions.ts`)
2. 또는 `?cache=refresh` URL 파라미터 사용

### Q: `api_data_json`은 왜 남겨뒀어?

**A**: Fallback입니다. ETL 안 돌린 오래된 데이터에 대한 하위 호환용입니다.

---

**최종 업데이트**: 2025-11-21

이 문서가 헷갈릴 때 참고하세요! 🚀


