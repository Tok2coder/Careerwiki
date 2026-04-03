const BASE = 'https://careerwiki.org';
const tests = [
  ['rksghtk', '간호사'],
  ['qkfltmxk', '바리스타'],
  ['dmltk', '의사'],
  ['vkstk', '판사'],
  ['qusghtk', '변호사'],
  ['thqkdrhks', '소방관'],
  ['rudckfrhks', '경찰관'],
  ['ghlgytwk', '회계사'],
  ['tnank', '세무사'],
];

async function test(eng, expected) {
  const url = `${BASE}/search?q=${encodeURIComponent(eng)}`;
  const res = await fetch(url, { headers: { 'User-Agent': 'Test/1.0' } });
  const html = await res.text();
  const p = /<h2 class="text-lg sm:text-xl font-bold[^"]*">\s*([^<]+?)\s*<\/h2>/g;
  const jobs = [];
  let m;
  while ((m = p.exec(html)) !== null) jobs.push(m[1].trim());
  const found = jobs.slice(0, 3).join(', ');
  const ok = found.includes(expected) ? 'OK' : 'MISS';
  console.log(`[${ok}] "${eng}" (→${expected}) → ${found || '(없음)'}`);
}

(async () => {
  for (const [e, k] of tests) {
    await test(e, k);
    await new Promise(r => setTimeout(r, 400));
  }
})();
