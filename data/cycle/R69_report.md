# R69 보고 (2026-07-04) — 25/25 PASS · KPI 2107→2132 (+25 정확) · 효율화 패키지 1~5 첫 적용

## 결과
- 직업: 방송영상감독 ~ 배수장관리원 (방송 제작·방수·배소·물류 계열)
- KPI **2132** (이중 실측), max master rev **20276**, landing 집합검증 25/25, 리밋 사망 **0** (5배치 전원 완주)
- 게이트(이원화 — dispatcher 직접 실행): audit 25/25 FAIL 0 · verify-cycle 22 PASS + urlDead 3직업 → opus 수정(rev 20274~20276, fix 각 1회) 후 **25/25** · 복붙 Jaccard 최대 15% · 정책위반 URL 검증단 적발 **0** (R67 5·R68 4 → [policyUrl] 사전 게이트 효과)

## 사고와 수습
- urlDead 5건(오타 1·rot 3·리스트성 1) — opus 판별 3분류 후 교체, D1 직접 조회로 재전송 확인(신규 룰 준수). hankyung 403·kitech은 anti-bot/TLS 거짓양성 판별 유지.
- 의심 규명: "이전 세션 완료" 라벨 4건 = 전건 당일 rev(보고 아티팩트, dup 0) / fix POST 1회 룰 위반 0 / 배소기조작원 "수산물 배소"는 Work24 원본 충실(제련 아님 — 정상) / B5가 activity 파일 1개 자작 커밋(무해).

## 효율 재측정 (R68 → R69, 패키지 적용 전후)
| 항목 | R68 | R69 | Δ |
|---|---|---|---|
| 배치 토큰/직업 | ~31.3K | **26.6K** (총 665K/25) | **-15%** |
| 검증 opus | 113K | **104K** (게이트 실행은 dispatcher Bash=무토큰) | -8% |
| 수습·재개 세션 | 87K (+B1~B3 유실 ~470K 추정) | **0** (사망 0) | — |
| cycle subagent 총합 | ~983K (유실 추정 포함) | **769K** | **~-22%** (유실 추정 감안 보수적 -10~20%) |
| 정책위반 URL 검증단 적발 | 4직업 8rev | **0** | 사전 차단 |
| tool_uses outlier | 재개 504 | B2 637·B4 706 ⚠️ (rev 다중 POST 아님 — 탐색·재시도 루프) | 잔존 과제 |

## 잔존 개선 후보 (다음 제안)
1. B2/B4 tool_uses outlier — WebFetch 실패 재시도 상한·tool-call budget의 결정적 강제(현재 목표치만 존재).
2. [policyUrl]에 saramin/jobkorea `company-info` 뷰 패턴 추가 (이번에 리스트성으로 통과).
3. dead URL 자체(환각·rot)는 policyUrl과 별개 — 배치 단계 URL liveness 셀프체크는 이미 룰, 상습 rot 도메인(cjlogistics deep 등) 블랙리스트 후보.

## 확인
admin: /admin/job-equalize (?fresh=1) · 표본: careerwiki.org/job/방송주조감독 · /job/방수반장 · /job/배송센터관리자
