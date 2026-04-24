import { readFileSync } from 'fs';

const draft = JSON.parse(readFileSync('./draft-yaksa.json', 'utf-8'));
const JOB_ID = '1765283465419996';

const res = await fetch(`https://careerwiki.org/api/job/${JOB_ID}/edit`, {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026'
  },
  body: JSON.stringify(draft)
});

const text = await res.text();
console.log('Status:', res.status);
console.log('Response:', text);
