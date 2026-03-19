/**
 * profile-saver.ts
 * AI 추천 완료 시 사용자 프로필을 user_profiles 테이블에 영구 저장
 * - 토큰 → 한글 변환
 * - 기존 프로필에 누적 업데이트 (새 값만 덮어씀, 기존 값 유지)
 */

import type { D1Database } from '@cloudflare/workers-types'

// ============================================
// 토큰 → 한글 변환 맵
// ============================================
const INTEREST_KO: Record<string, string> = {
  problem_solving: '문제 해결', data_numbers: '데이터/숫자', tech: '기술/IT',
  creative: '창작/예술', creating: '창작/예술', people: '사람/소통', helping: '돌봄/봉사',
  business: '비즈니스/경영', nature: '자연/환경', physical: '신체 활동',
  research: '연구/탐구', teaching: '교육/가르침', analysis: '분석',
  design: '디자인', writing: '글쓰기', hands_on: '손으로 만들기',
  media: '미디어/콘텐츠', science: '과학/연구', art: '예술',
  social: '사회/봉사', engineering: '공학/기술', medical: '의료/건강',
  law: '법률/행정', finance: '금융/경제', language: '언어/문학',
  sports: '스포츠/체육', music: '음악', cooking: '요리/식품',
}

const VALUE_KO: Record<string, string> = {
  recognition: '인정받고 영향력 발휘', stability: '안정성', income: '높은 수입',
  growth: '성장', autonomy: '자율성', meaning: '의미/사회 기여',
  wlb: '워라밸', balance: '일과 삶의 균형', expertise: '전문성',
  creativity: '창의성', interest: '흥미/적성 일치',
}

const STRENGTH_KO: Record<string, string> = {
  analytical: '분석력', creative: '창의력', communication: '소통력',
  structured_execution: '실행력', persistence: '끈기', fast_learning: '학습력',
  leadership: '리더십', detail_oriented: '꼼꼼함', patience: '인내심',
  empathy: '공감 능력', organization: '체계적 정리', adaptability: '적응력',
  perseverance: '끈기', creativity: '창의성', strategic: '전략적 사고',
  teamwork: '팀워크', independence: '독립적 업무',
}

const CONSTRAINT_KO: Record<string, string> = {
  time_constraint: '시간 제약', income_constraint: '수입 조건',
  location_constraint: '위치 제약', physical_constraint: '체력 제약',
  qualification_constraint: '자격 제약', uncertainty_constraint: '불확실성 회피',
  health_constraint: '건강 제약', work_hours_strict: '불규칙한 근무시간',
  no_travel: '출장 불가', no_overtime: '야근 불가',
  remote_only: '재택만 가능', remote_preferred: '재택 선호',
  shift_work_no: '교대근무 불가', degree_impossible: '학위 취득 어려움',
  stability: '안정성 필수',
}

const WORKSTYLE_KO: Record<string, string> = {
  solo: '혼자 집중', solo_deep: '혼자 깊이 집중', team: '팀 협업',
  team_harmony: '팀 조화', mixed: '상황에 따라', structured: '체계적 환경',
  flexible: '자유로운 환경', practice: '실습/실기 중심', theory: '이론 중심',
}

const DRAIN_KO: Record<string, string> = {
  people_drain: '대인관계 스트레스', cognitive_drain: '인지 피로',
  time_pressure_drain: '시간 압박 스트레스', responsibility_drain: '책임 스트레스',
  repetition_drain: '반복 피로', unpredictability_drain: '불확실성 스트레스',
  routine_drain: '반복 업무 피로', bureaucracy_drain: '관료주의 스트레스',
  pressure_drain: '마감 압박', conflict_drain: '갈등 상황',
  isolation_drain: '고립된 환경', physical_drain: '신체적 피로',
  uncertainty_drain: '불확실성',
}

const SACRIFICE_KO: Record<string, string> = {
  low_initial_income: '낮은 초봉 감수', willing_to_study: '재학습 감수',
  field_change_ok: '분야 전환 감수', ignore_social_pressure: '주변 시선 감수',
  no_sacrifice: '포기 불가', unstable_hours: '불규칙한 시간 감수',
  long_hours_ok: '긴 근무시간 감수', long_hours: '긴 근무시간',
  relocation: '거주지 이동', unstable_early: '초기 불안정 감수',
}

const ROLE_KO: Record<string, string> = {
  worker: '직장인', student: '학생', jobseeker: '구직자',
  career_changer: '이직 준비생', freelancer: '프리랜서',
  elementary: '초등학생', middle: '중학생', high: '고등학생',
  university: '대학생', graduate: '대학원생',
}

const STAGE_KO: Record<string, string> = {
  '0_3': '0~3년 (초기)', '3_7': '3~7년 (성장기)', '7_15': '7~15년 (전문가)',
  '15_plus': '15년+ (시니어)', exploring: '탐색 중', entry: '사회초년생',
}

const SUBJECT_KO: Record<string, string> = {
  math: '수학', science: '과학', korean: '국어', english: '영어',
  social: '사회', art: '미술', music: '음악', pe: '체육',
  tech: '기술/가정', info: '정보/컴퓨터', history: '역사',
}

// ============================================
// 변환 헬퍼
// ============================================
function toKorean(token: string, map: Record<string, string>): string {
  return map[token] || token
}

function toKoreanArray(tokens: string[] | undefined, map: Record<string, string>): string[] {
  if (!tokens || !Array.isArray(tokens)) return []
  return tokens.map(t => toKorean(t, map))
}

// ============================================
// 프로필 저장 메인 함수
// ============================================
export interface SaveProfileInput {
  userId: string
  analysisType: 'job' | 'major'
  requestId: number
  miniModuleResult: {
    interest_top?: string[]
    value_top?: string[]
    strength_top?: string[]
    constraint_flags?: string[]
    raw_selections?: {
      interest?: string[]
      value?: string[]
      strength?: string[]
      constraint?: string[]
      good_subjects?: string[]
      workstyle?: string
    }
  }
  narrativeFacts?: {
    highAliveMoment?: string
    lostMoment?: string
  } | null
  roundAnswers?: Array<{
    round?: number
    roundNumber?: number
    questionId?: string
    question?: string
    answer?: string
  }> | null
  careerState?: {
    role_identity?: string
    career_stage_years?: string
    transition_status?: string
    skill_level?: number
  } | null
}

export async function saveUserProfile(db: D1Database, input: SaveProfileInput): Promise<void> {
  const { userId, analysisType, requestId, miniModuleResult, narrativeFacts, roundAnswers, careerState } = input
  const raw = miniModuleResult.raw_selections || {}

  // 토큰 → 한글 변환
  const interests = toKoreanArray(raw.interest || miniModuleResult.interest_top, INTEREST_KO)
  const values = toKoreanArray(raw.value || miniModuleResult.value_top, VALUE_KO)
  const strengths = toKoreanArray(raw.strength || miniModuleResult.strength_top, STRENGTH_KO)
  const constraints = toKoreanArray(raw.constraint || miniModuleResult.constraint_flags, CONSTRAINT_KO)
  const workstyle = raw.workstyle ? toKorean(raw.workstyle, WORKSTYLE_KO) : null
  const goodSubjects = toKoreanArray(raw.good_subjects, SUBJECT_KO)

  // 심층 답변 조합
  const narrativeObj: Record<string, unknown> = {}
  if (narrativeFacts?.highAliveMoment) narrativeObj.highAliveMoment = narrativeFacts.highAliveMoment
  if (narrativeFacts?.lostMoment) narrativeObj.lostMoment = narrativeFacts.lostMoment
  if (roundAnswers && roundAnswers.length > 0) {
    narrativeObj.round_answers = roundAnswers.map(ra => ({
      round: ra.round || ra.roundNumber || 1,
      question: ra.question || ra.questionId || '',
      answer: ra.answer || '',
    }))
  }

  // career_state 한글 변환
  const roleIdentity = careerState?.role_identity ? toKorean(careerState.role_identity, ROLE_KO) : null
  const careerStage = careerState?.career_stage_years ? toKorean(careerState.career_stage_years, STAGE_KO) : null

  // 기존 프로필 조회
  const existing = await db.prepare(
    'SELECT id, interests_json, values_json, strengths_json, constraints_json, drains_json, sacrifices_json, good_subjects_json, narrative_json FROM user_profiles WHERE user_id = ? AND analysis_type = ?'
  ).bind(userId, analysisType).first<{
    id: number
    interests_json: string | null
    values_json: string | null
    strengths_json: string | null
    constraints_json: string | null
    drains_json: string | null
    sacrifices_json: string | null
    good_subjects_json: string | null
    narrative_json: string | null
  }>()

  if (existing) {
    // UPDATE: 새 값이 있으면 덮어씀, 없으면 기존 유지
    const mergedInterests = interests.length > 0 ? JSON.stringify(interests) : existing.interests_json
    const mergedValues = values.length > 0 ? JSON.stringify(values) : existing.values_json
    const mergedStrengths = strengths.length > 0 ? JSON.stringify(strengths) : existing.strengths_json
    const mergedConstraints = constraints.length > 0 ? JSON.stringify(constraints) : existing.constraints_json
    const mergedSubjects = goodSubjects.length > 0 ? JSON.stringify(goodSubjects) : existing.good_subjects_json

    // narrative: 기존 내용에 새 내용 머지
    let mergedNarrative = existing.narrative_json
    if (Object.keys(narrativeObj).length > 0) {
      const existingNarr = existing.narrative_json ? JSON.parse(existing.narrative_json) : {}
      const merged = { ...existingNarr, ...narrativeObj }
      // round_answers는 append가 아니라 최신으로 교체
      if (narrativeObj.round_answers) {
        merged.round_answers = narrativeObj.round_answers
      }
      mergedNarrative = JSON.stringify(merged)
    }

    await db.prepare(`
      UPDATE user_profiles SET
        role_identity = COALESCE(?, role_identity),
        career_stage = COALESCE(?, career_stage),
        skill_level = COALESCE(?, skill_level),
        interests_json = ?,
        values_json = ?,
        strengths_json = ?,
        constraints_json = ?,
        workstyle = COALESCE(?, workstyle),
        good_subjects_json = ?,
        narrative_json = ?,
        last_request_id = ?,
        updated_at = datetime('now')
      WHERE id = ?
    `).bind(
      roleIdentity, careerStage, careerState?.skill_level ?? null,
      mergedInterests, mergedValues, mergedStrengths, mergedConstraints,
      workstyle, mergedSubjects, mergedNarrative,
      requestId, existing.id
    ).run()

    console.log(`[profile-saver] Updated profile id=${existing.id} for user=${userId} type=${analysisType}`)
  } else {
    // INSERT: 새 프로필 생성
    const narrativeJson = Object.keys(narrativeObj).length > 0 ? JSON.stringify(narrativeObj) : null

    await db.prepare(`
      INSERT INTO user_profiles (user_id, analysis_type, role_identity, career_stage, skill_level,
        interests_json, values_json, strengths_json, constraints_json, workstyle,
        drains_json, sacrifices_json, good_subjects_json, narrative_json, last_request_id)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `).bind(
      userId, analysisType, roleIdentity, careerStage, careerState?.skill_level ?? null,
      interests.length > 0 ? JSON.stringify(interests) : null,
      values.length > 0 ? JSON.stringify(values) : null,
      strengths.length > 0 ? JSON.stringify(strengths) : null,
      constraints.length > 0 ? JSON.stringify(constraints) : null,
      workstyle, null, null,
      goodSubjects.length > 0 ? JSON.stringify(goodSubjects) : null,
      narrativeJson, requestId
    ).run()

    console.log(`[profile-saver] Created profile for user=${userId} type=${analysisType}`)
  }
}
