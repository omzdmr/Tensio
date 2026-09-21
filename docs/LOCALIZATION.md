# Tensio — Localization & Language Architecture

## Launch requirement

Tensio launches with **10 fully supported languages** across iOS and Android. Localization is a product capability, not a final-week translation pass.

Supported launch locales:

1. Turkish — `tr`
2. English — `en`
3. Spanish — `es`
4. Brazilian Portuguese — `pt-BR`
5. French — `fr`
6. German — `de`
7. Arabic — `ar`
8. Simplified Chinese — `zh-Hans`
9. Japanese — `ja`
10. Korean — `ko`

## Core rules

- No user-facing string may be hard-coded in feature widgets once localization migration begins.
- Users can select an app language independently of device language.
- “Use device language” remains available as an option.
- The selected app language is persisted locally.
- Arabic must support full RTL layout, not merely translated text.
- Date, time, decimal, percentage and unit formatting must follow locale conventions.
- Translation keys must describe meaning, not screen coordinates or visual position.
- Medical wording must be reviewed for clarity and consistency. Literal machine translation is not sufficient for release.
- PDF/CSV/report labels, reminders, notifications, onboarding, widgets and share text are part of localization scope.
- Accessibility labels and semantic chart summaries are localized too.

## Fallback behavior

1. Exact locale, e.g. `pt-BR`
2. Language family where appropriate
3. English

A missing translation must never display a raw localization key in production.

## Flutter implementation direction

Use Flutter's official localization stack:

- `flutter_localizations`
- `intl`
- ARB files under `lib/l10n/`
- generated strongly typed localization accessors

Planned structure:

```
lib/l10n/
  app_tr.arb
  app_en.arb
  app_es.arb
  app_pt.arb
  app_fr.arb
  app_de.arb
  app_ar.arb
  app_zh.arb
  app_ja.arb
  app_ko.arb
```

## Language selector UX

Profile → Language opens a searchable sheet containing:

- Use device language
- Türkçe
- English
- Español
- Português (Brasil)
- Français
- Deutsch
- العربية
- 简体中文
- 日本語
- 한국어

The language changes immediately without forcing app restart.

## Layout quality gates

Every major screen must be checked with:

- German and French for long labels
- Arabic for RTL
- Chinese/Japanese/Korean for dense CJK typography
- 200% text scaling
- narrow Android phone width
- iPhone compact width

Buttons must grow vertically instead of clipping. Cards must not rely on fixed text heights.

## Health terminology

Create a terminology glossary before release. Core concepts include:

- systolic
- diastolic
- pulse
- measurement
- average
- history
- trend
- medicine
- dose
- reminder
- report
- symptom
- arm
- posture
- cuff
- before/after medication
- before/after meal
- morning/evening

Clinical category wording must come from the selected sourced guideline profile and should not be invented by translators.

## Store localization

App Store and Google Play metadata should also be localized for the same 10 markets:

- app name/subtitle where appropriate
- short description
- long description
- screenshots
- promotional text
- privacy explanations
- release notes

## Definition of done for a localized feature

A feature is not localization-complete until:

- all visible copy uses localization keys;
- RTL has been tested;
- pluralization works where required;
- date/time/number formatting is locale-aware;
- screen-reader labels are localized;
- no overflow occurs at large text size;
- notifications/reports created by the feature are translated too.
