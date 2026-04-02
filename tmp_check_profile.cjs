const fs = require('fs');
const raw = fs.readFileSync('C:/Users/PC/Careerwiki/tmp_특수교사_data.txt','utf8');
const arrStart = raw.indexOf('[');
const arr = JSON.parse(raw.substring(arrStart));
const profileStr = arr[0].results[0].merged_profile_json;
const obj = JSON.parse(profileStr);

// Check sidebarCerts
console.log('=== sidebarCerts ===');
console.log(JSON.stringify(obj.sidebarCerts, null, 2)?.substring(0, 500));

// Check detailReady
console.log('\n=== detailReady ===');
if(obj.detailReady) {
  for(const k of Object.keys(obj.detailReady)) {
    const v = obj.detailReady[k];
    if(v===null) console.log(`  ${k}: NULL`);
    else if(Array.isArray(v)) console.log(`  ${k}: array[${v.length}]`);
    else if(typeof v==='string') console.log(`  ${k}: "${v.substring(0,100)}"`);
    else console.log(`  ${k}: ${typeof v}`);
  }
}

// Check trivia
console.log('\n=== trivia ===');
console.log(JSON.stringify(obj.trivia, null, 2)?.substring(0, 500));

// Check way
console.log('\n=== way ===');
console.log(JSON.stringify(obj.way, null, 2)?.substring(0, 500));

// Check relatedJobs
console.log('\n=== relatedJobs ===');
console.log(JSON.stringify(obj.relatedJobs, null, 2)?.substring(0, 300));

// Check sources
console.log('\n=== sources ===');
console.log('count:', obj.sources?.length);
if(obj.sources) console.log(JSON.stringify(obj.sources.slice(0,3), null, 2)?.substring(0, 500));

// Check sidebarQuickFacts
console.log('\n=== sidebarQuickFacts ===');
console.log(JSON.stringify(obj.sidebarQuickFacts, null, 2)?.substring(0, 300));

// Check overviewSalary
console.log('\n=== overviewSalary ===');
console.log(JSON.stringify(obj.overviewSalary, null, 2)?.substring(0, 300));

// Check summary
console.log('\n=== summary ===');
console.log(obj.summary?.substring(0, 200));

// Check certLic
console.log('\n=== certLic ===');
console.log(JSON.stringify(obj.certLic, null, 2)?.substring(0, 500));

// Check wlb
console.log('\n=== wlb ===');
console.log(JSON.stringify(obj.wlb, null, 2)?.substring(0, 300));
