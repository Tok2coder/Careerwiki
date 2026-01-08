# INTEGRATIONS / API STATUS

## 외부 API 통합 현황
- CareerNet 직업정보(getOpenApi), 직업백과(jobs.json) | 상태: 호출 성공 로그 미수집 → UNKNOWN
- Goyong24 직업정보(callOpenApiSvcInfo212D01/02/03), 전공(majorGb) | 상태: UNKNOWN
증거: `API_ENDPOINTS_GUIDE.md`, `src/index.tsx`(fetch params)

## 환경별 상태
- dev/local: wrangler pages dev로 호출 가능하나 실제 응답 미검증 → UNKNOWN
- prod/preview: 호출 결과/에러 미수집 → UNKNOWN

## 요금제/쿼터
- CareerNet/고용24: 일 1,000회 (문서 기준) | 증거: `API_ENDPOINTS_GUIDE.md`

## 재현용 호출 예시 (키 마스킹)
- 직업(변호사):  
  `curl "https://www.career.go.kr/cnet/openapi/getOpenApi?svcCode=JOB_VIEW&contentType=json&jobdicSeq=375&apiKey=****"`
- 직업(고용24 요약):  
  `curl "https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo212D01?target=JOBCD&dtlGb=1&jobCd=K000007482&authKey=****"`
- 직업(고용24 직무):  
  `curl "https://www.work24.go.kr/cm/openApi/call/hr/callOpenApiSvcInfo212D02?target=JOBCD&dtlGb=2&jobCd=K000007482&authKey=****"`

## 정상/에러 응답 샘플
- 미수집 → UNKNOWN (테스트 후 로그 보관 필요)

## 변경 가능성 추적
- 정책/요금/스키마 변경 모니터링 체계 없음 → UNKNOWN (공식 공지/RSS 모니터 필요)

