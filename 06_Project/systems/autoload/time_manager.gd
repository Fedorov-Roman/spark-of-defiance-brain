class_name TimeManager extends Node
signal started(duration: float)
signal ended
var is_active: bool = false
var energy: float = 100.0
const MAX_ENERGY: float = 100.0; const COST: float = 40.0; const DURATION: float = 2.5; const RECHARGE: float = 5.0
func _process(delta: float) -> void: if not is_active and energy < MAX_ENERGY: energy = min(MAX_ENERGY, energy + RECHARGE * delta)
func activate() -> void:
    if is_active or energy < COST: return
    is_active = true; energy -= COST; started.emit(DURATION)
    get_tree().create_timer(DURATION).timeout.connect(_end)
func _end() -> void: is_active = false; ended.emit()
func get_delta(d: float) -> float: return d * 0.3 if is_active else d
