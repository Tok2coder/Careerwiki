# CareerWiki ETL Scripts

## 📁 디렉토리 구조

```
src/scripts/etl/
├── seedCareerNetJobs.ts        - 커리어넷 직업백과 시딩
├── seedWork24Jobs.ts           - 고용24 직업정보 시딩
├── seedWork24JobDictionary.ts  - 고용24 직업사전 시딩 (6,581개)
├── mergeJobProfiles.ts         - 3개 소스 병합
├── seedCareerNetMajors.ts      - 커리어넷 전공 시딩
├── seedWork24Majors.ts         - 고용24 학과정보 시딩
└── mergeMajorProfiles.ts       - 2개 소스 병합
```

## 🚀 실행 순서

1. `loadJobDictionaryIndex.ts` (루트)
2. `seedCareerNetJobs.ts`
3. `seedWork24Jobs.ts`
4. `seedWork24JobDictionary.ts`
5. `mergeJobProfiles.ts`
6. `seedCareerNetMajors.ts` (선택)
7. `seedWork24Majors.ts` (선택)
8. `mergeMajorProfiles.ts` (선택)

## 📖 사용법

모든 스크립트는 Workers 또는 Node 환경에서 실행 가능합니다.

### Workers (Cloudflare)
```bash
wrangler deploy src/scripts/etl/seedCareerNetJobs.ts
# 또는
curl https://your-worker.workers.dev/seed-careernet-jobs
```

### Node (로컬)
```bash
tsx src/scripts/etl/seedCareerNetJobs.ts
```

## 🔧 옵션

모든 스크립트는 다음 옵션을 지원합니다:
- `--limit=N`: 처리할 개수 제한 (테스트용)
- `--skip=true`: 이미 존재하는 데이터 스킵

**예시:**
```bash
tsx src/scripts/etl/seedCareerNetJobs.ts --limit=100 --skip=true
```

## 📊 모니터링

시딩 진행 상황은 `seed_logs` 테이블에서 확인:
```sql
SELECT * FROM seed_logs ORDER BY started_at DESC LIMIT 10;
```

실패 항목은 `seed_errors` 테이블에서 확인:
```sql
SELECT * FROM seed_errors WHERE resolved_at IS NULL;
```

## ⚠️ 주의사항

- Rate limiting: 최소 300ms 간격
- 재시도: 3회까지 자동
- 로그: 모든 작업은 seed_logs에 기록됨

