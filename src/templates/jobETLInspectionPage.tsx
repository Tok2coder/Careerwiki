import type { UnifiedJobDetail } from '../types/unifiedProfiles'
import type { JobSourceRow } from '../types/database'

// 소스별 색상
const SOURCE_COLORS = {
  CAREERNET: { border: 'border-blue-500', bg: 'bg-blue-500/10', text: 'text-blue-400' },
  WORK24_JOB: { border: 'border-green-500', bg: 'bg-green-500/10', text: 'text-green-400' },
  WORK24_DJOB: { border: 'border-purple-500', bg: 'bg-purple-500/10', text: 'text-purple-400' },
  MERGED: { border: 'border-yellow-500', bg: 'bg-yellow-500/10', text: 'text-yellow-400' }
}

const SOURCE_LABELS = {
  CAREERNET: '커리어넷 직업백과',
  WORK24_JOB: '고용24 직업정보',
  WORK24_DJOB: '고용24 직업사전',
  MERGED: 'ETL 병합 결과 (jobs.merged_profile_json)'
}

interface FieldInfo {
  path: string
  type: string
  value: any
  example?: string
  description?: string
}

interface SourceData {
  system: string
  rawFields: FieldInfo[]
  normalizedFields: FieldInfo[]
  mergedFields: FieldInfo[]
  missingFields: FieldInfo[]
}

function escapeHtml(text: string): string {
  const map: Record<string, string> = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#039;'
  }
  return String(text).replace(/[&<>"']/g, m => map[m])
}

function formatValue(value: any, maxLength = 200): string {
  if (value === null || value === undefined) {
    return '<span class="text-gray-400">null</span>'
  }
  
  if (typeof value === 'string') {
    const escaped = escapeHtml(value)
    if (value.length > maxLength) {
      return `<span title="${escaped}">${escaped.substring(0, maxLength)}...</span>`
    }
    return escaped
  }
  
  if (Array.isArray(value)) {
    return `<span class="text-purple-400">Array[${value.length}]</span> ${value.length > 0 ? formatValue(value[0], 50) : ''}`
  }
  
  if (typeof value === 'object') {
    return `<span class="text-blue-400">Object</span> {${Object.keys(value).slice(0, 3).join(', ')}${Object.keys(value).length > 3 ? '...' : ''}}`
  }
  
  return String(value)
}

function getType(value: any): string {
  if (value === null || value === undefined) return 'null'
  if (Array.isArray(value)) return 'array'
  return typeof value
}

function getAllFields(obj: any, prefix = '', maxDepth = 5): FieldInfo[] {
  const fields: FieldInfo[] = []
  if (!obj || typeof obj !== 'object' || maxDepth <= 0) return fields
  
  for (const key in obj) {
    if (key.startsWith('__')) continue
    const path = prefix ? `${prefix}.${key}` : key
    const value = obj[key]
    const type = getType(value)
    
    let example = ''
    if (typeof value === 'string') {
      example = value.length > 50 ? value.substring(0, 50) + '...' : value
    } else if (Array.isArray(value) && value.length > 0) {
      example = `[${value.length} items] ${JSON.stringify(value[0]).substring(0, 30)}...`
    } else if (typeof value === 'object' && value !== null) {
      example = `{${Object.keys(value).slice(0, 3).join(', ')}}`
    }
    
    fields.push({
      path,
      type,
      value,
      example: example || undefined
    })
    
    // 중첩 객체 탐색
    if (typeof value === 'object' && value !== null && !Array.isArray(value)) {
      fields.push(...getAllFields(value, path, maxDepth - 1))
    }
  }
  
  return fields
}

function compareFields(sourceFields: FieldInfo[], mergedFields: FieldInfo[]): {
  present: FieldInfo[]
  missing: FieldInfo[]
} {
  const mergedPaths = new Set(mergedFields.map(f => f.path))
  
  const present: FieldInfo[] = []
  const missing: FieldInfo[] = []
  
  sourceFields.forEach(field => {
    // 정확한 경로 매칭 또는 상위 경로 매칭
    const isPresent = mergedPaths.has(field.path) || 
      Array.from(mergedPaths).some(mp => mp.startsWith(field.path + '.') || field.path.startsWith(mp + '.'))
    
    if (isPresent) {
      present.push(field)
    } else {
      missing.push(field)
    }
  })
  
  return { present, missing }
}

export function renderJobETLInspectionPage(
  jobName: string,
  jobId: string,
  sources: JobSourceRow[],
  mergedProfile: UnifiedJobDetail | null
): string {
  // 소스별 데이터 파싱
  const sourceDataMap = new Map<string, SourceData>()
  
  sources.forEach(source => {
    const system = source.source_system
    if (!sourceDataMap.has(system)) {
      sourceDataMap.set(system, {
        system,
        rawFields: [],
        normalizedFields: [],
        mergedFields: [],
        missingFields: []
      })
    }
    
    const sourceData = sourceDataMap.get(system)!
    
    // Raw payload 파싱
    try {
      const rawPayload = source.raw_payload ? JSON.parse(source.raw_payload) : null
      if (rawPayload) {
        sourceData.rawFields = getAllFields(rawPayload)
      }
    } catch (e) {
    }
    
    // Normalized payload 파싱
    try {
      const normalizedPayload = source.normalized_payload ? JSON.parse(source.normalized_payload) : null
      if (normalizedPayload) {
        sourceData.normalizedFields = getAllFields(normalizedPayload)
      }
    } catch (e) {
    }
  })
  
  // Merged profile 필드 추출
  let mergedFields: FieldInfo[] = []
  if (mergedProfile) {
    mergedFields = getAllFields(mergedProfile)
    
    // 각 소스별로 병합된 필드와 누락된 필드 비교
    sourceDataMap.forEach((sourceData, system) => {
      const comparison = compareFields(sourceData.normalizedFields, mergedFields)
      sourceData.mergedFields = comparison.present
      sourceData.missingFields = comparison.missing
    })
  }
  
  // HTML 생성
  const sourceSections = Array.from(sourceDataMap.values()).map(sourceData => {
    const colors = SOURCE_COLORS[sourceData.system as keyof typeof SOURCE_COLORS] || SOURCE_COLORS.MERGED
    const label = SOURCE_LABELS[sourceData.system as keyof typeof SOURCE_LABELS] || sourceData.system
    
    return `
      <div class="mb-8 ${colors.border} border-l-4 pl-4">
        <h2 class="text-2xl font-bold mb-4 ${colors.text}">${label}</h2>
        
        <!-- Raw Data Fields -->
        <div class="mb-6">
          <button onclick="toggleSection('raw-${sourceData.system}')" class="flex items-center gap-2 text-lg font-semibold mb-2 cursor-pointer hover:opacity-80">
            <span id="raw-${sourceData.system}-icon">▼</span>
            <span>원본 데이터 필드 (raw_payload)</span>
            <span class="text-sm text-gray-400">(${sourceData.rawFields.length}개)</span>
          </button>
          <div id="raw-${sourceData.system}" class="hidden ml-6">
            ${renderFieldTable(sourceData.rawFields)}
          </div>
        </div>
        
        <!-- Normalized Data Fields -->
        <div class="mb-6">
          <button onclick="toggleSection('normalized-${sourceData.system}')" class="flex items-center gap-2 text-lg font-semibold mb-2 cursor-pointer hover:opacity-80">
            <span id="normalized-${sourceData.system}-icon">▼</span>
            <span>정규화된 데이터 필드 (normalized_payload)</span>
            <span class="text-sm text-gray-400">(${sourceData.normalizedFields.length}개)</span>
          </button>
          <div id="normalized-${sourceData.system}" class="hidden ml-6">
            ${renderFieldTable(sourceData.normalizedFields)}
          </div>
        </div>
        
        <!-- Merged Fields (ETL 결과에 포함된 필드) -->
        <div class="mb-6">
          <button onclick="toggleSection('merged-${sourceData.system}')" class="flex items-center gap-2 text-lg font-semibold mb-2 cursor-pointer hover:opacity-80">
            <span id="merged-${sourceData.system}-icon">▼</span>
            <span>ETL 병합 결과에 포함된 필드</span>
            <span class="text-sm text-gray-400">(${sourceData.mergedFields.length}개)</span>
          </button>
          <div id="merged-${sourceData.system}" class="hidden ml-6">
            ${renderFieldTable(sourceData.mergedFields)}
          </div>
        </div>
        
        <!-- Missing Fields (ETL 결과에 누락된 필드) -->
        <div class="mb-6">
          <button onclick="toggleSection('missing-${sourceData.system}')" class="flex items-center gap-2 text-lg font-semibold mb-2 cursor-pointer hover:opacity-80">
            <span id="missing-${sourceData.system}-icon">▼</span>
            <span>ETL 병합 결과에 누락된 필드</span>
            <span class="text-sm text-red-400">(${sourceData.missingFields.length}개)</span>
          </button>
          <div id="missing-${sourceData.system}" class="hidden ml-6">
            ${sourceData.missingFields.length > 0 
              ? renderFieldTable(sourceData.missingFields)
              : '<p class="text-gray-400">누락된 필드가 없습니다.</p>'
            }
          </div>
        </div>
      </div>
    `
  }).join('')
  
  // Merged Profile 전체 필드
  const mergedSection = `
    <div class="mb-8 ${SOURCE_COLORS.MERGED.border} border-l-4 pl-4">
      <h2 class="text-2xl font-bold mb-4 ${SOURCE_COLORS.MERGED.text}">ETL 병합 결과 전체 필드 (jobs.merged_profile_json)</h2>
      <button onclick="toggleSection('merged-all')" class="flex items-center gap-2 text-lg font-semibold mb-2 cursor-pointer hover:opacity-80">
        <span id="merged-all-icon">▼</span>
        <span>전체 필드 목록</span>
        <span class="text-sm text-gray-400">(${mergedFields.length}개)</span>
      </button>
      <div id="merged-all" class="hidden ml-6">
        ${renderFieldTable(mergedFields)}
      </div>
    </div>
  `
  
  return `
    <!DOCTYPE html>
    <html lang="ko">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>ETL 병합 로직 점검 - ${jobName}</title>
      <link rel="stylesheet" href="/static/tailwind.css">
      <style>
        body { background: #0a0a0a; color: #e5e5e5; font-family: system-ui, -apple-system, sans-serif; }
        .field-table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        .field-table th, .field-table td { padding: 0.75rem; text-align: left; border-bottom: 1px solid #333; }
        .field-table th { background: #1a1a1a; font-weight: 600; }
        .field-table tr:hover { background: #1a1a1a; }
        .type-badge { padding: 0.25rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600; }
        .type-string { background: #3b82f6; color: white; }
        .type-number { background: #10b981; color: white; }
        .type-boolean { background: #f59e0b; color: white; }
        .type-array { background: #8b5cf6; color: white; }
        .type-object { background: #ec4899; color: white; }
        .type-null { background: #6b7280; color: white; }
      </style>
    </head>
    <body class="p-8">
      <div class="max-w-7xl mx-auto">
        <h1 class="text-4xl font-bold mb-2">ETL 병합 로직 점검</h1>
        <p class="text-gray-400 mb-8">직업: <strong class="text-white">${jobName}</strong> (ID: ${jobId})</p>
        
        <div class="mb-6 p-4 bg-yellow-900/20 border border-yellow-500/50 rounded">
          <h3 class="font-semibold mb-2">📋 병합 규칙</h3>
          <ul class="list-disc list-inside space-y-1 text-sm">
            <li><strong>우선순위:</strong> CAREERNET > WORK24_JOB > WORK24_DJOB</li>
            <li><strong>데이터 소스:</strong> normalized_payload 우선, 비어있으면 raw_payload 확인</li>
            <li><strong>필드 병합:</strong> mergeFieldByPriority 함수 사용</li>
            <li><strong>특수 처리:</strong> summary 필드는 duty.jobSum도 확인, dJobICdNm은 대괄호 제거</li>
          </ul>
        </div>
        
        ${sourceSections}
        ${mergedSection}
        
        <div class="mt-8 p-4 bg-blue-900/20 border border-blue-500/50 rounded">
          <h3 class="font-semibold mb-2">🔍 렌더링 확인</h3>
          <p class="mb-2">실제 렌더링된 페이지:</p>
          <a href="/job/${encodeURIComponent(jobName.toLowerCase().replace(/\s+/g, '-'))}" 
             target="_blank" 
             class="text-blue-400 hover:underline">
            /job/${encodeURIComponent(jobName.toLowerCase().replace(/\s+/g, '-'))}
          </a>
        </div>
      </div>
      
      <script>
        function toggleSection(id) {
          const section = document.getElementById(id)
          const icon = document.getElementById(id + '-icon')
          if (section.classList.contains('hidden')) {
            section.classList.remove('hidden')
            icon.textContent = '▼'
          } else {
            section.classList.add('hidden')
            icon.textContent = '▶'
          }
        }
      </script>
    </body>
    </html>
  `
}

function renderFieldTable(fields: FieldInfo[]): string {
  if (fields.length === 0) {
    return '<p class="text-gray-400">필드가 없습니다.</p>'
  }
  
  const rows = fields.map(field => {
    const typeClass = `type-${field.type}`
    return `
      <tr>
        <td class="font-mono text-sm">${escapeHtml(field.path)}</td>
        <td><span class="type-badge ${typeClass}">${field.type}</span></td>
        <td class="text-sm">${formatValue(field.value)}</td>
        <td class="text-xs text-gray-400">${field.example ? escapeHtml(String(field.example)) : '-'}</td>
      </tr>
    `
  }).join('')
  
  return `
    <table class="field-table">
      <thead>
        <tr>
          <th>필드 경로</th>
          <th>타입</th>
          <th>값</th>
          <th>예시</th>
        </tr>
      </thead>
      <tbody>
        ${rows}
      </tbody>
    </table>
  `
}

