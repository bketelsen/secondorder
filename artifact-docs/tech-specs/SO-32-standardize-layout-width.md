# Tech Spec: Standardize layout width across templates (SO-32)

## Goal
Standardize the content layout width across all UI pages (Dashboard, Workblocks, Activity, Cron, Settings, Issues, Agents, and Detail pages) to ensure UI consistency and facilitate easier global layout adjustments.

## Changes
1. **Extended Tailwind Config in `partials.html`**:
   - Added a custom `maxWidth.layout` mapping to the existing `--layout-max-w` CSS variable.
   - This allows using the `max-w-layout` utility class in any template.

2. **Updated Templates**:
   - Replaced hardcoded `max-w-6xl` with the standardized `max-w-layout` in all HTML templates:
     - `dashboard.html`
     - `policies.html` (Already fine, but updated for consistency)
     - `work_blocks.html`
     - `work_block_detail.html`
     - `activity.html`
     - `crons.html`
     - `settings.html`
     - `issues.html`
     - `issue_detail.html`
     - `agents.html`
     - `agent_detail.html`
     - `run_detail.html`
     - `not_found.html`

## Impact
- Changing the `--layout-max-w` variable in `partials.html` will now consistently update the maximum content width for all pages.
- UI consistency is maintained by referencing a single shared layout definition.
