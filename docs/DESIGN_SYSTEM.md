# Tensio — Design System

## Thesis

Tensio should feel like a **premium personal health instrument**, not an insurance portal and not a neon fitness toy.

Keywords: calm, precise, warm, spacious, tactile, trustworthy, premium.

## Brand direction

- abstract heart + pressure/pulse curve
- simple enough for app icon
- avoid medical cross clichés
- avoid generic ECG clip-art
- warm coral brand accent rather than “hospital blue everywhere”

## Dark palette

- Midnight: #071119
- Midnight soft: #0B1721
- Slate: #12212D
- Slate raised: #182A38
- Primary text: #F4F7FA
- Muted: #92A4B3
- Coral: #FF5C7A
- Coral soft: #FF8DA2
- Mint: #42DA9A
- Sky: #65B9FF
- Amber: #FFC65A
- Violet: #9587FF

## Light mode

Not a simple inversion:
- soft warm gray canvas
- white cards
- charcoal text
- same coral brand accent
- calmer status backgrounds

## Typography

- hero measurement: 40–48sp
- page title: 24–28sp
- section title: 18–20sp
- body: 14–16sp
- label: 12–14sp

Measurement values must survive large accessibility text.

## Geometry

- page padding: 20px
- card radius: 24px
- input radius: 18px
- compact chips: pill
- spacing system: 4/8/12/16/24/32/48

## Depth

Use low-opacity borders, soft shadows and selective gradients. Avoid turning every card into frosted glass. Health data should remain crisp.

## Navigation

Primary:
- Home
- History
- centered Add
- Insights
- Profile

New measurement remains one tap away.

## Motion

- quick feedback: ~140ms
- standard transition: ~240ms
- deliberate reveal: ~420ms
- respect reduced motion
- do not animate numbers in ways that delay reading

## Charts

- raw points visible
- missing data shown as gaps
- no fake smoothing
- readable legend
- color not the only distinction
- text summary available
- red reserved for genuinely meaningful sourced status

## Measurement entry

This is the most repeated workflow:
- numeric keyboard
- systolic/diastolic/pulse visible together when possible
- context secondary
- obvious save action
- no advertising
- repeated-reading mode without leaving the flow

## Status language

Prefer neutral language such as:
- Recorded
- Review this measurement
- Outside your selected range
- Trend changed

Avoid scary flashing UI and unsupported “healthy/unhealthy” claims.

## Platform behavior

Shared identity, native conventions:
- iOS sheets/haptics/HealthKit/share behavior
- Android predictive back/Health Connect/Material navigation behavior

Cross-platform does not mean forcing identical interaction where the native convention is better.
