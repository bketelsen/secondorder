CREATE TABLE IF NOT EXISTS audit_runs (
    id TEXT PRIMARY KEY,
    run_id TEXT,
    status TEXT NOT NULL DEFAULT 'running',
    issues_reviewed INTEGER NOT NULL DEFAULT 0,
    blocks_reviewed INTEGER NOT NULL DEFAULT 0,
    findings TEXT NOT NULL DEFAULT '',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at DATETIME
);

CREATE TABLE IF NOT EXISTS archetype_patches (
    id TEXT PRIMARY KEY,
    audit_run_id TEXT NOT NULL,
    agent_slug TEXT NOT NULL,
    current_content TEXT NOT NULL,
    proposed_content TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    reviewed_at DATETIME,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_archetype_patches_status ON archetype_patches(status);
