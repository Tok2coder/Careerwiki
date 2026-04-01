# 썸네일 & 인라인 이미지 생성

## 5-1. 썸네일 생성

```bash
# Step 1: 이미지 생성 요청 (HowTo 전용 slug 사용!)
curl -X POST https://careerwiki.org/api/image/generate \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "type": "jobs",
    "slug": "howto-TOPIC-thumb",
    "promptOverride": "[아래 스타일 풀에서 랜덤 선택] + [주제 설명]"
  }'
# → { "taskId": "task-unified-...", "estimatedTime": 32 }

# Step 2: 30~40초 대기 후 상태 확인
curl https://careerwiki.org/api/image/status/TASK_ID \
  -H "Cookie: session_token=SESSION_TOKEN"
# → { "status": "completed", "imageUrl": "https://files.evolink.ai/..." }

# Step 3: R2에 영구 저장 (필수! evolink URL은 4~5일 후 만료)
curl -X POST https://careerwiki.org/api/image/save \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "taskId": "TASK_ID",
    "type": "jobs",
    "slug": "HowTo-TOPIC",
    "imageUrl": "https://files.evolink.ai/.../image.webp"
  }'
# → { "imageUrl": "/uploads/jobs/job-HowTo-TOPIC.webp?v=..." }
# 이 /uploads/... 경로를 thumbnailUrl로 사용한다
```

**중요**: publish body의 `thumbnailUrl`에는 R2 경로(`/uploads/jobs/job-HowTo-TOPIC.webp`)를 사용.

---

## 5-1b. 이미지 스타일 풀 (매번 다른 스타일 사용!)

**규칙**: 매 HowTo마다 이전 글과 다른 스타일을 선택한다. 기존 발행글의 썸네일 스타일과 겹치지 않게 로테이션.

| # | 스타일명 | promptOverride 템플릿 | 분위기 |
|---|---------|----------------------|--------|
| 1 | **Isometric 3D** | `Isometric 3D illustration of [주제], vibrant colors, soft shadows, white background, game-like aesthetic` | 귀엽고 입체적 |
| 2 | **Flat Vector** | `Minimal flat vector illustration of [주제], bold geometric shapes, limited color palette of 4 colors, no outlines` | 깔끔 모던 |
| 3 | **Watercolor** | `Watercolor painting style illustration of [주제], soft pastel tones, artistic brush strokes, dreamy atmosphere` | 감성적 |
| 4 | **Retro Pop** | `Retro pop art style illustration of [주제], halftone dots, bold primary colors, comic book aesthetic, vintage feel` | 복고 에너지 |
| 5 | **Neon Gradient** | `Futuristic neon gradient illustration of [주제], dark background, glowing edges, cyberpunk-inspired, purple and teal tones` | 미래지향 |
| 6 | **Line Art** | `Elegant line art illustration of [주제], single continuous line style, minimal detail, white background, gold accent color` | 세련 미니멀 |
| 7 | **Paper Cut** | `Paper cut layered illustration of [주제], depth effect with shadows between layers, craft-like texture, warm colors` | 공예 느낌 |
| 8 | **Pixel Art** | `Pixel art illustration of [주제], 16-bit retro game style, bright colors, nostalgic, clean pixel grid` | 레트로 게임 |

**사용 예시**: 기존에 1(Isometric)과 2(Flat Vector)를 썼으면, 다음 글은 3~8 중에서 선택.

**주제와 스타일 매칭 가이드**:
- 체력/스포츠 주제 → Retro Pop, Isometric 3D
- 시험/공부 주제 → Flat Vector, Line Art
- 기술/IT 주제 → Neon Gradient, Pixel Art
- 예술/감성 주제 → Watercolor, Paper Cut

---

## 5-2. 인라인 이미지 생성 (필수)

모든 HowTo 가이드에는 본문 중간에 인포그래픽/상황 이미지를 **1~2개 필수**로 포함한다.
텍스트만 있는 글은 가독성이 떨어지고 시각적 흥미가 부족하다.

### 프롬프트 작성 가이드

> ⚠️ **텍스트 포함 이미지 절대 금지**
> - AI 이미지 생성기는 텍스트 렌더링이 불안정하여 깨진 글자가 표시된다.
> - 프롬프트에 텍스트, 글자, 단어, 레이블, 차트 라벨 등 문자가 포함되는 이미지를 요청하지 마라.
> - 인포그래픽, 차트, 데이터 비주얼라이제이션 등 텍스트가 필수인 이미지 대신, 추상적/시각적 일러스트레이션으로 대체한다.
> - 모든 프롬프트 끝에 반드시 `no text, no words, no labels, no typography` 네거티브 지시를 포함한다.

**기본 프롬프트** (간단한 아이콘/인포그래픽):
```
Abstract visual illustration of [내용], clean vector style, white background, no text, no words, no labels
```

**고화질 프롬프트** (매 2~3개 글 중 최소 1개는 이 수준으로 작성):
장면 묘사, 조명, 구도, 분위기를 구체적으로 지정하면 퀄리티 높은 이미지가 나온다.

```
예시 1 (시험 공부 장면):
A focused Korean university student studying late at night in a cozy study cafe,
warm desk lamp casting golden light on open textbooks and handwritten notes,
a laptop showing practice exam questions, coffee cup beside the desk,
photorealistic style, shallow depth of field, cinematic lighting,
warm amber and cool blue tones, 4K detail,
no text, no words, no labels, no typography

예시 2 (체력 훈련 장면):
Dynamic action shot of a young Korean athlete sprinting on a red track field,
early morning golden hour sunlight, motion blur on legs suggesting speed,
Olympic-quality stadium in background, determined facial expression,
professional sports photography style, high contrast, vivid colors,
no text, no words, no labels, no typography

예시 3 (직업 현장):
A modern hospital emergency room scene with medical professionals in action,
soft fluorescent lighting, medical equipment and monitors in background,
a young Korean doctor reviewing patient charts on a tablet,
documentary photography style, natural colors, authentic atmosphere,
no text, no words, no labels, no typography

예시 4 (기술/IT):
Aerial view of a developer's dual-monitor workspace with code editor open,
dark theme IDE showing colorful syntax-highlighted code,
mechanical keyboard, succulent plant, and coffee mug on a clean minimal desk,
tech aesthetic, cool blue and purple ambient lighting, ultra-detailed,
no text, no words, no labels, no typography

예시 5 (추상/기술 네트워크):
Abstract visualization of multiple interconnected technology nodes and glowing connections,
dark background, purple and teal gradient tones, futuristic digital network aesthetic,
no text, no words, no labels, no typography
```

**프롬프트 품질 규칙**:
- 3개 글 연속으로 단순 프롬프트만 쓰지 않는다
- 핵심 이미지(글의 메인 비주얼)는 고화질 프롬프트 권장
- 보조 이미지(표 아래 아이콘 등)는 간단 프롬프트 OK
- 한국인/한국 배경 포함 시 독자 친근감 상승
- **텍스트가 등장하는 모든 시각 요소(인포그래픽, 차트, 다이어그램, 표 이미지)는 생성하지 않는다**

### 생성 & 저장

```bash
# evolink API로 생성 (slug는 howto 전용으로!)
curl -X POST https://careerwiki.org/api/image/generate \
  -H "Content-Type: application/json" \
  -H "Cookie: session_token=SESSION_TOKEN" \
  -d '{
    "type": "jobs",
    "slug": "howto-TOPIC-img1",
    "promptOverride": "여기에 상세 프롬프트 작성"
  }'
```

인라인 이미지도 `/api/image/save`로 R2에 저장 후 R2 경로를 사용한다:
```json
{ "type": "image", "attrs": {
  "src": "/uploads/jobs/job-howto-TOPIC-img1.webp",
  "alt": "이미지 설명",
  "width": 720,
  "align": "center"
} }
```

**배치 위치**: 테이블 바로 다음, 또는 섹션 전환부에 자연스럽게 삽입.
