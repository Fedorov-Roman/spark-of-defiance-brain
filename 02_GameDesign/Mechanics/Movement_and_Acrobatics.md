# Movement and Acrobatics

## States

- **Idle** — Ground, no input.
- **Run** — Ground, horizontal input.
- **Jump** — Initial impulse upward.
- **Fall** — Airborne, descending.
- **Wall Slide** — Touching wall, descending slowly.
- **Wall Jump** — Push off wall, impulse diagonally.
- **Dash** — 4-directional burst, i-frames, 1 per air sequence.
- **Roll** — Ground evasion, 0.4s i-frames.
- **Crouch** — Reduced speed, quieter, smaller hitbox.
- **Ledge Grab** — Hang on edge, pull up.
- **Grapple** — Swing physics, point-to-point.

## Parameters

- Gravity: custom (not RigidBody2D).
- Acceleration/deceleration: smooth (Celeste-like feel).
- Wall-slide: automatic on contact.
- Wall-jump: changes direction, preserves some inertia.

## Up

[[MOC_Mechanics]]
