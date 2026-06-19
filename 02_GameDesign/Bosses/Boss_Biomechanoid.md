# 🧬 Boss: Experimental Biomechanoid (Экспериментальный биомеханоид)

> **Зона:** 3 — Глубинные Лаборатории (отдельная арена)  
> **Класс Godot:** `CharacterBody2D`  
> **Группа:** `"bosses"`, `"time_affected"`  
> **HP:** 3 фазы (НЕУЯЗВИМ без Кинжала Времени)

## Визуал
- Человеческий силуэт, но с металлическими вставками, проводами, светящимися жилами.
- Лицо — половина человека, половина машины (красный глаз-сканер).
- Движения: рывковые, неестественные, как у марионетки.
- Тень множится (послеimages).

## Уникальная механика: "Вне времени"

- **Без Кинжала Времени:** Биомеханоид неуязвим. Атаки проходят сквозь него. Он движется слишком быстро для обычного восприятия.
- **С Кинжалом:** Замедляется до нормальной скорости. Кай может уклоняться и контратаковать.
- **"Эхо" (от Элии):** Невидимость после рывка позволяет подойти со спины для критического удара.

## Фазы боя

### Фаза 1: "Испытание" (100%-66%)
- **Поведение:** Телепортируется (3 точки в арене), бросает энергетические сферы.
- **Атака:** Сферы замедляют Кая (дотрагиваются — скорость -50% на 3 сек).
- **Уязвимость:** Кай активирует Кинжал Времени → биомеханоид замедляется → Кай стреляет снайперкой в красный глаз. 3 попадания.

### Фаза 2: "Клоны" (66%-33%)
- **Поведение:** Создаёт 2 клона (полупрозрачные, меньше HP).
- **Атака:** Клоны атакуют синхронно, настоящий — из засады.
- **Как найти настоящего:** Кинжал Времени — клоны НЕ замедляются (только настоящий в группе "time_affected"). Или "Эхо" — невидимость, настоящий реагирует на присутствие (поворачивается).
- **Уязвимость:** Удар ножом в спину настоящего (критический, 1 хит фазы).

### Фаза 3: "Абсорбция" (33%-0%)
- **Поведение:** Поглощает лабораторное оборудование (станки, трубы), становится больше.
- **Атака:** Удары трубами, электрические разряды (Area2D).
- **Уязвимость:** Гравитационные аномалии арены (меняют направление гравитации). Кай использует аномалию, чтобы бросить обломок на биомеханоида.
- **Финал:** Кай прыгает с потолка (гравитация перевернута) и вонзает нож в ядро.

## Godot Specification

```gdscript
class_name BossBiomechanoid extends CharacterBody2D

enum Phase { PHASE_1, PHASE_2, PHASE_3, DEAD }
enum State { TELEPORT, ATTACK, VULNERABLE, ABSORB, RAGE }

@export var teleport_points: Array[Marker2D] = []
@export var clone_scene: PackedScene
@export var is_time_vulnerable: bool = true  # Только настоящий

@onready var red_eye: Area2D = $RedEye
@onready var clone_spawn_points: Array[Marker2D] = []
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gravity_anomaly_areas: Array[Area2D] = []

var _phase: Phase = Phase.PHASE_1
var _state: State = State.TELEPORT
var _eye_hits: int = 0
var _clones: Array[Node2D] = []
var _is_real: bool = true  # Для клонов = false

func _ready() -> void:
    add_to_group("bosses")
    if _is_real:
        add_to_group("time_affected")
    _start_phase_1()

func _start_phase_1() -> void:
    _phase = Phase.PHASE_1
    _teleport_loop()

func _teleport_loop() -> void:
    while _phase == Phase.PHASE_1:
        _state = State.TELEPORT
        var point := teleport_points[randi() % teleport_points.size()]
        global_position = point.global_position
        animation_player.play("teleport_in")
        await animation_player.animation_finished
        _state = State.ATTACK
        _throw_energy_spheres()
        await get_tree().create_timer(3.0).timeout

func _throw_energy_spheres() -> void:
    # Создание 3 сфер, летящих к Каю
    for i in range(3):
        var sphere := preload("res://scenes/entities/bosses/energy_sphere.tscn").instantiate()
        sphere.global_position = global_position
        get_parent().add_child(sphere)
        sphere.target = $"/root/GameManager/Player"

func _on_eye_shot() -> void:
    if not TimeManager.is_slowed:
        return  # Неуязвим без Кинжала
    _eye_hits += 1
    if _eye_hits >= 3:
        _start_phase_2()

func _start_phase_2() -> void:
    _phase = Phase.PHASE_2
    _spawn_clones()

func _spawn_clones() -> void:
    for i in range(2):
        var clone := clone_scene.instantiate()
        clone._is_real = false
        clone.global_position = clone_spawn_points[i].global_position
        get_parent().add_child(clone)
        _clones.append(clone)

func _on_backstabbed() -> void:
    if not _is_real:
        return  # Клон неуязвим к backstab
    # Проверка: Кай в невидимости (Эхо) или биомеханоид замедлен
    if not TimeManager.is_slowed and not Player.is_echo_active:
        return
    take_phase_damage()

func take_phase_damage() -> void:
    match _phase:
        Phase.PHASE_1: _start_phase_2()
        Phase.PHASE_2: _start_phase_3()
        Phase.PHASE_3: _die()

func _start_phase_3() -> void:
    _phase = Phase.PHASE_3
    _state = State.ABSORB
    animation_player.play("absorb_equipment")
    scale *= 1.5
    await animation_player.animation_finished
    _state = State.RAGE

func _on_gravity_anomaly_triggered(anomaly: Area2D) -> void:
    if _phase != Phase.PHASE_3:
        return
    # Кай бросает обломок
    # Проверка попадания
    take_phase_damage()

func _die() -> void:
    _phase = Phase.DEAD
    animation_player.play("death")
    GameManager.start_cutscene("biomechanoid_death")
```

## Арена

- **Размер:** 640×480 (2 экрана шириной, 2 высотой).
- **Особенность:** Гравитационные аномалии (4 зоны).
  - Вход в зону → гравитация меняет направление (вверх/вниз/влево/вправо).
  - Кай адаптируется (анимация), враги тоже.
- **Укрытия:** Лабораторные столы, капсулы (от сфер).
- **Чекпоинт:** Перед ареной.

---

*Биомеханоид — финальный босс. Проверка всех механик: Кинжал, Эхо, гравитация, стелс.*
