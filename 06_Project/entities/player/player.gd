class_name Player extends CharacterBody2D
enum State { IDLE, RUN, JUMP, WALL_SLIDE, DASH, ROLL, CROUCH, KNOCKBACK }
const SPEED: float = 120.0; const ACCEL: float = 800.0; const DECEL: float = 1000.0
const GRAVITY: float = 900.0; const JUMP_VELOCITY: float = -280.0; const WALL_SLIDE_SPEED: float = 60.0
const DASH_SPEED: float = 300.0; const DASH_DURATION: float = 0.15; const ROLL_IFRAMES: float = 0.4
const MAX_HP: int = 3
var state: State = State.IDLE
var hp: int = MAX_HP; var can_air_dash: bool = true; var is_rolling: bool = false; var is_crouching: bool = false; var iframe_timer: float = 0.0
var facing_right: bool = true
@onready var sprite: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var wall_ray_left: RayCast2D = $WallRayLeft
@onready var wall_ray_right: RayCast2D = $WallRayRight
func _physics_process(delta: float) -> void:
    if iframe_timer > 0: iframe_timer -= delta
    _handle_input(delta); _apply_gravity(delta); _apply_movement(delta); move_and_slide(); _update_state()
func _handle_input(delta: float) -> void:
    var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    if is_crouching: dir.x *= 0.5
    if state != State.DASH and state != State.ROLL and state != State.KNOCKBACK:
        velocity.x = move_toward(velocity.x, dir.x * SPEED, (ACCEL if dir.x != 0 else DECEL) * delta)
    if Input.is_action_just_pressed("jump"): _try_jump()
    if Input.is_action_just_pressed("dash"): _try_dash(dir)
    if Input.is_action_pressed("crouch"): _start_crouch()
    else: _end_crouch()
    if Input.is_action_just_pressed("roll") and is_on_floor(): _start_roll()
func _try_jump() -> void:
    if is_on_floor(): velocity.y = JUMP_VELOCITY; state = State.JUMP; can_air_dash = true
    elif _is_on_wall(): _wall_jump()
func _is_on_wall() -> bool: return (wall_ray_left.is_colliding() or wall_ray_right.is_colliding()) and not is_on_floor()
func _wall_jump() -> void:
    var n := get_wall_normal(); velocity = Vector2(n.x * SPEED * 0.8, JUMP_VELOCITY); state = State.JUMP
func _try_dash(dir: Vector2) -> void:
    if dir == Vector2.ZERO: dir = Vector2.RIGHT if facing_right else Vector2.LEFT
    if not is_on_floor() and not can_air_dash: return
    if not is_on_floor(): can_air_dash = false
    state = State.DASH; velocity = dir.normalized() * DASH_SPEED; iframe_timer = DASH_DURATION
    await get_tree().create_timer(DASH_DURATION).timeout; state = State.IDLE
func _start_roll() -> void:
    state = State.ROLL; is_rolling = true; iframe_timer = ROLL_IFRAMES; collider.scale.y = 0.5
    await get_tree().create_timer(ROLL_IFRAMES).timeout; is_rolling = false; collider.scale.y = 1.0; state = State.IDLE
func _start_crouch() -> void:
    if not is_on_floor() or is_rolling: return; is_crouching = true; collider.scale.y = 0.5; state = State.CROUCH
func _end_crouch() -> void:
    if not is_crouching: return; is_crouching = false; collider.scale.y = 1.0
func _apply_gravity(delta: float) -> void:
    if state == State.WALL_SLIDE and _is_on_wall(): velocity.y = clamp(velocity.y + GRAVITY * delta, 0, WALL_SLIDE_SPEED)
    elif state != State.DASH: velocity.y += GRAVITY * delta
func _apply_movement(_delta: float) -> void:
    if velocity.x > 0: facing_right = true
    elif velocity.x < 0: facing_right = false
    sprite.flip_h = not facing_right
func _update_state() -> void:
    if state == State.DASH or state == State.ROLL or state == State.KNOCKBACK: return
    if is_on_floor(): state = State.CROUCH if is_crouching else (State.RUN if abs(velocity.x) > 10 else State.IDLE)
    elif _is_on_wall() and velocity.y > 0: state = State.WALL_SLIDE
    elif velocity.y < 0: state = State.JUMP
func take_damage(a: int, kb: Vector2 = Vector2.ZERO) -> void:
    if iframe_timer > 0: return
    hp -= a; iframe_timer = 1.0; velocity = kb; state = State.KNOCKBACK; UIManager.update_health(hp, MAX_HP)
    if hp <= 0: _die()
func _die() -> void: pass # TODO: fade + respawn
func serialize() -> Dictionary: return {"hp": hp, "pos": {"x": global_position.x, "y": global_position.y}}
func deserialize(d: Dictionary) -> void: hp = d.get("hp", MAX_HP); global_position = Vector2(d.get("pos", {}).get("x", 0), d.get("pos", {}).get("y", 0))
