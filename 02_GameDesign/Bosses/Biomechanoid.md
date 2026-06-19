# 🧬 Boss: Experimental Biomechanoid (Экспериментальный биомеханоид)

> **Класс Godot:** `CharacterBody2D`  
> **Зона:** Зона 3 — Глубинные Лаборатории (отдельная арена)  
> **Группа:** `"bosses"`, `"time_affected"`  
> **Особенность:** Без замедления времени — неуязвим.

## Визуал
- Гибрид органики и машины. Полупрозрачная плоть, видны механические внутренности.
- Не имеет постоянной формы — меняет форму (руки-клинки, щит, щупальца).
- Светится красным, когда атакует; синим, когда уязвим.

## Фазы боя

### Phase 1: Адаптация (100-60% HP)
- Биомеханоид медленный, наблюдает за Каем.
- Копирует движения Кая (если Кай бежит — бежит, если прыгает — прыгает).
- **Уязвимость:** Только во время замедления времени (Кинжал Времени). Без него — все атаки проходят сквозь.
- Кай должен активировать Time Dagger, подойти, ударить ножом.

### Phase 2: Мимикрия (60-30% HP)
- Биомеханоид начинает использовать способности Кая:
  - Рывок (быстрый выпад).
  - Крюк-кошка (цепляется за стены, маятник).
  - «Эхо» — создаёт копию себя (иллюзия, не наносит урон, но отвлекает).
- **Уязвимость:** Настоящий биомеханоид отличается тенью (у копии нет тени). Кай должен найти настоящего и атаковать во время Time Dagger.

### Phase 3: Перегрузка (30-0% HP)
- Биомеханоид перегревается (красное свечение, пар).
- Атаки становятся хаотичными, быстрые.
- Лаборатория начинает разрушаться (падающие обломки, `RigidBody2D`).
- **Уязвимость:** После 5 атак подряд — останавливается на 3 сек (перегрузка). Кай атакует.
- Финал: Биомеханоид взрывается, открывается путь к реактору.

## Godot Specification

```gdscript
class_name Biomechanoid extends CharacterBody2D

enum Phase { ADAPTATION, MIMICRY, OVERLOAD }
enum State { OBSERVING, COPYING, ATTACKING, VULNERABLE, OVERHEATED }

@export var adaptation_speed: float = 60.0
@export var mimicry_speed: float = 120.0
@export var overload_speed: float = 180.0
@export var attack_damage: int = 2
@export var overload_attack_count: int = 5

@onready var shadow: Sprite2D = $Shadow  # у настоящего есть тень
@onready var clone_shadow: Sprite2D = $CloneShadow  # у копии нет
@onready var heat_particles: GPUParticles2D = $HeatParticles

var _health: float = 100.0
var _phase: Phase = Phase.ADAPTATION
var _state: State = State.OBSERVING
var _attack_count: int = 0
var _is_time_slow_active: bool = false

func _ready() -> void:
    add_to_group("bosses")
    add_to_group("time_affected")
    TimeManager.time_slow_started.connect(_on_time_slow_started)
    TimeManager.time_slow_ended.connect(_on_time_slow_ended)

func _on_time_slow_started() -> void:
    _is_time_slow_active = true
    if _phase == Phase.ADAPTATION:
        _state = State.VULNERABLE
        modulate = Color(0.3, 0.3, 1.0)  # синий = уязвим

func _on_time_slow_ended() -> void:
    _is_time_slow_active = false
    if _state == State.VULNERABLE:
        _state = State.OBSERVING
        modulate = Color(1.0, 1.0, 1.0)

func _physics_process(delta: float) -> void:
    var effective_delta := delta * TimeManager.time_scale
    match _state:
        State.OBSERVING: _process_observing(effective_delta)
        State.COPYING: _process_copying(effective_delta)
        State.ATTACKING: _process_attacking(effective_delta)
        State.VULNERABLE: _process_vulnerable(effective_delta)
        State.OVERHEATED: _process_overheated(effective_delta)

func _process_observing(delta: float) -> void:
    var player := get_tree().get_first_node_in_group("player") as Player
    if player:
        # Копируем движение с задержкой 0.5 сек
        pass  # Builder: реализовать копирование

func _process_attacking(delta: float) -> void:
    _attack_count += 1
    if _attack_count >= overload_attack_count and _phase == Phase.OVERLOAD:
        _state = State.OVERHEATED
        heat_particles.emitting = true
        await get_tree().create_timer(3.0).timeout
        _state = State.ATTACKING
        _attack_count = 0
        heat_particles.emitting = false
```

## Подводные камни
- **Неуязвимость без Time Dagger:** `Area2D` hitbox игрока должен проверять `TimeManager.is_slowed`. Если нет — атака не наносит урон, проигрывается звук "провала".
- **Копии:** Использовать `duplicate()` для создания копий. Копии — `CharacterBody2D` с упрощённым AI, без `shadow`.
- **Перегрузка:** Визуальный счётчик атак (3/5, 4/5, 5/5 → OVERHEATED).
- **Разрушение лаборатории:** `RigidBody2D` обломки с `gravity_scale` 0.5 (низкая гравитация аномалии).

---

*Биомеханоид — финальный босс. Проверка всех механик: Time Dagger, крюк, рывок, Эхо.*
