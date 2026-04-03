/**
 * 이미지 파이프라인 디버깅 스크립트
 * 전체 흐름을 추적합니다.
 */

const Database = require('better-sqlite3');
const path = require('path');

const dbPath = path.resolve(__dirname, '../.wrangler/state/v3/d1/miniflare-D1DatabaseObject/926ac646196f97cbbf82a014f1749799d60a709010a65dbb289e4b2e6132a340.sqlite');
const db = new Database(dbPath);

const slug = '가상현실전문가';

console.log('='.repeat(60));
console.log('🔍 이미지 파이프라인 디버깅');
console.log('='.repeat(60));

// 1. DB에서 직접 조회
console.log('\n📦 [1단계] DB 직접 조회');
const directQuery = db.prepare(`
  SELECT id, name, slug, image_url, image_alt, image_prompt,
         merged_profile_json IS NOT NULL as has_merged_profile
  FROM jobs 
  WHERE slug = ?
`).get(slug);

console.log('- id:', directQuery.id);
console.log('- name:', directQuery.name);
console.log('- slug:', directQuery.slug);
console.log('- image_url:', directQuery.image_url);
console.log('- image_alt:', directQuery.image_alt);
console.log('- image_prompt 길이:', directQuery.image_prompt?.length || 0);
console.log('- has_merged_profile:', directQuery.has_merged_profile);

// 2. merged_profile_json 확인
console.log('\n📦 [2단계] merged_profile_json 확인');
const mergedQuery = db.prepare(`
  SELECT merged_profile_json
  FROM jobs 
  WHERE slug = ?
`).get(slug);

if (mergedQuery.merged_profile_json) {
  const merged = JSON.parse(mergedQuery.merged_profile_json);
  console.log('- merged_profile_json에 image_url 있음?:', 'image_url' in merged);
  console.log('- merged_profile_json에 image_alt 있음?:', 'image_alt' in merged);
  if (merged.image_url) {
    console.log('- merged image_url:', merged.image_url);
  }
} else {
  console.log('- merged_profile_json: 없음');
}

// 3. profileDataService가 SELECT하는 쿼리 시뮬레이션
console.log('\n📦 [3단계] profileDataService SELECT 시뮬레이션');
const serviceQuery = db.prepare(`
  SELECT id, name, slug, merged_profile_json,
         user_contributed_json, admin_data_json,
         image_url, image_alt
  FROM jobs 
  WHERE slug = ? AND merged_profile_json IS NOT NULL AND merged_profile_json != '{}'
  LIMIT 1
`).get(slug);

if (serviceQuery) {
  console.log('- SELECT 결과 있음 ✅');
  console.log('- image_url:', serviceQuery.image_url);
  console.log('- image_alt:', serviceQuery.image_alt);
  
  // 최종 profile 객체 시뮬레이션
  let profile = JSON.parse(serviceQuery.merged_profile_json);
  
  // image_url, image_alt 추가 (profileDataService 로직)
  if (serviceQuery.image_url && serviceQuery.image_url !== 'null') {
    profile.image_url = serviceQuery.image_url;
  }
  if (serviceQuery.image_alt) {
    profile.image_alt = serviceQuery.image_alt;
  }
  
  console.log('\n📦 [4단계] 최종 profile 객체');
  console.log('- profile.image_url:', profile.image_url);
  console.log('- profile.image_alt:', profile.image_alt);
  console.log('- profile.name:', profile.name);
} else {
  console.log('- SELECT 결과 없음 ❌');
}

// 4. 이미지 URL 접근 테스트
console.log('\n📦 [5단계] 이미지 URL 접근 테스트');
const imageUrl = directQuery.image_url;
if (imageUrl && imageUrl !== 'null') {
  console.log('- 이미지 URL:', imageUrl);
  console.log('- URL 유효성: 테스트 중...');
  
  fetch(imageUrl, { method: 'HEAD' })
    .then(res => {
      console.log('- HTTP 상태:', res.status);
      console.log('- Content-Type:', res.headers.get('content-type'));
      console.log('- 접근 가능: ✅');
    })
    .catch(err => {
      console.log('- 접근 오류:', err.message);
      console.log('- 접근 가능: ❌');
    });
} else {
  console.log('- 이미지 URL 없음');
}

// 5. 템플릿에서 사용하는 조건 확인
console.log('\n📦 [6단계] 템플릿 조건 확인');
const heroImageUrl = profile?.image_url;
const condition1 = heroImageUrl ? '참' : '거짓';
const condition2 = heroImageUrl && heroImageUrl.trim() !== '' ? '참' : '거짓';
console.log('- heroImageUrl:', heroImageUrl);
console.log('- heroImageUrl 존재?:', condition1);
console.log('- heroImageUrl && heroImageUrl.trim() !== "":', condition2);

console.log('\n' + '='.repeat(60));
console.log('✅ 디버깅 완료');
console.log('='.repeat(60));


