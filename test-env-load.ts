import { readFileSync } from 'fs'
import { resolve } from 'path'

console.log('📂 Current directory:', process.cwd())

const envPath = resolve(process.cwd(), '.dev.vars')
console.log('📄 .dev.vars path:', envPath)

try {
  const envContent = readFileSync(envPath, 'utf-8')
  console.log('\n✅ File loaded successfully')
  
  // Parse .dev.vars file
  envContent.split('\n').forEach(line => {
    const trimmed = line.trim()
    if (trimmed && !trimmed.startsWith('#')) {
      const [key, ...valueParts] = trimmed.split('=')
      if (key && valueParts.length > 0) {
        const value = valueParts.join('=').trim()
        process.env[key.trim()] = value
        console.log(`  ✓ ${key.trim()} = ${value.substring(0, 20)}...`)
      }
    }
  })
  
  console.log('\n🔑 Environment variables after loading:')
  console.log('  CAREER_NET_API_KEY:', process.env.CAREER_NET_API_KEY)
  console.log('  GOYONG24_MAJOR_API_KEY:', process.env.GOYONG24_MAJOR_API_KEY)
  
} catch (e) {
  console.error('❌ Failed to load .dev.vars:', e)
}
