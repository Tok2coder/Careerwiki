import { readFileSync } from 'fs'
import { resolve } from 'path'

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

console.log('🔑 API Key loaded:', process.env.CAREER_NET_API_KEY?.substring(0, 20) + '...')

const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
url.searchParams.append('apiKey', process.env.CAREER_NET_API_KEY!)
url.searchParams.append('svcType', 'api')
url.searchParams.append('svcCode', 'MAJOR')
url.searchParams.append('contentType', 'xml')
url.searchParams.append('gubun', 'univ_list')
url.searchParams.append('thisPage', '1')
url.searchParams.append('perPage', '10')

console.log('\n📡 Testing API request...')

fetch(url.toString())
  .then(async response => {
    console.log('\n📊 Response status:', response.status, response.statusText)
    
    if (!response.ok) {
      const errorText = await response.text()
      console.log('❌ Error response:', errorText.substring(0, 200))
      return
    }
    
    const xmlData = await response.text()
    console.log('✅ Success! Response length:', xmlData.length)
    console.log('\nFirst 800 characters:')
    console.log(xmlData.substring(0, 800))
    
    // Count number of <seq> tags
    const seqMatches = xmlData.match(/<seq>/g)
    console.log('\n📊 Number of majors found:', seqMatches ? seqMatches.length : 0)
  })
  .catch(error => {
    console.error('❌ Fetch error:', error)
  })
