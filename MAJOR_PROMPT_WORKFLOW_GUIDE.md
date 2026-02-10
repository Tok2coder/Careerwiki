# 🎨 CareerWiki 전공 이미지 프롬프트 작업 가이드

> **AI 지시사항**: 이 문서는 전공 이미지 생성을 위한 프롬프트 작업 가이드입니다.
> 사용자가 "전공 프롬프트 시작해" 또는 "다음 전공 배치 진행해"라고 하면 아래 워크플로우를 따르세요.

---

## 📊 진행 상황 (AI가 업데이트)

| 배치 | 상태 | 완료일 | 비고 |
|------|------|--------|------|
| 배치 1 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 2 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 3 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 4 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 5 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 6 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 7 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 8 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 9 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 10 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 11 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 12 (50개) | ✅ 프롬프트 완료 | 2025-12-19 | 50개 프롬프트 삽입 완료 |
| 배치 13 (8개) | ✅ 프롬프트 완료 | 2025-12-19 | 8개 프롬프트 삽입 완료 |

**범례**: ⬜ 대기 | 🔄 진행중 | ✅ 프롬프트 완료 | 🖼️ 이미지 생성 완료

**전체 진행률**: 13 / 13 배치 (100%)

**총 전공 수**: 608개

---

## 🤖 AI 작업 워크플로우

### 사용자가 "전공 프롬프트 시작해" 또는 "다음 전공 배치 진행해"라고 하면:

```
1. 위 "진행 상황" 테이블에서 ⬜ 대기 중인 첫 번째 배치 찾기
2. 해당 배치 JSON 파일 읽기: scripts/major_batch_{N}_majors.json
3. 50개(또는 남은) 전공에 대해 프롬프트 생성 (아래 규칙 준수)
4. 프롬프트 삽입 스크립트 생성: scripts/insert_major_prompts_batch{N}.cjs
5. 스크립트 실행하여 DB에 프롬프트 저장
6. 진행 상황 테이블 업데이트 (⬜ → ✅)
7. 다음 배치로 자동 진행하지 말고, 사용자에게 결과 보고
```

### 사용자가 "전공 이미지 생성해"라고 하면:

```
1. node scripts/generate_major_images_r2.cjs 실행
2. 결과 보고
```

---

## 📁 파일 위치

| 용도 | 경로 |
|------|------|
| 배치 목록 (참고용) | `scripts/major_batch_{N}_majors.json` |
| 프롬프트 삽입 스크립트 (AI가 생성) | `scripts/insert_major_prompts_batch{N}.cjs` |
| 이미지 생성 + R2 저장 스크립트 | `scripts/generate_major_images_r2.cjs` |

---

## 🎯 프롬프트 생성 규칙 (필수 준수)

### 1. 고정 비버 묘사 (모든 프롬프트 시작)
```
A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style,
```

### 2. 학문적 동작 (MANDATORY)
- 비버가 **{전공명}**에 적합한 **명확하고 물리적인 학문/연구 관련 동작** 수행
- 학술 자료, 연구 도구, 실험실 장비, 기구, 도표, 표본, 모형 또는 창작물과 **직접적이고 가시적인 상호작용** 필수
- 구체적이고 시각적으로 명확한 동작 (예: 모형 조립, 기구 조정, 샘플 검사, 도표 스케치, 시뮬레이션 설정, 물질 혼합)
- **금지**: "studying", "learning", "researching", "analyzing" 같은 추상적 동작 (물리적 상호작용 없이)

### 3. 학문적 도구 & 복장
- 전공이 특정 연구 복장, 보호 장비, 학문적 장비를 사용한다면 (예: 실험복, 보안경, 현장 장비, 헤드셋) 비버가 그것의 단순화된 버전을 착용하거나 사용
- 해당 분야의 특징이 아니면 일반적인 복장 설명 피하기

### 4. 학문적 환경
- **{전공명}**과 명백하게 연관된 넓고 상세한 학습/연구 환경 묘사
- 해당 분야에 고유한 특정 학술 도구, 기구, 재료, 장치, 모형, 공간 요소 포함
- **금지**: "academic workspace", "related tools", "appropriate equipment" 같은 일반적 문구

### 5. 캐릭터 크기 (고정)
```
the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground,
```

### 6. 렌더링 스타일 (고정, 모든 프롬프트 끝)
```
rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.
```

### 7. 금지 항목
- 텍스트, 라벨, 간판, 숫자, 목록, 메타 코멘트, 로고
- 사실적인 인간이나 동물

---

## 📝 프롬프트 템플릿 (복사해서 사용)

```
A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, wearing [전공별 복장/장비], actively [구체적인 학문적 동작] with [도구/장비] in a [전공 관련 구체적 환경] surrounded by [전공 관련 물품 3~5개], the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.
```

---

## 📜 프롬프트 삽입 스크립트 템플릿

**파일명**: `scripts/insert_major_prompts_batch{N}.cjs`

```javascript
/**
 * 전공 배치 {N} 프롬프트 삽입 스크립트
 * 생성일: {날짜}
 * 전공 수: {개수}개
 */

const { execSync } = require('child_process');
const fs = require('fs');

const prompts = [
  {
    id: "전공ID1",
    prompt: `A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, wearing [복장], actively [동작] with [도구] in a [환경] surrounded by [물품들], the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.`
  },
  {
    id: "전공ID2",
    prompt: `...`
  },
  // ... 나머지 전공들
];

async function insertPrompts() {
  console.log(`🎨 전공 배치 {N}: ${prompts.length}개 프롬프트 삽입 시작...\n`);

  const updates = prompts.map(item => {
    const escapedPrompt = item.prompt.replace(/'/g, "''");
    return `UPDATE majors SET image_prompt = '${escapedPrompt}' WHERE id = '${item.id}';`;
  });

  const sqlContent = updates.join('\n');
  const sqlFileName = 'temp_major_batch{N}.sql';
  fs.writeFileSync(sqlFileName, sqlContent);

  try {
    execSync(`npx wrangler d1 execute careerwiki --local --file ${sqlFileName}`, { 
      stdio: 'inherit',
      cwd: process.cwd()
    });
    console.log(`\n✅ 전공 배치 {N} 프롬프트 삽입 완료! (${prompts.length}개)`);
  } catch (error) {
    console.error('❌ 오류 발생:', error.message);
  } finally {
    fs.unlinkSync(sqlFileName);
  }
}

insertPrompts();
```

---

## 🔍 검증 명령어

### 프롬프트 삽입 후 확인
```bash
# 새 프롬프트가 있고 이미지가 없는 전공 수 확인
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) as count FROM majors WHERE image_prompt IS NOT NULL AND image_prompt != '' AND (image_url IS NULL OR image_url = '')"
```

### 특정 전공 프롬프트 확인
```bash
npx wrangler d1 execute careerwiki --local --command "SELECT name, SUBSTR(image_prompt, 1, 200) FROM majors WHERE name LIKE '%컴퓨터%'"
```

---

## 💡 예시: 전공별 프롬프트

### 컴퓨터공학 (Computer Science)
```
A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, wearing a casual hoodie with small headphones around neck, actively assembling a small circuit board with a soldering iron and tweezers in a modern computer lab surrounded by multiple monitors displaying code, a mechanical keyboard, server racks with blinking LEDs, tangled ethernet cables, and a whiteboard covered in algorithm flowcharts, the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.
```

### 생명과학 (Biology)
```
A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, wearing a miniature lab coat and tiny safety goggles, actively examining a petri dish under a microscope with gloved paws in a biology research laboratory surrounded by DNA helix models, specimen jars with preserved samples, centrifuge machines, pipettes in racks, and colorful test tubes in holders, the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.
```

### 경영학 (Business Administration)
```
A small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style, wearing a small business casual blazer, actively pointing at a presentation chart with a tiny laser pointer in a modern business school lecture hall surrounded by financial graphs on screens, case study documents, a Bloomberg terminal display, business textbooks stacked on desks, and a whiteboard with SWOT analysis diagrams, the beaver appearing very small at about 12% of the frame, positioned naturally in the foreground, rendered in 2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, cinematic rim light using a dark-mode palette of deep navy, muted violet, soft teal glow accents with rich background depth.
```

---

## 📋 배치별 전공 요약

| 배치 | 전공 수 | 첫 번째 전공 | 마지막 전공 |
|------|---------|-------------|-------------|
| 1 | 50 | (major_batch_1_majors.json 확인) | - |
| 2 | 50 | (major_batch_2_majors.json 확인) | - |
| ... | ... | ... | ... |
| 13 | 8 | (major_batch_13_majors.json 확인) | - |

**총 전공 수**: 608개

---

## 🚀 빠른 시작 (AI용)

사용자가 작업 시작을 요청하면:

```bash
# 1. 다음 배치 파일 읽기
cat scripts/major_batch_1_majors.json

# 2. 프롬프트 스크립트 생성 (위 템플릿 사용)
# → scripts/insert_major_prompts_batch1.cjs 파일 생성

# 3. 스크립트 실행
node scripts/insert_major_prompts_batch1.cjs

# 4. 검증
npx wrangler d1 execute careerwiki --local --command "SELECT COUNT(*) FROM majors WHERE image_prompt IS NOT NULL AND (image_url IS NULL OR image_url = '')"

# 5. 이 문서의 진행 상황 테이블 업데이트
```

---

## ⚠️ 주의사항

1. **id 정확히 사용**: `major_batch_{N}_majors.json`의 id 값을 그대로 복사 (slug가 아닌 id 사용!)
2. **작은따옴표 이스케이프**: 프롬프트 내 `'`는 `''`로 자동 변환됨
3. **한 배치씩 진행**: 50개 단위로 프롬프트 작성 후 저장
4. **이미지 생성**: 프롬프트 완료 후 `generate_major_images_r2.cjs` 실행
5. **R2 즉시 저장**: Evolink 이미지는 3-4일 후 삭제되므로 즉시 R2에 저장

---

**문서 생성일**: 2025-12-19

