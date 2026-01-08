import Database from 'better-sqlite3';

const dbPath = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite';
const db = new Database(dbPath);

// 복구할 직업 목록 (job_id)
const jobsToRestore = [
  { id: '1765283572922905', name: '인력파견관리자' },
  { id: '1765284018725598', name: '사회복지사(일반)' },
  { id: '176528402195122', name: '장애인직업능력평가사' }
];

for (const job of jobsToRestore) {
  console.log(`\n=== ${job.name} 복구 시작 ===`);
  
  // 1. job_sources에서 raw_payload 가져오기
  const sourceRow = db.prepare(`
    SELECT raw_payload FROM job_sources WHERE job_id = ?
  `).get(job.id);
  
  if (!sourceRow || !sourceRow.raw_payload) {
    console.log('raw_payload 없음!');
    continue;
  }
  
  const rawPayload = JSON.parse(sourceRow.raw_payload);
  console.log('Raw payload 로드 완료:', rawPayload.dJobNm);
  
  // 2. optionJobInfo 파싱
  const opt = rawPayload.optionJobInfo || {};
  
  // 3. 자격증 파싱 (쉼표로 분리, 괄호 유지)
  const certLicStr = opt.certLic || '';
  const sidebarCerts = certLicStr ? certLicStr.split(', ').map(cert => ({
    name: cert.trim(),
    url: null
  })) : [];
  
  console.log('파싱된 자격증:', sidebarCerts);
  
  // 4. heroCategory 생성
  const heroCategory = {
    type: 'breadcrumb',
    large: opt.dJobECdNm ? opt.dJobECdNm.replace(/\[\d+\]/, '').trim() : '',
    medium: opt.dJobJCdNm ? opt.dJobJCdNm.replace(/\[\d+\]/, '').trim() : '',
    small: rawPayload.dJobNm
  };
  
  // 5. merged_profile_json 생성 (최소 필수 필드)
  const mergedProfile = {
    name: rawPayload.dJobNm,
    heroCategory,
    heroTitle: rawPayload.dJobNm,
    heroIntro: rawPayload.workSum || '',
    heroTags: [],
    overviewWork: {
      summary: rawPayload.workSum || '',
      details: rawPayload.doWork || '',
      tasks: []
    },
    overviewProspect: { value: '', analysis: '' },
    overviewAbilities: { text: '', details: [] },
    overviewAptitude: { description: '', details: [] },
    overviewSalary: { value: '', range: '', details: '' },
    detailEducation: {
      level: opt.eduLevel || '',
      path: '',
      majors: []
    },
    detailReady: {
      skillYear: opt.skillYear || '',
      certificate: sidebarCerts.map(c => c.name).join(', '),
      training: ''
    },
    detailClassification: {
      sosokDaebun: opt.dJobECd || '',
      sosokDaebunNm: opt.dJobECdNm || '',
      sosokJungbun: opt.dJobJCd || '',
      sosokJungbunNm: opt.dJobJCdNm || '',
      industryCode: opt.dJobICd || '',
      industryName: opt.dJobICdNm || ''
    },
    detailWlb: {
      workStrong: opt.workStrong || '',
      workPlace: opt.workPlace || '',
      physicalAct: opt.physicalAct || ''
    },
    charKnowledge: [],
    charStatus: [],
    charEnvironment: [],
    charPerformance: [],
    charInterest: [],
    charValues: [],
    sidebarCerts,
    relatedJobs: opt.connectJob ? opt.connectJob.split(', ').map(j => j.trim()) : [],
    similarJobs: opt.similarNm ? opt.similarNm.split(', ').map(j => j.trim()) : []
  };
  
  // 6. DB 업데이트
  const updateStmt = db.prepare(`
    UPDATE jobs 
    SET merged_profile_json = ?
    WHERE id = ?
  `);
  
  updateStmt.run(JSON.stringify(mergedProfile), job.id);
  console.log(`${job.name} 복구 완료!`);
}

// 검증
console.log('\n=== 검증 ===');
for (const job of jobsToRestore) {
  const row = db.prepare(`
    SELECT json_extract(merged_profile_json, '$.name') as name,
           json_extract(merged_profile_json, '$.sidebarCerts') as certs
    FROM jobs WHERE id = ?
  `).get(job.id);
  console.log(`${job.name}: name=${row.name}, certs=${row.certs}`);
}

db.close();
console.log('\n완료!');









