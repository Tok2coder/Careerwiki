/**
 * 직업 자동 분류 서비스
 *
 * 새 직업 생성 시 GPT-4o-mini를 이용하여 대분류/중분류를 자동 판별한다.
 * waitUntil 패턴으로 호출하므로 실패해도 직업 생성 자체에는 영향 없음.
 */

import { JOB_LARGE_CATEGORIES, JOB_MEDIUM_CATEGORIES, getClassificationPromptList } from '../constants/classification'
import { callOpenAI } from './ai-analyzer/openai-client'
import { fuzzyMatchLargeCategory } from '../constants/classification'

interface JobInfo {
  id: string
  name: string
  summary?: string
  industry?: string
}

/**
 * 신규 직업을 GPT-4o-mini로 자동 분류 → job_categories INSERT
 */
export async function autoClassifyJob(
  db: any,
  jobInfo: JobInfo,
  openaiApiKey: string
): Promise<{ large: string; medium: string } | null> {
  try {
    const categoryList = getClassificationPromptList()

    const prompt = `아래 직업을 분류 체계에서 골라 대분류(large)와 중분류(medium)로 분류하세요.

직업명: ${jobInfo.name}
${jobInfo.summary ? `설명: ${jobInfo.summary}` : ''}
${jobInfo.industry ? `산업: ${jobInfo.industry}` : ''}

분류 체계 (반드시 아래 목록에서만 선택):
${categoryList}

⚠️ 대분류는 반드시 위 10개 중 하나를 정확히 그대로 사용하세요.

응답 (JSON만):
{"large": "대분류명", "medium": "중분류명"}`

    const llmResult = await callOpenAI(
      openaiApiKey,
      [
        { role: 'system', content: '당신은 한국 직업 분류 전문가입니다. 주어진 직업을 정확한 대분류와 중분류로 분류합니다. 산업분류(KSIC)가 아닌 직업분류입니다.' },
        { role: 'user', content: prompt }
      ],
      { model: 'gpt-4o-mini', temperature: 0.1, max_tokens: 200 }
    )

    const responseText = llmResult.response?.trim() || ''
    // JSON 블록 추출
    const jsonMatch = responseText.match(/\{[\s\S]*\}/)
    if (!jsonMatch) return null

    const parsed = JSON.parse(jsonMatch[0]) as { large?: string; medium?: string }
    if (!parsed.large) return null

    // 유효성 검증 (직접 매칭 → 퍼지 매칭 폴백)
    let validLarge = JOB_LARGE_CATEGORIES.find(c => c === parsed.large) || null
    let confidence = 0.8

    if (!validLarge) {
      validLarge = fuzzyMatchLargeCategory(parsed.large) as typeof JOB_LARGE_CATEGORIES[number] | null
      confidence = 0.6
    }
    if (!validLarge) return null

    const validMediums = JOB_MEDIUM_CATEGORIES[validLarge]
    const validMedium = validMediums?.find(m => m === parsed.medium) || null

    // DB INSERT (REPLACE로 중복 방지)
    await db.prepare(`
      INSERT OR REPLACE INTO job_categories (job_id, large_category, medium_category, source, confidence, created_at, updated_at)
      VALUES (?, ?, ?, 'llm', ?, unixepoch() * 1000, unixepoch() * 1000)
    `).bind(jobInfo.id, validLarge, validMedium, confidence).run()

    return { large: validLarge, medium: validMedium || '' }
  } catch (error) {
    console.error(`[classification] autoClassifyJob failed for ${jobInfo.name}:`, error)
    return null
  }
}
