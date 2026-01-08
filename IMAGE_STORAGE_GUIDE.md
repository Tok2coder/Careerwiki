# 🖼️ CareerWiki 이미지 저장소 가이드

> 직업/전공 이미지의 생성, 저장, 서빙에 대한 완전한 가이드

---

## 📋 목차

1. [배경 및 문제 상황](#1-배경-및-문제-상황)
2. [아키텍처 개요](#2-아키텍처-개요)
3. [로컬 개발 환경 설정](#3-로컬-개발-환경-설정)
4. [이미지 생성 워크플로우](#4-이미지-생성-워크플로우)
5. [트러블슈팅](#5-트러블슈팅)
6. [전공 이미지 작업](#6-전공-이미지-작업)

---

## 1. 배경 및 문제 상황

### 1.1 원래 구조

```
이미지 생성 API (Evolink) → 이미지 URL 반환 → DB에 URL 저장 → 웹페이지에서 표시
```

### 1.2 발생한 문제들

#### 문제 1: Evolink API 이미지 자동 삭제
- **증상**: 생성 후 3-4일이 지나면 Evolink 서버에서 이미지가 자동 삭제됨
- **원인**: Evolink는 임시 저장소로, 영구 저장을 보장하지 않음
- **영향**: 6,895개 직업 이미지 중 대부분이 404 Not Found

#### 문제 2: 로컬 R2 저장소 접근 불가
- **증상**: `wrangler r2 object put --local`로 저장한 파일을 `wrangler pages dev`에서 접근 불가
- **원인**: 두 명령이 다른 저장소 위치를 사용
  - CLI: `.wrangler/state/v3/r2/careerwiki-uploads/blobs/`
  - 서버: `.wrangler/state/v3/r2/miniflare-R2BucketObject/`

#### 문제 3: URL 인코딩 불일치
- **증상**: 한글 파일명 이미지가 404 반환
- **원인**: 
  - R2 저장 키: `jobs/job-%EA%B0%80%EC%83%81%ED%98%84%EC%8B%A4%EC%A0%84%EB%AC%B8%EA%B0%80.webp` (인코딩)
  - Hono 경로: `jobs/job-가상현실전문가.webp` (자동 디코딩)

---

## 2. 아키텍처 개요

### 2.1 현재 구조 (해결 후)

```
┌─────────────────────────────────────────────────────────────────┐
│                        이미지 생성 흐름                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. DB에서 프롬프트 조회                                          │
│       ↓                                                         │
│  2. Evolink API로 이미지 생성                                     │
│       ↓                                                         │
│  3. 생성된 이미지 다운로드                                         │
│       ↓                                                         │
│  4. Cloudflare R2에 영구 저장                                     │
│       ↓                                                         │
│  5. DB에 R2 URL 저장 (/uploads/jobs/job-{slug}.webp)             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│                        이미지 서빙 흐름                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. 브라우저 요청: /uploads/jobs/job-가상현실전문가.webp            │
│       ↓                                                         │
│  2. Hono 서버: URL에서 인코딩된 경로 추출                          │
│       ↓                                                         │
│  3. R2에서 파일 조회: jobs/job-%EA%B0%80%EC%83%81...              │
│       ↓                                                         │
│  4. 이미지 반환 (캐시 1년)                                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 저장소 구조

```
.wrangler/state/v3/r2/
├── careerwiki-uploads/
│   └── blobs/                    # 실제 이미지 파일 (해시 파일명)
│       ├── 00071402...           # WebP 이미지 데이터
│       ├── 000bbd91...
│       └── ... (6,931개)
│
└── miniflare-R2BucketObject/
    ├── blobs/                    # Junction → careerwiki-uploads/blobs/
    └── 18ff2cc4...sqlite         # 메타데이터 (키-해시 매핑)
        └── _mf_objects 테이블
            ├── key: jobs/job-%EA%B0%80...webp
            └── blob_id: c7d2cd6e...
```

### 2.3 핵심 파일

| 파일 | 용도 |
|------|------|
| `src/index.tsx` | `/uploads/*` 라우트 - R2 이미지 서빙 |
| `src/services/uploadService.ts` | R2 조회/업로드 함수 |
| `package.json` | `npm run dev` 스크립트 |

---

## 3. 로컬 개발 환경 설정

### 3.1 필수 조건

1. **Junction 링크 생성** (한 번만 실행)
```powershell
cmd /c mklink /J ".wrangler\state\v3\r2\miniflare-R2BucketObject\blobs" ".wrangler\state\v3\r2\careerwiki-uploads\blobs"
```

2. **package.json dev 스크립트** (이미 설정됨)
```json
"dev": "npm run build && npx wrangler pages dev dist --d1=careerwiki-db --r2=careerwiki-uploads --local --port 3000"
```

### 3.2 서버 실행

```bash
npm run dev
```

이 명령은:
1. Vite로 빌드
2. wrangler pages dev로 서버 실행
3. D1 + R2 바인딩 포함

### 3.3 URL 인코딩 수정 (이미 적용됨)

`src/index.tsx`의 `/uploads/*` 라우트:

```typescript
app.get('/uploads/*', async (c) => {
  try {
    // Hono가 URL을 자동 디코딩하므로, 원본 URL에서 경로 추출
    const rawUrl = c.req.raw.url
    const urlObj = new URL(rawUrl)
    // pathname은 인코딩된 상태로 유지됨
    const path = urlObj.pathname.replace('/uploads/', '')
    
    if (!path) {
      return c.notFound()
    }
    
    const { getFromR2 } = await import('./services/uploadService')
    const object = await getFromR2(c.env.UPLOADS, path)
    
    if (!object) {
      return c.notFound()
    }
    // ...
  }
})
```

**핵심 포인트**: `c.req.path` 대신 `c.req.raw.url`에서 인코딩된 경로를 추출해야 한글 파일명이 작동함.

---

## 4. 이미지 생성 워크플로우

### 4.1 직업 이미지 (완료됨)

```
총 직업 수: 6,895개
R2 이미지: 6,895개 ✅
DB 매핑: 완료 ✅
```

### 4.2 이미지 생성 스크립트 구조

```javascript
// 1. DB에서 프롬프트 조회
const jobs = db.prepare(`
  SELECT slug, name, image_prompt
  FROM jobs
  WHERE image_prompt IS NOT NULL
    AND (image_url IS NULL OR image_url = '')
`).all();

// 2. Evolink API로 이미지 생성
const taskId = await requestImage(job.image_prompt);
const imageUrl = await checkTaskStatus(taskId);

// 3. 이미지 다운로드 후 R2 업로드
const filename = `job-${job.slug}.webp`;
const r2Key = `jobs/${filename}`;
execSync(`npx wrangler r2 object put careerwiki-uploads/${r2Key} --file="${localPath}" --local`);

// 4. DB 업데이트
db.prepare('UPDATE jobs SET image_url = ? WHERE slug = ?')
  .run(`/uploads/jobs/${filename}`, job.slug);
```

### 4.3 R2 키 형식

| 유형 | R2 키 | DB URL |
|------|-------|--------|
| 직업 | `jobs/job-{slug}.webp` | `/uploads/jobs/job-{slug}.webp` |
| 전공 | `majors/major-{slug}.webp` | `/uploads/majors/major-{slug}.webp` |
| 가이드 | `howto/{timestamp}-{random}.webp` | `/uploads/howto/...` |

---

## 5. 트러블슈팅

### 5.1 이미지가 404 반환

**원인 1: _routes.json 설정 오류** (가장 흔한 원인)
```json
// public/_routes.json에서 /uploads/*가 exclude에 포함되면 Worker가 처리하지 않음
{
  "exclude": [
    "/static/*",
    "/images/*"
    // "/uploads/*"  ← 이 줄이 있으면 안 됨!
  ]
}
```

**원인 2: Junction 링크 없음**
```powershell
# 확인
Get-ChildItem ".wrangler\state\v3\r2\miniflare-R2BucketObject"

# 해결
cmd /c mklink /J ".wrangler\state\v3\r2\miniflare-R2BucketObject\blobs" ".wrangler\state\v3\r2\careerwiki-uploads\blobs"
```

**원인 3: 서버 재시작 필요**
```bash
npm run dev
```

**원인 4: URL 인코딩 문제**
- `src/index.tsx`에서 `c.req.raw.url` 사용하는지 확인

### 5.2 R2에 파일이 저장되지 않음

```bash
# R2 객체 수 확인
node -e "const Database = require('better-sqlite3'); const db = new Database('.wrangler/state/v3/r2/miniflare-R2BucketObject/18ff2cc45daf2fc34011c4fb8bac92efb38a07255e5c66f9012346ba52364739.sqlite'); console.log(db.prepare('SELECT COUNT(*) FROM _mf_objects').get()); db.close();"
```

### 5.3 DB에 image_url이 없음

```bash
# 확인
npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) FROM jobs WHERE image_url IS NULL OR image_url = ''"
```

---

## 6. 전공 이미지 작업

### 6.1 현재 상태

```
총 전공 수: 608개
프롬프트: 608개 완료 ✅
R2 이미지: 608개 완료 ✅
DB 매핑: 완료 ✅
```

### 6.2 전공 이미지 생성 스크립트

`scripts/generate_major_images_r2.cjs` 사용:

```bash
node scripts/generate_major_images_r2.cjs
```

**스크립트 동작**:
1. `majors` 테이블에서 프롬프트가 있고 이미지가 없는 전공 조회
2. Evolink API로 이미지 생성
3. 다운로드 후 `wrangler r2 object put --local`로 R2에 저장
4. DB `image_url` 업데이트: `/uploads/majors/major-{slug}.webp`

### 6.3 전공 이미지 확인

```bash
# 프롬프트 있고 이미지 없는 전공 수
npx wrangler d1 execute careerwiki-db --local --command "SELECT COUNT(*) FROM majors WHERE image_prompt IS NOT NULL AND (image_url IS NULL OR image_url = '')"
```

### 6.4 전공 이미지 서빙

직업과 동일하게 `/uploads/majors/...` 경로로 서빙됩니다.

---

## 7. 체크리스트

### 새 환경 설정 시

- [ ] `.wrangler/state/v3/r2/` 디렉토리 존재 확인
- [ ] Junction 링크 생성 (miniflare → careerwiki-uploads)
- [ ] `npm run dev`로 서버 실행
- [ ] 테스트 이미지 접근 확인

### 이미지 생성 시

- [ ] `.dev.vars`에 `EVOLINK_API_KEY` 설정
- [ ] 프롬프트가 DB에 저장되어 있는지 확인
- [ ] 스크립트 실행 후 R2 저장 확인
- [ ] DB `image_url` 업데이트 확인

### 배포 시

- [ ] 프로덕션 R2에 이미지 업로드 필요 (`--remote` 옵션)
- [ ] 또는 CI/CD에서 R2 동기화 설정

---

## 8. 관련 파일

| 파일 | 용도 |
|------|------|
| `MAJOR_PROMPT_WORKFLOW_GUIDE.md` | 전공 프롬프트 생성 가이드 |
| `PROMPT_WORKFLOW_GUIDE.md` | 직업 프롬프트 생성 가이드 |
| `scripts/generate_major_images_r2.cjs` | 전공 이미지 생성 스크립트 |
| `scripts/check_r2_metadata.cjs` | R2 저장소 확인 스크립트 |
| `scripts/check_blob_mapping.cjs` | blob_id 매핑 확인 스크립트 |

---

**문서 작성일**: 2025-12-21
**마지막 수정**: 2025-12-21

