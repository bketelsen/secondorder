# Decision: SO-28 Runner Dispatch — 14 Runs Root Cause

Date: 2026-04-05

## Context

SO-28 (Implement runner dispatch for Codex and Antigravity CLIs) required 14 runs — the highest run count in project history.

## Root Cause

CLI runner integration spans multiple systems: scheduler, subprocess management, environment variable injection, stdout/stderr handling, and error propagation. Attempting to integrate all layers in a single pass made partial failures invisible. When Stage 2 failed, it was unclear whether Stage 1 was solid.

No protocol existed requiring incremental delivery with checkpoints.

## Decision

Added `incremental-delivery.md` policy: complex work (>3 files or 2+ systems) must be staged. Stage 1 must pass gates.sh before Stage 2 begins.

Added incremental delivery section to founding-engineer archetype (patch submitted audit 9541c09f).

## Feature request

SO-95: workflow-level incremental delivery checkpoints.
