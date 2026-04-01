# SO-33: App Version Tracking

## Goal
Implement app version tracking by reading from a `VERSION` file in the root directory and displaying it on the Settings page.

## Implementation Details

### VERSION File
A `VERSION` file was created in the root directory containing the current version string (e.g., `v0.1.0`).

### Backend Changes
- Modified `internal/handlers/ui.go`'s `Settings` handler to read the `VERSION` file.
- If the file exists, its content is used as the app version.
- If the file does not exist, it falls back to `debug.ReadBuildInfo()` or "dev".

### UI Changes
- The Settings page (`internal/templates/settings.html`) already had a section for "App Version" which uses the `.Version` field passed from the handler. No template changes were strictly necessary, but I verified it works as expected.

## Verification
- Added `TestSettingsVersion` in `internal/handlers/handlers_test.go` to verify the version is correctly read and displayed.
- All tests passed.
