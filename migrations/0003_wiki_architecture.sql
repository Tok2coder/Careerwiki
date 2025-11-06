-- ============================================
-- CareerWiki Phase 0.2: Wiki Architecture Migration
-- Created: 2025-01-06
-- Purpose: Add static wiki page tables for Phase 2+ implementation
-- ============================================

-- This migration adds new tables for static wiki architecture WITHOUT modifying
-- existing majors/jobs tables. Both architectures will coexist during Phase 1-2.

-- Note: Foreign keys will be automatically enforced by Cloudflare D1

-- ============================================
-- 1. Wiki Pages Main Table (Pre-rendered HTML)
-- ============================================

CREATE TABLE IF NOT EXISTS wiki_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- Basic info
  slug TEXT UNIQUE NOT NULL,                      -- URL slug (e.g., "컴퓨터공학과")
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
  title TEXT NOT NULL,                            -- Page title
  
  -- Complete HTML content (final rendered version)
  content TEXT NOT NULL,                          -- Full HTML page
  
  -- Section metadata (JSON)
  -- Tracks data source and last update time for each section
  -- Example: {
  --   "overview": { "source": "API", "last_updated": 1234567890 },
  --   "universities": { "source": "API", "last_updated": 1234567890 },
  --   "reviews": { "source": "USER", "last_updated": 1234567890 },
  --   "career_path": { "source": "AI", "last_updated": 1234567890 }
  -- }
  sections_meta TEXT,
  
  -- Source data references (for quick regeneration)
  careernet_id TEXT,
  goyong24_id TEXT,
  
  -- SEO & metadata
  meta_title TEXT,
  meta_description TEXT,
  canonical_url TEXT,
  
  -- Version control
  version INTEGER DEFAULT 1,
  
  -- Statistics
  view_count INTEGER DEFAULT 0,
  contribution_count INTEGER DEFAULT 0,           -- User contribution count
  
  -- Status
  status TEXT DEFAULT 'published' CHECK(status IN ('published', 'draft', 'archived')),
  
  -- Timestamps
  created_at INTEGER NOT NULL,                    -- Unix timestamp
  updated_at INTEGER NOT NULL,                    -- Unix timestamp
  last_api_sync_at INTEGER,                       -- Last API sync time
  
  -- Indexes
  UNIQUE(slug)
);

CREATE INDEX IF NOT EXISTS idx_wiki_pages_type ON wiki_pages(page_type);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_status ON wiki_pages(status);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_updated ON wiki_pages(updated_at);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_careernet ON wiki_pages(careernet_id);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_goyong24 ON wiki_pages(goyong24_id);

-- ============================================
-- 2. User Contributions Table
-- ============================================

CREATE TABLE IF NOT EXISTS user_contributions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,                     -- e.g., "reviews", "tips", "courses"
  
  -- Contribution content
  contribution_type TEXT NOT NULL CHECK(contribution_type IN (
    'review',           -- Graduate review
    'tip',             -- Study tip
    'course',          -- Course recommendation
    'resource',        -- Resource recommendation
    'correction',      -- Information correction
    'addition'         -- Information addition
  )),
  
  content TEXT NOT NULL,                          -- Contribution content (Markdown)
  
  -- Contributor info
  user_id INTEGER,                                -- Logged-in user (future)
  user_nickname TEXT DEFAULT '익명',
  user_ip_hash TEXT,                              -- For anonymous tracking
  
  -- Status
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending',         -- Awaiting review
    'approved',        -- Approved
    'rejected',        -- Rejected
    'archived'         -- Archived
  )),
  
  -- Voting
  upvotes INTEGER DEFAULT 0,
  downvotes INTEGER DEFAULT 0,
  
  -- Admin review
  reviewed_by INTEGER,                            -- Admin ID
  review_note TEXT,
  reviewed_at INTEGER,
  
  -- Timestamps
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
  
  -- Note: Foreign key constraint removed for D1 compatibility
  -- Application code should handle referential integrity
);

CREATE INDEX IF NOT EXISTS idx_contributions_page ON user_contributions(page_slug);
CREATE INDEX IF NOT EXISTS idx_contributions_status ON user_contributions(status);
CREATE INDEX IF NOT EXISTS idx_contributions_type ON user_contributions(contribution_type);
CREATE INDEX IF NOT EXISTS idx_contributions_user ON user_contributions(user_id);
CREATE INDEX IF NOT EXISTS idx_contributions_created ON user_contributions(created_at DESC);

-- ============================================
-- 3. AI Generated Content Table
-- ============================================

CREATE TABLE IF NOT EXISTS ai_generated_content (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  section_name TEXT NOT NULL,                     -- e.g., "career_path", "skills", "salary_forecast"
  
  -- AI generated content
  content_type TEXT NOT NULL CHECK(content_type IN (
    'career_path',     -- AI-generated career path
    'skills',          -- AI-recommended skills
    'salary_forecast', -- AI salary prediction
    'job_outlook',     -- AI job outlook
    'study_plan'       -- AI study plan
  )),
  
  content TEXT NOT NULL,                          -- Generated content (HTML/Markdown)
  
  -- AI metadata
  model TEXT NOT NULL,                            -- e.g., "claude-3-haiku", "gpt-4"
  prompt_hash TEXT,                               -- Prompt hash (for regeneration detection)
  confidence_score REAL,                          -- Confidence (0.0 ~ 1.0)
  
  -- Verification status
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending',         -- Awaiting review
    'approved',        -- Approved
    'rejected',        -- Rejected
    'regenerating'     -- Regenerating
  )),
  
  verified_by INTEGER,                            -- Admin ID
  verified_at INTEGER,
  
  -- Timestamps
  generated_at INTEGER NOT NULL,
  expires_at INTEGER                              -- Regeneration trigger time
  
  -- Note: Foreign key constraint removed for D1 compatibility
);

CREATE INDEX IF NOT EXISTS idx_ai_content_page ON ai_generated_content(page_slug);
CREATE INDEX IF NOT EXISTS idx_ai_content_status ON ai_generated_content(status);
CREATE INDEX IF NOT EXISTS idx_ai_content_expires ON ai_generated_content(expires_at);
CREATE INDEX IF NOT EXISTS idx_ai_content_type ON ai_generated_content(content_type);

-- ============================================
-- 4. Page Revisions Table (Audit log)
-- ============================================

CREATE TABLE IF NOT EXISTS page_revisions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  version INTEGER NOT NULL,
  
  -- Change info
  change_type TEXT NOT NULL CHECK(change_type IN (
    'api_sync',        -- API data sync
    'user_contribution',  -- User contribution applied
    'ai_generation',   -- AI content added
    'admin_edit',      -- Admin edit
    'template_update'  -- Template update
  )),
  
  sections_changed TEXT,                          -- Changed section list (JSON array)
  
  -- Previous content (for rollback if needed)
  previous_content TEXT,
  
  -- Changer info
  changed_by TEXT,                                -- "API", "USER:123", "AI", "ADMIN:456"
  change_summary TEXT,
  
  -- Timestamp
  created_at INTEGER NOT NULL
  
  -- Note: Foreign key constraint removed for D1 compatibility
);

CREATE INDEX IF NOT EXISTS idx_revisions_page ON page_revisions(page_slug, version);
CREATE INDEX IF NOT EXISTS idx_revisions_type ON page_revisions(change_type);
CREATE INDEX IF NOT EXISTS idx_revisions_created ON page_revisions(created_at DESC);

-- ============================================
-- 5. Page Update Queue (Async processing)
-- ============================================

CREATE TABLE IF NOT EXISTS page_update_queue (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  page_slug TEXT NOT NULL,
  update_type TEXT NOT NULL CHECK(update_type IN (
    'api_sync',
    'user_contribution',
    'ai_generation',
    'template_refresh'
  )),
  
  -- Sections to update
  sections_to_update TEXT,                        -- JSON array
  
  -- Priority
  priority INTEGER DEFAULT 5,                     -- 1 (highest) ~ 10 (lowest)
  
  -- Status
  status TEXT DEFAULT 'pending' CHECK(status IN (
    'pending',
    'processing',
    'completed',
    'failed'
  )),
  
  -- Processing info
  attempts INTEGER DEFAULT 0,
  last_error TEXT,
  
  -- Timestamps
  created_at INTEGER NOT NULL,
  started_at INTEGER,
  completed_at INTEGER
  
  -- Note: Foreign key constraint removed for D1 compatibility
);

CREATE INDEX IF NOT EXISTS idx_update_queue_status ON page_update_queue(status, priority);
CREATE INDEX IF NOT EXISTS idx_update_queue_created ON page_update_queue(created_at);

-- ============================================
-- 6. Users Table (Placeholder for Phase 3)
-- ============================================

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- Authentication
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT,                             -- For local auth (optional)
  
  -- OAuth providers (future)
  oauth_provider TEXT,                            -- 'google', 'github', etc.
  oauth_id TEXT,
  
  -- User info
  nickname TEXT NOT NULL,
  profile_image_url TEXT,
  
  -- Role
  role TEXT DEFAULT 'user' CHECK(role IN ('user', 'moderator', 'admin')),
  
  -- Status
  status TEXT DEFAULT 'active' CHECK(status IN ('active', 'suspended', 'deleted')),
  
  -- Timestamps
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  last_login_at INTEGER,
  
  UNIQUE(email)
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_oauth ON users(oauth_provider, oauth_id);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- ============================================
-- Migration Notes:
-- ============================================

-- 1. Existing tables (majors, jobs) remain unchanged
-- 2. Wiki architecture will be populated in Phase 2
-- 3. Users table is prepared but won't be used until Phase 3
-- 4. All new tables use Unix timestamps for consistency
-- 5. Foreign keys removed for D1 compatibility (app handles integrity)
-- 6. Comprehensive indexes added for query performance

-- Migration complete. Wrangler automatically tracks migration status.
