PRAGMA defer_foreign_keys=TRUE;
CREATE TABLE IF NOT EXISTS d1_migrations(
		id         INTEGER PRIMARY KEY AUTOINCREMENT,
		name       TEXT UNIQUE,
		applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  parent_id INTEGER, 
  nickname TEXT DEFAULT '익명',
  content TEXT NOT NULL,
  ip_hash TEXT,
  likes INTEGER DEFAULT 0,
  flagged BOOLEAN DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP, author_id TEXT, is_anonymous INTEGER DEFAULT 0 CHECK(is_anonymous IN (0, 1)), display_ip TEXT, status TEXT DEFAULT 'visible' CHECK(status IN ('visible', 'blinded', 'deleted')), dislike_count INTEGER DEFAULT 0, report_count INTEGER DEFAULT 0, password_hash TEXT, anonymous_number INTEGER, is_edited INTEGER DEFAULT 0 CHECK(is_edited IN (0, 1)), edited_at DATETIME, mentions TEXT, depth INTEGER DEFAULT 0, moderated INTEGER DEFAULT 0, original_content TEXT,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
  FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS career_analyses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_email TEXT,
  user_name TEXT,
  analysis_data TEXT NOT NULL, 
  report_type TEXT CHECK(report_type IN ('basic', 'professional', 'premium')),
  payment_status TEXT DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS search_index (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  content TEXT NOT NULL, 
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS ai_sessions (
  id TEXT PRIMARY KEY,
  user_identifier TEXT, 
  traits_snapshot TEXT, 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  last_active_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS serp_interaction_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major')),
  action TEXT NOT NULL, 
  keyword_length INTEGER,
  category TEXT,
  per_page INTEGER,
  results INTEGER,
  cache_status TEXT,
  duration_ms INTEGER,
  sampled BOOLEAN DEFAULT 1,
  source TEXT DEFAULT 'hydration',
  recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS serp_interaction_daily_summary (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  log_date TEXT NOT NULL, 
  page_type TEXT NOT NULL,
  action TEXT NOT NULL,
  samples INTEGER DEFAULT 0,
  avg_duration_ms REAL,
  avg_results REAL,
  cache_hit_ratio REAL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(log_date, page_type, action)
);
CREATE TABLE IF NOT EXISTS comment_votes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  vote INTEGER NOT NULL CHECK(vote IN (-1, 1)),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, ip_hash TEXT, is_anonymous INTEGER DEFAULT 0 CHECK(is_anonymous IN (0, 1)),
  UNIQUE(comment_id, user_id),
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS comment_reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_id INTEGER NOT NULL,
  reporter_id TEXT NOT NULL,
  reporter_ip_hash TEXT,
  reason TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS ip_blocks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ip_hash TEXT NOT NULL UNIQUE,
  reason TEXT,
  status TEXT DEFAULT 'active' CHECK(status IN ('active', 'released')),
  blocked_by TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  released_at DATETIME
);
CREATE TABLE IF NOT EXISTS wiki_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  
  slug TEXT NOT NULL,                     
  page_type TEXT NOT NULL                 
    CHECK(page_type IN ('job', 'major', 'guide')),
  
  
  content TEXT NOT NULL,                  
  cache_version INTEGER NOT NULL,         
  
  
  title TEXT NOT NULL,                    
  description TEXT,                       
  og_image_url TEXT,                      
  
  
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),  
  updated_at INTEGER NOT NULL DEFAULT (unixepoch()),  
  
  
  UNIQUE(slug, page_type)                 
);
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  google_id TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  name TEXT,
  picture_url TEXT,
  role TEXT DEFAULT 'user' CHECK(role IN ('user', 'expert', 'admin')),
  
  
  edit_count INTEGER DEFAULT 0,
  comment_count INTEGER DEFAULT 0,
  
  
  is_banned INTEGER DEFAULT 0,  
  ban_reason TEXT,
  banned_until INTEGER,  
  
  
  last_login_at INTEGER,
  created_at INTEGER DEFAULT (strftime('%s','now')),
  updated_at INTEGER DEFAULT (strftime('%s','now'))
, username TEXT, provider TEXT DEFAULT 'google', provider_user_id TEXT, onboarded INTEGER DEFAULT 0, custom_picture_url TEXT);
CREATE TABLE IF NOT EXISTS anonymous_comment_counters (
  page_id INTEGER NOT NULL PRIMARY KEY,
  next_number INTEGER DEFAULT 1,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS anonymous_daily_limits (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  ip_hash TEXT NOT NULL,
  date DATE NOT NULL,
  count INTEGER DEFAULT 1,
  UNIQUE(page_id, ip_hash, date),
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS anonymous_edit_limits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'howto')),
    entity_id TEXT NOT NULL,
    ip_hash TEXT NOT NULL,
    edit_date TEXT NOT NULL,  
    edit_count INTEGER DEFAULT 0,
    last_edit_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(entity_type, entity_id, ip_hash, edit_date)
);
CREATE TABLE IF NOT EXISTS IF NOT EXISTS "page_revisions" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER,  
  entity_type TEXT CHECK(entity_type IN ('job', 'major', 'howto', 'guide')),
  entity_id TEXT,
  revision_number INTEGER,
  is_current INTEGER DEFAULT 0 CHECK(is_current IN (0, 1)),
  editor_id TEXT,
  editor_type TEXT CHECK(editor_type IN ('anonymous', 'user', 'expert', 'admin', 'system')),
  editor_name TEXT,
  password_hash TEXT,
  anonymous_number INTEGER,
  ip_hash TEXT,
  change_type TEXT CHECK(change_type IN ('initial', 'edit', 'restore', 'merge')),
  change_summary TEXT,
  changed_fields TEXT,
  data_snapshot TEXT,
  source_url TEXT,
  source_type TEXT CHECK(source_type IN ('website', 'academic', 'government', 'news', 'other')),
  content TEXT NOT NULL DEFAULT '',
  editor_ip TEXT,
  user_id TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS job_sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT,
    source_system TEXT NOT NULL CHECK(source_system IN ('CAREERNET', 'WORK24_JOB', 'WORK24_DJOB')),
    source_key TEXT NOT NULL,
    source_type TEXT CHECK(source_type IN ('LIST', 'DETAIL', 'ENCYCLOPEDIA', 'DICTIONARY')),
    std_job_cd TEXT,
    keco_cd TEXT,
    ksoc_cd TEXT,
    industry_cd TEXT,
    raw_payload TEXT NOT NULL,
    normalized_payload TEXT NOT NULL,
    fetched_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    last_error TEXT,
    retry_count INTEGER DEFAULT 0,
    UNIQUE(source_system, source_key),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS major_sources (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    major_id TEXT,
    source_system TEXT NOT NULL CHECK(source_system IN ('CAREERNET', 'WORK24_MAJOR')),
    source_key TEXT NOT NULL,
    source_type TEXT CHECK(source_type IN ('LIST', 'DETAIL_UNIV', 'DETAIL_HIGH', 'DETAIL_GENERAL', 'DETAIL_SPECIAL')),
    major_seq TEXT,
    department_cd TEXT,
    track TEXT,
    gubun TEXT,
    raw_payload TEXT NOT NULL,
    normalized_payload TEXT NOT NULL,
    fetched_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    last_error TEXT,
    retry_count INTEGER DEFAULT 0,
    UNIQUE(source_system, source_key),
    FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS job_match_overrides (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT NOT NULL,
    source_system TEXT NOT NULL,
    source_key TEXT NOT NULL,
    reason TEXT,
    confidence REAL,
    created_by TEXT,
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    UNIQUE(job_id, source_system, source_key),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS job_assets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('hero_image', 'infographic', 'icon', 'chart', 'video_thumbnail', 'other')),
    source TEXT NOT NULL CHECK(source IN ('AI', 'USER', 'ADMIN', 'OFFICIAL', 'API')),
    url TEXT NOT NULL,
    caption TEXT,
    alt_text TEXT,
    meta_json TEXT,
    display_order INTEGER DEFAULT 0,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS major_assets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    major_id TEXT NOT NULL,
    type TEXT NOT NULL CHECK(type IN ('hero_image', 'infographic', 'icon', 'chart', 'campus_photo', 'other')),
    source TEXT NOT NULL CHECK(source IN ('AI', 'USER', 'ADMIN', 'OFFICIAL', 'API')),
    url TEXT NOT NULL,
    caption TEXT,
    alt_text TEXT,
    meta_json TEXT,
    display_order INTEGER DEFAULT 0,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    FOREIGN KEY (major_id) REFERENCES majors(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS job_dictionary_index (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    d_job_cd TEXT NOT NULL,
    d_job_cd_seq TEXT NOT NULL,
    large_class_cd TEXT,
    medium_class_cd TEXT,
    small_class_cd TEXT,
    large_class_nm TEXT,
    medium_class_nm TEXT,
    small_class_nm TEXT,
    job_nm TEXT NOT NULL,
    related_job TEXT,
    similar_job_nm TEXT,
    is_seeded INTEGER DEFAULT 0 CHECK(is_seeded IN (0, 1)),
    seeded_at INTEGER,
    seed_error TEXT,
    retry_count INTEGER DEFAULT 0,
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    UNIQUE(d_job_cd, d_job_cd_seq)
);
CREATE TABLE IF NOT EXISTS seed_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    seed_type TEXT NOT NULL CHECK(seed_type IN (
      'CAREERNET_JOB_LIST',
      'CAREERNET_JOB_DETAIL',
      'CAREERNET_JOB_ENCYCLOPEDIA',
      'WORK24_JOB_LIST',
      'WORK24_JOB_DETAIL',
      'WORK24_JOB_DICT_LOAD',
      'WORK24_JOB_DICT_DETAIL',
      'CAREERNET_MAJOR_LIST',
      'CAREERNET_MAJOR_DETAIL',
      'WORK24_MAJOR_LIST',
      'WORK24_MAJOR_DETAIL',
      'ETL_MERGE_JOBS',
      'ETL_MERGE_MAJORS'
    )),
    started_at INTEGER NOT NULL,
    completed_at INTEGER,
    status TEXT NOT NULL CHECK(status IN ('running', 'completed', 'failed', 'partial')),
    total_count INTEGER DEFAULT 0,
    success_count INTEGER DEFAULT 0,
    failed_count INTEGER DEFAULT 0,
    skipped_count INTEGER DEFAULT 0,
    error_message TEXT,
    error_details TEXT,
    meta_json TEXT,
    created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS seed_errors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    seed_log_id INTEGER,
    seed_type TEXT NOT NULL,
    entity_type TEXT NOT NULL CHECK(entity_type IN ('job', 'major', 'job_dict')),
    entity_id TEXT NOT NULL,
    entity_name TEXT,
    error_message TEXT,
    error_stack TEXT,
    request_params TEXT,
    retry_count INTEGER DEFAULT 0,
    max_retries INTEGER DEFAULT 3,
    last_retry_at INTEGER,
    resolved_at INTEGER,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (seed_log_id) REFERENCES seed_logs(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS feedback_posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL REFERENCES users(id),
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  type TEXT NOT NULL DEFAULT 'suggestion',
  status TEXT NOT NULL DEFAULT 'open',
  is_private INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
, link_url TEXT, last_activity_at INTEGER);
CREATE TABLE IF NOT EXISTS feedback_replies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL REFERENCES feedback_posts(id) ON DELETE CASCADE,
  admin_id INTEGER NOT NULL REFERENCES users(id),
  body TEXT NOT NULL,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
);
CREATE TABLE IF NOT EXISTS schema_migrations (version TEXT PRIMARY KEY, description TEXT, applied_at TEXT);
CREATE TABLE IF NOT EXISTS name_mappings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL CHECK(type IN ('job', 'major')),
    source_name TEXT NOT NULL,        
    target_name TEXT NOT NULL,        
    similarity_score REAL,            
    match_reason TEXT,                
    created_by TEXT,                  
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    UNIQUE(type, source_name)
);
CREATE TABLE IF NOT EXISTS howto_reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  reporter_id INTEGER,
  reporter_ip_hash TEXT,
  reason_type TEXT NOT NULL CHECK(reason_type IN ('defamation', 'obscene', 'spam', 'copyright', 'false_info', 'other')),
  reason_detail TEXT,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'resolved', 'dismissed')),
  resolved_by INTEGER,
  resolved_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
  FOREIGN KEY (reporter_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (resolved_by) REFERENCES users(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS howtos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  summary TEXT,
  thumbnail_url TEXT,
  content_json TEXT NOT NULL,    
  content_html TEXT NOT NULL,    
  version INTEGER NOT NULL DEFAULT 1,
  view_count INTEGER DEFAULT 0,
  report_count INTEGER DEFAULT 0,
  status TEXT DEFAULT 'published' CHECK(status IN ('published', 'blinded', 'deleted')),
  blind_reason TEXT,
  blinded_at DATETIME,
  blinded_by INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS howto_drafts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  base_howto_id INTEGER,           
  title TEXT,
  slug TEXT,                       
  summary TEXT,
  thumbnail_url TEXT,
  content_json TEXT,               
  content_html TEXT,               
  version INTEGER NOT NULL DEFAULT 1,  
  stage TEXT NOT NULL DEFAULT 'DRAFT' CHECK(stage IN ('DRAFT', 'REVIEW')),
  last_saved_at DATETIME,          
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP, published_page_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (base_howto_id) REFERENCES howtos(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  usage_count INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS howto_tags (
  howto_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (howto_id, tag_id),
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS draft_tags (
  draft_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY (draft_id, tag_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS howto_related_jobs (
  howto_id INTEGER NOT NULL,
  job_id TEXT NOT NULL,            
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (howto_id, job_id),
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS howto_related_majors (
  howto_id INTEGER NOT NULL,
  major_id TEXT NOT NULL,          
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (howto_id, major_id),
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS howto_related_howtos (
  parent_howto_id INTEGER NOT NULL,
  child_howto_id INTEGER NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (parent_howto_id, child_howto_id),
  FOREIGN KEY (parent_howto_id) REFERENCES howtos(id) ON DELETE CASCADE,
  FOREIGN KEY (child_howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS draft_related_jobs (
  draft_id INTEGER NOT NULL,
  job_id TEXT NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (draft_id, job_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS draft_related_majors (
  draft_id INTEGER NOT NULL,
  major_id TEXT NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (draft_id, major_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS draft_related_howtos (
  draft_id INTEGER NOT NULL,
  howto_id INTEGER NOT NULL,
  display_order INTEGER DEFAULT 0,
  PRIMARY KEY (draft_id, howto_id),
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE,
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS slug_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  howto_id INTEGER NOT NULL,
  old_slug TEXT NOT NULL,
  changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (howto_id) REFERENCES howtos(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS howto_reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  draft_id INTEGER NOT NULL,
  reviewer_id INTEGER NOT NULL,
  decision TEXT NOT NULL CHECK(decision IN ('APPROVED', 'REJECTED')),
  reason TEXT,                     
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (draft_id) REFERENCES howto_drafts(id) ON DELETE CASCADE,
  FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS uploaded_files (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  file_key TEXT NOT NULL UNIQUE,   
  original_name TEXT,              
  content_type TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  width INTEGER,                   
  height INTEGER,                  
  alt_text TEXT,                   
  caption TEXT,                    
  used_in_howto_id INTEGER,        
  used_in_draft_id INTEGER,        
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (used_in_howto_id) REFERENCES howtos(id) ON DELETE SET NULL,
  FOREIGN KEY (used_in_draft_id) REFERENCES howto_drafts(id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS user_bookmarks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  item_type TEXT NOT NULL CHECK(item_type IN ('job', 'major', 'howto')),
  item_slug TEXT NOT NULL,
  item_title TEXT,
  created_at INTEGER DEFAULT (strftime('%s','now')),
  
  
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  
  
  UNIQUE(user_id, item_type, item_slug)
);
CREATE TABLE IF NOT EXISTS IF NOT EXISTS "pages" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  page_type TEXT NOT NULL CHECK(page_type IN ('job', 'major', 'guide')),
  content TEXT NOT NULL,
  summary TEXT,
  meta_data TEXT,
  view_count INTEGER DEFAULT 0,
  status TEXT DEFAULT 'published' CHECK(status IN ('published', 'draft', 'deleted', 'draft_published')),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  author_id INTEGER,
  source TEXT DEFAULT 'system',
  FOREIGN KEY (author_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS page_relations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  page_id INTEGER NOT NULL,
  related_page_id INTEGER NOT NULL,
  relation_type TEXT NOT NULL,
  display_order INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE,
  FOREIGN KEY (related_page_id) REFERENCES pages(id) ON DELETE CASCADE,
  UNIQUE(page_id, related_page_id, relation_type)
);
CREATE TABLE IF NOT EXISTS user_attributions (user_id INTEGER PRIMARY KEY, self_channel TEXT NOT NULL, self_channel_other TEXT, interest_state TEXT, career_state TEXT, utm_source TEXT, utm_medium TEXT, utm_campaign TEXT, utm_content TEXT, utm_term TEXT, referrer TEXT, first_touch_at INTEGER NOT NULL, FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS consents (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER NOT NULL, type TEXT NOT NULL CHECK(type IN ('terms','privacy')), version TEXT NOT NULL, consented_at INTEGER NOT NULL, ip TEXT, ua TEXT, FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS profanity_rules (id INTEGER PRIMARY KEY AUTOINCREMENT, pattern TEXT NOT NULL UNIQUE, replacement TEXT DEFAULT '**', is_active INTEGER DEFAULT 1, created_at INTEGER DEFAULT (strftime('%s','now')));
CREATE TABLE IF NOT EXISTS jobs (
    id TEXT PRIMARY KEY,
    careernet_id TEXT,
    goyong24_id TEXT,
    name TEXT NOT NULL,
    api_data_json TEXT,
    api_data_hash TEXT,
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    user_contributed_json TEXT,
    user_last_updated_at INTEGER,
    admin_data_json TEXT,
    admin_last_updated_at INTEGER,
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    slug TEXT UNIQUE,
    primary_source TEXT CHECK(primary_source IN ('CAREERNET', 'WORK24_JOB', 'WORK24_DJOB', 'USER')),
    merged_profile_json TEXT,
    ai_data_json TEXT,
    ai_last_updated_at INTEGER,
    image_url TEXT,
    image_alt TEXT,
    image_credits TEXT
, name_en TEXT, image_prompt TEXT);
CREATE TABLE IF NOT EXISTS majors (
    id TEXT PRIMARY KEY,
    careernet_id TEXT,
    goyong24_id TEXT,
    name TEXT NOT NULL,
    api_data_json TEXT,
    api_data_hash TEXT,
    api_last_fetched_at INTEGER,
    api_last_updated_at INTEGER,
    user_contributed_json TEXT,
    user_last_updated_at INTEGER,
    admin_data_json TEXT,
    admin_last_updated_at INTEGER,
    created_at INTEGER NOT NULL,
    is_active INTEGER DEFAULT 1 CHECK(is_active IN (0, 1)),
    slug TEXT UNIQUE,
    primary_source TEXT CHECK(primary_source IN ('CAREERNET', 'WORK24_MAJOR', 'USER')),
    merged_profile_json TEXT,
    ai_data_json TEXT,
    ai_last_updated_at INTEGER,
    image_url TEXT,
    image_alt TEXT,
    image_credits TEXT
, name_en TEXT, image_prompt TEXT);
CREATE TABLE IF NOT EXISTS feedback_comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL REFERENCES feedback_posts(id) ON DELETE CASCADE,
  user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
  is_admin INTEGER NOT NULL DEFAULT 0,
  body TEXT NOT NULL,
  created_at INTEGER NOT NULL DEFAULT (strftime('%s','now')),
  updated_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))
);
CREATE TABLE IF NOT EXISTS ai_analysis_requests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  user_id TEXT,
  analysis_type TEXT DEFAULT 'job' CHECK(analysis_type IN ('job', 'major')),
  pricing_tier TEXT DEFAULT 'free' CHECK(pricing_tier IN ('free', 'pro')),
  
  
  prompt_payload TEXT NOT NULL,   
  
  
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'processing', 'completed', 'failed')),
  requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  processed_at DATETIME,
  
  
  recipe_version TEXT NOT NULL DEFAULT 'recipe-v1.0.0',
  tagger_version TEXT NOT NULL DEFAULT 'tagger-v1.0.0',
  scoring_version TEXT NOT NULL DEFAULT 'scoring-v0.2.1-final',
  
  
  profile_revision_id TEXT
  
);
CREATE TABLE IF NOT EXISTS ai_analysis_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  
  
  result_json TEXT NOT NULL,
  
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  
);
CREATE TABLE IF NOT EXISTS followup_responses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  request_id INTEGER NOT NULL,
  
  
  question_id TEXT NOT NULL,
  
  
  constraint_type TEXT NOT NULL CHECK(constraint_type IN (
    'work_hours_strict',
    'remote_only',
    'shift_work_no',
    'degree_impossible',
    'license_impossible'
  )),
  
  
  job_id TEXT NOT NULL,
  job_name TEXT,
  
  
  answer TEXT NOT NULL CHECK(answer IN ('yes', 'no')),
  
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  
);
CREATE TABLE IF NOT EXISTS confirmed_constraints (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  
  
  constraint_type TEXT NOT NULL CHECK(constraint_type IN (
    'work_hours_strict',
    'remote_only',
    'shift_work_no',
    'degree_impossible',
    'license_impossible'
  )),
  
  
  source_followup_id INTEGER,
  
  
  confirmed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  
  UNIQUE(session_id, constraint_type)  
);
CREATE TABLE IF NOT EXISTS question_history (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  session_id TEXT NOT NULL,
  request_id INTEGER,  
  question_id TEXT NOT NULL,
  question_type TEXT NOT NULL,  
  attribute TEXT,  
  asked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  answered_at DATETIME,
  answer_value TEXT,
  
  UNIQUE(session_id, question_id)
);
CREATE TABLE IF NOT EXISTS job_attributes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  
  job_id TEXT NOT NULL UNIQUE,
  job_name TEXT,
  source_system TEXT,  
  
  
  tagger_version TEXT NOT NULL,
  
  
  
  
  
  
  wlb INTEGER,                    
  work_hours TEXT,                
  shift_work TEXT,                
  travel TEXT,                    
  remote_possible TEXT,           
  
  
  growth INTEGER,                 
  stability INTEGER,              
  income INTEGER,                 
  
  
  teamwork INTEGER,               
  solo_deep INTEGER,              
  analytical INTEGER,             
  creative INTEGER,               
  execution INTEGER,              
  people_facing INTEGER,          
  
  
  degree_required TEXT,           
  license_required TEXT,          
  experience_required TEXT,       
  
  
  
  
  _confidence REAL NOT NULL,      
  _field_confidence_json TEXT,    
  
  
  
  
  evidence_json TEXT,             
  
  
  
  
  raw_source_json TEXT,           
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
, status TEXT DEFAULT 'pending');
CREATE TABLE IF NOT EXISTS tagger_runs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  run_id TEXT NOT NULL UNIQUE,
  tagger_version TEXT NOT NULL,
  
  
  batch_size INTEGER,
  total_jobs INTEGER,
  processed_jobs INTEGER DEFAULT 0,
  failed_jobs INTEGER DEFAULT 0,
  
  
  status TEXT DEFAULT 'running' CHECK(status IN ('running', 'completed', 'failed', 'paused')),
  
  
  qa_passed INTEGER DEFAULT 0,
  qa_failed INTEGER DEFAULT 0,
  avg_confidence REAL,
  
  
  started_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  completed_at DATETIME,
  
  
  error_log TEXT
);
CREATE TABLE IF NOT EXISTS tagger_errors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  run_id TEXT NOT NULL,
  job_id TEXT NOT NULL,
  error_type TEXT,  
  error_message TEXT,
  retry_count INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(run_id, job_id)
);
CREATE TABLE IF NOT EXISTS raw_events_backup(
  id INT,
  user_id TEXT,
  session_id TEXT,
  event_type TEXT,
  payload_json TEXT,
  created_at NUM,
  client_meta TEXT
);
CREATE TABLE IF NOT EXISTS facts_backup(
  id INT,
  session_id TEXT,
  user_id TEXT,
  fact_key TEXT,
  value_json TEXT,
  confidence REAL,
  question_id TEXT,
  source_type TEXT,
  collected_at NUM,
  fact_level INT
);
CREATE TABLE IF NOT EXISTS IF NOT EXISTS "raw_events" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id TEXT,
  session_id TEXT NOT NULL,
  event_type TEXT NOT NULL,  
  payload_json TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  client_meta TEXT
);
CREATE TABLE IF NOT EXISTS facts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  
  session_id TEXT NOT NULL,
  user_id TEXT,
  
  
  fact_key TEXT NOT NULL,
  
  
  value_json TEXT NOT NULL,
  
  
  confidence REAL DEFAULT 1.0,
  question_id TEXT,
  
  source_type TEXT DEFAULT 'followup',
  
  
  
  fact_level INTEGER DEFAULT 3,
  
  
  collected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  
  UNIQUE(session_id, fact_key)
);
DELETE FROM sqlite_sequence;
CREATE INDEX IF NOT EXISTS idx_comments_page_id ON comments(page_id);
CREATE INDEX IF NOT EXISTS idx_search_content ON search_index(content);
CREATE INDEX IF NOT EXISTS idx_serp_logs_page_action ON serp_interaction_logs(page_type, action);
CREATE INDEX IF NOT EXISTS idx_serp_logs_recorded_at ON serp_interaction_logs(recorded_at);
CREATE INDEX IF NOT EXISTS idx_serp_summary_date ON serp_interaction_daily_summary(log_date);
CREATE INDEX IF NOT EXISTS idx_comment_votes_comment ON comment_votes(comment_id);
CREATE INDEX IF NOT EXISTS idx_comment_votes_user ON comment_votes(user_id);
CREATE INDEX IF NOT EXISTS idx_comment_reports_comment ON comment_reports(comment_id);
CREATE INDEX IF NOT EXISTS idx_comment_reports_reporter ON comment_reports(reporter_id);
CREATE INDEX IF NOT EXISTS idx_ip_blocks_status ON ip_blocks(status);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_lookup 
  ON wiki_pages(slug, page_type, cache_version);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_type 
  ON wiki_pages(page_type);
CREATE INDEX IF NOT EXISTS idx_wiki_pages_updated 
  ON wiki_pages(updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_users_google_id ON users(google_id);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE UNIQUE INDEX idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_comments_anonymous_number ON comments(page_id, anonymous_number);
CREATE INDEX IF NOT EXISTS idx_comments_edited ON comments(is_edited, edited_at);
CREATE INDEX IF NOT EXISTS idx_anonymous_daily_limits_lookup ON anonymous_daily_limits(page_id, ip_hash, date);
CREATE INDEX IF NOT EXISTS idx_anonymous_limits ON anonymous_edit_limits(entity_type, entity_id, ip_hash, edit_date);
CREATE INDEX IF NOT EXISTS idx_revisions_entity ON page_revisions(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_revisions_current ON page_revisions(entity_type, entity_id, is_current);
CREATE INDEX IF NOT EXISTS idx_revisions_number ON page_revisions(entity_type, entity_id, revision_number);
CREATE INDEX IF NOT EXISTS idx_revisions_editor ON page_revisions(editor_id, editor_type);
CREATE INDEX IF NOT EXISTS idx_revisions_created ON page_revisions(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_job_sources_job_id ON job_sources(job_id);
CREATE INDEX IF NOT EXISTS idx_job_sources_system_key ON job_sources(source_system, source_key);
CREATE INDEX IF NOT EXISTS idx_job_sources_codes ON job_sources(std_job_cd, keco_cd, ksoc_cd);
CREATE INDEX IF NOT EXISTS idx_job_sources_type ON job_sources(source_type);
CREATE INDEX IF NOT EXISTS idx_major_sources_major_id ON major_sources(major_id);
CREATE INDEX IF NOT EXISTS idx_major_sources_system_key ON major_sources(source_system, source_key);
CREATE INDEX IF NOT EXISTS idx_major_sources_codes ON major_sources(major_seq, department_cd);
CREATE INDEX IF NOT EXISTS idx_major_sources_type ON major_sources(source_type);
CREATE INDEX IF NOT EXISTS idx_major_sources_track ON major_sources(track);
CREATE INDEX IF NOT EXISTS idx_job_match_overrides_job_id ON job_match_overrides(job_id);
CREATE INDEX IF NOT EXISTS idx_job_match_overrides_source ON job_match_overrides(source_system, source_key);
CREATE INDEX IF NOT EXISTS idx_job_assets_job_id ON job_assets(job_id);
CREATE INDEX IF NOT EXISTS idx_job_assets_type ON job_assets(type);
CREATE INDEX IF NOT EXISTS idx_job_assets_is_active ON job_assets(is_active);
CREATE INDEX IF NOT EXISTS idx_major_assets_major_id ON major_assets(major_id);
CREATE INDEX IF NOT EXISTS idx_major_assets_type ON major_assets(type);
CREATE INDEX IF NOT EXISTS idx_major_assets_is_active ON major_assets(is_active);
CREATE INDEX IF NOT EXISTS idx_job_dict_codes ON job_dictionary_index(d_job_cd, d_job_cd_seq);
CREATE INDEX IF NOT EXISTS idx_job_dict_seeded ON job_dictionary_index(is_seeded);
CREATE INDEX IF NOT EXISTS idx_job_dict_job_nm ON job_dictionary_index(job_nm);
CREATE INDEX IF NOT EXISTS idx_job_dict_class ON job_dictionary_index(large_class_cd, medium_class_cd, small_class_cd);
CREATE INDEX IF NOT EXISTS idx_seed_logs_type ON seed_logs(seed_type);
CREATE INDEX IF NOT EXISTS idx_seed_logs_status ON seed_logs(status);
CREATE INDEX IF NOT EXISTS idx_seed_logs_started ON seed_logs(started_at DESC);
CREATE INDEX IF NOT EXISTS idx_seed_errors_type ON seed_errors(seed_type, entity_type);
CREATE INDEX IF NOT EXISTS idx_seed_errors_retry ON seed_errors(retry_count, resolved_at);
CREATE INDEX IF NOT EXISTS idx_seed_errors_entity ON seed_errors(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_created_at ON feedback_posts (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_status ON feedback_posts (status);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_is_private ON feedback_posts (is_private);
CREATE INDEX IF NOT EXISTS idx_feedback_posts_type ON feedback_posts (type);
CREATE UNIQUE INDEX idx_feedback_replies_post ON feedback_replies (post_id);
CREATE INDEX IF NOT EXISTS idx_name_mappings_type ON name_mappings(type);
CREATE INDEX IF NOT EXISTS idx_name_mappings_source ON name_mappings(source_name);
CREATE INDEX IF NOT EXISTS idx_name_mappings_target ON name_mappings(target_name);
CREATE INDEX IF NOT EXISTS idx_name_mappings_active ON name_mappings(is_active);
CREATE INDEX IF NOT EXISTS idx_name_mappings_type_active ON name_mappings(type, is_active);
CREATE INDEX IF NOT EXISTS idx_howto_reports_page ON howto_reports(page_id);
CREATE INDEX IF NOT EXISTS idx_howto_reports_status ON howto_reports(status);
CREATE INDEX IF NOT EXISTS idx_howto_reports_reporter ON howto_reports(reporter_id);
CREATE INDEX IF NOT EXISTS idx_howtos_slug ON howtos(slug);
CREATE INDEX IF NOT EXISTS idx_howtos_author ON howtos(author_id);
CREATE INDEX IF NOT EXISTS idx_howtos_status ON howtos(status);
CREATE INDEX IF NOT EXISTS idx_howtos_updated_at ON howtos(updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_howtos_created_at ON howtos(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_drafts_user ON howto_drafts(user_id);
CREATE INDEX IF NOT EXISTS idx_drafts_stage ON howto_drafts(stage);
CREATE INDEX IF NOT EXISTS idx_drafts_base ON howto_drafts(base_howto_id);
CREATE INDEX IF NOT EXISTS idx_drafts_updated_at ON howto_drafts(updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_tags_slug ON tags(slug);
CREATE INDEX IF NOT EXISTS idx_tags_usage ON tags(usage_count DESC);
CREATE INDEX IF NOT EXISTS idx_slug_history_old ON slug_history(old_slug);
CREATE INDEX IF NOT EXISTS idx_slug_history_howto ON slug_history(howto_id);
CREATE INDEX IF NOT EXISTS idx_reviews_draft ON howto_reviews(draft_id);
CREATE INDEX IF NOT EXISTS idx_reviews_reviewer ON howto_reviews(reviewer_id);
CREATE INDEX IF NOT EXISTS idx_uploads_user ON uploaded_files(user_id);
CREATE INDEX IF NOT EXISTS idx_uploads_key ON uploaded_files(file_key);
CREATE INDEX IF NOT EXISTS idx_uploads_howto ON uploaded_files(used_in_howto_id);
CREATE INDEX IF NOT EXISTS idx_uploads_draft ON uploaded_files(used_in_draft_id);
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_user ON user_bookmarks(user_id);
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_type ON user_bookmarks(item_type);
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_slug ON user_bookmarks(item_slug);
CREATE INDEX IF NOT EXISTS idx_drafts_published_page ON howto_drafts(published_page_id);
CREATE INDEX IF NOT EXISTS idx_pages_slug ON pages(slug);
CREATE INDEX IF NOT EXISTS idx_pages_type ON pages(page_type);
CREATE INDEX IF NOT EXISTS idx_pages_status ON pages(status);
CREATE INDEX IF NOT EXISTS idx_pages_author ON pages(author_id);
CREATE INDEX IF NOT EXISTS idx_page_relations_page_id ON page_relations(page_id);
CREATE INDEX IF NOT EXISTS idx_page_relations_related ON page_relations(related_page_id);
CREATE INDEX IF NOT EXISTS idx_users_provider_user ON users(provider, provider_user_id);
CREATE INDEX IF NOT EXISTS idx_consents_user_id ON consents(user_id);
CREATE INDEX IF NOT EXISTS idx_consents_type ON consents(type);
CREATE INDEX IF NOT EXISTS idx_jobs_name ON jobs(name);
CREATE INDEX IF NOT EXISTS idx_jobs_is_active ON jobs(is_active);
CREATE INDEX IF NOT EXISTS idx_jobs_primary_source ON jobs(primary_source);
CREATE INDEX IF NOT EXISTS idx_jobs_slug ON jobs(slug);
CREATE INDEX IF NOT EXISTS idx_majors_name ON majors(name);
CREATE INDEX IF NOT EXISTS idx_majors_is_active ON majors(is_active);
CREATE INDEX IF NOT EXISTS idx_majors_primary_source ON majors(primary_source);
CREATE INDEX IF NOT EXISTS idx_majors_slug ON majors(slug);
CREATE INDEX IF NOT EXISTS idx_feedback_comments_post ON feedback_comments (post_id);
CREATE INDEX IF NOT EXISTS idx_feedback_comments_user ON feedback_comments (user_id);
CREATE INDEX IF NOT EXISTS idx_jobs_name_en ON jobs(name_en);
CREATE INDEX IF NOT EXISTS idx_majors_name_en ON majors(name_en);
CREATE INDEX IF NOT EXISTS idx_jobs_image_prompt ON jobs(image_prompt);
CREATE INDEX IF NOT EXISTS idx_majors_image_prompt ON majors(image_prompt);
CREATE INDEX IF NOT EXISTS idx_requests_session ON ai_analysis_requests(session_id);
CREATE INDEX IF NOT EXISTS idx_requests_status ON ai_analysis_requests(status);
CREATE INDEX IF NOT EXISTS idx_results_request ON ai_analysis_results(request_id);
CREATE INDEX IF NOT EXISTS idx_followup_request ON followup_responses(request_id);
CREATE INDEX IF NOT EXISTS idx_followup_constraint ON followup_responses(constraint_type);
CREATE INDEX IF NOT EXISTS idx_confirmed_session ON confirmed_constraints(session_id);
CREATE INDEX IF NOT EXISTS idx_confirmed_user ON confirmed_constraints(user_id);
CREATE INDEX IF NOT EXISTS idx_qh_session ON question_history(session_id);
CREATE INDEX IF NOT EXISTS idx_qh_request ON question_history(request_id);
CREATE INDEX IF NOT EXISTS idx_job_attr_job_id ON job_attributes(job_id);
CREATE INDEX IF NOT EXISTS idx_job_attr_tagger ON job_attributes(tagger_version);
CREATE INDEX IF NOT EXISTS idx_job_attr_source ON job_attributes(source_system);
CREATE INDEX IF NOT EXISTS idx_job_attr_confidence ON job_attributes(_confidence);
CREATE INDEX IF NOT EXISTS idx_job_attr_wlb ON job_attributes(wlb);
CREATE INDEX IF NOT EXISTS idx_job_attr_remote ON job_attributes(remote_possible);
CREATE INDEX IF NOT EXISTS idx_job_attr_degree ON job_attributes(degree_required);
CREATE INDEX IF NOT EXISTS idx_job_attr_license ON job_attributes(license_required);
CREATE INDEX IF NOT EXISTS idx_tagger_runs_status ON tagger_runs(status);
CREATE INDEX IF NOT EXISTS idx_tagger_runs_version ON tagger_runs(tagger_version);
CREATE INDEX IF NOT EXISTS idx_tagger_errors_run ON tagger_errors(run_id);
CREATE INDEX IF NOT EXISTS idx_tagger_errors_job ON tagger_errors(job_id);
CREATE INDEX IF NOT EXISTS idx_job_attributes_status ON job_attributes(status);
CREATE INDEX IF NOT EXISTS idx_raw_events_session ON raw_events(session_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_user ON raw_events(user_id);
CREATE INDEX IF NOT EXISTS idx_raw_events_type ON raw_events(event_type);
CREATE INDEX IF NOT EXISTS idx_facts_session ON facts(session_id);
CREATE INDEX IF NOT EXISTS idx_facts_user ON facts(user_id);
CREATE INDEX IF NOT EXISTS idx_facts_fact_key ON facts(fact_key);
CREATE TRIGGER IF NOT EXISTS trg_howtos_updated_at
AFTER UPDATE ON howtos FOR EACH ROW
BEGIN
  UPDATE howtos SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;
CREATE TRIGGER IF NOT EXISTS trg_drafts_updated_at
AFTER UPDATE ON howto_drafts FOR EACH ROW
BEGIN
  UPDATE howto_drafts SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;
CREATE TRIGGER IF NOT EXISTS trg_howto_tags_insert
AFTER INSERT ON howto_tags FOR EACH ROW
BEGIN
  UPDATE tags SET usage_count = usage_count + 1 WHERE id = NEW.tag_id;
END;
CREATE TRIGGER IF NOT EXISTS trg_howto_tags_delete
AFTER DELETE ON howto_tags FOR EACH ROW
BEGIN
  UPDATE tags SET usage_count = usage_count - 1 WHERE id = OLD.tag_id;
END;


