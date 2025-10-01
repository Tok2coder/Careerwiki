// 커리어넷 학과 API 상세 테스트
import axios from 'axios';

const API_KEY = 'd9e0285190fde074bef30031f17f669e';
const BASE_URL = 'https://www.career.go.kr/cnet/openapi';

// XML 파싱 함수
function parseXMLContent(xmlString) {
  const contents = [];
  const contentRegex = /<content>([\s\S]*?)<\/content>/g;
  let match;
  
  while ((match = contentRegex.exec(xmlString)) !== null) {
    const content = match[1];
    const obj = {};
    
    // 학과 관련 필드 추출
    const fields = [
      'majorSeq', 'lClass', 'mClass', 'facilName', 'major',
      'university', 'campus', 'department', 'subject',
      'totalCount', 'summary', 'employment', 'charter', 'interest'
    ];
    
    fields.forEach(field => {
      const fieldRegex = new RegExp(`<${field}>([\\s\\S]*?)<\\/${field}>`);
      const fieldMatch = content.match(fieldRegex);
      if (fieldMatch) {
        obj[field] = fieldMatch[1].trim();
      }
    });
    
    if (Object.keys(obj).length > 0) {
      contents.push(obj);
    }
  }
  
  return contents;
}

async function testMajorAPI() {
  console.log('=== 학과 API 상세 테스트 ===\n');
  
  // 다양한 gubun 값 테스트
  const testCases = [
    { name: 'gubun=대학교', gubun: '대학교' },
    { name: 'gubun=univ_list', gubun: 'univ_list' },
    { name: 'gubun=전문대학', gubun: '전문대학' },
    { name: 'gubun=고등학교', gubun: '고등학교' }
  ];
  
  for (const testCase of testCases) {
    console.log(`\n📋 테스트: ${testCase.name}`);
    
    try {
      // 1. XML 형식으로 요청
      const xmlParams = {
        apiKey: API_KEY,
        svcType: 'api',
        svcCode: 'MAJOR',
        contentType: 'xml',
        gubun: testCase.gubun,
        thisPage: '1',
        perPage: '3'
      };
      
      console.log('XML 요청 파라미터:', xmlParams);
      
      const xmlResponse = await axios.get(`${BASE_URL}/getOpenApi`, {
        params: xmlParams,
        timeout: 10000,
        responseType: 'text'
      });
      
      console.log('XML 응답 상태:', xmlResponse.status);
      console.log('XML 응답 길이:', xmlResponse.data.length);
      
      // content 태그 수 확인
      const contentCount = (xmlResponse.data.match(/<content>/g) || []).length;
      console.log('발견된 content 수:', contentCount);
      
      if (contentCount > 0) {
        console.log('✅ 데이터 발견!');
        const majors = parseXMLContent(xmlResponse.data);
        
        majors.forEach((major, idx) => {
          console.log(`\n학과 ${idx + 1}:`);
          console.log('- facilName:', major.facilName || 'N/A');
          console.log('- mClass:', major.mClass || 'N/A');
          console.log('- lClass:', major.lClass || 'N/A');
          console.log('- majorSeq:', major.majorSeq || 'N/A');
        });
      } else {
        console.log('❌ 데이터 없음');
        console.log('응답 샘플:', xmlResponse.data.substring(0, 200));
      }
      
      // 2. JSON 형식으로도 시도
      const jsonParams = {
        apiKey: API_KEY,
        svcType: 'api',
        svcCode: 'MAJOR',
        gubun: testCase.gubun,
        thisPage: '1',
        perPage: '3'
      };
      
      console.log('\nJSON 요청 파라미터:', jsonParams);
      
      const jsonResponse = await axios.get(`${BASE_URL}/getOpenApi.json`, {
        params: jsonParams,
        timeout: 10000
      });
      
      console.log('JSON 응답 상태:', jsonResponse.status);
      console.log('JSON 응답 타입:', typeof jsonResponse.data);
      
      if (typeof jsonResponse.data === 'object') {
        console.log('JSON 응답 키:', Object.keys(jsonResponse.data));
      } else {
        console.log('JSON 응답 샘플:', JSON.stringify(jsonResponse.data).substring(0, 200));
      }
      
    } catch (error) {
      console.error('❌ 오류:', error.message);
    }
    
    // API 호출 제한 방지
    await new Promise(resolve => setTimeout(resolve, 1000));
  }
  
  // searchTitle 파라미터 테스트
  console.log('\n\n📋 검색어 테스트');
  
  try {
    const searchParams = {
      apiKey: API_KEY,
      svcType: 'api',
      svcCode: 'MAJOR',
      contentType: 'xml',
      gubun: '대학교',
      searchTitle: '컴퓨터',
      thisPage: '1',
      perPage: '5'
    };
    
    console.log('검색 파라미터:', searchParams);
    
    const response = await axios.get(`${BASE_URL}/getOpenApi`, {
      params: searchParams,
      timeout: 10000,
      responseType: 'text'
    });
    
    console.log('응답 상태:', response.status);
    console.log('응답 길이:', response.data.length);
    
    const contentCount = (response.data.match(/<content>/g) || []).length;
    console.log('발견된 content 수:', contentCount);
    
    if (contentCount > 0) {
      console.log('✅ 검색 결과 발견!');
      const majors = parseXMLContent(response.data);
      console.log('검색된 학과 수:', majors.length);
      
      majors.slice(0, 2).forEach((major, idx) => {
        console.log(`\n학과 ${idx + 1}:`);
        Object.keys(major).forEach(key => {
          if (major[key]) {
            console.log(`- ${key}:`, major[key].substring(0, 50));
          }
        });
      });
    }
    
  } catch (error) {
    console.error('검색 테스트 오류:', error.message);
  }
}

// 실행
(async () => {
  await testMajorAPI();
  console.log('\n\n테스트 완료!');
})();