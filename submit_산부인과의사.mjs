import { readFileSync } from 'fs';

const draft = JSON.parse(readFileSync('./draft_산부인과의사.json', 'utf8'));

const payload = {
  fields: draft.fields,
  sources: draft.sources,
  changeSummary: draft.changeSummary
};

const res = await fetch(`https://careerwiki.org/api/job/${draft.jobId}/edit`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026'
  },
  body: JSON.stringify(payload)
});

const json = await res.json();
console.log('Status:', res.status);
console.log(JSON.stringify(json, null, 2));
