# Audio Design v2

## Dynamic Music System
Managed by `AudioManager` (AutoLoad). States:
- **Ambient:** Exploration. Low drones, wind, distant machinery.
- **Tension:** Suspicious enemy. Added percussion, heartbeat bass.
- **Combat:** Alert. Full drums, synth stabs.
- **Stealth:** Crouch/hide. Muffled, minimal.
- **Boss:** Intense. Layered orchestra + industrial.

Crossfade between states: 2.0 sec.

## SFX
| Event | Sound | Notes |
|-------|-------|-------|
| Footsteps (run) | Metallic thud on metal, soft crunch on sand | 2 variants per surface |
| Footsteps (crouch) | Very quiet, single layer |
| Jump | Air whoosh |
| Land | Soft thud |
| Dash | Electric zip |
| Roll | Fabric + metal scrape |
| Knife kill | Sharp slice + body fall |
| Sniper fire | Muffled crack + echo |
| Sniper hit | Electric zap + spark |
| EMP | Digital glitch + pop |
| Smoke | Hiss |
| Decoy | Stone clack |
| Time Dagger | Low whoosh + fast clock ticking |
| Enemy alert | Radio chirp + "!" ding |
| Damage | Grunt + impact |
| Death | Fade + heartbeat stop |

## Ambient (per zone)
- **Zone 1:** Wind, sand particles, distant thunder, creaking metal.
- **Zone 2:** Ice crackling, aurora hum, reactor drone.
- **Zone 3:** Drip, bioluminescent buzz, machinery, low frequency pulse.

## Implementation
- `AudioStreamPlayer` for music (2 for crossfade).
- `AudioStreamPlayer2D` for positional SFX (enemies, traps).
- `AudioStreamPlayer` for UI/HUD (non-positional).
- Bus layout: Master → Music, SFX, Ambient, UI.
