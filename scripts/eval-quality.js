const queries = [
  // 정확 매치
  '간호사', '변호사', '회계사', '건축가',
  // 동의어/속어
  '철밥통', '코드몽키', '공시생', '판검사', '기레기',
  // 카테고리
  'IT', '의료', '금융', '교육',
  // 복합 의도
  '안정적이면서 연봉 높은 IT 직업', '워라밸 좋고 연봉 괜찮은 사무직', '창의적이면서 돈 잘 버는 직업',
  // tail 노이즈 테스트
  '바리스타', '의료기기', '제약', '품질관리',
  // 키보드 역변환
  'rksghtk', 'qkfltmxk', 'dmltk', 'vkstk', 'qusghtk',
  // 전공 연계
  '경영학', '전자공학', '생명공학', '간호학',
  // 추상 쿼리
  '꿈이 없는데', '뭐 할지 모르겠어요', '적성에 맞는 직업',
  // 오타
  '프로그래머', '데이터 분석가', 'AI 엔지니어',
  // 직업 유형
  '사무직', '전문직', '서비스직', '기술직',
];

(async () => {
  for (const q of queries) {
    const url = 'https://careerwiki.org/search?q=' + encodeURIComponent(q);
    const res = await fetch(url);
    const html = await res.text();
    const regex = /<h2 class="text-lg[^"]*">\s*([^<]+?)\s*<\/h2>/g;
    const jobs = [];
    let m;
    while ((m = regex.exec(html)) !== null) jobs.push(m[1].trim());
    console.log(`[${q}] → ${jobs.slice(0, 5).join(' | ')}`);
    await new Promise(r => setTimeout(r, 300));
  }
})();
