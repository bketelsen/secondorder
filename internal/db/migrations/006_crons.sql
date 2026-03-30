CREATE TABLE IF NOT EXISTS cron_jobs (
    id TEXT PRIMARY KEY,
    agent_id TEXT NOT NULL REFERENCES agents(id),
    task TEXT NOT NULL,
    frequency TEXT NOT NULL DEFAULT '1h',
    active INTEGER NOT NULL DEFAULT 1,
    last_run_at DATETIME,
    created_at DATETIME NOT NULL DEFAULT (datetime('now')),
    updated_at DATETIME NOT NULL DEFAULT (datetime('now'))
);
