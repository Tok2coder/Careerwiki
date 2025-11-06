import * as dotenv from 'dotenv'
import * as path from 'path'

const envPath = path.resolve(process.cwd(), '.dev.vars')
const result = dotenv.config({ path: envPath })

if (result.error) {
  console.error('❌ Failed to load .dev.vars:', result.error)
  process.exit(1)
}

const apiKey = process.env.CAREERNET_API_KEY
console.log('🔑 API Key loaded:', apiKey ? `${apiKey.substring(0, 10)}...` : 'NOT FOUND')

const url = new URL('https://www.career.go.kr/cnet/openapi/getOpenApi')
url.searchParams.append('apiKey', apiKey!)
url.searchParams.append('svcType', 'api')
url.searchParams.append('svcCode', 'MAJOR')
url.searchParams.append('contentType', 'xml')
url.searchParams.append('gubun', 'univ_list')
url.searchParams.append('thisPage', '1')
url.searchParams.append('perPage', '10')

console.log('\n📡 Testing API request...')
console.log('URL:', url.toString().replace(apiKey!, 'API_KEY_HIDDEN'))

fetch(url.toString())
  .then(async response => {
    console.log('\n📊 Response status:', response.status, response.statusText)
    console.log('Content-Type:', response.headers.get('content-type'))
    
    if (!response.ok) {
      const errorText = await response.text()
      console.log('\n❌ Error response body:')
      console.log(errorText.substring(0, 500))
      return
    }
    
    const xmlData = await response.text()
    console.log('\n✅ Success! Response length:', xmlData.length)
    console.log('\nFirst 500 characters:')
    console.log(xmlData.substring(0, 500))
  })
  .catch(error => {
    console.error('\n❌ Fetch error:', error)
  })
