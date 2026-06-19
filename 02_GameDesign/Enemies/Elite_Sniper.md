# 🎯 Enemy: Elite Sniper SUN (Элитный снайпер)

> **Класс Godot:** `StaticBody2D` (статичный на вышке)  
> **Группа:** `"enemies"`, `"time_affected"`  
> **HP:** 1 (stealth kill)  

## Визуал
- Снайперская вышка, закамуфлированная под руины.
- Снайпер в броне SUN, прицел с линзой.
- Лазерный прицел (красная точка на земле).

## AI Behavior

### State: SCAN
- Медленное сканирование конусом (180° угол, 200 px дальность).
- Поворот на 15°/сек.
- Лазерная точка движется по траектории.

### State: AIM
- Если видит Кая 2+ секунды.
- Лазерная точка фиксируется на Кае.
- 1.5 сек наведения → выстрел.

### State: FIRE
- Выстрел (мгновенный луч).
- 1 урон Каю (если попал).
- 3 сек перезарядки.
- Если Кай в укрытии → промах, SEARCH.

### State: SEARCH
- Если потерял Кая после AIM.
- Увеличенный конус на 10 сек.
- Затем возврат к SCAN.

## Особенности
- **Статичный:** Не двигается с вышки.
- **Винтовка:** После stealth kill — Кай получает +1 патрон снайперки.
- **Уязвим:** Только со спины (вышка имеет лестницу сзади).

## Godot Specification

```gdscript
class_name EliteSniper extends StaticBody2D

enum State { SCAN, AIM, FIRE, SEARCH }

@export var scan_speed: float = 15.0  # градусов/сек
@export var vision_angle: float = 180.0
@export var vision_distance: float = 200.0
@export var aim_time: float = 1.5
@export var reload_time: float = 3.0

@onready var laser_dot: Sprite2D = $LaserDot
@onready var vision_area: Area2D = $VisionArea
@onready var aim_timer: Timer = $AimTimer
@onready var reload_timer: Timer = $ReloadTimer

func _ready() -> void:
    add_to_group("enemies")
    add_to_group("time_affected")

func _process(delta: float) -> void:
    var effective_delta := delta * TimeManager.time_scale
    match _state:
        State.SCAN: _process_scan(effective_delta)
        State.AIM: _process_aim(effective_delta)
        State.FIRE: _process_fire(effective_delta)
        State.SEARCH: _process_search(effective_delta)

func _process_scan(delta: float) -> void:
    rotation_degrees += scan_speed * delta
    # Ограничение угла
    if rotation_degrees > 180:
        rotation_degrees = -180
    _check_vision()
```

---

*Элитный снайпер — дальняя угроза. Требует обхода или быстрого stealth kill.*
