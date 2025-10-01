// 커리어넷 API XML 파싱 테스트
import axios from 'axios';

const API_KEY = 'd9e0285190fde074bef30031f17f669e';
const BASE_URL = 'https://www.career.go.kr/cnet/openapi';

// XML을 JSON으로 변환하는 간단한 파서
function parseXMLContent(xmlString) {
  const contents = [];
  const contentRegex = /<content>([\s\S]*?)<\/content>/g;
  let match;
  
  while ((match = contentRegex.exec(xmlString)) !== null) {
    const content = match[1];
    const obj = {};
    
    // 각 필드 추출
    const fields = [
      'profession', 'summary', 'similarJob', 'salery', 'jobdicSeq',
      'equalemployment', 'totalCount', 'aptd_type_code', 'prospect',
      'job_ctg_code', 'job_code', 'job', 'possibility',
      'major', 'department', 'campus', 'university', 'url',
      'majorSeq', 'subject'
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
  console.log('=== 학과 정보 API 테스트 (XML 파싱) ===');
  
  try {
    const url = `${BASE_URL}/getOpenApi`;
    const params = {
      apiKey: API_KEY,
      svcType: 'api',
      svcCode: 'MAJOR',
      contentType: 'xml',
      gubun: '대학',
      searchTitle: '컴퓨터',
      thisPage: '1',
      perPage: '3'
    };
    
    console.log('요청 파라미터:', params);
    
    const response = await axios.get(url, { 
      params,
      timeout: 10000,
      responseType: 'text'
    });
    
    console.log('응답 상태:', response.status);
    
    // XML 파싱
    const majors = parseXMLContent(response.data);
    console.log(`\n파싱된 학과 수: ${majors.length}`);
    
    majors.forEach((major, index) => {
      console.log(`\n--- 학과 ${index + 1} ---`);
      console.log(`학과명: ${major.major || 'N/A'}`);
      console.log(`계열: ${major.department || 'N/A'}`);
      console.log(`대학: ${major.university || 'N/A'}`);
      console.log(`캠퍼스: ${major.campus || 'N/A'}`);
      console.log(`요약: ${major.summary ? major.summary.substring(0, 100) + '...' : 'N/A'}`);
    });
    
    return majors;
  } catch (error) {
    console.error('오류 발생:', error.message);
  }
}

async function testJobAPI() {
  console.log('\n=== 직업 정보 API 테스트 (XML 파싱) ===');
  
  try {
    const url = `${BASE_URL}/getOpenApi`;
    const params = {
      apiKey: API_KEY,
      svcType: 'api',
      svcCode: 'JOB',
      contentType: 'xml',
      gubun: 'job_dic_list',
      searchJobNm: '개발',
      thisPage: '1',
      perPage: '3'
    };
    
    console.log('요청 파라미터:', params);
    
    const response = await axios.get(url, { 
      params,
      timeout: 10000,
      responseType: 'text'
    });
    
    console.log('응답 상태:', response.status);
    
    // XML 파싱
    const jobs = parseXMLContent(response.data);
    console.log(`\n파싱된 직업 수: ${jobs.length}`);
    
    jobs.forEach((job, index) => {
      console.log(`\n--- 직업 ${index + 1} ---`);
      console.log(`직업명: ${job.job || 'N/A'}`);
      console.log(`분류: ${job.profession || 'N/A'}`);
      console.log(`연봉: ${job.salery || 'N/A'}`);
      console.log(`전망: ${job.possibility || 'N/A'}`);
      console.log(`고용평등: ${job.equalemployment || 'N/A'}`);
      console.log(`요약: ${job.summary ? job.summary.substring(0, 100) + '...' : 'N/A'}`);
    });
    
    return jobs;
  } catch (error) {
    console.error('오류 발생:', error.message);
  }
}

// 실행
(async () => {
  console.log('커리어넷 API 테스트 (XML 파싱)\n');
  console.log('='.repeat(50));
  
  await testMajorAPI();
  await testJobAPI();
  
  console.log('\n테스트 완료!');
})();