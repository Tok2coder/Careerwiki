import fs from 'node:fs';

const JOB_ID = '1775053184425';
const DRAFT_PATH = new URL('./draft-smart-farm-builder-20260419.json', import.meta.url);
const API_URL = `https://careerwiki.org/api/job/${JOB_ID}/edit`;

const payload = JSON.parse(fs.readFileSync(DRAFT_PATH, 'utf8'));

const response = await fetch(API_URL, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026',
  },
  body: JSON.stringify({
    fields: payload.fields,
    sources: payload.sources,
    changeSummary: payload.changeSummary,
  }),
});

const data = await response.json();
console.log(JSON.stringify(data, null, 2));

if (!response.ok || data.success === false) {
  process.exit(1);
}
