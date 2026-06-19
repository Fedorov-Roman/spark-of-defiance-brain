class_name TimeManager extends Node

## Кастомное замедление (Answers Bible: гибрид, мир 30%, Кай 100%)
const TIME_SCALE_WORLD: float = 0.3
const TIME_SCALE_PLAYER: float = 1.0

var is_time_slowed: bool = false
var slow_duration: float = 2.5
var energy_cost: int = 40

## Сигналы
signal time_slow_started
signal time_slow_ended

func _ready() -> void:
    # TODO Builder: создать ColorRect с CanvasItem material (shader). Шейдер: mix(original_color, vec3(0.0, 0.3, 0.8), 0.4) + лёгкое искажение UV
    pass

func activate() -> bool:
    # TODO Builder: if energy >= 40: energy -= 40, emit time_slow_started, create_tween для ColorRect (fade in 0.2с). Запустить Timer на 2.5с. При timeout: emit time_slow_ended, fade out
    return false

func _apply_time_scale(scale: float) -> void:
    # TODO Builder: НЕ использовать Engine.time_scale. Вместо этого: в _physics_process каждой ноды группы умножать delta на 0.3. Для CharacterBody2D: velocity *= 0.3 перед move_and_slide()
    pass
