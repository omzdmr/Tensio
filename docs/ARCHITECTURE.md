# Tensio Architecture v0.1

## 1. Strategy

Tensio uses Flutter for the shared product layer and platform-native bridges for OS-specific health and background capabilities.

Goals:
- one coherent design system,
- shared domain rules,
- offline-first operation,
- testable feature modules,
- no business logic trapped inside UI widgets.

## 2. Proposed layers

```
lib/
  app/
  core/
    database/
    design/
    localization/
    notifications/
    platform/
    privacy/
  features/
    home/
    measurements/
    history/
    insights/
    reports/
    reminders/
    medications/
    weight/
    settings/
    integrations/
```

Each feature is split as needed into:
- domain,
- data,
- presentation.

Do not create architectural ceremony for tiny features. Boundaries exist to make change safer, not to impress a diagram.

## 3. State management

Initial direction: Riverpod.

Reasons:
- explicit dependencies,
- testable state,
- good async handling,
- avoids a global mutable service swamp.

## 4. Navigation

GoRouter or equivalent declarative routing.

Requirements:
- deep-linkable report/settings destinations later,
- central tab shell,
- modal add flow,
- predictable back stack.

## 5. Local database

Planned: SQLite-backed persistence through Drift or an equivalent typed layer.

Core entities:

### Measurement
- id
- profileId
- systolic
- diastolic
- pulse
- measuredAt
- timezoneOffsetAtCapture
- arm
- posture
- context
- note
- source
- externalSourceId
- createdAt
- updatedAt

### MeasurementSession
- id
- profileId
- startedAt
- endedAt
- optional note

### MeasurementSessionItem
- sessionId
- measurementId
- sequence

### Medication
- id
- profileId
- name
- doseText
- schedule metadata
- active state

### MedicationEvent
- id
- medicationId
- scheduledAt
- state
- recordedAt

### WeightEntry
- id
- profileId
- value
- unit
- measuredAt
- source

### Reminder
- id
- profileId
- type
- schedule
- enabled
- quiet-hour behavior

### Profile
- id
- displayName
- locale
- unit preferences
- report fields

## 6. IDs and time

- UUID-like local IDs.
- Store timestamps in UTC plus capture timezone metadata when relevant.
- Display in user's current/localized timezone policy.
- Never infer that two readings are duplicates only because values match.

## 7. Integrations

HealthKit and Health Connect stay behind a common domain interface.

Example:
`HealthDataGateway`
- requestReadPermissions()
- requestWritePermissions()
- importMeasurements(range)
- importWeight(range)
- exportMeasurement(item)

Imported records include source provenance.

## 8. Sync/backup

Core v1 does not require a backend.

Backup direction:
- explicit user export,
- optional platform/cloud backup later,
- encrypted structured archive preferred.

Sync is deliberately separated from local persistence so the app does not become unusable when a cloud API sulks.

## 9. Privacy

- minimize telemetry,
- never log measurement values to analytics/crash breadcrumbs,
- strip sensitive values from debug logging,
- secrets only in platform secure storage,
- no health-based ad targeting.

## 10. Testing

Required layers:
- unit tests for validation/domain calculations,
- repository/database tests,
- widget tests for critical flows,
- golden tests for major design states where practical,
- integration tests for measurement creation/history.

Clinical/range logic receives dedicated tests only after reference policy is documented.

## 11. CI target

GitHub Actions eventually runs:
- format,
- analyze,
- unit/widget tests,
- localization validation,
- Android debug build,
- iOS compile check where runner/signing constraints allow.

## 12. Release discipline

Main should remain releasable.

Branch pattern:
- feature/*
- fix/*
- chore/*

Substantial changes should update:
- relevant spec,
- HANDOFF,
- tests,
- research log if market-driven.
