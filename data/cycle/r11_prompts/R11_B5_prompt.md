# STRICT - 절대 룰 (위반 시 즉시 abort + 보고)

1-15. (R11_B1 동일 — 룰 14 youtubeLinks 의무 + 룰 15 totalEntries >= 19 강제)

---

# 처리 대상 5 직업 (R11_B5 - 검 5: 검시·검열·검찰·검침)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | 검시조사관 | 1765284441054741 | 검시조사관 | major | 대검찰청 (spo.go.kr), 국립과학수사연구원 NFS (nfs.go.kr), 대한법의학회 (legalmed.or.kr), 한국법의학회, 형사사법포털 (kics.go.kr), 검찰청 채용 deep, Q-net 임상병리사, 보건복지부, 경찰청 |
| 2 | 검열조종사 | 1765283965976381 | 검열조종사 | niche | 공군 (airforce.mil.kr), 국방부 (mnd.go.kr), 한국항공우주산업 KAI (koreaaero.com), 항공안전기술원 (kiast.or.kr), 국토교통부 항공정책관, 한국항공협회 (airtransport.or.kr), 항공기 시험비행 학회, ICAO Korea |
| 3 | 검찰수사관 | 1765284441502947 | 검찰수사관 | major | 대검찰청 (spo.go.kr), 검찰청 채용 (recruit.spo.go.kr), 법무부 (moj.go.kr), 사이버범죄수사관 채용 deep, 검찰청법 (law.go.kr), 한국형사정책연구원 (kic.re.kr), 한국형사법학회 (kacl.kr), 사법연수원, 형사사법포털 |
| 4 | 검찰총장 | 176528355605556 | 검찰총장 | major | 대검찰청 (spo.go.kr), 법무부 (moj.go.kr), 검찰청법 (law.go.kr), 헌법재판소 (ccourt.go.kr), 사법부 인사위원회, 한국형사정책연구원, 한국공법학회, 한국법학원 |
| 5 | 검침사무원 | 17652856183755 | 검침사무원 | minor | 한국전력공사 (kepco.co.kr), 한국가스공사 (kogas.or.kr), 한국수자원공사 K-water (kwater.or.kr), 한국도시가스협회 (citygas.or.kr), 서울도시가스 (seoulgas.co.kr), 한국상하수도협회 (kwwa.or.kr), HRD-Net, KOSHA |

# 처리 절차

각 직업 .claude/skills/job-data-master/SKILL.md Phase 0~7 (ENHANCE).
- change_summary: [job-data-master] enhance - way·trivia·detailReady·sidebar·youtubeLinks·...

# 보고 형식

```
R11_B5 결과:
1. 검시조사관    | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
2. 검열조종사    | rev=NNNN | distinct=NN | totalE=NN | niche | CLEAN
3. 검찰수사관    | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
4. 검찰총장      | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
5. 검침사무원    | rev=NNNN | distinct=NN | totalE=NN | minor | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```
