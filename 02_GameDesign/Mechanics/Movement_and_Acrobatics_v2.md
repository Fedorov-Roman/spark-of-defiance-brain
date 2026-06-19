# Movement & Acrobatics v2

## Constants
```gdscript
const TILE_SIZE: int = 32
const SPEED: float = 120.0          # px/sec
const ACCEL: float = 800.0          # px/sec²
const DECEL: float = 1000.0         # px/sec²
const GRAVITY: float = 900.0        # px/sec²
const JUMP_VELOCITY: float = -280.0 # px/sec (up is negative)
const WALL_SLIDE_SPEED: float = 60.0 # max downward on wall
const DASH_SPEED: float = 300.0   # px/sec
const DASH_DURATION: float = 0.15   # sec
const DASH_COOLDOWN: float = 0.3    # sec
const ROLL_IFRAMES: float = 0.4     # sec
const LEDGE_GRAB_TIME: float = 0.2  # sec to pull up
```

## States
- **Idle:** On ground, no input.
- **Run:** Ground movement with accel/decel.
- **Jump:** Single jump (double unlocked later).
- **WallSlide:** Auto on wall contact, gravity reduced to WALL_SLIDE_SPEED.
- **WallJump:** Press jump while wall-sliding → impulse away from wall + up.
- **Dash:** 4 directions (left/right/up/down). Air dash once (resets on ground). i-frames.
- **Roll:** Ground only. i-frames 0.4s. Low hitbox. Can pass through enemies.
- **Crouch:** Speed ×0.5. Noise radius ×0.3. Hitbox height halved. Can enter vents.
- **LedgeGrab:** Auto when falling past ledge. Press up to pull up in 0.2s.
- **Grapple:** Raycast to point. Swing as pendulum. Release → impulse in velocity direction.
- **Knockback:** On damage. Invulnerable 1.0 sec. No control 0.3 sec.

## Implementation Notes
- `CharacterBody2D` with `move_and_slide()`.
- `up_direction` defaults to `Vector2.UP`. Changes in Zone 3 anomalies.
- Wall detection: `is_on_wall()` + normal angle check (>60° from floor).
- Dash: `velocity = direction * DASH_SPEED` for DASH_DURATION, then restore.
- Grapple: custom physics (distance constraint, swing force). NOT `PinJoint2D`.
