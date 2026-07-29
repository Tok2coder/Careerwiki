# STRICT - 절대 룰 (위반 시 즉시 abort + 보고)

1. **이 batch 직업 명단 외 직업 SELECT/POST/audit 절대 X.**
2. **PowerShell 절대 X. Bash 만 사용.**
3. **자작 스크립트 X.** 모든 작업 = .claude/skills/job-data-master/SKILL.md Phase 0~7.
4. **WebFetch 우회 X. distinct URL >= 18 + totalEntries >= 19**.
5. **subagent 병렬 X.**
6. **sal/wage 미접촉.**
7. **AskUser X.**
8. **5 직업 처리 후 종료 형식**: slug | rev_id | distinct | totalE | class | audit + BATCH DONE.
9. **산업 분류**: major = distinct >= 18 강제. 모호 시 default = major.
10. **URL pool hint + alternate 발굴**: minimum 10 site.
11. **Lazy abort 방지**.
12. **본문 보강 의무화**: 9 prose 영역 100자+. minimal patch 금지.
13. **Audit**: WARN 0 / FAIL 0 후 다음.
14. **youtubeLinks 영역 omit 금지**.
15. **totalEntries >= 19 강제**.

---

# 처리 대상 5 직업 (R11_B2 - 건축 5)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | 건축감리원 | 1765283749750450 | 건축감리원 | major | 한국건축감리협회 (kasa.or.kr), 한국건축사협회 (kira.or.kr), 국토교통부 (molit.go.kr) 건축정책관, 건축법령 (law.go.kr), Q-net 건축감리·건축기사, 한국건설기술인협회 (kpea.or.kr), 한국시설안전공단, 대한건축학회 (aik.or.kr), 한국건설기술연구원 KICT |
| 2 | 건축견적원 | 1765283750104739 | 건축견적원 | major | 한국건설기술관리협회, 한국건설관리학회 KICEM (kicem.or.kr), Q-net 건축적산기사·산업기사·기사, 대한건설협회 (cak.or.kr), 한국건설기술인협회, 국토교통부 BIM 정책, 한국건설견적원협회 |
| 3 | 건축공무기술자 | 1765283750424884 | 건축공무기술자 | major | 한국건설기술관리협회, 대한건설협회, 한국건설기술인협회, Q-net 건축기사·산업기사·기능사, 국토교통부 건축정책관, 한국건설안전협회, 대한건축학회 |
| 4 | 건축구조설계기술자 | 1765283750806358 | 건축구조설계기술자 | major | 한국건축구조기술사회 (kasse.or.kr), 대한건축학회 (aik.or.kr), 한국강구조학회 (ksss.or.kr), 한국콘크리트학회 (kci.or.kr), 한국지진공학회 (eesk.or.kr), Q-net 건축구조기술사, 국토교통부, 한국건설기술연구원 KICT |
| 5 | 건축모형제작원 | 1765284782668192 | 건축모형제작원 | niche | 한국디자인진흥원 (kidp.or.kr), 한국공예디자인문화진흥원 (kcdf.kr), 대한건축학회, 한국건축사협회, Q-net 산업디자인기사·시각디자인기사, 한국실내건축가협회, HRD-Net 건축모형 |

# 처리 절차

각 직업 순서대로 .claude/skills/job-data-master/SKILL.md Phase 0~7 (ENHANCE 모드).
- POST: https://careerwiki.org/api/job/{id}/edit + X-Admin-Secret: careerwiki-admin-2026
- 파일 기반 POST, validate-job-edit + audit-via-api 의무
- change_summary: [job-data-master] enhance - way·trivia·detailReady·sidebar·youtubeLinks·...

# 보고 형식

```
R11_B2 결과:
1. 건축감리원         | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
2. 건축견적원         | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
3. 건축공무기술자     | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
4. 건축구조설계기술자 | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
5. 건축모형제작원     | rev=NNNN | distinct=NN | totalE=NN | niche | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```
