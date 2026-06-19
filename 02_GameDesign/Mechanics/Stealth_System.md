# Stealth System

## Detection States

1. **Idle** — Patrol route, normal vision cone.
2. **Suspicious** — Noise or glimpse. Investigation. Returns to Idle after 30s if lost.
3. **Alert** — Full detection. 5s timer → reinforcements (2 new enemies). Returns to Idle after 30s if lost.

## Vision

- Visible cones (semi-transparent) like Mark of the Ninja.
- Dynamic shadows via LightOccluder2D.
- Smoke breaks line of sight.

## Noise

- Walking: small radius.
- Running: large radius.
- Crouch: minimal.
- Decoy (stone): infinite supply, 1 active.

## Up

[[MOC_Mechanics]]
