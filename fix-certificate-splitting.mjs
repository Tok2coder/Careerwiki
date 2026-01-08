import Database from 'better-sqlite3';

// 자격증 데이터 분리 문제 수정
const dbPath = '.wrangler/state/v3/d1/miniflare-D1DatabaseObject/careerwiki-db.sqlite';
const db = new Database(dbPath);

console.log('=== 자격증 데이터 분리 문제 수정 ===');

// 문제가 있는 패턴 찾기: "(1급"으로 끝나고 ")"로 시작하는 항목들
const problematicJobs = db.prepare(`
  SELECT id, name, json_extract(merged_profile_json, '$.sidebarCerts') as sidebarCerts
  FROM jobs
  WHERE json_extract(merged_profile_json, '$.sidebarCerts') LIKE '%(1급%'
  AND json_extract(merged_profile_json, '$.sidebarCerts') LIKE '%2급)%'
`).all();

console.log('문제가 있는 직업 수:', problematicJobs.length);

for (const job of problematicJobs) {
  console.log(`\n직업: ${job.name}`);
  console.log('현재 sidebarCerts:', job.sidebarCerts);

  try {
    const certs = JSON.parse(job.sidebarCerts);
    console.log('파싱된 데이터:', certs);

    // 문제 패턴 찾기 및 병합
    const mergedCerts = [];
    let pendingCert = null;

    for (const cert of certs) {
      if (cert.name.endsWith('(1급') && !cert.name.includes('2급)')) {
        // "(1급"으로 끝나는 항목 저장
        pendingCert = cert;
      } else if (cert.name.startsWith('2급)') && pendingCert) {
        // "2급)"으로 시작하는 항목과 병합
        const mergedName = pendingCert.name + ', ' + cert.name;
        mergedCerts.push({
          name: mergedName,
          url: pendingCert.url || cert.url || null
        });
        pendingCert = null;
      } else if (!pendingCert) {
        // 일반 항목
        mergedCerts.push(cert);
      } else {
        // pendingCert가 있는데 다른 항목이 나온 경우
        mergedCerts.push(pendingCert);
        mergedCerts.push(cert);
        pendingCert = null;
      }
    }

    // 남은 pendingCert 처리
    if (pendingCert) {
      mergedCerts.push(pendingCert);
    }

    console.log('병합 후:', mergedCerts);

    // DB 업데이트
    const updateStmt = db.prepare(`
      UPDATE jobs
      SET merged_profile_json = json_set(
        merged_profile_json,
        '$.sidebarCerts',
        ?
      )
      WHERE id = ?
    `);

    const result = updateStmt.run(JSON.stringify(mergedCerts), job.id);
    console.log('업데이트 결과:', result);

  } catch (error) {
    console.error('처리 중 오류:', error);
  }
}

db.close();
console.log('완료되었습니다.');








