const fs = require('fs');
const path = require('path');

const draftPath = path.join(__dirname, 'draft-치과위생사.json');
const draft = JSON.parse(fs.readFileSync(draftPath, 'utf8'));

const payload = {
  fields: draft.fields,
  sources: draft.sources,
  changeSummary: draft.changeSummary
};

async function main() {
  const res = await fetch(`https://careerwiki.org/api/job/${draft.jobId}/edit`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Admin-Secret': 'careerwiki-admin-2026'
    },
    body: JSON.stringify(payload)
  });
  const text = await res.text();
  console.log('Status:', res.status);
  console.log('Response:', text);
}

main().catch(console.error);
