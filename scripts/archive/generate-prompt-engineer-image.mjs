/**
 * 프롬프트엔지니어 이미지 재생성 스크립트
 * geminiService.ts의 JOB_PROMPT_TEMPLATE과 동일한 로직 사용
 * (Gemini 일일 쿼터 소진으로 OpenAI로 동일 템플릿 실행)
 */
import fs from 'fs'
import https from 'https'

// .dev.vars에서 키 읽기
const devvars = fs.readFileSync('C:/Users/PC/Careerwiki/.dev.vars', 'utf8')
const getKey = (name) => {
  const m = devvars.match(new RegExp(`${name}=(.+)`))
  return m ? m[1].trim() : null
}
const OPENAI_KEY = getKey('OPENAI_API_KEY')
const EVOLINK_KEY = getKey('EVOLINK_API_KEY')
const ADMIN_SECRET = getKey('ADMIN_SECRET')

if (!OPENAI_KEY || !EVOLINK_KEY || !ADMIN_SECRET) {
  console.error('Missing API keys:', { OPENAI_KEY: !!OPENAI_KEY, EVOLINK_KEY: !!EVOLINK_KEY, ADMIN_SECRET: !!ADMIN_SECRET })
  process.exit(1)
}

// geminiService.ts의 JOB_PROMPT_TEMPLATE과 동일
const JOB_PROMPT_TEMPLATE = `You will create ONE paragraph describing an image prompt based on the job "{jobName}".
Follow all rules silently. Do NOT output lists, examples, or meta-text.

RULES (DO NOT OUTPUT THESE):

1) FIXED CHARACTER STYLE
Always describe the beaver exactly as:
"a small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style."
The style must never shift to realism, chibi, furry-detail, or alternative aesthetics.

2) JOB-SPECIFIC ACTION (MANDATORY)
The beaver must be shown performing ONE clear, physical, job-specific action appropriate for "{jobName}".
The action must involve direct, visible interaction with professional tools, devices, machinery, or materials that are genuinely used in this job.
The action must be concrete and visually obvious (e.g., tightening, assembling, calibrating, soldering, operating, adjusting, monitoring, sketching, programming, extinguishing).
Do NOT use abstract actions such as "performing duties," "consulting," "analyzing," or "overseeing."

3) PROFESSIONAL EQUIPMENT & UNIFORM
If the job normally requires a uniform, protective gear, or standard professional attire, the beaver must be wearing an appropriate simplified version of that uniform.
If the job requires specialized equipment (e.g., VR headsets, medical devices, safety helmets, lab coats, harnesses), the beaver must be clearly wearing or using that equipment as part of the action.

4) JOB-SPECIFIC ENVIRONMENT
Describe a wide, detailed workplace that is unmistakably associated with "{jobName}".
Include specific professional tools, machines, instruments, materials, or architectural elements unique to this job.
Avoid generic phrases such as "professional workplace," "relevant tools," or "appropriate equipment."

5) CHARACTER SIZE
The beaver should appear small and natural within the scene, occupying approximately **12% of the frame**, allowing the environment and professional context to dominate visually.

6) VISUAL STYLE
2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, and cinematic rim light.
Dark-mode palette: deep navy, muted violet, soft teal glow accents.
The background should be rich and detailed but never overpower the character.

7) PROHIBITED
No text, labels, signage, numbers, lists, meta commentary, logos, or photorealistic humans or animals.

OUTPUT
Produce ONE concise paragraph (<2000 characters) describing the final scene.
Do NOT mention rules or provide explanations.`

function post(hostname, path, data, headers) {
  return new Promise((resolve, reject) => {
    const body = typeof data === 'string' ? data : JSON.stringify(data)
    const opts = {
      hostname,
      path,
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'Content-Length': Buffer.byteLength(body), ...headers }
    }
    const req = https.request(opts, res => {
      let d = ''
      res.on('data', c => d += c)
      res.on('end', () => resolve(JSON.parse(d)))
    })
    req.on('error', reject)
    req.write(body)
    req.end()
  })
}

function get(hostname, path, headers) {
  return new Promise((resolve, reject) => {
    const opts = { hostname, path, method: 'GET', headers }
    const req = https.request(opts, res => {
      let d = ''
      res.on('data', c => d += c)
      res.on('end', () => resolve(JSON.parse(d)))
    })
    req.on('error', reject)
    req.end()
  })
}

async function main() {
  const jobName = '프롬프트엔지니어'
  const slug = '프롬프트엔지니어'

  // Step 1: geminiService.ts의 JOB_PROMPT_TEMPLATE과 동일한 로직으로 프롬프트 생성
  // (Gemini 일일 쿼터 소진으로 OpenAI GPT-4o-mini 사용, 동일 템플릿 적용)
  console.log('[1/4] Generating image prompt via OpenAI (same JOB_PROMPT_TEMPLATE as geminiService.ts)...')
  const systemPrompt = JOB_PROMPT_TEMPLATE.replace(/\{jobName\}/g, jobName)

  const openaiRes = await post('api.openai.com', '/v1/chat/completions', {
    model: 'gpt-4o-mini',
    messages: [{ role: 'user', content: systemPrompt }],
    temperature: 0.7,
    max_tokens: 1000,
    top_p: 0.9
  }, {
    'Authorization': `Bearer ${OPENAI_KEY}`
  })

  const imagePrompt = openaiRes.choices?.[0]?.message?.content?.trim().replace(/^["']|["']$/g, '').trim()
  if (!imagePrompt) {
    console.error('OpenAI prompt generation failed:', JSON.stringify(openaiRes).substring(0, 400))
    process.exit(1)
  }
  console.log('Generated prompt:', imagePrompt.substring(0, 200) + '...')

  // Step 2: /api/image/generate API 호출 (promptOverride로 전달)
  console.log('\n[2/4] Submitting to /api/image/generate...')
  const generateRes = await post('careerwiki.org', '/api/image/generate', {
    type: 'jobs',
    slug,
    promptOverride: imagePrompt
  }, {
    'X-Admin-Secret': ADMIN_SECRET
  })

  console.log('Generate response:', JSON.stringify(generateRes))
  if (!generateRes.success || !generateRes.taskId) {
    console.error('Image generation request failed')
    process.exit(1)
  }
  const taskId = generateRes.taskId
  console.log('Task ID:', taskId)

  // Step 3: 완료될 때까지 상태 폴링
  console.log('\n[3/4] Polling for completion...')
  let imageUrl = null
  let attempts = 0
  while (attempts < 30) {
    await new Promise(r => setTimeout(r, 3000))
    attempts++

    const statusRes = await get('careerwiki.org', `/api/image/status/${taskId}`, {
      'X-Admin-Secret': ADMIN_SECRET
    })
    console.log(`  Attempt ${attempts}: status=${statusRes.status}, imageUrl=${statusRes.imageUrl ? statusRes.imageUrl.substring(0, 80) : 'null'}`)

    if (statusRes.status === 'completed' && statusRes.imageUrl) {
      imageUrl = statusRes.imageUrl
      break
    }
    if (statusRes.status === 'failed') {
      console.error('Image generation failed')
      process.exit(1)
    }
  }

  if (!imageUrl) {
    console.error('Timed out waiting for image')
    process.exit(1)
  }

  // Step 4: 이미지 저장
  console.log('\n[4/4] Saving image via /api/image/save...')
  const saveRes = await post('careerwiki.org', '/api/image/save', {
    taskId,
    type: 'jobs',
    slug,
    imageUrl
  }, {
    'X-Admin-Secret': ADMIN_SECRET
  })

  console.log('Save response:', JSON.stringify(saveRes))
  if (saveRes.success) {
    console.log('\n✅ Image regeneration complete!')
    console.log('New image URL:', saveRes.imageUrl)
  } else {
    console.error('Image save failed:', saveRes.error)
    process.exit(1)
  }
}

main().catch(console.error)
