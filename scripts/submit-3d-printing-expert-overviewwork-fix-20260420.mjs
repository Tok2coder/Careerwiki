import fs from 'node:fs';

const DRAFT_PATH = new URL('./draft-3d-printing-expert-overviewwork-fix-20260420.json', import.meta.url);
const draft = JSON.parse(fs.readFileSync(DRAFT_PATH, 'utf8'));
const API_URL = `https://careerwiki.org/api/job/${draft.jobId}/edit`;

const response = await fetch(API_URL, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026'
  },
  body: JSON.stringify({
    fields: draft.fields,
    sources: draft.sources,
    changeSummary: draft.changeSummary
  })
});

const data = await response.json();
console.log(JSON.stringify(data, null, 2));

if (!response.ok || data.success === false) process.exit(1);
