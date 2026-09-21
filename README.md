# Tensio

Premium, privacy-first blood-pressure and cardiovascular wellness tracker for **iOS and Android**.

## Product promise

Tensio should make blood-pressure tracking calm, fast and useful enough that a user does not need separate apps for measurements, trends, reminders and reports.

## Technical direction

- Flutter / Dart shared product core
- Native adapters for Apple Health, Health Connect, notifications and BLE
- Local-first storage
- Useful without an account
- Premium light/dark design system
- Clinician-friendly export/report path
- Accessibility from day one

## Project memory

Future ChatGPT sessions and contributors should read, in order:

1. `docs/PROJECT_STATE.md`
2. `docs/PRODUCT_MASTER_SPEC.md`
3. `docs/DESIGN_SYSTEM.md`
4. `docs/ROADMAP.md`
5. `docs/RESEARCH_LOG.md`
6. `docs/AUTOMATION_RULES.md`

`PROJECT_STATE.md` is the canonical answer to “where were we and what comes next?”

## Bootstrap

```bash
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh
flutter analyze
flutter test
flutter run
```

Foundation sprint started: 2026-09-22.
