# CP-3: Time Dagger
## Goal
Hybrid time dilation. World 30%, Kai 100%. Blue shader. Energy.
## Checklist
- [ ] TimeManager: activate (cost 40, duration 2.5s), recharge 5/s
- [ ] Group "time_affected": enemies/traps/projectiles use `effective_delta = delta * 0.3`
- [ ] Full-screen `ColorRect` + shader: blue tint + chromatic aberration
- [ ] Kai afterimages: 3 ghosts, fade via `Tween`
- [ ] Energy bar in HUD updates
## Files
- `systems/autoload/time_manager.gd` (modify)
- `resources/shaders/time_dagger.gdshader`
- `ui/hud/energy_bar.gd`
- `entities/player/afterimage.gd`
## Class: TimeManager
```gdscript
class_name TimeManager extends Node
signal started(duration: float); signal ended
var is_active: bool = false
var energy: float = 100.0
const MAX_ENERGY: float = 100.0; const COST: float = 40.0; const DURATION: float = 2.5; const RECHARGE: float = 5.0
func _process(delta: float) -> void:
    if not is_active and energy < MAX_ENERGY: energy = min(MAX_ENERGY, energy + RECHARGE * delta)
func activate() -> void:
    if is_active or energy < COST: return
    is_active = true; energy -= COST; emit_signal("started", DURATION)
    get_tree().create_timer(DURATION).timeout.connect(_end)
func _end() -> void: is_active = false; emit_signal("ended")
func get_delta(d: float) -> float: return d * 0.3 if is_active else d
```
## Rules
1. NO `Engine.time_scale`.
2. Only nodes in group `"time_affected"` slow down.
3. Afterimages: duplicate sprite, tween alpha 0.5→0 over 0.3s, queue_free.
## Pitfalls
- `Tween` via `create_tween()`, not `new Tween`.
- Shader on `CanvasLayer` `ColorRect`, not `WorldEnvironment`.
