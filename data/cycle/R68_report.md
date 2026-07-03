# R68 보고 (2026-07-03) — 25/25 PASS · KPI 2082→2107 (+25 정확)

## 결과
- 직업: 방사성폐기물처리시설안전관리원 ~ 방송연출보조원 (방사성폐기물 처분·방송 기술 계열, master_list R68)
- KPI 2107 (독립 이중 실측 — dispatcher + opus 검증), max master rev **20220**, 집합검증 25/25 latest=마커
- verify-cycle 25/25 PASS · audit FAIL 0/25 · totalE 전건 ≥25(min 25) · distinct 11~22 · 복붙 Jaccard 최대 0.16 · sal 미접촉 · prod 표본 200

## 사고와 수습
1. **계정 session limit 다단 중단**: B1~B3 세션 중단(보고 유실) → DB landing 실측 21/25 → `--resume=68` 재개 세션(4직업, dup 가드) → 중복 POST 0, 25/25 복구.
2. **정책위반 URL 4직업 (opus 검증 적발·수정)**: nsis eduG 로그인게이트(3직업)→KOFONS 공개 안내(200), indeed 검색URL(방송안내원)→KPC 자격 deep. rev 20213~20220, 마커 유지·KPI 무영향. R67에 이어 재발 — validate 사전 게이트 격상 후보.
3. **edge 캐시 mojibake 허상**: 검증 수정 중 edit-data 재조회가 stale 응답 반환 → mojibake 오인 재검 루프. **D1 직접 조회로 판정 결과 저장 데이터는 전건 클린**. 교훈: 재전송 판정은 D1 직접 조회로.
4. 의심 규명: "이전 세션 rev" 라벨 착오 2건(데이터 정상), fix 재POST 3직업(dup 아님·changeSummary 상이), 잉여 재POST 0.

## 효율 체크포인트 (실측)
| 세션 | subagent_tokens | tool_uses | duration |
|---|---|---|---|
| B4 (sonnet, 5직업) | 155,926 | 237 | 50min |
| B5 (sonnet, 5직업) | 157,089 | 239 | 40min |
| B1~B3 (sonnet) | 유실 (리밋 중단 — 17직업 완료분 landing만 확인) | — | — |
| 재개 (sonnet, 4직업) | 86,654 | **504 ⚠️** | 71min |
| 검증 (opus, 수정 5rev 포함) | 112,896 | 88 | 24min |
| **직업당 (관측 가능분)** | **~31K/직업 (배치)** | — | — |

## 확인
- admin: /admin/job-equalize (KV 캐시 — ?fresh=1로 최신) · 표본: careerwiki.org/job/방송리포터 · /job/방사성폐기물처분관리원 · /job/방송안내원
