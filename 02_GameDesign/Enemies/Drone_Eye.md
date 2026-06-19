# 🛸 Enemy: Drone "Eye" (Глаз)

> **Класс Godot:** `CharacterBody2D` + `Area2D` (конус зрения) + `RayCast2D`  
> **Группа:** `"enemies"`, `"drones"`, `"time_affected"`  
> **HP:** 1 (stealth kill) / паралич (снайперка)  

## Визуал
- Летающая сфера, один большой синий глаз-камера.
- Холодный металлический корпус, гравировка символа SUN.
- Антенны, маленькие реактивные двигатели.

## AI Behavior (State Machine)

### State: PATROL
- Движение по заданным точкам (`Marker2D` на маршруте).
- Скорость: 60 px/sec.
- Конус зрения: 90° угол, 120 px дальность.
- Если видит Кая → переход в ALERT.

### State: ALERT
- Остановка, иконка "!".
- Звуковой сигнал (заметен в радиусе 200 px).
- Тревожный таймер 5 сек → спавн 2 подкреплений.
- Если потерял Кая → SEARCH (30 сек) → PATROL.

### State: DISABLED (ЭМИ)
- Падает на землю, анимация падения.
- Выключается на 10 сек.
- Не реагирует на шум/видение.
- После 10 сек → автоматический перезапуск → PATROL.

## Godot Specification

```gdscript
class_name DroneEye extends CharacterBody2D

enum State { PATROL, ALERT, SEARCH, DISABLED }

@export var patrol_speed: float = 60.0
@export var vision_angle: float = 90.0
@export var vision_distance: float = 120.0
@export var alert_time: float = 5.0
@export var search_time: float = 30.0
@export var disable_time: float = 10.0

@onready var vision_area: Area2D = $VisionArea
@onready var vision_ray: RayCast2D = $VisionRay
@onready var alert_timer: Timer = $AlertTimer
@onready var search_timer: Timer = $SearchTimer
@onready var disable_timer: Timer = $DisableTimer
@onready var sprite: AnimatedSprite2D = $Sprite

var _state: State = State.PATROL
var _patrol_points: Array[Marker2D] = []
var _current_point: int = 0
var _is_time_affected: bool = true

func _ready() -> void:
    add_to_group("enemies")
    add_to_group("drones")
    add_to_group("time_affected")
    # Собираем точки патруля
    for child in get_parent().get_children():
        if child is Marker2D and child.name.begins_with("Patrol"):
            _patrol_points.append(child)

func _physics_process(delta: float) -> void:
    var effective_delta := delta * TimeManager.time_scale if _is_time_affected else delta

    match _state:
        State.PATROL: _process_patrol(effective_delta)
        State.ALERT: _process_alert(effective_delta)
        State.SEARCH: _process_search(effective_delta)
        State.DISABLED: _process_disabled(effective_delta)

func _process_patrol(delta: float) -> void:
    if _patrol_points.is_empty(): return
    var target := _patrol_points[_current_point].global_position
    var dir := (target - global_position).normalized()
    velocity = dir * patrol_speed
    move_and_slide()

    if global_position.distance_to(target) < 5.0:
        _current_point = (_current_point + 1) % _patrol_points.size()

    _check_vision()

func _check_vision() -> void:
    # Проверка через Area2D + RayCast2D
    for body in vision_area.get_overlapping_bodies():
        if body.is_in_group("player"):
            vision_ray.target_position = body.global_position - global_position
            vision_ray.force_raycast_update()
            if vision_ray.is_colliding() and vision_ray.get_collider() == body:
                _transition_to(State.ALERT)
                return

func _transition_to(new_state: State) -> void:
    _state = new_state
    match new_state:
        State.ALERT:
            alert_timer.start()
            sprite.play("alert")
        State.SEARCH:
            search_timer.start()
            sprite.play("search")
        State.DISABLED:
            disable_timer.start()
            sprite.play("disabled")
            velocity = Vector2.ZERO

func disable(duration: float = 10.0) -> void:
    disable_timer.wait_time = duration
    _transition_to(State.DISABLED)

func _on_disable_timer_timeout() -> void:
    _transition_to(State.PATROL)
```

## Подводные камни
- `vision_area` — `CollisionPolygon2D` в форме треугольника. Поворот через `rotation` родителя.
- `vision_ray` — должен игнорировать самого дрона (`add_exception(self)`).
- При замедлении времени: `effective_delta` масштабирует скорость, но НЕ таймеры (таймеры Godot используют `Engine.time_scale`, поэтому для кастомного замедления нужно `Timer` с `process_callback = PHYSICS` и ручное отслеживание).

---

*Дрон — базовый враг для обучения стелсу. Уязвим к ЭМИ и скрытым убийствам.*
