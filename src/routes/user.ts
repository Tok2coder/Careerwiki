import { Hono } from 'hono'
import type { AppEnv } from '../types/app'
import { requireAuth } from '../middleware/auth'
import {
  renderUserMenu, renderLayoutWithContext, escapeHtml,
  getOptionalUser, formatDateSafe, parseNumberParam
} from '../utils/shared-helpers'
import { renderUserLayoutContent } from '../templates/user/userLayout'
import { renderUserAiResultsContent, type AiResultItem } from '../templates/user/userAiResults'
import { renderSecurityPage } from '../templates/user/userSecurity'
import {
  listUserSessions, destroySession,
  destroyAllUserSessions, getUserSessionEntries
} from '../utils/session'

export const userRoutes = new Hono<AppEnv>()

// 내 작성 가이드 목록 페이지 (새 URL)
userRoutes.get('/user/drafts', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/user/drafts')
  }
  
  const filter = c.req.query('filter') || 'all'
  
  // 내 가이드 조회 (draft_published + published)
  const allGuidesResult = await c.env.DB.prepare(`
    SELECT id, slug, title, summary, status, created_at, updated_at
    FROM pages 
    WHERE page_type = 'guide' AND author_id = ? AND status IN ('published', 'draft_published')
    ORDER BY created_at DESC
  `).bind(user.id).all()
  const allGuides = allGuidesResult.results || []
  const draftPublished = allGuides.filter((p: any) => p.status === 'draft_published')
  const published = allGuides.filter((p: any) => p.status === 'published')
  
  // 필터 적용
  const showDraftPublished = filter === 'all' || filter === 'draft_published'
  const showPublished = filter === 'all' || filter === 'published'
  
  const innerContent = `
      <div class="flex items-center justify-between gap-4 mb-6">
        <p class="text-wiki-muted">임시 발행 및 발행한 가이드를 관리합니다</p>
        <a href="/howto/write" class="px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-lg transition flex items-center gap-2 shrink-0 text-sm">
          <i class="fas fa-plus"></i>
          새 가이드 작성
        </a>
      </div>
      
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4">
        <a href="/user/drafts?filter=all" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition ${filter === 'all' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          전체 <span class="ml-1 opacity-70">(${allGuides.length})</span>
        </a>
        <a href="/user/drafts?filter=draft_published" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition ${filter === 'draft_published' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          임시 발행 <span class="ml-1 opacity-70">(${draftPublished.length})</span>
        </a>
        <a href="/user/drafts?filter=published" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition ${filter === 'published' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          발행됨 <span class="ml-1 opacity-70">(${published.length})</span>
        </a>
      </div>
      
        <div class="space-y-4">
        <!-- 임시 발행된 가이드 -->
        ${showDraftPublished && draftPublished.length > 0 ? draftPublished.map((p: any) => `
          <div class="p-4 bg-wiki-card/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
            <div class="flex items-start justify-between gap-4">
              <a href="/howto/${p.slug}" class="flex-1 min-w-0">
                <h3 class="text-lg font-semibold text-white group-hover:text-wiki-primary transition truncate">
                  ${escapeHtml(p.title || '제목 없음')}
                </h3>
                ${p.summary ? `<p class="text-sm text-wiki-muted mt-1 line-clamp-2">${escapeHtml(p.summary)}</p>` : ''}
                <div class="flex items-center gap-3 mt-2 text-xs text-wiki-muted">
                  <span>
                    <i class="far fa-clock mr-1"></i>
                    ${p.created_at ? formatDateSafe(p.created_at) : '날짜 없음'}
                  </span>
                  <span class="px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/30">
                    <i class="fas fa-eye-slash mr-1"></i>임시 발행
                  </span>
                </div>
              </a>
              <div class="flex items-center gap-2">
                <a href="/howto/${p.slug}/edit" class="p-2 text-wiki-muted hover:text-amber-400 transition" title="편집">
                  <i class="fas fa-edit text-sm"></i>
                </a>
                <button type="button" onclick="deletePublished(${p.id}, '${escapeHtml(p.title || '제목 없음').replace(/'/g, "\\'")}', this)" class="p-2 text-wiki-muted hover:text-red-400 transition" title="삭제">
                  <i class="fas fa-trash text-sm"></i>
                </button>
              </div>
            </div>
          </div>
        `).join('') : ''}
        
        <!-- 발행된 가이드 -->
        ${showPublished && published.length > 0 ? published.map((p: any) => `
          <div class="p-4 bg-wiki-card/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
            <div class="flex items-start justify-between gap-4">
              <a href="/howto/${p.slug}" class="flex-1 min-w-0">
                <h3 class="text-lg font-semibold text-white group-hover:text-wiki-primary transition truncate">
                  ${escapeHtml(p.title || '제목 없음')}
                </h3>
                ${p.summary ? `<p class="text-sm text-wiki-muted mt-1 line-clamp-2">${escapeHtml(p.summary)}</p>` : ''}
                <div class="flex items-center gap-3 mt-2 text-xs text-wiki-muted">
                  <span>
                    <i class="far fa-clock mr-1"></i>
                    ${p.created_at ? formatDateSafe(p.created_at) : '날짜 없음'}
                  </span>
                  ${p.status === 'draft_published' ? `
                    <span class="px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/30">
                      <i class="fas fa-eye-slash mr-1"></i>임시 발행
                    </span>
                  ` : `
                    <span class="px-2 py-0.5 rounded-full bg-green-500/10 text-green-400 border border-green-500/30">
                      <i class="fas fa-check-circle mr-1"></i>발행됨
                    </span>
                  `}
                </div>
              </a>
              <div class="flex items-center gap-2">
                <a href="/howto/${p.slug}/edit" class="p-2 text-wiki-muted hover:text-amber-400 transition" title="편집">
                  <i class="fas fa-edit text-sm"></i>
                </a>
                <button type="button" onclick="deletePublished(${p.id}, '${escapeHtml(p.title?.replace(/'/g, "\\'") || '')}', this)" 
                        class="p-2 text-wiki-muted hover:text-red-400 transition" title="삭제">
                  <i class="fas fa-trash text-sm"></i>
                </button>
              </div>
            </div>
          </div>
        `).join('') : ''}
        
        <!-- 빈 상태 -->
        ${allGuides.length === 0 || (filter === 'draft_published' && draftPublished.length === 0) || (filter === 'published' && published.length === 0) ? `
          <div class="text-center py-16">
            <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-card/50 mb-4">
              <i class="fas fa-file-alt text-2xl text-wiki-muted"></i>
            </div>
            <h3 class="text-lg font-semibold text-white mb-2">
              ${filter === 'draft_published' ? '임시 발행된 가이드가 없습니다' : filter === 'published' ? '발행된 가이드가 없습니다' : '아직 작성한 가이드가 없습니다'}
            </h3>
            <p class="text-wiki-muted">위의 "새 가이드 작성" 버튼을 눌러 시작하세요!</p>
          </div>
        ` : ''}
        </div>
        
        <script>
          async function deleteDraft(draftId, title, btn) {
            if (!confirm('정말 "' + title + '" 초안을 삭제하시겠습니까?\\n삭제된 초안은 복구할 수 없습니다.')) {
              return;
            }
            
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin text-sm"></i>';
            
            try {
              const res = await fetch('/api/howto/drafts/' + draftId, {
                method: 'DELETE'
              });
              const data = await res.json();
              
              if (data.success) {
                const card = btn.closest('[data-draft-id]');
                card.style.opacity = '0';
                card.style.transform = 'translateX(-20px)';
                card.style.transition = 'all 0.3s ease';
                setTimeout(() => {
                  card.remove();
                if (!document.querySelector('[data-draft-id]') && !document.querySelector('.space-y-4 > div:not([data-draft-id])')) {
                    location.reload();
                  }
                }, 300);
              } else {
                alert(data.error || '삭제에 실패했습니다.');
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
              }
            } catch (err) {
              alert('네트워크 오류가 발생했습니다.');
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
            }
          }
        
        async function deletePublished(pageId, title, btn) {
          if (!confirm('정말 "' + title + '" 가이드를 삭제하시겠습니까?\\n삭제된 가이드는 복구할 수 없습니다.')) {
            return;
          }
          
          btn.disabled = true;
          btn.innerHTML = '<i class="fas fa-spinner fa-spin text-sm"></i>';
          
          try {
            const res = await fetch('/api/howto/' + pageId, {
              method: 'DELETE'
            });
            const data = await res.json();
            
            if (data.success) {
              const card = btn.closest('.bg-wiki-card\\\\/50');
              if (card) {
                card.style.opacity = '0';
                card.style.transform = 'translateX(-20px)';
                card.style.transition = 'all 0.3s ease';
                setTimeout(() => {
                  card.remove();
                  location.reload();
                }, 300);
              } else {
                location.reload();
              }
            } else {
              alert(data.error || '삭제에 실패했습니다.');
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
            }
          } catch (err) {
            alert('네트워크 오류가 발생했습니다.');
            btn.disabled = false;
            btn.innerHTML = '<i class="fas fa-trash text-sm"></i>';
          }
        }
        </script>
  `
  
  const pageContent = renderUserLayoutContent({
    title: '작성 가이드',
    currentPath: '/user/drafts',
    children: innerContent,
    username: user.username || user.email || `user_${user.id}`,
    pictureUrl: user.custom_picture_url || user.picture_url || null,
    role: user.role
  })
  
  return c.html(
    renderLayoutWithContext(c, pageContent, '작성 가이드 - 마이페이지 - Careerwiki', '내 초안과 가이드를 관리합니다')
  )
})

// 마이페이지 메인 - AI 추천 페이지로 리다이렉트
userRoutes.get('/user', requireAuth, async (c) => {
  return c.redirect('/user/ai-results')
})

// ============================================================================
// 사용자 프로필 - AI 추천 페이지로 리다이렉트
// ============================================================================
userRoutes.get('/user/profile', requireAuth, (c) => {
  return c.redirect('/user/ai-results?tab=profile')
})

// ============================================================================
// 프로필 컨텐츠 HTML 생성 함수
// ============================================================================
function generateProfileContentHtml(): string {
  return `
    <!-- 프로필 요약 헤더 -->
    <div id="profile-summary" class="mb-6">
      <div class="animate-pulse">
        <div class="h-4 bg-wiki-border/30 rounded w-1/3 mb-2"></div>
        <div class="h-3 bg-wiki-border/20 rounded w-1/2"></div>
      </div>
    </div>
    
    <!-- 변경사항 알림 배너 -->
    <div id="changes-banner" class="hidden mb-6 p-4 rounded-xl border border-amber-500/30 bg-amber-500/10">
      <div class="flex items-start gap-3">
        <i class="fas fa-exclamation-circle text-amber-400 mt-0.5"></i>
        <div class="flex-1">
          <h4 class="font-medium text-amber-300 mb-1">프로필 변경 감지</h4>
          <p id="changes-message" class="text-sm text-wiki-muted mb-3"></p>
          <button onclick="quickReanalyze()" class="px-4 py-2 bg-amber-500 hover:bg-amber-600 text-black font-medium rounded-lg transition text-sm">
            <i class="fas fa-redo mr-2"></i>변경사항 적용하여 재분석
          </button>
        </div>
      </div>
    </div>
    
    <!-- 탭 네비게이션 -->
    <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4 overflow-x-auto" style="scrollbar-width: none;">
      <button onclick="switchTab('career')" data-tab="career" class="profile-tab px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap bg-wiki-primary text-white">
        <i class="fas fa-briefcase mr-2"></i>기본 정보
      </button>
      <button onclick="switchTab('universal')" data-tab="universal" class="profile-tab px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap text-wiki-muted hover:bg-wiki-card/50">
        <i class="fas fa-heart mr-2"></i>관심사/성향
      </button>
      <button onclick="switchTab('transition')" data-tab="transition" class="profile-tab px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap text-wiki-muted hover:bg-wiki-card/50">
        <i class="fas fa-exchange-alt mr-2"></i>전환 의향
      </button>
      <button onclick="switchTab('narrative')" data-tab="narrative" class="profile-tab px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap text-wiki-muted hover:bg-wiki-card/50">
        <i class="fas fa-pen-fancy mr-2"></i>심층 답변
      </button>
      <button onclick="switchTab('resume')" data-tab="resume" class="profile-tab px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap text-wiki-muted hover:bg-wiki-card/50">
        <i class="fas fa-file-alt mr-2"></i>이력서 정보
      </button>
    </div>
    
    <!-- 탭 컨텐츠 영역 -->
    <div id="tab-content">
      <!-- 로딩 상태 -->
      <div id="loading-state" class="py-8 text-center">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-wiki-primary"></div>
        <p class="mt-4 text-wiki-muted">프로필 데이터를 불러오는 중...</p>
      </div>
      
      <!-- 빈 상태 -->
      <div id="empty-state" class="hidden py-12 text-center">
        <div class="inline-flex items-center justify-center w-16 h-16 rounded-full mb-4" style="background: rgba(67, 97, 238, 0.1);">
          <i class="fas fa-user-plus text-2xl text-wiki-primary"></i>
        </div>
        <h3 class="text-xl font-semibold text-white mb-3">프로필 데이터가 없습니다</h3>
        <p class="mb-6 text-wiki-muted">AI 분석을 통해 프로필을 생성해주세요.</p>
        <a href="/analyzer/job" class="inline-flex items-center gap-2 px-5 py-2.5 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-lg transition">
          <i class="fas fa-magic"></i> AI 분석 시작하기
        </a>
      </div>
      
      <!-- Career State 탭 -->
      <div id="tab-career" class="tab-panel hidden">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">역할 정체성</h4>
              <button onclick="editField('career_state', 'role_identity')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <p id="field-role_identity" class="text-white font-medium">-</p>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">경력 단계</h4>
              <button onclick="editField('career_state', 'career_stage_years')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <p id="field-career_stage_years" class="text-white font-medium">-</p>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">전환 상태</h4>
              <button onclick="editField('career_state', 'transition_status')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <p id="field-transition_status" class="text-white font-medium">-</p>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">스킬 레벨</h4>
              <button onclick="editField('career_state', 'skill_level')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <div id="field-skill_level" class="flex items-center gap-2">
              <div class="flex gap-1">
                <span class="skill-dot w-3 h-3 rounded-full bg-wiki-border/50"></span>
                <span class="skill-dot w-3 h-3 rounded-full bg-wiki-border/50"></span>
                <span class="skill-dot w-3 h-3 rounded-full bg-wiki-border/50"></span>
                <span class="skill-dot w-3 h-3 rounded-full bg-wiki-border/50"></span>
                <span class="skill-dot w-3 h-3 rounded-full bg-wiki-border/50"></span>
              </div>
              <span class="text-wiki-muted text-sm">-</span>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Universal Answers 탭 -->
      <div id="tab-universal" class="tab-panel hidden">
        <div class="space-y-4">
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">관심 분야</h4>
              <button onclick="editField('universal_answers', 'interest')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <div id="field-interest" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">강점</h4>
              <button onclick="editField('universal_answers', 'strength')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <div id="field-strength" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">기피 요소</h4>
              <button onclick="editField('universal_answers', 'dislike')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <div id="field-dislike" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">우선순위</h4>
              <button onclick="editField('universal_answers', 'priority')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <p id="field-priority" class="text-white font-medium">-</p>
          </div>
          
          <!-- 나를 알아가기 섹션 (Q8-Q15) -->
          <div class="mt-6 pt-4 border-t border-wiki-border/30">
            <h3 class="text-lg font-semibold text-white mb-4 flex items-center gap-2">
              <i class="fas fa-brain text-purple-400"></i> 나를 알아가기
            </h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">업무 스타일</h4>
                <p id="field-workstyle_social" class="text-white font-medium">-</p>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">언어 능력</h4>
                <div id="field-language" class="flex flex-wrap gap-2">
                  <span class="text-wiki-muted">-</span>
                </div>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">🔥 감수 가능</h4>
                <div id="field-mm_sacrifice" class="flex flex-wrap gap-2">
                  <span class="text-wiki-muted">-</span>
                </div>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">⚡ 에너지 소모원</h4>
                <div id="field-mm_energy_drain" class="flex flex-wrap gap-2">
                  <span class="text-wiki-muted">-</span>
                </div>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">🏆 성취 피드백</h4>
                <div id="field-mm_achievement" class="flex flex-wrap gap-2">
                  <span class="text-wiki-muted">-</span>
                </div>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">🏃 실행 스타일</h4>
                <p id="field-mm_execution" class="text-white font-medium">-</p>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">🌍 영향 범위</h4>
                <p id="field-mm_impact_scope" class="text-white font-medium">-</p>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">💥 실패 반응</h4>
                <p id="field-mm_failure" class="text-white font-medium">-</p>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">🛡️ 버팀 앵커</h4>
                <p id="field-mm_anchor" class="text-white font-medium">-</p>
              </div>
              <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
                <h4 class="text-sm font-medium text-wiki-muted mb-2">👁️ 외부 기대 반응</h4>
                <p id="field-mm_external" class="text-white font-medium">-</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Transition Signal 탭 -->
      <div id="tab-transition" class="tab-panel hidden">
        <div class="space-y-4">
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">희망 전환 유형</h4>
              <button onclick="editField('transition_signal', 'desired_types')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <div id="field-desired_types" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">전환 동기</h4>
              <button onclick="editField('transition_signal', 'motivation')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <p id="field-motivation" class="text-white font-medium">-</p>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">목표 기간</h4>
              <button onclick="editField('transition_signal', 'timeline')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <p id="field-timeline" class="text-white font-medium">-</p>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">장애 요소</h4>
              <button onclick="editField('transition_signal', 'blockers')" class="text-wiki-muted hover:text-wiki-primary transition">
                <i class="fas fa-edit text-xs"></i>
              </button>
            </div>
            <div id="field-blockers" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Narrative/Round Answers 탭 -->
      <div id="tab-narrative" class="tab-panel hidden">
        <div class="space-y-4">
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">가장 생생했던 순간</h4>
            </div>
            <p id="field-highAliveMoment" class="text-white leading-relaxed">-</p>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">가장 지쳤던 순간</h4>
            </div>
            <p id="field-lostMoment" class="text-white leading-relaxed">-</p>
          </div>
          <div id="round-answers-container" class="space-y-4">
            <!-- 라운드 답변들이 여기에 동적으로 추가됨 -->
          </div>
        </div>
      </div>
      
      <!-- Resume Data 탭 -->
      <div id="tab-resume" class="tab-panel hidden">
        <div class="space-y-4">
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">보유 스킬</h4>
            </div>
            <div id="field-skills" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">자격증</h4>
            </div>
            <div id="field-certifications" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
            <div class="flex items-center justify-between mb-3">
              <h4 class="text-sm font-medium text-wiki-muted">경험 업종</h4>
            </div>
            <div id="field-industries" class="flex flex-wrap gap-2">
              <span class="text-wiki-muted">-</span>
            </div>
          </div>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
              <h4 class="text-sm font-medium text-wiki-muted mb-3">학력 수준</h4>
              <p id="field-education_level" class="text-white font-medium">-</p>
            </div>
            <div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">
              <h4 class="text-sm font-medium text-wiki-muted mb-3">역할 유형</h4>
              <p id="field-role_type" class="text-white font-medium">-</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 편집 모달 -->
    <div id="edit-modal" class="fixed inset-0 z-50 hidden">
      <div class="absolute inset-0 bg-black/70" onclick="closeEditModal()"></div>
      <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-md bg-wiki-bg border border-wiki-border rounded-2xl p-6">
        <div class="flex items-center justify-between mb-4">
          <h3 id="modal-title" class="text-lg font-semibold text-white">필드 수정</h3>
          <button onclick="closeEditModal()" class="text-wiki-muted hover:text-white transition">
            <i class="fas fa-times"></i>
          </button>
        </div>
        <div id="modal-content" class="mb-6">
          <!-- 동적으로 폼 필드 삽입 -->
        </div>
        <div class="flex justify-end gap-3">
          <button onclick="closeEditModal()" class="px-4 py-2 text-wiki-muted hover:text-white transition">취소</button>
          <button onclick="saveField()" class="px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white font-medium rounded-lg transition">저장</button>
        </div>
      </div>
    </div>
    
    <!-- 메타데이터 영역 -->
    <div class="mt-6 pt-6 border-t border-wiki-border/30">
      <div class="flex flex-wrap items-center justify-between gap-4 text-sm text-wiki-muted">
        <div class="flex items-center gap-4">
          <span id="meta-updated"><i class="far fa-clock mr-1"></i>마지막 업데이트: -</span>
          <span id="meta-analysis"><i class="fas fa-chart-line mr-1"></i>마지막 분석: -</span>
        </div>
        <div class="flex items-center gap-2">
          <span id="meta-completeness" class="flex items-center gap-2">
            완성도: <div class="w-24 h-2 bg-wiki-border/30 rounded-full overflow-hidden"><div class="h-full bg-wiki-primary rounded-full" style="width: 0%"></div></div> 0%
          </span>
        </div>
      </div>
    </div>
    
    <script>
      // 전역 상태
      let profileData = null;
      let currentCategory = null;
      let currentField = null;
      
      // 필드 라벨 맵
      const fieldLabels = {
        role_identity: '역할 정체성',
        career_stage_years: '경력 단계',
        transition_status: '전환 상태',
        skill_level: '스킬 레벨',
        interest: '관심 분야',
        strength: '강점',
        dislike: '기피 요소',
        priority: '우선순위',
        desired_types: '희망 전환 유형',
        motivation: '전환 동기',
        timeline: '목표 기간',
        blockers: '장애 요소'
      };
      
      // 값 라벨 맵
      const valueLabels = {
        // role_identity
        worker: '직장인',
        student: '학생',
        jobseeker: '구직자',
        career_changer: '이직 준비생',
        freelancer: '프리랜서',
        // career_stage_years
        '0_3': '0~3년 (초기)',
        '3_7': '3~7년 (성장기)',
        '7_15': '7~15년 (전문가)',
        '15_plus': '15년 이상 (시니어)',
        // transition_status
        exploring: '탐색 중',
        decided: '결정됨',
        preparing: '준비 중',
        transitioning: '전환 중',
        stable: '안정적',
        changer: '전환 고려 중',
        returner: '복귀 준비 중',
        // priority
        stability: '안정성',
        growth: '성장',
        balance: '워라밸',
        income: '소득',
        purpose: '의미/목적',
        // timeline
        '3m': '3개월 이내',
        '6m': '6개월 이내',
        '1y': '1년 이내',
        '2y_plus': '2년 이상',
        undecided: '미정',
        // motivation
        dissatisfaction: '현재 직무 불만족',
        better_opportunity: '더 좋은 기회',
        passion: '새로운 분야 열정',
        life_change: '생활 변화',
        skill_growth: '역량 향상',
        // ========== 나를 알아가기 (Q8-Q15) ==========
        // 업무 스타일 (Q7)
        alone_work: '혼자 집중',
        team_work: '함께 협업',
        mixed_work: '상황에 따라',
        // 포기 가능 (Q8 - sacrifice)
        low_initial_income: '낮은 초봉 감수',
        willing_to_study: '재학습 감수',
        field_change_ok: '분야 전환 감수',
        ignore_social_pressure: '주변 시선 감수',
        no_sacrifice: '포기 불가',
        // 에너지 소모 (Q9 - energy_drain)
        people_drain: '대인관계 스트레스',
        cognitive_drain: '인지 피로',
        time_pressure_drain: '시간 압박',
        responsibility_drain: '책임 스트레스',
        repetition_drain: '반복 피로',
        unpredictability_drain: '불확실성',
        // 성취 피드백 (Q10)
        metric_feedback: '수치 성과',
        helping_feedback: '직접 도움',
        problem_solved_feedback: '문제 해결',
        tangible_output_feedback: '결과물 산출',
        growth_feedback: '성장 실감',
        // 실행 스타일 (Q11)
        action_first: '일단 해보기',
        plan_first: '계획 우선',
        flexible_execution: '상황 따라',
        // 영향 범위 (Q12)
        individual_scope: '개인',
        team_scope: '팀/조직',
        company_scope: '회사/산업',
        society_scope: '사회 전반',
        unknown_scope: '잘 모르겠다',
        // 실패 반응 (Q13)
        iterate_on_failure: '구조 개선',
        pivot_on_failure: '빠르게 전환',
        pause_on_failure: '잠시 정리',
        emotionally_affected: '크게 흔들림',
        // 버팀 앵커 (Q14)
        reward_anchor: '보상',
        growth_anchor: '성장',
        people_anchor: '사람',
        meaning_anchor: '의미/방향성',
        stability_anchor: '안정성',
        // 외부 기대 반응 (Q15)
        external_structure_ok: '기준이 있으면 편함',
        neutral_to_expectation: '상관없음',
        expectation_pressure: '부담됨',
        // 관심 분야
        problem_solving: '문제해결',
        creating: '창작/디자인',
        helping_teaching: '도움/가르침',
        data_numbers: '데이터/숫자',
        organizing: '조직/관리',
        influencing: '영향력/설득',
        // 강점
        analytical: '분석력',
        creative: '창의력',
        communication: '소통력',
        structured_execution: '실행력',
        persistence: '끈기',
        fast_learning: '학습력'
      };
      
      // 페이지 로드 시 데이터 가져오기
      document.addEventListener('DOMContentLoaded', loadProfile);
      
      async function loadProfile() {
        try {
          const res = await fetch('/api/ai-analyzer/profile');
          const data = await res.json();
          
          if (!data.success) {
            document.getElementById('loading-state').classList.add('hidden');
            document.getElementById('empty-state').classList.remove('hidden');
            return;
          }
          
          profileData = data.profile;
          
          // 메타데이터 업데이트
          updateMetadata(data.metadata);
          
          // 데이터 렌더링
          renderProfile(data.profile);
          
          // 변경사항 체크
          checkForChanges();
          
          // 로딩 숨기고 첫 번째 탭 표시
          document.getElementById('loading-state').classList.add('hidden');
          document.getElementById('tab-career').classList.remove('hidden');
          
        } catch (error) {
          document.getElementById('loading-state').innerHTML = '<p class="text-red-400">프로필을 불러오는 중 오류가 발생했습니다.</p>';
        }
      }
      
      function updateMetadata(metadata) {
        if (metadata.last_updated_at) {
          const updatedDate = new Date(metadata.last_updated_at);
          document.getElementById('meta-updated').innerHTML = '<i class="far fa-clock mr-1"></i>마지막 업데이트: ' + updatedDate.toLocaleDateString('ko-KR');
        }
        if (metadata.last_analysis_at) {
          const analysisDate = new Date(metadata.last_analysis_at);
          document.getElementById('meta-analysis').innerHTML = '<i class="fas fa-chart-line mr-1"></i>마지막 분석: ' + analysisDate.toLocaleDateString('ko-KR');
        }
        const completeness = Math.round((metadata.data_completeness || 0) * 100);
        document.getElementById('meta-completeness').innerHTML = '완성도: <div class="w-24 h-2 bg-wiki-border/30 rounded-full overflow-hidden"><div class="h-full bg-wiki-primary rounded-full" style="width: ' + completeness + '%"></div></div> ' + completeness + '%';
        
        // 요약 헤더 업데이트
        const summaryEl = document.getElementById('profile-summary');
        summaryEl.innerHTML = '<p class="text-wiki-muted">총 ' + (metadata.total_facts_count || 0) + '개의 프로필 데이터가 저장되어 있습니다.</p>';
      }
      
      function renderProfile(profile) {
        if (!profile) return;
        
        // Career State
        if (profile.career_state) {
          const cs = profile.career_state;
          setText('field-role_identity', valueLabels[cs.role_identity] || cs.role_identity || '-');
          setText('field-career_stage_years', valueLabels[cs.career_stage_years] || cs.career_stage_years || '-');
          setText('field-transition_status', valueLabels[cs.transition_status] || cs.transition_status || '-');
          renderSkillLevel(cs.skill_level);
        }
        
        // Universal Answers
        if (profile.universal_answers) {
          const ua = profile.universal_answers;
          renderTags('field-interest', ua.interest, 'bg-emerald-500/20 text-emerald-300 border-emerald-500/30');
          renderTags('field-strength', ua.strength, 'bg-blue-500/20 text-blue-300 border-blue-500/30');
          renderTags('field-dislike', ua.dislike, 'bg-red-500/20 text-red-300 border-red-500/30');
          setText('field-priority', valueLabels[ua.priority] || ua.priority || '-');
          
          // 나를 알아가기 (Q8-Q15)
          setText('field-workstyle_social', valueLabels[ua.workstyle_social] || ua.workstyle_social || '-');
          renderLanguageTags('field-language', ua.language);
          renderTagsWithLabel('field-mm_sacrifice', ua.mm_sacrifice, 'bg-orange-500/20 text-orange-300 border-orange-500/30');
          renderTagsWithLabel('field-mm_energy_drain', ua.mm_energy_drain, 'bg-red-500/20 text-red-300 border-red-500/30');
          renderTagsWithLabel('field-mm_achievement', ua.mm_achievement, 'bg-green-500/20 text-green-300 border-green-500/30');
          setText('field-mm_execution', valueLabels[ua.mm_execution] || ua.mm_execution || '-');
          setText('field-mm_impact_scope', valueLabels[ua.mm_impact_scope] || ua.mm_impact_scope || '-');
          setText('field-mm_failure', valueLabels[ua.mm_failure] || ua.mm_failure || '-');
          setText('field-mm_anchor', valueLabels[ua.mm_anchor] || ua.mm_anchor || '-');
          setText('field-mm_external', valueLabels[ua.mm_external] || ua.mm_external || '-');
        }
        
        // Transition Signal
        if (profile.transition_signal) {
          const ts = profile.transition_signal;
          renderTags('field-desired_types', ts.desired_types, 'bg-purple-500/20 text-purple-300 border-purple-500/30');
          setText('field-motivation', valueLabels[ts.motivation] || ts.motivation || '-');
          setText('field-timeline', valueLabels[ts.timeline] || ts.timeline || '-');
          renderTags('field-blockers', ts.blockers, 'bg-orange-500/20 text-orange-300 border-orange-500/30');
        }
        
        // Narrative Facts
        if (profile.narrative_facts) {
          setText('field-highAliveMoment', profile.narrative_facts.highAliveMoment || '-');
          setText('field-lostMoment', profile.narrative_facts.lostMoment || '-');
        }
        
        // Round Answers
        if (profile.round_answers && profile.round_answers.length > 0) {
          const container = document.getElementById('round-answers-container');
          container.innerHTML = profile.round_answers.map((ra, i) => 
            '<div class="profile-card p-4 rounded-xl bg-wiki-card/30 border border-wiki-border/30">' +
              '<h4 class="text-sm font-medium text-wiki-muted mb-3">라운드 ' + ra.round + ' 답변 #' + (i + 1) + '</h4>' +
              '<p class="text-white leading-relaxed">' + escapeHtml(ra.answer || '-') + '</p>' +
            '</div>'
          ).join('');
        }
        
        // Resume Data
        if (profile.resume_data) {
          const rd = profile.resume_data;
          renderTags('field-skills', rd.skills, 'bg-cyan-500/20 text-cyan-300 border-cyan-500/30');
          renderTags('field-certifications', rd.certifications, 'bg-amber-500/20 text-amber-300 border-amber-500/30');
          renderTags('field-industries', rd.industries, 'bg-indigo-500/20 text-indigo-300 border-indigo-500/30');
          setText('field-education_level', rd.education_level || '-');
          setText('field-role_type', rd.role_type || '-');
        }
      }
      
      function setText(id, text) {
        const el = document.getElementById(id);
        if (el) el.textContent = text;
      }
      
      function renderTags(id, items, colorClass) {
        const el = document.getElementById(id);
        if (!el) return;
        if (!items || items.length === 0) {
          el.innerHTML = '<span class="text-wiki-muted">-</span>';
          return;
        }
        el.innerHTML = items.map(item => 
          '<span class="px-3 py-1 text-sm rounded-full border ' + colorClass + '">' + escapeHtml(item) + '</span>'
        ).join('');
      }
      
      // 토큰을 한국어 라벨로 변환하여 태그 렌더링
      function renderTagsWithLabel(id, items, colorClass) {
        const el = document.getElementById(id);
        if (!el) return;
        if (!items || items.length === 0) {
          el.innerHTML = '<span class="text-wiki-muted">-</span>';
          return;
        }
        el.innerHTML = items.map(item => {
          const label = valueLabels[item] || item;
          return '<span class="px-3 py-1 text-sm rounded-full border ' + colorClass + '">' + escapeHtml(label) + '</span>';
        }).join('');
      }
      
      // 언어 태그 렌더링 (수준 포함)
      function renderLanguageTags(id, langData) {
        const el = document.getElementById(id);
        if (!el) return;
        if (!langData) {
          el.innerHTML = '<span class="text-wiki-muted">-</span>';
          return;
        }
        
        // 배열인 경우 (단순 언어 목록)
        if (Array.isArray(langData)) {
          if (langData.length === 0 || (langData.length === 1 && langData[0] === 'none')) {
            el.innerHTML = '<span class="text-wiki-muted">없음</span>';
            return;
          }
          el.innerHTML = langData.filter(l => l !== 'none').map(lang => 
            '<span class="px-3 py-1 text-sm rounded-full border bg-indigo-500/20 text-indigo-300 border-indigo-500/30">' + escapeHtml(lang) + '</span>'
          ).join('');
          return;
        }
        
        // 객체인 경우 (언어: {level, label} 형태)
        const entries = Object.entries(langData);
        if (entries.length === 0) {
          el.innerHTML = '<span class="text-wiki-muted">-</span>';
          return;
        }
        
        const langLabels = {
          korean: '한국어', english: '영어', japanese: '일본어', chinese: '중국어',
          spanish: '스페인어', german: '독일어', french: '프랑스어', russian: '러시아어',
          italian: '이탈리아어', portuguese: '포르투갈어', arabic: '아랍어', hindi: '힌디어',
          vietnamese: '베트남어', thai: '태국어', indonesian: '인도네시아어', turkish: '터키어'
        };
        const levelLabels = {
          beginner: '초급', intermediate: '중급', advanced: '고급', native: '원어민'
        };
        
        el.innerHTML = entries.map(([lang, info]) => {
          const langName = langLabels[lang] || lang;
          const levelName = levelLabels[info?.level] || info?.level || '';
          return '<span class="px-3 py-1 text-sm rounded-full border bg-indigo-500/20 text-indigo-300 border-indigo-500/30">' + 
            escapeHtml(langName) + (levelName ? ' (' + levelName + ')' : '') + '</span>';
        }).join('');
      }
      
      function renderSkillLevel(level) {
        const el = document.getElementById('field-skill_level');
        if (!el) return;
        const lvl = level || 0;
        const labels = ['미설정', '입문', '초급', '중급', '고급', '전문가'];
        el.innerHTML = '<div class="flex gap-1">' +
          [1,2,3,4,5].map(i => 
            '<span class="skill-dot w-3 h-3 rounded-full ' + (i <= lvl ? 'bg-wiki-primary' : 'bg-wiki-border/50') + '"></span>'
          ).join('') +
          '</div><span class="text-wiki-muted text-sm ml-2">' + labels[lvl] + '</span>';
      }
      
      function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
      }
      
      // 탭 전환
      function switchTab(tabName) {
        // 모든 탭 버튼 비활성화
        document.querySelectorAll('.profile-tab').forEach(btn => {
          btn.classList.remove('bg-wiki-primary', 'text-white');
          btn.classList.add('text-wiki-muted', 'hover:bg-wiki-card/50');
        });
        
        // 선택된 탭 버튼 활성화
        const activeBtn = document.querySelector('[data-tab="' + tabName + '"]');
        if (activeBtn) {
          activeBtn.classList.add('bg-wiki-primary', 'text-white');
          activeBtn.classList.remove('text-wiki-muted', 'hover:bg-wiki-card/50');
        }
        
        // 모든 탭 패널 숨기기
        document.querySelectorAll('.tab-panel').forEach(panel => {
          panel.classList.add('hidden');
        });
        
        // 선택된 탭 패널 표시
        const activePanel = document.getElementById('tab-' + tabName);
        if (activePanel) {
          activePanel.classList.remove('hidden');
        }
      }
      
      // 변경사항 체크
      async function checkForChanges() {
        try {
          const res = await fetch('/api/ai-analyzer/profile/diff');
          const data = await res.json();
          
          if (data.success && data.has_changes) {
            const banner = document.getElementById('changes-banner');
            const message = document.getElementById('changes-message');
            banner.classList.remove('hidden');
            message.textContent = data.recommendation || '프로필이 변경되었습니다.';
          }
        } catch (error) {
        }
      }
      
      // 필드 편집
      function editField(category, field) {
        currentCategory = category;
        currentField = field;
        
        const title = document.getElementById('modal-title');
        const content = document.getElementById('modal-content');
        
        title.textContent = fieldLabels[field] || field;
        
        let currentValue = '';
        if (profileData && profileData[category]) {
          currentValue = profileData[category][field];
        }
        
        // 필드 타입에 따른 입력 폼 생성
        if (Array.isArray(currentValue)) {
          content.innerHTML = '<textarea id="edit-value" rows="4" class="w-full px-4 py-3 bg-wiki-card border border-wiki-border rounded-lg text-white focus:outline-none focus:border-wiki-primary" placeholder="쉼표로 구분하여 입력">' + (currentValue.join(', ')) + '</textarea>';
        } else if (typeof currentValue === 'number') {
          content.innerHTML = '<input type="number" id="edit-value" value="' + (currentValue || '') + '" min="0" max="5" class="w-full px-4 py-3 bg-wiki-card border border-wiki-border rounded-lg text-white focus:outline-none focus:border-wiki-primary" />';
        } else {
          content.innerHTML = '<input type="text" id="edit-value" value="' + (currentValue || '') + '" class="w-full px-4 py-3 bg-wiki-card border border-wiki-border rounded-lg text-white focus:outline-none focus:border-wiki-primary" />';
        }
        
        document.getElementById('edit-modal').classList.remove('hidden');
      }
      
      function closeEditModal() {
        document.getElementById('edit-modal').classList.add('hidden');
        currentCategory = null;
        currentField = null;
      }
      
      async function saveField() {
        if (!currentCategory || !currentField) return;
        
        const inputEl = document.getElementById('edit-value');
        let newValue = inputEl.value;
        
        // 배열 타입 처리
        if (inputEl.tagName === 'TEXTAREA') {
          newValue = newValue.split(',').map(s => s.trim()).filter(Boolean);
        } else if (inputEl.type === 'number') {
          newValue = parseInt(newValue, 10);
        }
        
        try {
          const res = await fetch('/api/ai-analyzer/profile', {
            method: 'PATCH',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              updates: {
                [currentCategory]: {
                  [currentField]: newValue
                }
              }
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            closeEditModal();
            // 페이지 새로고침하여 데이터 반영
            loadProfile();
          } else {
            alert('저장 실패: ' + (data.message || '알 수 없는 오류'));
          }
        } catch (error) {
          alert('저장 중 오류가 발생했습니다.');
        }
      }
      
      // 빠른 재분석
      async function quickReanalyze() {
        try {
          const btn = event.target;
          if (btn) {
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>처리 중...';
          }
          
          const res = await fetch('/api/ai-analyzer/profile/quick-reanalyze', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              use_existing_data: true,
              skip_unchanged_steps: true
            })
          });
          
          const data = await res.json();
          
          if (data.success) {
            // analyzer_url이 있으면 분석 페이지로, 없으면 결과 페이지로 이동
            if (data.analyzer_url) {
              window.location.href = data.analyzer_url;
            } else {
              window.location.href = '/user/ai-results';
            }
          } else {
            alert('재분석 요청 실패: ' + (data.message || '알 수 없는 오류'));
            if (btn) {
              btn.disabled = false;
              btn.innerHTML = '<i class="fas fa-redo mr-2"></i>변경사항 적용하여 재분석';
            }
          }
        } catch (error) {
          alert('재분석 요청 중 오류가 발생했습니다.');
        }
      }
    </script>
    
    <style>
      .profile-tab::-webkit-scrollbar { display: none; }
      .tab-panel { animation: fadeIn 0.2s ease-in-out; }
      @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
  `
}

userRoutes.get('/user/ai-results', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/user/ai-results')
  }
  
  const activeTab = (c.req.query('tab') || 'results') as 'results' | 'profile'
  const filter = (c.req.query('filter') || 'all') as 'all' | 'job' | 'major'
  const page = parseInt(c.req.query('page') || '1', 10)
  const limit = 10
  const offset = (page - 1) * limit
  
  try {
    // 진행중인 모든 draft 조회 (완료된 것은 request_id도 함께 조회)
    // LEFT JOIN으로 ai_analysis_requests와 연결하여 request_id 가져오기
    const draftResults = await c.env.DB.prepare(`
      SELECT
        d.id, d.session_id, d.analysis_type, d.current_step,
        d.step1_answers_json, d.step4_answers_json, d.updated_at,
        latest_req.id as request_id
      FROM analyzer_drafts d
      LEFT JOIN (
        SELECT session_id, MAX(id) as id
        FROM ai_analysis_requests
        WHERE status = 'completed'
        GROUP BY session_id
      ) latest_req ON d.session_id = latest_req.session_id
      WHERE d.user_id = ? AND d.session_id NOT LIKE 'edit-%'
      ORDER BY d.updated_at DESC
    `).bind(user.id).all<{
      id: number
      session_id: string
      analysis_type: string
      current_step: number
      step1_answers_json: string | null
      step4_answers_json: string | null
      updated_at: string
      request_id: number | null
    }>()
    
    // 총 개수 조회
    const countResult = await c.env.DB.prepare(`
      SELECT COUNT(*) as total
      FROM ai_analysis_results r
      JOIN ai_analysis_requests req ON r.request_id = req.id
      WHERE req.user_id = ?
      ${filter !== 'all' ? 'AND req.analysis_type = ?' : ''}
    `).bind(...(filter !== 'all' ? [user.id, filter] : [user.id])).first<{ total: number }>()
    
    const total = countResult?.total || 0
    const totalPages = Math.ceil(total / limit)
    
    // 결과 조회 (버전 정보 포함)
    const results = await c.env.DB.prepare(`
      SELECT
        r.id,
        r.request_id,
        r.result_json,
        r.confidence_score,
        r.created_at,
        r.engine_version,
        CASE WHEN r.premium_report_json IS NOT NULL THEN 1 ELSE 0 END as has_premium_report,
        req.session_id,
        req.analysis_type,
        req.version_number,
        req.version_note,
        req.parent_request_id
      FROM ai_analysis_results r
      JOIN ai_analysis_requests req ON r.request_id = req.id
      WHERE req.user_id = ?
      ${filter !== 'all' ? 'AND req.analysis_type = ?' : ''}
      ORDER BY r.created_at DESC
      LIMIT ? OFFSET ?
    `).bind(...(filter !== 'all' ? [user.id, filter, limit, offset] : [user.id, limit, offset])).all<{
      id: number
      request_id: number
      result_json: string
      confidence_score: number | null
      created_at: string
      engine_version: string | null
      has_premium_report: number
      session_id: string
      analysis_type: string
      version_number: number | null
      version_note: string | null
      parent_request_id: number | null
    }>()
    
    // 결과 파싱
    const parsedResults: AiResultItem[] = (results.results || []).map(r => {
      let topRecs: Array<{ name: string; score?: number }> = []
      try {
        const parsed = JSON.parse(r.result_json)
        const fitTop3 = parsed.fit_top3 || []
        topRecs = fitTop3.slice(0, 3).map((j: any) => ({
          name: j.job_name || j.name || '알 수 없음',
          score: j.fit_score
        }))
      } catch { }
      
      return {
        id: r.id,
        request_id: r.request_id,
        session_id: r.session_id,
        analysis_type: r.analysis_type as 'job' | 'major',
        top_recommendations: topRecs,
        confidence_score: r.confidence_score,
        created_at: r.created_at,
        engine_version: r.engine_version || 'v2',
        has_premium_report: r.has_premium_report === 1,
        version_number: r.version_number || 1,
        version_note: r.version_note || null,
        parent_request_id: r.parent_request_id || null
      }
    })
    
    const resultsContent = renderUserAiResultsContent({
      results: parsedResults,
      filter,
      totalCount: total,
      page,
      totalPages,
      drafts: (draftResults?.results || []).map(d => {
        // step1_answers_json에서 profileSubStep, currentRound 추출
        let profileSubStep = 1
        let currentRound = 0
        try {
          if (d.step1_answers_json) {
            const step1 = JSON.parse(d.step1_answers_json)
            profileSubStep = step1.profileSubStep || 1
            currentRound = step1.currentRound || 0
          }
          // step4_answers_json에서도 currentRound 확인 (fallback)
          if (!currentRound && d.step4_answers_json) {
            const step4 = JSON.parse(d.step4_answers_json)
            currentRound = step4.current_round || 0
          }
        } catch { /* ignore parse errors */ }
        
        return {
          id: d.id,
          session_id: d.session_id,
          analysis_type: d.analysis_type as 'job' | 'major',
          current_step: d.current_step,
          profile_sub_step: profileSubStep,
          current_round: currentRound,
          updated_at: d.updated_at,
          request_id: d.request_id  // 완료된 분석의 request_id (결과 페이지 링크용)
        }
      })
    })
    
    // 프로필 컨텐츠 HTML
    const profileContent = generateProfileContentHtml()
    
    // 탭 구조 컨텐츠
    const tabbedContent = `
      <!-- 메인 탭 네비게이션 -->
      <div class="flex items-center gap-2 sm:gap-4 mb-6 border-b border-wiki-border/40 pb-4">
        <a href="/user/ai-results?tab=results"
           class="flex items-center gap-2 px-4 py-2.5 rounded-lg text-sm font-medium transition ${activeTab === 'results' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:text-white hover:bg-wiki-card/50'}">
          <i class="fas fa-robot"></i>
          <span>AI 추천</span>
        </a>
        <a href="/user/ai-results?tab=profile"
           class="flex items-center gap-2 px-4 py-2.5 rounded-lg text-sm font-medium transition ${activeTab === 'profile' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:text-white hover:bg-wiki-card/50'}">
          <i class="fas fa-user-circle"></i>
          <span>내 프로필</span>
        </a>
      </div>
      
      <!-- 탭 컨텐츠 -->
      ${activeTab === 'results' ? `
        <p class="text-wiki-muted mb-6">AI 추천을 받으면 여기서 분석 결과를 확인할 수 있습니다.</p>
        ${resultsContent}
        
        <!-- 삭제 확인 모달 -->
        <div id="delete-draft-modal" class="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center hidden">
          <div class="bg-wiki-card border border-wiki-border rounded-2xl p-6 max-w-sm mx-4 shadow-2xl">
            <div class="text-center mb-6">
              <div class="w-16 h-16 mx-auto mb-4 bg-gradient-to-br from-red-500 to-orange-500 rounded-full flex items-center justify-center">
                <i class="fas fa-trash text-2xl text-white"></i>
              </div>
              <h3 class="text-lg font-bold text-white mb-2">진행중인 추천 삭제</h3>
              <p class="text-wiki-muted text-sm">정말 삭제하시겠습니까?<br>작성한 내용이 모두 사라집니다.</p>
            </div>
            <div class="flex gap-3">
              <button onclick="hideDeleteModal()" class="flex-1 px-4 py-2.5 bg-wiki-bg border border-wiki-border text-white rounded-xl hover:bg-wiki-card transition text-sm font-medium">
                취소
              </button>
              <button onclick="confirmDeleteDraft()" class="flex-1 px-4 py-2.5 bg-gradient-to-r from-red-500 to-orange-500 text-white rounded-xl hover:opacity-90 transition text-sm font-medium">
                삭제
              </button>
            </div>
          </div>
        </div>
        
        <script>
          let pendingDeleteSessionId = null;
          
          function deleteDraft(sessionId) {
            pendingDeleteSessionId = sessionId;
            document.getElementById('delete-draft-modal').classList.remove('hidden');
          }
          
          function hideDeleteModal() {
            document.getElementById('delete-draft-modal').classList.add('hidden');
            pendingDeleteSessionId = null;
          }
          
          async function confirmDeleteDraft() {
            if (!pendingDeleteSessionId) return;
            
            try {
              const response = await fetch('/api/ai-analyzer/draft/delete?session_id=' + encodeURIComponent(pendingDeleteSessionId), {
                method: 'DELETE',
                credentials: 'same-origin'
              });
              
              if (response.ok) {
                // 로컬 스토리지도 삭제 (job/major 둘 다)
                localStorage.removeItem('analyzer_draft');
                localStorage.removeItem('analyzer_draft_timestamp');
                localStorage.removeItem('analyzer_draft_major');
                localStorage.removeItem('analyzer_draft_major_timestamp');
                
                // 페이지 새로고침하여 목록 갱신
                window.location.reload();
              } else {
                alert('삭제에 실패했습니다. 다시 시도해주세요.');
              }
            } catch (error) {
              alert('삭제 중 오류가 발생했습니다.');
            }
            
            hideDeleteModal();
          }
          
          async function deleteAllDrafts() {
            if (!confirm('진행중인 모든 분석을 삭제하시겠습니까?\\n이 작업은 되돌릴 수 없습니다.')) {
              return;
            }
            
            try {
              const response = await fetch('/api/ai-analyzer/draft/delete-all', {
                method: 'DELETE',
                credentials: 'same-origin'
              });
              
              if (response.ok) {
                const data = await response.json();
                
                // 로컬 스토리지도 모두 삭제
                localStorage.removeItem('analyzer_draft');
                localStorage.removeItem('analyzer_draft_timestamp');
                localStorage.removeItem('analyzer_draft_major');
                localStorage.removeItem('analyzer_draft_major_timestamp');
                
                alert(data.deleted_count + '개의 진행중 분석이 삭제되었습니다.');
                window.location.reload();
              } else {
                alert('삭제에 실패했습니다. 다시 시도해주세요.');
              }
            } catch (error) {
              alert('삭제 중 오류가 발생했습니다.');
            }
          }
        </script>
      ` : profileContent}
    `
    
    const pageContent = renderUserLayoutContent({
      title: 'AI 추천',
      currentPath: '/user/ai-results',
      children: tabbedContent,
      username: user.username || user.email || 'user_' + user.id,
      pictureUrl: user.custom_picture_url || user.picture_url || null,
      role: user.role
    })
    
    return c.html(renderLayoutWithContext(c, pageContent, 'AI 추천 - 마이페이지 - Careerwiki'))
    
  } catch (error) {
    const errorContent = renderUserLayoutContent({
      title: 'AI 추천',
      currentPath: '/user/ai-results',
      children: `<div class="text-center py-16"><p class="text-wiki-muted">결과를 불러오는 중 오류가 발생했습니다.</p></div>`,
      username: user.username || user.email,
      pictureUrl: user.custom_picture_url || user.picture_url || null,
      role: user.role
    })
    return c.html(renderLayoutWithContext(c, errorContent, 'AI 추천 - 마이페이지 - Careerwiki'))
  }
})

// AI 추천 결과 상세 페이지
userRoutes.get('/user/ai-results/:requestId', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=' + encodeURIComponent(c.req.path))
  }

  const requestId = parseInt(c.req.param('requestId'), 10)

  try {
    // 결과 조회 - analysis_type만 확인하여 적절한 analyzer 페이지로 리다이렉트
    const result = await c.env.DB.prepare(`
      SELECT req.analysis_type
      FROM ai_analysis_requests req
      LEFT JOIN analyzer_drafts d ON req.session_id = d.session_id
      WHERE req.id = ? AND (req.user_id = ? OR d.user_id = ?)
    `).bind(requestId, user.id, user.id).first<{
      analysis_type: string
    }>()
    
    if (!result) {
      return c.redirect('/user/ai-results')
    }

    const analyzerPath = result.analysis_type === 'job' ? '/analyzer/job' : '/analyzer/major'
    return c.redirect(`${analyzerPath}?view=${requestId}`)
    
  } catch (error) {
    const errorPageContent = renderUserLayoutContent({
      title: '오류',
      currentPath: '/user/ai-results',
      children: `<div class="text-center py-16"><p class="text-wiki-muted">결과를 불러오는 중 오류가 발생했습니다.</p></div>`,
      username: user.username || user.email,
      pictureUrl: user.custom_picture_url || user.picture_url || null,
      role: user.role
    })
    return c.html(renderLayoutWithContext(c, errorPageContent, '오류 - 마이페이지 - Careerwiki'))
  }
})

userRoutes.get('/user/comments', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/user/comments')
  }
  
  const filter = c.req.query('filter') || 'all'
  
  // 내 댓글 조회 (pages 테이블과 조인)
  // author_id는 숫자로 저장되므로 CAST로 비교
  const comments = await c.env.DB.prepare(`
    SELECT c.id, c.content, c.created_at, p.page_type, p.slug, p.title as page_title
    FROM comments c
    JOIN pages p ON c.page_id = p.id
    WHERE CAST(c.author_id AS INTEGER) = ? AND c.status != 'deleted'
    ORDER BY c.created_at DESC
    LIMIT 100
  `).bind(user.id).all<{
    id: number; content: string; created_at: string; page_type: string; 
    slug: string; page_title: string | null
  }>()
  
  const allComments = comments.results || []
  
  // 페이지 타입별 분류 (guide는 howto로 취급)
  const jobComments = allComments.filter(c => c.page_type === 'job')
  const majorComments = allComments.filter(c => c.page_type === 'major')
  const guideComments = allComments.filter(c => c.page_type === 'guide' || c.page_type === 'howto')
  
  // 필터 적용
  let filteredComments = allComments
  if (filter === 'job') filteredComments = jobComments
  else if (filter === 'major') filteredComments = majorComments
  else if (filter === 'howto') filteredComments = guideComments
  
  // 페이지 타입에 따른 아이콘과 색상
  const getTypeInfo = (pageType: string) => {
    switch (pageType) {
      case 'job': return { icon: 'fa-briefcase', color: 'text-blue-400', bgColor: 'bg-blue-500/10', borderColor: 'border-blue-500/30', label: '직업' }
      case 'major': return { icon: 'fa-university', color: 'text-emerald-400', bgColor: 'bg-emerald-500/10', borderColor: 'border-emerald-500/30', label: '전공' }
      case 'guide':
      case 'howto': return { icon: 'fa-lightbulb', color: 'text-amber-400', bgColor: 'bg-amber-500/10', borderColor: 'border-amber-500/30', label: 'HowTo' }
      default: return { icon: 'fa-file', color: 'text-wiki-muted', bgColor: 'bg-wiki-card/50', borderColor: 'border-wiki-border/40', label: '기타' }
    }
  }
  
  // slug에서 type prefix 제거하고 실제 URL path 생성
  const getCommentUrl = (pageType: string, slug: string) => {
    // slug가 "guide:some-slug" 또는 "job:some-slug" 형태로 저장됨
    const cleanSlug = slug.replace(/^(guide|job|major):/, '')
    // guide는 howto로 라우팅
    const urlPath = pageType === 'guide' ? 'howto' : pageType
    return `/${urlPath}/${cleanSlug}`
  }
  
  const innerContent = `
      <p class="text-wiki-muted mb-6">내가 작성한 댓글들을 확인합니다</p>
      
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4 overflow-x-auto">
        <a href="/user/comments?filter=all" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'all' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          전체 <span class="ml-1 opacity-70">(${allComments.length})</span>
        </a>
        <a href="/user/comments?filter=job" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'job' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-briefcase mr-1.5"></i>직업 <span class="ml-1 opacity-70">(${jobComments.length})</span>
        </a>
        <a href="/user/comments?filter=major" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'major' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-university mr-1.5"></i>전공 <span class="ml-1 opacity-70">(${majorComments.length})</span>
        </a>
        <a href="/user/comments?filter=howto" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'howto' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-lightbulb mr-1.5"></i>HowTo <span class="ml-1 opacity-70">(${guideComments.length})</span>
        </a>
      </div>
      
      ${filteredComments.length > 0 ? `
        <div class="space-y-4">
          ${filteredComments.map(comment => {
            const typeInfo = getTypeInfo(comment.page_type)
            const commentUrl = getCommentUrl(comment.page_type, comment.slug)
            return `
            <a href="${escapeHtml(commentUrl)}#comment-${comment.id}" 
               class="block p-4 bg-wiki-bg/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
              <div class="flex items-start justify-between gap-4 mb-2">
                <div class="flex items-center gap-2 min-w-0">
                  <span class="px-2 py-0.5 rounded-full text-xs ${typeInfo.bgColor} ${typeInfo.color} ${typeInfo.borderColor} border shrink-0">
                    <i class="fas ${typeInfo.icon} mr-1"></i>${typeInfo.label}
                  </span>
                  <span class="text-sm text-wiki-primary group-hover:underline truncate">
                    ${escapeHtml(comment.page_title || comment.slug.replace(/^(guide|job|major):/, ''))}
                  </span>
                </div>
                <span class="text-xs text-wiki-muted shrink-0">${formatDateSafe(comment.created_at)}</span>
              </div>
              <p class="text-wiki-text text-sm line-clamp-2">${escapeHtml(comment.content)}</p>
            </a>
          `}).join('')}
        </div>
      ` : `
        <div class="text-center py-16">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-bg/50 mb-4">
            <i class="fas fa-comments text-2xl text-wiki-muted"></i>
          </div>
          <h3 class="text-lg font-semibold text-white mb-2">
            ${filter === 'all' ? '작성한 댓글이 없습니다' : `작성한 ${filter === 'job' ? '직업' : filter === 'major' ? '전공' : 'HowTo'} 댓글이 없습니다`}
          </h3>
          <p class="text-wiki-muted">
            ${filter === 'all' 
              ? '직업, 전공, HowTo 페이지에서 댓글을 작성해보세요!' 
              : `${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : 'HowTo 가이드'}에서 댓글을 작성해보세요!`}
          </p>
          <div class="mt-4">
            <a href="/${filter === 'all' ? 'job' : (filter === 'howto' ? 'howto' : filter)}" class="inline-flex items-center gap-2 px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white rounded-lg text-sm transition">
              <i class="fas fa-arrow-right"></i>
              ${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : filter === 'howto' ? 'HowTo 가이드' : '직업위키'} 둘러보기
            </a>
          </div>
        </div>
      `}
  `
  
  const pageContent = renderUserLayoutContent({
    title: '작성 댓글',
    currentPath: '/user/comments',
    children: innerContent,
    username: user.username || user.email || `user_${user.id}`,
    pictureUrl: user.custom_picture_url || user.picture_url || null,
    role: user.role
  })
  
  return c.html(
    renderLayoutWithContext(c, pageContent, '작성 댓글 - 마이페이지 - Careerwiki', '내가 작성한 댓글')
  )
})


userRoutes.get('/user/bookmarks', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect('/login?redirect=/user/bookmarks')
  }
  
  const filter = c.req.query('filter') || 'all'
  
  // 저장된 항목 조회 (테이블이 없을 수 있음)
  let bookmarkList: Array<{ id: number; item_type: string; item_slug: string; item_title: string; created_at: string }> = []
  try {
    const bookmarks = await c.env.DB.prepare(`
      SELECT b.id, b.item_type, b.item_slug, b.item_title, b.created_at
      FROM user_bookmarks b
      WHERE b.user_id = ?
      ORDER BY b.created_at DESC
      LIMIT 100
    `).bind(user.id).all<{
      id: number; item_type: string; item_slug: string; item_title: string; created_at: string
    }>()
    bookmarkList = bookmarks.results || []
  } catch (e) {
    // 테이블이 없으면 빈 배열
  }
  
  // 타입별로 분류
  const jobs = bookmarkList.filter(b => b.item_type === 'job')
  const majors = bookmarkList.filter(b => b.item_type === 'major')
  const howtos = bookmarkList.filter(b => b.item_type === 'howto')
  
  // 필터 적용
  let filteredBookmarks = bookmarkList
  if (filter === 'job') filteredBookmarks = jobs
  else if (filter === 'major') filteredBookmarks = majors
  else if (filter === 'howto') filteredBookmarks = howtos
  
  // 타입에 따른 아이콘과 색상
  const getTypeInfo = (itemType: string) => {
    switch (itemType) {
      case 'job': return { icon: 'fa-briefcase', color: 'text-blue-400', bgColor: 'bg-blue-500/10', borderColor: 'border-blue-500/30', label: '직업', path: 'job' }
      case 'major': return { icon: 'fa-university', color: 'text-emerald-400', bgColor: 'bg-emerald-500/10', borderColor: 'border-emerald-500/30', label: '전공', path: 'major' }
      case 'howto': return { icon: 'fa-lightbulb', color: 'text-amber-400', bgColor: 'bg-amber-500/10', borderColor: 'border-amber-500/30', label: 'HowTo', path: 'howto' }
      default: return { icon: 'fa-file', color: 'text-wiki-muted', bgColor: 'bg-wiki-card/50', borderColor: 'border-wiki-border/40', label: '기타', path: '' }
    }
  }
  
  const innerContent = `
      <p class="text-wiki-muted mb-6">저장한 직업, 전공, HowTo를 확인합니다</p>
      
      <!-- 필터 탭 -->
      <div class="flex items-center gap-2 mb-6 border-b border-wiki-border/40 pb-4 overflow-x-auto">
        <a href="/user/bookmarks?filter=all" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'all' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          전체 <span class="ml-1 opacity-70">(${bookmarkList.length})</span>
        </a>
        <a href="/user/bookmarks?filter=job" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'job' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-briefcase mr-1.5"></i>직업 <span class="ml-1 opacity-70">(${jobs.length})</span>
        </a>
        <a href="/user/bookmarks?filter=major" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'major' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-university mr-1.5"></i>전공 <span class="ml-1 opacity-70">(${majors.length})</span>
        </a>
        <a href="/user/bookmarks?filter=howto" 
           class="px-4 py-2 rounded-lg text-sm font-medium transition whitespace-nowrap ${filter === 'howto' ? 'bg-wiki-primary text-white' : 'text-wiki-muted hover:bg-wiki-card/50'}">
          <i class="fas fa-lightbulb mr-1.5"></i>HowTo <span class="ml-1 opacity-70">(${howtos.length})</span>
        </a>
      </div>
      
      ${filteredBookmarks.length > 0 ? `
        <div class="space-y-4">
          ${filteredBookmarks.map(bookmark => {
            const typeInfo = getTypeInfo(bookmark.item_type)
            return `
            <a href="/${typeInfo.path}/${escapeHtml(bookmark.item_slug)}" 
               class="block p-4 bg-wiki-bg/50 border border-wiki-border/40 rounded-xl hover:border-wiki-primary/50 transition group">
              <div class="flex items-center sm:items-start justify-between gap-4">
                <div class="flex items-center gap-3 min-w-0">
                  <span class="px-2 py-0.5 rounded-full text-xs ${typeInfo.bgColor} ${typeInfo.color} ${typeInfo.borderColor} border shrink-0">
                    <i class="fas ${typeInfo.icon} mr-1"></i>${typeInfo.label}
                  </span>
                  <span class="text-wiki-text group-hover:text-wiki-primary transition truncate">
                    ${escapeHtml(bookmark.item_title)}
                  </span>
                </div>
                <div class="flex items-center gap-3 shrink-0">
                  <span class="text-xs text-wiki-muted">${new Date(Number(bookmark.created_at) * 1000).toLocaleDateString('ko-KR')}</span>
                  <i class="fas fa-chevron-right text-wiki-muted text-xs group-hover:text-wiki-primary transition"></i>
                </div>
              </div>
            </a>
          `}).join('')}
        </div>
      ` : `
        <div class="text-center py-16">
          <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-wiki-bg/50 mb-4">
            <i class="fas fa-bookmark text-2xl text-wiki-muted"></i>
          </div>
          <h3 class="text-lg font-semibold text-white mb-2">
            ${filter === 'all' ? '저장한 항목이 없습니다' : `저장한 ${filter === 'job' ? '직업' : filter === 'major' ? '전공' : 'HowTo'}이 없습니다`}
          </h3>
          <p class="text-wiki-muted">
            ${filter === 'all' 
              ? '직업, 전공, HowTo 페이지에서 북마크 버튼을 눌러 저장해보세요!' 
              : `${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : 'HowTo 가이드'}에서 북마크 버튼을 눌러 저장해보세요!`}
          </p>
          <div class="mt-4">
            <a href="/${filter === 'all' ? 'job' : filter}" class="inline-flex items-center gap-2 px-4 py-2 bg-wiki-primary hover:bg-wiki-primary/90 text-white rounded-lg text-sm transition">
              <i class="fas fa-arrow-right"></i>
              ${filter === 'job' ? '직업위키' : filter === 'major' ? '전공위키' : filter === 'howto' ? 'HowTo 가이드' : '직업위키'} 둘러보기
            </a>
          </div>
        </div>
      `}
  `
  
  const pageContent = renderUserLayoutContent({
    title: '저장함',
    currentPath: '/user/bookmarks',
    children: innerContent,
    username: user.username || user.email || `user_${user.id}`,
    pictureUrl: user.custom_picture_url || user.picture_url || null,
    role: user.role
  })
  
  return c.html(
    renderLayoutWithContext(c, pageContent, '저장함 - 마이페이지 - Careerwiki', '저장한 직업, 전공, HowTo')
  )
})

// ============================================================================
// 북마크 API (저장 토글)
// ============================================================================


userRoutes.get('/api/bookmark/:type/:slug', async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ saved: false, error: 'not_logged_in' })
  }
  
  const { type, slug } = c.req.param()
  if (!['job', 'major', 'howto'].includes(type)) {
    return c.json({ saved: false, error: 'invalid_type' }, 400)
  }
  
  try {
    const existing = await c.env.DB.prepare(`
      SELECT id FROM user_bookmarks WHERE user_id = ? AND item_type = ? AND item_slug = ?
    `).bind(user.id, type, slug).first()
    
    return c.json({ saved: !!existing })
  } catch (e) {
    return c.json({ saved: false, error: 'db_error' }, 500)
  }
})

// 북마크 토글 API (저장/해제)
userRoutes.post('/api/bookmark', async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'not_logged_in', message: '로그인이 필요합니다' }, 401)
  }
  
  let body: { type: string; slug: string; title?: string }
  try {
    body = await c.req.json()
  } catch {
    return c.json({ success: false, error: 'invalid_body' }, 400)
  }
  
  const { type, slug, title } = body
  if (!type || !slug) {
    return c.json({ success: false, error: 'missing_params' }, 400)
  }
  if (!['job', 'major', 'howto'].includes(type)) {
    return c.json({ success: false, error: 'invalid_type' }, 400)
  }
  
  try {
    // 기존 북마크 확인
    const existing = await c.env.DB.prepare(`
      SELECT id FROM user_bookmarks WHERE user_id = ? AND item_type = ? AND item_slug = ?
    `).bind(user.id, type, slug).first<{ id: number }>()
    
    if (existing) {
      // 이미 저장됨 -> 삭제 (토글)
      await c.env.DB.prepare(`
        DELETE FROM user_bookmarks WHERE id = ?
      `).bind(existing.id).run()
      
      return c.json({ success: true, saved: false, message: '저장 해제되었습니다' })
    } else {
      // 저장되지 않음 -> 추가
      await c.env.DB.prepare(`
        INSERT INTO user_bookmarks (user_id, item_type, item_slug, item_title)
        VALUES (?, ?, ?, ?)
      `).bind(user.id, type, slug, title || null).run()
      
      return c.json({ success: true, saved: true, message: '저장되었습니다' })
    }
  } catch (e) {
    return c.json({ success: false, error: 'db_error' }, 500)
  }
})

// ===== 프로필 이미지 업로드 API =====
// POST /api/user/profile-image - 프로필 이미지 업로드

userRoutes.post('/api/user/profile-image', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'unauthorized' }, 401)
  }
  
  try {
    const formData = await c.req.formData()
    const file = formData.get('image') as File | null
    
    if (!file) {
      return c.json({ success: false, error: '이미지 파일이 필요합니다' }, 400)
    }
    
    // 파일 검증
    const { validateContentType, validateFileSize, validateMagicNumber, uploadToR2 } = await import('../services/uploadService')
    
    const typeResult = validateContentType(file.type)
    if (!typeResult.valid) {
      return c.json({ success: false, error: typeResult.error }, 400)
    }
    
    // 프로필 이미지는 2MB로 제한
    const MAX_PROFILE_SIZE = 2 * 1024 * 1024
    if (file.size > MAX_PROFILE_SIZE) {
      return c.json({ success: false, error: '프로필 이미지는 2MB를 초과할 수 없습니다' }, 400)
    }
    
    const sizeResult = validateFileSize(file.size)
    if (!sizeResult.valid) {
      return c.json({ success: false, error: sizeResult.error }, 400)
    }
    
    // 매직 넘버 검증
    const buffer = await file.arrayBuffer()
    if (!validateMagicNumber(buffer, file.type)) {
      return c.json({ success: false, error: '유효하지 않은 이미지 파일입니다' }, 400)
    }
    
    // 파일 키 생성 (profile/userId/timestamp.ext)
    const now = new Date()
    const timestamp = now.getTime()
    const ext = typeResult.ext || 'jpg'
    const fileKey = `profile/${user.id}/${timestamp}.${ext}`
    
    // R2에 업로드
    const uploadResult = await uploadToR2(
      c.env.UPLOADS,
      fileKey,
      buffer,
      file.type,
      { userId: String(user.id), type: 'profile' }
    )
    
    if (!uploadResult.success) {
      return c.json({ success: false, error: uploadResult.error || '업로드 실패' }, 500)
    }
    
    // 공개 URL 생성
    const publicUrl = `/uploads/${fileKey}`
    
    // DB 업데이트
    await c.env.DB.prepare(`
      UPDATE users SET custom_picture_url = ?, updated_at = ? WHERE id = ?
    `).bind(publicUrl, Math.floor(Date.now() / 1000), user.id).run()
    
    return c.json({ 
      success: true, 
      url: publicUrl,
      message: '프로필 이미지가 업데이트되었습니다' 
    })
  } catch (e) {
    return c.json({ success: false, error: '업로드 중 오류가 발생했습니다' }, 500)
  }
})

// DELETE /api/user/profile-image - 프로필 이미지 초기화 (기본 아이콘으로)
userRoutes.delete('/api/user/profile-image', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.json({ success: false, error: 'unauthorized' }, 401)
  }
  
  try {
    // 기존 custom_picture_url이 있으면 R2에서 삭제 시도 (선택적)
    if (user.custom_picture_url && user.custom_picture_url.startsWith('/uploads/')) {
      const fileKey = user.custom_picture_url.replace('/uploads/', '')
      const { deleteFromR2 } = await import('../services/uploadService')
      await deleteFromR2(c.env.UPLOADS, fileKey).catch(() => {})
    }
    
    // DB에서 custom_picture_url 제거
    await c.env.DB.prepare(`
      UPDATE users SET custom_picture_url = NULL, updated_at = ? WHERE id = ?
    `).bind(Math.floor(Date.now() / 1000), user.id).run()
    
    return c.json({ 
      success: true, 
      message: '프로필 이미지가 기본으로 초기화되었습니다' 
    })
  } catch (e) {
    return c.json({ success: false, error: '초기화 중 오류가 발생했습니다' }, 500)
  }
})


userRoutes.get('/api/user/sessions', requireAuth, async (c) => {
  const user = c.get('user')
  const currentToken = c.get('sessionToken')
  if (!user) return c.json({ error: 'unauthorized' }, 401)

  try {
    const sessions = await listUserSessions(c.env.KV, user.id, currentToken || undefined)
    return c.json({ sessions })
  } catch (e) {
    return c.json({ sessions: [], error: 'Failed to load sessions' }, 200)
  }
})

// DELETE /api/user/sessions/:prefix - 특정 세션 로그아웃
userRoutes.delete('/api/user/sessions/:prefix', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) return c.json({ error: 'unauthorized' }, 401)

  const prefix = c.req.param('prefix')
  const entries = await getUserSessionEntries(c.env.KV, user.id)
  const target = entries.find(s => s.token.substring(0, 8) === prefix)
  if (!target) return c.json({ error: 'Session not found' }, 404)

  // 현재 세션은 삭제 불가
  const currentToken = c.get('sessionToken')
  if (currentToken === target.token) {
    return c.json({ error: 'Cannot delete current session. Use logout instead.' }, 400)
  }

  await destroySession(c.env.KV, c.env.DB, target.token, 'user_logout', user.id)
  return c.json({ success: true })
})

// POST /api/user/sessions/logout-others - 다른 기기 전체 로그아웃
userRoutes.post('/api/user/sessions/logout-others', requireAuth, async (c) => {
  const user = c.get('user')
  const currentToken = c.get('sessionToken')
  if (!user) return c.json({ error: 'unauthorized' }, 401)

  const entries = await getUserSessionEntries(c.env.KV, user.id)
  if (entries.length === 0) return c.json({ success: true, destroyed: 0 })

  const others = entries.filter(s => s.token !== currentToken)
  if (others.length === 0) return c.json({ success: true, destroyed: 0 })

  // 세션 KV만 직접 삭제 (destroySession N번 호출 대신 병렬 삭제)
  await Promise.all(others.map(s => c.env.KV.delete(`session:${s.token}`)))

  // 인덱스를 현재 세션만 남긴 것으로 갱신
  const current = entries.find(s => s.token === currentToken)
  if (current) {
    await c.env.KV.put(
      `user-sessions:${user.id}`,
      JSON.stringify({ sessions: [current] }),
      { expirationTtl: 30 * 24 * 60 * 60 }
    )
  } else {
    await c.env.KV.delete(`user-sessions:${user.id}`)
  }

  // 감사 로그 일괄 업데이트 (비차단)
  c.executionCtx.waitUntil(
    c.env.DB.prepare(`
      UPDATE user_sessions SET expired_at = ?, logout_reason = ? WHERE user_id = ? AND expired_at IS NULL
    `).bind(Math.floor(Date.now() / 1000), 'all_devices_logout', user.id).run().catch(() => {})
  )

  return c.json({ success: true, destroyed: others.length })
})

userRoutes.get('/user/settings', requireAuth, async (c) => {
  const user = c.get('user')
  if (!user) {
    return c.redirect(`/login?redirect=${encodeURIComponent(c.req.path + c.req.query())}`)
  }
  
  const userData = {
    id: user.id,
    name: user.name,
    email: user.email,
    username: user.username,
    picture_url: user.picture_url,
    custom_picture_url: user.custom_picture_url,
    role: user.role,
    created_at: user.created_at
  }
  
  // 프로필 이미지 우선순위: custom > OAuth > 기본 아이콘
  const profileImageUrl = userData.custom_picture_url || userData.picture_url || null
  
  const innerContent = `
      <div class="space-y-6">
        <!-- 프로필 정보 섹션 -->
        <div class="bg-wiki-bg/50 p-6 rounded-xl border border-wiki-border">
          <h2 class="text-xl font-semibold mb-4 text-wiki-text">
            <i class="fas fa-user mr-2 text-wiki-primary"></i>프로필 정보
          </h2>
          
          <div class="space-y-4">
            <!-- 프로필 사진 -->
            <div class="flex items-start gap-4">
              <div class="relative group">
                <div 
                  id="profile-image-container"
                  class="w-20 h-20 rounded-full overflow-hidden border-2 border-wiki-border cursor-pointer hover:border-wiki-primary transition-colors"
                  title="클릭하여 프로필 이미지 변경"
                >
                  ${profileImageUrl ? `
                    <img 
                      id="profile-image"
                      src="${profileImageUrl}" 
                      alt="${userData.name || 'User'}"
                      class="w-full h-full object-cover"
                    />
                  ` : `
                    <div id="profile-image" class="w-full h-full bg-wiki-card flex items-center justify-center">
                      <i class="fas fa-user-circle text-4xl text-wiki-muted"></i>
                    </div>
                  `}
                  <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center rounded-full">
                    <i class="fas fa-camera text-white text-xl"></i>
                  </div>
                </div>
                <input 
                  type="file" 
                  id="profile-image-input" 
                  accept="image/jpeg,image/png,image/gif,image/webp"
                  class="hidden"
                />
              </div>
              <div class="flex-1 space-y-2">
                <p class="text-sm text-wiki-text font-medium">프로필 사진</p>
                <p class="text-xs text-wiki-muted">이미지를 클릭하여 변경하세요. (최대 2MB, JPG/PNG/GIF/WEBP)</p>
                <div class="flex flex-wrap gap-2 mt-2">
                  <button 
                    id="profile-image-upload-btn"
                    type="button"
                    class="px-4 py-2.5 min-h-[44px] text-sm bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition-colors"
                  >
                    <i class="fas fa-upload mr-1.5"></i>이미지 변경
                  </button>
                  ${userData.custom_picture_url ? `
                    <button 
                      id="profile-image-reset-btn"
                      type="button"
                      class="px-4 py-2.5 min-h-[44px] text-sm bg-wiki-card border border-wiki-border text-wiki-text rounded-lg hover:bg-wiki-bg transition-colors"
                    >
                      <i class="fas fa-undo mr-1.5"></i>기본으로 초기화
                    </button>
                  ` : ''}
                </div>
                <div id="profile-image-status" class="text-xs mt-2 hidden"></div>
              </div>
            </div>
            
            <!-- 이메일 (테스트 계정은 숨김) -->
            ${user.google_id !== 'test-account' ? `
            <div>
              <label class="block text-sm font-medium text-wiki-text mb-2">이메일</label>
              <div class="px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text">
                ${userData.email}
              </div>
              <p class="text-xs text-wiki-muted mt-1">Google 계정 이메일입니다.</p>
            </div>
            ` : ''}
          </div>
        </div>
        
        <!-- 계정 설정 섹션 -->
        <div class="bg-wiki-bg/50 p-6 rounded-xl border border-wiki-border">
          <h2 class="text-xl font-semibold mb-4 text-wiki-text">
            <i class="fas fa-id-card mr-2 text-wiki-primary"></i>계정 설정
          </h2>
          
          <div class="space-y-4">
            <!-- 사용자 아이디 변경 -->
            <div>
              <label for="username" class="block text-sm font-medium text-wiki-text mb-2">
                사용자 아이디 (닉네임)
              </label>
              <form id="username-form" class="flex flex-col sm:flex-row gap-2">
                <input
                  type="text"
                  id="username"
                  name="username"
                  value="${userData.username || ''}"
                  placeholder="user_abc123"
                  pattern="[a-z0-9_]{3,20}"
                  class="flex-1 px-4 py-3 min-h-[48px] bg-wiki-card border border-wiki-border rounded-lg text-wiki-text focus:outline-none focus:border-wiki-primary focus:ring-1 focus:ring-wiki-primary"
                  style="font-size: 16px;"
                  required
                />
                <button
                  type="submit"
                  class="px-6 py-3 min-h-[48px] bg-wiki-primary text-white rounded-lg hover:bg-blue-600 transition-colors font-medium"
                >
                  변경
                </button>
              </form>
              <p class="text-xs text-wiki-muted mt-2">
                3-20자, 영문 소문자, 숫자, 언더스코어(_)만 사용 가능합니다.
              </p>
              <div id="username-message" class="mt-2 text-sm hidden"></div>
            </div>
            
            <!-- 가입일 -->
            <div>
              <label class="block text-sm font-medium text-wiki-text mb-2">가입일</label>
              <div class="px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text">
                ${userData.created_at ? new Date(Number(userData.created_at) * 1000).toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }) : '알 수 없음'}
              </div>
            </div>
            
            <!-- 역할 -->
            <div>
              <label class="block text-sm font-medium text-wiki-text mb-2">역할</label>
              <div class="px-4 py-2 bg-wiki-card border border-wiki-border rounded-lg text-wiki-text">
                ${userData.role === 'admin' ? '관리자' : userData.role === 'expert' ? '전문가' : '일반 사용자'}
              </div>
            </div>
          </div>
        </div>
        
        <!-- 보안 섹션: 세션 관리 -->
        ${renderSecurityPage()}
      </div>
    </div>
    
    <script>
      (function() {
        const form = document.getElementById('username-form');
        const input = document.getElementById('username');
        const message = document.getElementById('username-message');
        
        if (!form || !input || !message) return;
        
        form.addEventListener('submit', async (e) => {
          e.preventDefault();
          
          const newUsername = input.value.trim().toLowerCase();
          
          // 클라이언트 측 유효성 검사
          if (!/^[a-z0-9_]{3,20}$/.test(newUsername)) {
            message.className = 'mt-2 text-sm text-red-400';
            message.textContent = '사용자 아이디는 3-20자의 영문 소문자, 숫자, 언더스코어만 사용할 수 있습니다.';
            message.classList.remove('hidden');
            return;
          }
          
          // 버튼 비활성화
          const submitBtn = form.querySelector('button[type="submit"]');
          if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.textContent = '변경 중...';
          }
          
          try {
            const response = await fetch('/api/user/username', {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json'
              },
              body: JSON.stringify({ username: newUsername })
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
              message.className = 'mt-2 text-sm text-green-400';
              message.textContent = '사용자 아이디가 변경되었습니다.';
              message.classList.remove('hidden');
              
              // 페이지 새로고침
              setTimeout(() => {
                window.location.reload();
              }, 1000);
            } else {
              message.className = 'mt-2 text-sm text-red-400';
              message.textContent = data.error || '사용자 아이디 변경에 실패했습니다.';
              message.classList.remove('hidden');
            }
          } catch (error) {
            message.className = 'mt-2 text-sm text-red-400';
            message.textContent = '네트워크 오류가 발생했습니다.';
            message.classList.remove('hidden');
          } finally {
            if (submitBtn) {
              submitBtn.disabled = false;
              submitBtn.textContent = '변경';
            }
          }
        });
      })();
      
      // 프로필 이미지 업로드 스크립트
      (function() {
        const container = document.getElementById('profile-image-container');
        const imageInput = document.getElementById('profile-image-input');
        const uploadBtn = document.getElementById('profile-image-upload-btn');
        const resetBtn = document.getElementById('profile-image-reset-btn');
        const status = document.getElementById('profile-image-status');
        
        if (!container || !imageInput) return;
        
        // 이미지 컨테이너 클릭 시 파일 선택
        container.addEventListener('click', () => imageInput.click());
        if (uploadBtn) {
          uploadBtn.addEventListener('click', () => imageInput.click());
        }
        
        // 파일 선택 시 업로드
        imageInput.addEventListener('change', async (e) => {
          const file = e.target.files[0];
          if (!file) return;
          
          // 파일 크기 검증 (2MB)
          if (file.size > 2 * 1024 * 1024) {
            showStatus('프로필 이미지는 2MB를 초과할 수 없습니다', 'error');
            return;
          }
          
          // 파일 형식 검증
          const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
          if (!allowedTypes.includes(file.type)) {
            showStatus('지원하지 않는 파일 형식입니다 (JPG/PNG/GIF/WEBP만 가능)', 'error');
            return;
          }
          
          showStatus('업로드 중...', 'loading');
          
          try {
            const formData = new FormData();
            formData.append('image', file);
            
            const response = await fetch('/api/user/profile-image', {
              method: 'POST',
              body: formData
            });
            
            const data = await response.json();
            
            if (response.ok && data.success) {
              showStatus('프로필 이미지가 업데이트되었습니다', 'success');
              // 페이지 새로고침하여 새 이미지 표시
              setTimeout(() => window.location.reload(), 1000);
            } else {
              showStatus(data.error || '업로드에 실패했습니다', 'error');
            }
          } catch (error) {
            showStatus('네트워크 오류가 발생했습니다', 'error');
          }
          
          // 입력 초기화
          imageInput.value = '';
        });
        
        // 초기화 버튼
        if (resetBtn) {
          resetBtn.addEventListener('click', async () => {
            if (!confirm('프로필 이미지를 기본으로 초기화하시겠습니까?')) return;
            
            showStatus('초기화 중...', 'loading');
            
            try {
              const response = await fetch('/api/user/profile-image', {
                method: 'DELETE'
              });
              
              const data = await response.json();
              
              if (response.ok && data.success) {
                showStatus('기본 이미지로 초기화되었습니다', 'success');
                setTimeout(() => window.location.reload(), 1000);
              } else {
                showStatus(data.error || '초기화에 실패했습니다', 'error');
              }
            } catch (error) {
              showStatus('네트워크 오류가 발생했습니다', 'error');
            }
          });
        }
        
        function showStatus(message, type) {
          if (!status) return;
          status.classList.remove('hidden', 'text-green-400', 'text-red-400', 'text-wiki-muted');
          if (type === 'success') {
            status.className = 'text-xs mt-2 text-green-400';
          } else if (type === 'error') {
            status.className = 'text-xs mt-2 text-red-400';
          } else {
            status.className = 'text-xs mt-2 text-wiki-muted';
          }
          status.textContent = message;
        }
      })();
    </script>
  `
  
  const pageContent = renderUserLayoutContent({
    title: '개인 설정',
    currentPath: '/user/settings',
    children: innerContent,
    username: user.username || user.email || `user_${user.id}`,
    pictureUrl: user.custom_picture_url || user.picture_url || null,
    role: user.role
  })
  
  return c.html(renderLayoutWithContext(c,
    pageContent,
    '개인 설정 - 마이페이지 - Careerwiki',
    '계정 설정 및 프로필 관리',
    false,
    { user: userData }
  ))
})

// /user/security → /user/settings 리다이렉트 (하위 호환)
userRoutes.get('/user/security', (c) => c.redirect('/user/settings', 301))
