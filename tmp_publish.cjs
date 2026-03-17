const https = require('https');
const fs = require('fs');

const contentJson = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
const meta = JSON.parse(fs.readFileSync(process.argv[3], 'utf8'));

const body = JSON.stringify({
  title: meta.title,
  summary: meta.summary,
  contentJson: JSON.stringify(contentJson),
  tags: meta.tags,
  relatedJobs: meta.relatedJobs,
  relatedMajors: meta.relatedMajors,
  thumbnailUrl: meta.thumbnailUrl
});

const options = {
  hostname: 'careerwiki.org',
  path: '/api/howto/publish-direct',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Cookie': 'session_token=61a959c9-aa93-4083-b67b-268631a81ef2-9920220e-d759-4240-a45c-52cd5572da06',
    'Content-Length': Buffer.byteLength(body)
  }
};

const req = https.request(options, (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => console.log(data));
});
req.on('error', e => console.error('Error:', e.message));
req.write(body);
req.end();
