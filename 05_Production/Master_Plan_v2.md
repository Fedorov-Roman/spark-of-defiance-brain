# Master Plan v2

## Phase 1: Foundation (CP-0..CP-3)
| CP | Name | Deliverable | Depends on | Est. Iterations |
|----|------|-----------|------------|-----------------|
| CP-0 | Project Setup | Godot project, folders, InputMap, placeholders, git | — | 1 |
| CP-1 | Player Movement | Run, jump, wall-slide, wall-jump, dash, roll, crouch, ledge | CP-0 | 2 |
| CP-2 | Stealth System | Vision cones, noise, states, hide zones, body discovery | CP-1 | 2 |
| CP-3 | Time Dagger | Hybrid time, shader, energy, afterimages | CP-1 | 2 |

## Phase 2: Combat & World (CP-4..CP-7)
| CP | Name | Deliverable | Depends on | Est. Iterations |
|----|------|-----------|------------|-----------------|
| CP-4 | Weapons | Sniper, knife, EMP, smoke, decoy, health | CP-1 | 2 |
| CP-5 | Zone 1 Blockout | TileMap, collisions, placeholder art, 3 sub-areas | CP-0 | 2 |
| CP-6 | Enemies | Drone, Guard, Silicon Beast, Elite Sniper AI | CP-2, CP-4 | 3 |
| CP-7 | Boss 1 (Leviathan) | Arena, phases, steam mechanic, defeat | CP-5, CP-6 | 2 |

## Phase 3: Progression (CP-8..CP-11)
| CP | Name | Deliverable | Depends on | Est. Iterations |
|----|------|-----------|------------|-----------------|
| CP-8 | NPC & Hub | 6 NPCs, dynamic hub, rescue logic, Uno shop | CP-0 | 2 |
| CP-9 | Save/Load | JSON, autosave, checkpoint, full state | CP-8 | 1 |
| CP-10 | Fast Travel | Vspyshka, map, landing pads, cutscene | CP-8 | 1 |
| CP-11 | Grapple | Pendulum physics, points, swing, release | CP-1 | 2 |

## Phase 4: Content (CP-12..CP-17)
| CP | Name | Deliverable | Depends on | Est. Iterations |
|----|------|-----------|------------|-----------------|
| CP-12 | Zone 2 | Polar Oasis, ice, lasers, verticality | CP-5 | 2 |
| CP-13 | Boss 2 (Helios-7) | Mech, leg EMP, mortar, core hack | CP-12, CP-6 | 2 |
| CP-14 | Zone 3 | Deep Labs, gravity anomalies, time doors | CP-12 | 2 |
| CP-15 | Boss 3 (Biomechanoid) | Invincible without Time Dagger, gravity shift | CP-14, CP-3 | 2 |
| CP-16 | Dialogue System | Text boxes, portraits, typewriter, skipping | CP-8 | 1 |
| CP-17 | UI/HUD | Hearts, ammo, gadgets, map, inventory, pause | CP-4, CP-10 | 2 |

## Phase 5: Polish (CP-18..CP-21)
| CP | Name | Deliverable | Depends on | Est. Iterations |
|----|------|-----------|------------|-----------------|
| CP-18 | Audio | Dynamic music, SFX, ambient, mixing | CP-17 | 2 |
| CP-19 | Visual Polish | Particles, screen shake, shaders, lighting | CP-17 | 2 |
| CP-20 | Balance & QA | Difficulty curve, bug fixes, performance | All | 3 |
| CP-21 | Release Build | Export Windows, README, installer | CP-20 | 1 |

## Critical Path
CP-0 → CP-1 → CP-2 → CP-4 → CP-6 → CP-5 → CP-7 → CP-8 → CP-9 → CP-12 → CP-13 → CP-14 → CP-15 → CP-17 → CP-20 → CP-21

## Current Status
- **Completed:** Pre-production (all answers, GDD, architecture).
- **Next:** CP-0 Project Setup.
- **Blocked by:** Nothing. Ready to start.

---

## Связанные разделы

- [[MOC_05_Production]]
- [[CP_Index]]
- [[Decision_Log]]
- [[Risk_Register]]
