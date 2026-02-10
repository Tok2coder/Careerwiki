// src/services/ai-analyzer/resume-parser.ts
// ============================================
// P0: 이력서 텍스트 파싱 (클라이언트 pdf.js → 서버 텍스트만 처리)
// P0-8: PDF 원본 저장은 P1으로 미룸
// ============================================

import type { Ai } from '@cloudflare/workers-types'
import type { CareerState, RoleIdentity, CareerStageYears, TransitionStatus, SkillLevel, CareerConstraints } from './career-tree-types'

// ============================================
// 파싱 결과 타입
// ============================================
export interface ParsedResumeData {
  // 5축 상태 좌표 추론
  inferred_state: {
    role_identity: RoleIdentity | null
    role_identity_subtype?: string
    career_stage_years: CareerStageYears | null
    transition_status: TransitionStatus | null
    skill_level: SkillLevel | null
    constraints: Partial<CareerConstraints>
  }

  // 추출된 정보 (마스킹됨)
  extracted: {
    // ⚠️ 회사명/학교명은 절대 추출하지 않음!
    skills: string[]                    // 기술 스택
    certifications: string[]            // 자격증
    education_level: string | null      // 학력 수준 (고졸/전문대/4년제/대학원)
    total_experience_years: number | null
    current_role_type: string | null    // 역할 유형 (개발자/기획자/디자이너 등)
    industries: string[]                // 경험 업종 (IT/금융/제조 등)
    job_change_count: number | null     // 이직 횟수
    employment_gap: boolean             // 경력 단절 여부
  }

  // 파싱 메타데이터
  meta: {
    parsed_at: string
    text_length: number
    warnings: string[]
  }
}

// ============================================
// LLM 프롬프트 (회사명/학교명 추출 금지!)
// ============================================
const RESUME_PARSE_SYSTEM_PROMPT = `당신은 이력서 분석 전문가입니다. 이력서 텍스트를 분석하여 커리어 상태를 추론합니다.

## ⚠️ 절대 금지 규칙 (개인정보 보호)
1. **회사명** 절대 추출 금지 (예: 삼성, 네이버, 카카오, 구글 등)
2. **학교명** 절대 추출 금지 (예: 서울대, 연세대, 고려대 등)
3. **개인 이름** 절대 추출 금지
4. **이메일/전화번호** 절대 추출 금지
5. **구체적인 프로젝트명** 추출 금지 (예: "XX 시스템 개발" → "대규모 시스템 개발"로 일반화)

## 추출해야 하는 정보
1. **기술 스택**: 프로그래밍 언어, 프레임워크, 도구 등
2. **자격증**: 정보처리기사, AWS 자격증 등
3. **학력 수준**: 고졸/전문대/4년제/대학원 (학교명 제외!)
4. **총 경력 연수**: 숫자로
5. **역할 유형**: 개발자/기획자/디자이너/마케터 등
6. **경험 업종**: IT/금융/제조/유통 등 (회사명 제외!)
7. **이직 횟수**: 대략적인 숫자
8. **경력 단절 여부**: 1년 이상 공백이 있는지

## 출력 형식 (JSON만!)
{
  "skills": ["Python", "React", "AWS"],
  "certifications": ["정보처리기사", "SQLD"],
  "education_level": "4년제",
  "total_experience_years": 5,
  "current_role_type": "백엔드 개발자",
  "industries": ["IT", "핀테크"],
  "job_change_count": 2,
  "employment_gap": false,
  "role_identity": "worker",
  "career_stage_years": "3_10",
  "transition_status": "none",
  "skill_level": 3,
  "warnings": []
}

## role_identity 매핑
- student: 학생/취준생
- worker: 직장인 (일반 사원~대리)
- manager: 관리자급 (과장~임원)
- entrepreneur: 창업가/프리랜서
- inactive: 구직중/휴직/은퇴

## career_stage_years 매핑
- none: 경력 없음 (학생/취준생)
- 0_3: 0~3년차 (신입/주니어)
- 3_10: 3~10년차 (미들)
- 10_plus: 10년 이상 (시니어)

## transition_status 매핑
- none: 현재 안정적
- changer: 이직 준비중/최근 이직
- returner: 경력 단절 후 복귀
- second_career: 은퇴 후 재취업/전직

## skill_level 매핑 (관심 분야 기준!)
- 0: 입문 (해당 분야 경험 없음)
- 1: 초급 (학습 중/1년 미만)
- 2: 중급 (1~3년 실무)
- 3: 고급 (3~5년 실무)
- 4: 전문가 (5년+ 또는 리더급)

⚠️ 반드시 JSON만 출력하세요. 다른 텍스트 금지!`

// ============================================
// 메인 파싱 함수
// ============================================
export async function parseResumeText(
  ai: Ai,
  text: string,
  config?: { model?: string; temperature?: number }
): Promise<ParsedResumeData> {
  const model = config?.model || '@cf/meta/llama-3.1-8b-instruct'
  const temperature = config?.temperature || 0.3  // 낮은 temperature로 일관성 확보

  // 텍스트 길이 제한 (토큰 초과 방지)
  const truncatedText = text.slice(0, 8000)

  try {
    const response = await ai.run(model as any, {
      messages: [
        { role: 'system', content: RESUME_PARSE_SYSTEM_PROMPT },
        { role: 'user', content: `다음 이력서를 분석해주세요:\n\n${truncatedText}` },
      ],
      temperature,
      max_tokens: 1000,
    })

    const responseText = (response as any)?.response || (response as any)?.generated_text || ''
    const parsed = extractJsonFromResponse(responseText)

    if (!parsed) {
      throw new Error('LLM 응답에서 JSON을 추출할 수 없습니다')
    }

    // ⚠️ P2 마스킹 필터는 여기서 적용 예정
    // 지금은 LLM이 추출하지 않도록 프롬프트만 강제
    // const maskedParsed = maskSensitiveInfo(parsed)

    return {
      inferred_state: {
        role_identity: validateRoleIdentity(parsed.role_identity),
        career_stage_years: validateCareerStage(parsed.career_stage_years),
        transition_status: validateTransitionStatus(parsed.transition_status),
        skill_level: validateSkillLevel(parsed.skill_level),
        constraints: {},  // 이력서에서 제약 조건은 추론하지 않음
      },
      extracted: {
        skills: Array.isArray(parsed.skills) ? parsed.skills : [],
        certifications: Array.isArray(parsed.certifications) ? parsed.certifications : [],
        education_level: parsed.education_level || null,
        total_experience_years: typeof parsed.total_experience_years === 'number' ? parsed.total_experience_years : null,
        current_role_type: parsed.current_role_type || null,
        industries: Array.isArray(parsed.industries) ? parsed.industries : [],
        job_change_count: typeof parsed.job_change_count === 'number' ? parsed.job_change_count : null,
        employment_gap: !!parsed.employment_gap,
      },
      meta: {
        parsed_at: new Date().toISOString(),
        text_length: text.length,
        warnings: Array.isArray(parsed.warnings) ? parsed.warnings : [],
      },
    }
  } catch (error) {
    console.error('Resume parsing failed:', error)
    return createEmptyParsedData(text.length, error instanceof Error ? error.message : 'Unknown error')
  }
}

// ============================================
// JSON 추출 유틸리티
// ============================================
function extractJsonFromResponse(response: string): any {
  try {
    // JSON 블록 추출 시도
    const jsonMatch = response.match(/\{[\s\S]*\}/)
    if (jsonMatch) {
      return JSON.parse(jsonMatch[0])
    }
  } catch (e) {
    console.warn('JSON extraction failed:', e)
  }
  return null
}

// ============================================
// 검증 함수들
// ============================================
function validateRoleIdentity(value: any): RoleIdentity | null {
  const valid: RoleIdentity[] = ['student', 'worker', 'manager', 'entrepreneur', 'inactive']
  return valid.includes(value) ? value : null
}

function validateCareerStage(value: any): CareerStageYears | null {
  const valid: CareerStageYears[] = ['none', '0_3', '3_10', '10_plus']
  return valid.includes(value) ? value : null
}

function validateTransitionStatus(value: any): TransitionStatus | null {
  const valid: TransitionStatus[] = ['none', 'changer', 'returner', 'second_career']
  return valid.includes(value) ? value : null
}

function validateSkillLevel(value: any): SkillLevel | null {
  if (typeof value === 'number' && value >= 0 && value <= 4) {
    return value as SkillLevel
  }
  return null
}

// ============================================
// 빈 결과 생성 (에러 시)
// ============================================
function createEmptyParsedData(textLength: number, errorMessage: string): ParsedResumeData {
  return {
    inferred_state: {
      role_identity: null,
      career_stage_years: null,
      transition_status: null,
      skill_level: null,
      constraints: {},
    },
    extracted: {
      skills: [],
      certifications: [],
      education_level: null,
      total_experience_years: null,
      current_role_type: null,
      industries: [],
      job_change_count: null,
      employment_gap: false,
    },
    meta: {
      parsed_at: new Date().toISOString(),
      text_length: textLength,
      warnings: [`파싱 실패: ${errorMessage}`],
    },
  }
}

// ============================================
// P2: 민감정보 마스킹 필터 (현재는 미사용, P2에서 활성화)
// ============================================
// eslint-disable-next-line @typescript-eslint/no-unused-vars
function maskSensitiveInfo(parsed: any): any {
  // P2에서 구현 예정
  // 회사명/학교명 패턴 탐지 후 마스킹
  // 예: \bSK\b → [회사] (단, SKLearn 같은 스킬은 예외 처리)
  //
  // const COMPANY_PATTERNS = [
  //   /\b(삼성|Samsung|네이버|Naver|카카오|Kakao|LG|SK(?!\s*(Learn|Kit)))[\w가-힣]*\b/gi,
  // ]
  // const SCHOOL_PATTERNS = [
  //   /\b(서울대|연세대|고려대|KAIST|포항공대|한양대|성균관대)[\w가-힣]*\b/gi,
  // ]
  return parsed
}

// ============================================
// 파싱 결과 → CareerState 변환
// ============================================
export function parsedResumeToCareerState(parsed: ParsedResumeData): Partial<CareerState> {
  const now = new Date().toISOString()

  return {
    role_identity: parsed.inferred_state.role_identity || undefined,
    career_stage_years: parsed.inferred_state.career_stage_years || undefined,
    transition_status: parsed.inferred_state.transition_status || undefined,
    skill_level: parsed.inferred_state.skill_level ?? undefined,
    constraints: {
      time: { has_constraint: false },
      money: { has_constraint: false },
      location: { has_constraint: false },
      family: { has_constraint: false },
      health: { has_constraint: false },
      qualification: { has_constraint: false },
    },
    captured_at: now,
    source: 'resume_parsed',
  }
}
