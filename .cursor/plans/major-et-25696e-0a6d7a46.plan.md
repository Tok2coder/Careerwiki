<!-- 0a6d7a46-c31c-4766-b048-41e9cc97c8c7 efd646ac-a527-4266-9a73-dc0ff44c79ec -->
# ChartData 재배치 계획

## 변경 파일

- `src/templates/unifiedMajorDetail.ts`

## 1. 상세정보 탭: 입학상황 섹션 추가 (첫 번째 섹션)

- `chartData.gender` (도넛 차트: 남/여 비율)
- `chartData.applicant` (바 차트: 지원자/입학자 수)
- 스크린샷처럼 2열 그리드 레이아웃
- 출처: "자료: 한국교육개발원, 교육통계(2025), {학과명}"

## 2. 개요 탭: 졸업 후 진출분야 차트 추가

- `chartData.field` (도넛 차트)를 기존 `enterField` 텍스트 위에 배치
- 출처: "자료: 한국고용정보원, 대졸자 직업이동 경로조사(2020), {학과명}"

## 3. 핵심지표 섹션: 통계 차트 추가

히어로 영역 아래 또는 개요 탭 상단에 4개 차트 추가:

- `chartData.after_graduation` (도넛 차트: 진학률)
- `chartData.employment_rate` (바 차트: 취업률)
- `chartData.avg_salary` (도넛 차트: 월평균 임금 분포)
- `chartData.satisfaction` (도넛 차트: 첫 직장 만족도)

2x2 그리드 레이아웃, 각 차트에 출처 표시

## 4. 기존 텍스트 지표 강조 스타일링

핵심지표 차트 아래에 기존 텍스트 지표 유지:

- 취업률, 졸업 후 평균 월급
- 카드 형태로 강조 스타일 적용 (배경색, 아이콘, 큰 폰트)

## 5. 기존 통계 섹션 정리

- 현재 detailCards에 있는 중복 차트 로직 제거
- universities-chartData 섹션 제거 또는 용도 변경

### To-dos

- [ ] 상세정보 탭에 입학상황 섹션 추가 (gender + applicant 차트)
- [ ] 개요 탭 진출분야에 field 도넛 차트 추가
- [ ] 핵심지표에 4개 통계 차트 추가 (진학률, 취업률, 임금, 만족도)
- [ ] 기존 텍스트 지표 강조 스타일링
- [ ] 기존 중복 차트 로직 정리