# Decision: SO-55 API Reassignment — 12 Runs Root Cause

Date: 2026-04-05

## Context

SO-55 (API: Support reassignment in UpdateIssue) required 12 runs — second highest in project history for a backend-only change.

## Root Cause

Acceptance criteria did not specify the full API contract: which fields were patchable, what happened when assignee_slug was empty, whether partial updates were idempotent. Each QA run discovered a different missing case. The CEO issue was "support reassignment" without enumerating the cases.

## Decision

Added `acceptance-criteria-completeness.md` policy: API issues must specify endpoint, method, request/response shape, and all error cases before assignment.

Added acceptance criteria standards section to CEO archetype (patch submitted audit 9541c09f).

## Feature request

SO-96: acceptance criteria completeness validator in the issue creation flow.
