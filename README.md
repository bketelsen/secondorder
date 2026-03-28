# thelastorg

**Open-source orchestration for zero-human companies.**

If OpenClaw is an employee, Paperclip is the company. thelastorg is self improving org system.

**Manage business goals, not pull requests.**

| Step | Example |
|------|---------|
| 01 | **Define the goal** -- "Build the #1 AI note-taking app to $1M MRR." |
| 02 | **Hire the team** -- CEO, CTO, engineers, designers, marketers -- any bot, any provider. |
| 03 | **Approve and run** -- Review strategy. Set budgets. Hit go. Monitor from the dashboard. |
| 04 | **Self-improve** -- Agents review their own outputs, log what worked, adapt for next cycle. |


### The Self-Improvement Loop

Traditional agent orchestration is fire-and-forget: assign task, agent runs, collect output. Paperclip closes the loop.

**How it works:**

1. **Execute** -- Agent runs on assigned issue, produces work products, logs token usage and cost
2. **Reflect** -- Post-run, agent reviews its own output against the goal criteria. What worked? What didn't? What would it do differently?
3. **Record** -- Reflections, performance scores, and self-critiques are stored as structured data attached to runs
4. **Adapt** -- On next dispatch, the scheduler surfaces relevant past reflections. Agent reads its own history before starting, adjusting approach based on prior outcomes
5. **Consolidate** -- Patterns that succeed repeatedly get promoted to the skills library. One agent's learning becomes available to the entire org

This isn't prompt engineering. It's agents building institutional knowledge -- the same way a company accumulates expertise across employees and projects. The skills library, activity log, and work product history form a collective memory that compounds over time.

**Concrete example:** A code review agent initially flags 40% false positives. After 50 runs, its self-critiques identify the pattern: "I flag style issues as bugs." The reflection is surfaced on subsequent runs. False positive rate drops to 8% -- no human intervention required.

---

# thelastorg: Technical Plan

## Bottom Line Up Front

**thelastorg is a single-binary AI agent management platform built with Go + HTMX + templ + SQLite, providing Linear-style project management for autonomous AI agents with built-in cost controls, execution isolation, and full audit trails.** Target deployment: zero-ops single binary with embedded database, no external dependencies, sub-second startup. The architecture combines server-rendered HTML (HTMX + templ) with a pure-Go SQLite driver (modernc.org/sqlite) for a deployment experience that's `go build && ./thelastorg` -- nothing else.

**Why it matters**: Organizations running multiple AI agents across projects face scattered terminals, no cost visibility, no audit trail, and no coordination layer. thelastorg consolidates agent management, issue tracking, execution monitoring, and budget enforcement into one dashboard. Think of it as Linear meets agent orchestration -- a command center where humans assign work, agents execute, and everything is tracked.

**The opportunity**: AI agent usage is exploding, but tooling hasn't caught up. Teams run Claude Code, Codex, and custom agents in disconnected terminals. There's no unified way to assign tasks, monitor costs, enforce budgets, or review outputs. thelastorg fills this gap with a platform that's simpler to deploy than a Docker container (single binary, SQLite) while offering enterprise-grade features (budget policies, approval workflows, config versioning, encrypted secrets).

## What It Actually Is

**In one sentence:** A self-hosted dashboard where you register AI agents, assign them issues, and monitor their work -- costs, outputs, token usage, approvals -- from one place.

## The Real-World Problem It Solves

Your engineering team runs multiple AI agents:
- Claude Code working on backend refactors
- A content agent writing documentation
- A review agent checking PRs for security issues
- A triage agent sorting incoming bugs

Current state forces you to:
- **Open N terminals** for N agents, lose track of what's running where
- **No cost visibility** until the Anthropic invoice arrives, then scramble to find which agent burned through tokens
- **No audit trail** -- who assigned what, when did it run, what did it produce?
- **No coordination** -- agents duplicate work, contradict each other, miss dependencies
- **No guardrails** -- a misconfigured agent can burn $500 in tokens overnight

**thelastorg gives you one place to manage it all.**

## Market Comparison Table

| Feature | thelastorg | Paperclip (TS) | Custom Scripts | Slack + Manual | Linear + CLI |
|---------|-----------|----------------|----------------|----------------|--------------|
| **Deployment** | Single binary | Node.js + Docker | Per-team DIY | N/A | Multi-tool |
| **Agent Registry** | Built-in | Built-in | None | None | None |
| **Issue Tracking** | Linear-style | Linear-style | None | Informal | Linear (separate) |
| **Cost Controls** | Per-agent budgets | Basic | None | None | None |
| **Execution Isolation** | Worktrees, Docker | Worktrees | Manual | None | None |
| **Live Monitoring** | SSE real-time | SSE | Logs only | None | None |
| **Approval Workflows** | Built-in | Basic | None | Manual | None |
| **Config Versioning** | Full rollback | None | Git only | None | None |
| **Secrets Management** | Encrypted store | Env vars | .env files | None | None |
| **Cron Automation** | Built-in routines | External | Crontab | None | None |
| **External Dependencies** | Zero | Node, Docker, DB | Varies | Multiple SaaS | Multiple SaaS |
| **Startup Time** | <1s | 5-15s | Varies | N/A | N/A |
| **Database** | Embedded SQLite | PostgreSQL/SQLite | Varies | None | Cloud |
| **Cost** | Free (MIT) | Free | Engineering time | $15+/user/mo | $10+/user/mo |

## Closest Equivalents

### 1. **Paperclip** (TypeScript predecessor)
**What it is:** The Node.js/TypeScript version of this same concept, requiring Docker and external databases.
**Similarity:** Same feature set, same UI patterns, same mental model.
**Key differences:**
- Paperclip = multi-service (Node + DB + Docker), thelastorg = single binary
- Paperclip = JavaScript ecosystem overhead, thelastorg = compiled Go with embedded assets
- Paperclip = external SQLite/Postgres, thelastorg = pure-Go SQLite compiled in
- Paperclip = ~15s cold start, thelastorg = <1s start

**Why thelastorg wins:** Zero-ops deployment. `scp` the binary to a server and run it. No Docker, no npm, no runtime.

### 2. **Custom Agent Scripts + Slack**
**What it is:** The most common "solution" -- bash scripts, cron jobs, and Slack channels for coordination.
**Similarity:** Gets the job done for 1-2 agents.
**Key differences:**
- Scripts = no cost tracking, thelastorg = per-agent budget policies with hard limits
- Scripts = no audit trail, thelastorg = comprehensive activity log
- Scripts = no UI, thelastorg = Linear-style dashboard
- Scripts = breaks at 3+ agents, thelastorg = designed for fleet management

**Why thelastorg wins:** Moves from "it works on my machine" to "we have a system."

### 3. **Linear + Claude Code CLI**
**What it is:** Using Linear for issue tracking and running agents manually from terminals.
**Similarity:** Similar issue tracking UX, manual agent dispatch.
**Key differences:**
- Linear = human-oriented, thelastorg = agent-oriented (API-first for agent auth, inbox, work products)
- Linear = no execution tracking, thelastorg = stdout capture, token usage, cost per run
- Linear = no budget controls, thelastorg = monthly caps, per-run limits, alert thresholds
- Linear = $10+/user/mo SaaS, thelastorg = free, self-hosted, data stays local

**Why thelastorg wins:** Purpose-built for the agent loop: assign -> execute -> monitor -> review.

## What Makes thelastorg Unique

**The "triple unlock":**

1. **Zero-ops deployment** (single binary, embedded SQLite, no Docker)
2. **Agent-native workflows** (API keys, inbox, work products, approval requests)
3. **Enterprise cost controls** (per-agent budgets, token quotas, hard limits, finance events)

**No existing solution has all three.**

## Real-World Use Cases

### Use Case 1: Engineering Team with Multiple Claude Code Agents
**Current state:** 5 engineers each running Claude Code in separate terminals
**Pain:** No visibility into aggregate costs, duplicated work, no review process
**thelastorg solution:** Register each agent, assign issues from a shared board, enforce $50/day per-agent budgets, require approval for destructive operations
**Impact:** 40-60% cost reduction from budget enforcement alone, zero duplicated work

### Use Case 2: Content Operations
**Current state:** Marketing team manually prompting AI for blog posts, social content, docs
**Pain:** No version history, no approval workflow, outputs scattered across conversations
**thelastorg solution:** Content agent with cron routines (weekly blog draft), issue-based workflow with review stages, work products attached to issues
**Impact:** Automated content pipeline with human review gates

### Use Case 3: Automated Triage and Bug Fixing
**Current state:** Bugs reported in GitHub, manually assigned to engineers
**Pain:** Triage bottleneck, simple bugs wait days for human attention
**thelastorg solution:** Triage agent with webhook trigger, auto-creates issues, assigns fix agents based on project/skill match, human approves before merge
**Impact:** Simple bugs fixed in minutes instead of days

### Use Case 4: Multi-Agent Research Pipeline
**Current state:** Research tasks require multiple AI passes (search, synthesize, verify)
**Pain:** Manual handoff between stages, no tracking of intermediate results
**thelastorg solution:** Agent hierarchy (researcher reports to lead), sub-issues for each stage, work products flow between agents, cost tracking per pipeline run
**Impact:** Reproducible research pipelines with full provenance

## Architecture Overview: Server-Rendered Single Binary

thelastorg's architecture prioritizes operational simplicity -- every component compiles into one binary, runs without external services, and serves a full-featured UI.

```
cmd/thelastorg/main.go        Entry point, CLI flags, template loading, server startup
internal/
  handlers/                    HTTP handlers + HTMX partials + REST API
    handlers.go                Router setup, middleware, auth
    pages.go                   Page rendering (issues, agents, dashboard)
    pages_extended.go          Extended pages (routines, workspaces, costs, secrets)
    api.go                     REST API (JSON, API key auth)
    render.go                  Template rendering helpers
  templates/                   templ components (compiled to type-safe Go)
    layout.templ               Main layout, navigation, sidebar
    dashboard.templ            Dashboard summary, charts, activity
    issues.templ               Issue board, detail, comments, filters
    agents.templ               Agent roster, config, status, runs
    pages.templ                Goals, approvals, extended views
    extended.templ             Routines, workspaces, costs, skills
    fragments.templ            Reusable HTMX partial templates
  models/                      Data types (25+ entity types)
    models.go                  Core entities (Agent, Issue, Run, Comment)
    extended.go                Extended entities (Routine, Budget, Workspace)
  db/                          SQLite queries + migrations
    db.go                      Connection, migration runner, transaction helpers
    queries.go                 CRUD for core entities
    queries_extended.go        CRUD for routines, workspaces, budgets, secrets
    migrations/
      001_initial.sql          45+ tables, indexes, constraints
      002_routines_workspaces.sql  Automation and workspace isolation
  scheduler/                   Background agent dispatch
    scheduler.go               Heartbeat loop, goroutine management, signal handling
static/                        CSS + JS (embedded via embed.FS)
```

**Single binary. No external dependencies at runtime.** SQLite database file + optional data directory for attachments. The Go compiler embeds all templates, static assets, and starter blueprints into the binary at build time.

## Database Schema: 45+ Tables for Full Agent Lifecycle

The schema covers the complete agent lifecycle from registration through execution to cost reconciliation.

### Core Entities

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `agents` | AI agent configuration | name, model, adapter, status, working_dir, instructions, reports_to |
| `issues` | Work items | title, status, priority, assignee_id, project_id, parent_id, key |
| `runs` | Execution records | agent_id, issue_id, stdout, tokens_in/out/cached, cost, started_at/ended_at |
| `comments` | Issue discussions | body, author_type, author_id, run_id |
| `projects` | Organizational groupings | name, slug, description |
| `goals` | Company objectives | title, status, target_date |

### Execution & Workflows

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `routines` | Cron/webhook automation | name, agent_id, enabled, trigger_type |
| `routine_triggers` | Trigger configuration | cron_expression, webhook_public_id |
| `routine_runs` | Execution history | routine_id, run_id, triggered_at |
| `execution_workspaces` | Isolation environments | type (worktree/docker/local), project_id, branch |
| `work_products` | Agent output artifacts | issue_id, type (file/diff/url/code/report), content |
| `issue_documents` | Versioned docs | issue_id, key, body, revision_count |
| `task_sessions` | Agent-issue work links | agent_id, issue_id, run_id |

### Cost & Budget

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `budget_policies` | Per-agent spending limits | agent_id, monthly_cost_cap, per_run_limit, token_quota |
| `budget_incidents` | Threshold violations | policy_id, type (warning/limit/overage), amount |
| `quota_windows` | Rolling usage tracking | policy_id, window_start, tokens_used, cost_used |
| `cost_events` | External billing | agent_id, model, provider, biller, amount |
| `finance_events` | Cost reconciliation | type, entity_id, amount, metadata |

### Infrastructure

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `api_keys` | Agent authentication | agent_id, prefix_hash, key_hash, last_used_at |
| `secrets` | Encrypted credentials | name, encrypted_value, provider, rotation_at |
| `agent_config_revisions` | Config snapshots | agent_id, config_json, revision_number |
| `run_events` | Detailed event stream | run_id, type (tool_use/message/error), data |
| `activity_log` | Full audit trail | actor_type, action, entity_type, entity_id, metadata |
| `skills` | Reusable agent capabilities | name, description, category |
| `labels` | Issue tags | name, color |
| `settings` | Workspace config | key (workspace_name, issue_prefix, brand_color), value |
| `sequences` | Auto-increment counters | name, current_value |
| `attachments` | File metadata | issue_id, filename, content_type, size |

## Scheduler: Heartbeat-Driven Agent Dispatch

The scheduler is a background goroutine that polls every 10 seconds, checking each agent's heartbeat status and dispatching work.

**Dispatch loop:**
1. Query all agents where `heartbeat_enabled=true` and `status != paused`
2. For each agent, check if already running (concurrent map with mutex protection)
3. Check if enough time elapsed since last heartbeat (configurable interval, default 3600s)
4. If ready, spawn goroutine: fetch assigned issue from inbox, create run record, execute agent command, capture stdout, record token usage and cost
5. On completion, update run status, release running lock

**Concurrency model:** `sync.WaitGroup` for goroutine lifecycle, `sync.Mutex` protecting the running-agents map, `context.Context` with cancellation for graceful shutdown on SIGTERM/SIGINT.

**Execution isolation:** Agents can run in git worktrees (branch-per-run isolation), Docker containers, or local filesystem. The scheduler creates the workspace before dispatch and archives it after completion.

**Safety controls:**
- Execution timeout with 15-second graceful interrupt
- Max turns limit per agent (default 300)
- Budget check before dispatch -- skip if monthly cap exceeded
- Approval workflow pauses execution until human confirms

## REST API: Agent-Facing Endpoints

Agents authenticate via API keys (`X-API-Key` or `Authorization: Bearer` header). Keys are SHA256-hashed with prefix-based O(1) lookup.

```
GET    /api/v1/inbox                          Pending issues assigned to authenticated agent
GET    /api/v1/issues/{key}                   Issue details + comments + work products
POST   /api/v1/issues                         Create new issue (agents can self-assign work)
PATCH  /api/v1/issues/{key}                   Update status, priority, assignee
POST   /api/v1/issues/{key}/comments          Add comment (progress updates, blockers)
GET    /api/v1/agents/me                      Authenticated agent's own config and status
POST   /api/v1/runs/{id}/tokens               Report token usage (input, output, cached)
POST   /api/v1/runs/{id}/events               Log run events (tool_use, message, error)
POST   /api/v1/approvals                      Request human approval before proceeding
POST   /api/v1/issues/{key}/work-products     Attach artifact (file, diff, URL, code, report)
PUT    /api/v1/issues/{key}/documents/{key}   Upsert versioned document with revision tracking
POST   /api/v1/cost-events                    Report cost for external billing reconciliation
```

**Authentication flow:** Agent sends API key in header. Server extracts prefix (first 16 chars), looks up key record by hashed prefix, validates full key hash, resolves agent identity. `LastUsedAt` timestamp updated on each request.

## Web UI: Server-Rendered HTMX Dashboard

The UI is entirely server-rendered using templ (type-safe HTML templates compiled to Go) with HTMX for interactivity. No JavaScript framework, no build step for frontend, no node_modules.

**Page routes:**

| Path | Feature |
|------|---------|
| `/dashboard` | Summary: agent count, active runs, recent activity, cost charts |
| `/issues` | Linear-style board with status/priority/assignee/label filtering |
| `/issues/{key}` | Issue detail: comments, work products, documents, sub-issues |
| `/agents` | Agent roster with status indicators (idle, running, paused, error) |
| `/agents/{slug}` | Agent detail: config, recent runs, budget summary |
| `/agents/{slug}/configuration` | Edit agent model, instructions, working dir, permissions |
| `/agents/{slug}/budget` | Budget policy, quota usage, incident history |
| `/runs/{id}` | Run detail: stdout, token usage, cost, event timeline |
| `/costs` | Cost breakdown by model, provider, biller with date filtering |
| `/approvals` | Pending approval requests from agents |
| `/routines` | Cron/webhook automation management |
| `/execution-workspaces` | Workspace isolation management |
| `/secrets` | Encrypted secrets store |
| `/skills` | Reusable agent capabilities library |
| `/activity` | Full audit trail across all entities |
| `/inbox` | Pending items requiring attention |
| `/search` | Command palette (global search) |
| `/org` | Workspace settings (name, issue prefix, brand color) |
| `/export`, `/import` | Backup and migration |
| `/events` | SSE stream for live run monitoring |

**HTMX patterns:** Partial page updates via `hx-get`/`hx-post` with `hx-target` for surgical DOM replacement. HTMX redirect headers enable SPA-like navigation. SSE connection pushes live run output and status changes.

## Tech Stack Deep Dive

### Go 1.26 -- Single Binary, Fast Compilation, Stdlib HTTP
Go compiles to a single static binary with no runtime dependencies. The stdlib `net/http` server handles routing, middleware, and SSE without external frameworks. `embed.FS` packages templates, static assets, and starter blueprints into the binary at build time. Result: `scp` one file to a server and run it.

### templ -- Type-Safe HTML Templates
templ compiles HTML templates to Go code at build time, providing compile-time type checking for template data. No runtime template parsing, no `interface{}` assertions, no nil pointer panics from missing template variables. Each UI component is a Go function that returns `templ.Component`, composable like React components but with zero JavaScript overhead.

### HTMX -- Server-Rendered Interactivity
HTMX adds dynamic behavior to server-rendered HTML through HTML attributes (`hx-get`, `hx-post`, `hx-swap`, `hx-trigger`). The server returns HTML fragments, HTMX swaps them into the DOM. No JavaScript framework, no build pipeline, no client-side state management. SSE integration provides live updates for running agents without polling.

### SQLite (modernc.org/sqlite) -- Pure Go, Zero CGO
Pure Go SQLite implementation avoids CGO compilation complexity. No C compiler needed, cross-compilation works out of the box. WAL mode for concurrent reads, foreign key constraints, CHECK constraints on status enums. 45+ tables covering the full agent lifecycle. Migrations run automatically on startup.

### SSE -- Live Updates Without WebSockets
Server-Sent Events provide one-way real-time updates from server to browser. Simpler than WebSockets (no handshake, automatic reconnection, works through proxies). Used for live run output streaming, agent status changes, and inbox notifications.

## Configuration

| Flag | Env Var | Default | Description |
|------|---------|---------|-------------|
| `-p, --port` | `PORT` | `3100` | HTTP listen port |
| `-d, --db` | `DB_PATH` | `./thelastorg.db` | SQLite database path |
| `--data-dir` | -- | `./data` | Attachments directory |
| `-t, --template` | -- | -- | Apply starter template on launch |
| `-l, --list-templates` | -- | -- | List available templates |

## Starter Templates

Pre-configured organization blueprints embedded as JSON in the binary:

- **`startup`** -- CEO, Founding Engineer, Product Lead with projects, goals, and starter issues
- **`dev-team`** -- Engineering-focused: backend, frontend, DevOps agents with CI/CD routines
- **`content-agency`** -- Content pipeline: writer, editor, SEO agents with weekly routines

```bash
# List built-in templates
./thelastorg --list-templates

# Apply on launch
./thelastorg --template startup

# Load from filesystem
./thelastorg --template ./my-org.json
```

Templates create agents, projects, goals, issues, and routines in a single atomic operation. Safe to re-apply -- skips existing entities.

## Quick Start

```bash
# Build
go build -o thelastorg ./cmd/thelastorg

# Run (defaults: port 3100, db ./thelastorg.db)
./thelastorg

# With options
./thelastorg --port 8080 --db /var/data/org.db --data-dir /var/data

# Bootstrap with a starter template
./thelastorg --template startup
```

Open `http://localhost:3100`.

## Technical Differentiators That Matter

### 1. **Zero-Ops Deployment**
**Problem:** Most agent platforms require Docker, databases, message queues, and ops expertise.
**thelastorg:** `go build && ./thelastorg`. One binary, one SQLite file. Backup is `cp thelastorg.db backup.db`. Migration is `scp thelastorg server:~/`.

**Why it matters:** The team running AI agents doesn't want to also run infrastructure for the management layer.

### 2. **Agent-Native API Design**
**Problem:** Generic project management tools (Linear, Jira) don't speak agent. No inbox endpoint, no token reporting, no approval requests.
**thelastorg:** Purpose-built REST API where agents authenticate, poll for work, report progress, request approvals, and attach artifacts -- all through dedicated endpoints.

**Why it matters:** Agents are first-class citizens, not humans using a UI through browser automation.

### 3. **Budget Enforcement at the Platform Level**
**Problem:** Cost overruns discovered after the fact on monthly invoices.
**thelastorg:** Per-agent budget policies with monthly caps, per-run limits, and token quotas. Alert thresholds trigger warnings. Hard limits pause execution before overspend.

**Why it matters:** A single misconfigured agent prompt can burn hundreds of dollars. Budget enforcement should be infrastructure, not discipline.

### 4. **Configuration Versioning with Rollback**
**Problem:** Changing an agent's model, instructions, or permissions and it breaks. No way to go back.
**thelastorg:** Every config change creates a numbered revision. View diff between revisions. One-click rollback to any previous state.

**Why it matters:** Agent configs are code. They deserve version control.

### 5. **Execution Isolation**
**Problem:** Agents running in the same directory can interfere with each other, corrupt files, or conflict on git branches.
**thelastorg:** Execution workspaces provide isolation -- git worktrees (branch per run), Docker containers, or local filesystem sandboxes. The scheduler creates the workspace before dispatch and archives after.

**Why it matters:** Concurrent agent execution requires isolation the same way concurrent processes require separate memory spaces.

## Market Gaps thelastorg Fills

### Gap 1: "Managed + Self-Hosted"
**Existing:** Cloud agent platforms (expensive, data leaves your network)
**Existing:** DIY scripts (free but fragile, no features)
**thelastorg:** Full-featured platform that runs on a $5/month VPS

**Validation:** Teams running sensitive code can't send it to cloud platforms. Self-hosted is the only option, and current self-hosted options require ops expertise.

### Gap 2: "Cost Controls for AI Agents"
**Existing:** Anthropic/OpenAI usage dashboards (after the fact, account-level)
**Existing:** Nothing at the per-agent level
**thelastorg:** Per-agent budgets with real-time enforcement

**Validation:** Every team running agents has a cost horror story. Budget enforcement is the most-requested feature in agent tooling.

### Gap 3: "Agent Coordination Layer"
**Existing:** Agents run independently, humans coordinate via Slack
**Existing:** No system for agent-to-agent task delegation
**thelastorg:** Agent hierarchy (reports-to), sub-issues, shared inbox, work product handoff

**Validation:** Multi-agent workflows are the next frontier. Agents that can delegate, review, and build on each other's work need a coordination layer.

## Risk Analysis

### Risk 1: "Teams won't adopt another tool"
**Likelihood:** Medium
**Mitigation:** Zero-ops deployment removes adoption friction. Template system gets teams running in 60 seconds. Linear-familiar UI minimizes learning curve.

### Risk 2: "SQLite won't scale"
**Likelihood:** Low
**Mitigation:** SQLite handles millions of rows. WAL mode supports concurrent reads. Most agent management workloads are read-heavy with low write volume. If needed, the db layer abstracts storage -- swap to PostgreSQL without changing handlers.

### Risk 3: "Agents don't need project management"
**Likelihood:** Low
**Mitigation:** Every production agent deployment develops ad-hoc tracking (spreadsheets, Slack channels, scripts). thelastorg formalizes what teams already do informally.

### Risk 4: "Open source means no revenue"
**Likelihood:** Medium
**Mitigation:** MIT license builds trust and adoption. Revenue from managed hosting, enterprise support, and advanced features (RBAC, SSO, multi-tenant).

## Implementation Roadmap

### Phase 1 (Complete): Foundation
- Go project structure, CLI flags, server startup
- SQLite database with 45+ tables and migrations
- Core CRUD: agents, issues, runs, comments, projects
- templ-based UI with HTMX interactivity
- Heartbeat-driven scheduler with concurrent dispatch
- Starter templates (startup, dev-team, content-agency)
- **Delivered:** Working agent management platform

### Phase 2 (Complete): Agent API
- REST API with API key authentication
- Agent inbox, issue CRUD, comment, token reporting
- Run event logging, work product attachment
- Document versioning, cost event reporting
- Approval workflow
- **Delivered:** Agents can authenticate and work autonomously

### Phase 3 (Complete): Enterprise Features
- Budget policies with monthly caps, per-run limits, token quotas
- Alert thresholds and hard limits
- Cost breakdown by model, provider, biller
- Configuration versioning with rollback
- Execution workspaces (worktree, Docker, local)
- Secrets management with encryption
- Routines with cron and webhook triggers
- Skills library
- Export/import for backup and migration
- **Delivered:** Production-ready with cost controls

### Phase 3.5 (Complete): Budget Enforcement, Review Loop, Telegram

**Daily Token Budgets**
- Per-agent daily token limit (set in agent config > Daily Budget)
- Scheduler checks today's usage before each run; if exceeded, agent is paused
- Token usage parsed from CLI output after runs, stored as cost_events
- Resets daily; set to 0 for unlimited

**Approval-Review Loop**
- Agents request approval via `POST /api/v1/approvals` with `issue_key`
- Linked issue moves to "In Review"
- Reviewer determined: explicit `review_agent_id` > `reports_to` > board (UI)
- Reviewer agent sees pending reviews in heartbeat prompt
- Approve -> issue Done; Reject -> issue back to In Progress + comment
- Configure reviewer per agent in config > Review dropdown

**Telegram Approval Switch**
- Settings > Telegram Notifications: enter bot token + chat ID
- Set webhook: `YOUR_URL/api/v1/telegram/webhook`
- Approval requests send Telegram message with inline Approve/Reject buttons
- Clicking a button resolves the approval and updates the linked issue

**API additions:**
- `POST /api/v1/approvals` now accepts `issue_key`, auto-determines reviewer
- `POST /api/v1/approvals/:id/resolve` -- approve/reject with comment
- `POST /api/v1/telegram/webhook` -- Telegram callback handler

### Phase 4 (Planned): Scale & Polish
- RBAC and multi-user access control
- SSO integration (OIDC, SAML)
- Multi-workspace support
- Agent-to-agent communication protocol
- Plugin system for custom adapters
- Webhook notifications (Slack, email, custom)
- Dashboard analytics and reporting
- Performance optimization for 100+ concurrent agents

### Phase 5 (Future): Platform
- Managed hosting option
- Marketplace for agent templates and skills
- Integration with Linear, GitHub, Jira for bi-directional sync
- Mobile app for approval workflows
- LLM provider abstraction (Claude, GPT, Gemini, local models)
- Distributed execution across multiple nodes

## Architecture Principles

- **Simplicity over features:** Single binary, embedded database, zero external dependencies. Every feature must justify the complexity it adds.
- **Server-rendered over SPA:** HTML from the server, HTMX for interactivity. No JavaScript build pipeline, no client-side state management, no hydration bugs.
- **Agent-first design:** API endpoints designed for agent consumption. Agents are first-class entities, not an afterthought bolted onto a human tool.
- **Budget enforcement as infrastructure:** Cost controls are not optional add-ons. They're core to the platform, enforced at the scheduler level before dispatch.
- **Config as versioned state:** Agent configurations, workspace settings, and templates are versioned with full history. Every change is reversible.

## Key Technical Decisions

- **Storage:** Pure-Go SQLite (modernc.org/sqlite) over PostgreSQL -- zero-ops, embedded, cross-compiles, single file backup. WAL mode for concurrent reads.
- **Templates:** templ over Go `html/template` -- compile-time type safety, IDE support, composable components. No runtime template parsing errors.
- **Frontend:** HTMX over React/Vue/Svelte -- server-rendered HTML with surgical DOM updates. No JavaScript build step, no node_modules, no hydration. 14KB total JS footprint.
- **Scheduling:** Goroutine-per-agent over queue-based -- simpler, sufficient for single-node deployment, easy to reason about. Mutex-protected running map prevents double dispatch.
- **Auth:** API key with SHA256 hashing over JWT/OAuth -- simpler for agent-to-server authentication. Prefix-based lookup for O(1) key resolution. No token expiry management.
- **Serialization:** JSON for configs/metadata, raw text for stdout capture. No protobuf, no msgpack -- human readability matters for debugging agent outputs.

## Bottom Line

**What is thelastorg practically?**
The command center your AI agent fleet needs -- assign work, enforce budgets, monitor execution, review outputs, all from one dashboard deployed as a single binary.

**Is there anything like it?**
Pieces exist (Linear for tracking, custom scripts for dispatch, spreadsheets for costs), but no solution combines agent orchestration + issue tracking + cost controls + zero-ops deployment.

**Should you use it?**
If you run 2+ AI agents and have ever lost track of costs, duplicated work, or wished you had an audit trail -- yes.

**The opportunity:** First purpose-built, self-hosted agent management platform that deploys in 60 seconds and scales from a side project to an engineering organization.

## License

MIT
