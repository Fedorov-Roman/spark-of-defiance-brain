# 🤖 Boss: Helios-7 Prototype (Прототип Гелиос-7)

> **Класс Godot:** `CharacterBody2D`  
> **Зона:** Зона 2 — Полярный Оазис (отдельная арена)  
> **Группа:** `"bosses"`, `"time_affected"`  

## Визуал
- Шагающий мех, 3 этажа высотой.
- Солнечная символика SUN, холодный металл, оранжевые акценты.
- Лазерные глаза, ракетные пусковые установки.

## Фазы боя

### Phase 1: Патруль (100-70% HP)
- Мех ходит по арене, топает (шоковые волны, отбрасывают Кая).
- Лазерные лучи из глаз (предупреждение — красная линия 1 сек).
- **Уязвимость:** Ноги (снайперка парализует ногу на 5 сек → мех падает на колено).

### Phase 2: Обрушение (70-30% HP)
- Мех стреляет ракетами (3 штуки, Area2D взрыв).
- Кай должен заманить ракеты под мост (перекат/рывок).
- Ракеты разрушают мост → мех падает в пропасть (но цепляется).
- **Уязвимость:** Ядро на груди (открыто при падении).

### Phase 3: Адреналин (30-0% HP)
- Мех отбрасывает оружие, бьёт кулаками (быстрые удары, Area2D).
- Кай должен использовать Кинжал Времени для уклонения.
- После 3 уклонений — мех устаёт (5 сек уязвимости).
- Финальный удар — ножом в ядро.

## Godot Specification

```gdscript
class_name Helios7 extends CharacterBody2D

enum Phase { PATROL, COLLAPSE, ADRENALINE }
enum State { WALKING, LASER, MISSILE, FALLEN, PUNCHING, TIRED, DEAD }

@export var walk_speed: float = 40.0
@export var laser_damage: int = 1
@export var missile_count: int = 3
@export var punch_damage: int = 2
@export var leg_paralyze_time: float = 5.0

@onready var legs: Array[Area2D] = []  # 2 ноги
@onready var core: Area2D = $Core
@onready var laser_ray: RayCast2D = $LaserRay
@onready var missile_spawn: Marker2D = $MissileSpawn

var _health: float = 100.0
var _phase: Phase = Phase.PATROL
var _state: State = State.WALKING
var _is_leg_paralyzed: bool = false

func _ready() -> void:
    add_to_group("bosses")
    add_to_group("time_affected")
    for leg in $Legs.get_children():
        if leg is Area2D:
            legs.append(leg)
            leg.body_entered.connect(_on_leg_hit)

func _on_leg_hit(body: Node2D) -> void:
    if body.is_in_group("player") and body.has_method("shoot_sniper"):
        _paralyze_leg()

func _paralyze_leg() -> void:
    _is_leg_paralyzed = true
    # Анимация падения на колено
    _state = State.FALLEN
    await get_tree().create_timer(leg_paralyze_time).timeout
    _is_leg_paralyzed = false
    _state = State.WALKING
```

## Подводные камни
- **Размер:** Мех занимает много места. Arena должна быть 3-4 экрана в ширину.
- **Лазер:** `RayCast2D` с предупреждением (таймер 1 сек, красная линия → оранжевая → выстрел).
- **Ракеты:** `RigidBody2D` или `CharacterBody2D` с гомингом на Кая. Кай должен увернуться, чтобы ракета попала в мост.
- **Мост:** `StaticBody2D` с `health`. При попадании ракеты — `queue_free()`.

---

*Гелиос-7 — второй босс. Проверка снайперки и тактики окружения.*
