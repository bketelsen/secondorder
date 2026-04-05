---
name: Acceptance Criteria Completeness
description: CEO must provide complete specs for API and backend issues
type: project
---

API issues must specify: endpoint path, HTTP method, request shape, response shape, and all error cases. Backend issues must specify inputs, outputs, and failure modes. Vague criteria are not acceptable.

**Why:** SO-55 (12 runs) — API reassignment issue had incomplete criteria, causing repeated QA rejection cycles where each pass discovered a different missing case.

**How to apply:** CEO reviews the issue description before assigning. If any required field is missing from an API/backend issue, CEO adds it before the issue leaves their hands.
