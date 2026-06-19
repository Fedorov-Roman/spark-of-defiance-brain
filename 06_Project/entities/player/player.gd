class_name Player extends CharacterBody2D

enum State {
    IDLE, RUN, JUMP, FALL, WALL_SLIDE, WALL_JUMP,
    DASH, ROLL, CROUCH, LEDGE_GRAB, LEDGE_PULLUP,
    GRAPPLE_SWING, GRAPPLE_PULL, DEAD
}

@export var speed: float = 120.0
@export var jump_velocity: float = -280.0
@export var wall_jump_velocity: Vector2 = Vector2(180.0, -250.0)
@export var dash_speed: float = 400.0
@export var dash_duration: float = 0.15
@export var roll_duration: float = 0.4
@export var gravity: float = 980.0
@export var wall_slide_gravity: float = 120.0
@export var max_dash_energy: float = 100.0
@export var grapple_max_distance: float = 160.0
@export var grapple_swing_force: float = 8.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var hurtbox: CollisionShape2D = $Hurtbox/CollisionShape2D
@onready var wall_check: RayCast2D = $WallCheck
@onready var ledge_check: RayCast2D = $LedgeCheck
@onready var grapple_cast: RayCast2D = $GrappleCast

var current_state: State = State.IDLE
var facing: int = 1
var dash_energy: float = 100.0
var can_air_dash: bool = true
var is_invulnerable: bool = false
var hp: int = 3
var max_hp: int = 3
var ammo: int = 3
var max_ammo: int = 5

var grapple_point: Vector2 = Vector2.ZERO
var grapple_active: bool = false
var grapple_length: float = 0.0

signal hp_changed(new_hp: int, max_hp: int)
signal ammo_changed(new_ammo: int, max_ammo: int)
signal dash_energy_changed(new_energy: float, max_energy: float)
signal state_changed(new_state: State)
signal died

func _ready() -> void:
    hp_changed.emit(hp, max_hp)
    ammo_changed.emit(ammo, max_ammo)
    dash_energy_changed.emit(dash_energy, max_dash_energy)

func _physics_process(delta: float) -> void:
    var time_scale: float = TimeManager.get_time_scale() if TimeManager else 1.0
    var adjusted_delta: float = delta * time_scale

    _handle_input()

    match current_state:
        State.IDLE, State.RUN, State.CROUCH:
            _apply_gravity(adjusted_delta)
            _move_ground()
        State.JUMP, State.FALL, State.WALL_JUMP:
            _apply_gravity(adjusted_delta)
            _move_air()
        State.WALL_SLIDE:
            _wall_slide(adjusted_delta)
        State.DASH:
            _dash(adjusted_delta)
        State.ROLL:
            _roll(adjusted_delta)
        State.LEDGE_GRAB:
            _ledge_grab(adjusted_delta)
        State.LEDGE_PULLUP:
            _ledge_pullup(adjusted_delta)
        State.GRAPPLE_SWING:
            _grapple_swing(adjusted_delta)
        State.GRAPPLE_PULL:
            _grapple_pull(adjusted_delta)
        State.DEAD:
            return

    # CRITICAL FIX: move_and_slide FIRST, then get wall normal
    move_and_slide()

    # After move_and_slide, check wall normal for wall-jump
    if current_state in [State.WALL_SLIDE, State.JUMP, State.FALL]:
        if is_on_wall_only() and Input.is_action_pressed("move_left"):
            var wall_normal := get_wall_normal()
            if wall_normal.x > 0.1:
                _start_wall_slide(wall_normal)
        elif is_on_wall_only() and Input.is_action_pressed("move_right"):
            var wall_normal := get_wall_normal()
            if wall_normal.x < -0.1:
                _start_wall_slide(wall_normal)

    # Ledge detection after movement
    if current_state in [State.IDLE, State.RUN, State.JUMP, State.FALL]:
        _check_ledge()

    # Transition checks
    if current_state in [State.JUMP, State.FALL, State.WALL_JUMP] and is_on_floor():
        _transition_to(State.IDLE)
        can_air_dash = true

func _handle_input() -> void:
    if current_state == State.DEAD:
        return

    var move_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")

    # Dash — 4 directions only (cardinal)
    if Input.is_action_just_pressed("dash") and dash_energy >= 20.0:
        var dash_dir := _get_cardinal_direction(move_input)
        if dash_dir != Vector2.ZERO:
            _start_dash(dash_dir)
            return

    # Grapple
    if Input.is_action_just_pressed("grapple"):
        _try_grapple()
        return

    if grapple_active and Input.is_action_just_released("grapple"):
        _release_grapple()
        return

    # Jump
    if Input.is_action_just_pressed("jump"):
        match current_state:
            State.IDLE, State.RUN, State.CROUCH:
                if is_on_floor():
                    _start_jump()
            State.WALL_SLIDE:
                _start_wall_jump()
            State.LEDGE_GRAB:
                _start_ledge_pullup()
            State.GRAPPLE_SWING, State.GRAPPLE_PULL:
                _release_grapple()
                _start_jump()

    # Roll
    if Input.is_action_just_pressed("roll") and is_on_floor():
        if current_state in [State.IDLE, State.RUN]:
            _start_roll()

    # Crouch
    if Input.is_action_pressed("crouch") and is_on_floor():
        if current_state in [State.IDLE, State.RUN]:
            _transition_to(State.CROUCH)
    elif Input.is_action_just_released("crouch") and current_state == State.CROUCH:
        _transition_to(State.IDLE)

    # Sniper
    if Input.is_action_just_pressed("sniper_fire"):
        _fire_sniper()

    # Knife
    if Input.is_action_just_pressed("knife_attack"):
        _knife_attack()

    # Time Dagger
    if Input.is_action_just_pressed("time_dagger"):
        if TimeManager:
            TimeManager.activate_time_dagger()

func _get_cardinal_direction(input_vec: Vector2) -> Vector2:
    if input_vec == Vector2.ZERO:
        return Vector2(facing, 0)  # Default forward
    var angle := input_vec.angle()
    var deg := rad_to_deg(angle)
    if abs(deg) <= 45 or abs(deg) >= 315:
        return Vector2(1, 0)
    elif abs(deg - 90) <= 45:
        return Vector2(0, -1)
    elif abs(deg - 180) <= 45 or abs(deg + 180) <= 45:
        return Vector2(-1, 0)
    elif abs(deg + 90) <= 45:
        return Vector2(0, 1)
    return Vector2(facing, 0)

func _apply_gravity(delta: float) -> void:
    velocity.y += gravity * delta
    velocity.y = min(velocity.y, 600.0)

func _move_ground() -> void:
    var input_x := Input.get_axis("move_left", "move_right")
    if input_x != 0:
        facing = sign(input_x)
        sprite.flip_h = (facing < 0)
        velocity.x = input_x * speed
        if current_state != State.CROUCH:
            _transition_to(State.RUN)
    else:
        velocity.x = move_toward(velocity.x, 0, speed * 0.2)
        if current_state != State.CROUCH:
            _transition_to(State.IDLE)

func _move_air() -> void:
    var input_x := Input.get_axis("move_left", "move_right")
    if input_x != 0:
        facing = sign(input_x)
        sprite.flip_h = (facing < 0)
    velocity.x = input_x * speed * 0.8

func _start_jump() -> void:
    velocity.y = jump_velocity
    _transition_to(State.JUMP)

func _start_wall_slide(wall_normal: Vector2) -> void:
    current_state = State.WALL_SLIDE
    facing = -sign(wall_normal.x)
    sprite.flip_h = (facing < 0)
    state_changed.emit(current_state)

func _wall_slide(delta: float) -> void:
    velocity.y = wall_slide_gravity * delta
    velocity.x = 0
    if Input.is_action_just_pressed("jump"):
        _start_wall_jump()
    elif not is_on_wall():
        _transition_to(State.FALL)

func _start_wall_jump() -> void:
    var wall_normal := get_wall_normal()
    if wall_normal == Vector2.ZERO:
        wall_normal = Vector2(-facing, 0)
    velocity = Vector2(wall_normal.x * wall_jump_velocity.x, wall_jump_velocity.y)
    facing = sign(velocity.x) if velocity.x != 0 else facing
    sprite.flip_h = (facing < 0)
    _transition_to(State.WALL_JUMP)

func _start_dash(direction: Vector2) -> void:
    current_state = State.DASH
    is_invulnerable = true
    dash_energy -= 20.0
    dash_energy_changed.emit(dash_energy, max_dash_energy)
    velocity = direction * dash_speed
    state_changed.emit(current_state)
    await get_tree().create_timer(dash_duration).timeout
    if current_state == State.DASH:
        is_invulnerable = false
        if is_on_floor():
            _transition_to(State.IDLE)
        else:
            can_air_dash = false
            _transition_to(State.FALL)

func _dash(delta: float) -> void:
    pass  # Velocity set once, maintained by inertia

func _start_roll() -> void:
    current_state = State.ROLL
    is_invulnerable = true
    hitbox.disabled = true
    state_changed.emit(current_state)
    await get_tree().create_timer(roll_duration).timeout
    if current_state == State.ROLL:
        is_invulnerable = false
        hitbox.disabled = false
        _transition_to(State.IDLE)

func _roll(delta: float) -> void:
    velocity.x = facing * speed * 1.5
    velocity.y = 0

func _check_ledge() -> void:
    if not ledge_check:
        return
    ledge_check.position = Vector2(facing * 10, -16)
    ledge_check.target_position = Vector2(facing * 8, -8)
    ledge_check.force_raycast_update()
    if not ledge_check.is_colliding():
        # No wall above, but wall below? Ledge detected
        wall_check.position = Vector2(facing * 8, 0)
        wall_check.target_position = Vector2(facing * 4, 0)
        wall_check.force_raycast_update()
        if wall_check.is_colliding():
            _start_ledge_grab()

func _start_ledge_grab() -> void:
    current_state = State.LEDGE_GRAB
    velocity = Vector2.ZERO
    state_changed.emit(current_state)

func _ledge_grab(delta: float) -> void:
    velocity = Vector2.ZERO

func _start_ledge_pullup() -> void:
    current_state = State.LEDGE_PULLUP
    state_changed.emit(current_state)
    await get_tree().create_timer(0.4).timeout
    if current_state == State.LEDGE_PULLUP:
        global_position.y -= 16
        global_position.x += facing * 4
        _transition_to(State.IDLE)

func _ledge_pullup(delta: float) -> void:
    velocity = Vector2(facing * 30, -40)

func _try_grapple() -> void:
    if not grapple_cast:
        return
    grapple_cast.target_position = Vector2(facing, 0).normalized() * grapple_max_distance
    grapple_cast.force_raycast_update()
    if grapple_cast.is_colliding():
        grapple_point = grapple_cast.get_collision_point()
        grapple_length = global_position.distance_to(grapple_point)
        grapple_active = true
        _transition_to(State.GRAPPLE_SWING)

func _release_grapple() -> void:
    grapple_active = false
    grapple_point = Vector2.ZERO
    if current_state in [State.GRAPPLE_SWING, State.GRAPPLE_PULL]:
        _transition_to(State.FALL)

func _grapple_swing(delta: float) -> void:
    if not grapple_active:
        return
    var to_grapple := grapple_point - global_position
    var dist := to_grapple.length()
    if dist > grapple_length:
        var correction := (dist - grapple_length) * to_grapple.normalized()
        velocity += correction * 10
    velocity += Vector2(0, gravity * 0.5) * delta
    var swing_input := Input.get_axis("move_left", "move_right")
    velocity.x += swing_input * grapple_swing_force

func _grapple_pull(delta: float) -> void:
    var dir := (grapple_point - global_position).normalized()
    velocity = dir * speed * 2.0
    if global_position.distance_to(grapple_point) < 8.0:
        _release_grapple()
        _transition_to(State.IDLE)

func _fire_sniper() -> void:
    if ammo <= 0:
        return
    ammo -= 1
    ammo_changed.emit(ammo, max_ammo)
    # Raycast from player in facing direction
    var space_state := get_world_2d().direct_space_state
    var query := PhysicsRayQueryParameters2D.create(
        global_position,
        global_position + Vector2(facing, 0) * 300.0,
        0b11111110  # Exclude player layer
    )
    var result := space_state.intersect_ray(query)
    if result:
        var collider := result.collider
        if collider.has_method("paralyze"):
            collider.paralyze(10.0)
        elif collider.has_method("take_damage"):
            collider.take_damage(1)

func _knife_attack() -> void:
    var space_state := get_world_2d().direct_space_state
    var query := PhysicsShapeQueryParameters2D.new()
    # Melee range check
    var melee_pos := global_position + Vector2(facing * 12, 0)
    var circle := CircleShape2D.new()
    circle.radius = 8.0
    query.shape = circle
    query.transform = Transform2D(0, melee_pos)
    query.collision_mask = 0b10  # Enemy layer
    var results := space_state.intersect_shape(query, 4)
    for r in results:
        var collider := r.collider
        if collider.has_method("stealth_kill"):
            collider.stealth_kill()
        elif collider.has_method("take_damage"):
            collider.take_damage(3)

func take_damage(amount: int) -> void:
    if is_invulnerable or current_state == State.DEAD:
        return
    hp -= amount
    hp_changed.emit(hp, max_hp)
    if hp <= 0:
        _die()
    else:
        _start_invulnerability_frames(0.5)

func _start_invulnerability_frames(duration: float) -> void:
    is_invulnerable = true
    sprite.modulate.a = 0.5
    await get_tree().create_timer(duration).timeout
    sprite.modulate.a = 1.0
    is_invulnerable = false

func _die() -> void:
    _transition_to(State.DEAD)
    died.emit()
    await get_tree().create_timer(1.0).timeout
    # Respawn handled by GameState/LevelManager

func _transition_to(new_state: State) -> void:
    if current_state == new_state:
        return
    current_state = new_state
    state_changed.emit(new_state)
    _update_animation()

func _update_animation() -> void:
    match current_state:
        State.IDLE: sprite.play("idle")
        State.RUN: sprite.play("run")
        State.JUMP, State.WALL_JUMP: sprite.play("jump")
        State.FALL: sprite.play("fall")
        State.WALL_SLIDE: sprite.play("wall_slide")
        State.DASH: sprite.play("dash")
        State.ROLL: sprite.play("roll")
        State.CROUCH: sprite.play("crouch")
        State.LEDGE_GRAB: sprite.play("ledge_grab")
        State.LEDGE_PULLUP: sprite.play("ledge_pullup")
        State.GRAPPLE_SWING: sprite.play("grapple")
        State.GRAPPLE_PULL: sprite.play("grapple")
        State.DEAD: sprite.play("death")

func serialize() -> Dictionary:
    return {
        "hp": hp,
        "max_hp": max_hp,
        "ammo": ammo,
        "max_ammo": max_ammo,
        "dash_energy": dash_energy,
        "max_dash_energy": max_dash_energy,
        "position": {"x": global_position.x, "y": global_position.y},
        "state": current_state,
        "facing": facing
    }

func deserialize(data: Dictionary) -> void:
    hp = data.get("hp", 3)
    max_hp = data.get("max_hp", 3)
    ammo = data.get("ammo", 3)
    max_ammo = data.get("max_ammo", 5)
    dash_energy = data.get("dash_energy", 100.0)
    max_dash_energy = data.get("max_dash_energy", 100.0)
    global_position = Vector2(data.get("position", {}).get("x", 0.0), data.get("position", {}).get("y", 0.0))
    facing = data.get("facing", 1)
    hp_changed.emit(hp, max_hp)
    ammo_changed.emit(ammo, max_ammo)
    dash_energy_changed.emit(dash_energy, max_dash_energy)
