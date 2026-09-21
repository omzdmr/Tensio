# Tensio — Product Master Specification

## Vision

Tensio should be the one app a person needs for routine blood-pressure tracking: capture, context, trends, reminders, medication, reports, health-platform integrations and device imports without forcing an account or a permanent cloud dependency.

## Core promise

**Capture quickly. Understand patterns. Remember what matters. Share cleanly. Keep control of the data.**

## Home

- latest reading
- next measurement/reminder
- one-tap add
- 7-day trend
- medication status
- useful context cards
- shortcuts to report/history
- no clutter for features the user has not enabled

## Measurement

Core:
- systolic
- diastolic
- pulse
- date/time

Context:
- arm
- posture
- cuff/device
- morning/midday/evening/night
- before/after medication
- before/after meal
- caffeine
- nicotine/smoking
- exercise
- stress
- sleep quality
- symptoms
- free note
- source

Session:
- repeated readings
- optional preparation timer
- session average
- raw readings always retained

## History

- list
- calendar
- day grouping
- search/filter
- edit/delete
- tags/context
- source indication
- expand repeated-reading session

## Insights

- 7/30/90 day + custom range
- systolic/diastolic/pulse trends
- averages
- variability
- morning vs evening
- weekday/time-of-day comparison
- context correlations only with enough data
- measurement consistency
- data-quality hints
- no invented causality

## Reports

- custom range
- summary
- reading table
- charts
- medication summary
- notes
- PDF
- CSV
- print/share
- clinician compact mode

## Reminders

- recurring measurement windows
- medication reminders
- snooze
- missed reminder recovery
- quiet hours
- time-zone behavior

## Medication

- medicine
- dose
- schedule
- taken/skipped/missed
- refill reminder
- history
- report inclusion

## Optional health context

- weight
- resting heart rate
- activity
- sleep
- sodium/diet note
- hydration
- stress
- smoking/nicotine
- caffeine

These exist to explain blood-pressure context, not to become an unfocused “everything health” app.

## Integrations

- Apple Health
- Android Health Connect
- Bluetooth blood-pressure monitors
- import/export
- optional secure backup later

## Onboarding

Short and skippable:
1. product promise
2. feature overview
3. optional personalisation
4. optional Health/Health Connect
5. optional reminders
6. usable app

Account creation must not block first use.

## Clinical/guideline handling

- raw readings are permanent facts
- classification logic lives in a dedicated engine
- guideline organization/version/region must be recorded
- changing guidelines must not rewrite raw readings
- no diagnosis from a single reading
- high-risk messaging requires authoritative sources and tests
- clinical rules never live directly in widgets

## Data model direction

- UserProfile
- PressureReading
- MeasurementSession
- MeasurementContext
- Medication
- MedicationDoseEvent
- Reminder
- WeightEntry
- Device
- ImportSource
- GuidelineProfile
- ReportTemplate
- SyncState

Every health record should reserve stable ID, createdAt, measuredAt, updatedAt, source and future sync/deletion metadata.

## Privacy

- offline useful by default
- no account required
- local storage first
- cloud backup opt-in
- least-privilege permissions
- analytics must avoid raw health values
- exports belong to the user
- no sensitive-health-data ad targeting

## Premium

Free remains genuinely useful. Premium can add advanced reports, deep long-range analytics, multiple profiles, richer automation, advanced device integrations and encrypted backup/sync.

Basic measurement/history must not be crippled by a hostile paywall.

## Advertising

If ads are added later:
- never inside measurement entry
- never in urgent/high-risk health messaging
- never disguised as advice
- never targeted from raw health measurements
- low-friction placements only
- premium removes ads

## Accessibility

- dynamic text
- screen-reader semantics
- color is never the only status signal
- large touch targets
- one-handed primary actions
- reduced-motion support
- readable chart summaries

## Localization

Tensio launches with ten first-class languages on both iOS and Android:

- Turkish
- English
- Spanish
- Brazilian Portuguese
- French
- German
- Arabic
- Simplified Chinese
- Japanese
- Korean

Language selection is independent of device language, while “use device language” remains available. Arabic requires full RTL behavior. Dates, numbers, units, notifications, reports, accessibility labels and store-facing content are localization scope. See `docs/LOCALIZATION.md` for the implementation contract.

## Definition of done

A feature needs: useful happy path, empty/error state where relevant, persistence where relevant, accessibility, tests for core logic, privacy review where relevant, and updated project state.
