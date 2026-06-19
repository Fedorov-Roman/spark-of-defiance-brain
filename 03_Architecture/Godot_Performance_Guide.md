# Performance Guide
- Use `@onready` never `get_node()` in `_process`.
- Vision cones: 12 segments, cull off-screen, update every 3rd frame.
- Use `Object.call_deferred("add_child", obj)` for spawns.
- Particles: `GPUParticles2D` max 200 particles per emitter.
- TileMap: use `TileMapLayer` in 4.6, not multiple TileMaps.
- Avoid `Engine.time_scale` — use custom delta group.
- Signals: disconnect in `_exit_tree` to prevent leaks.
- JSON: parse once, cache result. Don't parse in `_process`.

---

## Связанные разделы

- [[MOC_03_Architecture]]
- [[Godot_Architecture_v2]]
- [[MOC_06_Project]]
