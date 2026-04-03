const queries = [
  // 정확 매치 — #2-5 노이즈 체크
  '간호사', '변호사', '회계사', '건축가',
  // SLANG — #3-5 노이즈
  '철밥통', '코드몽키', '공시생', '판검사', '기레기',
  // 카테고리
  'IT', '의료', '금융', '교육',
  // tail
  '바리스타', '의료기기', '제약', '품질관리',
  // 키보드
  'rksghtk', 'qkfltmxk', 'dmltk', 'vkstk', 'qusghtk',
  // 전공
  '경영학', '전자공학', '생명공학', '간호학',
  // 추상
  '꿈이 없는데', '뭐 할지 모르겠어요', '적성에 맞는 직업',
  // 오타/변형
  '프로그래머', '데이터 분석가', 'AI 엔지니어',
  // 직업 유형
  '사무직', '전문직', '서비스직', '기술직',
  // 추가 — 각종 노이즈 패턴 확인용
  '바이오', '반도체', '핀테크', '블록체인', '메타버스',
  '외교관', '파일럿', '수의사', '미용사', '기자',
  '소방관', '경찰관', '의사', '치과의사', '약사',
  '요리사', '사진작가', '통역사', '판사', '세무사',
];

(async () => {
  let totalNoise = 0;
  let totalQueries = 0;
  const noiseDetails = [];

  for (const q of queries) {
    const url = 'https://careerwiki.org/search?q=' + encodeURIComponent(q);
    const res = await fetch(url);
    const html = await res.text();
    const regex = /<h2 class="text-lg[^"]*">\s*([^<]+?)\s*<\/h2>/g;
    const jobs = [];
    let m;
    while ((m = regex.exec(html)) !== null) jobs.push(m[1].trim());

    const top5 = jobs.slice(0, 5);
    // 노이즈 판별: 쿼리와 결과 이름 간 문자 겹침 체크
    let noise = [];
    for (let i = 0; i < top5.length; i++) {
      const name = top5[i];
      // 쿼리 문자열(2-gram)이 결과에 포함되는지 체크
      const qClean = q.replace(/[a-zA-Z]/g, ''); // 영문 제거 (키보드 변환용)
      let hasOverlap = false;
      if (qClean.length >= 2) {
        for (let j = 0; j <= qClean.length - 2; j++) {
          if (name.includes(qClean.slice(j, j + 2))) { hasOverlap = true; break; }
        }
      }
      // 키보드 변환 쿼리는 변환 결과로 체크해야 하므로 일단 모두 OK로
      if (/^[a-zA-Z]+$/.test(q)) hasOverlap = true;
      if (!hasOverlap && i >= 2) {
        noise.push(`#${i+1}:${name}`);
      }
    }

    console.log(`[${q}] → ${top5.join(' | ')}${noise.length > 0 ? `  ⚠️ NOISE: ${noise.join(', ')}` : ''}`);
    if (noise.length > 0) {
      totalNoise += noise.length;
      noiseDetails.push({ query: q, noise });
    }
    totalQueries++;
    await new Promise(r => setTimeout(r, 300));
  }

  console.log(`\n=== 노이즈 요약 ===`);
  console.log(`총 쿼리: ${totalQueries}, 노이즈 항목: ${totalNoise}`);
  for (const d of noiseDetails) {
    console.log(`  [${d.query}] ${d.noise.join(', ')}`);
  }
})();
