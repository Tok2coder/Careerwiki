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
  } = {}
): Promise<{ response: string; usage: OpenAIResponse['usage'] }> {
  const {
    model = OPENAI_MODEL,
    temperature = 0.7,
    max_tokens = 1500,
  } = options

  const response = await fetch('https://api.openai.com/v1/chat/completions', {
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
  })

  if (!response.ok) {
    const error = await response.text()
    console.error('[OpenAI] API Error:', response.status, error)
    throw new Error(`OpenAI API error: ${response.status} - ${error}`)
  }

  const data: OpenAIResponse = await response.json()
  
  console.log('[OpenAI] Usage:', {
    model,
    prompt_tokens: data.usage.prompt_tokens,
    completion_tokens: data.usage.completion_tokens,
    total_tokens: data.usage.total_tokens,
  })

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
  input: string | string[]
): Promise<{ embeddings: number[][]; usage: OpenAIEmbeddingResponse['usage'] }> {
  const texts = Array.isArray(input) ? input : [input]
  
  const response = await fetch('https://api.openai.com/v1/embeddings', {
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
  })

  if (!response.ok) {
    const error = await response.text()
    console.error('[OpenAI Embedding] API Error:', response.status, error)
    throw new Error(`OpenAI Embedding API error: ${response.status} - ${error}`)
  }

  const data: OpenAIEmbeddingResponse = await response.json()
  
  console.log('[OpenAI Embedding] Usage:', {
    model: OPENAI_EMBEDDING_MODEL,
    dimensions: OPENAI_EMBEDDING_DIMENSIONS,
    input_count: texts.length,
    prompt_tokens: data.usage.prompt_tokens,
    total_tokens: data.usage.total_tokens,
  })

  // 인덱스 순서대로 정렬하여 반환
  const sortedEmbeddings = data.data
    .sort((a, b) => a.index - b.index)
    .map(item => item.embedding)

  return {
    embeddings: sortedEmbeddings,
    usage: data.usage,
  }
}
