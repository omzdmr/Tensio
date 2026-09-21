# Tensio — Application Architecture

This document defines the intended production architecture for the iOS and Android app. It is deliberately more durable than any single chat session.

## 1. Product architecture principle

Tensio is a local-first health tracker. Manual blood-pressure tracking must remain useful without an account, network connection, cloud service or wearable integration.

The application is split into four layers:

1. **Presentation** — Flutter screens, reusable components, navigation, accessibility and platform-adaptive interaction.
2. **Application** — use-cases such as add/edit/delete reading, build session average, create report, schedule reminder and import health data.
3. **Domain** — health records, validation, calculation, source attribution and versioned guideline interpretation.
4. **Infrastructure** — local database, secure preferences, HealthKit, Health Connect, BLE, notifications, exports and optional sync.

Widgets must never contain clinical thresholds or persistence logic.

## 2. Flutter module direction

Target structure:

```
lib/
  app/
    tensio_app.dart
    navigation/
    theme/
  core/
    accessibility/
    localization/
    platform/
    privacy/
    time/
  features/
    dashboard/
    measurements/
      data/
      domain/
      presentation/
    history/
    insights/
    reports/
    reminders/
    medications/
    connections/
    profile/
    premium/
  services/
    health_platform/
    notifications/
    export/
    backup/
  l10n/
```

The current single-file prototype may be split incrementally. Do not perform a giant cosmetic refactor while core behavior is still unstable.

## 3. Blood-pressure data model

A reading is an immutable health fact plus editable metadata.

Minimum production fields:

- stable UUID
- systolic mmHg
- diastolic mmHg
- pulse bpm
- measuredAt
- createdAt
- updatedAt
- source
- deviceId optional
- measurementSessionId optional
- arm optional
- posture optional
- before/after medication optional
- before/after meal optional
- caffeine/nicotine/exercise/stress/sleep context optional
- symptom tags
- free note
- excludedFromDerivedAverage flag where applicable

Editing a record changes user-entered data but must preserve timestamps needed for audit/sync behavior.

## 4. Measurement sessions

A session groups repeated readings without destroying raw values.

A derived average:
- references the session;
- does not replace raw readings;
- can exclude an explicitly marked accidental reading;
- records the algorithm/version if averaging rules later become configurable.

## 5. Persistence

Production storage should use a structured local database, not an in-memory list.

Requirements:
- transactional writes;
- schema migrations;
- deterministic ordering;
- indexes on measuredAt, source and session ID;
- soft-deletion/sync metadata reserved even before cloud sync exists;
- repository interfaces so UI is independent from the database package.

Initial repository contracts:

```
ReadingRepository
  watchReadings(range/filter)
  getReading(id)
  addReading(reading)
  updateReading(reading)
  deleteReading(id)
  restoreReading(id)

SettingsRepository
  get/set locale
  get/set theme
  get/set units
  get/set reminder preferences
```

## 6. Health integrations

Use adapters:
- iOS: HealthKit
- Android: Health Connect

Rules:
- imported records retain source attribution;
- imports are deduplicated;
- permissions are requested in context;
- denied permission never breaks manual tracking;
- raw health data is not sent to analytics.

## 7. Bluetooth devices

BLE support sits behind a `BloodPressureDeviceGateway`.

The rest of the app should consume normalized measurements instead of vendor-specific packets. Device support is registry-based so one problematic monitor integration does not infect the measurement domain.

## 8. Guideline engine

Classification is separate from recording.

Input:
- raw reading/session;
- guideline profile;
- guideline version;
- region/configuration when relevant.

Output:
- structured interpretation code;
- localized display key;
- provenance/source metadata.

A guideline update may change interpretation, never historical raw values.

## 9. Localization

The product has ten selectable launch languages:
Turkish, English, Spanish, Brazilian Portuguese, French, German, Arabic, Simplified Chinese, Japanese and Korean.

Flutter generation may contain technical base fallback catalogs such as `pt` and `zh`; those do **not** create extra user-facing language choices.

All user-facing copy ultimately comes from localization resources. Arabic requires full RTL QA. Reports, notifications, accessibility labels and store copy are localization scope.

## 10. Reports

Reports are generated from domain data, not screenshots.

Pipeline:
1. query data;
2. compute reproducible summary;
3. render neutral printable document;
4. export PDF/CSV;
5. share/print through native surface.

Generated reports must include date range, generation timestamp and enough source metadata to understand what was included.

## 11. Reminders and medication

Scheduling logic belongs outside widgets. The app stores reminder intent, then translates it to platform notifications.

Timezone changes and daylight-saving changes must not silently shift a user's intended routine.

Medication tracking is contextual support for blood-pressure tracking, not prescribing software.

## 12. Premium and advertising boundaries

Entitlements are exposed behind a service and must not leak payment-provider checks throughout widgets.

If advertising is introduced:
- no ad in measurement entry;
- no ad in urgent/high-risk messaging;
- no ad in clinician reports;
- no sensitive health value used for targeting;
- premium removes ads.

## 13. Testing layers

Minimum expectations:
- domain unit tests for calculations/validation;
- repository tests for persistence/migrations;
- widget tests for core flows;
- localization/RTL/overflow tests;
- integration tests for add → persist → restart → history;
- adapter tests with fakes for HealthKit/Health Connect/BLE;
- golden tests only for stable high-value visual components.

## 14. CI gates

A development batch is not complete merely because a commit exists.

Required gates as the project matures:
- `flutter pub get`
- localization generation
- `flutter analyze`
- `flutter test`
- Android build smoke
- iOS compile smoke on macOS runner when native scaffolding is committed

Never mark PROJECT_STATE green without evidence from the current HEAD.

## 15. Near-term migration from prototype

Order:
1. keep CI green;
2. finish localization plumbing;
3. introduce repository abstraction;
4. replace seeded in-memory data with local persistence;
5. add edit/delete/date-time flows;
6. add empty/error/loading states;
7. split the large prototype file by feature as behavior stabilizes;
8. add native iOS/Android scaffolding and platform adapters;
9. move into repeated-reading sessions and reports.

This order prevents architecture theater from replacing an actually usable app.
