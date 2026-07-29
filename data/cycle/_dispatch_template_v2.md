# 🚨 master skill spawn STRICT prompt template (v2, 2026-05-25)

dispatcher가 sub-session spawn 시 이 헤더를 prompt 맨 앞에 그대로 prepend.

```
# 🚨 STRICT — 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 batch 직업 명단 외 직업 SELECT/POST/audit 절대 X.**
   - NULL 풀에서 가나다순 다음 직업 자동 SELECT 절대 X.
   - 명단 5 직업 처리 끝나면 즉시 종료. 새 cycle / Phase 재진입으로 자동 다른 직업 X.

2. **PowerShell 절대 X. Bash 만 사용.**
   - Windows 환경도 Bash (Git Bash, WSL). PowerShell / pwsh / Invoke-RestMethod 호출 X.
   - PreToolUse hook `.claude/hooks/powershell-block.cjs` 가 차단함 — exit 2.

3. **자작 스크립트 X.**
   - `_cycle*.cjs` `_generic*.cjs` `_bulk*.cjs` `_pool*.cjs` `_mass*.cjs` `_force-enhance*.cjs` 등 차단됨.
   - PreToolUse hook `.claude/hooks/cycle-script-block.cjs` 가 차단함 — exit 2.
   - 모든 작업 = `.claude/skills/job-data-master/SKILL.md` Phase 0~7 흐름만.

4. **WebFetch 우회 X.**
   - URL 등록 전 WebFetch 검증 의무. fabricated URL 등록 절대 X.
   - distinct URL ≥ 18 (룰 Z).

5. **subagent 병렬 X.**
   - 본 sub-session 내부 직렬 처리. fan-out 사고 (75 fan-out / 172M token) 재발 방지.

6. **sal/wage 미접촉.**
   - `fields.overviewSalary` / `sources["overviewSalary.sal"]` 절대 손대지 X.

7. **AskUser X.**
   - 막힘 시 텍스트로 상태 보고 후 abort. user 응답 대기 형태 prompt X.

8. **5 직업 처리 후 종료 형식**: 각 직업별 `slug | rev_id | distinct_url | industry_class (niche/minor/major) | audit_status` 1줄 + 마지막 `BATCH DONE: 5/5 ok, 0 fail` 또는 `BATCH FAIL: N/5 ok, K fail` 형식.

9. **🚨 산업 분류 + distinct URL 강제** (SKILL.md 룰 30):
   - 각 직업별 industry_class 명시: `niche` (단일 공정·공장 직업) / `minor` (소규모 산업) / `major` (금융·IT·법조·항공·항만·반도체·자동차·통신·에너지·의료·교육 등 광범위)
   - **major 산업 = distinct ≥ 18 발굴 의무. lazy 절충 X.**
   - niche 절충 (distinct <18 허용) 은 단일 회사·공정 + URL pool 8~10개 모두 시도 후만 가능

10. **1-2 URL ECONNREFUSED / 404 만나도 alternate deep URL 발굴 의무. lazy 포기 X.** WebFetch fail = 다른 URL 시도. 산업 표준 기관·정부 deep page·deep article 등 alternate pool 활용.

---

# 처리 대상 5 직업

| # | name | id | slug |
|---|---|---|---|
| 1 | <name1> | <id1> | <slug1> |
| 2 | <name2> | <id2> | <slug2> |
| 3 | <name3> | <id3> | <slug3> |
| 4 | <name4> | <id4> | <slug4> |
| 5 | <name5> | <id5> | <slug5> |

# 처리 절차

각 직업 순서대로 `.claude/skills/job-data-master/SKILL.md` Phase 0~7 흐름 따라 master 적용.
POST endpoint: `https://careerwiki.org/api/job/{id}/edit`
인증: `X-Admin-Secret: careerwiki-admin-2026`
배치 5 직업 끝나면 즉시 종료. 자동 다음 cycle 진입 X.
```
