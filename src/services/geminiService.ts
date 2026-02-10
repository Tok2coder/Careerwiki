/**
 * Google Gemini API를 통한 이미지 프롬프트 생성 서비스
 * 직업/전공명을 입력받아 비버 캐릭터 스타일의 이미지 프롬프트를 생성
 */

const GEMINI_API_BASE = 'https://generativelanguage.googleapis.com/v1beta/models'
const MODEL = 'gemini-2.0-flash'

// 직업용 프롬프트 템플릿
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

// 전공용 프롬프트 템플릿
const MAJOR_PROMPT_TEMPLATE = `You will create ONE paragraph describing an image prompt based on the academic major "{majorName}".
Follow all rules silently. Do NOT output meta-text, lists, or examples.

RULES (DO NOT OUTPUT THESE):

1) FIXED CHARACTER STYLE  
Always describe the beaver exactly as:
"a small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style."
The style must never shift to realism, chibi, furry-detail, or alternative aesthetics.

2) ACADEMIC ACTION (MANDATORY)  
The beaver must be shown performing ONE clear, physical, academic or research-related action appropriate for "{majorName}".
The action must involve direct, visible interaction with academic materials, research tools, laboratory equipment, instruments, diagrams, specimens, models, or creative artifacts genuinely used in this field.
The action must be concrete and visually explicit (e.g., assembling a model, adjusting instruments, examining samples, sketching diagrams, configuring simulations, mixing substances).
Do NOT use abstract actions such as "studying," "learning," "researching," or "analyzing" without a physical interaction.

3) ACADEMIC TOOLS & ATTIRE  
If the major typically involves specific research attire, protective gear, or academic equipment (e.g., lab coats, safety goggles, field gear, headsets), the beaver may be wearing or using a simplified version of that equipment as part of the action.
Avoid generic clothing descriptions unless they are characteristic of the field.

4) ACADEMIC ENVIRONMENT  
Describe a wide, detailed learning or research environment unmistakably associated with "{majorName}".
Include specific academic tools, instruments, materials, devices, models, or spatial elements unique to the field.
Avoid generic phrases such as "academic workspace," "related tools," or "appropriate equipment."

5) CHARACTER SIZE  
The beaver should appear small and natural within the scene, occupying approximately **12% of the frame**, allowing the academic environment and context to visually dominate.

6) VISUAL STYLE & LIGHTING  
2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, and cinematic rim light.
Dark-mode palette: deep navy, muted violet, soft teal glow accents.
The background should be rich and detailed but not overpower the character.

7) PROHIBITED  
No text, labels, signage, numbers, lists, meta commentary, logos, or photorealistic humans or animals.

OUTPUT  
Produce ONE concise paragraph (<2000 characters) describing the final scene.
Do NOT mention rules or provide explanations.`

export interface GeminiResponse {
  success: boolean
  prompt?: string
  error?: string
}

/**
 * Gemini API로 텍스트 생성 요청
 */
async function callGeminiAPI(
  apiKey: string,
  systemPrompt: string
): Promise<GeminiResponse> {
  try {
    const response = await fetch(
      `${GEMINI_API_BASE}/${MODEL}:generateContent?key=${apiKey}`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          contents: [{
            parts: [{ text: systemPrompt }]
          }],
          generationConfig: {
            temperature: 0.7,
            maxOutputTokens: 1000,
            topP: 0.9
          }
        })
      }
    )

    if (!response.ok) {
      const errorText = await response.text()
      console.error('[Gemini] API Error:', response.status, errorText)
      return {
        success: false,
        error: `Gemini API 오류: HTTP ${response.status}`
      }
    }

    const data = await response.json() as {
      candidates?: Array<{
        content?: {
          parts?: Array<{ text?: string }>
        }
      }>
      error?: { message?: string }
    }

    // 응답에서 텍스트 추출
    const generatedText = data.candidates?.[0]?.content?.parts?.[0]?.text

    if (!generatedText) {
      console.error('[Gemini] No text in response:', JSON.stringify(data))
      return {
        success: false,
        error: '프롬프트 생성 결과가 비어있습니다'
      }
    }

    // 프롬프트 정리 (앞뒤 공백, 불필요한 따옴표 제거)
    const cleanedPrompt = generatedText
      .trim()
      .replace(/^["']|["']$/g, '')
      .trim()

    console.log('[Gemini] Generated prompt:', cleanedPrompt.substring(0, 100) + '...')

    return {
      success: true,
      prompt: cleanedPrompt
    }
  } catch (error) {
    console.error('[Gemini] Request failed:', error)
    return {
      success: false,
      error: error instanceof Error ? error.message : '알 수 없는 오류'
    }
  }
}

/**
 * 직업명으로 이미지 프롬프트 생성
 * @param apiKey - Gemini API 키
 * @param jobName - 직업명 (한국어)
 * @returns 생성된 이미지 프롬프트
 */
export async function generateJobImagePrompt(
  apiKey: string,
  jobName: string
): Promise<GeminiResponse> {
  const systemPrompt = JOB_PROMPT_TEMPLATE.replace(/\{jobName\}/g, jobName)
  return callGeminiAPI(apiKey, systemPrompt)
}

/**
 * 전공명으로 이미지 프롬프트 생성
 * @param apiKey - Gemini API 키
 * @param majorName - 전공명 (한국어)
 * @returns 생성된 이미지 프롬프트
 */
export async function generateMajorImagePrompt(
  apiKey: string,
  majorName: string
): Promise<GeminiResponse> {
  const systemPrompt = MAJOR_PROMPT_TEMPLATE.replace(/\{majorName\}/g, majorName)
  return callGeminiAPI(apiKey, systemPrompt)
}











