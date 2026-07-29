# STRICT - 절대 룰 (위반 시 즉시 abort + 보고)

1-15. (R11_B1 동일 — 룰 14 youtubeLinks 의무 + 룰 15 totalEntries >= 19 강제)

---

# 처리 대상 5 직업 (R11_B4 - 건축 4 + 검색광고 1)

| # | name | id | slug | industry_class | URL pool hint |
|---|---|---|---|---|---|
| 1 | 건축시공연구원 | 1765283751544420 | 건축시공연구원 | major | 한국건설기술연구원 KICT (kict.re.kr), 대한건축학회 (aik.or.kr), 한국건설관리학회 KICEM (kicem.or.kr), 한국건축구조기술사회, 국토교통부 건축정책관, Q-net 건축기사·건축시공기술사, 한국건설기술인협회 |
| 2 | 건축자재영업원 | 1765284493288107 | 건축자재영업원 | minor | 한국시멘트협회 (cement.or.kr), 한국철강협회 (kosa.or.kr), 한국유리공업협회, 한국건자재시험연구원 (kctri.or.kr), 한국건축자재협회, 대한건설협회, KS 인증 (ksa.or.kr) |
| 3 | 건축전기설비감리원 | 176528383851776 | 건축전기설비감리원 | major | 한국전기기술인협회 (keea.or.kr), 한국전기안전공사 (kesco.or.kr), 한국전기공사협회 (keca.or.kr), Q-net 전기기사·전기공사기사·전기감리, 국토교통부 건축정책관, 대한전기학회 (kiee.or.kr), 한국조명전기설비학회 (kiiee.or.kr) |
| 4 | 건축전기설비기술자 | 176528383893630 | 건축전기설비기술자 | major | 한국전기기술인협회, 한국전기공사협회, 대한전기학회, 한국조명전기설비학회, Q-net 전기기사·전기공사기사·산업기사, 한국전기안전공사, 한국전력공사 (kepco.co.kr), 국토교통부 |
| 5 | 검색광고판매-매니저 | 1765284104052152 | 검색광고판매-매니저 | major | 네이버 검색광고 (searchad.naver.com), 카카오 모먼트 (moment.kakao.com), 구글 광고 코리아, 한국디지털광고협회 (kdaa.org), 한국온라인광고협회, 한국인터넷진흥원 KISA (kisa.or.kr), 한국방송광고진흥공사 (kobaco.co.kr), 한국광고학회 (kadpr.or.kr) |

# 처리 절차

각 직업 .claude/skills/job-data-master/SKILL.md Phase 0~7 (ENHANCE).
- change_summary: [job-data-master] enhance - way·trivia·detailReady·sidebar·youtubeLinks·...

# 보고 형식

```
R11_B4 결과:
1. 건축시공연구원       | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
2. 건축자재영업원       | rev=NNNN | distinct=NN | totalE=NN | minor | CLEAN
3. 건축전기설비감리원   | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
4. 건축전기설비기술자   | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN
5. 검색광고판매-매니저  | rev=NNNN | distinct=NN | totalE=NN | major | CLEAN

BATCH DONE: 5/5 ok, 0 fail
```
