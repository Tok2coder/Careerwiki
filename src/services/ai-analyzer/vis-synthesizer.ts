// CareerWiki AI Analyzer - VIS (Vector Insight Synthesizer)
// Version: v1.0.0 (Freeze v1.1)
//
// ============================================
// VIS = 계산기 + 주석 생성기 (두뇌 아님!)
// ============================================
// 설계 원칙:
// 1. 숫자/판정: 룰 기반 (결정적)
// 2. 해석 문장: LLM (조건부, threshold 초과 시만)
// 3. 의사결정 관여: 절대 금지
// ============================================
//
// VIS의 역할:
// - Vectorize 결과를 "직업 추천 힌트"가 아니라
//   "질문을 깊게 만들 단서"로 변환
// - 직업명 제거 + 인간 언어로 재서술
// ============================================

import type { VectorSearchResult } from './vectorize-pipeline'
import type { AxisType, AxisCoverage } from './axis-framework'
import { AXES, AXIS_QUESTION_THEMES } from './axis-framework'
import { callOpenAI, OPENAI_MODEL } from './openai-client'

// ============================================
// 타입 정의
// ============================================

export interface LatentPattern {
  pattern: string               // "추상적 문제를 구조화하는 활동 선호"
  confidence: number            // 0-1
  source: 'cluster' | 'axis'    // 어디서 추론했는지
}

export interface TensionPoint {
  tension: string               // "사람 상대 서비스 직무와 거리감"
  why: string                   // 왜 긴장점인지
  confidence: number
}

export interface VISMetrics {
  cluster_spread: number        // 분산도 계산 (0-1, 높을수록 분산)
  volatility: number            // 이전 라운드 대비 변화 (0-1)
  dominant_cluster: string      // 가장 큰 클러스터
  cluster_counts: Record<string, number>  // 클러스터별 개수
}

export interface VISInterpretation {
  summary: string               // 왜 지금 헷갈리는지 1줄
  suggested_angle: string       // 질문 방향 제안
}

export interface VISOutput {
  // 룰 기반 (항상 생성)
  latent_patterns: LatentPattern[]
  tension_points: TensionPoint[]
  metrics: VISMetrics
  
  // LLM 기반 (조건부 생성)
  interpretation?: VISInterpretation
}

export interface SynthesizeVISInput {
  vectorResults: VectorSearchResult[]
  axisCoverage: AxisCoverage
  previousVIS?: VISOutput
  openaiApiKey?: string
}

// ============================================
// 클러스터 → 패턴 매핑 (룰 기반)
// ============================================
const CLUSTER_TO_PATTERNS: Record<string, LatentPattern[]> = {
  '기술·분석': [
    { pattern: '추상적 문제를 구조화하는 활동 선호', confidence: 0.8, source: 'cluster' },
    { pattern: '논리적 사고와 체계적 접근 중시', confidence: 0.7, source: 'cluster' },
  ],
  '창작·디자인': [
    { pattern: '자기 표현과 창의적 결과물 추구', confidence: 0.8, source: 'cluster' },
    { pattern: '시각적/감각적 완성도에 만족', confidence: 0.7, source: 'cluster' },
  ],
  '대인·서비스': [
    { pattern: '사람과의 직접적 소통에서 에너지 충전', confidence: 0.8, source: 'cluster' },
    { pattern: '타인의 문제 해결에 보람 느낌', confidence: 0.7, source: 'cluster' },
  ],
  '관리·사무': [
    { pattern: '안정적이고 예측 가능한 환경 선호', confidence: 0.8, source: 'cluster' },
    { pattern: '체계적 프로세스와 명확한 역할 중시', confidence: 0.7, source: 'cluster' },
  ],
  '전문·연구': [
    { pattern: '깊이 있는 전문성 추구', confidence: 0.8, source: 'cluster' },
    { pattern: '장기적 학습과 성장에 가치 부여', confidence: 0.7, source: 'cluster' },
  ],
  '제조·생산': [
    { pattern: '실체가 있는 결과물에서 만족', confidence: 0.8, source: 'cluster' },
    { pattern: '손으로 직접 만드는 과정 선호', confidence: 0.7, source: 'cluster' },
  ],
}

// 축 → 긴장점 매핑 (룰 기반)
const AXIS_TENSION_RULES: Array<{
  condition: (coverage: AxisCoverage) => boolean
  tension: TensionPoint
}> = [
  {
    condition: (c) => c.values.confidence < 0.4 && c.values.evidence.length > 1,
    tension: {
      tension: '가치관에서 상반된 신호 감지',
      why: '안정과 도전 사이에서 우선순위 미확정',
      confidence: 0.7,
    },
  },
  {
    condition: (c) => c.work_style.confidence < 0.4 && c.work_style.evidence.length > 0,
    tension: {
      tension: '업무 스타일 선호 불명확',
      why: '혼자 집중과 팀 협업 중 선호 미확정',
      confidence: 0.6,
    },
  },
  {
    condition: (c) => c.people.confidence < 0.3,
    tension: {
      tension: '대인관계 선호 정보 부족',
      why: '함께 일하고 싶은 사람 유형 미파악',
      confidence: 0.5,
    },
  },
  {
    condition: (c) => c.risk.confidence < 0.3 && c.feasibility_constraints.confidence > 0.5,
    tension: {
      tension: '현실 제약과 도전 의지 간 균형점 미확인',
      why: '제약은 명확하나 리스크 수용도 불명',
      confidence: 0.6,
    },
  },
  {
    condition: (c) => c.stress_tolerance.confidence < 0.4,
    tension: {
      tension: '스트레스 대응 패턴 미파악',
      why: '압박 상황에서의 반응이 불명확',
      confidence: 0.5,
    },
  },
]

// 클러스터 대비 → 긴장점 (룰 기반)
const CLUSTER_CONTRAST_TENSIONS: Array<{
  clusters: [string, string]
  tension: TensionPoint
}> = [
  {
    clusters: ['기술·분석', '대인·서비스'],
    tension: {
      tension: '분석 업무와 대인 서비스 사이에서 갈등',
      why: '기술 중심 vs 사람 중심 업무 모두에 관심',
      confidence: 0.7,
    },
  },
  {
    clusters: ['창작·디자인', '관리·사무'],
    tension: {
      tension: '창의성과 안정성 사이의 긴장',
      why: '자유로운 표현과 체계적 환경 모두 필요',
      confidence: 0.6,
    },
  },
  {
    clusters: ['전문·연구', '제조·생산'],
    tension: {
      tension: '이론과 실무 사이의 선택',
      why: '깊이 있는 연구와 실체적 결과물 모두 추구',
      confidence: 0.6,
    },
  },
]

// ============================================
// 카테고리 → 클러스터 라벨 변환 (qsp-generator와 동일)
// ============================================
const CATEGORY_TO_CLUSTER: Record<string, string> = {
  '정보통신': '기술·분석', '정보기술': '기술·분석', 'IT': '기술·분석',
  '엔지니어': '기술·분석', '공학': '기술·분석', '데이터': '기술·분석', '개발': '기술·분석',
  '디자인': '창작·디자인', '예술': '창작·디자인', '창작': '창작·디자인',
  '미디어': '창작·디자인', '콘텐츠': '창작·디자인',
  '서비스': '대인·서비스', '상담': '대인·서비스', '교육': '대인·서비스',
  '의료': '대인·서비스', '복지': '대인·서비스', '영업': '대인·서비스',
  '경영': '관리·사무', '관리': '관리·사무', '사무': '관리·사무',
  '행정': '관리·사무', '재무': '관리·사무', '인사': '관리·사무',
  '연구': '전문·연구', '법률': '전문·연구', '금융': '전문·연구', '컨설팅': '전문·연구',
  '제조': '제조·생산', '생산': '제조·생산', '건설': '제조·생산', '물류': '제조·생산',
}

function categoryToCluster(category: string | undefined): string {
  if (!category) return '기타'
  for (const [key, label] of Object.entries(CATEGORY_TO_CLUSTER)) {
    if (category.includes(key)) return label
  }
  return '기타'
}

// ============================================
// 룰 기반: 클러스터 분석
// ============================================
function analyzeClusterMetrics(
  vectorResults: VectorSearchResult[],
  previousVIS?: VISOutput
): VISMetrics {
  // 클러스터별 카운트
  const clusterCounts: Record<string, number> = {}
  for (const result of vectorResults) {
    const category = result.metadata?.category as string | undefined
    const cluster = categoryToCluster(category)
    clusterCounts[cluster] = (clusterCounts[cluster] || 0) + 1
  }
  
  const total = vectorResults.length
  const entries = Object.entries(clusterCounts).sort((a, b) => b[1] - a[1])
  
  // dominant_cluster
  const dominant_cluster = entries[0]?.[0] || '기타'
  
  // cluster_spread: 분산도 계산 (엔트로피 기반, 0-1)
  // 높을수록 분산, 낮을수록 집중
  let entropy = 0
  for (const [_, count] of entries) {
    const p = count / total
    if (p > 0) entropy -= p * Math.log2(p)
  }
  const maxEntropy = Math.log2(Math.max(entries.length, 1))
  const cluster_spread = maxEntropy > 0 ? entropy / maxEntropy : 0
  
  // volatility: 이전 VIS 대비 변화량
  let volatility = 0
  if (previousVIS) {
    const prevClusters = new Set(Object.keys(previousVIS.metrics.cluster_counts))
    const currClusters = new Set(Object.keys(clusterCounts))
    
    // Jaccard distance
    const intersection = [...currClusters].filter(c => prevClusters.has(c)).length
    const union = new Set([...prevClusters, ...currClusters]).size
    volatility = union > 0 ? 1 - (intersection / union) : 0
    
    // 비율 변화도 반영
    if (previousVIS.metrics.dominant_cluster !== dominant_cluster) {
      volatility = Math.min(volatility + 0.2, 1)
    }
  }
  
  return {
    cluster_spread,
    volatility,
    dominant_cluster,
    cluster_counts: clusterCounts,
  }
}

// ============================================
// 룰 기반: latent_patterns 추출
// ============================================
function extractLatentPatterns(
  metrics: VISMetrics,
  axisCoverage: AxisCoverage
): LatentPattern[] {
  const patterns: LatentPattern[] = []
  
  // 1. 클러스터 기반 패턴
  const topClusters = Object.entries(metrics.cluster_counts)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 3)
    .map(([cluster]) => cluster)
  
  for (const cluster of topClusters) {
    const clusterPatterns = CLUSTER_TO_PATTERNS[cluster]
    if (clusterPatterns) {
      patterns.push(...clusterPatterns.map(p => ({
        ...p,
        // 해당 클러스터 비중에 따라 confidence 조정
        confidence: p.confidence * (metrics.cluster_counts[cluster] / 
          Object.values(metrics.cluster_counts).reduce((a, b) => a + b, 0)),
      })))
    }
  }
  
  // 2. 축 기반 패턴 (confidence가 높은 축)
  for (const axis of AXES) {
    const state = axisCoverage[axis]
    if (state.confidence > 0.6 && state.evidence.length >= 2) {
      const theme = AXIS_QUESTION_THEMES[axis]
      patterns.push({
        pattern: `${theme.ko_label} 관련 명확한 선호 보임`,
        confidence: state.confidence,
        source: 'axis',
      })
    }
  }
  
  // 중복 제거 및 상위 5개
  return patterns
    .sort((a, b) => b.confidence - a.confidence)
    .slice(0, 5)
}

// ============================================
// 룰 기반: tension_points 생성
// ============================================
function extractTensionPoints(
  metrics: VISMetrics,
  axisCoverage: AxisCoverage
): TensionPoint[] {
  const tensions: TensionPoint[] = []
  
  // 1. 축 기반 긴장점
  for (const rule of AXIS_TENSION_RULES) {
    if (rule.condition(axisCoverage)) {
      tensions.push(rule.tension)
    }
  }
  
  // 2. 클러스터 대비 긴장점
  const topClusters = Object.entries(metrics.cluster_counts)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 2)
    .map(([cluster]) => cluster)
  
  if (topClusters.length >= 2) {
    const [first, second] = topClusters
    const firstRatio = metrics.cluster_counts[first] / 
      Object.values(metrics.cluster_counts).reduce((a, b) => a + b, 0)
    const secondRatio = metrics.cluster_counts[second] / 
      Object.values(metrics.cluster_counts).reduce((a, b) => a + b, 0)
    
    // 비슷한 비율이면 긴장점 추가
    if (firstRatio < 0.5 && secondRatio > 0.15) {
      for (const contrast of CLUSTER_CONTRAST_TENSIONS) {
        const [c1, c2] = contrast.clusters
        if ((first === c1 && second === c2) || (first === c2 && second === c1)) {
          tensions.push(contrast.tension)
        }
      }
    }
  }
  
  // 3. 분산도가 너무 높으면 긴장점
  if (metrics.cluster_spread > 0.7) {
    tensions.push({
      tension: '관심 분야가 매우 다양하게 분산됨',
      why: '특정 방향으로 집중되지 않아 탐색 범위가 넓음',
      confidence: 0.5,
    })
  }
  
  return tensions.slice(0, 5)
}

// ============================================
// LLM 호출 조건 (threshold)
// ============================================
function needsLLMInterpretation(
  metrics: VISMetrics,
  tensionPoints: TensionPoint[]
): boolean {
  return (
    metrics.volatility > 0.4 ||           // 변화량이 클 때
    metrics.cluster_spread > 0.7 ||       // 너무 분산됐을 때
    tensionPoints.length >= 3             // 긴장점이 많을 때
  )
}

// ============================================
// LLM 기반: interpretation 생성 (조건부)
// ============================================
async function generateLLMInterpretation(
  latentPatterns: LatentPattern[],
  tensionPoints: TensionPoint[],
  metrics: VISMetrics,
  openaiApiKey: string
): Promise<VISInterpretation> {
  const systemPrompt = `당신은 커리어 분석 전문가입니다. 
주어진 사용자 패턴과 긴장점을 바탕으로 짧은 해석을 제공합니다.

규칙:
- 직업명을 언급하지 마세요
- 사용자의 내면 상태에 집중하세요
- 1-2문장으로 간결하게 답변하세요
- 한국어로 답변하세요`

  const userPrompt = `사용자 분석 결과:

[잠재 패턴]
${latentPatterns.map(p => `- ${p.pattern} (신뢰도: ${(p.confidence * 100).toFixed(0)}%)`).join('\n')}

[긴장점]
${tensionPoints.map(t => `- ${t.tension}: ${t.why}`).join('\n')}

[지표]
- 분산도: ${(metrics.cluster_spread * 100).toFixed(0)}%
- 변화량: ${(metrics.volatility * 100).toFixed(0)}%

다음 두 가지를 각각 한 문장으로 답변하세요:
1. summary: 이 사용자가 지금 왜 헷갈려하는지
2. suggested_angle: 다음에 어떤 방향으로 질문하면 좋을지

JSON 형식으로 답변: {"summary": "...", "suggested_angle": "..."}`

  try {
    const response = await callOpenAI(openaiApiKey, {
      model: OPENAI_MODEL,
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: userPrompt },
      ],
      temperature: 0.3,
      max_tokens: 200,
    })
    
    const content = response.choices[0]?.message?.content || '{}'
    
    // JSON 추출
    const jsonMatch = content.match(/\{[\s\S]*\}/)
    if (jsonMatch) {
      const parsed = JSON.parse(jsonMatch[0])
      return {
        summary: parsed.summary || '분석 중 헷갈림 포인트가 감지됨',
        suggested_angle: parsed.suggested_angle || '구체적인 경험을 질문해보세요',
      }
    }
  } catch (error) {
  }
  
  // Fallback
  return {
    summary: tensionPoints.length > 0 
      ? `${tensionPoints[0].tension}으로 인해 방향이 불명확함`
      : '다양한 관심사가 공존하여 우선순위 필요',
    suggested_angle: latentPatterns.length > 0
      ? `${latentPatterns[0].pattern}에 대해 구체적으로 질문해보세요`
      : '특정 경험에서 느낀 감정을 물어보세요',
  }
}

// ============================================
// 메인 함수: VIS 합성
// ============================================
export async function synthesizeVectorInsights(
  input: SynthesizeVISInput
): Promise<VISOutput> {
  const { vectorResults, axisCoverage, previousVIS, openaiApiKey } = input
  
  // 1. 룰 기반: 메트릭 계산
  const metrics = analyzeClusterMetrics(vectorResults, previousVIS)
  
  // 2. 룰 기반: 잠재 패턴 추출
  const latent_patterns = extractLatentPatterns(metrics, axisCoverage)
  
  // 3. 룰 기반: 긴장점 생성
  const tension_points = extractTensionPoints(metrics, axisCoverage)
  
  // 4. LLM 조건부: interpretation 생성
  let interpretation: VISInterpretation | undefined
  
  if (openaiApiKey && needsLLMInterpretation(metrics, tension_points)) {
    interpretation = await generateLLMInterpretation(
      latent_patterns,
      tension_points,
      metrics,
      openaiApiKey
    )
  }
  
  return {
    latent_patterns,
    tension_points,
    metrics,
    interpretation,
  }
}

// ============================================
// 동기 버전 (LLM 없이)
// ============================================
export function synthesizeVectorInsightsSync(
  input: Omit<SynthesizeVISInput, 'openaiApiKey'>
): Omit<VISOutput, 'interpretation'> {
  const { vectorResults, axisCoverage, previousVIS } = input
  
  const metrics = analyzeClusterMetrics(vectorResults, previousVIS)
  const latent_patterns = extractLatentPatterns(metrics, axisCoverage)
  const tension_points = extractTensionPoints(metrics, axisCoverage)
  
  return {
    latent_patterns,
    tension_points,
    metrics,
  }
}

// ============================================
// VIS → 프롬프트 힌트 변환
// ============================================
export function visToPromptHints(vis: VISOutput): string {
  const hints: string[] = []
  
  hints.push('[사용자 잠재 패턴]')
  for (const p of vis.latent_patterns.slice(0, 3)) {
    hints.push(`- ${p.pattern}`)
  }
  
  if (vis.tension_points.length > 0) {
    hints.push('')
    hints.push('[긴장점 - 질문으로 해소 필요]')
    for (const t of vis.tension_points.slice(0, 3)) {
      hints.push(`- ${t.tension}: ${t.why}`)
    }
  }
  
  hints.push('')
  hints.push(`[분석 지표] 분산도: ${(vis.metrics.cluster_spread * 100).toFixed(0)}%, 변화량: ${(vis.metrics.volatility * 100).toFixed(0)}%`)
  
  if (vis.interpretation) {
    hints.push('')
    hints.push(`[해석] ${vis.interpretation.summary}`)
    hints.push(`[추천 질문 방향] ${vis.interpretation.suggested_angle}`)
  }
  
  return hints.join('\n')
}
