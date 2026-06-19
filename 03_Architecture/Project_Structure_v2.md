# Project Structure v2

See [[Godot_Architecture_v2]] for full tree.

Key principles:
- **Modular folders:** `entities/`, `systems/`, `scenes/`, `assets/` — no flat dumping.
- **Component pattern:** `HealthComponent`, `HitboxComponent`, `VisionCone` as reusable scenes.
- **Resource-based config:** Enemy stats, weapon data, dialogue lines stored in `.tres` or `.json` under `resources/`.
- **Naming:** snake_case for files, PascalCase for classes, UPPER_CASE for constants.
- **Git:** `.gitignore` excludes `.godot/`, `*.tmp`, `export_presets.cfg`, `user://`.

---

## Связанные разделы

- [[MOC_03_Architecture]]
- [[Godot_Architecture_v2]]
- [[MOC_06_Project]]
