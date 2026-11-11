# 2.0.1

## Fixes

- **Fixed crash when applying paragraph-style modifiers to empty components.** Previously, calling any paragraph-style modifier (e.g. `alignment(_:)`, `lineSpacing(_:)`, `firstLineHeadIndent(_:)`) on an empty component (`RText("")`, `""`, or an empty `RLink`) terminated the app with an uncaught `NSRangeException`. The attributes lookup now safely returns an empty set for zero-length strings, making these calls no-ops instead of crashes. *(Found by automated security scan; classified as a robustness fix — not a security vulnerability, as it is only triggerable by the app's own code.)*

## Changes

- **Removed macOS support.** The library now supports iOS and watchOS only. All `canImport(AppKit)` code paths were removed and `RFont`/`RColor`/`RImage` are now unconditionally `UIFont`/`UIColor`/`UIImage`.
  - Removed the macOS-only `Ligature.all` case.
  - Removed the macOS-only `vertical(range:)` modifier.
- **Corrected package platform declarations.** `Package.swift` previously declared macOS 10.13 while `RequestBuilder` uses APIs requiring macOS 12+; the macOS entry was removed entirely along with platform support.

## Testing

- Added a 7-case regression suite covering the empty-component crash scenarios and safe edge cases (whitespace content, non-paragraph modifiers).
- Full test suite (138 tests, 23 suites) verified on the iOS simulator.
