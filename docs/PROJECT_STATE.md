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

Current HEAD before this state update: `484c984ee7c3dd74c42ae8a3ed6daeb9b67bd495`.

## Verification status

GitHub Actions was still running for the latest foundation HEAD when this file was updated. Do not treat the build as verified green until a later run records success.

The first CI run created before application files existed failed and is not evidence about the completed foundation slice.

## Immediate next work

### P0 — real measurement lifecycle
1. Confirm/fix CI until latest HEAD is green.
2. Generate and commit native iOS + Android project folders.
3. Introduce repository interface + local persistence.
4. Replace seed-only data with persisted readings.
5. Add edit/delete/duplicate flows.
6. Add date/time picker.
7. Add empty/loading/error states.
8. Improve accessibility semantics and dynamic-type behavior.
9. Expand unit/widget tests.

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

**Persistence + real measurement lifecycle**, unless latest CI is red. If CI is red, fix CI/build first and only then continue feature work.
