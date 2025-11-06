-- Migration: Wiki-style page caching system
-- Purpose: Store pre-rendered HTML with template version tracking
-- Architecture: ISR (Incremental Static Regeneration)

-- wiki_pages: Cached HTML storage with version-based invalidation
CREATE TABLE IF NOT EXISTS wiki_pages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  
  -- Page identification
  slug TEXT NOT NULL,                     -- URL-friendly identifier (e.g., 'computer-science')
  page_type TEXT NOT NULL                 -- Page category ('job', 'major', 'guide')
    CHECK(page_type IN ('job', 'major', 'guide')),
  
  -- Cache data
  content TEXT NOT NULL,                  -- Pre-rendered HTML (complete <html> document)
  cache_version INTEGER NOT NULL,         -- Template version (for auto-invalidation)
  
  -- Metadata
  title TEXT NOT NULL,                    -- Page title for search/display
  description TEXT,                       -- SEO meta description
  og_image_url TEXT,                      -- Open Graph image URL
  
  -- Timestamps
  created_at INTEGER NOT NULL DEFAULT (unixepoch()),  -- Unix timestamp (seconds)
  updated_at INTEGER NOT NULL DEFAULT (unixepoch()),  -- Unix timestamp (seconds)
  
  -- Constraints
  UNIQUE(slug, page_type)                 -- One cache entry per page
);

-- Indexes for fast lookups
CREATE INDEX IF NOT EXISTS idx_wiki_pages_lookup 
  ON wiki_pages(slug, page_type, cache_version);

CREATE INDEX IF NOT EXISTS idx_wiki_pages_type 
  ON wiki_pages(page_type);

CREATE INDEX IF NOT EXISTS idx_wiki_pages_updated 
  ON wiki_pages(updated_at DESC);

-- Example query pattern:
-- SELECT content, cache_version 
-- FROM wiki_pages 
-- WHERE slug = 'computer-science' 
--   AND page_type = 'major' 
--   AND cache_version = 2;
