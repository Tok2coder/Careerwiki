/**
 * Re-seed empty majors: Full ETL pipeline
 * CareerNet + Goyong24 시딩 → major_sources 저장 → 병합 → merged_profile_json 업데이트
 *
 * Usage: node scripts/reseed-empty-majors.mjs
 */

import { readFileSync, writeFileSync, unlinkSync } from 'fs'
import { execSync } from 'child_process'

// ─── API Keys ────────────────────────────────────────────────────────
const devVars = readFileSync('.dev.vars', 'utf-8')
const CAREERNET_KEY = devVars.match(/CAREER_NET_API_KEY=(.+)/)?.[1]?.trim() || ''
const GOYONG24_KEY = devVars.match(/GOYONG24_MAJOR_API_KEY=(.+)/)?.[1]?.trim() || ''

const CAREERNET_BASE = 'https://www.career.go.kr/cnet/openapi'
const GOYONG24_BASE = 'https://www.work24.go.kr/cm/openApi/call/wk'

// ─── Helpers ─────────────────────────────────────────────────────────
const sleep = (ms) => new Promise(r => setTimeout(r, ms))

function decodeXml(v) {
  if (!v) return ''
  return v.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"').replace(/&#39;/g, "'")
    .replace(/&#xA;/gi, '\n').replace(/&#x[Dd];/gi, '')
}

function extractXmlTag(xml, tag) {
  const re = new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`)
  const m = xml.match(re)
  return m ? decodeXml(m[1]).trim() : null
}

function extractXmlTags(xml, tag) {
  const re = new RegExp(`<${tag}>([\\s\\S]*?)<\\/${tag}>`, 'g')
  const results = []
  let m
  while ((m = re.exec(xml)) !== null) results.push(decodeXml(m[1]).trim())
  return results
}

function parseXmlItems(xml, wrapperTag) {
  const items = []
  const re = new RegExp(`<${wrapperTag}>([\\s\\S]*?)<\\/${wrapperTag}>`, 'g')
  let m
  while ((m = re.exec(xml)) !== null) {
    const item = {}
    const fieldRe = /<([^\/>\s]+)>([^<]*)<\/\1>/g
    let fm
    while ((fm = fieldRe.exec(m[1])) !== null) {
      item[fm[1]] = decodeXml(fm[2]).trim()
    }
    if (Object.keys(item).length) items.push(item)
  }
  return items
}

function escapeSql(str) { return str.replace(/'/g, "''") }

function execD1(sql) {
  writeFileSync('tmp_reseed.sql', sql)
  try {
    const out = execSync(
      'npx wrangler d1 execute careerwiki-kr --remote --file=tmp_reseed.sql --json 2>&1',
      { encoding: 'utf-8', maxBuffer: 50 * 1024 * 1024 }
    )
    const jsonStart = out.indexOf('[')
    if (jsonStart >= 0) return JSON.parse(out.substring(jsonStart))
    return null
  } catch (e) {
    console.error('  D1 exec error:', e.message?.substring(0, 200))
    throw e
  }
}

function queryD1(sql) {
  const out = execSync(
    `npx wrangler d1 execute careerwiki-kr --remote --json --command "${sql.replace(/"/g, '\\"')}"`,
    { encoding: 'utf-8', maxBuffer: 50 * 1024 * 1024 }
  )
  const jsonStart = out.indexOf('[')
  if (jsonStart >= 0) return JSON.parse(out.substring(jsonStart))[0]?.results || []
  return []
}

// ─── CareerNet API ───────────────────────────────────────────────────
async function careernetSearch(keyword) {
  const url = new URL(`${CAREERNET_BASE}/getOpenApi`)
  url.searchParams.set('apiKey', CAREERNET_KEY)
  url.searchParams.set('svcType', 'api')
  url.searchParams.set('svcCode', 'MAJOR')
  url.searchParams.set('contentType', 'xml')
  url.searchParams.set('gubun', 'univ_list')
  url.searchParams.set('searchTitle', keyword)
  url.searchParams.set('perPage', '30')
  const resp = await fetch(url.toString())
  if (!resp.ok) throw new Error(`CareerNet search ${resp.status}`)
  return parseXmlItems(await resp.text(), 'content')
}

async function careernetDetail(majorSeq) {
  const url = new URL(`${CAREERNET_BASE}/getOpenApi`)
  url.searchParams.set('apiKey', CAREERNET_KEY)
  url.searchParams.set('svcType', 'api')
  url.searchParams.set('svcCode', 'MAJOR_VIEW')
  url.searchParams.set('contentType', 'json')
  url.searchParams.set('gubun', 'univ_list')
  url.searchParams.set('majorSeq', majorSeq)
  const resp = await fetch(url.toString())
  if (!resp.ok) throw new Error(`CareerNet detail ${resp.status}`)
  const json = await resp.json()
  return json.dataSearch?.content?.[0] || json
}

// ─── Goyong24 API ────────────────────────────────────────────────────
async function goyong24Search(keyword) {
  const url = new URL(`${GOYONG24_BASE}/callOpenApiSvcInfo213L01.do`)
  url.searchParams.set('authKey', GOYONG24_KEY)
  url.searchParams.set('returnType', 'XML')
  url.searchParams.set('target', 'MAJORCD')
  url.searchParams.set('srchType', 'K')
  url.searchParams.set('keyword', keyword)
  const resp = await fetch(url.toString())
  if (!resp.ok) throw new Error(`Goyong24 search ${resp.status}`)
  const xml = await resp.text()
  return parseXmlItems(xml, 'majorList')
}

async function goyong24Detail(majorGb, empCurtState1Id, empCurtState2Id) {
  const endpoint = majorGb === '2' ? 'callOpenApiSvcInfo213D02' : 'callOpenApiSvcInfo213D01'
  const url = new URL(`${GOYONG24_BASE}/${endpoint}.do`)
  url.searchParams.set('authKey', GOYONG24_KEY)
  url.searchParams.set('returnType', 'XML')
  url.searchParams.set('target', 'MAJORDTL')
  url.searchParams.set('majorGb', majorGb)
  url.searchParams.set('empCurtState1Id', empCurtState1Id)
  url.searchParams.set('empCurtState2Id', empCurtState2Id)
  const resp = await fetch(url.toString())
  if (!resp.ok) throw new Error(`Goyong24 detail ${resp.status}`)
  const xml = await resp.text()

  // Parse detail XML
  const detail = {
    majorGb, departmentId: empCurtState1Id, majorId: empCurtState2Id,
    departmentName: extractXmlTag(xml, 'knowDptNm'),
    majorName: extractXmlTag(xml, 'knowSchDptNm'),
    summary: extractXmlTag(xml, 'schDptIntroSum'),
    aptitude: extractXmlTag(xml, 'aptdIntrstCont'),
  }

  if (majorGb === '2') {
    detail.whatStudy = extractXmlTag(xml, 'whatStudy')
    detail.howPrepare = extractXmlTag(xml, 'howPrepare')
    detail.jobProspect = extractXmlTag(xml, 'jobProspect')
  } else {
    detail.mainSubjects = extractXmlTags(xml, 'mainEdusbjCont')
    detail.licenses = extractXmlTags(xml, 'adoptCertCont')
    detail.relatedJobs = extractXmlTags(xml, 'knowJobNm')
    detail.relatedMajors = extractXmlTags(xml, 'knowDtlSchDptNm')
    // Universities
    detail.universities = parseXmlItems(xml, 'univList').map(u => ({
      name: u.univNm, department: u.schDptNm, url: u.univUrl, universityType: u.univGbnNm
    }))
    // Recruitment
    detail.recruitmentStatus = parseXmlItems(xml, 'empSttsList').map(r => ({
      enrollmentQuota: r.enscMxnp, applicants: r.enscSpnb,
      graduates: r.grdnNmpr, universityType: r.univGbnNm, year: r.year
    }))
  }
  return detail
}

// ─── Merge Logic (port of mergeMajorProfiles.ts) ────────────────────
function extractFirstSentence(text) {
  if (!text || typeof text !== 'string') return null
  const m = text.match(/^(.+?[.?!。])\s*/)
  return m ? m[1].trim() : text.trim()
}

function dedupe(arr) {
  const seen = new Set()
  return (arr || []).filter(item => {
    if (item === null || item === undefined) return false
    const str = typeof item === 'string' ? item : item?.name || item?.subject_name || JSON.stringify(item)
    if (!str || typeof str !== 'string') return false
    const key = str.trim().toLowerCase()
    if (!key || seen.has(key)) return false
    seen.add(key)
    return true
  })
}

function splitToList(val) {
  if (!val) return []
  if (Array.isArray(val)) return val.map(v => typeof v === 'string' ? v.trim() : v?.name || v?.subject_name || String(v)).filter(Boolean)
  if (typeof val === 'object') return [val.name || JSON.stringify(val)].filter(Boolean)
  if (typeof val !== 'string') return []
  return val.split(/[,，\n]/).map(s => s.trim()).filter(Boolean)
}

function mergeMajorData(name, careernet, goyong24, goyong24Raw) {
  const cn = careernet || {}
  const w24 = goyong24 || {}
  const w24r = goyong24Raw || {}
  const hasCareernet = !!careernet
  const hasGoyong24 = !!goyong24

  // Determine category
  const categoryName = w24.departmentName || cn.facilName || cn.categoryName || null
  const majorGb = w24.majorGb || cn.majorGb || '1'

  // Hero
  const heroSummary = extractFirstSentence(w24.summary || cn.summary || cn.major_summary) || null
  const heroTags = dedupe([
    ...(cn.heroTags || []),
    ...splitToList(cn.facilName || cn.categoryName || ''),
    ...(w24.relatedMajors || [])
  ]).filter(t => t && t !== name)

  // Overview
  const summary = w24.summary || cn.summary || cn.major_summary || null
  const aptitude = cn.aptitude || cn.aptd_con || w24.aptitude || null
  const property = cn.property || cn.major_property || null

  // Detail fields
  const mainSubjects = dedupe([
    ...(w24.mainSubjects || []),
    ...splitToList(cn.main_subject || ''),
    ...splitToList(cn.relate_subject || '')
  ])

  // Universities
  const universities = (w24.universities?.length ? w24.universities : null) ||
    (cn.universityList?.length ? cn.universityList.map(u => ({
      name: u.schoolName, department: u.majorName, url: u.schoolURL
    })) : null)

  // Jobs and licenses
  const relatedJobs = dedupe([
    ...(w24.relatedJobs || []),
    ...splitToList(cn.relatedJob || cn.related_job || ''),
    ...splitToList(cn.enter_field || ''),
    ...splitToList(cn.career_act || '')
  ])
  const licenses = dedupe([
    ...(w24.licenses || []),
    ...splitToList(cn.qualifications || ''),
    ...splitToList(cn.licenses || '')
  ])

  // Parse JSON string fields from CareerNet
  const tryParse = (v) => { try { return typeof v === 'string' ? JSON.parse(v) : v } catch { return v } }
  const mainSubject = tryParse(cn.main_subject || cn.mainSubject) || undefined
  const relateSubject = tryParse(cn.relate_subject || cn.relateSubject) || undefined
  const careerAct = tryParse(cn.career_act || cn.careerAct) || undefined
  const enterField = tryParse(cn.enter_field || cn.enterField) || undefined

  // Special major fields (majorGb = '2')
  const whatStudy = majorGb === '2' ? null : (cn.whatStudy || w24r.whatStudy || undefined)
  const howPrepare = majorGb === '2' ? null : (cn.howPrepare || w24r.howPrepare || undefined)
  const jobProspect = majorGb === '2' ? null : (cn.jobProspect || w24r.jobProspect || undefined)

  const merged = {
    name,
    id: `major:${name}`,
    categoryId: w24.departmentId || cn.categoryId || null,
    categoryName,
    categoryDisplay: categoryName && (categoryName.match(/,/g) || []).length < 2 ? categoryName : null,
    majorGb,
    heroSummary,
    heroTags: heroTags.length ? heroTags : undefined,
    summary,
    property,
    aptitude,
    enterField,
    mainSubject,
    relateSubject,
    careerAct,
    whatStudy,
    howPrepare,
    jobProspect,
    mainSubjects: mainSubjects.length ? mainSubjects : undefined,
    universities,
    recruitmentStatus: w24.recruitmentStatus?.length ? w24.recruitmentStatus : undefined,
    chartData: cn.chartData || undefined,
    relatedJobs: relatedJobs.length ? relatedJobs : undefined,
    licenses: licenses.length ? licenses : undefined,
    relatedMajors: heroTags.length ? heroTags : undefined,
    salary: cn.salary || undefined,
    salaryAfterGraduation: cn.salaryAfterGraduation || undefined,
    employmentRate: cn.employmentRate || undefined,
    genCD: cn.GenCD || cn.genCD || undefined,
    schClass: cn.SchClass || cn.schClass || undefined,
    lstMiddleAptd: cn.lstMiddleAptd || undefined,
    lstHighAptd: cn.lstHighAptd || undefined,
    lstVals: cn.lstVals || undefined,
    sources: [
      ...(hasCareernet ? ['CAREERNET'] : []),
      ...(hasGoyong24 ? ['WORK24_MAJOR'] : [])
    ],
    sourceIds: {
      careernet: cn.majorSeq || null,
      work24: w24.majorId || null
    }
  }

  // Remove null/undefined/empty
  for (const key of Object.keys(merged)) {
    const v = merged[key]
    if (v === null || v === undefined || v === '' ||
        (Array.isArray(v) && v.length === 0) ||
        (typeof v === 'object' && v !== null && !Array.isArray(v) && Object.keys(v).every(k => !v[k]))) {
      delete merged[key]
    }
  }

  return merged
}

// ─── Main ────────────────────────────────────────────────────────────
async function main() {
  console.log('=' .repeat(60))
  console.log('🔄 Full ETL Reseed for Empty Majors')
  console.log('   CareerNet + Goyong24 → major_sources → merged_profile_json')
  console.log('=' .repeat(60))

  if (!CAREERNET_KEY) { console.error('❌ CAREER_NET_API_KEY missing'); process.exit(1) }
  if (!GOYONG24_KEY) { console.error('❌ GOYONG24_MAJOR_API_KEY missing'); process.exit(1) }

  // Step 0: Get empty majors from remote D1
  console.log('\n📋 Step 0: Fetching empty majors from production D1...')
  const emptyMajors = queryD1(
    "SELECT id, name FROM majors WHERE is_active = 1 AND (merged_profile_json IS NULL OR LENGTH(merged_profile_json) < 10) ORDER BY name"
  )
  console.log(`   Found ${emptyMajors.length} empty majors\n`)

  if (emptyMajors.length === 0) { console.log('✅ Nothing to do!'); return }

  const results = []
  let ok = 0, fail = 0

  for (const major of emptyMajors) {
    const { name } = major
    console.log(`\n${'─'.repeat(50)}`)
    console.log(`🔄 [${ok + fail + 1}/${emptyMajors.length}] ${name}`)

    let cnData = null, cnSeq = null
    let g24Data = null, g24Raw = null, g24Params = null

    // ── Step 1: CareerNet ──
    try {
      console.log('  📡 CareerNet: searching...')
      const sr = await careernetSearch(name)
      const exact = sr.find(r => (r.mClass || '').trim() === name)
      const match = exact || sr.find(r => (r.mClass || '').trim() === name.replace(/학과$|과$/, '')) || sr[0]

      if (match?.majorSeq) {
        cnSeq = match.majorSeq
        console.log(`  📡 CareerNet: found seq=${cnSeq} (${match.mClass})`)
        await sleep(350)
        cnData = await careernetDetail(cnSeq)
        cnData.facilName = match.facilName
        cnData.majorGb = match.majorGb
        console.log(`  ✅ CareerNet: ${cnData.summary ? 'has summary' : 'no summary'}, ${cnData.main_subject ? 'has subjects' : 'no subjects'}`)
      } else {
        console.log('  ⚠️  CareerNet: no results')
      }
    } catch (e) {
      console.log(`  ⚠️  CareerNet error: ${e.message}`)
    }
    await sleep(350)

    // ── Step 2: Goyong24 ──
    try {
      console.log('  📡 Goyong24: searching...')
      const sr = await goyong24Search(name)
      const exact = sr.find(r => (r.knowSchDptNm || '').trim() === name)
      const match = exact || sr.find(r => (r.knowSchDptNm || '').trim() === name.replace(/학과$|과$/, '')) || sr[0]

      if (match?.empCurtState2Id) {
        const majorGb = match.majorGb === '2' ? '2' : '1'
        g24Params = { majorGb, dept: match.empCurtState1Id, major: match.empCurtState2Id }
        console.log(`  📡 Goyong24: found ${match.knowSchDptNm} (gb=${majorGb})`)
        await sleep(350)
        g24Data = await goyong24Detail(majorGb, match.empCurtState1Id, match.empCurtState2Id)
        g24Raw = { ...g24Data }
        console.log(`  ✅ Goyong24: ${g24Data.summary ? 'has summary' : 'no summary'}, ${g24Data.universities?.length || 0} universities`)
      } else {
        console.log('  ⚠️  Goyong24: no results')
      }
    } catch (e) {
      console.log(`  ⚠️  Goyong24 error: ${e.message}`)
    }
    await sleep(350)

    if (!cnData && !g24Data) {
      console.log('  ❌ No data from either source')
      results.push({ name, status: 'no_data' })
      fail++
      continue
    }

    // ── Step 3: Save to major_sources ──
    try {
      if (cnData) {
        const sourceKey = `CAREERNET:${cnSeq}`
        const normalizedJson = escapeSql(JSON.stringify({
          name, majorSeq: cnSeq,
          summary: cnData.summary, aptitude: cnData.aptitude || cnData.aptd_con,
          property: cnData.property || cnData.major_property,
          main_subject: cnData.main_subject, relate_subject: cnData.relate_subject,
          career_act: cnData.career_act, enter_field: cnData.enter_field,
          relatedJob: cnData.relatedJob || cnData.related_job,
          salaryAfterGraduation: cnData.salaryAfterGraduation,
          employmentRate: cnData.employmentRate,
          chartData: cnData.chartData,
          GenCD: cnData.GenCD, SchClass: cnData.SchClass,
          lstMiddleAptd: cnData.lstMiddleAptd, lstHighAptd: cnData.lstHighAptd, lstVals: cnData.lstVals,
          sources: ['CAREERNET']
        }))
        const rawJson = escapeSql(JSON.stringify(cnData))
        const sql = `INSERT INTO major_sources (major_id, source_system, source_key, source_type, major_seq, raw_payload, normalized_payload, fetched_at, updated_at, retry_count)
VALUES ('${escapeSql(major.id)}', 'CAREERNET', '${escapeSql(sourceKey)}', 'DETAIL_UNIV', '${escapeSql(cnSeq)}', '${rawJson}', '${normalizedJson}', ${Date.now()}, ${Date.now()}, 0)
ON CONFLICT(source_system, source_key) DO UPDATE SET raw_payload = excluded.raw_payload, normalized_payload = excluded.normalized_payload, major_id = excluded.major_id, updated_at = excluded.updated_at;`
        execD1(sql)
        console.log('  💾 CareerNet source saved')
      }

      if (g24Data && g24Params) {
        const sourceKey = `WORK24_MAJOR:${g24Params.dept}:${g24Params.major}`
        const normalizedJson = escapeSql(JSON.stringify({
          name: g24Data.majorName || name,
          summary: g24Data.summary, aptitude: g24Data.aptitude,
          departmentName: g24Data.departmentName,
          mainSubjects: g24Data.mainSubjects, licenses: g24Data.licenses,
          universities: g24Data.universities, recruitmentStatus: g24Data.recruitmentStatus,
          relatedJobs: g24Data.relatedJobs, relatedMajors: g24Data.relatedMajors,
          whatStudy: g24Data.whatStudy, howPrepare: g24Data.howPrepare, jobProspect: g24Data.jobProspect,
          majorGb: g24Params.majorGb, departmentId: g24Params.dept, majorId: g24Params.major,
          sources: ['WORK24_MAJOR']
        }))
        const rawJson = escapeSql(JSON.stringify(g24Raw))
        const sql = `INSERT INTO major_sources (major_id, source_system, source_key, source_type, department_cd, gubun, raw_payload, normalized_payload, fetched_at, updated_at, retry_count)
VALUES ('${escapeSql(major.id)}', 'WORK24_MAJOR', '${escapeSql(sourceKey)}', '${g24Params.majorGb === '2' ? 'DETAIL_SPECIAL' : 'DETAIL_GENERAL'}', '${escapeSql(g24Params.dept)}', '${escapeSql(g24Params.majorGb)}', '${rawJson}', '${normalizedJson}', ${Date.now()}, ${Date.now()}, 0)
ON CONFLICT(source_system, source_key) DO UPDATE SET raw_payload = excluded.raw_payload, normalized_payload = excluded.normalized_payload, major_id = excluded.major_id, updated_at = excluded.updated_at;`
        execD1(sql)
        console.log('  💾 Goyong24 source saved')
      }
    } catch (e) {
      console.log(`  ⚠️  Source save error: ${e.message?.substring(0, 200)}`)
      // Continue to merge even if source save fails
    }

    // ── Step 4: Merge ──
    try {
      const merged = mergeMajorData(name, cnData, g24Data, g24Raw)
      const mergedJson = JSON.stringify(merged)
      console.log(`  🔀 Merged: ${Object.keys(merged).length} fields, ${(mergedJson.length / 1024).toFixed(1)}KB`)

      // Determine primary source
      const primarySource = cnData ? 'CAREERNET' : 'WORK24_MAJOR'

      // Update majors table
      const updateSql = `UPDATE majors SET merged_profile_json = '${escapeSql(mergedJson)}', primary_source = '${primarySource}'${cnSeq ? `, careernet_id = '${escapeSql(cnSeq)}'` : ''}${g24Params ? `, goyong24_id = '${escapeSql(g24Params.major)}'` : ''} WHERE id = '${escapeSql(major.id)}';`
      execD1(updateSql)

      // Invalidate ISR cache
      try {
        execD1(`DELETE FROM wiki_pages WHERE slug = '${escapeSql(name)}' AND page_type = 'major';`)
      } catch { /* best effort */ }

      console.log(`  ✅ ${name} — merged & saved!`)
      results.push({ name, status: 'success', sources: merged.sources })
      ok++
    } catch (e) {
      console.log(`  ❌ Merge/save error: ${e.message?.substring(0, 200)}`)
      results.push({ name, status: 'error', error: e.message })
      fail++
    }
  }

  // Cleanup
  try { unlinkSync('tmp_reseed.sql') } catch {}

  // Summary
  console.log('\n' + '='.repeat(60))
  console.log('📊 FINAL RESULTS')
  console.log('='.repeat(60))
  console.log(`Total: ${emptyMajors.length}  |  Success: ${ok}  |  Failed: ${fail}`)
  console.log('')
  for (const r of results) {
    const icon = r.status === 'success' ? '✅' : '❌'
    const src = r.sources ? ` [${r.sources.join('+')}]` : ''
    console.log(`  ${icon} ${r.name}: ${r.status}${src}${r.error ? ` — ${r.error}` : ''}`)
  }
  console.log('='.repeat(60))
}

main().catch(e => { console.error('Fatal:', e); process.exit(1) })
