import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const draft = JSON.parse(readFileSync(join(__dirname, 'draft-보건소장-technknow.json'), 'utf8'));

const res = await fetch('https://careerwiki.org/api/job/1765283562871324/edit', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026',
  },
  body: JSON.stringify(draft),
});

const text = await res.text();
console.log('Status:', res.status);
console.log('Body:', text);
