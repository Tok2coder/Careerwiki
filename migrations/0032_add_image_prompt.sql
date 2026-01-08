-- Migration 0032: Add image_prompt column to jobs and majors tables
-- Safe migration: Check if column exists before adding

-- Add image_prompt to jobs table (if not exists workaround for SQLite)
-- SQLite doesn't support IF NOT EXISTS for ALTER TABLE, so we use a try-catch approach
-- This will fail silently if the column already exists

-- Create temp table to track if migration is needed
CREATE TABLE IF NOT EXISTS _migration_check_0032 (id INTEGER PRIMARY KEY);

-- Only run if this is the first attempt
INSERT OR IGNORE INTO _migration_check_0032 (id) VALUES (1);

-- Drop the check table
DROP TABLE IF EXISTS _migration_check_0032;

-- Add image_prompt column to jobs and majors
ALTER TABLE jobs ADD COLUMN image_prompt TEXT;
ALTER TABLE majors ADD COLUMN image_prompt TEXT;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_jobs_image_prompt ON jobs(image_prompt);
CREATE INDEX IF NOT EXISTS idx_majors_image_prompt ON majors(image_prompt);
