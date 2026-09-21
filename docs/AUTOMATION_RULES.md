# Tensio — Automation Rules

## Shared

Every automated run must:
1. work only in `omzdmr/Tensio`
2. read PROJECT_STATE first
3. read relevant product/design docs
4. inspect current HEAD before writing
5. never overwrite newer work blindly
6. make a coherent meaningful batch
7. never invent tests/CI/progress
8. record blockers precisely
9. update repo memory after meaningful development

## Research job

Research owns `docs/RESEARCH_LOG.md`.

Each run:
- search current and evergreen feedback
- rotate Turkish and international sources
- inspect negative reviews and feature requests
- include Ekşi Sözlük when relevant
- append only genuinely new evidence
- include source/date and product implication
- do not edit app code
- do not create duplicate findings merely to prove the job ran

## Development job

Each run:
- read PROJECT_STATE, PRODUCT_MASTER_SPEC, DESIGN_SYSTEM and latest research
- inspect current HEAD/CI
- choose one coherent high-value batch
- implement code + relevant tests
- update PROJECT_STATE/ROADMAP
- leave the repo buildable/reviewable
- do not react to one anecdotal review as if it were product truth

## Coordination

Research and development should be staggered so they do not write simultaneously.

Research owns research log. Development owns app code/tests/project state/roadmap. Re-read HEAD before touching any shared file.
