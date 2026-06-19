# 🤖 Boss: Prototype Helios-7 (Прототип Гелиос-7)

> **Зона:** 2 — Полярный Оазис (отдельная арена)  
> **Класс Godot:** `CharacterBody2D` (шагающий мех)  
> **Группа:** `"bosses"`, `"time_affected"`  
> **HP:** 3 фазы

## Визуал
- Шагающий мех, 4 ноги, массивный корпус.
- Жёлтые предупреждающие знаки радиационной опасности.
- Один большой красный глаз (целеуказатель).
- Ракетные пусковые установки на плечах.

## Фазы боя

### Фаза 1: "Патруль" (100%-66%)
- **Поведение:** Медленная ходьба по арене. Периодические остановки для сканирования.
- **Атака:** Лазерный луч из глаза (предупреждение 1 сек, затем выстрел).
- **Уязвимость:** Ноги. Кай стреляет снайперкой в суставы ног → мех падает на колени.
- **После падения:** Кай подходит и бьёт энергоножом в глаз (1 хит). 3 цикла.

### Фаза 2: "Оборона" (66%-33%)
- **Поведение:** Стоит на месте, активирует щит (полусфера вокруг).
- **Атака:** Ракетные залпы (4 ракеты, следуют за Каем 2 сек).
- **Уязвимость:** ЭМИ-граната отключает щит на 8 сек.
- **После отключения щита:** Кай стреляет в ракетные установки (снайперка). 3 попадания.

### Фаза 3: "Самоуничтожение" (33%-0%)
- **Поведение:** Щит сломан, мех бьётся в агонии. Движется хаотично, оставляет лужи масла (скользко).
- **Атака:** Безконтрольные выстрелы лазера, взрывы ног.
- **Уязвимость:** Кай должен добежать до ядра (открывается после взрыва ноги) и вставить ЭМИ-заряд.
- **Финал:** Кат-сцена взрыва, Кай убегает на рывках.

## Godot Specification

```gdscript
class_name BossHelios7 extends CharacterBody2D

enum Phase { PHASE_1, PHASE_2, PHASE_3, DEAD }
enum State { WALKING, SCANNING, LASER_AIM, LASER_FIRE, SHIELDED, MISSILE_VOLLEY, CORE_EXPOSED, EXPLODING }

@export var walk_speed: float = 40.0
@export var laser_aim_time: float = 1.0
@export var shield_duration: float = 8.0
@export var missile_count: int = 4

@onready var legs: Array[CollisionShape2D] = [$Leg1, $Leg2, $Leg3, $Leg4]
@onready var eye: Sprite2D = $Eye
@onready var shield_area: Area2D = $ShieldArea
@onready var missile_launchers: Array[Marker2D] = [$Launcher1, $Launcher2]
@onready var core_area: Area2D = $CoreArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _phase: Phase = Phase.PHASE_1
var _state: State = State.WALKING
var _legs_disabled: int = 0
var _missile_hits: int = 0
var _is_shield_active: bool = false

func _ready() -> void:
    add_to_group("bosses")
    add_to_group("time_affected")
    _start_phase_1()

func _start_phase_1() -> void:
    _phase = Phase.PHASE_1
    _start_walking_loop()

func _start_walking_loop() -> void:
    while _phase == Phase.PHASE_1:
        _state = State.WALKING
        # Движение к случайной точке
        await get_tree().create_timer(3.0).timeout
        _state = State.SCANNING
        await get_tree().create_timer(2.0).timeout
        _start_laser_attack()

func _start_laser_attack() -> void:
    _state = State.LASER_AIM
    # Лазерная точка следует за Каем 1 сек
    await get_tree().create_timer(laser_aim_time).timeout
    _state = State.LASER_FIRE
    # Выстрел
    # Проверка попадания
    await get_tree().create_timer(0.5).timeout

func _on_leg_shot(leg_index: int) -> void:
    legs[leg_index].disabled = true
    _legs_disabled += 1
    if _legs_disabled >= 2:
        _fall_to_knees()

func _fall_to_knees() -> void:
    animation_player.play("fall_knees")
    # Уязвимость: глаз
    await animation_player.animation_finished
    _legs_disabled = 0
    for leg in legs:
        leg.disabled = false

func _on_eye_stabbed() -> void:
    # Кай ударил ножом в глаз
    take_phase_damage()

func take_phase_damage() -> void:
    match _phase:
        Phase.PHASE_1: _start_phase_2()
        Phase.PHASE_2: _start_phase_3()
        Phase.PHASE_3: _die()

func _start_phase_2() -> void:
    _phase = Phase.PHASE_2
    _state = State.SHIELDED
    _activate_shield()

func _activate_shield() -> void:
    _is_shield_active = true
    shield_area.monitoring = true
    # Визуал: полусфера
    await get_tree().create_timer(shield_duration).timeout
    _is_shield_active = false
    shield_area.monitoring = false

func _on_emp_hit() -> void:
    if _is_shield_active:
        _is_shield_active = false
        shield_area.monitoring = false
        # Щит отключён

func _start_phase_3() -> void:
    _phase = Phase.PHASE_3
    _state = State.CORE_EXPOSED
    core_area.monitoring = true
    # Ядро открыто

func _on_core_emp_inserted() -> void:
    _die()

func _die() -> void:
    _phase = Phase.DEAD
    animation_player.play("self_destruct")
    GameManager.start_cutscene("helios_death")
```

## Арена

- **Размер:** 800×400 (2.5 экрана шириной).
- **Элементы:**
  - Укрытия: металлические баррикады (от лазера).
  - Лазерные сетки (отключаются ЭМИ).
  - Высокие платформы (от ракет).
- **Чекпоинт:** Перед ареной.

---

*Гелиос-7 — второй босс. Обучает: снайперка по частям, ЭМИ, укрытия.*
