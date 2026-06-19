# Sound Design Brief

## Music
- Dynamic states: Ambient → Tension → Combat → Stealth → Boss
- Crossfade: 2.0 sec
- Sources: Freesound, itch.io, self-composed

## SFX List
| Event | File | Source |
|-------|------|--------|
| Footsteps (run) | `sfx/footstep_run.wav` | Freesound |
| Footsteps (crouch) | `sfx/footstep_crouch.wav` | Freesound |
| Jump | `sfx/jump.wav` | Freesound |
| Land | `sfx/land.wav` | Freesound |
| Dash | `sfx/dash.wav` | Freesound |
| Roll | `sfx/roll.wav` | Freesound |
| Knife kill | `sfx/knife_kill.wav` | Freesound |
| Sniper fire | `sfx/sniper_fire.wav` | Freesound |
| Sniper hit | `sfx/sniper_hit.wav` | Freesound |
| EMP | `sfx/emp.wav` | Freesound |
| Smoke | `sfx/smoke.wav` | Freesound |
| Decoy | `sfx/decoy.wav` | Freesound |
| Time Dagger | `sfx/time_dagger.wav` | Freesound |
| Enemy alert | `sfx/alert.wav` | Freesound |
| Damage | `sfx/damage.wav` | Freesound |
| Death | `sfx/death.wav` | Freesound |

## Ambient (per zone)
- Zone 1: wind, sand, distant thunder, metal creak
- Zone 2: ice crackle, aurora hum, reactor drone
- Zone 3: drip, bioluminescent buzz, machinery, low pulse

## Implementation
- `AudioStreamPlayer` for music (2 for crossfade)
- `AudioStreamPlayer2D` for positional SFX
- `AudioStreamPlayer` for UI/HUD
- Bus layout: Master → Music, SFX, Ambient, UI
