const fs = require('fs');
const scenarios = ['analytical_user', 'stability_seeker', 'internal_conflict', 'creative_user', 'low_can_user', 'comprehensive_test'];
for (const s of scenarios) {
  const data = JSON.parse(fs.readFileSync('docs/e2e-results/full-e2e/' + s + '.json', 'utf8'));
  const tops = data.recommendation.top10;
  const fit1 = tops[0] ? tops[0].fitScore : 0;
  const fit10 = tops[9] ? tops[9].fitScore : 0;
  const spread = fit1 - fit10;
  console.log('\n=== ' + s + ' (' + tops.length + ' results, Spread=' + spread + ') ===');
  tops.forEach(function(j, i) {
    console.log('  #' + (i+1) + ' ' + j.jobName.padEnd(25) + ' fit=' + j.fitScore + ' like=' + j.likeScore + ' can=' + j.canScore + ' risk=' + j.riskPenalty);
  });
  // Show risk distribution
  const risks = tops.map(function(j) { return j.riskPenalty; });
  const riskMin = Math.min.apply(null, risks);
  const riskMax = Math.max.apply(null, risks);
  console.log('  Risk range: ' + riskMin + '-' + riskMax);
}
