// src/services/ai-analyzer/openai-client.ts
// ============================================
// OpenAI API 클라이언트 (Chat + Embedding)
// ============================================

export interface OpenAIMessage {
  role: 'system' | 'user' | 'assistant'
  content: string
}

export interface OpenAIResponse {
  id: string
  choices: Array<{
    message: {
      role: string
      content: string
    }
    finish_reason: string
  }>
  usage: {
    prompt_tokens: number
    completion_tokens: number
    total_tokens: number
  }
}

// 기본 모델 설정
export const OPENAI_MODEL = 'gpt-4o-mini'

// 임베딩 모델 설정
export const OPENAI_EMBEDDING_MODEL = 'text-embedding-3-small'
export const OPENAI_EMBEDDING_DIMENSIONS = 1536

/**
 * OpenAI Chat Completion API 호출
 */
export async function callOpenAI(
  apiKey: string,
  messages: OpenAIMessage[],
  options: {
    model?: string
    temperature?: number
    max_tokens?: number
    timeout_ms?: number  // v3.10.6: 개별 호출 타임아웃 (기본 25초)
  } = {}
): Promise<{ response: string; usage: OpenAIResponse['usage'] }> {
  const {
    model = OPENAI_MODEL,
    temperature = 0.7,
    max_tokens = 1500,
    timeout_ms = 55000,  // 55초: 정상(5-15초)에선 안 걸리고, OpenAI 먹통일 때만 작동
  } = options

  // v3.10.6: AbortController로 개별 OpenAI 호출 타임아웃 적용
  const controller = new AbortController()
  const timeoutId = setTimeout(() => controller.abort(), timeout_ms)

  let response: Response
  try {
    response = await fetch('https://gateway.ai.cloudflare.com/v1/3587865378649966bfb0a814fce73c77/careerwiki/openai/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model,
        messages,
        temperature,
        max_tokens,
      }),
      signal: controller.signal,
    })
  } catch (err: any) {
    clearTimeout(timeoutId)
    if (err.name === 'AbortError') {
      throw new Error(`OpenAI API timeout after ${timeout_ms}ms`)
    }
    throw err
  } finally {
    clearTimeout(timeoutId)
  }

  if (!response.ok) {
    const error = await response.text()
    throw new Error(`OpenAI API error: ${response.status} - ${error}`)
  }

  const data: OpenAIResponse = await response.json()
  

  return {
    response: data.choices[0]?.message?.content || '',
    usage: data.usage,
  }
}

/**
 * Cloudflare AI → OpenAI 호환 래퍼
 * 기존 코드 변경 최소화를 위해 Cloudflare AI와 동일한 인터페이스 제공
 */
export function createOpenAICompatibleRunner(apiKey: string) {
  return {
    async run(
      _model: string, // 무시됨 - 항상 GPT-4o-mini 사용
      options: {
        messages: Array<{ role: string; content: string }>
        temperature?: number
        max_tokens?: number
      }
    ): Promise<{ response: string }> {
      const result = await callOpenAI(
        apiKey,
        options.messages as OpenAIMessage[],
        {
          temperature: options.temperature,
          max_tokens: options.max_tokens,
        }
      )
      return { response: result.response }
    },
  }
}

// ============================================
// OpenAI Embedding API
// ============================================

export interface OpenAIEmbeddingResponse {
  object: string
  data: Array<{
    object: string
    index: number
    embedding: number[]
  }>
  model: string
  usage: {
    prompt_tokens: number
    total_tokens: number
  }
}

/**
 * OpenAI Embedding API 호출
 * 다국어 지원 (한국어 직접 처리 가능)
 * 
 * @param apiKey OpenAI API 키
 * @param input 임베딩할 텍스트 (단일 또는 배열)
 * @returns 임베딩 벡터 배열 (1536차원)
 */
export async function generateOpenAIEmbedding(
  apiKey: string,
  input: string | string[],
  timeout_ms: number = 30000  // v3.10.6: 임베딩은 30초 (정상 2-3초, 먹통 방지용)
): Promise<{ embeddings: number[][]; usage: OpenAIEmbeddingResponse['usage'] }> {
  const texts = Array.isArray(input) ? input : [input]

  const controller = new AbortController()
  const timeoutId = setTimeout(() => controller.abort(), timeout_ms)

  let response: Response
  try {
    response = await fetch('https://gateway.ai.cloudflare.com/v1/3587865378649966bfb0a814fce73c77/careerwiki/openai/embeddings', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model: OPENAI_EMBEDDING_MODEL,
        input: texts,
        dimensions: OPENAI_EMBEDDING_DIMENSIONS,
      }),
      signal: controller.signal,
    })
  } catch (err: any) {
    clearTimeout(timeoutId)
    if (err.name === 'AbortError') {
      throw new Error(`OpenAI Embedding API timeout after ${timeout_ms}ms`)
    }
    throw err
  } finally {
    clearTimeout(timeoutId)
  }

  if (!response.ok) {
    const error = await response.text()
    throw new Error(`OpenAI Embedding API error: ${response.status} - ${error}`)
  }

  const data: OpenAIEmbeddingResponse = await response.json()
  

  // 인덱스 순서대로 정렬하여 반환
  const sortedEmbeddings = data.data
    .sort((a, b) => a.index - b.index)
    .map(item => item.embedding)

  return {
    embeddings: sortedEmbeddings,
    usage: data.usage,
  }
}
