// src/services/ai-analyzer/llm-memory.ts
// ============================================
// Rolling Memory: 누적 요약/가설 업데이트 컴포넌트
// ============================================
// 목적: Round 답변 또는 NarrativeFacts가 제출될 때마다
// 짧고 구조화된 메모리를 업데이트해서 다음 질문의 품질을 급상승
// ============================================

import type { Ai } from '@cloudflare/workers-types'
import type { RoundAnswer, NarrativeFacts } from './types'
import type {
  AggregatedProfile,
  ProfileMemory,
  MemoryItem,
  EmotionalTrigger,
  EvidenceSourceKey,
} from './aggregated-profile'
import { callOpenAI } from './openai-client'

// ============================================
// Types
// ============================================

// 입력 타입: RoundAnswer 또는 NarrativeFacts 모두 처리
export type MemoryInput = 
  | { type: 'round_answers'; data: RoundAnswer[]; roundNumber: 1 | 2 | 3 }
  | { type: 'narrative_facts'; data: NarrativeFacts }

// LLM 출력 구조
interface LLMMemoryOutput {
  stable_drivers?: Array<{ text: string; confidence: number; evidence_excerpt?: string }>
  recurring_fears?: Array<{ text: string; confidence: number; evidence_excerpt?: string }>
  decision_rules?: Array<{ text: string; confidence: number; evidence_excerpt?: string }>
  contradictions?: Array<{ text: string; confidence: number; evidence_excerpt?: string }>
  open_loops?: Array<{ text: string; priority: number }>
  resolved_loops?: string[]
  emotional_triggers?: Array<{
    trigger: string
    emotions: string[]
    intensity: number
    evidence_excerpt?: string
  }>
}

// ============================================
// Constants
// ============================================

const MEMORY_SYSTEM_PROMPT = `당신은 커리어 코치 AI의 메모리 관리자입니다.
사용자의 응답에서 중요한 패턴, 동기, 두려움, 의사결정 기준을 추출합니다.

## 중요 규칙
1. **확정형 표현 금지**: 모든 항목은 "~일 수 있음", "~로 보임", "~경향" 등 완화된 표현 사용
2. **신뢰도(confidence)**: 0.0~1.0 사이 값. 명확한 언급은 0.8+, 추론은 0.4~0.6
3. **증거(evidence)**: 가능하면 사용자 원문 일부를 인용 (최대 100자)
4. **감정 강도(intensity)**: 1(미약)~5(매우 강함). 감정 표현이 명시적이면 높게
5. **open_loops**: 아직 해소되지 않은 질문/갈등 (다음 라운드에서 파야 할 것)

## 추출 대상
- stable_drivers: 반복 등장하는 동기/욕구 (예: "자율적 판단", "문제 해결 몰입")
- recurring_fears: 반복 등장하는 두려움/회피 (예: "결정권 축소", "반복 업무")
- decision_rules: 선택 기준 If-Then 형태 (예: "설명할 수 있는 이유가 있으면 안정감")
- contradictions: 가치/욕구 충돌 (예: "자율 vs 안정")
- emotional_triggers: 감정 반응이 큰 지점 (트리거 + 감정들 + 강도)
- open_loops: 미해결 질문 (예: "신뢰의 기준이 무엇인지 아직 불명확")
- resolved_loops: 이번 응답으로 해소된 이전 open_loops

## 출력 JSON 형식
{
  "stable_drivers": [{ "text": "...", "confidence": 0.8, "evidence_excerpt": "..." }],
  "recurring_fears": [{ "text": "...", "confidence": 0.7, "evidence_excerpt": "..." }],
  "decision_rules": [{ "text": "...", "confidence": 0.6, "evidence_excerpt": "..." }],
  "contradictions": [{ "text": "...", "confidence": 0.7, "evidence_excerpt": "..." }],
  "open_loops": [{ "text": "...", "priority": 1 }],
  "resolved_loops": ["..."],
  "emotional_triggers": [{
    "trigger": "...",
    "emotions": ["불안", "답답함"],
    "intensity": 4,
    "evidence_excerpt": "..."
  }]
}

반드시 JSON만 출력하세요. 설명이나 마크다운 없이 순수 JSON만 반환하세요.`

// ============================================
// Helper: 기존 메모리와 새 메모리 병합
// ============================================
function mergeMemoryItems(
  existing: MemoryItem[],
  newItems: MemoryItem[],
  maxItems: number = 5
): MemoryItem[] {
  // 기존 항목 Map (text → item)
  const map = new Map<string, MemoryItem>()
  
  for (const item of existing) {
    map.set(item.text, item)
  }
  
  // 새 항목 병합 (같은 text면 confidence 업데이트)
  for (const item of newItems) {
    const existingItem = map.get(item.text)
    if (existingItem) {
      // 신뢰도 가중 평균 (새 항목에 더 높은 가중치)
      existingItem.confidence = (existingItem.confidence * 0.4) + (item.confidence * 0.6)
      if (item.evidenceKey) {
        existingItem.evidenceKey = item.evidenceKey
      }
    } else {
      map.set(item.text, item)
    }
  }
  
  // confidence 내림차순 정렬 후 상위 N개
  const merged = Array.from(map.values())
  merged.sort((a, b) => b.confidence - a.confidence)
  
  return merged.slice(0, maxItems)
}

function mergeEmotionalTriggers(
  existing: EmotionalTrigger[],
  newTriggers: EmotionalTrigger[],
  maxItems: number = 5
): EmotionalTrigger[] {
  const map = new Map<string, EmotionalTrigger>()
  
  for (const t of existing) {
    map.set(t.trigger, t)
  }
  
  for (const t of newTriggers) {
    const existingT = map.get(t.trigger)
    if (existingT) {
      // 강도 업데이트 (더 높은 값 유지)
      existingT.intensity = Math.max(existingT.intensity, t.intensity) as 1|2|3|4|5
      // 감정 합집합
      existingT.emotions = [...new Set([...existingT.emotions, ...t.emotions])]
      if (t.evidenceKey) {
        existingT.evidenceKey = t.evidenceKey
      }
    } else {
      map.set(t.trigger, t)
    }
  }
  
  const merged = Array.from(map.values())
  merged.sort((a, b) => b.intensity - a.intensity)
  
  return merged.slice(0, maxItems)
}

// ============================================
// Main: updateMemory
// ============================================
export async function updateMemory(
  ai: Ai | null,
  profile: AggregatedProfile,
  newInput: MemoryInput,
  openaiApiKey?: string
): Promise<ProfileMemory> {
  const existingMemory = profile.memory
  
  // 입력 데이터를 컨텍스트로 변환
  let inputContext: string
  let evidenceKeyPrefix: string
  
  if (newInput.type === 'narrative_facts') {
    const facts = newInput.data
    inputContext = `## 사용자 서술 응답

### 커리어 이야기
${facts.storyAnswer || facts.life_story || '(미입력)'}

### 가장 살아있다고 느낀 순간
${facts.highAliveMoment || '(미입력)'}

### 현재 아쉬운 점
${facts.lostMoment || '(미입력)'}`
    evidenceKeyPrefix = 'step2'
  } else {
    const { data: answers, roundNumber } = newInput
    const answerTexts = answers.map((a, i) => 
      `Q${i+1} (${a.questionId}): ${a.answer}`
    ).join('\n\n')
    
    inputContext = `## Round ${roundNumber} 답변

${answerTexts}`
    evidenceKeyPrefix = `round${roundNumber}`
  }
  
  // 기존 메모리 요약
  const existingMemoryContext = `## 기존 누적 메모리

### 안정적 동기 (stable_drivers)
${existingMemory.stable_drivers.map(d => `- ${d.text} (신뢰도: ${d.confidence.toFixed(2)})`).join('\n') || '(없음)'}

### 반복 두려움 (recurring_fears)
${existingMemory.recurring_fears.map(f => `- ${f.text} (신뢰도: ${f.confidence.toFixed(2)})`).join('\n') || '(없음)'}

### 의사결정 기준 (decision_rules)
${existingMemory.decision_rules.map(r => `- ${r.text} (신뢰도: ${r.confidence.toFixed(2)})`).join('\n') || '(없음)'}

### 가치 충돌 (contradictions)
${existingMemory.contradictions.map(c => `- ${c.text} (신뢰도: ${c.confidence.toFixed(2)})`).join('\n') || '(없음)'}

### 미해결 질문 (open_loops)
${existingMemory.open_loops.map(l => `- ${l.text} (우선순위: ${l.priority})`).join('\n') || '(없음)'}

### 감정 트리거 (emotional_triggers)
${existingMemory.emotional_triggers.map(t => `- ${t.trigger}: ${t.emotions.join(', ')} (강도: ${t.intensity})`).join('\n') || '(없음)'}`
  
  const userPrompt = `${existingMemoryContext}

${inputContext}

위 새로운 응답을 분석하여 기존 메모리를 업데이트하세요.
- 새로 발견된 패턴을 추가
- 기존 패턴이 강화되면 confidence 상향
- 이번 응답으로 해소된 open_loop는 resolved_loops에 추가
- 새로운 갈등/미해결 포인트는 open_loops에 추가`

  try {
    let responseText: string
    
    if (openaiApiKey) {
      // OpenAI 사용
      const response = await callOpenAI(openaiApiKey, [
        { role: 'system', content: MEMORY_SYSTEM_PROMPT },
        { role: 'user', content: userPrompt },
      ], {
        model: 'gpt-4o-mini',
        temperature: 0.3,  // 일관성 중요
        max_tokens: 2000,
      })
      responseText = response
    } else if (ai) {
      // Cloudflare AI 사용
      const response = await ai.run('@cf/meta/llama-3.1-8b-instruct' as any, {
        messages: [
          { role: 'system', content: MEMORY_SYSTEM_PROMPT },
          { role: 'user', content: userPrompt },
        ],
        max_tokens: 2000,
        temperature: 0.3,
      }) as { response?: string }
      responseText = response.response || ''
    } else {
      // AI 없음 - 기존 메모리 유지
      return existingMemory
    }
    
    // JSON 파싱
    const jsonMatch = responseText.match(/\{[\s\S]*\}/)
    if (!jsonMatch) {
      return existingMemory
    }
    
    const llmOutput: LLMMemoryOutput = JSON.parse(jsonMatch[0])
    
    // 새 메모리 아이템 생성 (evidenceKey 추가)
    const createMemoryItems = (
      items: Array<{ text: string; confidence: number; evidence_excerpt?: string }> | undefined,
      keyType: string
    ): MemoryItem[] => {
      if (!items) return []
      return items.map((item, i) => {
        const evidenceKey = `${evidenceKeyPrefix}.${keyType}_${i}` as EvidenceSourceKey
        return {
          text: item.text,
          confidence: Math.max(0, Math.min(1, item.confidence)),  // 0~1 범위 보장
          evidenceKey: item.evidence_excerpt ? evidenceKey : undefined,
        }
      })
    }
    
    // 기존 메모리와 병합
    const updatedMemory: ProfileMemory = {
      stable_drivers: mergeMemoryItems(
        existingMemory.stable_drivers,
        createMemoryItems(llmOutput.stable_drivers, 'driver')
      ),
      recurring_fears: mergeMemoryItems(
        existingMemory.recurring_fears,
        createMemoryItems(llmOutput.recurring_fears, 'fear')
      ),
      decision_rules: mergeMemoryItems(
        existingMemory.decision_rules,
        createMemoryItems(llmOutput.decision_rules, 'rule')
      ),
      contradictions: mergeMemoryItems(
        existingMemory.contradictions,
        createMemoryItems(llmOutput.contradictions, 'conflict')
      ),
      open_loops: [
        // 기존 open_loops 중 resolved 아닌 것
        ...existingMemory.open_loops.filter(
          l => !(llmOutput.resolved_loops || []).includes(l.text)
        ),
        // 새로운 open_loops
        ...(llmOutput.open_loops || []).map((l, i) => ({
          text: l.text,
          priority: l.priority || 50,
          evidenceKey: `${evidenceKeyPrefix}.loop_${i}` as string,
        })),
      ].slice(0, 10),  // 최대 10개
      resolved_loops: [
        ...existingMemory.resolved_loops,
        ...(llmOutput.resolved_loops || []),
      ].slice(-20),  // 최근 20개만 유지
      emotional_triggers: mergeEmotionalTriggers(
        existingMemory.emotional_triggers,
        (llmOutput.emotional_triggers || []).map((t, i) => ({
          trigger: t.trigger,
          emotions: t.emotions,
          intensity: Math.max(1, Math.min(5, t.intensity)) as 1|2|3|4|5,
          evidenceKey: `${evidenceKeyPrefix}.trigger_${i}`,
        }))
      ),
    }
    
    
    return updatedMemory
    
  } catch (error) {
    return existingMemory
  }
}

// ============================================
// Export for testing
// ============================================
export { mergeMemoryItems, mergeEmotionalTriggers }
