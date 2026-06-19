# 👮 Enemy: Guard SUN (Страж)

> **Класс Godot:** `CharacterBody2D`  
> **Группа:** `"enemies"`, `"guards"`, `"time_affected"`  
> **HP:** 1 (stealth kill) / паралич  

## Визуал
- Броня Solar Wardens (белая/хромированная, характерные каски).
- Безжалостный, дисциплинированный.

## AI Behavior

### State: PATROL
- Движение по маршруту (наземный, по точкам).
- Скорость: 50 px/sec.
- Конус зрения: 60° угол, 100 px дальность.
- Более узкий конус, чем у дрона, но дольше ALERT.

### State: ALERT
- Бег к последней известной позиции Кая.
- Если не нашёл за 30 сек → SEARCH.
- Если увидел труп союзника → мгновенный ALERT.

### State: ATTACK
- Если Кай в лобовой атаке (не stealth).
- Удар ближний (1 урон Каю, отбрасывание).
- Тревога.

## Особенности
- **Наземный:** Не летает, не перепрыгивает пропасти.
- **Слышит шум:** Реагирует на шум в радиусе 80 px.
- **Видит трупы:** Мгновенный ALERT при виде мёртвого врага.

## Godot Specification

```gdscript
class_name GuardSUN extends CharacterBody2D

enum State { PATROL, ALERT, SEARCH, ATTACK }

@export var patrol_speed: float = 50.0
@export var alert_speed: float = 80.0
@export var vision_angle: float = 60.0
@export var vision_distance: float = 100.0
@export var hearing_radius: float = 80.0

func _ready() -> void:
    add_to_group("enemies")
    add_to_group("guards")
    add_to_group("time_affected")
```

---

*Страж — наземная угроза. Требует стелса или паралича снайперкой.*
