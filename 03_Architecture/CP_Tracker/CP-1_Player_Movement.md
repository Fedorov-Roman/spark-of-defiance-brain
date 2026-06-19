

---

## Additional Notes (Brain 2)

# CP-1: Player Movement

## Goal
Kai can run, jump, wall-slide, wall-jump, dash, roll, crouch, and ledge-grab in a test scene.

## Checklist for Roman
- [ ] Kai moves left/right with acceleration/deceleration
- [ ] Kai jumps (single, variable height by hold)
- [ ] Kai wall-slides automatically on wall contact
- [ ] Kai wall-jumps (press jump while sliding)
- [ ] Kai dashes in 4 directions (ground + air once)
- [ ] Kai rolls with 0.4s i-frames (ground only)
- [ ] Kai crouches (slower, smaller hitbox, quieter)
- [ ] Kai ledge-grabs and pulls up
- [ ] All animations placeholder (color changes or simple sprites)
- [ ] No stealth/combat yet — pure movement

## Files
- `entities/player/player.gd` — CharacterBody2D, state machine
- `entities/player/player.tscn` — sprite, collision, raycasts for wall/ledge
- `scenes/test_movement.tscn` — simple TileMap floor + walls

## Key Constants
```gdscript
const SPEED: float = 120.0
const ACCEL: float = 800.0
const DECEL: float = 1000.0
const GRAVITY: float = 900.0
const JUMP_VELOCITY: float = -280.0
const WALL_SLIDE_SPEED: float = 60.0
const DASH_SPEED: float = 300.0
const DASH_DURATION: float = 0.15
const ROLL_IFRAMES: float = 0.4
```

## Rules
1. Use `_physics_process` for all movement.
2. Use `move_and_slide()`.
3. Wall detection: `is_on_wall()` + normal angle.
4. Dash: temporary velocity override, not force.
5. Roll: `CollisionShape2D` scale Y halved, timer restores.

## Pitfalls
- Do NOT use `_process` for physics.
- Do NOT hardcode key names — use InputMap actions.
- Wall-jump must clear wall stick (push away from wall).
- Air dash resets only on ground touch (not on wall).

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_05_Production]]
- [[Master_Plan_v2]]
- [[CP_Template]]
