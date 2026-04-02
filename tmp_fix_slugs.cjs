const fs = require('fs');
const mapping = JSON.parse(fs.readFileSync('tmp_fix_mapping.json','utf8'));
const {jobMap, majorMap} = mapping;

// Read all HowTo guide data
const rawData = fs.readFileSync('C:/Users/PC/.claude/projects/C--Users-PC-Careerwiki/574260b2-6df6-4bd3-8735-329ec509cdf6/tool-results/bm7ufo69z.txt','utf8');
const json = JSON.parse(rawData.substring(rawData.indexOf('[')));
const guides = json[0].results.filter(r => r.slug !== 'guide:가이드-작성법');

const updates = [];

guides.forEach(g => {
  let jobChanged = false;
  let majorChanged = false;

  // Fix relatedJobs
  if (g.rj) {
    const jobs = JSON.parse(g.rj);
    const fixedJobs = jobs.map(j => {
      if (jobMap[j.slug]) {
        jobChanged = true;
        return jobMap[j.slug];
      }
      return { slug: j.slug, name: j.name };
    });
    if (jobChanged) {
      const seen = new Set();
      const deduped = fixedJobs.filter(j => {
        if (seen.has(j.slug)) return false;
        seen.add(j.slug);
        return true;
      });
      g.fixedJobs = JSON.stringify(deduped);
    }
  }

  // Fix relatedMajors
  if (g.rm) {
    const majors = JSON.parse(g.rm);
    const fixedMajors = majors.map(m => {
      if (majorMap[m.slug]) {
        majorChanged = true;
        return majorMap[m.slug];
      }
      return { slug: m.slug, name: m.name };
    });
    if (majorChanged) {
      const seen = new Set();
      const deduped = fixedMajors.filter(m => {
        if (seen.has(m.slug)) return false;
        seen.add(m.slug);
        return true;
      });
      g.fixedMajors = JSON.stringify(deduped);
    }
  }

  if (jobChanged || majorChanged) {
    updates.push({
      id: g.id,
      slug: g.slug,
      title: g.title,
      fixedJobs: g.fixedJobs,
      fixedMajors: g.fixedMajors
    });
  }
});

console.log('Guides needing updates:', updates.length);
updates.forEach(u => {
  console.log('  ID:', u.id, '-', u.title.substring(0, 40));
});

// Generate SQL - nested json_set for multiple fields
const sqls = [];
updates.forEach(u => {
  let expr = 'meta_data';
  if (u.fixedJobs) {
    const escaped = u.fixedJobs.replace(/'/g, "''");
    expr = "json_set(" + expr + ", '$.relatedJobs', json('" + escaped + "'))";
  }
  if (u.fixedMajors) {
    const escaped = u.fixedMajors.replace(/'/g, "''");
    expr = "json_set(" + expr + ", '$.relatedMajors', json('" + escaped + "'))";
  }
  if (expr !== 'meta_data') {
    sqls.push('UPDATE pages SET meta_data = ' + expr + ' WHERE id = ' + u.id + ';');
  }
});

// Cache invalidation
updates.forEach(u => {
  sqls.push("DELETE FROM wiki_pages WHERE slug = '" + u.slug.replace(/'/g, "''") + "';");
});

fs.writeFileSync('tmp_fix_howto_slugs.sql', sqls.join('\n'));
console.log('\nSQL saved. Total statements:', sqls.length);
