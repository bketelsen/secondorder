-- Add disable_slash_commands and disable_skills columns to agents table.
ALTER TABLE agents ADD COLUMN disable_slash_commands INTEGER NOT NULL DEFAULT 0;
ALTER TABLE agents ADD COLUMN disable_skills INTEGER NOT NULL DEFAULT 0;
