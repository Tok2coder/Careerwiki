# FTS5 PLAN (DEV ONLY)

목표: LIKE 기반 검색 병목(>6s)을 FTS5 기반으로 전환할 준비. prod 미적용.

## 설계
- 테이블: `jobs_search_fts(name, slug, content='jobs', content_rowid='id', tokenize='unicode61')`
- 트리거: insert/update/delete → FTS 동기화 (migrations/dev_fts5.sql)
- 초기 동기화: is_active=1 rows만 upsert (비파괴)
- 한글: unicode61 토크나이저로 초성/자모 대응, NFC 입력

## 전환 조건
- 로컬 질의 성능 확인 후 prod 계획 수립
- LIKE 폴백 유지(FTS 검색 실패 시 기존 경로)
- 정렬: rank 제한 + 필요 시 별도 weight 설정

## 예상 효과 / 리스크
- 장점: prefix/full-text 매치, 검색 속도 개선, 한글 토큰화 개선
- 리스크: FTS 테이블 크기 증가, 트리거 부하. prod 적용 시 백업/롤백 필수.

## 차기 단계
- FTS 질의 경로 추가 (MATCH) + LIMIT/OFFSET 검증
- 정렬 기준 정의(rank > updated_at 등)
- 데이터 버전 키(ETag seed)와 연동해 304 유지

