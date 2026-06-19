# 🐛 Boss: Sand Leviathan (Песчаный Левиафан)

> **Зона:** 1 — Красные Дюны (отдельная арена)  
> **Класс Godot:** `CharacterBody2D` (гигантский, не двигается по земле — вырывается из песка)  
> **Группа:** `"bosses"`, `"time_affected"`  
> **HP:** 3 фазы (по 3 хита каждая = 9 общих "попаданий")

## Визуал
- Колоссальный червь, длина 200+ пикселей.
- Сегментированное тело с металлическими вставками (броня).
- Множество светящихся синих глаз вдоль тела.
- Пасть с круглыми зубами, вращающимися как бур.

## Фазы боя

### Фаза 1: "Пробуждение" (100%-66% HP)
- **Поведение:** Периодически вырывается из песка в случайных точках арены (3 точки).
- **Атака:** Выпад вверх → попытка схватить Кая пастью.
- **Уязвимость:** Паровые клапаны на теле (3 штуки). Кай стреляет снайперкой → клапан лопается, пар выходит.
- **После 3 клапанов:** Переход в Фазу 2.

### Фаза 2: "Ярость" (66%-33% HP)
- **Поведение:** Движется под песком, создаёт волны (видны выпуклости).
- **Атака:** Быстрые выпады, хвост выбивает из песка (удар по площади).
- **Уязвимость:** Заманить в зыбучий песок (4 точки в арене). Кай активирует ловушку (кнопка) → червь проваливается, голова оказывается на поверхности.
- **Удар:** Кай прыгает и бьёт энергоножом в глаз (1 хит).
- **После 3 таких циклов:** Переход в Фазу 3.

### Фаза 3: "Агония" (33%-0% HP)
- **Поведение:** Полностью на поверхности, бьётся хвостом, создаёт пылевые волны.
- **Атака:** Круговые удары хвостом, песчаные смерчи (мешают видимости).
- **Уязвимость:** Кинжал Времени + рывок к пасти. Без замедления — слишком быстро.
- **Финальный удар:** Кай входит в пасть и стреляет снайперкой внутрь (кат-сцена).

## Godot Specification

```gdscript
class_name BossLeviathan extends CharacterBody2D

enum Phase { PHASE_1, PHASE_2, PHASE_3, DEAD }
enum State { BURROWED, EMERGING, ATTACKING, STUNNED, RAGING }

@export var emerge_points: Array[Marker2D] = []
@export var quicksand_points: Array[Marker2D] = []
@export var phase1_hp: int = 3
@export var phase2_hp: int = 3
@export var phase3_hp: int = 3

@onready var body_segments: Array[Sprite2D] = []
@onready var steam_valves: Array[Area2D] = []
@onready var head_hitbox: Area2D = $HeadHitbox
@onready var tail_hitbox: Area2D = $TailHitbox
@onready var state_timer: Timer = $StateTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _phase: Phase = Phase.PHASE_1
var _state: State = State.BURROWED
var _current_hp: int = 3
var _target_valves_destroyed: int = 0
var _quicksand_triggers: int = 0

func _ready() -> void:
    add_to_group("bosses")
    add_to_group("time_affected")
    _start_phase_1()

func _start_phase_1() -> void:
    _phase = Phase.PHASE_1
    _current_hp = phase1_hp
    # Анимация "плавания" под песком
    _start_burrowed_loop()

func _start_burrowed_loop() -> void:
    _state = State.BURROWED
    state_timer.wait_time = randf_range(3.0, 5.0)
    state_timer.start()
    await state_timer.timeout
    _emerge_at_random_point()

func _emerge_at_random_point() -> void:
    if emerge_points.is_empty(): return
    var point := emerge_points[randi() % emerge_points.size()]
    global_position = point.global_position
    _state = State.EMERGING
    animation_player.play("emerge")
    await animation_player.animation_finished
    _state = State.ATTACKING
    _perform_bite_attack()

func _perform_bite_attack() -> void:
    # Анимация выпада пастью
    animation_player.play("bite")
    # Проверка попадания по Каю через Area2D
    await animation_player.animation_finished
    _return_to_burrow()

func _on_valve_destroyed() -> void:
    _target_valves_destroyed += 1
    if _target_valves_destroyed >= 3:
        _start_phase_2()

func _start_phase_2() -> void:
    _phase = Phase.PHASE_2
    _current_hp = phase2_hp
    # Ускорение, больше волн
    _start_burrowed_loop_fast()

func _on_quicksand_triggered() -> void:
    _quicksand_triggers += 1
    if _quicksand_triggers >= 3:
        _start_phase_3()

func _start_phase_3() -> void:
    _phase = Phase.PHASE_3
    _current_hp = phase3_hp
    _state = State.RAGING
    animation_player.play("surface_permanently")
    # Включаем пылевые волны
    $DustWaveParticles.emitting = true

func take_damage(source: String) -> void:
    _current_hp -= 1
    if _current_hp <= 0:
        match _phase:
            Phase.PHASE_1: _start_phase_2()
            Phase.PHASE_2: _start_phase_3()
            Phase.PHASE_3: _die()

func _die() -> void:
    _phase = Phase.DEAD
    animation_player.play("death")
    # Кат-сцена
    GameManager.start_cutscene("leviathan_death")
```

## Арена

- **Размер:** 640×360 (2 экрана шириной, 1.5 экрана высотой).
- **Элементы:**
  - 3 точки появления (маркеры).
  - 4 зыбучих песчаных ловушки (активируются кнопками).
  - 3 паровых клапана на теле червя (Area2D, стрелять снайперкой).
  - Укрытия: каменные выступы (от хвоста).
- **Чекпоинт:** Перед входом в арену.

## Подводные камни
- Червь не должен застревать в стенах TileMap. `CollisionShape2D` головы — круг, а не прямоугольник.
- Пылевые волны в Фазе 3: `GPUParticles2D` с высокой плотностью, может влиять на FPS. Оптимизация: `amount = 50`, `lifetime = 2.0`.
- Камера: должна следовать за Каем, но не показывать за границы арены. `Camera2D.limit`.

---

*Левиафан — первый босс. Обучает механике: снайперка, ловушки, Кинжал Времени.*
