# Tensio Roadmap

## Phase 0 — Foundation
- [x] Repository initialized
- [x] Product master spec
- [x] Design system direction
- [x] Architecture direction
- [x] Localization plan
- [x] Flutter app bootstrap
- [x] Theme tokens in code
- [x] Tab shell
- [x] Home visual prototype
- [x] Measurement visual prototype
- [x] Seed translation catalogs for 10 locales
- [ ] Wire generated localization strings into every current screen
- [ ] Add native Android/iOS runner projects and first CI build
- [ ] Add light theme foundation

## Phase 1 — Core tracking
- [ ] Measurement entity/database
- [ ] Measurement validation
- [ ] Persist new measurements
- [ ] Edit/delete
- [ ] History list from real data
- [ ] Calendar view
- [ ] Filter/search
- [ ] Basic trend charts from real data
- [ ] Empty/error/loading states
- [ ] Local reminders
- [ ] Accessibility pass

## Phase 2 — Reports and routines
- [ ] PDF report
- [ ] CSV export
- [ ] Medication model
- [ ] Medication reminders/log
- [ ] Weight tracking
- [ ] Multi-reading measurement sessions
- [ ] Custom tags/contexts

## Phase 3 — Health ecosystem
- [ ] HealthKit
- [ ] Health Connect
- [ ] Import deduplication
- [ ] Provenance UI
- [ ] Permission UX
- [ ] Optional backup

## Phase 4 — Advanced product
- [ ] Richer analytics
- [ ] Multi-profile/family
- [ ] Supported device integrations
- [ ] Premium entitlement architecture
- [ ] Ad placement review if monetization includes ads
- [ ] Localized store assets

## Permanent quality gates
- Never merge user-visible copy without a localization path.
- Never add a health metric without provenance.
- Never add ads to measurement/report/safety flows.
- Never hard-code medical thresholds without a documented reference policy.
- Keep core measurement/history useful without an account.
- Update HANDOFF after meaningful work.
