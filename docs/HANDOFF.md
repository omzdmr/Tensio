# Tensio Handoff / Continuity File

This file is the continuity source for future ChatGPT sessions, automations and developers. Do not depend on chat history.

## Read first
1. `docs/PRODUCT_MASTER_SPEC.md`
2. `docs/DESIGN_SYSTEM.md`
3. `docs/ARCHITECTURE.md`
4. `docs/ROADMAP.md`
5. `docs/RESEARCH_LOG.md`
6. this file
7. recent commits / open issues

## Product decisions that must survive handoffs
- Product name: **Tensio**.
- Platforms: **iOS + Android**.
- Shared app direction: Flutter.
- Native health bridges: HealthKit on iOS, Health Connect on Android.
- Visual direction: premium, calm, dark-first, warm coral accent, dense information with breathing room.
- Local-first. Core tracking must work offline and without a mandatory account.
- Initial locales: Turkish, English, Spanish, Brazilian Portuguese, French, German, Arabic, Simplified Chinese, Japanese and Korean.
- Language selection must eventually be independent from device language.
- Arabic requires full RTL.
- Ads may be considered later, but never during measurement, in reports, in urgent/safety content, or targeted from health measurements.
- Clinical classification thresholds are intentionally **not** hard-coded until the reference policy is documented.

## Foundation status — 2026-09-22
Implemented on `feature/foundation-v01`:
- expanded project README,
- master product spec,
- design system,
- architecture spec,
- localization spec,
- research log,
- roadmap,
- Flutter pubspec/lint/l10n setup,
- Tensio dark design tokens,
- shared SurfaceCard component,
- five-destination app shell with central measurement action,
- premium Home prototype,
- New Measurement prototype,
- History prototype,
- Insights prototype,
- Profile/Settings prototype,
- starter ARB catalogs for all 10 agreed locales.

Important limitation:
- Current prototype screen copy is still mostly hard-coded Turkish. ARB catalogs exist but generated strings are not yet wired into each screen.
- Measurement save is intentionally a visual prototype and does not persist yet.
- Native `ios/` and `android/` runner projects/CI bootstrap are still pending.

## Next engineering batch
The next substantial batch should be **Core Persistence v0.1**, not random cosmetics:

1. Add typed local database layer.
2. Define Measurement domain entity and source/provenance fields.
3. Add conservative input validation without medical classification.
4. Persist measurement from New Measurement screen.
5. Drive History from stored measurements.
6. Add empty state and delete/edit path.
7. Add unit/repository/widget tests for this slice.
8. Update ROADMAP and this HANDOFF.

Parallel small foundation work is allowed only if required by that batch:
- localization wiring,
- Android/iOS runner bootstrap,
- CI.

## Research-to-development protocol
Research automation writes evidence to `docs/RESEARCH_LOG.md` and may create a GitHub issue when a finding is actionable.

Development automation:
1. reads master spec + handoff + research log,
2. checks recent commits/open issues,
3. chooses one coherent substantial batch,
4. avoids duplicate/conflicting work,
5. implements and tests as much of that batch as possible,
6. updates roadmap/handoff before ending.

Research suggestions do not automatically override the master spec.

## Definition of a useful development run
A useful run delivers a coherent piece of product value: a complete component family, screen flow, data slice, test-backed feature or well-scoped refactor.

One renamed variable, one padding tweak, or a ceremonial README edit followed by "done" does not qualify.
