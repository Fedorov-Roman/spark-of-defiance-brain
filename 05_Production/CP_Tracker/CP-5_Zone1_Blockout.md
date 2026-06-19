# CP-5: Zone 1 Blockout
## Goal
TileMap floor+walls, 3 sub-areas, placeholders, dust storm event.
## Checklist
- [ ] TileMap 32×32 with physics layers (world=layer1)
- [ ] 3 sub-areas: dunes, ruins, cave
- [ ] Dust storm: random 40-60s, visibility 50%, masks noise
- [ ] 2 landing pads (discoverable)
- [ ] 4 Data Drive locations (hidden)
- [ ] Grapple item pickup
## Files
- `scenes/zones/zone_1.tscn`
- `resources/tilesets/zone_1.tres`
- `systems/weather/dust_storm.gd`
## Class: DustStorm
```gdscript
class_name DustStorm extends Node2D
signal started; signal ended
var active: bool = false
func trigger() -> void:
    active = true; emit_signal("started")
    await get_tree().create_timer(randf_range(40.0, 60.0)).timeout
    active = false; emit_signal("ended")
    await get_tree().create_timer(randf_range(20.0, 40.0)).timeout
    trigger()
```
## Rules
1. TileMap uses `TileSet` with physics layers.
2. Storm affects both sides: enemy vision ×0.5, Kai noise radius ×0.5.
3. Use `CanvasModulate` + `ColorRect` for storm darkness.
## Pitfalls
- `TileMap` is deprecated in favor of `TileMapLayer` in 4.6; use `TileMap` for compatibility or `TileMapLayer` if preferred.

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_05_Production]]
- [[Master_Plan_v2]]
- [[CP_Template]]
