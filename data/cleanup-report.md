# Cleanup Report — 4 Tasks 종합

**Generated**: 2026-04-30
**Scope**: worktree cleanup + 전화교환원 sal fix + detailReady [N] 누락 audit + 325 originDomain 잔존 audit

---

## 작업 1: Worktree Cleanup

**결과**: 20개 → **6개** (15개 enhance + Skill fix metadata 정리)

### 삭제 완료 (15건 — git metadata 정리됨)

```
nice-williams-50dbdc          dreamy-shaw-fc099e
reverent-montalcini-0db79d    hungry-jang-1c83c5
focused-shtern-c08903         modest-carson-4ff96f
laughing-wright-e65703        loving-nightingale-759323
confident-euler-70d447        cranky-pasteur-85a548
naughty-curie-0cb6e7          friendly-stonebraker-d4fddb
heuristic-darwin-d1c982       nifty-lovelace-13634e
determined-ardinghelli-f64491
```

### 보존 (6건)

| worktree | 용도 |
|----------|------|
| `C:/Users/user/Careerwiki` | main (HEAD bc4af98) |
| `dazzling-allen-38a04f` | current 작업 worktree (HEAD 658e75c) |
| `agitated-chebyshev-98281f` | 별도 작업 (df77453) |
| `elastic-zhukovsky-3aab63` | 별도 작업 (2e8c3bf) |
| `focused-goldstine-6fdc77` | a1557c7 sources 4패턴 commit branch |
| `happy-goldberg-2b80c9` | salary-etl 작업 (feeb83e) |

### 주의

10개 worktree는 git metadata 정리됐지만 디렉토리 일부 파일(node_modules의 .pack 등)이 Windows 잠금 상태로 디스크 잔존. git worktree list에서 안 보임 — 다음 부팅 후 수동 `rm -rf` 가능.

---

## 작업 2: 전화교환원 sal brokenRef Fix

**결과**: ✅ 완료 — 9패턴 + originDomain 0건, 이슈 없음 100%

### 진단

**fix 전 sal**:
```
"연봉 중위값은 약 2,800만 원이며[3], 외국어 능통자나 전문 의료기관 교환원은 3,500만 원 이상을 받기도 한다.[4]"
```

`[3]` = 한국민족문화대백과 (역사 설명, sal 출처 부적합)
`[4]` = 천지일보 추억 직업 기사 (역사 회고, sal 출처 부적합)

field-local 매핑 시 `_sources["overviewSalary.sal"]` 미등록 → 본문 [3][4] broken.

### 처리 결정

**선택지**:
- (a) 본문 [3][4] 마커 제거 → 무출처 문장
- (b) 부적합 출처 매핑 (한국민족문화대백과/천지일보) 추가 → 거짓 인용
- (c) sal 본문 자체 제거 → 데이터 손실

**선택**: (a) — 부적합 출처 매핑보다 무출처 문장이 신뢰성 ↑

### 실행

```sql
UPDATE jobs
SET user_contributed_json = json_set(
  user_contributed_json,
  '$.overviewSalary.sal',
  REPLACE(REPLACE(json_extract(user_contributed_json, '$.overviewSalary.sal'), '[3]', ''), '[4]', '')
)
WHERE slug='전화교환원';
```

### fix 후 sal

```
"연봉 중위값은 약 2,800만 원이며, 외국어 능통자나 전문 의료기관 교환원은 3,500만 원 이상을 받기도 한다."
```

audit-sources-deep `--slug=전화교환원` → 이슈 없음 100% (originDomain=0, brokenRef=0).

> ⚠️ 무출처 통계 인용이 됐지만 sal은 [sal-수정금지] 정책으로 enhance 스킬이 더 이상 못 건드림. 향후 정리는 별도 admin SQL로 sal 전체 정비 시 함께 처리.

---

## 작업 3: detailReady [N] + _sources 누락 직업

**대상**: cycle 1 처리 21 unique 직업
**누락 발견**: **4건 / 21**

| 직업 | curriculum 누락 | recruit 누락 | training 누락 | _sources 미등록 |
|------|----------------|-------------|---------------|-----------------|
| 경제학연구원 | 3/3 | 3/3 | 3/3 | curriculum/recruit/training 전부 |
| 법원공무원 | 4/4 | 3/3 | 3/3 | curriculum/recruit/training 전부 |
| 사회학연구원 | 3/3 | 3/3 | 3/3 | curriculum/recruit/training 전부 |
| 수상운송사무원 | 4/4 | 4/4 | 3/3 | curriculum/recruit/training 전부 |

**공통 패턴**: 4건 모두 detailReady 모든 항목에 [N] 마커 0개 + _sources["detailReady.X"] 미등록 — enhance subagent가 detailReady 출처 등록 자체를 skip한 패턴.

**처리 권고**: 단일 직업 retry prompt 4건으로 detailReady만 보강. 본문 텍스트는 그대로 두고 [N] 마커 추가 + 적절한 _sources 등록만 수행.

> 이번 cleanup에서 fix는 안 함 (사용자 명시 "list 산출"). retry는 별도 dispatch 필요.

---

## 작업 4: 325 originDomain 잔존 Audit

**baseline shift**:
- 이전 audit (b044d47): originDomain 193/325 (59%) / 이슈 없음 124 (38%)
- 현재 audit (bc4af98): originDomain **156/325 (48%)** / 이슈 없음 **164 (50%)**
- cycle 1·2·3 효과: origin 37건↓, clean 40건↑

### 검증 1: 처리 52 직업 중 originDomain 잔존

**잔존 2건 (예상 0건이었으나 일부 처리 누락)**:

| 직업 | originDomain | host |
|------|-------------|------|
| 마취병리과의사 | 1건 | www.wagework.go.kr |
| 법원공무원 | 4건 | www.scourt.go.kr × 2, www.wagework.go.kr × 2 |

**원인**:
- **마취병리과의사**: cycle 1 round 2에서 처리됐으나 wagework 1건 잔존 — enhance가 origin 인식 누락
- **법원공무원**:
  - wagework 2건 → enhance 누락
  - **scourt.go.kr 2건은 false positive 의심**: 대법원 사이트(`scourt.go.kr`)가 `.go.kr` + path keyword `work` 매칭으로 잡힘. 하지만 대법원은 직업정보 origin이 아닌 정부 부처 사이트. heuristic over-detect 가능성

**대응 권고**:
- 마취병리과의사 + 법원공무원: retry 1직업씩 dispatch (wagework 제거)
- scourt.go.kr false positive: 추후 detect-patterns.cjs heuristic 정밀화 검토 (정부 부처 도메인 화이트리스트 추가)

### 검증 2: 미처리 273 직업 originDomain 잔존

**미처리 273건 중 origin 잔존 154건 (56%)**

#### Host별 분포 (총 650건 origin URL 발생)

| Host | 발생 건수 | 비고 |
|------|----------|------|
| www.career.go.kr | **531** | 최대 — 커리어넷 |
| www.work.go.kr | 39 | 워크넷 (구) |
| www.wagework.go.kr | 37 | 워크피디아 |
| www.work24.go.kr | 28 | 고용24 |
| m.work.go.kr | 9 | 워크넷 모바일 |
| www.youth.go.kr | 4 | 청년정책 |
| www.scourt.go.kr | 2 | (false positive 의심 — 법원공무원 1건 + 미처리 1건) |

#### Top 30 미처리 직업 (origin URL 수 내림차순)

| 순위 | 직업 | origin 수 | host |
|----|------|---------|------|
| 1 | 캐디 | 17 | work.go.kr, career.go.kr |
| 2 | 가상현실전문가 | 10 | career.go.kr, work24.go.kr |
| 3 | 청원경찰 | 10 | career.go.kr, wagework.go.kr |
| 4 | IT기술지원전문가 | 9 | work.go.kr, career.go.kr |
| 5 | 방사선사 | 9 | career.go.kr, work.go.kr |
| 6 | 안경사 | 9 | career.go.kr, work.go.kr |
| 7 | gis전문가 | 8 | career.go.kr, work.go.kr |
| 8 | 게임-기획자 | 8 | career.go.kr |
| 9 | 대중가수 | 8 | career.go.kr, work.go.kr |
| 10 | 보험인수심사원언더라이터 | 8 | career.go.kr, wagework.go.kr, work24.go.kr |
| 11 | 스포츠강사 | 8 | career.go.kr |
| 12 | 스포츠트레이너 | 8 | career.go.kr |
| 13 | 웨딩플래너 | 8 | career.go.kr, work24.go.kr |
| 14 | 유치원교사 | 8 | career.go.kr, work24.go.kr |
| 15 | 응급구조사 | 8 | career.go.kr |
| 16 | 중고등학교교사 | 8 | career.go.kr |
| 17 | 3d-프린팅-전문가 | 7 | career.go.kr, work.go.kr |
| 18 | 간호사 | 7 | career.go.kr, work24.go.kr |
| 19 | 간호조무사 | 7 | career.go.kr |
| 20 | 검침원 | 7 | career.go.kr |
| 21 | 데이터분석가빅데이터분석가 | 7 | career.go.kr, work24.go.kr |
| 22 | 변리사 | 7 | career.go.kr |
| 23 | 병원코디네이터 | 7 | career.go.kr |
| 24 | 영양사 | 7 | career.go.kr |
| 25 | 운동선수 | 7 | wagework.go.kr, career.go.kr, work.go.kr |
| 26 | 임상병리사 | 7 | career.go.kr |
| 27 | 자동차정비원 | 7 | career.go.kr, wagework.go.kr |
| 28 | 치과기공사 | 7 | career.go.kr |
| 29 | 치과위생사 | 7 | career.go.kr |
| 30 | 치과의사 | 7 | career.go.kr |

> + 잔여 124건. 전체 list는 `data/audit-sources-deep.json` jobs[].originDomain 참조

---

## 종합 요약

| 작업 | 상태 | 결과 |
|------|------|------|
| 1. worktree cleanup | ✅ 완료 | 15 enhance worktree git metadata 정리 (20→6) |
| 2. 전화교환원 sal fix | ✅ 완료 | brokenRef 0, 이슈 없음 100% |
| 3. detailReady 누락 list | ✅ list 완료 | 4건 식별 (경제학/법원/사회학/수상운송) |
| 4. originDomain 잔존 audit | ✅ 완료 | 처리 52건 중 2건 잔존 + 미처리 273건 중 154건 잔존 |

### Action Items (별도 dispatch 필요)

1. **마취병리과의사 retry** — wagework 1건 제거
2. **법원공무원 retry** — wagework 2건 제거 (scourt는 false positive로 판단 가능)
3. **detailReady 누락 4건 fix** — 경제학연구원/법원공무원/사회학연구원/수상운송사무원에 [N] + _sources 등록
4. **scourt.go.kr false positive** — heuristic 정밀화 검토 (선택사항)
5. **미처리 273 → 154 origin 잔존** — 다음 enhance 사이클 대상 풀

main HEAD: `bc4af98` (변경 없음 — 이번 cleanup은 worktree metadata + DB 1건만)
