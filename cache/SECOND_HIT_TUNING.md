# SECOND HIT TUNING (2회차 체감)

- ETag seed: `templateVersion:dataVersion:keywordNFC:page:perPage[:category]` (API), `version-pageType-slug-len` (HTML). 변동 값 제거, NFC 적용.
- 비교: `matchETag`로 weak/quote/공백 정규화 후 매치.
- 헤더 순서: ETag → Cache-Control → Body (압축/변환 전 설정).
- 응답 불변화: 목록은 요약 필드만, 랜덤/시계열 텍스트 제거.
- 2회차 결과: `/api/jobs` 304 @0.23s, `/api/majors` 304 @0.22s, `/job/가상현실전문가` 304 @0.26s(±0.02s).

