# STRICT - 절대 룰 (위반 시 즉시 abort + 보고)

1-15. (R11_B1 / R11_B2 동일 — 룰 14 youtubeLinks 의무 + 룰 15 totalEntries >= 19 강제)

---

# 처리 대상 5 직업 (R11_B3 - 건축 5: 배관·석공·설비)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | 건축배관공 | 1765284809327492 | 건축배관공 | major | Q-net 배관기능사·산업기사·기사, 한국설비기술협회 (karse.or.kr), 한국가스안전공사 (kgs.or.kr), 한국상하수도협회 (kwwa.or.kr), 한국건축설비기술사회, 대한건설협회, KOSHA 산업안전, 한국건설기술인협회 |
| 2 | 건축배관반장 | 1765284809706737 | 건축배관반장 | major | Q-net 배관산업기사·기사, 한국설비기술협회, 한국가스안전공사, 한국상하수도협회, 대한건설협회, KOSHA, 한국건설기술인협회, 한국건축설비기술사회 |
| 3 | 건축석공반장 | 176528474759780 | 건축석공반장 | minor | 한국석재산업협회 (kosa.or.kr), 한국채석공협회, 대한건설협회, KOSHA 산업안전, Q-net 석공기능사·산업기사, HRD-Net, 대한건축학회 |
| 4 | 건축석축공 | 1765284747947433 | 건축석축공 | niche | 한국석재산업협회, KOSHA 산업안전, Q-net 석공기능사, HRD-Net, 대한건설협회, 한국화약발파공학회 |
| 5 | 건축설비설계기술자 | 1765283901772860 | 건축설비설계기술자 | major | 한국건축설비기술사회 (kibse.or.kr), 한국설비기술협회 (karse.or.kr), 대한건축학회, Q-net 건축설비기사·산업기사·기술사, 국토교통부 건축정책관, 한국건설기술연구원 KICT, 한국공기조화냉동공학회 (sarek.or.kr) |

# 처리 절차

각 직업 .claude/skills/job-data-master/SKILL.md Phase 0~7 (ENHANCE).
- POST + validate + audit 의무
- change_summary: [job-data-master] enhance - way·trivia·detailReady·sidebar·youtubeLinks·...

# 보고 형식

```
R11_B3 결과:
1. 건축배관공         | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
2. 건축배관반장       | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
3. 건축석공반장       | rev=NNNN | distinct=NN | totalE=NN | minor | CLEAN
4. 건축석축공         | rev=NNNN | distinct=NN | totalE=NN | niche | CLEAN
5. 건축설비설계기술자 | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```
