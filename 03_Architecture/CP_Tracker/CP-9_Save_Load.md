# CP-9: Save & Load
## Goal
JSON save, full world state, autosave, checkpoint, versioned.
## Checklist
- [ ] SaveManager: serialize Progression + Player + Zones to `user://save.json`
- [ ] Version field (1); mismatch → new game warning
- [ ] Autosave: checkpoint, NPC rescue, boss kill, zone exit
- [ ] Load: restore HP, ammo, position, flags, doors, items
- [ ] Death: respawn at last checkpoint
## Files
- `systems/autoload/save_manager.gd` (modify)
- `systems/autoload/progression_manager.gd` (modify)
- `entities/checkpoint/checkpoint.gd`
## Class: SaveManager
```gdscript
class_name SaveManager extends Node
const PATH: String = "user://save.json"; const VERSION: int = 1
func save_game() -> void:
    var d := {"version": VERSION, "timestamp": Time.get_unix_time_from_system(), "progression": ProgressionManager.serialize(), "player": _get_player(), "zones": _get_zones()}
    var f := FileAccess.open(PATH, FileAccess.WRITE)
    if f: f.store_string(JSON.stringify(d)); f.close()
func load_game() -> bool:
    if not FileAccess.file_exists(PATH): return false
    var f := FileAccess.open(PATH, FileAccess.READ)
    if not f: return false
    var d := JSON.parse_string(f.get_as_string()); f.close()
    if d == null or d.get("version", 0) != VERSION: return false
    ProgressionManager.deserialize(d["progression"])
    _set_player(d.get("player", {})); _set_zones(d.get("zones", {}))
    return true
```
## Rules
1. JSON only, human-readable.
2. Zone state: visited, defeated enemies, open doors, collected items.
3. Enemies respawn on zone re-entry (per D15) → don't save live enemy state, only flags.
## Pitfalls
- `FileAccess` returns `null` if path invalid; always check.
- `JSON.parse_string` returns `null` on error; check before use.

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_03_Architecture]]
- [[Master_Plan_v2]]
- [[CP_Template]]
