# AGENTS.md — Tensio continuity contract

Any ChatGPT, automation or human contributor working in this repository must treat GitHub as the durable memory of the project.

## Read before changing anything

1. `docs/PROJECT_STATE.md`
2. `docs/PRODUCT_MASTER_SPEC.md`
3. `docs/UX_BLUEPRINT.md`
4. `docs/DESIGN_SYSTEM.md`
5. `docs/ARCHITECTURE.md`
6. `docs/LOCALIZATION.md`
7. `docs/RESEARCH_LOG.md`
8. `docs/AUTOMATION_RULES.md`
9. current HEAD and current CI status

## Non-negotiable behavior

- Re-read HEAD immediately before writing.
- Never overwrite newer work from another session blindly.
- If CI is red, diagnose it before adding unrelated feature work.
- Do not claim a feature, test, build or platform works without evidence.
- Prefer one coherent meaningful batch over a cosmetic one-line change.
- Update `docs/PROJECT_STATE.md` after meaningful work.
- Update `docs/ROADMAP.md` when scope/status changes.
- Research automation owns `docs/RESEARCH_LOG.md`; development automation should consume it.
- Preserve the ten-language launch requirement.
- Preserve local-first/manual-use-without-account behavior.
- Keep clinical thresholds out of widgets.
- Do not place ads in measurement, urgent messaging or clinician-report flows.

## Handoff requirement

Before a development session ends, PROJECT_STATE must answer:
- What is the current HEAD?
- What was completed?
- What is verified?
- What is broken or uncertain?
- What is the next highest-value batch?
- Are there any coordination hazards with another task/session?

If the next contributor can only understand the project by reading chat history, the session failed its handoff duty.
