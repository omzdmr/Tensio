# Tensio — Premium UX Blueprint

This file is the visual and interaction north star for the iOS and Android app. It exists so the intended product can be reconstructed from GitHub even if every chat disappears.

## Product feeling

Tensio should feel like a **premium personal health instrument**: calm, precise, warm, spacious and trustworthy.

It must not feel like:
- a hospital administration portal;
- a spreadsheet with rounded corners;
- a neon fitness game;
- a subscription trap;
- an “AI” demo looking for somewhere to put sparkles.

The hierarchy on almost every screen is:

1. the health information that matters now;
2. the most useful next action;
3. context/trend;
4. deeper tools.

“Add measurement” is always easy to reach.

## Brand

Working name: **Tensio**.

Brand idea: pressure + pulse + calm control.

Logo direction:
- one continuous abstract heart/pressure ribbon;
- recognizable at app-icon size;
- coral/pink primary accent;
- works in monochrome;
- avoids medical-cross and generic ECG clichés.

## Visual system

### Dark mode
Hero presentation:
- canvas: near-black navy;
- raised surfaces: slate/blue-black;
- primary text: warm near-white;
- secondary text: cool gray;
- primary accent: coral;
- support accents: mint, sky, amber, violet.

### Light mode
Not a dumb inversion:
- warm gray canvas;
- white cards;
- charcoal text;
- restrained borders;
- same coral brand identity;
- softer status backgrounds.

### Geometry
- page padding: ~20 logical px;
- major card radius: 22–26;
- input radius: 16–20;
- large sheet radius: 28–32;
- chips: pill;
- touch targets: minimum 44–48.

### Depth
Use low-opacity borders, subtle elevation and occasional hierarchy gradients. Do not frost every rectangle or turn health data into a nightclub.

## Main navigation

Five anchors:
- Home
- History
- centered Add
- Insights
- Profile

Shared product identity does not mean ignoring platform conventions. iOS should feel native on iOS; Android should feel native on Android.

## Home

### Header
- compact greeting/context;
- Tensio identity;
- profile/avatar;
- optional next reminder state.

### Latest measurement hero
Large:
**120 / 80**
mmHg

Support:
- pulse;
- time;
- context;
- source.

No unsourced “healthy/unhealthy” label. Classification color waits for the versioned guideline engine.

### Quick actions
- New measurement
- Report
- Reminder

Never place advertising between latest reading and New Measurement.

### Seven-day trend
- systolic + diastolic;
- raw points visible;
- missing data shown as gaps;
- no fake smoothing;
- accessible text summary.

### Today
Only modules the user enabled:
- medication;
- pulse;
- weight;
- optional lifestyle context.

Disabled modules leave no empty holes.

## Measurement entry

This is the highest-frequency workflow and receives the most polish.

Primary fields:
- systolic;
- diastolic;
- pulse.

All visible together where space permits. Numeric keyboard. Large values.

Secondary context:
- date/time;
- arm;
- posture;
- cuff/device;
- before/after medication;
- before/after meal;
- caffeine;
- nicotine/smoking;
- exercise;
- stress;
- sleep quality;
- symptoms;
- note;
- source.

Context is progressive disclosure so routine entry never becomes a questionnaire.

### Guided session
Optional:
- preparation/rest timer;
- posture hints;
- repeated readings.

Repeated readings:
- each raw reading is retained;
- derived session average is separate;
- accidental reading can be explicitly excluded without silently rewriting history.

### Save
One clear full-width action. No ad, paywall or interstitial.

## History

Modes:
- list;
- calendar.

Rows:
- time;
- systolic/diastolic;
- pulse;
- source/status marker;
- meaningful context.

Detail:
- edit;
- delete;
- duplicate as new;
- inspect session/raw readings;
- source/context.

Deletion should offer undo where practical.

## Insights

Ranges:
- 7 days;
- 30 days;
- 90 days;
- custom.

Core:
- average systolic;
- average diastolic;
- average pulse;
- reading count;
- morning vs evening;
- variability;
- consistency.

Later:
- medication timing;
- sleep;
- nicotine;
- caffeine;
- stress;
- activity.

Rules:
- no causality from weak correlation;
- no pseudo-medical certainty;
- no insight card merely because a blank card looks lonely;
- minimum sample requirements;
- accessible textual chart summaries.

## Reports

Report builder:
- custom range;
- charts;
- raw table;
- medication;
- notes;
- context;
- clinician compact mode.

Outputs:
- PDF;
- CSV;
- share;
- print.

Reports use a clean white printable layout regardless of app theme, clear generation date, page numbers and restrained branding.

## Reminders

Types:
- measurement;
- medication;
- refill;
- optional weekly review.

Features:
- recurring schedule;
- time windows where useful;
- snooze;
- done/skip;
- quiet hours;
- timezone behavior.

No guilt language.

## Medication

Medication:
- name;
- dose/form;
- schedule;
- start/end;
- instructions;
- refill.

Dose event:
- taken;
- skipped;
- missed;
- actual time.

Medication is context for the pressure-tracking product, not an attempt to replace prescribing software.

## Connections

Profile → Connections.

iOS:
- Apple Health / HealthKit.

Android:
- Health Connect.

Later:
- Bluetooth blood-pressure monitors.

Rules:
- source attribution;
- import deduplication;
- explain permission before the OS prompt;
- app remains useful with every permission denied.

## Profile & settings

Personal:
- profile;
- goals/ranges;
- clinician details;
- multiple profiles later.

Tracking:
- medication;
- devices;
- reminders;
- health-platform connections.

App:
- appearance;
- language;
- accessibility;
- units/date preferences.

Data:
- export;
- backup;
- restore;
- privacy.

Commercial:
- Premium;
- restore purchase.

About:
- sources/guidelines;
- privacy;
- support;
- version.

## Onboarding

Short and skippable:

1. product promise;
2. feature overview;
3. language/device-language choice;
4. optional personalization;
5. optional Health/Health Connect;
6. optional reminder setup;
7. app.

No forced account.

Permissions are requested in context, not dumped on the user on launch.

## Ten-language launch UX

Launch locales:
- Turkish;
- English;
- Spanish;
- Brazilian Portuguese;
- French;
- German;
- Arabic;
- Simplified Chinese;
- Japanese;
- Korean.

Language is selectable independently from OS language.

Arabic requires complete RTL QA:
- directional icons;
- navigation;
- sheets;
- lists;
- charts/legends.

German/French are overflow stress tests. CJK screens are checked for typography density.

## Accessibility

Required:
- screen-reader semantics;
- scalable text;
- large targets;
- strong contrast;
- reduced motion;
- color never the only status signal;
- chart summaries;
- natural spoken order for readings.

Primary health values must survive 200% text scaling.

## Motion & haptics

Typical motion:
- tap feedback: 120–160 ms;
- standard transition: 220–260 ms;
- major sheet/reveal: 350–450 ms.

Use haptics for:
- successful save;
- meaningful selection;
- destructive confirmation.

Do not bounce or pulse numbers for attention.

## Empty states

Every empty state teaches the next action:
- no measurements → add first measurement;
- no report → build report;
- no medication → optional setup;
- insufficient trend data → explain what data is needed.

No blank dead canvases.

## Errors & sync

Local actions feel immediate.

Integration errors distinguish:
- permission denied;
- network unavailable;
- provider error;
- last successful sync.

A failed sync never deletes local data.

## Premium

Free remains a respectable tracker.

Premium candidates:
- advanced long-range analytics;
- advanced/custom reports;
- multiple profiles;
- richer automation;
- encrypted backup/sync;
- advanced device support;
- customization.

Basic manual measurement and history remain genuinely useful.

Paywall rules:
- no fake countdown;
- clear monthly/annual terms;
- restore purchase;
- no measurement-entry interruption.

## Advertising readiness

If ads are added later:
- never inside measurement entry;
- never inside urgent/risk messaging;
- never inside generated reports;
- never disguised as advice;
- never targeted using raw health readings;
- no hostile full-screen interstitial in health workflows.

Premium removes ads.

## Privacy experience

Privacy is shown through behavior:
- useful without account;
- local first;
- export is findable;
- permissions just-in-time;
- connected data sources visible;
- delete/export controls easy to find.

## Screen inventory

### P0
- launch/splash;
- Home;
- New Measurement;
- History;
- Insights;
- Profile/Settings.

### P1
- preparation timer;
- repeated-reading session;
- measurement detail/edit;
- reminders;
- medication;
- report builder;
- report preview;
- language picker.

### P2
- Apple Health / Health Connect setup;
- devices/pairing;
- import review;
- backup;
- Premium.

### P3
- advanced insights;
- multi-profile;
- deeper device ecosystem.

## Design acceptance checklist

A screen is not done because one screenshot looks premium.

It must also:
- work dark and light;
- have empty/loading/error states;
- survive German/French length;
- work RTL;
- work at large text sizes;
- work on compact phones;
- expose semantics;
- avoid fixed-height text traps;
- keep primary action reachable;
- behave appropriately on both iOS and Android.

This file is authoritative unless PRODUCT_MASTER_SPEC.md explicitly overrides it.
