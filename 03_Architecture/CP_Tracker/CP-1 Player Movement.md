# ТЗ — CP-1: Player Movement Core

> **Цель:** Кай бегает, прыгает, цепляется за стены, скользит вниз, отталкивается от стены, приседает, цепляется за уступ. Camera2D следует за ним. Placeholder анимации (цветные квадраты).

---

## Критерий готовности (чеклист для Романа)

- [ ] Кай бегает влево/вправо (геймпад левый стик / A-D)
- [ ] Прыжок (крестик / Пробел) — стандартная высота 280px
- [ ] Wall-slide: автоматическое замедление падения у стены (фрикция 0.3)
- [ ] Wall-jump: отскок от стены с импульсом (180px вверх, 100px в сторону)
- [ ] Ledge grab: зацепление за уступ (RayCast2D) и подтягивание
- [ ] Приседание: скорость 50%, меньше хитбокс, тише шаги
- [ ] Плавное ускорение/торможение (0.3s до максимума)
- [ ] Camera2D следует за Каем с smoothing
- [ ] Тестовая сцена с платформами, стенами, уступами
- [ ] Placeholder анимации: idle, run, jump, fall, wall_slide, wall_jump, crouch, ledge_grab

---

## Файлы и сцены

### Создать

#### `scripts/entities/player/player.gd`

```gdscript
class_name Player extends CharacterBody2D

## --- @export переменные (видны в Inspector) ---
@export_group("Movement")
@export var speed: float = 120.0
@export var acceleration: float = 400.0
@export var friction: float = 400.0
@export var jump_force: float = 280.0
@export var gravity: float = 980.0

@export_group("Wall Mechanics")
@export var wall_slide_friction: float = 0.3
@export var wall_slide_max_speed: float = 80.0
@export var wall_jump_force: float = 180.0
@export var wall_jump_push: float = 100.0

@export_group("Ledge Grab")
@export var ledge_ray_length: float = 12.0
@export var ledge_offset: Vector2 = Vector2(0, -8)

@export_group("Crouch")
@export var crouch_speed_multiplier: float = 0.5
@export var crouch_height: float = 20.0
@export var stand_height: float = 32.0

## --- @onready переменные ---
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var crouch_shape: CollisionShape2D = $CrouchCollisionShape2D
@onready var ground_ray: RayCast2D = $GroundRayCast
@onready var wall_left_ray: RayCast2D = $WallLeftRayCast
@onready var wall_right_ray: RayCast2D = $WallRightRayCast
@onready var ledge_ray: RayCast2D = $LedgeRayCast
@onready var camera: Camera2D = $Camera2D

## --- Сигналы ---
signal landed()
signal jumped()
signal wall_jumped(direction: int)
signal ledge_grabbed()

## --- Состояние ---
var is_crouching: bool = false
var is_wall_sliding: bool = false
var is_ledge_grabbing: bool = false
var facing_direction: int = 1  # 1 = right, -1 = left
var was_on_floor: bool = false

func _ready() -> void:
    # Builder: инициализация камеры, настройка RayCast
    pass

func _physics_process(delta: float) -> void:
    # Builder: главный цикл движения
    # 1. Проверка ledge grab (если не на земле, падаем, ledge_ray срабатывает)
    # 2. Проверка wall slide (если касается стены, падает, не на земле)
    # 3. Применение гравитации (если не wall_slide и не ledge_grab)
    # 4. Ввод (бег, прыжок, приседание)
    # 5. move_and_slide()
    pass

func _handle_input(delta: float) -> void:
    # Builder: обработка ввода
    # - move_left/right: изменение velocity.x с ускорением/фрикцией
    # - jump: если на земле или wall_slide — прыжок
    # - crouch: удержание кнопки, смена collision_shape
    pass

func _apply_gravity(delta: float) -> void:
    # Builder: если не на земле и не wall_slide — velocity.y += gravity * delta
    pass

func _check_wall_slide(delta: float) -> void:
    # Builder: если is_on_wall() и velocity.y > 0 и !is_on_floor()
    # - is_wall_sliding = true
    # - velocity.y = min(velocity.y, wall_slide_max_speed)
    # - velocity.y *= wall_slide_friction (если удерживать кнопку к стене)
    pass

func _check_ledge_grab() -> void:
    # Builder: если ledge_ray.is_colliding() и !is_on_floor() и velocity.y > 0
    # - is_ledge_grabbing = true
    # - velocity = Vector2.ZERO
    # - snap position к уступу
    pass

func _perform_jump() -> void:
    # Builder: если на земле — обычный прыжок
    # Если wall_slide — wall-jump (импульс в сторону от стены и вверх)
    pass

func _perform_wall_jump() -> void:
    # Builder: velocity.y = -wall_jump_force
    # velocity.x = wall_jump_push * facing_direction (от стены)
    # is_wall_sliding = false
    pass

func _update_facing(direction: float) -> void:
    # Builder: если direction != 0, facing_direction = sign(direction)
    # sprite.flip_h = facing_direction < 0
    pass

func _update_collision_shape() -> void:
    # Builder: если is_crouching — включаем crouch_shape, выключаем collision_shape
    # Иначе — наоборот
    pass
```

#### `scripts/entities/player/states/player_state.gd` (базовый класс состояния)

```gdscript
class_name PlayerState extends Node

var player: Player = null

func _ready() -> void:
    await owner.ready
    player = owner as Player

func enter() -> void:
    pass

func exit() -> void:
    pass

func update(delta: float) -> void:
    pass

func physics_update(delta: float) -> void:
    pass
```

#### `scripts/entities/player/states/idle_state.gd`

```gdscript
class_name IdleState extends PlayerState

func enter() -> void:
    # Builder: анимация idle
    pass

func physics_update(delta: float) -> void:
    # Builder: если input != 0 → transition to RunState
    # если jump pressed → transition to JumpState
    # если crouch pressed → transition to CrouchState
    pass
```

#### `scripts/entities/player/states/run_state.gd`

```gdscript
class_name RunState extends PlayerState

func enter() -> void:
    # Builder: анимация run
    pass

func physics_update(delta: float) -> void:
    # Builder: применение velocity.x с ускорением
    # если input == 0 → transition to IdleState
    # если !is_on_floor() → transition to FallState
    pass
```

#### `scripts/entities/player/states/jump_state.gd`

```gdscript
class_name JumpState extends PlayerState

func enter() -> void:
    # Builder: velocity.y = -jump_force, анимация jump
    pass

func physics_update(delta: float) -> void:
    # Builder: если velocity.y > 0 → transition to FallState
    # если is_on_wall() → transition to WallSlideState
    pass
```

#### `scripts/entities/player/states/fall_state.gd`

```gdscript
class_name FallState extends PlayerState

func physics_update(delta: float) -> void:
    # Builder: если is_on_floor() → transition to IdleState
    # если is_on_wall() → transition to WallSlideState
    # если ledge detected → transition to LedgeGrabState
    pass
```

#### `scripts/entities/player/states/wall_slide_state.gd`

```gdscript
class_name WallSlideState extends PlayerState

func enter() -> void:
    # Builder: анимация wall_slide
    pass

func physics_update(delta: float) -> void:
    # Builder: velocity.y = min(velocity.y, wall_slide_max_speed) * friction
    # если jump pressed → transition to WallJumpState
    # если !is_on_wall() → transition to FallState
    pass
```

#### `scripts/entities/player/states/wall_jump_state.gd`

```gdscript
class_name WallJumpState extends PlayerState

func enter() -> void:
    # Builder: применить wall_jump импульс, анимация wall_jump
    pass

func physics_update(delta: float) -> void:
    # Builder: если velocity.y > 0 → transition to FallState
    pass
```

#### `scripts/entities/player/states/crouch_state.gd`

```gdscript
class_name CrouchState extends PlayerState

func enter() -> void:
    # Builder: is_crouching = true, смена collision_shape
    pass

func exit() -> void:
    # Builder: is_crouching = false, восстановление collision_shape
    pass

func physics_update(delta: float) -> void:
    # Builder: скорость *= crouch_speed_multiplier
    # если !crouch pressed → transition to IdleState
    pass
```

#### `scripts/entities/player/states/ledge_grab_state.gd`

```gdscript
class_name LedgeGrabState extends PlayerState

func enter() -> void:
    # Builder: velocity = ZERO, snap к уступу, анимация ledge_grab
    pass

func physics_update(delta: float) -> void:
    # Builder: если jump pressed → подтягивание (transition to IdleState с импульсом вверх)
    # если down pressed → отпускание (transition to FallState)
    pass
```

#### `scripts/entities/player/states/state_machine.gd`

```gdscript
class_name PlayerStateMachine extends Node

signal state_changed(new_state: String, old_state: String)

@export var initial_state: PlayerState

var current_state: PlayerState = null
var previous_state: PlayerState = null
var states: Dictionary = {}

func _ready() -> void:
    # Builder: собрать все дочерние состояния в states
    for child in get_children():
        if child is PlayerState:
            states[child.name] = child
            child.player = get_parent() as Player
    if initial_state:
        change_state(initial_state.name)

func change_state(state_name: String) -> void:
    if not states.has(state_name):
        return
    if current_state:
        current_state.exit()
    previous_state = current_state
    current_state = states[state_name]
    current_state.enter()
    state_changed.emit(state_name, previous_state.name if previous_state else "")

func _physics_process(delta: float) -> void:
    if current_state:
        current_state.physics_update(delta)

func _process(delta: float) -> void:
    if current_state:
        current_state.update(delta)
```

#### `scenes/entities/player/player.tscn`

```
Корень: CharacterBody2D
├── Sprite2D (name: Sprite2D)
│   └── texture: placeholder_red_square_32x32.png (или ColorRect 32×32)
├── CollisionShape2D (name: CollisionShape2D)
│   └── shape: RectangleShape2D (size: 32×32)
├── CollisionShape2D (name: CrouchCollisionShape2D)
│   └── shape: RectangleShape2D (size: 32×20)
│   └── disabled: true
├── RayCast2D (name: GroundRayCast)
│   └── target_position: Vector2(0, 4)
│   └── collision_mask: 3 (world)
├── RayCast2D (name: WallLeftRayCast)
│   └── target_position: Vector2(-8, 0)
│   └── collision_mask: 3 (world)
├── RayCast2D (name: WallRightRayCast)
│   └── target_position: Vector2(8, 0)
│   └── collision_mask: 3 (world)
├── RayCast2D (name: LedgeRayCast)
│   └── target_position: Vector2(12, -12)  # вперёд и вверх
│   └── collision_mask: 3 (world)
├── Camera2D (name: Camera2D)
│   └── position_smoothing_enabled: true
│   └── position_smoothing_speed: 8.0
│   └── zoom: Vector2(2, 2)  # x2 pixel-perfect
│   └── process_callback: CAMERA2D_PROCESS_PHYSICS
└── PlayerStateMachine (Node, name: StateMachine)
    ├── IdleState (player_state.gd)
    ├── RunState (player_state.gd)
    ├── JumpState (player_state.gd)
    ├── FallState (player_state.gd)
    ├── WallSlideState (player_state.gd)
    ├── WallJumpState (player_state.gd)
    ├── CrouchState (player_state.gd)
    └── LedgeGrabState (player_state.gd)
```

#### `scenes/levels/test_movement.tscn`

```
Корень: Node2D
├── TileMapLayer (ground) — несколько платформ
├── TileMapLayer (walls) — стены для wall-slide
├── TileMapLayer (ledges) — уступы для ledge-grab
├── Player (player.tscn)
└── Camera2D (опционально, если не в Player)
```

---

## Правила реализации

1. **State Machine — обязательно.** Не использовать if-цепочки в `player.gd`. Каждое состояние — отдельный класс.
2. **Все состояния наследуют `PlayerState`.** У них есть `enter()`, `exit()`, `update()`, `physics_update()`.
3. **Переходы между состояниями — только через `StateMachine.change_state()`.** Не менять состояние напрямую.
4. **Визуал:** `AnimatedSprite2D` с placeholder'ами (цветные квадраты разного цвета для каждого состояния). Не нужны настоящие спрайты.
5. **Camera2D:** `zoom = Vector2(2, 2)` для x2. `position_smoothing_enabled = true`.
6. **RayCast2D:** все должны быть `enabled = true` и `collide_with_areas = false`, `collide_with_bodies = true`.
7. **Collision:** Player на Layer 1 (player), маски 2+3 (enemies + world).

---

## Подводные камни

- **State Machine в `_ready()`:** дочерние состояния могут быть не готовы. Использовать `await owner.ready` или `_enter_tree()`.
- **Camera2D zoom:** `zoom = Vector2(2, 2)` уменьшает видимую область в 2 раза. Убедиться, что `Camera2D` обновляется в `_physics_process` (`process_callback = CAMERA2D_PROCESS_PHYSICS`).
- **Wall-slide фрикция:** `velocity.y *= wall_slide_friction` каждый кадр — это экспоненциальное замедление. Может быть слишком резким. Альтернатива: `velocity.y = min(velocity.y, wall_slide_max_speed)`.
- **Ledge grab:** `LedgeRayCast` должен быть направлен ВПЕРЁД и ВВЕРХ от рук Кая. Если Кай смотрит влево — инвертировать `target_position.x`.
- **Crouch collision:** при смене формы проверять, что над головой нет препятствия (`test_move()`). Иначе Кай застрянет.
- **Input:** для геймпада использовать `Input.get_vector("move_left", "move_right", "move_up", "move_down")` — это автоматически обрабатывает стик и deadzone.

---

*ТЗ CP-1 готово. После приёмки — переход к CP-2 (Dash and Roll).*
