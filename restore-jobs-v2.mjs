import Database from 'better-sqlite3';

const dbPath = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';
const db = new Database(dbPath);

// 정상 작동하는 취업알선원의 데이터를 템플릿으로 사용
const templateRow = db.prepare("SELECT merged_profile_json FROM jobs WHERE name = '취업알선원'").get();
const templateJson = JSON.parse(templateRow.merged_profile_json);

// 복구할 직업 목록
const jobsToRestore = [
  { id: '1765283572922905', name: '인력파견관리자' },
  { id: '1765284018725598', name: '사회복지사(일반)' },
  { id: '176528402195122', name: '장애인직업능력평가사' }
];

for (const job of jobsToRestore) {
  console.log(`\n=== ${job.name} 복구 시작 ===`);
  
  // job_sources에서 raw_payload 가져오기
  const sourceRow = db.prepare(`
    SELECT raw_payload FROM job_sources WHERE job_id = ?
  `).get(job.id);
  
  if (!sourceRow || !sourceRow.raw_payload) {
    console.log('raw_payload 없음!');
    continue;
  }
  
  const rawPayload = JSON.parse(sourceRow.raw_payload);
  const opt = rawPayload.optionJobInfo || {};
  
  // 템플릿 복사
  const newProfile = JSON.parse(JSON.stringify(templateJson));
  
  // 필수 필드만 수정
  newProfile.name = rawPayload.dJobNm;
  newProfile.heroTitle = rawPayload.dJobNm;
  newProfile.heroIntro = rawPayload.workSum || '';
  newProfile.heroTags = opt.similarNm ? opt.similarNm.split(', ').map(s => s.trim()).slice(0, 3) : [];
  
  // heroCategory
  newProfile.heroCategory = {
    type: 'breadcrumb',
    large: opt.dJobECdNm ? opt.dJobECdNm.replace(/\[\d+\]/, '').trim() : templateJson.heroCategory.large,
    medium: opt.dJobJCdNm ? opt.dJobJCdNm.replace(/\[\d+\]/, '').trim() : templateJson.heroCategory.medium,
    small: rawPayload.dJobNm
  };
  
  // overviewWork
  newProfile.overviewWork.main = rawPayload.doWork || '';
  newProfile.overviewWork.workStrong = opt.workStrong || '';
  newProfile.overviewWork.workPlace = opt.workPlace || '';
  newProfile.overviewWork.physicalAct = opt.physicalAct || null;
  
  // overviewAbilities
  newProfile.overviewAbilities.eduLevel = opt.eduLevel || '';
  newProfile.overviewAbilities.skillYear = opt.skillYear || '';
  
  // 자격증 - 단순 쉼표 분리가 아닌 스마트 파싱
  const certLicStr = opt.certLic || '';
  // "사회복지사(1급, 2급), 정신건강사회복지사, 직업상담사(1급, 2급)" 형태 처리
  // 괄호 안의 쉼표는 유지, 괄호 밖의 쉼표로 분리
  const parsedCerts = [];
  let current = '';
  let parenDepth = 0;
  for (let i = 0; i < certLicStr.length; i++) {
    const char = certLicStr[i];
    if (char === '(') parenDepth++;
    else if (char === ')') parenDepth--;
    else if (char === ',' && parenDepth === 0) {
      if (current.trim()) parsedCerts.push(current.trim());
      current = '';
      continue;
    }
    current += char;
  }
  if (current.trim()) parsedCerts.push(current.trim());
  
  newProfile.sidebarCerts = parsedCerts.map(cert => ({
    name: cert,
    url: null
  }));
  
  // detailReady.certificate
  if (newProfile.detailReady) {
    newProfile.detailReady.certificate = certLicStr;
  }
  
  // detailClassification
  if (newProfile.detailClassification) {
    newProfile.detailClassification.kecoList = [];
  }
  
  // relatedJobs, similarJobs
  newProfile.relatedJobs = opt.connectJob ? opt.connectJob.split(', ').map(j => j.trim()) : [];
  newProfile.similarJobs = opt.similarNm ? opt.similarNm.split(', ').map(j => j.trim()) : [];
  
  console.log('파싱된 자격증:', newProfile.sidebarCerts);
  
  // DB 업데이트
  const updateStmt = db.prepare(`
    UPDATE jobs 
    SET merged_profile_json = ?
    WHERE id = ?
  `);
  
  updateStmt.run(JSON.stringify(newProfile), job.id);
  console.log(`${job.name} 복구 완료! (JSON 크기: ${JSON.stringify(newProfile).length})`);
}

// 검증
console.log('\n=== 검증 ===');
for (const job of jobsToRestore) {
  const row = db.prepare(`
    SELECT json_extract(merged_profile_json, '$.name') as name,
           length(merged_profile_json) as len
    FROM jobs WHERE id = ?
  `).get(job.id);
  console.log(`${job.name}: name=${row.name}, JSON크기=${row.len}`);
}

db.close();
console.log('\n완료!');









