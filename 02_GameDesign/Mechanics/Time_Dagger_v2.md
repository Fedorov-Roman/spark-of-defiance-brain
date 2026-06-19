# Time Dagger v2

## Concept
Hybrid time dilation: world slows to 30%, Kai moves at 100%. Full-screen blue shader.

## Why NOT Engine.time_scale
- Would slow UI, animations, particles, timers, Tween.
- Kai's own animations would lag.

## Solution: Custom Delta
- Group `"time_affected"`: enemies, traps, projectiles, doors, particles, ambient SFX.
- These nodes multiply `delta` by `0.3` in `_physics_process` and `_process`.
- Kai, UI, camera, global timers: normal `delta`.

## Energy
- Max energy: 100
- Cost per use: 40 (2.5 uses full → 2 uses practical)
- Recharge: 5/sec (passive). Batteries in world +30.
- Hub recharge station: full restore.

## Duration
- Active: 2.5 sec (real time)
- Cooldown: 1.0 sec (real time)

## Visual
- Full-screen `ColorRect` with shader: blue tint + slight chromatic aberration + radial blur at edges.
- Fades in 0.2s, holds, fades out 0.3s.
- Kai leaves blue afterimage trail (2-3 ghosts, 50% opacity).

## Audio
- Activation: low whoosh + clock ticking (pitched up, since Kai hears real time)
- Ambient: all SFX pitched down 30% for "time_affected" group only

## Boss Interaction (Biomechanoid)
- Without Time Dagger: boss invincible (attacks pass through).
- With Time Dagger: boss vulnerable, attacks slowed, weak points glow.

---

## Связанные разделы

- [[Mechanics_Index]]
- [[MOC_02_GameDesign]]
- [[GDD_Core_v2]]
- [[Input_Map]]
