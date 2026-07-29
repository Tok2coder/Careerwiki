const path = require('path');
const dp = require(path.join(process.cwd(), 'scripts', '_shared', 'detect-patterns.cjs'));
const out = [];
out.push('PROSE_BODY_FIELDS=' + JSON.stringify(dp.PROSE_BODY_FIELDS));
out.push('SOURCE_FIELD_MAP keys=' + JSON.stringify(dp.SOURCE_FIELD_MAP ? Object.keys(dp.SOURCE_FIELD_MAP) : 'UNDEFINED'));
if (dp.SOURCE_FIELD_MAP) out.push('SOURCE_FIELD_MAP=' + JSON.stringify(dp.SOURCE_FIELD_MAP));
out.push('technKnow in PROSE_BODY_FIELDS=' + (dp.PROSE_BODY_FIELDS || []).includes('overviewAbilities.technKnow'));
require('fs').writeFileSync(path.join(process.cwd(),'data/cycle/r12-a4/_dbg2_out.txt'), out.join('\n'), 'utf8');
console.log('DBG2 DONE');
