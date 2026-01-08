# RESULT SHAPE (목록 API 축소)

대상: `/api/jobs`, `/api/majors` (목록)

## 필수 반환 필드
- `profile.id`, `profile.name`, `profile.slug` (있을 경우)
- `profile.sourceIds` (careernet/goyong24 최소 식별자; 없으면 null/undefined)
- `profile.sources` (기본 `['CAREERNET']`)
- `display.summary` (첫 문장/요약)
- `meta.total` (FTS 경로는 page 범위 내 개수로 반환)

## 제외/지연 로드
- 연봉/만족도/워라벨/heroTags 등 상세 필드는 `?include=details` 같은 확장 플래그로 후속 로드 권장.
- 대용량 merged_profile_json 파싱 제거 → 직렬화/전송 크기 축소.

## 정렬/랭킹
- FTS5 MATCH + `bm25(jobs_search_fts)` ASC
- keyword < 2글자 시 기존 LIKE 폴백 유지.

