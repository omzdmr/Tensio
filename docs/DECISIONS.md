# Tensio — Architecture & Product Decisions

## ADR-001 Flutter shared core
Date: 2026-09-22

Use Flutter/Dart for the shared iOS/Android product foundation.

Why:
- one coherent premium design system
- fast iteration on a large feature surface
- native adapters remain possible for HealthKit, Health Connect, BLE and notifications

Consequence:
Cross-platform must not become an excuse to ignore native interaction conventions.

## ADR-002 Local-first
Date: 2026-09-22

Core measurement/history features work without login or network.

Why:
Health tracking is personal and should remain useful offline.

## ADR-003 Clinical logic outside UI
Date: 2026-09-22

Classification thresholds belong to a sourced, versioned guideline engine.

Why:
Organizations/regions differ and guidelines change. Raw measurements must outlive interpretation logic.

## ADR-004 Project memory in Git
Date: 2026-09-22

PROJECT_STATE plus master docs are mandatory handoff artifacts.

Why:
The project must survive lost chat context, model changes and contributor handoffs.

## ADR-005 Monetization separation
Date: 2026-09-22

Premium and future ads must sit behind service/UI abstractions.

Health measurements, urgent messaging and sensitive data may never become ad-targeting inputs.
