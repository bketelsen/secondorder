# Tech Spec: SO-36 Board Directives Active by Default

## Problem
Currently, when a board member (human) adds a new board directive, it defaults to an "inactive" state. The human must then manually toggle it to "active" for it to be used by agents during audits and work. This adds an unnecessary step and is counter-intuitive since the human just explicitly added the directive.

## Solution
Change the default state of newly created board directives to "active".

## Implementation Details

### 1. Database Layer (`internal/db/queries.go`)
- Modified `CreateBoardPolicy` to explicitly set `bp.Active = true`.
- Updated SQL query to match this default.

### 2. Database Schema (`internal/db/migrations/004_board_policies.sql`)
- Updated the default value for the `active` column from `0` to `1`. This ensures consistency for any direct SQL inserts.

### 3. Tests (`internal/db/db_test.go`)
- Renamed `TestBoardPolicyDefaultsToInactive` to `TestBoardPolicyDefaultsToActive`.
- Updated test expectations to verify that new policies are active by default.
- Updated `TestGetActiveBoardPoliciesExcludesInactive` to manually toggle a policy to inactive to test exclusion logic.

## Verification Results
- All related database tests passed.
- Verified that new board policies are created with `active=1`.
