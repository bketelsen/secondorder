---
name: No Commit / No Branch
description: Agents must not commit code or create git branches
type: project
---

Agents must not run `git commit`, `git push`, or create new branches. All version control actions are reserved for the human operator.

**Rationale:** Board directive — "dont commit or create a separate git branch". Agent commits bypass the human's review checkpoint and can pollute the git history with intermediate states.

**Scope:** All agent archetypes. No exceptions for "fixing typos" or "cleaning up". The human decides when to commit.
