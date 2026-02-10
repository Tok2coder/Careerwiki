/**
 * Generate SQL for Job Dictionary Index from CSV
 * CSV → SQL 파일 생성 → wrangler d1 execute로 실행
 */

import * as fs from 'fs'
import * as path from 'path'

interface JobDictionaryRow {
  largeClassCd: string
  mediumClassCd: string
  smallClassCd: string
  dJobCd: string
  dJobCdSeq: string
  largeClassNm: string
  mediumClassNm: string
  smallClassNm: string
  jobNm: string
  relatedJob: string
  similarJobNm: string
}

function parseCSV(filePath: string): JobDictionaryRow[] {
  const content = fs.readFileSync(filePath, 'utf-8')
  const lines = content.split('\n')
  
  const rows: JobDictionaryRow[] = []
  
  // Skip first 2 lines (title and empty line), Line 3 is header
  for (let i = 3; i < lines.length; i++) {
    const line = lines[i].trim()
    if (!line) continue
    
    const parts = line.split(',').map(p => p.trim())
    if (parts.length < 11) continue
    
    const [
      largeClassCd, mediumClassCd, smallClassCd,
      dJobCd, dJobCdSeq,
      largeClassNm, mediumClassNm, smallClassNm,
      jobNm, relatedJob, similarJobNm
    ] = parts
    
    // Only include rows with valid job code AND sequence number AND job name
    if (!dJobCd || !jobNm || !dJobCdSeq || dJobCd.trim() === '' || dJobCdSeq.trim() === '') continue
    
    rows.push({
      largeClassCd: largeClassCd || '',
      mediumClassCd: mediumClassCd || '',
      smallClassCd: smallClassCd || '',
      dJobCd: dJobCd.trim(),
      dJobCdSeq: dJobCdSeq.trim(),
      largeClassNm: largeClassNm || '',
      mediumClassNm: mediumClassNm || '',
      smallClassNm: smallClassNm || '',
      jobNm: jobNm.trim(),
      relatedJob: relatedJob || '',
      similarJobNm: similarJobNm || ''
    })
  }
  
  return rows
}

function escapeSQL(str: string): string {
  if (!str || str.trim() === '') return 'NULL'
  // Replace single quotes with two single quotes for SQL escaping
  // Also remove any potential problematic characters
  const escaped = str.replace(/'/g, "''").replace(/\0/g, '')
  return `'${escaped}'`
}

function generateSQL(rows: JobDictionaryRow[]): string {
  const now = Date.now()
  const inserts: string[] = []
  
  for (const row of rows) {
    const sql = `INSERT INTO job_dictionary_index (
      d_job_cd, d_job_cd_seq,
      large_class_cd, medium_class_cd, small_class_cd,
      large_class_nm, medium_class_nm, small_class_nm,
      job_nm, related_job, similar_job_nm,
      is_seeded, created_at
    ) VALUES (
      ${escapeSQL(row.dJobCd)}, ${escapeSQL(row.dJobCdSeq)},
      ${row.largeClassCd ? escapeSQL(row.largeClassCd) : 'NULL'},
      ${row.mediumClassCd ? escapeSQL(row.mediumClassCd) : 'NULL'},
      ${row.smallClassCd ? escapeSQL(row.smallClassCd) : 'NULL'},
      ${row.largeClassNm ? escapeSQL(row.largeClassNm) : 'NULL'},
      ${row.mediumClassNm ? escapeSQL(row.mediumClassNm) : 'NULL'},
      ${row.smallClassNm ? escapeSQL(row.smallClassNm) : 'NULL'},
      ${escapeSQL(row.jobNm)},
      ${row.relatedJob ? escapeSQL(row.relatedJob) : 'NULL'},
      ${row.similarJobNm ? escapeSQL(row.similarJobNm) : 'NULL'},
      0, ${now}
    );`
    
    inserts.push(sql)
  }
  
  return inserts.join('\n')
}

// Main execution
const csvPath = path.join(process.cwd(), 'docs', '직업사전_세세분류_코드.csv')
const BATCH_SIZE = 100

console.log('📂 Reading CSV:', csvPath)
const rows = parseCSV(csvPath)
console.log(`📊 Parsed ${rows.length} job dictionary entries`)

// Ensure .temp directory exists
const tempDir = path.join(process.cwd(), '.temp')
if (!fs.existsSync(tempDir)) {
  fs.mkdirSync(tempDir, { recursive: true })
}

console.log('🔨 Generating SQL in batches...')
const batches = []
for (let i = 0; i < rows.length; i += BATCH_SIZE) {
  batches.push(rows.slice(i, i + BATCH_SIZE))
}

console.log(`💾 Writing ${batches.length} batch files...`)
for (let i = 0; i < batches.length; i++) {
  const batchSql = generateSQL(batches[i])
  const batchPath = path.join(tempDir, `job_dict_batch_${String(i + 1).padStart(3, '0')}.sql`)
  fs.writeFileSync(batchPath, batchSql, 'utf-8')
}

// Generate a master import script
const importScript = `# Job Dictionary Index Import Script
# Generated: ${new Date().toISOString()}
# Total records: ${rows.length}
# Batches: ${batches.length}

${batches.map((_, i) => 
  `echo "Importing batch ${i + 1}/${batches.length}..."\nnpx wrangler d1 execute careerwiki-kr --local --file=.temp/job_dict_batch_${String(i + 1).padStart(3, '0')}.sql`
).join('\n')}

echo "✅ All batches imported!"
echo "Verifying count..."
npx wrangler d1 execute careerwiki-kr --local --command="SELECT COUNT(*) as count FROM job_dictionary_index;"
`

const scriptPath = path.join(tempDir, 'import_job_dict.sh')
fs.writeFileSync(scriptPath, importScript, 'utf-8')

console.log(`✅ Done! Generated ${batches.length} batch files`)
console.log(`\nNext step: Run the import script:`)
console.log(`bash .temp/import_job_dict.sh`)
console.log(`\nOr on Windows PowerShell, run each batch manually.`)

