import { readFileSync } from 'fs'
import { resolve } from 'path'
import { searchMajors } from './src/api/careernetAPI'

// Load .dev.vars
const envPath = resolve(process.cwd(), '.dev.vars')
const envContent = readFileSync(envPath, 'utf-8')
envContent.split('\n').forEach(line => {
  const trimmed = line.trim()
  if (trimmed && !trimmed.startsWith('#')) {
    const [key, ...valueParts] = trimmed.split('=')
    if (key && valueParts.length > 0) {
      process.env[key.trim()] = valueParts.join('=').trim()
    }
  }
})

const env = {
  CAREER_NET_API_KEY: process.env.CAREER_NET_API_KEY
}

console.log('🔑 API Key:', env.CAREER_NET_API_KEY?.substring(0, 20) + '...')
console.log('\n📡 Calling searchMajors with env object...')

searchMajors({ thisPage: 1, perPage: 10 }, env)
  .then(majors => {
    console.log('\n✅ Success!')
    console.log('Number of majors:', majors.length)
    if (majors.length > 0) {
      console.log('\nFirst major:')
      console.log('  majorSeq:', majors[0].majorSeq)
      console.log('  major:', majors[0].major)
      console.log('  department:', majors[0].department)
    }
  })
  .catch(error => {
    console.error('\n❌ Error:', error.message)
  })
