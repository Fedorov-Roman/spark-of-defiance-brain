# 🐉 Boss: Sand Leviathan (Песчаный Левиафан)

> **Класс Godot:** `CharacterBody2D` (кинематический, не физический)  
> **Зона:** Зона 1 — Красные Дюны (отдельная арена)  
> **Группа:** `"bosses"`, `"time_affected"`  

## Визуал
- Колоссальный песчаный червь, взрывающийся из дюн.
- Множество синих глаз вдоль тела.
- Бронированные металлические сегменты, пластины.
- Пылевая буря вокруг, масштаб — крошечная фигура Кая впереди.

## Фазы боя

### Phase 1: Погружение (0-33% HP)
- Червь движется под песком, видны волны.
- Выпады на поверхность (предупреждение — волны сгущаются).
- Кай должен уклоняться (dash, wall-jump).
- **Уязвимость:** Глаза на поверхности (снайперка парализует на 3 сек).

### Phase 2: Ослепление (33-66% HP)
- Червь выпускает облако песка (видимость 30%).
- **Механика окружения:** Паровые клапаны на арене. Стрельба по клапанам → пар ослепляет червя (останавливается на 5 сек).
- Кай бежит к клапанам, активирует, атакует глаза.

### Phase 3: Ярость (66-100% HP)
- Червь разрушает часть арены (падающие платформы).
- **Зыбучий песок:** Опасные зоны на полу (мгновенная смерть).
- Кай должен заманить червя в зыбучий песок (прыгнуть в сторону в последний момент).
- Червь застревает → 10 сек уязвимости (все глаза открыты).

## Godot Specification

```gdscript
class_name SandLeviathan extends CharacterBody2D

enum Phase { SUBMERGED, BLINDED, ENRAGED }
enum State { UNDERGROUND, EMERGING, ATTACKING, STUNNED, TRAPPED }

@export var underground_speed: float = 80.0
@export var emerge_warning_time: float = 1.5
@export var attack_damage: int = 3  # мгновенная смерть
@export var stun_duration: float = 5.0
@export var trap_duration: float = 10.0

@onready var phase: Phase = Phase.SUBMERGED
@onready var state: State = State.UNDERGROUND
@onready var emerge_timer: Timer = $EmergeTimer
@onready var stun_timer: Timer = $StunTimer
@onready var trap_timer: Timer = $TrapTimer
@onready var hitbox: Area2D = $Hitbox  # урон Каю
@onready var weak_points: Array[Area2D] = []  # глаза

var _health: int = 3  # 3 фазы
var _is_underground: bool = true

func _ready() -> void:
    add_to_group("bosses")
    add_to_group("time_affected")
    for child in $WeakPoints.get_children():
        if child is Area2D:
            weak_points.append(child)
            child.body_entered.connect(_on_weak_point_hit)

func _physics_process(delta: float) -> void:
    var effective_delta := delta * TimeManager.time_scale
    match state:
        State.UNDERGROUND: _process_underground(effective_delta)
        State.EMERGING: _process_emerging(effective_delta)
        State.ATTACKING: _process_attacking(effective_delta)
        State.STUNNED: _process_stunned(effective_delta)
        State.TRAPPED: _process_trapped(effective_delta)

func _process_underground(delta: float) -> void:
    # Движение к Каю под песком
    var player := get_tree().get_first_node_in_group("player") as Player
    if player:
        var dir := (player.global_position - global_position).normalized()
        velocity = dir * underground_speed
        move_and_slide()

    # Предупреждение — волны сгущаются
    if global_position.distance_to(player.global_position) < 100:
        _start_emerge()

func _start_emerge() -> void:
    state = State.EMERGING
    emerge_timer.start()
    # Анимация волн

func _on_emerge_timer_timeout() -> void:
    state = State.ATTACKING
    # Выпад на поверхность
    hitbox.monitoring = true

func _on_weak_point_hit(body: Node2D) -> void:
    if body.is_in_group("player"):
        if body.has_method("attack_weak_point"):
            body.attack_weak_point()
            _health -= 1
            if _health <= 0:
                _die()
            else:
                _transition_phase()

func _transition_phase() -> void:
    match phase:
        Phase.SUBMERGED:
            phase = Phase.BLINDED
            # Включаем паровые клапаны
        Phase.BLINDED:
            phase = Phase.ENRAGED
            # Активируем зыбучий песок

func _die() -> void:
    # Анимация смерти, падает в зыбучий песок
    queue_free()
    # Открываем выход из арены
```

## Подводные камни
- **Кинематический:** Червь не использует `move_and_slide()` для столкновений с Каем — используем `Area2D` для урона.
- **Предсказуемость:** Игрок должен видеть предупреждение (волны, тень) за 1.5 сек до выпада.
- **Фаза 3:** Зыбучий песок — `Area2D` с мгновенным уроном 3 (смерть). Кай должен стоять на безопасных платформах.
- **Time Dagger:** При замедлении — предупреждение длится дольше (визуально), но Кай может увернуться.

---

*Левиафан — первый босс. Проверка мастерства движения и стелса.*
