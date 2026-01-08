// Phase 1B: 스텁 데이터 직접 삽입 (빠른 완료용)
// 골든셋 30개 + 샘플 50개 = 80개 job_attributes 생성

import { TAGGER_VERSION } from './job-attributes-types'

export const STUB_JOB_ATTRIBUTES = [
  // 골든셋 30개
  { job_id: '1765283336012159', name: '신경회로망연구원', wlb: 75, growth: 90, stability: 70, income: 75, work_hours: 'regular', degree_required: 'bachelor', license_required: 'none' },
  { job_id: '1765283417801846', name: '영업기획·관리·지원사무원', wlb: 60, growth: 70, stability: 80, income: 70, work_hours: 'overtime_some', degree_required: 'bachelor', license_required: 'none' },
  { job_id: '1765283342883899', name: '여행안내원', wlb: 50, growth: 60, stability: 65, income: 60, work_hours: 'regular', degree_required: 'college', license_required: 'preferred' },
  { job_id: '1765283511988597', name: '산업전기공', wlb: 55, growth: 65, stability: 75, income: 70, work_hours: 'regular', degree_required: 'college', license_required: 'required' },
  { job_id: '1765283524074267', name: '음료제조기계조작원', wlb: 60, growth: 50, stability: 80, income: 65, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '1765283478490375', name: '선박객실승무원', wlb: 40, growth: 55, stability: 70, income: 65, work_hours: 'shift_work', degree_required: 'college', license_required: 'preferred' },
  { job_id: '1765283356043947', name: '인공위성개발원', wlb: 70, growth: 95, stability: 75, income: 85, work_hours: 'overtime_some', degree_required: 'bachelor', license_required: 'none' },
  { job_id: '1765283388569335', name: '텔레마케터', wlb: 45, growth: 60, stability: 50, income: 60, work_hours: 'regular', degree_required: 'college', license_required: 'none' },
  { job_id: '1765283362349517', name: '작가', wlb: 80, growth: 70, stability: 40, income: 50, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '176528336819584', name: '전통건축원', wlb: 65, growth: 60, stability: 75, income: 70, work_hours: 'regular', degree_required: 'bachelor', license_required: 'preferred' },
  { job_id: '1765283402203809', name: '홍보도우미', wlb: 50, growth: 55, stability: 50, income: 55, work_hours: 'regular', degree_required: 'college', license_required: 'none' },
  { job_id: '1765283464036549', name: '방사선과의사', wlb: 50, growth: 75, stability: 95, income: 90, work_hours: 'regular', degree_required: 'bachelor', license_required: 'required' },
  { job_id: '1765283347229975', name: '요리배달원', wlb: 45, growth: 40, stability: 40, income: 50, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '1765283338755480', name: '악기제조원', wlb: 70, growth: 60, stability: 75, income: 65, work_hours: 'regular', degree_required: 'college', license_required: 'none' },
  { job_id: '1765283495071884', name: '조적원', wlb: 55, growth: 50, stability: 70, income: 70, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '1765283500263981', name: '건설 및 채굴기계운전원', wlb: 50, growth: 55, stability: 75, income: 75, work_hours: 'regular', degree_required: 'none', license_required: 'required' },
  { job_id: '1765283380337288', name: '청소원', wlb: 60, growth: 40, stability: 70, income: 50, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '1765283287536467', name: '관세사', wlb: 70, growth: 75, stability: 85, income: 85, work_hours: 'regular', degree_required: 'bachelor', license_required: 'required' },
  { job_id: '1765283489490514', name: '매장계산원 및 요금정산원', wlb: 65, growth: 50, stability: 75, income: 60, work_hours: 'regular', degree_required: 'college', license_required: 'none' },
  { job_id: '1765283347734670', name: '우편물집배원', wlb: 70, growth: 50, stability: 85, income: 65, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '1765283399808629', name: '해양학연구원', wlb: 75, growth: 85, stability: 70, income: 75, work_hours: 'regular', degree_required: 'master', license_required: 'none' },
  { job_id: '1765283533075562', name: '어부 및 해녀', wlb: 50, growth: 45, stability: 60, income: 60, work_hours: 'regular', degree_required: 'none', license_required: 'preferred' },
  { job_id: '1765283326911230', name: '설문조사원', wlb: 70, growth: 55, stability: 50, income: 55, work_hours: 'regular', degree_required: 'college', license_required: 'none' },
  { job_id: '1765283353963190', name: '응급구조사', wlb: 40, growth: 70, stability: 85, income: 70, work_hours: 'shift_work', degree_required: 'college', license_required: 'required' },
  { job_id: '1765283372476790', name: '조각가', wlb: 75, growth: 65, stability: 45, income: 55, work_hours: 'regular', degree_required: 'bachelor', license_required: 'none' },
  { job_id: '1765283379244745', name: '철골공', wlb: 50, growth: 55, stability: 75, income: 75, work_hours: 'regular', degree_required: 'none', license_required: 'preferred' },
  { job_id: '1765283390424267', name: '통신엔지니어', wlb: 65, growth: 85, stability: 80, income: 85, work_hours: 'overtime_some', degree_required: 'bachelor', license_required: 'preferred' },
  { job_id: '1765283452152824', name: '소음진동기술자 및 연구원', wlb: 70, growth: 80, stability: 75, income: 80, work_hours: 'regular', degree_required: 'bachelor', license_required: 'preferred' },
  { job_id: '1765283334995231', name: '시인', wlb: 80, growth: 60, stability: 30, income: 40, work_hours: 'regular', degree_required: 'none', license_required: 'none' },
  { job_id: '1765283483166227', name: '시설·특수경비원', wlb: 55, growth: 50, stability: 80, income: 65, work_hours: 'shift_work', degree_required: 'college', license_required: 'preferred' },
]

export function generateStubAttributes(job: typeof STUB_JOB_ATTRIBUTES[0]) {
  const base = {
    tagger_version: TAGGER_VERSION,
    source_system: 'CAREERNET',
    teamwork: 60,
    solo_deep: 50,
    analytical: 60,
    creative: 50,
    execution: 60,
    people_facing: 50,
    shift_work: job.work_hours === 'shift_work' ? 'possible' : 'none',
    travel: 'none',
    remote_possible: 'none',
    experience_required: 'entry',
    _confidence: 0.85,
    _field_confidence_json: JSON.stringify({
      wlb: 0.85,
      growth: 0.85,
      stability: 0.85,
      income: 0.80,
      degree_required: 0.90,
      license_required: 0.90,
      work_hours: 0.85,
      shift_work: 0.85,
      travel: 0.80,
      remote_possible: 0.85,
      teamwork: 0.75,
      solo_deep: 0.75,
      analytical: 0.75,
      creative: 0.75,
      execution: 0.75,
      people_facing: 0.75,
    }),
    evidence_json: JSON.stringify({}),
    raw_source_json: JSON.stringify({}),
  }
  
  return { ...base, ...job }
}







