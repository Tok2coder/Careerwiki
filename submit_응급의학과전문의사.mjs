import { readFileSync } from 'fs';

const draft = JSON.parse(readFileSync('C:/Users/user/Careerwiki/draft_응급의학과전문의사.json', 'utf-8'));

const payload = {
  fields: draft.fields,
  sources: draft.sources,
  changeSummary: draft.changeSummary
};

const res = await fetch('https://careerwiki.org/api/job/1765283994742757/edit', {
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
