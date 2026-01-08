-- Add draft_published status to pages table
-- SQLite doesn't support ALTER CHECK, so we need to recreate the table

-- Step 1: Create new table with updated CHECK constraint
CREATE TABLE IF NOT EXISTS pages_new (
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

-- Step 2: Copy data from old table to new table
INSERT INTO pages_new (id, slug, title, page_type, content, summary, meta_data, view_count, status, created_at, updated_at, author_id, source)
SELECT id, slug, title, page_type, content, summary, meta_data, view_count, status, created_at, updated_at, author_id, source
FROM pages;

-- Step 3: Drop old table
DROP TABLE pages;

-- Step 4: Rename new table to original name
ALTER TABLE pages_new RENAME TO pages;

-- Step 5: Recreate indexes
CREATE INDEX IF NOT EXISTS idx_pages_slug ON pages(slug);
CREATE INDEX IF NOT EXISTS idx_pages_type ON pages(page_type);
CREATE INDEX IF NOT EXISTS idx_pages_status ON pages(status);
CREATE INDEX IF NOT EXISTS idx_pages_author ON pages(author_id);

-- Step 6: Create page_relations table for related content
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

CREATE INDEX IF NOT EXISTS idx_page_relations_page_id ON page_relations(page_id);
CREATE INDEX IF NOT EXISTS idx_page_relations_related ON page_relations(related_page_id);

