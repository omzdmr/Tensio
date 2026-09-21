# Tensio — Project State

Last updated: 2026-09-22

## Current phase

**Foundation / premium UI slice**

## Current decisions

- Product name: Tensio
- Platforms: iOS + Android
- Shared UI/product core: Flutter
- Architecture: local-first, feature-oriented
- Native platform capabilities go behind adapters
- Health classifications will be sourced, versioned and separated from UI
- Repo documentation is the durable project memory
- Launch localization set: Turkish, English, Spanish, Brazilian Portuguese, French, German, Arabic, Simplified Chinese, Japanese and Korean
- App language must eventually be selectable independently of device language
- Arabic requires full RTL support

## Completed in foundation batch 001

- Master product specification
- Premium visual design system
- Roadmap + architecture decisions
- Durable handoff/project-memory rules
- Flutter package manifest and analyzer config
- GitHub Actions analyze/test workflow
- First premium Flutter experience:
  - dark theme foundation
  - dashboard
  - latest-reading hero card
  - one-tap measurement entry sheet
  - history screen
  - insights/averages screen
  - custom trend chart
  - profile/settings shell
  - centered global add action
- In-memory reading model/store for prototype behavior
- Dashboard smoke test
- Android/iOS bootstrap script
- Localization architecture document
- Flutter localization generation config
- Starter ARB catalogs for all 10 launch locales

## Verification status

Do not treat the build as verified green unless the latest GitHub Actions run confirms it.

Localization catalogs are now present, but existing screen copy is still largely hard-coded Turkish. The next localization slice must migrate widget strings to generated localization accessors and add in-app language selection.

## Immediate next work

### P0 — verify + real measurement lifecycle
1. Inspect latest CI and fix build/analyze issues first if red.
2. Generate/commit native iOS + Android project folders if not already present.
3. Introduce repository interface + local persistence.
4. Replace seed-only data with persisted readings.
5. Add edit/delete/duplicate flows.
6. Add date/time picker.
7. Add empty/loading/error states.
8. Improve accessibility semantics and dynamic-type behavior.
9. Expand unit/widget tests.

### P0 — localization wiring
1. Wire generated localizations into MaterialApp.
2. Migrate current hard-coded UI strings to ARB keys.
3. Add in-app language selector independent of device language.
4. Persist selected locale locally.
5. Verify Arabic RTL and long German/French labels.
6. Add localization/overflow tests.

### P1 — measurement quality
- repeated-reading sessions
- session average while preserving raw readings
- arm/posture/cuff/device/context
- measurement preparation timer
- sourced/versioned guideline classification engine

### P1 — daily system
- reminders
- medication tracking
- weight/heart-rate context
- Apple Health / Health Connect
- report/export system

## Handoff rule

Every development run must:
1. Read this file first.
2. Read PRODUCT_MASTER_SPEC.md before scope changes.
3. Read latest RESEARCH_LOG.md entries.
4. Inspect current HEAD before writing.
5. Make a meaningful batch, not one cosmetic tweak.
6. Inspect tests/CI when possible.
7. Update this file with what changed, what is next and blockers.
8. Never claim code works without code/CI evidence.

## Next recommended batch

**Latest CI health check, then persistence + real measurement lifecycle.** Localization wiring is the next parallel foundation slice and should not be forgotten.
