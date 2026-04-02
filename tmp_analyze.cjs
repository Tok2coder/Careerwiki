const fs = require('fs');

function analyze(file, label) {
  const raw = fs.readFileSync(file, 'utf8');
  // Parse the wrangler output JSON
  const startIdx = raw.indexOf('[');
  const jsonPart = raw.substring(startIdx);
  const endIdx = jsonPart.lastIndexOf(']') + 1;
  const parsed = JSON.parse(jsonPart.substring(0, endIdx));
  const html = parsed[0].results[0].content;

  const text = html.replace(/<[^>]+>/g, '').replace(/&[a-z]+;/g, ' ');
  const h2 = (html.match(/<h2/g) || []).length;
  const h3 = (html.match(/<h3/g) || []).length;
  const tables = (html.match(/<table/g) || []).length;
  const lists = (html.match(/<[uo]l/g) || []).length;
  const paras = (html.match(/<p/g) || []).length;
  const imgs = (html.match(/<img/g) || []).length;

  console.log('=== ' + label + ' ===');
  console.log('HTML:', html.length, '| 순수텍스트:', text.length);
  console.log('H2:', h2, '| H3:', h3, '| 테이블:', tables, '| 리스트:', lists, '| 문단:', paras, '| 이미지:', imgs);
}

analyze('tmp_best_article.json', '의사국시 (초기, id=3854)');
analyze('tmp_today_article.json', '토익900 (오늘, id=6615)');
