const fs = require('fs');
const draft = JSON.parse(fs.readFileSync('draft-조산사.json', 'utf8'));

fetch('https://careerwiki.org/api/job/1765284006251716/edit', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-Admin-Secret': 'careerwiki-admin-2026'
  },
  body: JSON.stringify(draft)
})
.then(r => r.json())
.then(d => console.log(JSON.stringify(d, null, 2)))
.catch(e => console.error(e));
