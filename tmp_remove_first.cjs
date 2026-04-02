const fs = require('fs');
const p = JSON.parse(fs.readFileSync('tmp_merge_targets.json', 'utf8'));
const filtered = p.filter(x => x.source !== '건축설계사');
fs.writeFileSync('tmp_merge_targets.json', JSON.stringify(filtered, null, 2));
console.log('Remaining:', filtered.length);
