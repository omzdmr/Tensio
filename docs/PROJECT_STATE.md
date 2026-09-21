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

## What is being built first

1. Premium dashboard
2. Fast manual measurement entry
3. Measurement history
4. Trend/insight screen
5. Profile/settings shell
6. Local persistence
7. iOS/Android native project scaffolding
8. CI/tests

## Immediate next work

### P0
- complete first runnable Flutter UI slice
- generate/commit native iOS + Android folders
- add local database/repository abstraction
- persist measurements
- edit/delete/duplicate flows
- date/time selector
- empty/loading/error states
- accessibility semantics
- tests

### P1
- repeated-reading sessions
- session averaging while preserving raw readings
- arm/posture/cuff/device/context fields
- measurement preparation timer
- sourced/versioned guideline classification engine
- reminders
- medication tracking
- weight/heart-rate context
- Apple Health + Health Connect
- reports/export

## Handoff rule

Every development run must:
1. Read this file first.
2. Read PRODUCT_MASTER_SPEC.md before scope changes.
3. Read latest RESEARCH_LOG.md entries.
4. Make a meaningful batch, not one cosmetic tweak.
5. Inspect tests/CI when possible.
6. Update this file with what changed, what is next and blockers.
7. Never claim code works without code/CI evidence.

## Next recommended batch

**Real measurement lifecycle:** native scaffolding + local persistence + add/edit/delete/history working from persisted data.
