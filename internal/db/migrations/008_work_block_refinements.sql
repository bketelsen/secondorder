ALTER TABLE work_blocks ADD COLUMN activated_at DATETIME;
ALTER TABLE work_blocks ADD COLUMN acceptance_criteria TEXT NOT NULL DEFAULT '';
