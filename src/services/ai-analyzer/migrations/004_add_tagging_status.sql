-- Migration: 004_add_tagging_status
-- Add status column to job_attributes for tracking tagging progress
-- Created: 2026-01-05

-- Note: CHECK constraint removed to avoid D1 issues, validation done in app layer
ALTER TABLE job_attributes ADD COLUMN status TEXT DEFAULT 'pending';

-- Index for filtering by status
CREATE INDEX IF NOT EXISTS idx_job_attr_status ON job_attributes(status);
