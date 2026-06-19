class_name SaveManager extends Node

const SAVE_PATH: String = "user://save.json"
const SAVE_VERSION: int = 1

func save_game() -> void:
    var data: Dictionary = {
        "version": SAVE_VERSION,
        "game_state": _serialize_game_state(),
        "progression": _serialize_progression(),
        "zone_states": _serialize_zones()
    }
    var json: String = JSON.stringify(data, "\t")
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(json)
        file.close()

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return false
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    var json: String = file.get_as_text()
    file.close()
    var data: Variant = JSON.parse_string(json)
    if data is Dictionary:
        _deserialize(data)
        return true
    return false

func _serialize_game_state() -> Dictionary:
    # TODO Builder: вернуть Dictionary с player_hp, player_ammo, player_energy, current_zone, checkpoint_position
    return {}

func _serialize_progression() -> Dictionary:
    # TODO Builder: вернуть Dictionary с rescued_* флагами и has_* способностями
    return {}

func _serialize_zones() -> Dictionary:
    # TODO Builder: для каждой зоны: открытые двери (Vector2i координаты), собранные предметы (ID), убитые враги (ID)
    return {}

func _deserialize(data: Dictionary) -> void:
    # TODO Builder: при load_game вызвать GameState.reset(), затем применить loaded data. Для зон: маркировать двери и предметы
    pass
