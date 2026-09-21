# Tensio Design System v0.1

## 1. Design goal

Tensio should feel like a high-end personal health instrument rather than an insurance portal or a generic Material template.

The generated visual concept establishes the direction: dark layered surfaces, large vital numbers, restrained coral accent, data colors used selectively, generous rounded geometry and compact analytical cards.

## 2. Brand

Working wordmark: **Tensio**

Brand personality:
- calm,
- precise,
- warm,
- modern,
- private,
- trustworthy.

Avoid:
- red emergency styling as the default brand,
- sterile all-white hospital UI,
- cartoon hearts everywhere,
- excessive glass blur,
- tiny grey text,
- charts that look like crypto trading terminals.

## 3. Color tokens

Dark theme foundation:
- background: #071018
- surface: #0D1822
- surfaceRaised: #12212D
- surfaceStrong: #172A38
- outline: #243746
- textPrimary: #F4F8FB
- textSecondary: #9EB0BE
- textMuted: #6F8391

Brand/data accents:
- coral: #FF5D7A
- coralSoft: #FF8DA2
- emerald: #31D586
- blue: #4DA3FF
- amber: #FFB84D
- violet: #8C7CFF

Color roles must be semantic tokens rather than raw values scattered through widgets.

## 4. Typography

Use platform-appropriate system typography first for performance and native legibility.

Scale:
- Display: 40/44, bold
- Hero metric: 36/40, semibold
- Title L: 24/30, semibold
- Title M: 20/26, semibold
- Body L: 17/24
- Body M: 15/21
- Label: 13/18, medium
- Micro: 11/15, medium

Tabular figures should be enabled for measurements where available so numbers do not visually jump.

## 5. Spacing

Base unit: 4dp.

Primary spacing scale:
4, 8, 12, 16, 20, 24, 32, 40.

Screen horizontal gutter:
- phone: 20
- compact phone fallback: 16
- tablet: adaptive max content width.

## 6. Shape

- small control radius: 10
- standard card: 16
- large card: 22
- hero card: 26
- pills: fully rounded

Do not make every rectangle a pill.

## 7. Elevation

Use tonal elevation more than heavy shadow:
- base surface,
- raised card,
- modal sheet,
- floating CTA.

Dark-mode shadows remain subtle. Borders provide structure.

## 8. Main home composition

Top:
- greeting + profile avatar,
- date/compact context.

Hero card:
- most recent BP in large typography,
- unit,
- textual status,
- timestamp,
- compact pulse line,
- action to see detail.

Quick actions:
- New Measurement,
- History,
- Reports,
- Reminders.

Below:
- 7-day mini trend,
- today routine,
- medication/weight optional modules,
- insight card.

The hierarchy must make "record BP" obvious without turning the whole screen into one giant button.

## 9. Measurement screen

Header:
- New Measurement,
- date/time.

Three primary numeric lanes:
- systolic,
- diastolic,
- pulse.

Interaction candidates:
- numeric keyboard entry,
- wheel/stepper hybrid,
- previous-value ghost hint.

Context sheet:
- arm,
- posture,
- timing,
- medication relation,
- tags,
- note.

Primary CTA:
- Save.

No ads, no upsell, no unrelated banners.

## 10. Charts

Rules:
- line width high enough to remain visible,
- points optional except selected value,
- touch/drag inspection,
- readable axis labels,
- no unnecessary 3D,
- no gradient fog masking values,
- textual summary underneath,
- accessible alternative to chart.

## 11. Motion

Motion should explain state:
- 180–240ms standard transitions,
- gentle metric morph,
- card expansion,
- bottom sheet spring with restrained bounce,
- haptic confirmation on save.

Respect reduce-motion.

## 12. Components

Foundation components:
- TensioScaffold
- TensioTopBar
- SurfaceCard
- HeroVitalCard
- MetricChip
- QuickActionTile
- PrimaryButton
- SecondaryButton
- NumericVitalField
- SegmentedControl
- FilterChip
- TrendChartCard
- EmptyState
- InsightCard
- ReminderRow
- SettingRow
- BottomNavigationShell
- ModalSheet

Every component must have:
- loading state if relevant,
- disabled state,
- error state if relevant,
- dark/light behavior,
- localization resilience,
- accessibility semantics.

## 13. Light theme

Light mode will not simply invert dark mode.

Direction:
- warm off-white background,
- white/very-light-blue raised surfaces,
- dark navy text,
- same coral brand accent,
- restrained shadows,
- high data contrast.

## 14. Localization resilience

Design against:
- German label expansion,
- French line wrapping,
- Arabic RTL,
- CJK compact labels,
- large accessibility text.

Never use fixed-width text containers for semantic labels.

## 15. Platform personality

iOS:
- natural sheet behavior,
- Cupertino-feeling transitions where appropriate,
- native haptics,
- HealthKit terminology.

Android:
- predictive back readiness,
- system edge-to-edge behavior,
- Health Connect terminology,
- Android notification conventions.

The brand stays the same; platform behavior should not feel alien.
