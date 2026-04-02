const sql = `SELECT id, person_name, job_slug, stages_json FROM career_trees WHERE id IN (22,23,24,25,26,27,28) ORDER BY id`;
console.log("Run this SQL on production D1:");
console.log(sql);
