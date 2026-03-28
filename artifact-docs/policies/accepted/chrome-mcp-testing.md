---
name: Chrome MCP for Testing
description: QA must use Chrome MCP for browser-based verification, not manual description
type: project
---

All QA browser verification must use Chrome MCP. Screenshots, console output, and network tab evidence must be captured via Chrome MCP and included in completion comments.

**Why:** Board directive — "testing should use chrome mcp". Browser-based issues (XSS, UI regressions, accessibility) cannot be reliably verified by reading code alone.

**How to apply:** QA engineer must use Chrome MCP for any issue that involves UI, templates, or browser behavior. Text descriptions of visual state are not sufficient — attach Chrome MCP evidence.
