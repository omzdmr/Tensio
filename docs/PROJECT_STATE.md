# Tensio — Project State

Last updated: 2026-09-22

## Current phase

**Foundation / premium UI slice → real app foundation**

## Current decisions

- Product name: Tensio
- Platforms: iOS + Android
- Shared UI/product core: Flutter
- Architecture: local-first, feature-oriented
- Native platform capabilities go behind adapters
- Health classifications are sourced/versioned and separated from UI
- Repo documentation is the durable project memory
- Launch localization set: Turkish, English, Spanish, Brazilian Portuguese, French, German, Arabic, Simplified Chinese, Japanese and Korean
- App language is selectable independently of device language
- Arabic requires full RTL support

## Completed

- Master product specification
- Premium visual design system
- Complete premium UX blueprint
- Roadmap and architecture decisions
- Durable GitHub handoff rules
- Flutter package/analyzer foundation
- GitHub Actions analyze/test workflow
- First premium Flutter UI slice:
  - dark theme foundation
  - dashboard
  - latest-reading hero card
  - one-tap measurement entry sheet
  - history
  - insights/averages
  - custom trend chart
  - profile/settings shell
  - centered global add action
- In-memory prototype reading store
- Dashboard smoke test
- Android/iOS bootstrap script
- Localization architecture
- Starter ARB catalogs for all 10 launch languages
- Explicit ten-language enum/tests
- Portuguese and Chinese base fallback catalogs required by Flutter localization generation
- Production architecture blueprint in `docs/ARCHITECTURE.md`
- Root continuity instructions in `AGENTS.md`

## Current verification status

The previous HEAD `cbecaf451b3129fdf1625609035a4df3b31379d1` failed during `flutter pub get` because Flutter required base fallback ARB files for `pt_BR` and `zh_Hans`.

Fixes were committed:
- Portuguese base fallback: `0bb0fbdc5a29930adefe00f13719a46ec7016684`
- Chinese base fallback: `948b907b0b8a5e756bbab75c671efc66dac632c3`

At the time of this update, CI for the latest localization fix is still being re-verified. Do not call the project green until a current-HEAD run succeeds.

## Important implementation reality

The visual prototype is real, but much of the screen copy in `lib/main.dart` remains hard-coded Turkish. ARB catalogs existing is not the same thing as complete localization.

The prototype also still uses seeded in-memory readings. Persistence, edit/delete and restart survival are not yet complete.

## Immediate next work

### P0 — CI + localization
1. Confirm current CI.
2. If red, fix the actual log error before feature work.
3. Wire generated localizations into `MaterialApp`.
4. Migrate visible prototype copy from hard-coded Turkish to localization keys.
5. Add in-app language selector and local persistence.
6. Verify Arabic RTL plus German/French overflow.

### P0 — real measurement lifecycle
1. Introduce `ReadingRepository`.
2. Add structured local persistence with migrations.
3. Replace seeded-only data with persisted data.
4. Add edit/delete with undo where practical.
5. Add measurement date/time picker.
6. Add empty/loading/error states.
7. Add restart persistence tests.

### P0 — platforms
1. Generate and commit Android/iOS native scaffolding.
2. Add Android and iOS build smoke checks once scaffolding exists.
3. Keep HealthKit / Health Connect behind adapters.

## Later sequence

- repeated-reading sessions and derived averages
- measurement context and preparation timer
- sourced/versioned guideline engine
- reminders + medication
- reports PDF/CSV
- Apple Health + Health Connect
- BLE device imports
- deeper insights
- optional encrypted backup/sync
- premium/ad readiness
- release hardening and store localization

## Handoff rule

Every development run must:
1. Read this file first.
2. Read product, UX, design, architecture and latest research.
3. Inspect current HEAD before writing.
4. Inspect current CI.
5. Make a coherent meaningful batch.
6. Add/update relevant tests.
7. Update this file and ROADMAP when status changes.
8. Never claim success without evidence.

## Next recommended batch

**Finish CI verification, then localization plumbing and the first repository/persistence slice.**
