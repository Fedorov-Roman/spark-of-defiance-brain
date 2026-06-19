# Risk Register

| ID | Risk | Probability | Impact | Mitigation |
|----|------|-------------|--------|------------|
| R01 | Hybrid time_scale desyncs physics | Medium | High | Prototype in CP-3; test move_and_slide with custom delta |
| R02 | Gravity anomalies break wall-run | Medium | High | Prototype in CP-1; abstract wall detection to up_direction |
| R03 | Pendulum grapple feels bad | Medium | Medium | Prototype early; iterate on rope length / swing force |
| R04 | Visible cones + shadows = FPS drop | Medium | Medium | Limit cone to 12-segment polygon; cull off-screen; LOD |
| R05 | Placeholder art never replaced | High | Medium | Schedule Leonardo prompts per CP; set art milestone at CP-8 |
| R06 | JSON save bloat / corruption | Low | High | Version field in JSON; validate on load; fallback to defaults |
| R07 | Dual input (pad+mouse) conflicts | Medium | Medium | InputManager auto-detects active device; hides mouse cursor on pad |
| R08 | Builder stuck on complex mechanic | Medium | Medium | Reserve Builder (Flash) backup after 3 failed iterations |
| R09 | 3 zones = scope creep | Medium | High | Lock zone designs at CP-5; no new mechanics after CP-10 |
| R10 | Pixel-perfect jitter on camera | Low | Medium | Camera2D integer zoom + snap; test at x2/x3 |
| R11 | No sound designer = bad audio | Medium | Low | Curated free asset lists per zone; dynamic music via stems |
| R12 | Leonardo tokens run out | Medium | Low | Batch prompts; prioritize player + 1 zone first; use FLUX Schnell for drafts |
| R13 | Silent protagonist = weak narrative | Low | Medium | Strong environmental storytelling; audio logs; NPC monologues |
| R14 | Metroidvania backtracking boring | Medium | Medium | Fast travel early; new enemy types on return; shortcuts |
| R15 | Bosses too hard/easy | Medium | Medium | Checkpoint before each; observe Roman's playtest; tweak HP/damage |

---

## Связанные разделы

- [[MOC_00_Meta]]
- [[Master_Plan_v2]]
- [[Decision_Log]]
- [[Bug_Tracker]]
