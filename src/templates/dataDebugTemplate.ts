import type { DataSource, UnifiedJobDetail } from '../types/unifiedProfiles'
import type { SourceStatusRecord } from '../services/profileDataService'
import { escapeHtml } from './detailTemplateUtils'

export interface DataDebugTemplateParams {
  profile: UnifiedJobDetail | null
  partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>
  sources?: SourceStatusRecord
  rawApiData?: {
    careernet?: any
    goyong24?: any
  }
}

const renderJsonTable = (data: any, title: string): string => {
  if (!data) {
    return `
      <div class="bg-gray-50 border border-gray-200 rounded-lg p-4">
        <h3 class="text-lg font-bold text-gray-700 mb-2">${escapeHtml(title)}</h3>
        <p class="text-gray-500">데이터 없음</p>
      </div>
    `
  }

  const renderValue = (value: any, depth: number = 0): string => {
    if (value === null || value === undefined) {
      return `<span class="text-gray-400">null</span>`
    }
    
    if (typeof value === 'boolean') {
      return `<span class="text-blue-600">${value}</span>`
    }
    
    if (typeof value === 'number') {
      return `<span class="text-green-600">${value}</span>`
    }
    
    if (typeof value === 'string') {
      const escaped = escapeHtml(value)
      return `<span class="text-purple-600">"${escaped}"</span>`
    }
    
    if (Array.isArray(value)) {
      if (value.length === 0) {
        return `<span class="text-gray-400">[]</span>`
      }
      
      const items = value.slice(0, 10).map((item, index) => `
        <div class="ml-4 border-l-2 border-gray-200 pl-2 py-1">
          <span class="text-gray-500 text-xs">[${index}]</span> ${renderValue(item, depth + 1)}
        </div>
      `).join('')
      
      const more = value.length > 10 ? `<div class="ml-4 text-gray-500 text-xs">... (총 ${value.length}개 항목)</div>` : ''
      
      return `<div class="my-1">${items}${more}</div>`
    }
    
    if (typeof value === 'object') {
      const entries = Object.entries(value)
      if (entries.length === 0) {
        return `<span class="text-gray-400">{}</span>`
      }
      
      if (depth > 2) {
        return `<span class="text-gray-500 text-xs">[Object with ${entries.length} keys]</span>`
      }
      
      const items = entries.map(([key, val]) => `
        <div class="ml-4 border-l-2 border-gray-200 pl-2 py-1">
          <span class="text-blue-700 font-mono text-sm">${escapeHtml(key)}:</span> ${renderValue(val, depth + 1)}
        </div>
      `).join('')
      
      return `<div class="my-1">${items}</div>`
    }
    
    return `<span class="text-gray-600">${String(value)}</span>`
  }

  return `
    <div class="bg-white border border-gray-300 rounded-lg p-4 mb-6">
      <h3 class="text-xl font-bold text-gray-800 mb-4 pb-2 border-b-2 border-gray-200">
        ${escapeHtml(title)}
      </h3>
      <div class="overflow-auto max-h-[800px] font-mono text-sm">
        ${renderValue(data)}
      </div>
    </div>
  `
}

const renderFieldComparisonTable = (partials?: Partial<Record<DataSource, UnifiedJobDetail | null>>): string => {
  if (!partials) {
    return '<p class="text-gray-500">데이터 없음</p>'
  }

  const careernet = partials.CAREERNET
  const goyong24 = partials.GOYONG24

  const allFields = new Set<string>()
  if (careernet) Object.keys(careernet).forEach(key => allFields.add(key))
  if (goyong24) Object.keys(goyong24).forEach(key => allFields.add(key))

  const fields = Array.from(allFields).sort()

  const rows = fields.map(field => {
    const careernetValue = careernet ? (careernet as any)[field] : undefined
    const goyong24Value = goyong24 ? (goyong24 as any)[field] : undefined

    const formatValue = (value: any): string => {
      if (value === null || value === undefined) {
        return '<span class="text-gray-300">-</span>'
      }
      
      if (Array.isArray(value)) {
        return `<span class="text-blue-600">[${value.length}개 항목]</span>`
      }
      
      if (typeof value === 'object') {
        return '<span class="text-purple-600">[Object]</span>'
      }
      
      const str = String(value)
      if (str.length > 100) {
        return `<span class="text-gray-700">${escapeHtml(str.substring(0, 100))}...</span>`
      }
      
      return `<span class="text-gray-700">${escapeHtml(str)}</span>`
    }

    return `
      <tr class="border-b border-gray-200 hover:bg-gray-50">
        <td class="px-4 py-3 font-semibold text-sm text-gray-800 bg-gray-50">
          ${escapeHtml(field)}
        </td>
        <td class="px-4 py-3 text-sm">
          ${formatValue(careernetValue)}
        </td>
        <td class="px-4 py-3 text-sm">
          ${formatValue(goyong24Value)}
        </td>
      </tr>
    `
  }).join('')

  return `
    <div class="overflow-x-auto mb-6">
      <table class="w-full border border-gray-300 rounded-lg">
        <thead>
          <tr class="bg-gray-100 border-b-2 border-gray-300">
            <th class="px-4 py-3 text-left text-sm font-bold text-gray-700">필드명</th>
            <th class="px-4 py-3 text-left text-sm font-bold text-gray-700">커리어넷 (CareerNet)</th>
            <th class="px-4 py-3 text-left text-sm font-bold text-gray-700">고용24 (Goyong24)</th>
          </tr>
        </thead>
        <tbody>
          ${rows}
        </tbody>
      </table>
    </div>
  `
}

export const renderDataDebugPage = (params: DataDebugTemplateParams): string => {
  const { profile, partials, sources, rawApiData } = params

  const jobTitle = profile?.name || '직업 정보'
  const careernetId = profile?.sourceIds?.careernet || 'N/A'
  const goyong24Id = profile?.sourceIds?.goyong24 || 'N/A'

  return `
    <div class="min-h-screen bg-gray-100 py-8 px-4">
      <div class="max-w-7xl mx-auto">
        <!-- Header -->
        <div class="bg-white rounded-lg shadow-lg p-6 mb-6">
          <h1 class="text-3xl font-bold text-gray-900 mb-4">
            <i class="fas fa-database mr-3 text-blue-600"></i>
            데이터 수집 디버그: ${escapeHtml(jobTitle)}
          </h1>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
              <h3 class="text-sm font-bold text-blue-900 mb-2">커리어넷 ID</h3>
              <p class="text-lg font-mono text-blue-700">${escapeHtml(careernetId)}</p>
              <p class="text-xs text-gray-600 mt-1">API: getOpenApi?svcCode=JOB_VIEW&jobdicSeq=${escapeHtml(careernetId)}</p>
            </div>
            
            <div class="bg-green-50 border border-green-200 rounded-lg p-4">
              <h3 class="text-sm font-bold text-green-900 mb-2">고용24 ID</h3>
              <p class="text-lg font-mono text-green-700">${escapeHtml(goyong24Id)}</p>
              <p class="text-xs text-gray-600 mt-1">API: callOpenApiSvcInfo212D01?jobCd=${escapeHtml(goyong24Id)}</p>
            </div>
          </div>
        </div>

        <!-- Source Status -->
        ${sources ? `
          <div class="bg-white rounded-lg shadow-lg p-6 mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-4">
              <i class="fas fa-signal mr-2 text-green-600"></i>
              API 호출 상태
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              ${Object.entries(sources).map(([source, status]) => `
                <div class="border rounded-lg p-4 ${status.attempted ? (status.error ? 'bg-red-50 border-red-300' : 'bg-green-50 border-green-300') : 'bg-gray-50 border-gray-300'}">
                  <h3 class="font-bold text-lg mb-2">${source}</h3>
                  <div class="text-sm space-y-1">
                    <p>시도: <span class="font-mono">${status.attempted ? '✅' : '❌'}</span></p>
                    ${status.count !== undefined ? `<p>결과: <span class="font-mono">${status.count}개</span></p>` : ''}
                    ${status.error ? `<p class="text-red-600">에러: ${escapeHtml(status.error)}</p>` : ''}
                    ${status.skippedReason ? `<p class="text-gray-600">건너뜀: ${escapeHtml(status.skippedReason)}</p>` : ''}
                  </div>
                </div>
              `).join('')}
            </div>
          </div>
        ` : ''}

        <!-- Field Comparison Table -->
        <div class="bg-white rounded-lg shadow-lg p-6 mb-6">
          <h2 class="text-2xl font-bold text-gray-800 mb-4">
            <i class="fas fa-table mr-2 text-purple-600"></i>
            필드별 데이터 비교
          </h2>
          ${renderFieldComparisonTable(partials)}
        </div>

        <!-- Raw API Data (CareerNet) -->
        ${rawApiData?.careernet ? renderJsonTable(rawApiData.careernet, '커리어넷 원본 API 응답 (CareerNet Raw Response)') : ''}

        <!-- Raw API Data (Goyong24) -->
        ${rawApiData?.goyong24 ? renderJsonTable(rawApiData.goyong24, '고용24 원본 API 응답 (Goyong24 Raw Response)') : ''}

        <!-- Merged Profile -->
        ${profile ? renderJsonTable(profile, '병합된 최종 프로필 (Merged Profile)') : ''}

        <!-- Back Button -->
        <div class="text-center mt-8">
          <a href="/job/lawyer" class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-8 rounded-lg transition-colors">
            <i class="fas fa-arrow-left mr-2"></i>
            일반 페이지로 돌아가기
          </a>
        </div>
      </div>
    </div>
  `
}
