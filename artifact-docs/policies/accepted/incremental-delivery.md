---
name: Incremental Delivery for Complex Work
description: Founding Engineer must deliver complex multi-system implementations in stages
type: project
---

For any implementation touching >3 files or integrating 2+ systems, deliver in stages. Comment on the issue when Stage 1 passes gates.sh before proceeding.

**Why:** SO-28 (14 runs) — full CLI runner integration attempted in a single pass. Partial state was invisible to the reviewer, leading to cascading failures across all stages simultaneously.

**How to apply:** Founding Engineer identifies stages in their first comment. CEO reviewer can see stage progress. A passing Stage 1 is always shipped before Stage 2 begins.
