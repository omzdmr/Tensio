# Tensio

Tensio is a premium, privacy-first blood pressure and heart-health companion for iOS and Android.

The product goal is simple: a person should be able to record, understand, organize and share their blood-pressure-related health data without needing a second tracking app.

## Product principles

- Premium, calm and readable UI instead of a clinical spreadsheet.
- iOS and Android are first-class platforms.
- Local-first. Core tracking must work offline.
- No account required for basic use.
- User-owned data, explicit export and backup.
- No diagnosis theatre. Tensio explains patterns and helps users prepare useful records for clinicians.
- Accessibility is part of the design system, not a later patch.
- Localization is built in from day one.

## Initial languages

Turkish, English, Spanish, Brazilian Portuguese, French, German, Arabic, Simplified Chinese, Japanese and Korean.

The language can be changed independently of the device language. Arabic must support complete RTL layout mirroring.

## Tech direction

Flutter is used for the shared app, design system, offline data and most feature logic. Native integrations stay native where that is the better platform fit:

- iOS: HealthKit, notifications, background behavior, share sheet.
- Android: Health Connect, notifications, background behavior, share sheet.

## Repository map

- `docs/PRODUCT_MASTER_SPEC.md` — canonical product scope.
- `docs/DESIGN_SYSTEM.md` — visual language, components, motion and accessibility.
- `docs/ARCHITECTURE.md` — engineering architecture and data boundaries.
- `docs/LOCALIZATION.md` — multilingual requirements.
- `docs/ROADMAP.md` — implementation sequence.
- `docs/HANDOFF.md` — the first file a future ChatGPT/developer should read.
- `docs/RESEARCH_LOG.md` — market and user-feedback findings.
- `lib/` — application source.

## Current status

Foundation v0.1 is being built on `feature/foundation-v01`.

The first milestone is not "make every screen". It is to establish the design system, navigation shell, data model, localization architecture and measurement flow so future features do not become ten unrelated mini-apps wearing the same logo.
