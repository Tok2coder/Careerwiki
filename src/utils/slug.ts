const SLUG_INVALID_REGEX = /[^0-9a-z\u3131-\u314e\u314f-\u3163가-힣-]+/gi
const HANGUL_SEPARATOR_REGEX = /[·•]/g
const SLUG_MAX_LENGTH = 140

const truncateSlug = (value: string): string => {
  if (value.length <= SLUG_MAX_LENGTH) {
    return value
  }
  return value.slice(0, SLUG_MAX_LENGTH).replace(/-+$/g, '')
}

const slugifyName = (value?: string | null): string => {
  if (!value) return ''
  const normalized = typeof value.normalize === 'function' ? value.normalize('NFKC') : value
  const slug = normalized
    .replace(HANGUL_SEPARATOR_REGEX, '-')
    .trim()
    .toLowerCase()
    .replace(/\s+/g, '-')
    .replace(SLUG_INVALID_REGEX, '-')
    .replace(/-+/g, '-')
    .replace(/^-+|-+$/g, '')

  return truncateSlug(slug)
}

const joinSlugParts = (primary?: string | null, secondary?: string | null): string => {
  const safePrimary = primary ? primary.trim() : ''
  const safeSecondary = secondary ? secondary.trim() : ''
  const combined = safePrimary && safeSecondary ? `${safePrimary}--${safeSecondary}` : safePrimary || safeSecondary
  return truncateSlug(combined)
}

const encodeLegacyIdSegment = (type: 'job' | 'major' | 'guide', id: string): string | null => {
  if (type === 'guide') {
    return null
  }
  const regex = type === 'job' ? /^job:([a-z])_(\d+)$/i : /^major:([a-z])_(\d+)$/i
  const match = id.match(regex)
  if (!match) {
    return null
  }
  const prefix = match[1].toLowerCase()
  const digits = match[2]
  return `${type}-${prefix}-${digits}`
}

const decodeLegacyIdSegment = (type: 'job' | 'major' | 'guide', slug: string): string | null => {
  if (type === 'guide') {
    return null
  }
  const regex = type === 'job' ? /(?:^|-)job-([a-z])-(\d+)$/i : /(?:^|-)major-([a-z])-(\d+)$/i
  const match = slug.match(regex)
  if (!match) {
    return null
  }
  const prefix = match[1].toUpperCase()
  const digits = match[2]
  return `${type}:${prefix}_${digits}`
}

const normalizeIdSlug = (id: string): string => {
  const direct = slugifyName(id)
  if (direct) {
    return direct
  }
  const fallback = (typeof id.normalize === 'function' ? id.normalize('NFKC') : id)
    .replace(HANGUL_SEPARATOR_REGEX, '-')
    .replace(SLUG_INVALID_REGEX, '-')
    .replace(/-+/g, '-')
    .replace(/^-+|-+$/g, '')
  return truncateSlug(fallback)
}

export const composeDetailSlug = (type: 'job' | 'major', name: string | undefined, id: string): string => {
  const legacySegment = encodeLegacyIdSegment(type, id)
  const nameSlug = slugifyName(name)

  // 이름이 있으면 항상 이름을 슬러그로 사용 (한국어 우선)
  if (nameSlug) {
    return nameSlug
  }

  // 이름이 없을 경우에만 ID 사용
  if (!id) {
    return 'unknown'
  }

  if (!id.includes(':')) {
    const idSlug = slugifyName(id)
    return idSlug || id
  }

  if (legacySegment) {
    return legacySegment
  }

  return normalizeIdSlug(id)
}

export const resolveDetailIdFromSlug = (type: 'job' | 'major', slug: string): string => {
  if (!slug) return slug
  if (slug.includes(':')) {
    return slug
  }

  const decodedFull = decodeLegacyIdSegment(type, slug)
  if (decodedFull) {
    return decodedFull
  }

  const doubleDashIndex = slug.lastIndexOf('--')
  if (doubleDashIndex !== -1) {
    const candidate = slug.slice(doubleDashIndex + 2)
    if (candidate) {
      const decodedCandidate = decodeLegacyIdSegment(type, candidate)
      return decodedCandidate ?? candidate
    }
  }

  if (/[^0-9a-z\u3131-\u314e\u314f-\u3163가-힣-]/i.test(slug)) {
    const suffixMatch = slug.match(/([0-9a-z\u3131-\u314e\u314f-\u3163가-힣-]+)$/i)
    if (suffixMatch && suffixMatch[1]) {
      const candidate = suffixMatch[1]
      const decodedCandidate = decodeLegacyIdSegment(type, candidate)
      return decodedCandidate ?? candidate
    }
  }

  return slug
}

export const ensureUniqueSlug = (baseSlug: string, existing: Set<string>): string => {
  const normalizedBase = baseSlug ? truncateSlug(baseSlug) : ''
  if (!normalizedBase) {
    throw new Error('BASE_SLUG_REQUIRED')
  }

  if (!existing.has(normalizedBase)) {
    existing.add(normalizedBase)
    return normalizedBase
  }

  let counter = 2
  while (counter < 1_000) {
    const candidate = truncateSlug(`${normalizedBase}-${counter}`)
    if (!existing.has(candidate)) {
      existing.add(candidate)
      return candidate
    }
    counter += 1
  }

  throw new Error('SLUG_CONFLICT_UNRESOLVED')
}
