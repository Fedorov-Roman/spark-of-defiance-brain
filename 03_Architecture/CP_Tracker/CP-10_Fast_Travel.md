# CP-10: Fast Travel (Vspyshka)
## Goal
Landing pads, map screen, auto cutscene, save on travel.
## Checklist
- [ ] Landing pad: interact → open map
- [ ] Map: discovered pads only, select → confirm
- [ ] Cutscene: 3s Vspyshka sprite across starfield
- [ ] Autosave before and after travel
- [ ] Player state preserved
## Files
- `entities/interactables/landing_pad.gd`
- `ui/map/map_screen.gd`
- `scenes/cutscenes/vspyshka_flight.tscn`
## Class: LandingPad
```gdscript
class_name LandingPad extends Area2D
@export var pad_id: String = ""
@export var target_zone: String = ""
func _ready() -> void:
    body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node2D) -> void:
    if body is Player: ProgressionManager.discover_pad(pad_id)
func interact() -> void: UIManager.open_map()
```
## Rules
1. Pads discovered by proximity (Area2D), not interaction.
2. Hub pad always active.
3. Travel only if Kess rescued (except Hub ↔ Zone 1 story forced).
## Pitfalls
- `change_scene_to_file` is async; use `await` or callback.
- Don't free player before saving state.
