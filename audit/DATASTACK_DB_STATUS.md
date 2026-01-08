# DATASTACK / DB STATUS

## 데이터 소스 카탈로그
- CareerNet 직업정보 getOpenApi: svcCode=JOB_VIEW, jobdicSeq, JSON 우선/XML 폴백  
- CareerNet 직업백과 jobs.json: id 파라미터  
- Goyong24 직업정보: `callOpenApiSvcInfo212D01/02/03` (dtlGb=1/2/3, jobCd)  
- Goyong24 전공: majorGb, departmentId, majorId  
- 레이트리밋: CareerNet/고용24 일 1,000회 (문서 기준)  
증거: `API_ENDPOINTS_GUIDE.md`, `src/index.tsx` (fetch params)

## 스키마/ERD (요약)
- 핵심 테이블: jobs, majors, wiki_pages, update_logs, comments, ai_sessions, serp_interaction_logs 등  
- 인덱스: idx_jobs_name, idx_wiki_pages_lookup, idx_wiki_pages_type 등  
- 제약: wiki_pages UNIQUE(slug,page_type); jobs/majors PK=id  
증거: `docs/D1_DATABASE_STRUCTURE.md`

## 병합 로직
- 이름 매핑 테이블 적용 (name_mappings), 소스 우선순위 CAREERNET > WORK24_JOB > WORK24_DJOB  
- 필드별 병합 규칙 상세: duties/prospect/salary 등 우선순위, 중복 제거  
증거: `docs/ETL_CURRENT_STATE.md`, `docs/JOB_DATA_MERGE_LOGIC.md`, `docs/ETL_FIELD_MAPPING.md`

## 적재 주기/버전/롤백
- 2주 주기 크론 설계 언급, wrangler crons 주석 처리 상태 → 실제 스케줄 미배포(UNKNOWN)  
- 캐시 무효화: 템플릿 버전 증가 또는 wiki_pages 삭제  
- 롤백 전략: D1 백업/스냅샷 미확인 → UNKNOWN

## 품질 현황
- 원본/병합 건수: 직업 원본 ~21k → 병합 ~6,945; 전공 원본 ~619 → 병합 ~595; 이름 매핑 job 166 / major 24  
  증거: `docs/ETL_CURRENT_STATE.md`
- 최신 결측/중복률, import 로그 샘플: 없음 → UNKNOWN (로그 수집 필요)

## 최근 import 로그 (샘플 20줄)
- 수집된 로그 없음 → UNKNOWN (ETL 실행 및 로그 보관 필요)

## 환경 변수 샘플 (마스킹)
```
CAREER_NET_API_KEY=****xxxx
GOYONG24_JOB_API_KEY=****xxxx
GOYONG24_MAJOR_API_KEY=****xxxx
DB_URL=****/careerwiki
```

## DB 접속/풀/마이그레이션
- 드라이버: Cloudflare D1 (sqlite), 풀 설정 없음 (Workers 특성)  
- 마이그레이션 파일 존재(migrations/*.sql), 적용 상태 미확인 → UNKNOWN

