# CP-2: Stealth System

## Goal
Enemies have vision cones, detect noise, enter states (Idle/Suspicious/Alert), and call reinforcements.

## Checklist for Roman
- [ ] Enemy has visible semi-transparent cone (color by state)
- [ ] Cone blocked by walls (LightOccluder2D or RayCast)
- [ ] Kai inside cone = detection ramp (0.5s to Suspicious, 1.0s to Alert)
- [ ] Noise emitter: Kai actions create noise circles
- [ ] Enemy hears noise → moves to investigate → returns after 30s
- [ ] Alert state: 5s timer → spawns 2 reinforcements from hidden points
- [ ] Tall grass hides Kai only while crouching
- [ ] Body discovery: enemy sees body → instant Alert

## Files
- `entities/enemies/guard_sun.gd` — state machine, vision, hearing
- `entities/enemies/vision_cone.gd` — Polygon2D update, raycast check
- `systems/components/noise_emitter.gd` — emits noise signal
- `systems/components/hide_zone.gd` — Area2D for grass

## States
```gdscript
enum State { IDLE, SUSPICIOUS, ALERT }
```

## Rules
1. Vision cone: 12-segment polygon, updated every frame (or every 3rd for perf).
2. Use `PhysicsDirectSpaceState2D.intersect_ray()` for occlusion.
3. Noise: `AudioManager` or direct signal to enemies in radius.
4. Groups: `"enemies"` for mass alerts.

## Pitfalls
- Do NOT use `Area2D` overlap alone for detection — check line of sight.
- Do NOT forget to cull vision cones off-screen.
- Alert timer must be real-time (not affected by Time Dagger).
