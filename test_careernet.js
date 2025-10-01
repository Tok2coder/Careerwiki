// 커리어넷 API 직접 테스트
import axios from 'axios';

const API_KEY = 'd9e0285190fde074bef30031f17f669e';
const BASE_URL = 'https://www.career.go.kr/cnet/openapi';

async function testMajorAPI() {
  console.log('=== 학과 정보 API 테스트 ===');
  
  try {
    // 학과 목록 조회
    const url = `${BASE_URL}/getOpenApi.json`;
    const params = {
      apiKey: API_KEY,
      svcType: 'api',
      svcCode: 'MAJOR',
      gubun: '대학',
      searchTitle: '컴퓨터',
      thisPage: '1',
      perPage: '5'
    };
    
    console.log('요청 URL:', url);
    console.log('파라미터:', params);
    
    const response = await axios.get(url, { 
      params,
      timeout: 10000
    });
    
    console.log('\n응답 상태:', response.status);
    console.log('응답 데이터:');
    console.log(JSON.stringify(response.data, null, 2));
    
    return response.data;
  } catch (error) {
    console.error('오류 발생:', error.message);
    if (error.response) {
      console.error('응답 상태:', error.response.status);
      console.error('응답 데이터:', error.response.data);
    }
  }
}

async function testJobAPI() {
  console.log('\n=== 직업 정보 API 테스트 ===');
  
  try {
    // 직업 목록 조회
    const url = `${BASE_URL}/getOpenApi.json`;
    const params = {
      apiKey: API_KEY,
      svcType: 'api',
      svcCode: 'JOB',
      gubun: 'job_dic_list',
      searchJobNm: '개발',
      thisPage: '1',
      perPage: '5'
    };
    
    console.log('요청 URL:', url);
    console.log('파라미터:', params);
    
    const response = await axios.get(url, { 
      params,
      timeout: 10000
    });
    
    console.log('\n응답 상태:', response.status);
    console.log('응답 데이터:');
    console.log(JSON.stringify(response.data, null, 2));
    
    return response.data;
  } catch (error) {
    console.error('오류 발생:', error.message);
    if (error.response) {
      console.error('응답 상태:', error.response.status);
      console.error('응답 데이터:', error.response.data);
    }
  }
}

// 실행
(async () => {
  console.log('커리어넷 API 테스트 시작\n');
  console.log('API Key:', API_KEY);
  console.log('='.repeat(50));
  
  await testMajorAPI();
  await testJobAPI();
  
  console.log('\n테스트 완료!');
})();