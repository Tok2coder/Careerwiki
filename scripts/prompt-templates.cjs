/**
 * 이미지 프롬프트 템플릿 모듈
 * 직업/전공/HowTo별 개선된 프롬프트 생성
 *
 * 테마 색상:
 *   직업: deep indigo (#4F46E5) / blue-violet (#6366F1)
 *   전공: deep emerald (#10B981) / soft green (#34D399)
 *   HowTo: deep violet (#8B5CF6) / lavender (#A78BFA)
 */

const THEME_COLORS = {
  job: {
    primary: 'deep indigo',
    secondary: 'muted blue-violet',
    glow: 'soft blue glow accents',
    palette: 'deep indigo (#4F46E5), muted blue-violet (#6366F1), dark navy background (#0a0f1e)',
  },
  major: {
    primary: 'deep emerald',
    secondary: 'soft green',
    glow: 'warm jade glow accents',
    palette: 'deep emerald (#10B981), soft green (#34D399), dark navy background (#0a0f1e)',
  },
  howto: {
    primary: 'deep violet',
    secondary: 'soft lavender',
    glow: 'purple haze glow accents',
    palette: 'deep violet (#8B5CF6), soft lavender (#A78BFA), dark navy background (#0a0f1e)',
  },
};

// 비버 캐릭터 설명 (LoRA 트리거 포함 옵션)
function getBeaverDescription(useLora = false) {
  const trigger = useLora ? 'cwbeaver, ' : '';
  return `${trigger}a small cute baby beaver with tiny teeth, big round glossy eyes, soft rounded cheeks, short limbs, light-brown fluffy fur and a creamy belly, drawn in simple 2D cartoon style`;
}

/**
 * 직업용 프롬프트 템플릿
 * @param {string} jobName - 직업명 (한국어)
 * @param {object} options - { useLora: boolean }
 * @returns {string} 시스템 프롬프트
 */
function getJobPromptTemplate(jobName, options = {}) {
  const { useLora = false } = options;
  const beaver = getBeaverDescription(useLora);
  const theme = THEME_COLORS.job;

  return `You will create ONE paragraph describing an image prompt based on the job "${jobName}".
Follow all rules silently. Do NOT output lists, examples, or meta-text.

RULES (DO NOT OUTPUT THESE):

1) FIXED CHARACTER STYLE
Always describe the beaver exactly as:
"${beaver}."
The style must never shift to realism, chibi, furry-detail, or alternative aesthetics.

2) JOB-SPECIFIC ACTION (MANDATORY)
The beaver must be shown performing ONE clear, physical, job-specific action appropriate for "${jobName}".
The action must involve direct, visible interaction with professional tools, devices, machinery, or materials that are genuinely used in this job.
Describe the exact tool being held or operated and the specific motion being performed.
Use precise action verbs such as: tightening a bolt with a torque wrench, soldering a circuit board with a fine-tip iron, adjusting a microscope focus knob, pouring molten metal into a mold, kneading bread dough on a floured surface, suturing a wound with needle and thread.
Do NOT use abstract actions such as "performing duties," "consulting," "analyzing," or "overseeing."

3) PROFESSIONAL EQUIPMENT & UNIFORM
If the job normally requires a uniform, protective gear, or standard professional attire, the beaver must be wearing an appropriate simplified version.
Describe specific garment names and colors (e.g., "a white lab coat with blue nitrile gloves" not "appropriate attire"; "a bright orange hard hat and reflective safety vest" not "protective gear").
If the job requires specialized equipment, the beaver must be clearly wearing or using it as part of the action.

4) JOB-SPECIFIC ENVIRONMENT
Describe a wide, detailed workplace that is unmistakably associated with "${jobName}".
Include at least 3 specific, named objects, machines, instruments, or architectural features found in this workplace.
Use real-world terminology (e.g., "an autoclave sterilizer beside a stainless-steel instrument tray" not "medical equipment"; "a CNC milling machine with aluminum shavings on the worktable" not "factory tools").
The environment should tell the viewer exactly what job this is, even without the beaver character.

5) CHARACTER POSITIONING
The beaver should be centered in the middle third of the composition, occupying approximately 12% of the frame.
This ensures the character is clearly visible at any screen size including mobile devices, while the environment dominates visually.

6) VISUAL STYLE
2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, and cinematic rim light.
Color palette: ${theme.palette}, with ${theme.glow}.
The background should be rich and detailed but never overpower the character.

7) PROHIBITED
No text, labels, signage, numbers, lists, meta commentary, logos, or photorealistic humans or animals.

OUTPUT
Produce ONE concise paragraph (<2000 characters) describing the final scene.
Do NOT mention rules or provide explanations.`;
}

/**
 * 전공용 프롬프트 템플릿
 * @param {string} majorName - 전공명 (한국어)
 * @param {object} options - { useLora: boolean }
 * @returns {string} 시스템 프롬프트
 */
function getMajorPromptTemplate(majorName, options = {}) {
  const { useLora = false } = options;
  const beaver = getBeaverDescription(useLora);
  const theme = THEME_COLORS.major;

  return `You will create ONE paragraph describing an image prompt based on the academic major "${majorName}".
Follow all rules silently. Do NOT output meta-text, lists, or examples.

RULES (DO NOT OUTPUT THESE):

1) FIXED CHARACTER STYLE
Always describe the beaver exactly as:
"${beaver}."
The style must never shift to realism, chibi, furry-detail, or alternative aesthetics.

2) FIELD-SPECIFIC ACTION (MANDATORY)
The beaver must be shown performing ONE clear, physical action that represents what someone in the field of "${majorName}" does.
This could be academic research, field work, creative practice, clinical practice, or professional application — whatever best represents the field.
The action must involve direct, visible interaction with tools, instruments, materials, specimens, models, devices, or creative artifacts genuinely used in this field.
Describe the exact object being manipulated and the specific motion (e.g., "pipetting a blue reagent into a glass Erlenmeyer flask" not "conducting research"; "sculpting wet clay on a pottery wheel" not "creating art").
Do NOT use abstract actions such as "studying," "learning," or "analyzing" without a visible physical interaction.
Prefer real, tangible objects over symbolic visuals. Avoid floating charts, generic holograms, miniature infographic props, or abstract business iconography unless the field truly centers on those exact artifacts.
For broad social-science or business-related majors, choose a concrete operational or training task with physical materials, devices, paperwork, merchandise, instruments, or workspace tools rather than a generic executive meeting tableau.

3) FIELD-APPROPRIATE ATTIRE & TOOLS
If the field typically involves specific attire or protective gear (e.g., lab coat and safety goggles, field vest and binoculars, paint-stained apron), the beaver may be wearing a simplified version.
Describe specific items by name and appearance rather than generic terms.

4) FIELD-SPECIFIC ENVIRONMENT
Describe a wide, detailed scene that represents the world of "${majorName}".
This could be a laboratory, studio, field site, clinic, workshop, courtroom, stage, observatory, or any environment where this field's knowledge is applied.
Include at least 3 specific, named objects or features unique to the field using real-world terminology (e.g., "a fume hood with glass sash raised, Bunsen burner with blue flame, and rack of test tubes" not "science equipment").
Choose a plausible real-world setting where the field is practiced or trained, not a generic presentation room. If the major is broad, prefer a concrete lab, studio, clinic, workshop, campus facility, or operational workplace with tangible equipment and materials.
Avoid defaulting to a luxury boardroom, keynote stage, or abstract strategy scene unless that environment is truly indispensable to the field.
The scene should tell the viewer exactly what field this is, even without the beaver character.

5) CHARACTER POSITIONING
The beaver should be centered in the middle third of the composition, occupying approximately 12% of the frame.
This ensures the character is clearly visible at any screen size including mobile devices, while the environment dominates visually.

6) VISUAL STYLE & LIGHTING
2D stylized realism with soft painterly shading, gentle gradients, atmospheric haze, and cinematic rim light.
Color palette: ${theme.palette}, with ${theme.glow}.
The background should be rich and detailed but not overpower the character.

7) PROHIBITED
No text, labels, signage, numbers, lists, meta commentary, logos, or photorealistic humans or animals.

OUTPUT
Produce ONE concise paragraph (<2000 characters) describing the final scene.
Do NOT mention rules or provide explanations.`;
}

module.exports = {
  THEME_COLORS,
  getBeaverDescription,
  getJobPromptTemplate,
  getMajorPromptTemplate,
};
