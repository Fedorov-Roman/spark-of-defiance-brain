# ТЗ — CP-1: Player Movement

## Цель
Реализовать полноценное движение Кая: бег, прыжок, wall-slide, wall-jump, dash, roll, crouch, ledge grab.

## Критерий готовности
- [ ] Кай (placeholder 32×32) бегает влево/вправо с плавным ускорением.
- [ ] Прыжок с coyote time и jump buffer.
- [ ] Wall-slide автоматический при касании стены.
- [ ] Wall-jump меняет направление с импульсом.
- [ ] Dash в 4 направления (в воздухе 1 раз).
- [ ] Roll с i-frames 0.4 сек, хитбокс уменьшается.
- [ ] Crouch снижает скорость, шум, хитбокс.
- [ ] Ledge grab: зацепление за уступ и подтягивание.
- [ ] Все параметры — `@export` для Inspector.

## Файлы и сцены

### Создать
- `scripts/entities/player/player.gd` — основной скрипт игрока.
- `scripts/entities/player/player_state_machine.gd` — State Machine.
- `scenes/entities/player/player.tscn` — сцена игрока.
- `scenes/levels/test_movement.tscn` — тестовый уровень (TileMap с платформами и стенами).

### Модифицировать
- `scenes/core/main.tscn` — заменить placeholder на `player.tscn`.

## Спецификация нод

### Сцена: `scenes/entities/player/player.tscn`
- Корень: `CharacterBody2D` (name = "Player")
- Дочерние:
  - `AnimatedSprite2D` (name = "Sprite") — placeholder (красный квадрат).
  - `CollisionShape2D` (name = "StandingHitbox") — `RectangleShape2D`, 16×32.
  - `CollisionShape2D` (name = "CrouchHitbox") — `RectangleShape2D`, 16×16. **Disabled по умолчанию.**
  - `RayCast2D` (name = "LedgeDetector") — направлен вперёд и вниз.
  - `Area2D` (name = "NoiseArea") — круг, радиус меняется в зависимости от скорости.
  - `Timer` (name = "RollTimer") — 0.4 сек.
  - `Timer` (name = "DashTimer") — 0.2 сек.
  - `Timer` (name = "CoyoteTimer") — 0.1 сек.
  - `Timer` (name = "JumpBufferTimer") — 0.1 сек.
- Скрипт: `scripts/entities/player/player.gd`

### Класс: `Player` (extends CharacterBody2D)
```gdscript
class_name Player extends CharacterBody2D

## @export переменные
@export var speed: float = 120.0
@export var acceleration: float = 800.0
@export var friction: float = 800.0
@export var jump_velocity: float = -280.0
@export var wall_slide_speed: float = 60.0
@export var wall_jump_push: float = 200.0
@export var dash_speed: float = 300.0
@export var dash_duration: float = 0.2
@export var gravity: float = 980.0
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1

## @onready
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var standing_hitbox: CollisionShape2D = $StandingHitbox
@onready var crouch_hitbox: CollisionShape2D = $CrouchHitbox
@onready var ledge_detector: RayCast2D = $LedgeDetector
@onready var noise_area: Area2D = $NoiseArea
@onready var roll_timer: Timer = $RollTimer
@onready var dash_timer: Timer = $DashTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

## Состояние
var _state: int = State.IDLE
var _facing: int = 1  # 1 = right, -1 = left
var _can_dash_air: bool = true
var _is_rolling: bool = false
var _is_crouching: bool = false
var _is_grabbing_ledge: bool = false

enum State {
    IDLE, RUN, JUMP, FALL, WALL_SLIDE, WALL_JUMP, 
    DASH, ROLL, CROUCH, LEDGE_GRAB
}

func _ready() -> void:
    roll_timer.wait_time = 0.4
    dash_timer.wait_time = dash_duration
    coyote_timer.wait_time = coyote_time
    jump_buffer_timer.wait_time = jump_buffer_time
    roll_timer.one_shot = true
    dash_timer.one_shot = true
    coyote_timer.one_shot = true
    jump_buffer_timer.one_shot = true

func _physics_process(delta: float) -> void:
    # Гравитация
    if not is_on_floor() and not _is_grabbing_ledge:
        velocity.y += gravity * delta

    # Обработка состояний
    match _state:
        State.IDLE, State.RUN, State.CROUCH:
            _handle_ground_movement(delta)
        State.JUMP, State.FALL:
            _handle_air_movement(delta)
        State.WALL_SLIDE:
            _handle_wall_slide(delta)
        State.WALL_JUMP:
            _handle_wall_jump(delta)
        State.DASH:
            _handle_dash(delta)
        State.ROLL:
            _handle_roll(delta)
        State.LEDGE_GRAB:
            _handle_ledge_grab(delta)

    move_and_slide()

func _handle_ground_movement(delta: float) -> void:
    var input_dir := Input.get_axis("move_left", "move_right")

    if _is_crouching:
        input_dir *= 0.5

    if input_dir != 0:
        velocity.x = move_toward(velocity.x, input_dir * speed, acceleration * delta)
        _facing = sign(input_dir)
        sprite.flip_h = _facing < 0
        if not _is_crouching:
            _transition_to(State.RUN)
        else:
            _transition_to(State.CROUCH)
    else:
        velocity.x = move_toward(velocity.x, 0.0, friction * delta)
        if not _is_crouching:
            _transition_to(State.IDLE)
        else:
            _transition_to(State.CROUCH)

    # Jump
    if Input.is_action_just_pressed("jump"):
        if is_on_floor() or not coyote_timer.is_stopped():
            _jump()
        else:
            jump_buffer_timer.start()

    # Dash
    if Input.is_action_just_pressed("dash"):
        _start_dash()

    # Roll
    if Input.is_action_just_pressed("roll") and is_on_floor():
        _start_roll()

    # Crouch
    _is_crouching = Input.is_action_pressed("crouch")
    _update_hitbox()

    # Coyote time
    if is_on_floor():
        _can_dash_air = true
        if not jump_buffer_timer.is_stopped():
            _jump()
            jump_buffer_timer.stop()
    else:
        if velocity.y > 0 and coyote_timer.is_stopped():
            coyote_timer.start()
        _transition_to(State.FALL)

func _handle_air_movement(delta: float) -> void:
    var input_dir := Input.get_axis("move_left", "move_right")
    velocity.x = move_toward(velocity.x, input_dir * speed, acceleration * delta)
    if input_dir != 0:
        _facing = sign(input_dir)
        sprite.flip_h = _facing < 0

    # Wall detection
    if is_on_wall() and velocity.y > 0:
        _transition_to(State.WALL_SLIDE)
        return

    # Dash in air
    if Input.is_action_just_pressed("dash") and _can_dash_air:
        _can_dash_air = false
        _start_dash()

    # Ledge grab
    if _can_grab_ledge():
        _start_ledge_grab()

func _handle_wall_slide(delta: float) -> void:
    velocity.y = min(velocity.y, wall_slide_speed)

    if Input.is_action_just_pressed("jump"):
        _wall_jump()

    if not is_on_wall():
        _transition_to(State.FALL)

func _wall_jump() -> void:
    var wall_normal := get_wall_normal()
    velocity.x = wall_normal.x * wall_jump_push
    velocity.y = jump_velocity
    _facing = sign(wall_normal.x)
    sprite.flip_h = _facing < 0
    _transition_to(State.WALL_JUMP)

func _handle_wall_jump(delta: float) -> void:
    # Постепенное замедление wall-jump импульса
    velocity.x = move_toward(velocity.x, 0.0, friction * delta)
    if is_on_floor():
        _transition_to(State.IDLE)
    elif is_on_wall() and velocity.y > 0:
        _transition_to(State.WALL_SLIDE)

func _start_dash() -> void:
    var dash_dir := Vector2.ZERO
    dash_dir.x = Input.get_axis("move_left", "move_right")
    dash_dir.y = Input.get_axis("move_up", "move_down")

    if dash_dir == Vector2.ZERO:
        dash_dir.x = _facing

    # Только 4 направления (без диагоналей)
    if abs(dash_dir.x) > abs(dash_dir.y):
        dash_dir.y = 0
    else:
        dash_dir.x = 0

    dash_dir = dash_dir.normalized()
    velocity = dash_dir * dash_speed
    _transition_to(State.DASH)
    dash_timer.start()

func _handle_dash(delta: float) -> void:
    if dash_timer.is_stopped():
        velocity.x = move_toward(velocity.x, 0.0, friction * delta)
        if is_on_floor():
            _transition_to(State.IDLE)
        else:
            _transition_to(State.FALL)

func _start_roll() -> void:
    _is_rolling = true
    velocity.x = _facing * speed * 1.5
    _transition_to(State.ROLL)
    roll_timer.start()

func _handle_roll(delta: float) -> void:
    if roll_timer.is_stopped():
        _is_rolling = false
        if is_on_floor():
            _transition_to(State.IDLE)
        else:
            _transition_to(State.FALL)

func _start_ledge_grab() -> void:
    _is_grabbing_ledge = true
    velocity = Vector2.ZERO
    _transition_to(State.LEDGE_GRAB)

func _handle_ledge_grab(delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
        _is_grabbing_ledge = false
        velocity.y = jump_velocity
        velocity.x = _facing * speed * 0.5
        _transition_to(State.JUMP)
    elif Input.is_action_pressed("move_down"):
        _is_grabbing_ledge = false
        _transition_to(State.FALL)

func _can_grab_ledge() -> bool:
    # RayCast2D проверяет уступ
    return ledge_detector.is_colliding() and velocity.y > 0

func _jump() -> void:
    velocity.y = jump_velocity
    coyote_timer.stop()
    _transition_to(State.JUMP)

func _update_hitbox() -> void:
    standing_hitbox.disabled = _is_crouching or _is_rolling
    crouch_hitbox.disabled = not (_is_crouching or _is_rolling)

func _transition_to(new_state: int) -> void:
    if _state == new_state:
        return
    _state = new_state
    # TODO: Builder — добавить смену анимации AnimatedSprite2D
```

## Правила реализации
1. **Строгая типизация:** Все параметры функций типизированы, возвращаемые значения тоже.
2. **State Machine:** Только `_transition_to()` меняет состояние. Никаких прямых присваиваний `_state`.
3. **Физика:** Только в `_physics_process()`. `_process()` не используется для движения.
4. **Hitbox:** `standing_hitbox` и `crouch_hitbox` — только один активен одновременно.
5. **Timers:** Все `Timer` — `one_shot = true`. Запуск через `start()`.

## Подводные камни
- **Wall-slide jitter:** `is_on_wall()` может дребезжать на неровных стенах. Добавить `Timer` задержки 0.05 сек перед переходом в `WALL_SLIDE`.
- **Dash через стены:** `move_and_slide()` сам останавливает при столкновении, но проверь `is_on_wall()` после dash.
- **Roll + Crouch:** Если игрок нажимает crouch во время roll — игнорировать до окончания roll.
- **Ledge grab + TileMap:** `RayCast2D` может не видеть TileMap уступы. Убедиться, что слой `World` имеет коллизию.
- **Coyote time:** `coyote_timer` должен запускаться только если игрок БЫЛ на полу в прошлом кадре, а сейчас нет. Использовать `was_on_floor` флаг.

---

*CP-1 — сердце геймплея. Без плавного движения игра не заработает.*
