// 커리어넷 학과 API 디버깅
import axios from 'axios';

const API_KEY = 'd9e0285190fde074bef30031f17f669e';
const BASE_URL = 'https://www.career.go.kr/cnet/openapi';

async function testVariousMajorParams() {
  console.log('=== 다양한 파라미터로 학과 API 테스트 ===\n');
  
  const testCases = [
    {
      name: '전체 학과 조회',
      params: {
        apiKey: API_KEY,
        svcType: 'api',
        svcCode: 'MAJOR',
        contentType: 'xml',
        gubun: '대학',
        thisPage: '1',
        perPage: '5'
      }
    },
    {
      name: '대학교 구분',
      params: {
        apiKey: API_KEY,
        svcType: 'api',
        svcCode: 'MAJOR',
        contentType: 'xml',
        gubun: '대학교',
        thisPage: '1',
        perPage: '5'
      }
    },
    {
      name: '전문대 구분',
      params: {
        apiKey: API_KEY,
        svcType: 'api',
        svcCode: 'MAJOR',
        contentType: 'xml',
        gubun: '전문대',
        thisPage: '1',
        perPage: '5'
      }
    },
    {
      name: 'subject 파라미터 사용',
      params: {
        apiKey: API_KEY,
        svcType: 'api',
        svcCode: 'MAJOR',
        contentType: 'xml',
        gubun: '대학',
        subject: '공학',
        thisPage: '1',
        perPage: '5'
      }
    }
  ];
  
  for (const testCase of testCases) {
    console.log(`\n📋 테스트: ${testCase.name}`);
    console.log('파라미터:', JSON.stringify(testCase.params, null, 2));
    
    try {
      const url = `${BASE_URL}/getOpenApi`;
      const response = await axios.get(url, {
        params: testCase.params,
        timeout: 10000,
        responseType: 'text'
      });
      
      console.log('응답 상태:', response.status);
      console.log('응답 길이:', response.data.length);
      console.log('응답 샘플 (처음 500자):', response.data.substring(0, 500));
      
      // content 태그 개수 확인
      const contentCount = (response.data.match(/<content>/g) || []).length;
      console.log('발견된 content 태그 수:', contentCount);
      
    } catch (error) {
      console.error('오류:', error.message);
    }
    
    // API 호출 제한 방지
    await new Promise(resolve => setTimeout(resolve, 1000));
  }
}

// 실행
(async () => {
  await testVariousMajorParams();
  console.log('\n테스트 완료!');
})();