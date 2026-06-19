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
    ProgressionManager.deserialize(d.get("progression", {}))
    _set_player(d.get("player", {})); _set_zones(d.get("zones", {}))
    return true
func _get_player() -> Dictionary: var p := get_tree().get_first_node_in_group("player"); return p.serialize() if p else {}
func _set_player(d: Dictionary) -> void: var p := get_tree().get_first_node_in_group("player"); if p: p.deserialize(d)
func _get_zones() -> Dictionary: return {}
func _set_zones(d: Dictionary) -> void: pass
