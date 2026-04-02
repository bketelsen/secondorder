# Layout Widths — Design Spec (SO-43)

## Overview

All pages share a single, consistent layout structure. There are no per-page width overrides.

## Layout Structure

```
┌──────────────────────────────────────────────────────────┐
│ Top accent bar (3px, full width, z-50)                   │
├────────────┬─────────────────────────────────────────────┤
│            │  <main>  p-8 (32px all sides)               │
│  Sidebar   │  ┌─────────────────────────────────────────┐│
│  w-56      │  │  max-w-6xl (1152px) · mx-auto           ││
│  (224px)   │  │                                         ││
│  fixed     │  │  Page content                           ││
│            │  │                                         ││
│            │  └─────────────────────────────────────────┘│
└────────────┴─────────────────────────────────────────────┘
```

## CSS Custom Properties

Defined in `partials.html` `:root` block:

| Variable              | Value   | Tailwind eq.  | px   | Usage                              |
|-----------------------|---------|---------------|------|------------------------------------|
| `--layout-sidebar`    | 14rem   | `w-56`        | 224  | Sidebar width (fixed)              |
| `--layout-max-w`      | 72rem   | `max-w-6xl`   | 1152 | Page content max width             |
| `--layout-pad`        | 2rem    | `p-8`         | 32   | Main padding (all sides, desktop)  |
| `--layout-pad-top-mob`| 4rem    | `pt-16`       | 64   | Top padding on mobile (hamburger)  |

## Template Pattern

Every page must use this exact `<main>` + inner `<div>`:

```html
<main class="flex-1 ml-0 md:ml-56 p-8 pt-16 md:pt-8 mt-[3px]">
  <div class="max-w-6xl mx-auto">
    <!-- page content -->
  </div>
</main>
```

- `ml-0 md:ml-56` — offset for fixed sidebar on md+ screens
- `p-8 pt-16 md:pt-8` — uniform 32px padding; top bumped to 64px on mobile to clear hamburger button
- `mt-[3px]` — clears the top accent bar
- `max-w-6xl mx-auto` — caps content at 1152px and centers it

## Breakpoints

| Breakpoint | Behavior                          |
|------------|-----------------------------------|
| < 768px    | Sidebar hidden, hamburger shown   |
| ≥ 768px    | Sidebar fixed at 224px            |

Content never exceeds 1152px regardless of viewport width.

## Pages Using This Pattern

All 10 page templates:
- dashboard.html
- agents.html / agent_detail.html
- issues.html / issue_detail.html
- work_blocks.html / work_block_detail.html
- activity.html
- crons.html
- settings.html
- run_detail.html
