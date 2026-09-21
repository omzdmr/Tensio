# Localization Specification

Tensio is multilingual from the foundation rather than translated after the UI has hardened into English-shaped boxes.

## Initial locales

1. Turkish — tr
2. English — en
3. Spanish — es
4. Brazilian Portuguese — pt-BR
5. French — fr
6. German — de
7. Arabic — ar
8. Simplified Chinese — zh-Hans
9. Japanese — ja
10. Korean — ko

This is the initial agreed product set. The research process should periodically verify store-market priorities and can propose changes, but should not silently remove an agreed language.

## Requirements

- In-app language selector independent of device language.
- "Use device language" option.
- Full RTL for Arabic.
- Locale-aware dates/times.
- Locale-aware decimal and unit formatting.
- No concatenated sentence fragments that break grammar.
- PDF/report localization.
- Notification localization.
- App Store / Play Store metadata localization later.
- Screenshots localized for priority markets later.

## Translation structure

Use ARB/Flutter localization generation.

Naming:
- semantic keys, not UI-position keys.
- Example: `measurement.save`, not `screen2.button3`.

Every user-visible string must be localizable except:
- user-entered text,
- brand name,
- standardized units/symbols where appropriate.

## Quality

Health terminology must be reviewed for natural language. Literal machine translations are not accepted merely because they compile.

Fallback locale: English.

Turkish remains a first-class development locale so layouts are not accidentally optimized only for English.
