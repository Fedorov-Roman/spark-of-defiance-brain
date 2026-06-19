# Component Pattern
```gdscript
class_name HealthComponent extends Node
signal changed(current: int, maximum: int)
signal died
@export var max_hp: int = 3
var current: int = 3
func damage(amount: int) -> void:
    current -= amount
    emit_signal("changed", current, max_hp)
    if current <= 0: emit_signal("died")
func heal(amount: int) -> void:
    current = min(max_hp, current + amount)
    emit_signal("changed", current, max_hp)
func serialize() -> Dictionary: return {"current": current, "max": max_hp}
func deserialize(d: Dictionary) -> void: current = d.get("current", max_hp); max_hp = d.get("max", 3)
```

---

## Связанные разделы

- [[MOC_03_Architecture]]
- [[Entities_Index]]
- [[Godot_Architecture_v2]]
