import { getMajorDetail } from './src/api/careernetAPI'

async function check() {
  const raw = await getMajorDetail('463') // 전기전자공학과
  console.log('universityList 존재?', !!raw?.universityList)
  console.log('university 존재?', !!raw?.university)
  if (raw?.university) {
    console.log('university 타입:', Array.isArray(raw.university) ? '배열' : typeof raw.university)
    if (Array.isArray(raw.university)) {
      console.log('university 길이:', raw.university.length)
    }
  }
  if (raw?.universityList) {
    console.log('universityList 길이:', raw.universityList.length)
  }
}

check()
