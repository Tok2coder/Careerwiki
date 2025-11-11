import type { D1Database } from '@cloudflare/workers-types'
import { readFileSync } from 'fs'
import { resolve } from 'path'
import { Miniflare } from 'miniflare'

async function main() {
  const env: Record<string, string> = {}
  const devVars = resolve(process.cwd(), '.dev.vars')
  try {
    const content = readFileSync(devVars, 'utf-8')
    content.split('\n').forEach((line) => {
      const trimmed = line.trim()
      if (!trimmed || trimmed.startsWith('#')) return
      const [key, ...valueParts] = trimmed.split('=')
      if (!key || valueParts.length === 0) return
      env[key.trim()] = valueParts.join('=').trim()
    })
  } catch {}

  const mf = new Miniflare({
    modules: true,
    script: '',
    d1Databases: {
      DB: 'edc21e23-c2ac-4693-bb79-389b6914e173'
    },
    d1Persist: './.wrangler/state/v3/d1'
  })

  const db = (await mf.getD1Database('DB')) as unknown as D1Database

  const rows = await db.prepare(
    `SELECT id, name, careernet_id, goyong24_id FROM jobs WHERE name LIKE ? ORDER BY id`
  ).bind('%기업고위임원%').all<any>()

  console.log(`Found ${rows.results?.length || 0} rows`)
  for (const row of rows.results || []) {
    console.log(JSON.stringify(row))
  }
}

main().catch(console.error)
