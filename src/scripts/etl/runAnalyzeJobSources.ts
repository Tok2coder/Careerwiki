/**
 * Run analyzeJobSources script locally
 */

import { getLocalD1Database } from '../../utils/localD1'
import { analyzeJobSources } from './analyzeJobSources'

async function main() {
  const db = getLocalD1Database()
  await analyzeJobSources(db)
}

main().catch((error) => {
  console.error('Error:', error)
  process.exit(1)
})






