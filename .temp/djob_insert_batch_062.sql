INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006058:1', '{"dJobCd":"K000006058","dJobCdSeq":"1","dJobNm":"그라비어인쇄기조작원","workSum":"비닐필름, 지류 등의 인쇄원단에 단색 또는 다색을 인쇄하기 위하여 그라비어(Gravure)인쇄기를 조작한다.","doWork":"작업지시서를 확인하고 인쇄 작업에 필요한 각종 사항을 검토한다. 인쇄 장치, 잉크장치, 건조장치 및 인쇄 관련 설비를 점검한다. 작업내용에 따른 잉크배합, 인쇄실린더 끼우기, 건조 실린더의 온도조절 등의 준비 작업을 한다. 인쇄용 원단을 인쇄 롤을 회전시켜 롤러 사이로 투입한다. 투입 원단 및 인쇄상태를 확인하고 인쇄핀트와 압력 롤의 간격을 조절한다. 불량 인쇄물에 불량표시를 하고 인쇄원단을 권취한다. 인쇄공정에 따라 엠보싱기 등의 관련 장치를 조작하기도 한다. 롤 상태의 종이를 릴에 걸어서 고속인쇄를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"낱장그라비어인쇄기조작원, 두루마리그라비어인쇄기조작원 , 평판그라비어인쇄기조작원, 원통판그라비어인쇄기조작원, 벽지인쇄기조작원, 그라비어윤전기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005090:1', '{"dJobCd":"K000005090","dJobCdSeq":"1","dJobNm":"기타인쇄물인쇄원","workSum":"안내장, 명함, 스티커 및 기타 인쇄물을 인쇄·제작하기 위하여 장식이나 문구를 도안하고 자동인쇄기를 조작한다.","doWork":"고객과 인쇄물의 디자인을 상의하거나 미리 준비된 디자인 중에서 선택한다. 컴퓨터로 디자인 시안을 만들고 인쇄용 포맷(CMYK:인쇄시스템에서 사용되는 4원색 색표시 모델)으로 저장한다. 인쇄규격에 맞는 용지를 인쇄기에 투입한다. 인쇄기를 가동시키고 컴퓨터의 원고를 인쇄기로 전송한다. 초판을 인쇄하고 수정할 사항이 없으면 정해진 수량을 인쇄한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"스티커인쇄기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005585:1', '{"dJobCd":"K000005585","dJobCdSeq":"1","dJobNm":"대지기계조작원","workSum":"앨범 또는 수첩용 특수책자의 대지(내지)를 제작하기 위하여 대지기계를 조작한다.","doWork":"대지에 인쇄할 문양과 같은 금형을 대지기계에 부착한다. 접착제를 수령하여 통에 투입하고 접착제 이송 파이프를 롤러에 연결한다. 대지 위에 코팅처리 할 필름을 걸어서 롤러에 연결시킨다. 기계의 이상 유무를 확인하고 롤러의 온도를 조절한다. 대지제조용 두루마리마닐라 판지를 기계의 투입구에 연결한다. 제조할 앨범이나 책자의 규격에 따라 기계에 내장된 재단칼날을 조정한다. 기계 가동스위치를 조작한다. 필름이 코팅 처리된 상태를 점검하고 적재된 대지의 규격과 수량을 파악하여 기록한다. 주입식 앨범의 대지에 포켓을 만드는 기계를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"포켓기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003460:1', '{"dJobCd":"K000003460","dJobCdSeq":"1","dJobNm":"디지털제판원","workSum":"컴퓨터로 작업한 데이터를 인쇄판에 출력하는 CTP(Computer To Plate)시스템을 운영한다.","doWork":"컴퓨터 화면상에서 인쇄원고를 편집하고 출력기(출력할 파일을 PDF로 변환·출력하여 컬러 등을 보정함)로 출력하여 원고 데이터의 오류를 검사한다. 컴퓨터상에서 원고를 수정한다. CTP출력기를 사용하여 원고데이터를 동판에 직접 출력한다. 작업이 완료되면 동판을 포장하고 데이터를 저장한다. CTP출력기의 이상 유무를 점검하고 이상이 발생하면 제조사에 문의하여 조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001821:1', '{"dJobCd":"K000001821","dJobCdSeq":"1","dJobNm":"문자판실크인쇄원","workSum":"명세서에 명시된 모양을 내기 위해 인쇄장비를 사용하여 시계의 문자판 표면에 실크인쇄를 한다.","doWork":"작업명세서와 도면을 보고 실크인쇄 할 문자판의 규격, 형태, 두께 등을 확인한다. 실크인쇄기, 인쇄망, 전사필름, 잉크 적외선 건조기 등의 원료 및 장비의 작동 여부를 점검한다. 인쇄 모양대로 현상액을 칠하여 건조한 후, 인쇄되지 않을 부분의 실크인쇄망에 필름을 부착하고 세척액으로 씻은 후 스크린망을 완료한다. 스크린망과 지그잉크를 준비한다. 기계에 지그를 고정한 후 스크린망을 조립한다. 잉크를 넣고 지그에 문자판을 고정한다. 잉크의 농도를 맞춘 후 찍어서 투영기로 초점을 맞춘다. 실크인쇄 전 문자판 상면과 필름부위의 오염물질을 제거한 후 스크린망으로 문자판에 실크인쇄를 한다. 인쇄를 한 후 실크망을 들어내고 문자판을 적외선 건조기에 넣고 건조시킨다. 제품의 규격 및 크기에 따라 실크망을 제작하고 파손된 실크망을 수리·보수하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004911:1', '{"dJobCd":"K000004911","dJobCdSeq":"1","dJobNm":"문자판전사원","workSum":"인쇄장비를 사용하여 시계의 시자(時字), 분 및 초궤도, 회사명을 시계문자판에 새긴다.","doWork":"작업지시서에 따라 전사할 문자판의 규격, 형태, 수량을 확인한다. 전자인쇄기, 잉크, 주걱, 문자판 등의 원료 및 장비를 점검한다. 도안 및 문양을 확인하고 고정구를 전자인쇄기의 젤라틴 상단에 놓는다. 양각된 금속판을 고정구에 놓고 잉크를 판 위에 칠한다. 주걱을 사용하여 남은 잉크를 제거한다. 전자인쇄기의 젤라틴(Gelatin) 상단을 판에 내려 도안을 복사한다. 도안을 문자판에 찍기 위해 문자판을 제 위치에 놓고 젤라틴 상단을 내린다. 패드를 이용하여 찍어서 패드인쇄를 하기도 한다. 부품을 보호하기 위해 문자판의 일정 부위에 래커(Lacquer) 칠을 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"아주 가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C274","dJobICdNm":"[C274]시계 및 시계부품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007381:1', '{"dJobCd":"K000007381","dJobCdSeq":"1","dJobNm":"벽지견본책제조원","workSum":"제조된 벽지의 종류와 규격별로 견본을 채취하여 견본책을 만든다.","doWork":"벽지 보급 및 판매에 사용할 견본책을 만들기 위하여 벽지제품의 규격·무늬·지질별로 견본을 채취한다. 채취된 견본을 일정 규격으로 재단하고 견본용 앨범에 색상 순서별로 삽입하거나 바인더, 스테이플 등을 이용하여 책을 만든다. 견본별로 벽지의 규격, 제조업체명, 견본마크를 인쇄한다. 수출용 견본책을 제작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C179","dJobICdNm":"[C179]기타 종이 및 판지 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001435:1', '{"dJobCd":"K000001435","dJobCdSeq":"1","dJobNm":"사진제판반장","workSum":"인쇄할 사진 및 원고를 촬영하여 인쇄용 판으로 제작하는 작업원의 활동을 감독·조정한다.","doWork":"사진제판에 관련된 기술을 작업자에게 교육한다. 확대경을 사용하여 작업지시서 또는 고객의 주문 내용과 인쇄판이 일치하는지 점검한다. 인쇄물량과 일정에 따라 순서를 계획하고 작업원에게 작업내용 및 계획을 알린다. 작업진행상황을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 작업공정에 필요한 자재 및 기술을 지원한다. 표준명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업내용을 점검한다. 수시로 관찰과 면담을 통하여 작업원의 애로 및 건의사항을 수렴·해결하고 문제점을 보고한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","similarNm":"사진제판기장, 사진제판부기장","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001644:1', '{"dJobCd":"K000001644","dJobCdSeq":"1","dJobNm":"사철기조작원","workSum":"낱장으로 취합된 인쇄물을 책으로 제조하기 위하여 실로 꿰매거나 중앙부분에 철심을 박는 사철기 및 중철기를 조작한다.","doWork":"인쇄물의 규격에 따라서 적재판의 크기를 조절한다. 책의 두께와 크기에 따라 꿰매는 실 가닥수를 결정하고 각 바늘에 연결시킨다. 한 권의 책으로 제책되는 정합인쇄물의 수에 따라 실을 투입한다. 기계 가동스위치를 조작하여 꿰매고, 가동상태를 검사한다. 인쇄물을 한 권씩 엮음기 바늘 밑에 넣고 기계를 가동하여 꿰매기도 한다. 중철기를 사용하는 경우 책의 중앙부분에 철심을 박아 넣기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"봉책기조작원, 엮음원","connectJob":"중철기조작원","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005561:1', '{"dJobCd":"K000005561","dJobCdSeq":"1","dJobNm":"색박기조작원","workSum":"가죽, 직물, 종이, 플라스틱 및 여러 재료 위에 문자나 도안을 금, 은, 카본, 청, 적 등의 색상을 입히기 위하여 박(箔)프레스기를 조작한다.","doWork":"작업지시서에 따라 인쇄할 문양의 금형을 프레스에 고정한다. 압형할 재료의 재질에 따라 열·압력·시간조정기를 조절한다. 금박프레스 적재대에 인쇄할 재료를 올려놓는다. 굴대에 인쇄에 필요한 금박, 은박, 카본의 두루마리를 끼워 넣는다. 인쇄가 필요한 재료를 인쇄기의 인쇄 위치에 넣고 레버를 당기거나 페달을 밟아 인쇄한다. 인쇄물의 인쇄상태를 검사하고 규격별로 분리하여 적재한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"금박기원, 은박기원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001957:1', '{"dJobCd":"K000001957","dJobCdSeq":"1","dJobNm":"색부기조작원","workSum":"책이나 노트로 제책하기 전 표지가 붙지 않은 가제책된 반제품의 삼면에 금, 은, 적 등의 색상을 도색한다.","doWork":"가제책된 반제품에 대한 작업사항을 확인하고 도장용 분사기, 연마기 등의 기계를 점검한다. 도색할 색상의 도장재를 준비한다. 가제책된 반제품을 일정량씩 모아 압축기로 압축한다. 연마기를 사용하여 삼면을 연마하고 도장재가 골고루 도색되도록 한다. 색부기 조작반의 공기조절장치를 조작하여 분사될 도장재의 분사량을 조절한다. 규정된 두께로 도장재를 분출하여 색칠한다. 건조된 제품은 규정된 규격으로 도색되었는지 검사하고 규격별로 분리하여 적재한다. 수동 스프레이를 이용하여 가제책의 삼면을 규정된 색상으로 도색하기도 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"색부원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004648:1', '{"dJobCd":"K000004648","dJobCdSeq":"1","dJobNm":"소부원","workSum":"배열된 원고용 필름을 아연판, 알루미늄판 등의 인쇄용 판으로 제작한다.","doWork":"소부할 필름원판을 수령한다. 필름과 부착할 시트를 작업대 위에 겹쳐놓고 네 귀퉁이를 테이프로 고정한다. 필름을 손빗자루로 쓸어서 공기가 들어가지 않도록 주의하면서 시트에 부착한다. 시트에 뚫려있는 두 개의 구멍을 소부기 투입구의 핀에 고정한다. 현상할 매수를 입력하고 작동버튼을 눌러 시트를 소부기에 투입한다. 소부기에서 자동으로 현상되어 나온 인쇄용 판을 윤전기로 이동한다. 소부기의 현상액, 고무액을 교체하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"소부기조작원","connectJob":"수지판제작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003474:1', '{"dJobCd":"K000003474","dJobCdSeq":"1","dJobNm":"스크린인쇄원","workSum":"제조된 스크린 틀을 이용하여 종이, 금속, 직물 및 기타 합성수지 제품에 도안이나 문자를 인쇄한다.","doWork":"일정 규격의 천(Silk)에 유제를 도포한다. 유기용제로 처리된 천을 건조시킨다. 인쇄할 내용이 도안된 필름을 유제가 처리된 천에 밀착시키고 일정 조도의 광원이 설치된 라이트테이블(Light Table)에 고정한다. 적정 시간 동안 빛 쪼임 작업이 된 천을 물로 세척한다. 천에 나타난 도안물의 상태를 확인하고 나무, 스테인리스 등으로 만든 틀에 테이프, 핀 등을 이용하여 천을 고정한다. 인쇄할 물질에 스크린 틀을 정확하게 맞추어 밀착시킨다. 인쇄할 색상에 맞는 잉크를 스크린 틀에 바르고 고무롤러로 밀어서 인쇄를 한다. 인쇄된 판의 색상, 내용, 인쇄상태 등을 점검한다. 인쇄가 완료되었거나 색상을 바꾸기 위하여 용해액으로 스크린을 세척한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"스크린인쇄기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003315:1', '{"dJobCd":"K000003315","dJobCdSeq":"1","dJobNm":"스프링제책기조작원","workSum":"스프링을 이용하여 인쇄물을 수첩, 노트 및 책의 형태로 구성하는 제책기를 조작한다.","doWork":"생산의뢰서의 주문사항 및 특이사항을 확인한다. 천공기, 스프링기, 포장기, 바코드기 등과 같은 제책 관련 설비를 점검하고 제책을 위한 원·부자재 등의 준비사항을 점검한다. 생산의뢰서에 주문된 규격, 품질 등에 맞게 제책 관련 설비의 조작반을 조작한다. 생산되어 나오는 제품의 품질상태 및 진행사항을 관찰하고 이상 시 조치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"스프링제본기조작원","connectJob":"스프링원링조작원, 스프링트윈링조작원, 천공기조작원, 디지털제책기조작원","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001254:1', '{"dJobCd":"K000001254","dJobCdSeq":"1","dJobNm":"실크인쇄원","workSum":"플라스틱 제품에 회사명, 제품명 등을 인쇄하기 위하여 실크인쇄틀을 교정한 후 인쇄기를 조작·관리한다.","doWork":"성형이 완료된 제품을 작업장소로 운반한다. 인쇄에 필요한 잉크 및 실크인쇄틀을 준비하고 제품에 실크인쇄판을 위치시킨다. 실크인쇄판에 잉크를 도포하고 고무롤러로 왕복하여 민다. 인쇄된 부위를 일정 시간 건조시킨다. 제조된 제품이 작업지시서와 동일한지 확인하고 외관상의 결함을 검사한다. 이상이 없을 때 후공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006697:1', '{"dJobCd":"K000006697","dJobCdSeq":"1","dJobNm":"오프셋인쇄기조작원","workSum":"문자, 그림, 표 등을 책자, 신문, 상업인쇄물, 포장인쇄물과 같은 인쇄물로 제작하기 위하여 오프셋인쇄기를 조작한다.","doWork":"인쇄판을 인쇄기의 실린더에 걸고, 배합잉크를 잉크통에 투입한다. 수동 휠을 돌려 판면과 롤러의 접촉도를 롤러 게이지로 조절하여 맞춘다. 급지 상태를 확인하고, 인쇄기의 스위치를 넣어 가동한다. 인쇄가 진행되는 상태나 인쇄잉크의 농도, 인쇄물의 품질 등을 확인·조정한다. 롤 상태의 종이를 릴에 걸어서 고속인쇄를 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"오프셋윤전기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004252:1', '{"dJobCd":"K000004252","dJobCdSeq":"1","dJobNm":"와이어포밍기조작원","workSum":"철선을 이용하여 인쇄물을 수첩, 노트 및 책 등의 형태로 제책할 때 사용하는 스프링을 제조하는 와이어포밍기를 조작한다.","doWork":"생산의뢰서의 주문사항 및 스프링제책반장의 지시사항을 숙지한다. 설비를 점검하고 철선의 코팅상태 등을 확인한다. 주문서에 따라 원하는 규격의 스프링 지름을 제조하기 위하여 와이어포밍기의 조정판을 조작한다. 철선을 원료 투입구에 걸어주고 가공라인에 연결한다. 시운전을 통하여 철선의 코팅상태, 지름 등이 정확히 일치하는지 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","similarNm":"스프링가공기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003312:1', '{"dJobCd":"K000003312","dJobCdSeq":"1","dJobNm":"유리인쇄장식원","workSum":"성형이 완료된 유리기물에 상표, 상품명 및 도안을 인쇄하기 위하여 인쇄장치를 운전, 조작한다.","doWork":"작업지시서에 따라 인쇄로 장식할 유리종류 및 형태, 규격, 도안을 확인한다. 도안스크린, 안료, 오일 등의 원료를 준비하고 인쇄기의 작동을 점검한다. 인쇄할 도안의 스크린을 인쇄기에 부착한다. 작업표준에 따라 안료에 점성을 주기 위하여 스퀴즈 오일(Squeeze Oil)을 혼합하여 규정 점도로 혼합한 후 인쇄기에 주입한다. 인쇄기의 고무롤러 중심을 유리성형물의 인쇄할 부분에 맞춘다. 인쇄기에 연결된 컨베이어를 가동시켜 성형물의 투입속도를 조절한다. 인쇄기의 가동 스위치를 넣어 작업을 시작하고 인쇄되어 나오는 상태를 육안으로 확인한다. 완성된 인쇄장식의 형태를 작업지시서와 비교·점검한다. 작업이 완료된 유리를 지정된 적재판에 쌓고, 인쇄한 수량을 파악하여 작업표에 기재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C231","dJobICdNm":"[C231]유리 및 유리제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002906:1', '{"dJobCd":"K000002906","dJobCdSeq":"1","dJobNm":"은사제조원","workSum":"위·변조 지폐를 방지하기 위하여 사용되는 지류에 들어가는 은선을 제조하기 위하여 나일론사를 투입·염색하는 설비를 조작한다.","doWork":"나일론사(염칙실)를 일정 모양으로 재단이 용이하도록 선별된 크라프트지로 포장·적재한다. 재단칼날의 열에 의하여 녹지 않도록 정확히 조정하여 재단한다. 염색조에 나일론사, 형광염료, 기타 조제약품을 투입한다. 작업표준에 맞도록 염색설비를 조작하여 염색한다. 염색된 나일론사가 균일하게 염색되었는지 자외선램프를 이용하여 확인한다. 이상이 없는 제품은 세척·건조한다. 지폐용 지료(紙料:종이를 만들기 위해 펄프와 기타 여러 가지 약품들이 혼합한 원료)의 혼합 일회량을 기준으로 무게를 평량(Basis-Weight:종이의 단위면적당 무게를 나타내는 종이의 기본 무게 호칭)하고 이를 관련 부서에 인계한다. 은사의 발광 상태를 관련 부서에 확인한다. 사용한 재단칼날은 연마하여 습기가 없는 곳에 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005332:1', '{"dJobCd":"K000005332","dJobCdSeq":"1","dJobNm":"인쇄교정기조작원","workSum":"인쇄의 여부를 최종 결정하기 위해 소부된 인쇄판을 시쇄(試刷)하여 확인하는 교정기를 조작한다.","doWork":"교정 인쇄할 판을 접수하고 대장에 기재한다. 교정기에 소부판을 끼우고 세척한다. 인쇄판이 끼워진 교정기의 롤러에 주걱으로 잉크를 묻힌다. 유도장치를 조작하여 인쇄종이가 인쇄할 위치에 들어오면 상태를 확인한다. 교정기를 가동하여 시쇄(試刷)하고, 인쇄물을 확대경을 사용하여 인쇄상태를 확인한다. 교정쇄를 포장하여 편집자 또는 주문처로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"교정기조작원, 오프셋교정기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001462:1', '{"dJobCd":"K000001462","dJobCdSeq":"1","dJobNm":"인쇄기조작원(무늬롤)","workSum":"플라스틱 필름이나 시트 등에 다양한 무늬와 색깔을 인쇄 또는 압착하는 장비를 조작·관리한다.","doWork":"작업지시서에 따라 호이스트를 사용하여 인쇄할 모양의 무늬롤을 인쇄기의 샤프트에 걸어 끼운다. 무늬롤과 잉크, 주걱칼의 간격을 조절한다. 인쇄할 필름이나 시트를 호이스트 등을 사용하여 샤프트의 받침대에 걸어 놓는다. 스팀밸브를 열어 압력게이지를 확인하여 인쇄기 오븐의 온도를 일정하게 유지한다. 잉크 및 광택제를 작업지시서에 지시된 혼합비율로 혼합하여 인쇄기의 잉크 받침통에 붓는다. 작동버튼을 눌러 롤을 회전시킨다. 인쇄할 시트 또는 필름의 끝에 끈을 붙여 무늬롤의 밑 부분으로부터 상부가이드 롤을 거쳐 건조오븐 안으로 끈을 당겨 권취기에 감는다. 하부에 설치된 고무롤에 잉크가 묻지 않도록 용제가 묻은 걸레를 사용하여 고무롤을 수시로 닦는다. 건조오븐을 통하여 권취되는 제품의 색상, 무늬 등을 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"문압기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006073:1', '{"dJobCd":"K000006073","dJobCdSeq":"1","dJobNm":"인쇄물재단기조작원","workSum":"인쇄가 완료된 인쇄물을 재단기를 이용하여 제본규격에 맞게 재단한다.","doWork":"작업지시서의 재단규격에 대한 내용을 확인한다. 인쇄물의 재단 폭 및 깊이를 맞추기 위하여 재단기의 절단가이드, 칼날 등을 조절한다. 재단보조원에 의해 추려진 인쇄물 또는 제책된 인쇄물을 재단기의 적재대에 올려놓는다. 적재 인쇄물의 가장자리를 정렬시켜 재단할 면을 절단한다. 절단된 인쇄물의 절단면 결함을 조사하고 수정한다. 재단된 인쇄물을 적재대 위에 일정 수량씩 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"자동재단기조작원, 합지재단사, 전지재단기조작원, 삼면재단기조작원, 디지털재단기조작원","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005900:1', '{"dJobCd":"K000005900","dJobCdSeq":"1","dJobNm":"인쇄잉크배합원","workSum":"원하는 색상, 문양 등을 인쇄물에 재현하고 인쇄의 질을 향상시키기 위하여 인쇄잉크와 용제를 배합하여 조색한다.","doWork":"생산계획에 따른 작업지시 사항을 확인한다. 주문사양에 맞게 배합하기 위하여 잉크 및 용제 등을 준비한다. 인쇄잉크 및 용제 등을 배합통에 투입하고 주문사양에 맞도록 적당한 점도와 색상 등을 고려하여 배합한다. 잉크 배합비율 표와 경험을 기초로 잉크와 잉크 또는 용제를 배합하여 다양한 채도와 농도의 잉크색을 만든다. 배합된 잉크를 이송펌프를 가동하여 인쇄 기계의 잉크통이나 인쇄롤러에 투입한다. 시험인쇄를 통하여 주문사양에 맞게 잉크배합이 이루어졌는지 확인하고 조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|다습|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"정밀작업","similarNm":"조색원","connectJob":"벽지조색원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003115:1', '{"dJobCd":"K000003115","dJobCdSeq":"1","dJobNm":"장합기조작원","workSum":"한 책 분의 쪽수가 순서대로 이어가도록 접지된 각 접장(摺張)들을 겹쳐 모으는 장합(張合:정합)기를 조작한다.","doWork":"접지된 인쇄물을 삽지부에 제책 페이지 순서에 맞추어 적재하도록 장합보조원에게 지시한다. 적재한 접지 인쇄물의 두께에 맞추어 오리발(취족)의 감지장치를 조절한다. 공기흡출 장치와 체인의 상태를 확인하고 기계가동 스위치를 조작한다. 접지인쇄물이 취합되어 중철기계로 이동되는 과정을 관찰한다. 정합된 인쇄물의 견본을 뽑아 페이지 배열과 취합이 정확한지 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"디지털장합기","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003631:1', '{"dJobCd":"K000003631","dJobCdSeq":"1","dJobNm":"전사기조작원","workSum":"문자, 문양 등을 인쇄한 전사지(轉寫紙:Transfer-paper)로 도자기, 천, 플라스틱, 금속과 같은 피인쇄체에 인쇄하는 전사기를 조작한다.","doWork":"작업표에 따라서 전사지 두루마리를 선택하여 릴에 놓는다. 기계에 있는 삽지가이드를 통하여 배출판 위로 전사지를 빠져나가게 한다. 기계의 전사다리미를 가열하기 위하여 규정된 온도로 조절한다. 컨베이어 벨트의 삽지가이드를 조절하는 스크루를 돌린다. 가이드의 맞은편에 있는 컨베이어 벨트에 물품을 놓거나 전사다리미 아래에 있는 기계의 베드 위에 물품을 놓는다. 인쇄된 자료나 도안을 물품 위에 전사하기 위하여 가열된 다리미를 낮추는 버튼을 누른다. 규격과의 차이점을 찾아내고 필요할 때에 삽지가이드를 조정하기 위하여 물품을 검토한다. 끈을 사용하여 지시된 수의 물품을 꾸러미로 묶기도 한다. 사포를 사용하여 전사다리미의 표면을 깨끗이 닦아내기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"전사다리미조작원","connectJob":"요판전사기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002807:1', '{"dJobCd":"K000002807","dJobCdSeq":"1","dJobNm":"점역도서인쇄원","workSum":"점자로 번역된 점역문서를 인쇄·제책·발송한다.","doWork":"점역사가 송부한 컴퓨터 파일의 문자, 그림, 수식 등을 확인하여 관련 컴퓨터로 읽어 들인다. 프린터 용지를 프린터에 공급하고 점자에 손상이 가지 않도록 인쇄장치를 조정한다. 인쇄 과정의 원활한 진행을 모니터링한다. 출력된 인쇄물을 정리하여 제본한다. 제책된 점역도서를 발송처로 발송한다. 프린터기 등을 청소·유지·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002319:1', '{"dJobCd":"K000002319","dJobCdSeq":"1","dJobNm":"점자인쇄기조작원","workSum":"점자로 번역된 문서를 대량으로 인쇄하기 위하여 제판하고 인쇄한다.","doWork":"점역된 문서를 점자제판기를 조작하여 알루미늄판에 새긴다. 제판된 알루미늄판을 점자교정사에게 의뢰하여 교정을 받는다. 판을 점자인쇄기에 건다. 인쇄매수 등을 고려하여 점자인쇄기 내에 장치를 설정한다. 점자인쇄기를 작동하고 인쇄과정을 모니터링한다. 인쇄 후 인쇄물을 정리하고 제책한다. 점자제판기나 인쇄기를 청소·유지·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003559:1', '{"dJobCd":"K000003559","dJobCdSeq":"1","dJobNm":"접지기조작원","workSum":"재단된 인쇄물을 페이지 순서로 접어주기 위하여 접지기를 조작한다.","doWork":"작업지시서에 따른 접지 종류 및 고려사항 등의 작업내용을 확인한다. 접지기계 및 종이흡입기, 종이누름기 등의 부속기계가 정상적으로 작동되는지 점검한다. 한 장의 인쇄물을 몇 번 접어주는 수에 맞추어 접지기의 접지부의 롤러수를 조정한다. 접지할 인쇄용지의 두께에 맞추어 맞물림 롤러를 조작한다. 접지기를 가동시켜 인쇄물의 투입상태 및 접지상태를 관찰하고 불량하면 재조정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"디지털접지기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001358:1', '{"dJobCd":"K000001358","dJobCdSeq":"1","dJobNm":"제책반장","workSum":"한 권의 책을 만들기 위한 제책 관련 종업원의 활동을 감독·조정한다.","doWork":"작업할 내용을 작업원에게 지시한다. 재단기, 접지기, 정합기 등 제책하기 위한 제반 설비를 관리한다. 원활한 작업진행을 위하여 작업원의 활동을 관리·감독하고 작업 원을배치한다. 재단된 상태를 확인·점검한다. 작업에 필요한 원·부자재를 주문 의뢰한다. 제책(성책)물을 확인하고 작업내용을 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","similarNm":"성책기장, 제본기장","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004279:1', '{"dJobCd":"K000004279","dJobCdSeq":"1","dJobNm":"제책원","workSum":"봉책된 내지를 책 형태로 제책하기 위하여 압축기, 띠 부착기계, 케이스삽입기계 등을 조작한다.","doWork":"내지 규격에 맞는 케이스(표지)를 적재대에 쌓는다. 세양사(책의 속장과 표지를 접착시키는 힘받이로 쓰이는 가재모양의 재료)를 띠부착기계에 걸어준다. 아교, 풀 등의 접착제를 통에 넣는다. 책 규격과 두께에 따라 적재대 높이, 내지 투입구의 폭, 동 체인의 폭, 책등압축기의 폭 등을 적절하게 조절한다. 기계 가동스위치를 조작하여 제책한다. 제책된 책자의 상태를 확인·점검한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"수동조작","similarNm":"제본원","connectJob":"무선철원, 반양장원, 양장원, 중철원, 호부장원","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001816:1', '{"dJobCd":"K000001816","dJobCdSeq":"1","dJobNm":"직물상표표시원","workSum":"천의 뒷면에 상품명을 인쇄하는 기계를 조작한다.","doWork":"천의 유형에 따라 지시된 비율로 혼합통에 인쇄용 잉크와 물을 붓는다. 혼합통과 픽업롤러(Pick-up Roller)의 밑에 있는 물통 사이에서 잉크를 순환시키는 펌프를 가동한다. 기계 앞에 천을 실은 수레를 놓고 인쇄용 롤러 위에 있는 천 이송용 롤러의 시동을 건다. 천에 잉크의 침투상태를 알아보기 위해 천을 검사한다. 직물에 칠해지는 잉크의 양을 조절하는 압력롤러를 조정하기 위해 핸들을 돌린다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"스탬프원","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004968:1', '{"dJobCd":"K000004968","dJobCdSeq":"1","dJobNm":"코팅기조작원","workSum":"비닐, 합성수지(PVC) 등의 각종 도포용 필름을 이용하여 인쇄물의 표면에 표면광택, 잉크변색방지 및 방습 등의 효과를 내기 위하여 가공하는 코팅기를 조작한다.","doWork":"생산계획에 따라 인쇄물에 도포할 작업내용을 숙지한다. 작업표준에 따라 폴리프로필렌 등과 같은 각종 도포용 필름과 인쇄물을 준비한다. 인쇄물의 크기와 같은 규격의 필름을 선별하여 급지대에 걸거나 호퍼(Hopper:분립체의 저장 및 공급장치)에 폴리프로필렌을 투입한다. 작업지시서에 맞추어 가열 롤러의 온도를 조절한다. 기계 가동스위치를 조작하고 인쇄물에 도포용 필름이 코팅되는 작업진행 과정을 관찰하고 도포된 필름의 외관·표면 상태 등을 점검한다. 자동 코팅기를 사용하는 경우 디지털인쇄기에 코팅기를 연결하여 컴퓨터조작으로 코팅기를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","connectJob":"건식코팅기조작원, 습식코팅기조작원, 라미네이팅기조작원, 라미넥스기조작원, UV코팅기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003096:1', '{"dJobCd":"K000003096","dJobCdSeq":"1","dJobNm":"특수인쇄기조작원","workSum":"은행권, 여권, 증권 및 채권 등 각종 특수 인쇄물을 인쇄하기 위하여 특수 인쇄기를 조작한다.","doWork":"작업지시에 의하여 인쇄판, 잉크, 용지 및 견본을 준비한다. 용지를 정돈하여 투입구에 적치한다. 판통실린더에 인쇄판을 건다. 잉크덕트를 조립한 후 적정 위치에 잉크칸막이를 설치한다. 패널을 조작하여 인쇄한다. 인쇄위치, 혼색, 얼룩 등을 확인한 후 색 맞춤을 위하여 인쇄한다. 인쇄된 인쇄물의 교정이 완료되면 기계를 정상 가동한다. 수시로 인쇄상태를 교정하고 인쇄된 제품은 계수하여 일정 단위로 적재한다. 작업이 완료되면 잉크장치를 분리하여 잔여 잉크를 제거하고 인쇄판을 세척하여 관련 부서에 반납한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"요판인쇄기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004412:1', '{"dJobCd":"K000004412","dJobCdSeq":"1","dJobNm":"표지제조원","workSum":"앨범, 양장책자, 바인더 등의 제책에 사용할 두껍게 가공된 표지(Hard Cover)를 제조한다.","doWork":"표지를 두껍게 하여 내장품을 보호하기 위하여 같은 규격으로 재단된 판지를 합지한다. 표지를 제책할 원단에 접착제를 도포하기 위하여 표지기를 조작한다. 표지원단과 합지 사이에 패드(Pad)를 삽입한다. 접착제가 도포된 원단으로 합지를 제책·압착하기 위하여 제책기를 조작한다. 제책된 표지의 외형을 완성하고 합지나 패드가 빠지는 것을 방지하기 위하여 표지의 원단 사각을 안으로 접어주는 사면접지기를 조작한다. 사각이 접힌 표지 안쪽에 면지기를 이용하여 배면지를 부착한다. 완성된 표지의 면을 둥글고 고르게 하기 위하여 인두 작업을 한다. 완성된 표지의 품질과 수량을 검사한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"배면지부착원, 인두작업원, 패드삽입원, 표지기조작원","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004942:1', '{"dJobCd":"K000004942","dJobCdSeq":"1","dJobNm":"표지합지원","workSum":"한 권의 책으로 완성하기 위하여 성책된 인쇄물과 표지를 합지하는 기계를 조작한다.","doWork":"표지와 인쇄물을 합지하기 위한 작업내용을 숙지한다. 합지할 규격에 맞게 정확히 인쇄물과 표지가 접합될 수 있도록 합지기를 조정한다. 접착제의 농도를 맞춘다. 접착제, 인쇄물과 표지를 투입부 및 풀통에 투입하도록 표지합지보조원에게 지시한다. 기계를 가동하여 표지를 합지하고 진행사항을 관찰한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"표지발이","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001819:1', '{"dJobCd":"K000001819","dJobCdSeq":"1","dJobNm":"플렉소인쇄기조작원","workSum":"플렉소 인쇄기를 조작하여 각종 인쇄물을 인쇄한다.","doWork":"작업지시서에 의해 견본에 맞는 고무 볼록판 또는 수지를 준비한다. 플렉소 인쇄기의 각 부위(잉크 냄 롤러, 아닐록스 롤러(Anilox Roller), 판통 및 압통)를 점검한다. 인쇄에 사용할 잉크를 준비한다. 골파지, 쇼핑백, 종이상자, 포장재료 라벨 등 인쇄물에 따라 준비된 제판을 인쇄기에 걸고 인쇄한다. 인쇄물의 상태를 확인하고 기계를 가동시킨다. 인쇄가 완료된 인쇄기를 청소·유지·보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","certLic":"인쇄기능사, 인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002822:1', '{"dJobCd":"K000002822","dJobCdSeq":"1","dJobNm":"활판인쇄기조작원","workSum":"주조된 활자체를 인쇄용 판으로 만들어 인쇄하는 인쇄기를 조작한다.","doWork":"작업지시서에 의하여 활자를 인쇄용 판에 끼워 제작한다. 용지를 정돈하여 적치대에 적치한다. 인쇄용 판을 인쇄기에 인쇄할 위치에 맞추어 상ㆍ하 실린더에 거치한다. 잉크통에 활판잉크를 투입한다. 인쇄하여 인쇄물의 이상여부를 확인하고 교정한다. 인쇄기를 정상 가동하고, 수시로 인쇄상태를 확인한다. 작업이 완료되면 잉크장치를 분리하여 잔여잉크를 제거하고 인쇄판을 세척하여 관련 부서에 반납한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"10년 초과","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","certLic":"인쇄산업기사","dJobECd":"8811","dJobECdNm":"[8811]인쇄기계 조작원","dJobJCd":"8921","dJobJCdNm":"[8921]인쇄기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"1999"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005909:1', '{"dJobCd":"K000005909","dJobCdSeq":"1","dJobNm":"사진리터처","workSum":"아날로그 방식에서의 사진인화와 디지털 방식에서의 이미지-리터칭을 활용하고 디지털 출력기를 사용해서 사진을 출력한다.","doWork":"다양한 매체에 적합한 사진적 표현방법을 모색한다. 사진촬영에 필요한 장비를 선정하고 사진을 촬영한다. 그래픽 툴을 이용하여 사용 목적에 맞게 촬영된 사진을 보정한다. 사진의 목적에 따라 이미지 합성, 확대 및 축소, 회전 등의 적절한 디지털기법을 사용해서 사진처리 작업을 하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006222:1', '{"dJobCd":"K000006222","dJobCdSeq":"1","dJobNm":"사진인화현상원","workSum":"필름을 현상하고 밀착인화기를 사용하여 사진을 인화한다.","doWork":"화학약품을 희석하여 정착액과 현상액을 준비한다. 필름의 보관상태를 점검하고 현상액의 온도를 조절한다. 필름을 현상액에 넣고 일정 시간이 경과되면 필름을 세척하여 정착액에 담근다. 일정 시간이 경과되면 필름을 세척하고 건조한다. 현상할 사진의 크기에 따라 인화지를 선택한다. 밀착인화기 위에 필름과 인화지를 끼워 넣는다. 인화기의 광원스위치를 넣고 일정 시간 동안 노출시킨다. 노광된 인화지를 정착액에 담궈 상을 정착시킨다. 일정 시간이 경과되면 인화지를 물로 세척하고 건조시킨다. 현상된 필름의 결함을 찾아내고 수정할 부분을 교정한다. 사진의 가장자리를 규격에 맞게 절단한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005475:1', '{"dJobCd":"K000005475","dJobCdSeq":"1","dJobNm":"사진제판원","workSum":"문자, 사진 등 원고용 필름을 인쇄규격에 맞추어 재단·배열하여 제판용 필름으로 현상한다.","doWork":"인쇄할 원고 및 필름도안을 준비하고 제작할 제판의 내용과 비교하여 동일하게 규격, 색상, 문안내용을 확인한다. 필름이 아닌 반사원고는 촬영하여 원고용 필름으로 제작한다. 제판실 내 및 약품의 온도를 조절한다. 확인된 필름을 색상별로 한 매씩 복사한다. 배열 수대로 규격에 맞추어 필름을 재단한다. 제판용 아스테이지에 인쇄규격에 맞추어 필름을 배열한다. 대·소절로 색분판된 필름을 밀착기에 넣고 촬영할 사진의 확대, 축소, 노출시간 등 각각의 비율에 따라 밀착기를 조절한다. 인쇄할 제품의 색도의 수만큼 원판과 감광재료를 밀착시켜 촬영한다. 밀착된 필름을 현상·수세·건조한다. 색상별로 구분하여 배열 수대로 견본과 비교하면서 식판한다. 연마된 판에 감광액을 도포하고, 식판된 필름을 감광액이 도포된 판에 놓고 노출을 시킨다. 노출이 완료된 후 견본과 대조하여 불필요한 부분을 수정하고 건조한다. 내쇄력을 강화시키기 위해 락카로 처리하고 건조 후 보호용 잉크를 바른다. 탈막처리 후 고무를 바르고 최종검사를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","connectJob":"대절원, 밀착원, 소절원","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005494:1', '{"dJobCd":"K000005494","dJobCdSeq":"1","dJobNm":"슬라이드제작원","workSum":"현상이 완료된 필름을 절단하고 플라스틱이나 종이틀에 끼워 슬라이드를 제작한다.","doWork":"현상된 필름의 선명도를 점검하여 슬라이드용 필름을 선별한다. 절단기를 사용하여 일정한 크기로 절단하고 플라스틱이나 종이틀에 끼워 넣고 마운팅프레스(필름과 틀을 접착시키는 장치)에 넣어 마운팅한다. 틀과 필름의 접착상태를 확인하고 불량인 제품을 분류한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004216:1', '{"dJobCd":"K000004216","dJobCdSeq":"1","dJobNm":"영화필름인화원","workSum":"영화 필름을 인화하기 위하여 인화기를 조작한다.","doWork":"인화준비가 완료된 영화 필름을 인수하여 검사한다. 인화실에서 16밀리 또는 35밀리 밀착인화기를 조작하여 16밀리 또는 35밀리 필름으로 인화한다. 스크래치 등 필름의 상태가 불량한 경우 이를 보정할 수 있는 웨트인화기로 필름을 인화한다. 아날로그 방식인 경우 특수효과인화기를 조작하여 오버랩, 페이크아웃, 타이틀 자막 등 옵티컬 관련 필름특수효과 작업을 수행하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003054:1', '{"dJobCd":"K000003054","dJobCdSeq":"1","dJobNm":"영화필름현상원","workSum":"촬영된 영화필름을 현상하기 위해 현상기를 조작한다.","doWork":"16밀리 또는 35밀리 네거컬러현상기 및 포지컬러현상기 등 현상기를 점검 및 청소하고 약품(현상액)을 확인한다. 테스트필름을 장착하여 현상기에 문제가 없는지 점검한다. 약품의 온도를 확인한다. 암실에서 네거 및 포지필름을 점검하고 메거진(필름장착기계)에 필름을 장착한다. 네거 및 포지현상기에 메거진을 장착하여 현상기를 조작하고, 필름을 현상한다. 현상된 필름을 색보정원에게 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004456:1', '{"dJobCd":"K000004456","dJobCdSeq":"1","dJobNm":"원색분해기조작원","workSum":"사진 및 그림을 그대로 떠내어 제판용 필름이나 인쇄물로 출력하기 위하여 원색분해기를 조작한다.","doWork":"원고 및 슬라이드의 상태를 확인하고 편집자가 요구하는 규격과 색상에 따라 필요한 선의 수를 결정한다. 자판을 이용하여 스캐너(Scanner)에 입력한다. 필름을 실린더에 테이프로 고정한다. 실린더를 스캐너에 끼운다. 기본색상의 농도, 확대, 축소, 비율, 모양 등을 스캐너의 다이얼이나 자판을 이용하여 입력하거나 조절한다. 일정 시간 스캐너를 가동하여 색 분해된 자료를 컴퓨터에 데이터로 입력한다. 인화된 사진을 확인하여 수정할 내용을 결정하고, 색 분해가 잘못된 부분은 모니터의 화면을 보고 수정한다. 색 분해가 완성되면 출력기를 이용하여 제판용 필름을 현상한다. 수정이 불필요한 부분에 붓으로 보호제를 칠하거나 네거티브필름의 홈 또는 핀홀을 정교한 붓을 이용하여 수정액으로 제거하기도 한다. 확대경을 사용하여 점의 분포도를 확인하고 수정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"스캐너조작원","certLic":"인쇄기능사","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"C181","dJobICdNm":"[C181]인쇄 및 인쇄관련 산업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005013:1', '{"dJobCd":"K000005013","dJobCdSeq":"1","dJobNm":"자동인화현상기조작원","workSum":"필름을 현상하여 사진을 인화하기 위하여 자동현상기를 조작·관리한다.","doWork":"자동현상기에 투입된 화학약품의 유량을 확인하고 인화지의 잔여량을 확인한다. 확대기 렌즈 및 전구의 작동 상태를 확인하고 절단칼날의 마모상태를 점검한다. 필름보관통의 입구에 걸쇠를 넣고 촬영한 필름의 끝부분을 기계의 투입구에 걸고 가스스위치를 조작한다. 자동현상기의 가동상태를 확인하고 현상된 필름을 점검한다. 현상된 필름의 상을 확인하여 고객의 요구에 따라 인화할 사진의 수량을 조절판에 입력하고 광학렌즈에 노출시킨다. 인화된 사진의 상을 확인하고 사진의 크기에 따라 분류한다. 사진의 종류와 수량에 따라 분류한다. 사진의 종류와 수량에 따라 가격을 계산하고 포장지에 넣어 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001667:1', '{"dJobCd":"K000001667","dJobCdSeq":"1","dJobNm":"필름현상반장","workSum":"촬영한 영상필름을 현상하는 업무에 종사하는 작업원들의 활동을 감독·조정한다.","doWork":"촬영한 영상필름을 수령하여 촬영 당시의 날씨, 조도 등을 검토한다. 현상약의 혼합비율을 검토하고 필름현상기의 조작상태를 검사한다. 작업의 진행사항을 파악하고 작업내용을 보고한다. 작업원의 작업상황을 관리·감독하고 기술적인 지원 및 자재를 공급한다. 작업계획에 따라 세부실행항목을 수립하고 작업절차 및 방법을 결정하여 작업원에게 작업내용을 지시하고 작업배치를 한다. 표준작업명세에 따라 지시된 작업이 이루어지는지 작업원과 함께 작업하며 작업상황을 관찰하고 작업내용을 점검한다. 작업원의 직무교육 및 안전위생교육을 통하여 직무수행능력을 향상시키고 안전재해를 예방한다. 수시면담과 관찰을 통하여 작업원의 애로점 및 건의사항을 수렴·해결하고 문제점을 보완한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"J591/M733","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업 / [M733]사진 촬영 및 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001985:1', '{"dJobCd":"K000001985","dJobCdSeq":"1","dJobNm":"필름현상액조약원","workSum":"영화 필름 현상에 사용되는 현상액을 분석하고 조제한다.","doWork":"필름 현상에 사용되는 각종 화학약품을 실험기구를 사용하여 조제한다. 사용된 현상액을 채취, 분석하여 약품의 오염여부를 확인한다. 조제된 현상액 성분을 분석하여 약품의 규정된 사양을 충족하는지 검사한다. 조제된 현상액을 물에 희석시켜 농도를 조절한다. 필요시화약약품을 보충하거나 교체한다.","optionJobInfo":{"eduLevel":"14년 초과 ~ 16년 이하(대졸 정도)","skillYear":"2년 초과 ~ 4년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"조작운전","similarNm":"-","connectJob":"-","certLic":"-","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"J591","dJobICdNm":"[J591]영화, 비디오물, 방송프로그램 제작 및 배급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003567:1', '{"dJobCd":"K000003567","dJobCdSeq":"1","dJobNm":"필름현상원","workSum":"필름을 현상하기 위하여 고속의 필름현상기를 조작한다.","doWork":"현상기에 일정량의 화학약품을 투입하고 조작판을 조작하여 혼합비율을 입력한다. 암통(필름포장재)을 고속현상기의 걸쇠에 걸고 필름의 끝을 현상기의 리더(현상기 내의 안내장치)에 연결한다. 걸쇠를 현상기에 투입하고 뚜껑을 닫는다. 현상기를 가동하고 가동상태를 관찰한다. 수시로 현상된 필름을 검사하여 선명도를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|고온|","workFunc1":"비교","workFunc2":"서비스제공","workFunc3":"조작운전","dJobECd":"8812","dJobECdNm":"[8812]사진 인화·현상기 조작원(사진수정 포함)","dJobJCd":"8922","dJobJCdNm":"[8922]사진 인화 및 현상기 조작원","dJobICd":"M733","dJobICdNm":"[M733]사진 촬영 및 처리업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006735:1', '{"dJobCd":"K000006735","dJobCdSeq":"1","dJobNm":"계면활성제포장원","workSum":"각종 계면활성제를 담기 위해 규격에 맞는 드럼이나 포대, 용기에 충전 후 봉합한다.","doWork":"작업지시서의 내용에 따라서 출하할 제품을 확인하고, 다양한 계면활성제 제품 중에서 출하를 할 제품과 충전할 제품이 동일한지 확인한다. 폴리프로필렌 지대를 저울에 올려놓고 영점을 맞춘다. 저울의 눈금을 확인하면서 정해진 포장단위에 따라 계량하여 충전한다. 충전이 완료되면 폴리프로필렌 지대의 입구를 봉합기에 대고 봉합한다. 드럼이나 용기의 경우 드럼, 용기 안에 폴리프로필렌을 넣고 충전한 후 뚜껑을 닫아 봉합한다. 포장이 완료되면 포장용기 중앙에 제품명, 중량, 상호, 제품번호 등을 표시하여 적재함에 적재한다. 출고 시 유해화학물질 스티커를 스프레이 본드를 이용하여 부착한다. 포장된 제품의 수량을 확인하고 작업일지에 기록한다. 포장된 수량을 입·출고 담당자에게 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"제품충전원","certLic":"위험물기능사","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005647:1', '{"dJobCd":"K000005647","dJobCdSeq":"1","dJobNm":"고철압축원","workSum":"고철을 적당한 크기로 압축시키는 압축기를 조작한다.","doWork":"고철을 야적장에서 압축장으로 운반하도록 지게차운전원이나 기중기조종원에게 신호를 보낸다. 스위치를 조작하여 모터를 가동시켜 압축기를 작동한다. 장입도구를 사용하여 고철을 압축기 투입구에 장입한다. 덮개를 닫고 실린더를 작동시켜 고철을 압축한다. 압축실린더를 후퇴시키고 덮개를 열어 압축된 고철을 꺼낸다. 압축된 고철을 적재 장소로 운반하도록 지게차운전원에게 신호한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"제어조작","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C241","dJobICdNm":"[C241]1차 철강 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005071:1', '{"dJobCd":"K000005071","dJobCdSeq":"1","dJobNm":"공기압축기운전원","workSum":"착암기 등 압축공기를 사용하는 광산기계나 갱내에 신선한 공기를 공급하기 위하여 공기를 압축시키는 공기압축기를 운전한다.","doWork":"작업지시서나 광산기계반장의 지시에 따라 점검사항, 장비운전, 공기공급 등의 계획을 수립한다. 냉각구 분사상태, 윤활유·오일·전원·압력·냉각상태 등 점검일지에 명시된 사항을 확인·점검한다. 스위치를 올리거나 핸들을 조작하여 전기모터, 가솔린 및 디젤엔진을 구동시켜 공기를 압축한다. 압축기가 가동되면 가동저항기의 레버를 단계적으로 작동하여 압축공기의 양을 조절하고, 압축공기가 일정 압력이 되도록 유지한다. 압축된 공기를 필요로 하는 기계나 장소로 공급하기 위하여 공기흡입밸브를 열고 압력을 확인한다. 온도계와 압력계를 관찰하고 작업표준에 맞추어 조정한다. 엔진의 이상소음, 압축상태, 속도, 과열, 배기색, 진동, 밸브연결 등을 점검한다. 점검일지와 운전일지를 작성한다. 기기청소 및 공기압축실을 정리·정돈한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"컴프레서조작원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"F426","dJobICdNm":"[F426]건설장비 운영업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007226:1', '{"dJobCd":"K000007226","dJobCdSeq":"1","dJobNm":"기계포장원(일반)","workSum":"검사가 완료된 제품에 대한 포장을 위해 포장기계를 조작한다.","doWork":"포장기계를 작동하여 작동상태를 관찰하면서 기계의 이상 유무를 확인한다. 이상발생 시 작동을 중지하고 작동상태에 따라 정비원에게 정비를 요청하거나 상위책임자에게 보고한다. 포장할 제품의 무게에 따라 용기, 제품을 갈아 끼우는 등의 간단한 수리 및 조절을 한다. 작업지시서 및 표준에 따라서 상품이 포장되었는지 확인하기 위하여 포장이 완료된 용기를 검사한다. 포장용 원·부자재, 플라스틱 케이스, 박스, 마분지, 잉크, 라벨과 같은 재료의 과부족 상태를 확인하고 보충한다. 포장이 완료된 포장지에 인쇄기로 상품종류, 무게 등을 인쇄한다. 포장 완료된 제품 중 샘플을 채취하여 검사를 한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005257:1', '{"dJobCd":"K000005257","dJobCdSeq":"1","dJobNm":"낙농제품충전기조작원","workSum":"발효유, 우유 등의 액상낙농제품과 분유를 포장용기(종이팩, 플라스틱병, 비닐파우치, 캔)에 충전하는 기계를 조작한다.","doWork":"충전기의 각 부위를 점검하고 무균상태를 확인한다. 기계조정판에 충전할 내용물의 양, 온도, 속도 등을 입력한다. 숙성탱크에서 충전기를 통해 포장용기에 발효용액이 투입되는 상태를 점검한다. 발효용액이 용기에 담긴 후 뚜껑(Cap)으로 밀봉되는 상태를 확인한다. 컨베이어의 속도를 조절하여 충전속도의 균형을 유지한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"분유충전기조작원, 발효유충전기조작원, 우유충전기조작원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2016"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004356:1', '{"dJobCd":"K000004356","dJobCdSeq":"1","dJobNm":"낙인기조작원","workSum":"제작된 고무호스에 회사명, 품명, 상표 등을 인쇄하는 낙인기계를 조작한다.","doWork":"완성된 호스 제품을 낙인기 하판에 투입한 후 상판의 덮개를 덮는다. 롤러 등을 이용하여 호스 제품의 먼지를 제거한 후 특정한 인쇄판을 고정구에 조인다. 낙인될 호스를 공급하기 위하여 렌치를 사용하여 가이드와 공급롤러를 조절한다. 낙인을 하고자 하는 특정 색깔의 잉크로 공급탱크를 채우고 기계를 작동한다. 손이나 호이스트를 사용하여 호스를 테이블까지 들어 올리고 호스를 공급롤러로 보낸다. 명세서대로 낙인이 되어 있는지 확인하기 위하여 호스를 검사한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"인쇄기조작원, 프린팅기조작원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C221","dJobICdNm":"[C221]고무제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006930:1', '{"dJobCd":"K000006930","dJobCdSeq":"1","dJobNm":"농업드론방제사","workSum":"농작물 재배 시 발생할 수 있는 병충해 등을 방제하기 위하여 살포계획을 수립하고 살포장비를 점검하여 드론을 조종하며 논, 밭 등에 농약을 살포한다.","doWork":"방제 장비 운용절차 파악, 방제지역 특성파악, 방제지역 병충해 특성파악, 방제작업 피해 예상지역 파악, 살포면제에 따른 약제충전량 계산 등 살포계획을 수립한다. 살포장비의 가동여부, 살포약제 특성파악, 살포지역 특성, 이착륙 지역 파악 등 살포장비를 점검한다. 드론을 적정한 장소에 설치하고 조정기를 조정하여 약제를 살포한다. 살포과정을 모니터링하고 필요시 드론을 재조정한다. 방제 결과를 확인 평가한다. 드론 조종이 끝나면 드론을 회수하고 장비를 세척한다. 드론 및 조종기구에 이상이 없는지 점검한다. 필요시 드론을 수리 및 정비하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","certLic":"초경량비행장치조종자격","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2019"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001381:1', '{"dJobCd":"K000001381","dJobCdSeq":"1","dJobNm":"드론조종사","workSum":"드론을 조종하여 고공 영상이나 사진 촬영, 기사 정보 수집, 농약 살포 등의 업무를 수행한다.","doWork":"드론을 조종하기 전에 사용할 드론 또는 조종기구의 상태를 점검한다. 드론을 사용할 장소, 환경, 목적을 확인한다. 드론을 바닥에 놓고 작동시킨다. 드론을 정해진 목적에 따라 조종한다. 드론 조종이 끝나면 드론을 회수한다. 드론 및 조종기구에 이상이 없는지 점검한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내·외","workFunc1":"수집","workFunc2":"말하기신호","workFunc3":"제어조작","connectJob":"농업드론조종사","certLic":"초경량비행장치조종자격(1-4종)","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"P856","dJobICdNm":"[P856]기타 교육기관","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001425:1', '{"dJobCd":"K000001425","dJobCdSeq":"1","dJobNm":"라벨부착기조작원","workSum":"검사가 완료된 제품에 라벨을 부착하는 기계를 조작한다.","doWork":"라벨을 부착할 제품과 라벨이 일치하는지 확인한다. 라벨부착 기계에 라벨롤을 연결한다. 기계를 가동하고 자동이송장치의 작동과 라벨의 부착상태를 점검한다. 부착상태가 불량하면 기계를 다시 조절한다. 기계를 청소하고 낡거나 손상된 부품을 수리·교체한다. 라벨, 접착제의 사용량을 점검한다. 불량품을 분리하기도 하고 부착된 라벨을 제거하기 위해서 물이나 유기용제로 씻기도 한다. 인쇄기능이 있는 라벨부착기계를 사용하는 경우 기계의 제어판에 생산번호, 생산시간 등 인쇄할 내용을 입력하고 인쇄하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"라벨표시원, 상표부착기조작원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002199:1', '{"dJobCd":"K000002199","dJobCdSeq":"1","dJobNm":"라이터가스주입원","workSum":"라이터를 제조하기 위하여 가스탱크에 가스를 주입하는 가스주입기를 조작·관리한다.","doWork":"가스저장실의 가스 재고를 확인한다. 가스주입장치의 이상 여부와 가스주입기의 연결파이프를 점검한다. 조립된 가스탱크를 가스주입기 케이스 받침대에 연결한다. 기계를 가동시켜 받침대를 회전시키고 가스주입구에 일정 시간 멈추게 한다. 파이프를 통하여 액화상태의 가스를주입한다. 일회용 가스라이터 제조 시 주입된 가스가 새는 것을 방지하기 위해 케이스 위에 톱니를 박아 결합하기도한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"약간의 시범정도","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004078:1', '{"dJobCd":"K000004078","dJobCdSeq":"1","dJobNm":"라이터불꽃조정원","workSum":"라이터를 제조하기 위하여 라이터의 불꽃 높이와 가스량을 조정한다.","doWork":"가스가 주입된 케이스를 손으로 잡아 가스파이프에 댄다. 라이터의 조정체를 좌우로 돌리면서 치구를 사용하여 불꽃의 최대 높이와 최소 높이를 조절한다. 불꽃의 높이와 가스량이 적당한지 육안으로 검사한다. 검사가 완료되면 후공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|시각|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006865:1', '{"dJobCd":"K000006865","dJobCdSeq":"1","dJobNm":"마킹원","workSum":"종류 및 치수, 제조방법, 제조년월일, 제조자 등 제품을 알려주는 각종 사항을 표시(마킹)한다.","doWork":"작업지시서나 작업표준 및 요구사항을 파악한다. 마킹기에 잉크와 희석액을 채워 넣는다. 마킹하기 위하여 제품에 표시할 사항들을 마킹기의 제어판에 입력한다. 제품을 검사하여 마킹상태를 검사한다. 마킹기의 노즐이 막히거나 마킹상태가 불량한 경우 마킹을 중지하고 불량 원인을 해결한 후 재가동한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007240:1', '{"dJobCd":"K000007240","dJobCdSeq":"1","dJobNm":"매트리스포장원","workSum":"비닐접합 장치 및 자동 포장기를 이용하여 매트리스를 포장한다.","doWork":"롤 포장 비닐을 준비한다. 상면용 비닐롤을 자동포장기의 위쪽에 설치된 비닐공급롤러(Roller) 위에 올린 후 비닐이 처음 시작되는 부분을 롤러 밖으로 일정 간격 내려 자동포장을 준비한다. 컨베이어 벨트에 매트리스가 도착하면 코너보호대를 부착하여 포장기로 이송한다. 자동포장 장치에 매트리스를 삽입하여 포장하고 작업이 완료되면 포장상태를 검사하여 출고하거나 별도의 적재장소에 보관한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C320","dJobICdNm":"[C320]가구 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004969:1', '{"dJobCd":"K000004969","dJobCdSeq":"1","dJobNm":"박막트랜지스터봉지원","workSum":"액정이 주입된 셀 내부 주입구를 봉지제로 봉합하는 기기를 작동한다.","doWork":"클린 룸에 입장하기 위하여 방진복을 착용하고 에어샤워를 한다. 액정이 주입된 패널의 봉지 작업을 위해 이동시킨다. 봉지공정 기기(End Seal M/C)의 오퍼레이팅 파라미터에 가압조건, 강압조건, 침투시간, 노광시간 등을 입력한다. 액정 셀을 가압한 후 잉여 액정을 제거한다. 액정 셀을 감압 후 액정 주입구에 봉합 실란트(End Sealant)를 침투시킨 후 자외선램프로 경화시킨다. 일정 시간이 지난 후 검사를 위한 공정으로 이동시킨다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"TFT봉지원","certLic":"전기기능사, 화학분석기능사","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C262","dJobICdNm":"[C262]전자부품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001925:1', '{"dJobCd":"K000001925","dJobCdSeq":"1","dJobNm":"병검사원","workSum":"공병 검사장비를 사용하여 공병의 상태를 검사하고 불량품을 제거한다.","doWork":"공병 또는 페트병(PET)을 검사장비에 통과시킨다. 공병 및 페트병의 바닥, 내벽, 외벽, 병입구, 나사선, 잔수(병안에 남은 음료), 이물질 등의 검사를 수행한다. 결함이 있는 불량품을 폐기용 용기에 담는다. 정기적으로 검사장비를 점검하고 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"검병원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001835:1', '{"dJobCd":"K000001835","dJobCdSeq":"1","dJobNm":"봉제완구충전기조작원","workSum":"인형 등 봉제완구의 부속품에 충전물(아크릴 솜)을 투입하는 송풍기를 조작·관리한다.","doWork":"재봉이 끝난 완구의 트인 부분에 충전플러그를 삽입한다. 송풍기의 페달을 눌러 아크릴 솜을 불어 넣는다. 봉제완구의 모양이 제품 표준과 맞을 때까지 솜을 삽입한다. 어느 정도 모양이 만들어지면 저울을 사용하여 봉제완구의 중량을 측정한다. 모양이 잘 만들어지지 않으면 손으로 봉제완구의 속을 채우면서 모양을 조정하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"송풍원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C334","dJobICdNm":"[C334]인형, 장난감 및 오락용품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002569:1', '{"dJobCd":"K000002569","dJobCdSeq":"1","dJobNm":"봉합기조작원","workSum":"고압용기의 생산을 위해 원판의 상부와 하부를 가열하여 이음매가 없이 봉합하는 봉합기기를 조작한다.","doWork":"작업시방서에 따라 봉합할 제품을 확인한다. 봉합기의 작동 여부를 점검하고 확인한다. 시방서의 규격대로 성형된 원판을 봉합기 속에 넣는다. 봉합기를 작동시킨다. 원판을 성형하여 시방서의 규격대로 원관의 상·하를 봉합한다. 봉합된 제품을 꺼낸다. 봉합된 용기를 검사한 후 검사원의 검사를 받는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C251","dJobICdNm":"[C251]구조용 금속제품, 탱크 및 증기발생기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001952:1', '{"dJobCd":"K000001952","dJobCdSeq":"1","dJobNm":"부동액충전원","workSum":"배합조에서 이송된 부동액을 드럼이나 플라스틱용기에 충진하기 위하여 여과기 및 기타 충진장비를 조작·관리한다.","doWork":"품질검사부에서 합격판정을 받은 제품이 저장된 탱크를 호이스트나 리프트를 사용하여 운반한다. 작업지시서에 따라 중간검사를 거친 제품과 그렇지 않은 제품을 구분하고 중간검사를 받지 않은 제품은 제품에 따라 호스를 제품배관에 맞게 연결한 후 호스에 있는 밸브를 열고 펌프를 가동하여 여과기로 이송하여 여과한다. 여과가 완료된 부동액은 저장탱크에 보관한다. 제품배관에 맞게 충전호스를 연결하고 드럼통이나 플라스틱용기에 자동적으로 충전되는지 관찰한다. 드럼이나 플라스틱용기의 뚜껑을 닫고 적재한다. 작업일지에 제품번호와 작업물량을 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004854:1', '{"dJobCd":"K000004854","dJobCdSeq":"1","dJobNm":"비료코팅기조작원","workSum":"선별, 냉각 과정을 거친 비료 입자를 피복(Coating)하기 위해 비료코팅기를 조작·관리한다.","doWork":"선별공정을 거쳐 냉각기에서 공기로 냉각시킨 비료입자들을 최종 선별기에 투입해 작은 입자들을 제거한다. 선별된 비료입자들은 창고 저장 중 공기 중의 수분을 흡수하여 덩어리가 되거나 녹아나는 현상을 방지하기 위해 피복(Coating)을 하는 비료코팅기에 투입한다. 비료코팅기를 가동해 온도, 공기량, 코팅물, 중량 등의 조건을 설정한다. 코팅주입기를 사용하여 비료입자가 이동하는 동안 코팅물질을 주입한다. 작업이 종료되면 코팅기를 멈추고 코팅된 입자를 담기 위한 포대를 준비한다. 코팅기 및 관련 장치를 유지하고 보수한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"비료코팅원, 피복원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C203","dJobICdNm":"[C203]비료, 농약 및 살균, 살충제 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003614:1', '{"dJobCd":"K000003614","dJobCdSeq":"1","dJobNm":"비스킷포장원","workSum":"비스킷을 포장용지에 포장하고 박스에 담는다.","doWork":"비스킷이 홈을 통해서 이동하는 것을 모니터링한다. 모양이 흐트러졌을 경우 가지런히 정리한다. 손으로 포장용지 및 포장용기를 포장기에 투입한다. 낱개로 포장된 개별제품을 포장박스에 담는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C107","dJobICdNm":"[C107]기타 식품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004475:1', '{"dJobCd":"K000004475","dJobCdSeq":"1","dJobNm":"선별원","workSum":"선별기를 조작하여 제품을 선별하고 수량별로 박스에 적재한다.","doWork":"자동리프트를 사용하여 선별기에 제품을 투입한다. 자동선별기로 양품을 선별하고 수량별로 박스에 적재한다. 필요에 따라 육안으로 선별한다. 제품박스에 테이핑하거나 라벨을 부착한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002594:1', '{"dJobCd":"K000002594","dJobCdSeq":"1","dJobNm":"실린더충전원","workSum":"압축가스(상온에서 압축하여 액화하기 어려운 가스를 단지 상태변화 없이 압축한 가스), 액화가스(상온에서 압축하면 끓는 점이 다른 가스에 비해 높아 압력을 가하면 쉽게 액화되는 가스)를 압축기, 기화기 등을 이용하여 실린더에 충전한다.","doWork":"충전할 실린더 용기 내의 잔여물질 여부를 검사한 후 충전대상 용기들을 충전라인에 운반하여 체인으로 고정한다. 용기충전구에 충전용 바이스를 연결하고 실린더의 밸브를 연다. 압축기를 작동시키고 압력게이지 또는 저울눈금을 확인하면서 지시된 압력이나 무게까지 실린더에 가스를 충전한다. 밸브를 잠그고 실린더에서 충전호스를 분리한다. 비눗물이나 휴대용 가스 누출기를 사용하여 실린더 밸브의 가스 누출 여부를 검사한다. 순도계, 압력계를 사용하여 가스의 순도 및 압력의 양을 검사한다. 검증표에 지시된 중량, 압력, 가스의 종류 및 충전된 자료 등을 부착한다. 충전된 실린더를 시험분석실에 의뢰하고 불합격된 제품은 폐기하거나 가스를 완전히 제거하고 재충전하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"가벼운 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"산소가스충전원, 특수가스충전원, 알곤가스충전원, 질소가스충전원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"D352","dJobICdNm":"[D352]연료용 가스 제조 및 배관공급업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004806:1', '{"dJobCd":"K000004806","dJobCdSeq":"1","dJobNm":"아이스크림포장원","workSum":"카세트에 담겨진 아이스크림을 빼내서 포장박스에 담는다.","doWork":"카세트(콘형 또는 컵형 아이스크림 용기가 탑재되도록 일정간격으로 고정하는 지지프레임으로 이루어진 아이스크림 용기 탑재용 통)에 담겨진 아이스크림을 빼낸다. 아이스크림을 포장박스에 담는다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005516:1', '{"dJobCd":"K000005516","dJobCdSeq":"1","dJobNm":"안경제조반장","workSum":"안경을 제조하기 위하여 렌즈를 가공하고 안경테를 제작하는 작업원의 활동을 감독·조정한다.","doWork":"작업지시서에 따라 작업원을 배치한다. 렌즈가공 및 안경테 제조에 사용되는 연마기, 도금설비, 도장설비, 기타 보조공구 등의 이상 유무를 점검하고 작업을 지시한다. 작업 중 발생하는 부품의 불량 및 설비의 고장에 대하여 수리 또는 조치를 취한다. 작업원의 근로시간, 작업태도를 감독하고 생산량, 불량률 등을 기록·관리한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|","workFunc1":"조정","workFunc2":"감독","workFunc3":"조작운전","connectJob":"안경조립반장, 안경검사반장, 안경수리반장","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002437:1', '{"dJobCd":"K000002437","dJobCdSeq":"1","dJobNm":"안경테조립원","workSum":"수동공구, 용접기, 연마기 등을 사용하여 금, 알루미늄, 백금 등을 소재로 하는 안경테를 조립한다.","doWork":"작업지시서에 따라 조립할 안경테의 소재와 제조방법 등을 확인한다. 조립에 필요한 각 부품과 수량을 확인하여 준비한다. 전동드라이버, 용접기, 연마기, 고주파세척기 등의 도구 및 장비를 준비하고 작동 여부를 확인한다. 안경테 구성부품을 수령하고 공기전동드라이버를 사용하여 나사 체결 작업을 한다. 고주파유도가열장치(용접기)를 사용하여 가공될 부품들을 치구에 걸어 용접한다. 조립이 완료된 안경테를 지그에 걸고 연마기에 넣어 연마 및 광택을 낸다. 연마 및 광택이 끝난 후 고주파세척기를 이용하여 세척한다. 안경테에 필요한 팁(안경다리에 끼워 넣는 플라스틱)을 손으로 끼워 넣는다. 수출물량의 경우 안경테를 보호하기 위하여 도수 없는 렌즈를 안경테에 끼워 넣는다. 인쇄기를 사용하여 안경다리 팁 위에 업체명, 제품번호 등의 문구를 인쇄하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002109:1', '{"dJobCd":"K000002109","dJobCdSeq":"1","dJobNm":"안료포장원","workSum":"제조된 안료를 수동·자동 포장기를 이용해 포대에 담거나 드럼에 충진한다.","doWork":"조색공정을 거친 안료의 제품번호를 확인한 후 작업일지에 기록한다. 저울의 계량상태를 점검한다. 저울에 용기를 올려놓고 저울의 영점을 맞춘다. 드럼통일 경우에는 비닐팩을 안에 넣은 후 영점을 맞춘다. 조색공정탱크와 연결된 밸브를 천천히 열어 안료를 용기에 충진한다. 수시로 저울을 확인하여 적정량이 투입되도록 밸브를 조절한다. 1차 충진이 완료되면 정확히 함량을 맞추기 위하여 부족분을 채워 넣는다. 드럼통에 담을 때에는 뚜껑을 정확하게 닫아 밀폐를 시키고, 포대는 새는 곳이 없도록 재봉기로 봉합한다. 적재함에 적재한 후 보관실로 운반한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workEnv":"대기환경미흡|위험내재|고온|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C204","dJobICdNm":"[C204]기타 화학제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003782:1', '{"dJobCd":"K000003782","dJobCdSeq":"1","dJobNm":"압인기조작원","workSum":"구두부품에 열을 가해서 번호, 크기, 소재, 색상을 표시하는 압인기를 조작한다.","doWork":"특정한 형태의 부호로 압인하기 위해 선택손잡이를 돌리거나 금형을 압인기 헤드에 놓는다. 부품을 헤드 밑의 베드 위에 놓는다. 가열한 압인기 헤드에 잉크를 묻히고 페달을 눌러 부품에 부호를 찍는다. 가열된 압인기에 금박지를 대고 압인기 스위치를 조작하여 가죽의 표면에 금박을 입히기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"마킹기조작원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C152","dJobICdNm":"[C152]신발 및 신발 부분품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004258:1', '{"dJobCd":"K000004258","dJobCdSeq":"1","dJobNm":"앰풀충전엄폐기조작원","workSum":"액체의약품을 앰풀(Ampule)에 충전하고 봉인하는 엄폐기를 조작한다.","doWork":"밀폐할 의약품 및 용기의 종류를 확인하고 밀폐용 자재, 부품의 수량 및 종류를 확인하여 준비한다. 엄폐기의 작동 여부를 점검하여 확인한다. 기계를 가동하여 빈 앰풀을 호퍼(Hopper:분립체의 저장 및 공급장치)로 보내거나 자동적으로 충전위치에 보내주는 회전기계판 위에 둔다. 앰풀이 가스버너에 의해 불꽃 속에서 유리가 용해되고 봉인되는 상태를 확인한다. 봉인된 앰풀을 검사하는 앰풀검사원의 일을 하기도 한다. 부품을 검사(용봉검사, 용폐검사)하기 위하여 지시약(염색약)이 담겨진 밀봉용기에 담궈 검사하기도 한다. 앰풀을 세척하는 장비를 조작하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"수집","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2022"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006814:1', '{"dJobCd":"K000006814","dJobCdSeq":"1","dJobNm":"연고충전(충진)원","workSum":"조제된 연고 내용물을 튜브케이스에 충진(충전)하는 장치를 조작한다.","doWork":"작업명세서에 따라 충진할 의약품의 종류와 생산수량을 확인한다. 충진기의 작동상태 및 청결상태를 확인·점검한다. 충진작업 전 저장탱크로 이송된 내용물의 성상을 확인하고 작업 중 라벨을 부착한다. 튜브케이스를 충진기의 케이스 저장 호퍼(Hopper:분립체의 저장 및 공급장치)에 투입한다. 이송된 연고 내용물을 튜브케이스가 배치되어 있는 충진기호퍼에 투입한다. 충진기의 충진량과 충진속도 등을 조정한 후 가동한다. 튜브케이스가 컨베이어를 통해 일정하게 투입되도록 튜브케이스를 정렬한다. 충진이 완료되면 내용물이 충진된 제품의 개별중량, 평균용량, 봉합상태, 튜브외관 등을 측정하고 점검한다. 견본을 품질검사부에 보내고 결과가 통보될 때까지 제품을 창고에 이송·보관한다. 충진작업 후 장치를 정지하고 청소한다. 품질관리부에서 적합판정이 나면 포장지시서와 함께 포장실로 인계한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004951:1', '{"dJobCd":"K000004951","dJobCdSeq":"1","dJobNm":"우산제조원","workSum":"우산살 및 우산대를 제조하기 위하여 긴 철편을 성형·열처리·절단한다.","doWork":"철편회전대 위에 철편묶음을 고정한다. 철편 끝을 성형기룰러를 거쳐 성형감기대에 묶는다. 감기대를 수동으로 돌려 보아 철편이 둥글게 성형되면 성형기의 가동스위치를 누른다. 성형된 우산살에 탄력을 주기 위해 전기로에 넣고 열처리한다. 열처리가 끝난 우산살을 강하게 하기 위해 일정 시간 동안 기름통에 담근다. 기름통에서 꺼낸 우산살을 절단기로 절단한다. 절단한 우산살이 부러지지 않도록 살 양쪽 끝부분을 소둔열처리를 한다. 소둔열처리가 끝난 우산살 양쪽 끝부분을 납작하게 만들기 위해 가공기에 투입한다. 완성된 제품에 남아있는 실이나 실밥을 가위로 잘라내고 제품이 외관상 이상이 있는지 육안으로 검사한다. 입고한 원단을 검사하기 위해 검단기에 건다. 검단기에 걸쳐놓은 원단의 양끝을 손으로 잡아당기면서 제작상의 결점, 염색 얼룩, 날염 결점 등을 육안으로 확인한다. 불량부분이 있으면 분필로 표시하거나 원단의 반대 색깔의 실로 표시한다. 불량품은 이상이 있는 부위를 표시하여 해당 부서로 보낸다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","connectJob":"우산검사원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C339","dJobICdNm":"[C339]그 외 기타 제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006645:1', '{"dJobCd":"K000006645","dJobCdSeq":"1","dJobNm":"유리관세척기조작원","workSum":"형광등 제조에 사용되는 유리관의 불순물을 제거하기 위해 유리관을 세척·건조하는 기계를 조작한다.","doWork":"작업지시서의 내용을 이해하고 작업물량을 확인한다. 세척기에 부착된 수직물림쇠에 일정 치수의 유리관을 끼운다. 물이 유리관을 통해 흐르도록 밸브를 조절한다. 스위치를 조작하여 물을 수직으로 통과시켜 유리관을 세척하고 연속적으로 건조하는 세척기를 가동한다. 세척·건조된 유리관을 육안으로 검사하기도 한다. 다음 공정으로 이동을 위해 작업물량과 최종적인 상태를 확인한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|","workEnv":"위험내재|다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005462:1', '{"dJobCd":"K000005462","dJobCdSeq":"1","dJobNm":"음료세병기조작원","workSum":"알코올이나 비알콜성 음료액을 충전하는 공병을 기계적·화학적 방법으로 내·외부를 세척하는 세병기를 조작·관리한다.","doWork":"세척액의 온도를 규정된 세척온도로 맞추고 일정 농도로 희석된 가성소다 용액을 가성소다 탱크에 채운다. 세병기를 가동시키고 컨베이어를 통해 이송된 공병의 투입상태, 세척상태, 노즐(Nozzle)의 분사상태가 양호한지 등을 관찰·검사하여 필요시 컨베이어의 속도를 조절하거나 가성소다 용액의 농도 그리고 온수온도 등을 조절한다. 세척되는 공병을 관찰하여 깨진 병 또는 세척이 불량한 공병을 제거한다. 자동화된 기계의 조정판에 세척시간, 물의 분무량, 컨베이어의 이송속도 등을 입력하여 세척된 상태를 관찰·조절하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"다습|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C111","dJobICdNm":"[C111]알코올음료 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005351:1', '{"dJobCd":"K000005351","dJobCdSeq":"1","dJobNm":"의료용품봉함원","workSum":"멸균된 주사기, 수액세트 등과 같은 의료용품에 이물질이나 균의 침입을 방지하기 위해 제품을 봉(Sealing)한다.","doWork":"의료용품을 봉하기 전 봉함기(Sealer)의 오염상태를 확인하고 가동상태 이상 유무를 점검한다. 봉함기계의 상태가 양호함을 확인 후에 멸균된 주사기 및 수액세트를 포장용기에 삽입한다. 포장용기를 봉함기의 회전롤러의 힘을 이용하여 포장용기에 봉함한다. 자동봉함기의 경우 작업과정을 살펴보고 이상이 발생할 시 기계를 멈추고 문제를 해결한다. 봉함 후 일정 수량을 세어 박스에 담아 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","similarNm":"씰링원, 포장원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C271","dJobICdNm":"[C271]의료용 기기 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002059:1', '{"dJobCd":"K000002059","dJobCdSeq":"1","dJobNm":"이불충전원","workSum":"누비이불, 깃털이불, 슬리핑백 덮개를 솜이나 패딩으로 채우는 자동기계를 조작한다.","doWork":"삼면으로 바느질된 덮개를 벌려 틀 위에 놓고 충전기(충진기)의 출구에 접속한다. 기계의 작동부위를 점검하고 결함 여부를 점검한다. 발로 충전기(충진기)의 페달을 밟거나 스위치를 눌러 솜이나 패딩을 일정하게 채운 후 충전(충진) 상태를 점검한다. 충전(충진)이 완료되면 덮개를 봉합한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"우모실작업원","connectJob":"누비이불충전원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003388:1', '{"dJobCd":"K000003388","dJobCdSeq":"1","dJobNm":"자동포장기조작원","workSum":"각종 공정을 거쳐 완성이 된 석유화학제품 및 기타 화학제품을 상자나 박스, 백(Bag) 등에 포장하는 자동포장기를 조작한다.","doWork":"교대 근무 시 전 근무자로부터 작업의 내용과 특이사항 등에 대한 내용들을 인수인계 받는다. 작업지시서의 내용에 따라 포장할 제품의 종류와 포장량 등을 확인한다. 자동포장기를 작동해 포장박스 등을 투입구에 탑재한다. 운전 중 포장기의 가동상태를 점검하고 포장된 제품의 봉합상태 등을 점검한다. 포장수량, 포장제품의 종류, 포장날짜 등을 일지에 기록한다. 고장원인을 진단하고 조치한다. 작업이 완료되면 주변을 정리정돈하고 간단한 일지를 작성한 후 다음 근무자에게 인수인계를 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"가벼운 작업","workPlace":"실내","workEnv":"대기환경미흡|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"포장원","certLic":"포장산업기사","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000007167:1', '{"dJobCd":"K000007167","dJobCdSeq":"1","dJobNm":"제품결속원","workSum":"제품을 일정 단위로 결속(밴딩)하는 결속기를 조작하며 포장재로 제품을 포장한다.","doWork":"제품이 일정 분량 쌓이면 분리하여 자동 또는 수동 결속기를 사용하여 제품을 묶는다. 결속된 제품을 적재기를 사용하여 이동시켜 적재한다. 작업지시서에 따라 결속된 제품을 포장지나 박스에 포장한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"N759","dJobICdNm":"[N759]기타 사업지원 서비스업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005383:1', '{"dJobCd":"K000005383","dJobCdSeq":"1","dJobNm":"초자충전원","workSum":"네온사인에 사용되는 유리관을 지시된 모양으로 구부리고 가스를 주입한다.","doWork":"도면설계도에 따라 유리관을 불에 달구어 일정한 모양으로 구부린다. 진공펌프를 사용하여 유리관 내부의 공기를 완전히 제거한다. 유리관에 가스관을 연결하여 네온관의 발광색에 따라 네온, 아르곤 등의 혼합가스를 주입한다. 유리관에 전극을 연결하고 스위치를 조작하여 빛의 색깔을 관찰한다. 유리관 내부에 가스가 골고루 퍼지도록 전원을 일정 시간 연결한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"손사용|시각|","workEnv":"대기환경미흡|위험내재|고온|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C284","dJobICdNm":"[C284]전구 및 조명장치 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000005209:1', '{"dJobCd":"K000005209","dJobCdSeq":"1","dJobNm":"침구충전원","workSum":"주입기를 사용하여 솜털, 면직물 등의 충전재를 베개, 쿠션, 침낭 등에 채워 넣는다.","doWork":"작업지시서를 확인하고 생산하려는 제품에 따라 충전할 충전재의 종류 및 양을 확인한다. 주입기의 유출관을 충전할 직물에 대고 묶은 후 덮개 속으로 충전재가 투입되도록 압력버튼을 누른다. 무게를 달거나 주입기의 가동시간으로 충전재의 양을 결정한다. 금속막대를 사용하여 덮개 끝의 입구에 충전재를 집어넣는다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","workEnv":"대기환경미흡|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","connectJob":"베개충전원, 침낭충전원, 쿠션충전원, 솜털충전원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C132","dJobICdNm":"[C132]직물직조 및 직물제품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004690:1', '{"dJobCd":"K000004690","dJobCdSeq":"1","dJobNm":"캡슐충전기(충진기)조작원","workSum":"젤라틴 캡슐에 의약 제조물을 채우는 캡슐충전기(충진기)를 조작한다.","doWork":"작업명세서에 따라 충진할 의약품의 종류를 확인한다. 충진기의 작동 여부를 확인하고 각 계기판을 점검한다. 분말 또는 액상으로 제조된 약품과 젤라틴 캡슐을 충진기에 투입한다. 작업지시서에 지시된 양만큼 충진하기 위해 컴퓨터를 조작한 후 충진기의 작동 스위치를 조작한다. 견본을 채취하여 캡슐의 파열 및 결함 여부를 조사한다. 일정 수의 캡슐 무게를 측정하여 중량명세서와 일치하는지 확인한다. 충진이 완료된 의약품을 다음 공정으로 이송한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1년 초과 ~ 2년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"유지","connectJob":"연질캡슐충전기(충진기)조작원, 병충전(충진)원, 튜브충전(충진)원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C212","dJobICdNm":"[C212]의약품 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002481:1', '{"dJobCd":"K000002481","dJobCdSeq":"1","dJobNm":"테이프복사원","workSum":"테이프를 대량으로 복사하기 위하여 복제기를 조작하여 다량으로 테이프를 복사한다.","doWork":"작업지시서에 의하여 복사할 서브마스터 테이프(Sub Master Tape:음향이 녹음된 원판테이프로 대량의 테이프로 녹음하기 위하여 만든 녹음용 테이프)와 녹음되지 않은 릴테이프(Reel Tape)를 준비한다. 기기의 작동상태를 확인한다. 서브마스터 테이프와 릴 테이프를 복제기에 장착한다. 작업지시서의 수량에 맞게 복사 매수를 설정하고 장비를 가동한다. 장비의 작동상태를 확인한다. 복사된 테이프를 떼어내어 음질 및 화질의 이상 유무를 검사한다. 녹음된 테이프를 각각의 테이프에 되감는다. 테이프에 라벨을 부착하고 포장한다. 낱개로 포장된 테이프를 박스에 담아 적재한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"6개월 초과 ~ 1년 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","connectJob":"카세트테이프복사원, 시디복사원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C182","dJobICdNm":"[C182]기록매체 복제업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003420:1', '{"dJobCd":"K000003420","dJobCdSeq":"1","dJobNm":"폐건전지처리원","workSum":"수집된 폐건전지에서 납을 분리하기 위하여 자동분리기를 조작한다.","doWork":"폐건전지를 지정된 장소에 적재한다. 부수고 분리하는 장비의 이상 유무를 점검한다. 해머나 자동 파쇄기를 조작하여 납을 분리한다. 분리된 납을 분리기 안에 투입하고 이물질은 제거하고 납만 걸러낸다. 분리된 납의 양을 계량하여 작업일지에 기록한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내·외","physicalAct":"웅크림|손사용|","workEnv":"위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"조작운전","similarNm":"폐배터리처리원","dJobECd":"8859","dJobECdNm":"[8859]주입·포장·상표부착기 및 기타 기계 조작원","dJobJCd":"8990","dJobJCdNm":"[8990]기타 기계 조작원","dJobICd":"C242","dJobICdNm":"[C242]1차 비철금속 제조업","inqYear":"2017"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006116:1', '{"dJobCd":"K000006116","dJobCdSeq":"1","dJobNm":"건설단순노무자","workSum":"건설현장에서 건설기능공(목공, 철근공, 콘크리트공, 배관공 등)의 작업을 지원하고 보조하며, 기능을 요하지 않는 잡역에 종사한다.","doWork":"철근, 벽돌, 시멘트 몰탈 등 공사자재를 정리한다. 공사자재를 설치 장소로 운반한다. 건설현장에서 각종 청소 및 심부름 등 잡역을 수행한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내·외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","similarNm":"건설인부, 건물건설잡역부, 건설잡부","connectJob":"하는 일에 따라 건설단순종사원, 인력운반공, 건설자재정리원, 건설현장정리원, 기능 및 숙련도에 따라 보통인부, 특별인부, 조력공","dJobECd":"7060","dJobECdNm":"[7060]건설·채굴 단순 종사원","dJobJCd":"9100","dJobJCdNm":"[9100]건설 및 광업 단순 종사원","dJobICd":"F","dJobICdNm":"[F]건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003120:1', '{"dJobCd":"K000003120","dJobCdSeq":"1","dJobNm":"건설현장교통정리원","workSum":"도로, 댐, 다리 등의 건설현장에서 작업이 원활히 진행되도록 차량 및 인원을 통제한다.","doWork":"차량의 소통이 원활하게 이루어지도록 깃발이나 호루라기를 이용하여 교통을 통제한다. 공사장으로 진·출입하는 각종 장비를 유도한다. 교통표지판 및 안전표지판을 설치·해체한다. 작업지역 내의 안전시설 및 위험방지를 위해 조치한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"가벼운 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"신호원, 유도원, 건설현장교통신호수, 건설현장신호수","dJobECd":"7060","dJobECdNm":"[7060]건설·채굴 단순 종사원","dJobJCd":"9100","dJobJCdNm":"[9100]건설 및 광업 단순 종사원","dJobICd":"F411/F412","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000004688:1', '{"dJobCd":"K000004688","dJobCdSeq":"1","dJobNm":"광석운반원","workSum":"광산에서 채굴된 광석을 삽·어랭이·괭이·지렛대 등을 사용하여 광차에 싣고 운반한다.","doWork":"작업장에서 천반과 측벽을 확인하고 부석을 제거한다. 광차의 차륜 및 적재함을 점검하고 운반레일의 이상 유무를 확인한다. 해머를 사용하여 큰 광석을 파쇄한다. 삽·어랭이(삼태기 같은 운반도구)·괭이·지렛대 등을 사용하여 광석을 들어 광차에 적재한다. 광차에 적정량을 적재하고 그리즐리(Grizzly:광석, 석탄, 자갈 등을 가려내는 데 사용되는 기계), 슈트 또는 기타 저장소에 밀어서 운반한다. 광차를 고정시키고 광석을 직접 또는 장비를 사용하여 쏟아붓는다. 안전 등을 점검하고 그리즐리 및 슈트장의 조명상태를 확인한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"힘든 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"광차운반원, 수적운반원, 광석운반인부","dJobECd":"7060","dJobECdNm":"[7060]건설·채굴 단순 종사원","dJobJCd":"9100","dJobJCdNm":"[9100]건설 및 광업 단순 종사원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002230:1', '{"dJobCd":"K000002230","dJobCdSeq":"1","dJobNm":"교통표지판설치원","workSum":"원활한 도로교통과 도로이용자의 편의를 위하여 경계표지, 이정표지, 방향표지, 노선표지 등의 각종 교통표지판을 설치한다.","doWork":"도면을 보고 교통표지판의 설치 지점을 확인한다. 교통표지판의 반사시트나 페인트가 벗겨지지 않도록 포장하여 설치장소로 운반한다. 볼트의 위치 및 높이를 정한 후 볼트를 연결한다. 볼트가 고정되도록 콘크리트를 타설한다. 각종 교통표지판과 지주를 조립한다. 기중기조종원에게 수신호하여 안전하게 설치지점으로 달아올려 임팩트렌치(Impact Wrench)나 토크렌치(Torque Wrench)로 너트를 균등하게 조인다. 표지판이 차량의 진행방향과 일치하는지와 직각 여부를 확인·교정한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실외","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"도로표지판설치원","dJobECd":"7060","dJobECdNm":"[7060]건설·채굴 단순 종사원","dJobJCd":"9100","dJobJCdNm":"[9100]건설 및 광업 단순 종사원","dJobICd":"F421","dJobICdNm":"[F421]기반조성 및 시설물 축조관련 전문공사업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001502:1', '{"dJobCd":"K000001502","dJobCdSeq":"1","dJobNm":"기중기신호원","workSum":"무전기, 신호기, 수신호 등을 이용하여 중량물을 정확한 위치에 이동시킬 수 있도록 기중기조종원에게 신호하고, 이동작업을 보조한다.","doWork":"작업지시서를 검토하여 운반할 중량물의 종류, 운반위치 등을 확인한다. 무전기의 교신장치, 신호방법 등을 점검한다. 크레인의 고리를 내려 와이어로프 및 연결용 쇠고랑(Shackle)을 점검한다. 크레인 이동방향에 장애물의 유무를 확인한다. 중량물을 와이어로프로 묶거나 연결용 쇠고랑을 체결한다. 물품의 손상을 방지하기 위하여 슬링벨트(Sling Belt)를 사용한다. 기중기조종원에게 신호하여 물품을 약간 들어올려 낙하물 및 고정상태를 확인한 후 운반위치에 이동시켜 내려놓는다. 연결고리 및 로프를 풀고 물품의 상태를 확인한다.","optionJobInfo":{"eduLevel":"6년 초과 ~ 9년 이하(중졸 정도)","skillYear":"시범후 30일 이하","workStrong":"보통 작업","workPlace":"실외","workEnv":"대기환경미흡|위험내재|소음·진동|","workFunc1":"비교","workFunc2":"말하기신호","workFunc3":"단순작업","similarNm":"크레인신호수, 기중기수신호원, 크레인수신호원, 타워크레인수신호원","connectJob":"지게차신호수, 건설현장신호수","dJobECd":"7060","dJobECdNm":"[7060]건설·채굴 단순 종사원","dJobJCd":"9100","dJobJCdNm":"[9100]건설 및 광업 단순 종사원","dJobICd":"F411/F412/F426","dJobICdNm":"[F411]건물 건설업 / [F412]토목 건설업 / [F426]건설장비 운영업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002548:1', '{"dJobCd":"K000002548","dJobCdSeq":"1","dJobNm":"토공작업원","workSum":"고속도로, 일반도로, 관개수로, 댐, 건축 등의 건설 시 벌개제근(모공 작업 전에 나무뿌리나 초목 등을 제거하는 작업), 절토, 성토, 정지하는 직무를 수행한다.","doWork":"토공반장의 지시에 따라 현장 주위를 청소한다. 수목, 덤불, 뿌리 등을 전동톱, 삽, 낫 등을 이용하여 제거한다. 절토지점을 표시하기 위하여 말뚝을 박고 줄을 맨다. 중장비운전원에게 절토하거나 파놓은 흙을 운반하게끔 수신호를 한다. 삽·곡괭이 등을 사용하여 도랑이나 굴착부분의 벽과 바닥을 일정한 경사로 파내고 다듬는다. 흙의 함몰을 방지하기 위하여 측면받침대를 설치한다. 노면을 평탄하게 다듬기 위하여 삽으로 뿌리고 고른다. 절취장소, 토취장 또는 성토기초의 고인 물을 배수하기 위하여 도랑 등의 배수시설을 설치한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"힘든 작업","workPlace":"실외","workEnv":"위험내재|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"수동조작","similarNm":"토공작업공, 토공작업인부","connectJob":"벌목작업원, 절토작업원, 성토작업원, 정지작업원","dJobECd":"7060","dJobECdNm":"[7060]건설·채굴 단순 종사원","dJobJCd":"9100","dJobJCdNm":"[9100]건설 및 광업 단순 종사원","dJobICd":"F412","dJobICdNm":"[F412]토목 건설업","inqYear":"2014"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000002416:1', '{"dJobCd":"K000002416","dJobCdSeq":"1","dJobNm":"객실물품보급반장","workSum":"항공기에서 사용될 기내용품의 적재·하역 과정을 관리하고 감독한다.","doWork":"객실용품관리원(항공운수)의 지시에 따라 작업할 항공기의 종류 및 탑재할 용품의 수량을 검토한다. 운반용기에 포장되는 각종 기내용품을 점검하고 수량을 확인한다. 항공기의 적재위치를 확인하고 탑재수량을 확인한다. 탑재가 완료되면 객실승무원에게 탑재목록을 제출한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"4년 초과 ~ 10년 이하","workStrong":"보통 작업","workPlace":"실내·외","workFunc1":"조정","workFunc2":"감독","workFunc3":"관련없음","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000001261:1', '{"dJobCd":"K000001261","dJobCdSeq":"1","dJobNm":"광산자재창고작업원","workSum":"광산 내에서 필요한 각종 자재 및 광산장비 부품을 창고에 입고·보관·불출하는 업무를 한다.","doWork":"광산자재창고사무원의 지시에 따라 각종 자재나 물품을 수령하거나 창고로 운반하여 질적 상태 및 수량을 검수한다. 자재의 종류 및 순서에 따라 분류하여 선반에 얹거나 상자에 담는다. 창고 내에 적재되어 있는 자재를 정리하고 창고를 청소한다. 자재청구서에 명시된 자재를 찾아 수량을 세어 불출한다. 입고되거나 불출한 수량을 자재입출고 일지에 기록한다. 일일현황을 파악하기 위하여 물품을 조사하고 재고량을 검수하여 현황일지에 기록한다. 자재나 물품을 포장하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"1개월 초과 ~ 3개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"균형감각|웅크림|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"B051/B061/B062","dJobICdNm":"[B051]석탄 광업 / [B061]철 광업 / [B062]비철금속 광업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003820:1', '{"dJobCd":"K000003820","dJobCdSeq":"1","dJobNm":"기내식탑재원","workSum":"기내식 및 면세품을 기내에 탑재하여 정리한다.","doWork":"준비 완료된 음식, 음료 등의 기내식과 면세품의 수량을 확인하여 운송차량에 적재한다. 메뉴에 따라 정해진 온도 및 청결상태를 유지하여 항공기로 운반한다. 기용품차량을 이용하여 기내에 적재하고 갤리의 정해진 위치에 기내식 및 면세품을 정리한다. 항공기객실승무원에게 작업 내용을 전달한다. 운송차량을 운전하기도 한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000003065:1', '{"dJobCd":"K000003065","dJobCdSeq":"1","dJobNm":"기내용품탑재원","workSum":"모포, 기내지 등의 기내용품을 항공기에 탑재한다.","doWork":"요청된 기내용품의 주문량을 확인하여 창고에 있는 재고를 파악한다. 물품을 분류하여 수량에 맞게 운반용기에 정리한다. 운송차량에 적재하여 운반하고 항공기의 적재 위치를 확인해 기내로 탑재한다. 탑재목록 및 수량을 항공기객실승무원에게 전달한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"단순작업","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"H511/H512","dJobICdNm":"[H511]항공 여객 운송업 / [H512]항공 화물 운송업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;

INSERT INTO job_sources (source_system, source_type, source_key, raw_payload, normalized_payload, fetched_at, updated_at) 
         VALUES ('WORK24_DJOB', 'DICTIONARY', 'K000006684:1', '{"dJobCd":"K000006684","dJobCdSeq":"1","dJobNm":"낙농품냉동창고작업원","workSum":"제조된 아이스크림, 빙과제품, 발효유 등을 냉동창고에 저장·관리한다.","doWork":"아이스크림, 빙과제품, 발효유 등의 낙농품이 포장되어 입고되면 제품을 종류별로 분류한다. 지게차 등을 사용하여 제품박스를 규정된 장소로 운반하여 적재한다. 입고된 제품의 종류와 수량, 입고날짜 등을 기록한 명세표를 적재한 제품의 상단에 부착한다. 수시로 온도계를 확인하고 창고 내의 제품은 제품별 숙성시간(경화)을 준수하여 출고한다. 출고된 제품의 수량을 기록하고, 재고수량과 비교·확인한다. 냉동장치의 각 부위를 점검하고 낡거나 파손된 부품을 수리하거나 교체한다.","optionJobInfo":{"eduLevel":"9년 초과 ~ 12년 이하(고졸 정도)","skillYear":"3개월 초과 ~ 6개월 이하","workStrong":"보통 작업","workPlace":"실내","physicalAct":"웅크림|","workEnv":"대기환경미흡|저온|다습|","workFunc1":"비교","workFunc2":"관련없음","workFunc3":"투입인출","similarNm":"유제품냉동창고작업원","certLic":"지게차운전기능사","dJobECd":"6244","dJobECdNm":"[6244]하역·적재 종사원","dJobJCd":"9210","dJobJCdNm":"[9210]하역 및 적재 단순 종사원","dJobICd":"C105","dJobICdNm":"[C105]낙농제품 및 식용빙과류 제조업","inqYear":"2013"}}', '{}', unixepoch('now'), unixepoch('now'))
         ON CONFLICT(source_system, source_key) DO UPDATE SET
           raw_payload = excluded.raw_payload,
           normalized_payload = excluded.normalized_payload,
           fetched_at = excluded.fetched_at,
           updated_at = excluded.updated_at;