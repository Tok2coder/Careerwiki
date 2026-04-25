const { execSync } = require('child_process');

const stages = [
  {
    order: 0,
    title: '이커머스 서비스 기획자',
    organization: '국내 이커머스 기업',
    years: '~2018',
    description: '이커머스 플랫폼 서비스 기획 업무 수행 및 기획 기초 역량 구축'
  },
  {
    order: 1,
    title: 'AI 커머스 서비스 기획자 PO',
    organization: '카카오스타일 지그재그',
    years: '2018~',
    description: 'AI 개인화 추천 및 검색 서비스 기획 담당 데이터 기반 의사결정 기획 적용',
    job_slug: '인공지능서비스기획자'
  },
  {
    order: 2,
    title: '서비스기획 전문가 겸 저자',
    organization: '도그냥TV 출판',
    years: '2020~',
    description: '서비스기획 스쿨 도서 출판 및 유튜브 채널 운영으로 PM 및 기획자 대상 교육'
  }
];

const stagesJson = JSON.stringify(stages).replace(/'/g, "''");

const insertTree = `INSERT INTO career_trees (person_name, person_name_en, person_title, person_image_url, stages_json, is_active) VALUES ('이미준(도그냥)', 'Lee Mi-jun (Dogyang)', '카카오스타일 지그재그 PO 겸 서비스기획 저자', NULL, '${stagesJson}', 1)`;

console.log('Inserting career_tree...');
try {
  execSync(`npx wrangler d1 execute careerwiki-kr --remote --command "${insertTree.replace(/"/g, '\\"')}"`, {
    cwd: 'C:\\Users\\user\\Careerwiki',
    encoding: 'utf8',
    stdio: 'inherit'
  });
} catch (e) {
  console.error('Insert failed:', e.message);
  process.exit(1);
}

console.log('\nGetting new career_tree id...');
const result = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT id FROM career_trees WHERE person_name='이미준(도그냥)' ORDER BY id DESC LIMIT 1" --json`,
  { cwd: 'C:\\Users\\user\\Careerwiki', encoding: 'utf8' }
);
const parsed = JSON.parse(result);
const newId = parsed[0].results[0].id;
console.log('New career_tree id:', newId);

// Get 인공지능서비스기획자 job id
const jobResult = execSync(
  `npx wrangler d1 execute careerwiki-kr --remote --command "SELECT id FROM jobs WHERE slug='인공지능서비스기획자' AND is_active=1" --json`,
  { cwd: 'C:\\Users\\user\\Careerwiki', encoding: 'utf8' }
);
const jobParsed = JSON.parse(jobResult);
const jobId = jobParsed[0].results[0].id;
console.log('Job id (인공지능서비스기획자):', jobId);

// Insert career_tree_job_links
const insertLink = `INSERT INTO career_tree_job_links (career_tree_id, job_slug, job_id, stage_index, created_at) VALUES (${newId}, '인공지능서비스기획자', ${jobId}, 1, datetime('now'))`;
console.log('\nInserting career_tree_job_links...');
execSync(`npx wrangler d1 execute careerwiki-kr --remote --command "${insertLink}"`, {
  cwd: 'C:\\Users\\user\\Careerwiki',
  encoding: 'utf8',
  stdio: 'inherit'
});

console.log('\nDone! career_tree_id:', newId, 'linked to job_id:', jobId, 'stage_index: 1');
