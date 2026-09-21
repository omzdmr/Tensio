# Tensio — Product Master Specification

Status: living specification  
Canonical repo: `omzdmr/Tensio`  
Primary platforms: iOS + Android  
Working product name: Tensio

## 1. Vision

Tensio is a personal blood-pressure and cardiovascular tracking companion designed to replace the usual pile of disconnected tools: one app for readings, another for medication reminders, another for weight, another for doctor PDFs, screenshots for notes, and some heroic spreadsheet nobody wants to maintain.

The app should feel premium and reassuring without becoming decorative at the cost of readability. A reading must be recordable in seconds. A six-month history must remain understandable. A clinician-facing export must be useful rather than a screenshot collage.

Tensio is not positioned as an autonomous diagnostic system. It stores measurements, presents trends, lets users add context, supports reminders, and helps them share organized data.

## 2. Product pillars

### 2.1 Fast capture
A normal measurement should take a few taps:
1. systolic,
2. diastolic,
3. pulse,
4. optional context,
5. save.

The app remembers useful defaults but never silently invents a medical measurement.

### 2.2 Context, not just numbers
Optional measurement context:
- left/right arm,
- sitting/standing/lying,
- before/after medication,
- before/after meal,
- morning/afternoon/evening/night,
- rest duration,
- symptoms,
- free-form note,
- measurement device,
- custom tags.

### 2.3 Useful history
History must support:
- chronological list,
- calendar,
- day/week/month/year views,
- filters,
- search by note/tag,
- comparison periods,
- morning vs evening patterns,
- per-arm comparison,
- pulse trends,
- measurement adherence.

### 2.4 Reports
Users should be able to create a clean PDF or shareable summary with:
- date range,
- readings,
- averages and trends,
- optional notes,
- medication list,
- optional weight data,
- user-defined clinician/contact details,
- readable chart,
- clear indication of missing data.

No account should be required to export the user's own data.

### 2.5 Medication and reminders
Medication support is intended for organization and adherence, not prescribing:
- medication name,
- dosage text,
- schedule,
- active date range,
- reminder,
- taken/skipped log,
- optional relation to readings.

Reminder types:
- morning/evening BP measurement,
- medication,
- weight,
- appointment,
- custom routine.

### 2.6 Supporting health data
The app may track or import:
- pulse,
- body weight,
- optional body-mass metadata,
- steps/activity where permitted,
- sleep summary where permitted,
- manually added notes.

Supporting health data must not bury the core BP experience.

### 2.7 Health platform integrations
Planned:
- Apple Health / HealthKit,
- Android Health Connect.

Integration rules:
- permission is granular,
- app remains useful without permissions,
- import source is visible,
- duplicate detection is mandatory,
- imported data is distinguishable from manual entry,
- export/write permissions are separate from read permissions.

### 2.8 Devices
Future device layer may support compatible Bluetooth blood-pressure monitors. Device support must use official/standard protocols when available. Manual entry remains a first-class flow.

## 3. Information architecture

Primary tabs:

### Home
A calm daily dashboard:
- last reading,
- measurement CTA,
- compact pulse/weight cards,
- today's reminder state,
- seven-day mini trend,
- next useful action,
- optional insight card.

### History
- list/calendar toggle,
- filters,
- ranges,
- reading details,
- edit/delete,
- bulk export.

### Add
Central floating action:
- blood pressure reading,
- pulse-only entry if supported,
- weight,
- medication taken,
- note.

### Insights
- trend charts,
- period summaries,
- morning/evening comparison,
- adherence,
- variability views,
- contextual patterns.

Insights should describe data, not impersonate a doctor.

### Profile / Settings
- personal display preferences,
- health profile fields used for reports,
- targets/ranges where product policy permits,
- medicines,
- devices,
- reminders,
- integrations,
- language,
- units,
- appearance,
- accessibility,
- privacy,
- backup/export,
- premium.

## 4. Measurement flow

### 4.1 Entry
The primary entry screen uses large vertical number selectors or highly legible numeric fields:
- systolic,
- diastolic,
- pulse.

Requirements:
- one-handed use,
- large tap targets,
- no accidental save,
- sensible validation,
- editable date/time,
- optional note collapsed by default.

### 4.2 Measurement session
Planned multi-reading mode:
- users can record 2–3 readings in one session,
- configurable rest interval timer,
- each raw reading remains stored,
- app can show a session summary without deleting originals.

This is important because many people take repeated readings rather than a single isolated value.

### 4.3 Status display
Any status/range classification must be based on an explicitly documented clinical reference and locale/product policy. Do not hard-code a universal "normal/high" engine before the reference policy is approved.

UI must never rely on color alone. Text/icon/pattern cues are required.

## 5. History and analytics

Core analytics:
- count of measurements,
- period average,
- systolic trend,
- diastolic trend,
- pulse trend,
- measurement frequency,
- morning/evening comparison,
- distribution by configured status bands,
- min/max with timestamp,
- streak/adherence where user enabled a routine.

Advanced candidates:
- moving averages,
- variability,
- weekday patterns,
- medication-context overlays,
- weight overlays,
- custom tag comparison.

A sophisticated chart is useless if nobody can read it. Every chart needs a plain-language summary.

## 6. Reminders

Reminder engine requirements:
- local notifications by default,
- works without account/server,
- timezone-safe,
- daylight-saving-safe,
- skip/snooze,
- quiet hours,
- temporary pause,
- "already recorded" suppression where appropriate,
- duplicate-notification prevention.

## 7. Reports and clinician sharing

Exports:
- PDF,
- CSV,
- machine-readable backup.

PDF modes:
- quick 7-day,
- 30-day,
- custom range.

Optional content:
- medications,
- notes,
- weight,
- user contact fields,
- doctor/clinic label.

Never place ads inside health reports.

## 8. Privacy and data ownership

Baseline:
- local database,
- encryption for sensitive local records where technically appropriate,
- no sale of health data,
- no ad targeting based on health measurements,
- transparent analytics policy,
- deletion and export controls,
- optional backup, not mandatory cloud captivity.

If ads are introduced in the future, they must never appear:
- during measurement,
- on urgent/safety information,
- inside reports,
- between a reminder tap and measurement entry,
- in a way that resembles medical advice.

Future monetization may use a calm premium upgrade model plus carefully separated non-health-targeted placements in low-friction areas. Exact ad model remains a later decision.

## 9. Premium product direction

Free core should remain genuinely useful.

Candidate premium features:
- advanced trends and comparisons,
- richer reports,
- unlimited custom profiles/family profiles if added,
- additional themes,
- advanced backup/sync,
- device automation conveniences.

Do not cripple basic measurement history to manufacture a subscription problem.

## 10. Multi-profile / family mode

Candidate feature:
- separate local profiles,
- clear active-profile identity,
- independent reminders,
- independent exports,
- no accidental mixing.

This is useful for people helping parents/partners but must be designed carefully to avoid record confusion.

## 11. Accessibility

Required:
- Dynamic Type / large font support,
- scalable layout,
- screen reader semantics,
- minimum contrast targets,
- color-independent state communication,
- generous touch targets,
- reduce-motion compatibility,
- haptic feedback where useful,
- numeric controls usable by assistive tech.

## 12. Localization

Initial ten languages:
- tr — Turkish
- en — English
- es — Spanish
- pt-BR — Brazilian Portuguese
- fr — French
- de — German
- ar — Arabic
- zh-Hans — Simplified Chinese
- ja — Japanese
- ko — Korean

See `LOCALIZATION.md`.

## 13. Offline-first requirements

Without internet the user must be able to:
- launch the app,
- view history,
- add/edit/delete readings,
- receive local reminders,
- view cached insights,
- generate core local reports where platform libraries allow,
- change settings.

Internet-only features must degrade gracefully and be visibly optional.

## 14. Onboarding

Onboarding should be short:
1. brand/value screen,
2. choose language or use device language,
3. privacy/local-first explanation,
4. optional reminder setup,
5. optional health integration,
6. enter app.

Permissions are requested at the moment they become useful, not as a wall of popups on first launch.

## 15. Visual personality

Keywords:
- dark mineral surfaces,
- soft depth,
- warm coral/pink primary accent,
- emerald success accent,
- electric blue data accent,
- premium but not futuristic-gimmicky,
- dense information with breathing room,
- human rather than hospital software.

Both light and dark themes are planned. Dark is the current hero direction.

## 16. Feature backlog

P0 foundation:
- navigation,
- design tokens,
- localization,
- local data model,
- measurement entry,
- history,
- basic chart,
- reminders,
- export skeleton,
- settings.

P1:
- medication tracking,
- weight,
- multi-reading sessions,
- richer analytics,
- HealthKit/Health Connect,
- PDF reports,
- backup/export.

P2:
- multi-profile,
- device integrations,
- advanced analytics,
- premium entitlements,
- carefully reviewed monetization.

## 17. Non-goals for first releases

- remote diagnosis,
- automated prescribing,
- pretending data from a phone camera equals a cuff measurement,
- social feed,
- gamification that shames users,
- mandatory login,
- intrusive ads.

## 18. Definition of "premium"

Premium is not gradients sprayed over everything.

For Tensio it means:
- consistent spacing,
- excellent typography,
- frictionless entry,
- purposeful motion,
- tactile controls,
- elegant charts,
- useful empty/loading/error states,
- polished reports,
- accessibility,
- stable offline behavior,
- no jarring monetization.

That standard applies to every future feature.
