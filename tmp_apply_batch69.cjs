const https = require('https');
const fs = require('fs');

const jobs = [
  { id: '1765285285304447', file: 'scripts/temp-산업용로봇제어조작원-body.json' },
  { id: '1765285389395593', file: 'scripts/temp-산업용세척기조립원-body.json' },
  { id: '176528404743498',  file: 'scripts/temp-산업응용기술학원강사-body.json' },
];

function applyJob(job) {
  return new Promise((resolve, reject) => {
    const data = JSON.parse(fs.readFileSync(job.file, 'utf8'));
    const body = JSON.stringify({
      fields: data.fields,
      sources: data.sources,
      changeSummary: data.changeSummary,
    });

    const options = {
      hostname: 'careerwiki.org',
      path: `/api/job/${job.id}/edit`,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(body),
      },
    };

    const req = https.request(options, (res) => {
      let responseData = '';
      res.on('data', chunk => responseData += chunk);
      res.on('end', () => {
        console.log(`[${job.id}] HTTP ${res.statusCode}: ${responseData.substring(0, 300)}`);
        resolve({ status: res.statusCode, body: responseData });
      });
    });

    req.on('error', (e) => {
      console.error(`[${job.id}] Error:`, e.message);
      reject(e);
    });

    req.write(body);
    req.end();
  });
}

(async () => {
  for (const job of jobs) {
    console.log(`\n--- Applying: ${job.file} ---`);
    try {
      await applyJob(job);
      await new Promise(r => setTimeout(r, 1000)); // 1s pause between requests
    } catch (e) {
      console.error('Failed:', e.message);
    }
  }
  console.log('\nDone.');
})();
