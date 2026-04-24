// rollback-salary.mjs: overviewSalary 롤백 스크립트
const ADMIN_SECRET = 'careerwiki-admin-2026';
const BASE_URL = 'https://careerwiki.org';

const jobs = [
  {
    id: '1775053184629',
    slug: '3d-프린팅-전문가',
  },
  {
    id: '1765283277187957',
    slug: '가구제조수리원',
  },
  {
    id: '1765285002145485',
    slug: '가스공급관리원',
  }
];

async function fetchCurrent(id) {
  const res = await fetch(`${BASE_URL}/api/job/${id}`);
  if (!res.ok) throw new Error(`Fetch failed: ${res.status}`);
  return res.json();
}

async function rollback(job) {
  console.log(`\n=== ${job.slug} (id: ${job.id}) ===`);

  // 현재 job 데이터 가져오기
  const data = await fetchCurrent(job.id);
  const ucj = data.user_contributed_json 
    ? (typeof data.user_contributed_json === 'string' ? JSON.parse(data.user_contributed_json) : data.user_contributed_json)
    : {};

  // 삭제 전 overviewSalary 값 출력
  console.log('삭제 전 overviewSalary:', JSON.stringify(ucj.overviewSalary));

  // overviewSalary 제거
  delete ucj.overviewSalary;

  // _sources에서 overviewSalary.sal 제거
  if (ucj._sources && ucj._sources['overviewSalary.sal']) {
    delete ucj._sources['overviewSalary.sal'];
    console.log('_sources["overviewSalary.sal"] 삭제됨');
  }

  // API 호출
  const payload = {
    user_contributed_json: ucj,
    sources: ucj._sources || {}
  };

  const res = await fetch(`${BASE_URL}/api/job/${job.id}/edit`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Admin-Secret': ADMIN_SECRET
    },
    body: JSON.stringify(payload)
  });

  const text = await res.text();
  console.log(`API 응답 (${res.status}):`, text.substring(0, 300));

  if (res.status !== 200) {
    console.error('❌ 실패');
    return false;
  }

  console.log('✅ 업데이트 성공');
  return true;
}

async function checkPage(slug) {
  const url = `${BASE_URL}/job/${encodeURIComponent(slug)}`;
  const res = await fetch(url);
  console.log(`페이지 확인 (${res.status}): ${url}`);
  return res.status === 200;
}

for (const job of jobs) {
  try {
    const ok = await rollback(job);
    if (ok) {
      await new Promise(r => setTimeout(r, 300));
      await checkPage(job.slug);
    }
  } catch (e) {
    console.error(`❌ ${job.slug} 오류:`, e.message);
  }
}
