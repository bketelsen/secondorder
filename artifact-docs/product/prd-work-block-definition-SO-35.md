# PRD: Refined Work Block Definition
Issue: SO-35 | Date: 2026-04-01

---

## Problem

The current work block concept is underspecified. `title` and `goal` are the only structured fields beyond status. This leaves ambiguity around:

- What "done" looks like for a block before shipping
- When cycle time should start (creation vs. activation)
- What a block represents relative to a deployment

Without a tighter definition, blocks become meaningless containers — just folders of issues with a status badge.

---

## What a Work Block Is

A work block is **one deployable slice of value**. It groups the minimum set of issues whose combined output can be reviewed and shipped as a unit. It is not a sprint (no time box), not an epic (no hierarchy), and not a project (no team ownership). It maps to exactly one deployment decision by a human operator.

### Boundaries

- **Too small**: a single issue with no coordination needed — just do the issue
- **Right-sized**: 3–10 issues that together produce one reviewable outcome (e.g., "user can invite teammates", "billing shows invoices correctly")
- **Too large**: 20+ issues spanning multiple independent features — split into multiple blocks

The size guidance is advisory, not enforced. One active block at a time remains a hard system constraint.

---

## Refined Data Model

### Current fields
| Field | Type | Notes |
|---|---|---|
| `title` | text | Short label for the block |
| `goal` | text | Free-text intent |
| `status` | enum | proposed → active → ready → shipped / cancelled |
| `created_at` | datetime | When proposed |
| `updated_at` | datetime | Last change |
| `completed_at` | datetime | Set on ship |

### Proposed additions
| Field | Type | Rationale |
|---|---|---|
| `activated_at` | datetime, nullable | Set when status → active. Cycle time must be measured from activation, not creation — time in "proposed" is waiting, not working. |
| `acceptance_criteria` | text | What must be true for this block to be ready to ship. Separate from goal (goal = intent, criteria = done condition). |

### What we do NOT add
- **Owner/assignee**: blocks are not owned by agents; the human operator is always the decision-maker on ship
- **Priority**: blocks are sequenced implicitly by activation order (one active at a time)
- **Deadline**: no time boxing by design
- **Deployment artifact/URL**: deployment happens outside SecondOrder; tracking it here is out of scope for now

---

## Status Lifecycle (Clarified)

```
proposed → active → ready → shipped
                 ↘         ↗
                   (back to active if not ready)
          ↓
       cancelled (from any non-terminal state)
```

| Status | Who can set it | Meaning |
|---|---|---|
| `proposed` | Human or CEO agent | Block has been scoped; not yet approved to start |
| `active` | Human operator only | Work is in flight; agents prioritize this block's issues; `activated_at` is stamped |
| `ready` | Human or CEO agent | All issues done (or explicitly signed off); awaiting operator ship decision |
| `shipped` | Human operator only | Operator approved; `completed_at` is stamped; block is immutable after this |
| `cancelled` | Human operator only | Block abandoned; issues remain but are unlinked from block goal |

**Key rules:**
1. Only one block may be `active` at a time — enforced at DB/handler level
2. Moving to `active` stamps `activated_at`; this is the cycle time start
3. `shipped` and `cancelled` are terminal — no transitions out
4. A block can return from `ready` → `active` if the operator sends it back for more work

---

## Metrics (Clarified)

Cycle time = `completed_at - activated_at` (not `created_at`). This measures actual working time, not queue time.

All other existing metrics (run count, total cost, issues planned/completed/cancelled) remain as-is.

---

## Acceptance Criteria Field: Usage Guidance

`acceptance_criteria` is optional but strongly encouraged for active blocks. Format is free text; markdown is acceptable. Agents (particularly the CEO) should read the acceptance criteria when evaluating whether a block is ready. Example:

> - User can log in with Google OAuth
> - Existing password login still works
> - Session persists across page refreshes
> - No 5xx errors in test run

The criteria are not automatically evaluated — they guide human review before shipping.

---

## What Changes

### DB
- Add `activated_at DATETIME` to `work_blocks` table
- Add `acceptance_criteria TEXT NOT NULL DEFAULT ''` to `work_blocks` table

### Handlers
- Stamp `activated_at = NOW()` when transitioning status to `active`
- Update cycle time calculation: use `activated_at` instead of `created_at`

### UI
- Add `acceptance_criteria` textarea to create and detail views (alongside `goal`)
- Show `activated_at` in the Timeline sidebar section
- Cycle time metric label: change "Cycle Time" → "Active Time" to signal it excludes queue time

### API
- Include `activated_at` and `acceptance_criteria` in work block JSON responses

---

## Out of Scope

- Automated acceptance criteria evaluation
- Block templates or presets
- Multi-block parallelism (one active at a time remains)
- Deployment integration / webhook on ship
- Block-level permissions or access control
