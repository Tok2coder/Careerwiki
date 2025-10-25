# Phase 1 Task 3 — Detail Telemetry Guide

## 목적
- 직업 상세 SSR 템플릿(`src/templates/unifiedJobDetail.ts`)과 프론트엔드 하이드레이션 레이어(`public/static/api-client.js`)에 적용된 텔레메트리 속성과 이벤트 흐름을 정리합니다.
- Growth Marketing Director UI/UX 리팩터링에서 도입한 계측을 유지하면서, 변호사 페이지에 한정해 히어로 메타 칩을 제거하고 법조 비교 매트릭스로 시선을 전환한 배경을 문서화합니다.
- Phase 1 Task 3 범위 내에서 수집·전송해야 하는 이벤트 명세, 페이로드 구조, 장애 대비 가이드라인을 제공합니다.

---

## 1. SSR 레이어 데이터 속성 맵
| 블록 | 루트 data-* | 주요 하위 data-* | 설명 |
| --- | --- | --- | --- |
| 히어로 섹션 | `data-job-hero` | `data-cw-telemetry-component="job-hero-summary"`, `data-cw-telemetry-scope="job-hero-actions"` | 직업 요약과 공유 액션을 계측. Phase 1 Task 3 기준 변호사 변형(`lawyer-live-data-v1`)에서는 히어로 메타 칩을 제거하고 Quick Stats와 비교 매트릭스에 집중합니다. |
| Quick Stats 카드 | `data-cw-telemetry-component="job-quick-stats"` | `data-cw-telemetry-component="job-quick-stat"`, `data-source-group` | 급여/전망/만족도/고용 형태 등 핵심 지표. 각 카드에 출처별 상태(`커리어넷 · 실시간 데이터`)가 포함됩니다. |
| 개요 카드 영역 | `data-cw-job-overview` | `data-cw-telemetry-component="job-overview-card"` | 하는 일/커리어 전망/핵심 능력/임금 정보 등. Anchor ID 기반 TOC 연동. |
| 상세 카드 영역 | `data-cw-job-details` | `data-cw-telemetry-component="job-detail-card"` | 학력·전공 분포, KECO 코드, 업무 지표 등. |
| 사이드바 | `data-job-sidebar` | `data-job-sidebar-section` | 연관 직업/전공/자격증/기관, HowTo 추천. |
| 데이터 출처 패널 | `data-job-sources` | `data-source-collapsible`, `data-source-toggle` | CareerNet/고용24 부분 소스 상태, 오류 메시지 포함. |
| 법조 직업 비교 매트릭스 | `data-job-lawyer-matrix` | `data-cw-telemetry-component="job-source-matrix-card"`, `data-job-source-matrix`, `data-cw-telemetry-component="job-source-matrix-cell"` | 변호사 식별 시 CareerNet vs 고용24 필드를 필드별로 비교하며, 각 셀에 출처 상태가 기록됩니다. |
| 커뮤니티 블록 | `data-job-community` | `data-cw-telemetry-scope="job-comments"` (클라이언트) | 샘플 댓글 및 향후 실시간 댓글 폼을 위한 프레임. |

---

## 2. 클라이언트 텔레메트리 이벤트 흐름
프론트엔드 런타임(`public/static/api-client.js`)에서는 `DetailTelemetry` 모듈이 다음 이벤트를 발행합니다.

| 이벤트 | 트리거 | 페이로드 핵심 | 비고 |
| --- | --- | --- | --- |
| `cw-hydration-ready` | SSR 템플릿 하이드레이션 완료 | `{ version, path, sessionId, sourceSummary }` | AbortController 기반 타임아웃(4s)으로 장애 대비. |
| `cw-hydration-error` | 하이드레이션 예외 발생 | `{ error, component, stack }` | 서버·클라이언트 양쪽 로그 대응 필요. |
| `cw-detail-action` | TOC 클릭, Quick Stat hover, 댓글 CTA 등 | `{ action, component, scope, meta }` | `data-cw-telemetry-action`/`-component`/`-scope` 속성을 통해 자동 수집. |

### Phase 1 Task 3 보강 계측
- **공유 인터랙션 추적**: 히어로 공유 버튼(`data-cw-telemetry-component="job-share-trigger"`, `data-cw-telemetry-action="share-open"`)과 복사 버튼(`job-share-copy`, `share-copy`)에 텔레메트리 속성을 부여해 `cw-detail-action` 이벤트로 오픈/복사 동작을 수집합니다. 패널(`job-share-panel`) 역시 동일 스코프(`job-hero-actions`)로 그룹화했습니다.
- **고용24 재시도 로깅**: `goyong24API.fetchXml` 호출 시 Cloudflare Worker에서 헤더 프로필을 순환하며 재시도하며, 각 실패Attempt는 `[goyong24]` 로그로 HTTP 상태·요약 스니펫을 남깁니다. 반환 본문이 HTML(차단 페이지)일 경우에도 텔레메트리 메타에 `error`가 기록되도록 보정했습니다.
- **Variant 태깅**: 히어로 섹션, Quick Stats, 변호사 매트릭스, 공유 액션에 `data-cw-telemetry-variant`가 전파됩니다. 현재 지원되는 값은 `growth-marketing-director-phase1`(그로스 마케팅 디렉터)과 `lawyer-live-data-v1`(변호사 실데이터 통합)입니다.
- **법조 소스 비교 매트릭스**: `data-job-lawyer-matrix` 래퍼와 `data-job-source-matrix` 테이블은 셀 단위로 `data-source-group`/`data-source-status`를 표기합니다. CareerNet·고용24 각각의 데이터 가용 여부가 그대로 텔레메트리 메타에 반영됩니다.

### AbortController & Fallback
- `DetailTelemetry`는 AbortController를 이용해 4초 내 이벤트 전송이 이뤄지지 않을 경우 전송을 취소하고 콘솔 경고를 남깁니다.
- 실패 시 `cw-hydration-error`가 전송되며, 백오프 대기(3초) 후 재시도하도록 설계되었습니다.

---

## 3. 페이로드 구조 & 샘플
```jsonc
{
  "version": "phase1-task3",
  "path": "/job/growth-marketing-director",
  "sessionId": "cw-20241015-abcdef",
  "component": "job-quick-stat",
  "action": "hover",
  "meta": {
    "label": "평균 연봉",
    "source": "GOYONG24",
    "status": "실시간 데이터"
  }
}
```

### 출처 상태 라벨 규칙
- `실시간 데이터`: `count > 0`
- `오류 발생`: `error` 메시지 존재
- `응답 없음`: 호출했으나 `count`가 0이고 오류가 없음
- `키워드 필요 / 식별자 필요 / 추가 정보 필요 / 샘플 데이터` 등: `skippedReason` 값을 `SKIPPED_REASON_MESSAGES`로 변환

---

## 4. QA 체크리스트
1. **히어로 요약 & 공유 버튼**
   - 상단 요약 문장이 `data-cw-telemetry-component="job-hero-summary"`로 출력되는지 확인
   - 공유 버튼(`job-share-trigger`) 클릭 시 `cw-detail-action` 이벤트(`action=share-open`)가 발생하고, 복사 버튼(`share-copy`) 계측도 동작하는지 확인
2. **변호사 타이틀 및 메타데이터**
   - `/job/lawyer` 페이지의 `<title>`과 히어로 H1이 모두 "변호사"로 노출되는지 확인
   - JSON-LD와 Canonical URL이 `lawyer` 슬러그를 반영하며 `job:C_375` 토큰이 노출되지 않는지 검수
3. **법조 매트릭스 노출**
   - `data-job-lawyer-matrix` 섹션이 렌더링되고, 각 셀의 `data-source-group`/`data-source-status`가 CareerNet·고용24 상태와 일치하는지 확인
   - 고용24 응답 실패 시 `오류 발생` 라벨과 `제공 안됨` 텍스트로 폴백되는지 검증 (WAF 차단시 로그에 `[goyong24]` 경고가 남아야 함)
4. **Quick Stats 툴팁**
   - 각 카드의 `data-source-group` 값이 CareerNet/고용24와 일치하는지 DevTools에서 확인
5. **TOC & 앵커**
   - `data-toc-target` 앵커가 개요/상세 카드 ID와 일치하는지 확인
6. **이벤트 캡처**
   - 네트워크 탭에서 `cw-detail-action` POST가 발생하는지 확인 (`?debugTelemetry=1` 옵션 사용 가능)
   - AbortController 작동 여부 테스트: 브라우저 네트워크를 Offline으로 전환 후 재시도

---

## 5. 향후 확장 가이드
- **법률 직업군**: 히어로 칩을 제거했으므로 분류 정보는 상세 카드와 비교 매트릭스를 통해 노출합니다. `profile.classifications` 정규화는 유지하여 향후 칩 복원이나 검색 필터링에 활용할 수 있습니다.
- **데이터 파이프라인 연동**: `cw-detail-action` 채널을 Cloudflare Workers Logpush + D1 테이블로 수집 예정 (Phase 2)
- **A/B 실험**: Quick Stats 순서나 Hero Summary 길이를 `data-experiment-variant` 속성으로 구분해 비교 가능

---

## 참고 링크
- SSR 템플릿: [`src/templates/unifiedJobDetail.ts`](../src/templates/unifiedJobDetail.ts)
- 텔레메트리 스택: [`public/static/api-client.js`](../public/static/api-client.js)
- 프로필 병합 로직: [`src/services/profileMerge.ts`](../src/services/profileMerge.ts)
