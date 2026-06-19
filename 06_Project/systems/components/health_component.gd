class_name HealthComponent extends Node
signal changed(current: int, maximum: int)
signal died
@export var max_hp: int = 3
var current: int = 3
func damage(a: int) -> void: current -= a; changed.emit(current, max_hp); if current <= 0: died.emit()
func heal(a: int) -> void: current = min(max_hp, current + a); changed.emit(current, max_hp)
func serialize() -> Dictionary: return {"current": current, "max": max_hp}
func deserialize(d: Dictionary) -> void: current = d.get("current", max_hp); max_hp = d.get("max", 3)
