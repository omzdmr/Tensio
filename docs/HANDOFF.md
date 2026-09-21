# Tensio Handoff / Continuity File

This file exists so a future ChatGPT session or developer can continue without relying on chat memory.

## Read first
1. `PRODUCT_MASTER_SPEC.md`
2. `DESIGN_SYSTEM.md`
3. `ARCHITECTURE.md`
4. `ROADMAP.md`
5. `RESEARCH_LOG.md`
6. recent commits

## Current product decisions
- Product name: Tensio.
- Platforms: iOS + Android.
- Shared app direction: Flutter.
- Native bridges: HealthKit on iOS, Health Connect on Android.
- Product must be premium visually and local-first.
- Core tracking works without an account.
- Initial 10 locales are documented in LOCALIZATION.md.
- Dark theme is the current hero direction; light theme is planned.
- Ads may be considered later, but never inside measurement, reports, urgent/safety content or health-targeted contexts.
- Clinical classification thresholds are intentionally not hard-coded yet.

## Current branch
`feature/foundation-v01`

## Current milestone
Foundation v0.1:
- product documentation,
- design tokens,
- app shell,
- localization bootstrap,
- premium home prototype,
- new measurement prototype.

## Next engineering steps
1. Bootstrap Flutter project files in repo.
2. Add Tensio design tokens/theme.
3. Implement app shell with Home / History / Add / Insights / Profile.
4. Build Home visual prototype.
5. Build New Measurement visual prototype.
6. Add localization plumbing and starter keys for all ten locales.
7. Add model/database only after UI/domain naming stabilizes.
8. Add tests as soon as measurement validation exists.

## Automation coordination

Research automation:
- appends dated findings to RESEARCH_LOG.md,
- creates actionable proposals,
- does not directly redesign random screens.

Development automation:
- reads this file and RESEARCH_LOG.md first,
- selects one substantial coherent batch,
- avoids tiny cosmetic commits,
- updates this file before ending.

## Definition of a useful development run

A useful run should produce a coherent piece of product value: a complete component family, screen flow, data slice, test-backed feature, or well-scoped refactor. One renamed variable and a victory speech do not qualify.
