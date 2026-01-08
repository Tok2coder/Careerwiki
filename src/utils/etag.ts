import { createHash } from 'crypto'

export const toNFC = (s: string | null | undefined) => (s ? s.normalize('NFC') : '')

export const weakETag = (seed: string) => {
  const hash = createHash('sha1').update(toNFC(seed)).digest('hex')
  return `W/"${hash}"`
}

export const matchETag = (incoming: string | null | undefined, etag: string) => {
  if (!incoming) return false
  const clean = (v: string) => v.trim().replace(/^W\//i, '').replace(/^"|"$/g, '')
  const target = clean(etag)
  return incoming
    .split(',')
    .map(clean)
    .includes(target)
}

