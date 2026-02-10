// CareerWiki AI Analyzer - QSP Generator
// Version: v1.1.0 (Freeze v1.1 + VIS Integration)
//
// ============================================
// QSP (Question Signals Packet) 생성 모듈
// ============================================
// 설계 원칙:
// 1. Vectorize 결과에서 직업명을 노출하지 않음
// 2. 추상 클러스터 라벨만 제공하여 편향 방지
// 3. 축별 정보 부족/충돌을 감지하여 질문 방향 제시
// 4. VIS (Vector Insight Synthesizer)와 통합하여
//    잠재 패턴/긴장점을 질문 생성에 활용
// ============================================

import type { VectorSearchResult } from './vectorize-pipeline'
import type { AxisType, AxisCoverage } from './axis-framework'
import { AXES, AXIS_QUESTION_THEMES, getHighPriorityAxes } from './axis-framework'
import {
  synthesizeVectorInsights,
  synthesizeVectorInsightsSync,
  visToPromptHints,
  type VISOutput,
  type LatentPattern,
  type TensionPoint,
} from './vis-synthesizer'

// ============================================
// QSP 타입 정의
// ============================================
export interface QSP {
  // 검색 결과 요약 (직업명 비노출)
  retrieval_summary: {
    top_clusters: string[]     // 추상 라벨 3-5개 (예: "기술 분석", "대인 서비스")
    cluster_spread: number     // 쏠림 정도 0-1 (높을수록 특정 분야에 집중)
    volatility: number         // 변화량 0-1 (이전 QSP 대비 변화)
  }
  
  // 대비 쌍 (선택 분기점)
  contrast_pairs: Array<{
    pair: string               // 예: "기술 vs 사람 중심"
    why_uncertain: string      // 예: "분석 업무와 소통 업무 모두에 관심을 보임"
  }>
  
  // 축별 부족 정보 힌트
  missing_axis_hints: Array<{
    axis: AxisType
    hint: string               // 예: "스트레스 상황 대응 패턴이 불명확함"
  }>
  
  // 질문 대상 (우선순위)
  question_targets: Array<{
    axis: AxisType
    reason: string             // 예: "가치관 정보 부족, 우선순위 확인 필요"
  }>
  
  // 이미 충분한 축 (질문 스킵)
  do_not_ask: string[]
  
  // === VIS 통합 (Freeze v1.1) ===
  // 잠재 패턴 (직업명 없이 능력·성향·선호 문장)
  latent_patterns?: LatentPattern[]
  
  // 긴장점 (사용자 내면의 갈등/불확실성)
  tension_points?: TensionPoint[]
  
  // VIS 해석 (LLM 조건부 생성)
  vis_interpretation?: {
    summary: string             // 왜 지금 헷갈리는지 1줄
    suggested_angle: string     // 질문 방향 제안
  }
}

// ============================================
// KSCO 대분류 → 추상 라벨 매핑
// ============================================
const CATEGORY_TO_CLUSTER_LABEL: Record<string, string> = {
  // 기술/분석
  '정보통신': '기술·분석',
  '정보기술': '기술·분석',
  'IT': '기술·분석',
  '엔지니어': '기술·분석',
  '공학': '기술·분석',
  '데이터': '기술·분석',
  '개발': '기술·분석',
  
  // 창작/디자인
  '디자인': '창작·디자인',
  '예술': '창작·디자인',
  '창작': '창작·디자인',
  '미디어': '창작·디자인',
  '콘텐츠': '창작·디자인',
  
  // 대인 서비스
  '서비스': '대인·서비스',
  '상담': '대인·서비스',
  '교육': '대인·서비스',
  '의료': '대인·서비스',
  '복지': '대인·서비스',
  '영업': '대인·서비스',
  
  // 관리/사무
  '경영': '관리·사무',
  '관리': '관리·사무',
  '사무': '관리·사무',
  '행정': '관리·사무',
  '재무': '관리·사무',
  '인사': '관리·사무',
  
  // 전문/연구
  '연구': '전문·연구',
  '법률': '전문·연구',
  '금융': '전문·연구',
  '컨설팅': '전문·연구',
  
  // 제조/생산
  '제조': '제조·생산',
  '생산': '제조·생산',
  '건설': '제조·생산',
  '물류': '제조·생산',
}

// ============================================
// 카테고리 → 추상 클러스터 라벨 변환
// ============================================
function categoryToClusterLabel(category: string | undefined): string {
  if (!category) return '기타'
  
  // 정확한 매핑 찾기
  for (const [key, label] of Object.entries(CATEGORY_TO_CLUSTER_LABEL)) {
    if (category.includes(key)) {
      return label
    }
  }
  
  return '기타'
}

// ============================================
// Vectorize 결과에서 클러스터 분석
// ============================================
interface ClusterAnalysis {
  topClusters: Array<{ label: string; count: number; percentage: number }>
  spread: number
  totalJobs: number
}

function analyzeClusterDistribution(
  vectorResults: VectorSearchResult[]
): ClusterAnalysis {
  const clusterCounts: Record<string, number> = {}
  
  for (const result of vectorResults) {
    const category = result.metadata?.category as string | undefined
    const label = categoryToClusterLabel(category)
    clusterCounts[label] = (clusterCounts[label] || 0) + 1
  }
  
  const total = vectorResults.length
  const entries = Object.entries(clusterCounts)
    .map(([label, count]) => ({
      label,
      count,
      percentage: total > 0 ? count / total : 0,
    }))
    .sort((a, b) => b.count - a.count)
  
  // spread: 상위 1개 클러스터의 비중 (높을수록 쏠림)
  const topPercentage = entries[0]?.percentage || 0
  const spread = Math.min(topPercentage * 1.5, 1) // 0.67 이상이면 쏠림으로 판단
  
  return {
    topClusters: entries.slice(0, 5),
    spread,
    totalJobs: total,
  }
}

// ============================================
// 대비 쌍 생성 (선택 분기점)
// ============================================
interface ContrastPair {
  pair: string
  why_uncertain: string
}

function generateContrastPairs(
  clusterAnalysis: ClusterAnalysis,
  axisCoverage?: AxisCoverage
): ContrastPair[] {
  const pairs: ContrastPair[] = []
  const topClusters = clusterAnalysis.topClusters
  
  // 클러스터 간 대비
  if (topClusters.length >= 2) {
    const first = topClusters[0]
    const second = topClusters[1]
    
    // 비슷한 비율이면 대비 쌍 생성
    if (first.percentage < 0.5 && second.percentage > 0.1) {
      pairs.push({
        pair: `${first.label} vs ${second.label}`,
        why_uncertain: `두 분야 모두 관심을 보임 (${Math.round(first.percentage * 100)}% vs ${Math.round(second.percentage * 100)}%)`,
      })
    }
  }
  
  // 축별 충돌 기반 대비
  if (axisCoverage) {
    // 가치관 충돌 예시
    const valuesState = axisCoverage.values
    if (valuesState.confidence < 0.5 && valuesState.evidence.length > 1) {
      pairs.push({
        pair: '안정 vs 도전',
        why_uncertain: '가치관에서 상반된 신호가 감지됨',
      })
    }
    
    // 업무 스타일 충돌
    const styleState = axisCoverage.work_style
    if (styleState.confidence < 0.5 && styleState.evidence.length > 0) {
      pairs.push({
        pair: '혼자 집중 vs 팀 협업',
        why_uncertain: '업무 스타일 선호가 명확하지 않음',
      })
    }
  }
  
  return pairs.slice(0, 3) // 최대 3개
}

// ============================================
// QSP 생성 메인 함수
// ============================================
export interface GenerateQSPInput {
  vectorResults: VectorSearchResult[]
  axisCoverage: AxisCoverage
  previousQSP?: QSP
  previousVIS?: VISOutput
  round?: 1 | 2 | 3
  openaiApiKey?: string  // VIS LLM 해석용 (optional)
}

/**
 * QSP 생성 (동기, VIS 포함 - LLM 해석 제외)
 */
export function generateQSP(input: GenerateQSPInput): QSP {
  const { vectorResults, axisCoverage, previousQSP, previousVIS, round = 1 } = input
  
  // 1. VIS 생성 (동기, LLM 해석 제외)
  const vis = synthesizeVectorInsightsSync({
    vectorResults,
    axisCoverage,
    previousVIS,
  })
  
  // 2. 클러스터 분석 (직업명 비노출)
  const clusterAnalysis = analyzeClusterDistribution(vectorResults)
  
  // 3. 이전 QSP 대비 변화량 계산
  let volatility = vis.metrics.volatility
  if (!previousQSP && !previousVIS) {
    const prevClusters = previousQSP ? new Set(previousQSP.retrieval_summary.top_clusters) : new Set()
    const currClusters = new Set(clusterAnalysis.topClusters.map(c => c.label))
    
    const intersection = [...currClusters].filter(c => prevClusters.has(c)).length
    const union = new Set([...prevClusters, ...currClusters]).size
    volatility = union > 0 ? 1 - (intersection / union) : 0
  }
  
  // 4. 대비 쌍 생성 (VIS tension_points 활용)
  const contrastPairs = generateContrastPairs(clusterAnalysis, axisCoverage)
  
  // VIS tension_points에서 추가 대비 쌍 생성
  for (const tp of vis.tension_points.slice(0, 2)) {
    if (!contrastPairs.some(cp => cp.pair.includes(tp.tension.slice(0, 10)))) {
      contrastPairs.push({
        pair: tp.tension,
        why_uncertain: tp.why,
      })
    }
  }
  
  // 5. 축별 부족 정보 힌트
  const missingAxisHints: Array<{ axis: AxisType; hint: string }> = []
  for (const axis of AXES) {
    const state = axisCoverage[axis]
    if (state.missing || state.confidence < 0.3) {
      const theme = AXIS_QUESTION_THEMES[axis]
      missingAxisHints.push({
        axis,
        hint: `${theme.ko_label} 정보가 부족함 (confidence: ${state.confidence.toFixed(2)})`,
      })
    }
  }
  
  // 6. 질문 대상 우선순위
  const priorityTargets = getHighPriorityAxes(axisCoverage, 3)
  const questionTargets = priorityTargets.map(t => ({
    axis: t.axis,
    reason: t.reason,
  }))
  
  // 7. 충분한 축 (질문 스킵)
  const doNotAsk: string[] = []
  for (const axis of AXES) {
    const state = axisCoverage[axis]
    if (state.confidence > 0.7 && !state.missing) {
      doNotAsk.push(AXIS_QUESTION_THEMES[axis].ko_label)
    }
  }
  
  return {
    retrieval_summary: {
      top_clusters: clusterAnalysis.topClusters.slice(0, 5).map(c => c.label),
      cluster_spread: vis.metrics.cluster_spread,  // VIS 메트릭 사용
      volatility,
    },
    contrast_pairs: contrastPairs.slice(0, 3),
    missing_axis_hints: missingAxisHints.slice(0, 5),
    question_targets: questionTargets,
    do_not_ask: doNotAsk,
    // VIS 통합 필드
    latent_patterns: vis.latent_patterns,
    tension_points: vis.tension_points,
  }
}

/**
 * QSP 생성 (비동기, VIS LLM 해석 포함)
 */
export async function generateQSPAsync(input: GenerateQSPInput): Promise<QSP> {
  const { vectorResults, axisCoverage, previousQSP, previousVIS, round = 1, openaiApiKey } = input
  
  // 1. VIS 생성 (비동기, LLM 해석 포함 가능)
  const vis = await synthesizeVectorInsights({
    vectorResults,
    axisCoverage,
    previousVIS,
    openaiApiKey,
  })
  
  // 기본 QSP 생성
  const baseQSP = generateQSP({
    ...input,
    previousVIS: vis,  // VIS 결과 전달
  })
  
  // VIS interpretation 추가
  return {
    ...baseQSP,
    latent_patterns: vis.latent_patterns,
    tension_points: vis.tension_points,
    vis_interpretation: vis.interpretation,
  }
}

// ============================================
// QSP → 질문 생성 힌트 텍스트 변환
// ============================================
export function qspToPromptHints(qsp: QSP): string {
  const hints: string[] = []
  
  // VIS 잠재 패턴 (직업명 없이 능력·성향·선호)
  if (qsp.latent_patterns && qsp.latent_patterns.length > 0) {
    hints.push('[사용자 잠재 패턴 - 질문 깊이를 위한 단서]')
    for (const p of qsp.latent_patterns.slice(0, 3)) {
      hints.push(`- ${p.pattern}`)
    }
    hints.push('')
  }
  
  // VIS 긴장점 (내면 갈등/불확실성)
  if (qsp.tension_points && qsp.tension_points.length > 0) {
    hints.push('[긴장점 - 질문으로 해소 필요]')
    for (const t of qsp.tension_points.slice(0, 3)) {
      hints.push(`- ${t.tension}: ${t.why}`)
    }
    hints.push('')
  }
  
  // 클러스터 정보 (직업명 비노출)
  hints.push(`[검색 결과 클러스터]`)
  hints.push(`- 주요 분야: ${qsp.retrieval_summary.top_clusters.join(', ')}`)
  hints.push(`- 분산도: ${(qsp.retrieval_summary.cluster_spread * 100).toFixed(0)}%`)
  hints.push(`- 변화량: ${(qsp.retrieval_summary.volatility * 100).toFixed(0)}%`)
  
  // 대비 쌍
  if (qsp.contrast_pairs.length > 0) {
    hints.push('')
    hints.push('[선택 분기점]')
    for (const cp of qsp.contrast_pairs) {
      hints.push(`- ${cp.pair}: ${cp.why_uncertain}`)
    }
  }
  
  // 질문 대상
  if (qsp.question_targets.length > 0) {
    hints.push('')
    hints.push('[질문 우선순위]')
    for (const qt of qsp.question_targets) {
      hints.push(`- ${qt.axis}: ${qt.reason}`)
    }
  }
  
  // 스킵 대상
  if (qsp.do_not_ask.length > 0) {
    hints.push('')
    hints.push(`[이미 충분한 정보] ${qsp.do_not_ask.join(', ')} - 질문 불필요`)
  }
  
  // VIS 해석 (LLM 생성 시)
  if (qsp.vis_interpretation) {
    hints.push('')
    hints.push(`[AI 해석] ${qsp.vis_interpretation.summary}`)
    hints.push(`[추천 질문 방향] ${qsp.vis_interpretation.suggested_angle}`)
  }
  
  return hints.join('\n')
}
