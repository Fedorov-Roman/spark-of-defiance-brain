class_name SaveManager extends Node

const SAVE_PATH: String = "user://save.json"
const SAVE_VERSION: String = "1.0"

signal save_completed
signal load_completed

var current_save: Dictionary = {}

func _ready() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        current_save = _create_new_save()
    else:
        load_game()

func _create_new_save() -> Dictionary:
    return {
        "version": SAVE_VERSION,
        "timestamp": Time.get_datetime_string_from_system(),
        "player": {
            "hp": 3,
            "max_hp": 3,
            "ammo": 3,
            "max_ammo": 5,
            "position": {"x": 0.0, "y": 0.0},
            "zone": "hub",
            "checkpoint": "hub_spawn"
        },
        "progression": {
            "npcs_rescued": [],
            "abilities": [],
            "data_drives": 0
        },
        "world": {
            "doors_open": [],
            "chests_open": [],
            "bosses_defeated": [],
            "zones_unlocked": ["hub"],
            "landing_pads_found": ["hub_pad"]
        },
        "settings": {
            "fullscreen": false,
            "music_volume": 0.8,
            "sfx_volume": 1.0,
            "text_speed": 1.0
        }
    }

func save_game() -> void:
    var save_data := current_save.duplicate(true)
    save_data["timestamp"] = Time.get_datetime_string_from_system()

    # Serialize player state
    if GameState.player:
        save_data["player"] = GameState.player.serialize()

    # Serialize progression
    if ProgressionManager:
        save_data["progression"] = {
            "npcs_rescued": ProgressionManager.npcs_rescued,
            "abilities": ProgressionManager.unlocked_abilities,
            "data_drives": ProgressionManager.data_drives_collected
        }

    # Serialize world state
    save_data["world"] = _get_zones()

    var json := JSON.stringify(save_data, "\t")
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(json)
        file.close()
        save_completed.emit()
        print("Game saved to ", SAVE_PATH)
    else:
        push_error("Failed to save game!")

func load_game() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        current_save = _create_new_save()
        return

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if not file:
        push_error("Failed to open save file!")
        return

    var json := file.get_as_text()
    file.close()

    var parsed := JSON.parse_string(json)
    if parsed is Dictionary:
        current_save = parsed
        # Version check
        if current_save.get("version", "") != SAVE_VERSION:
            print("Save version mismatch, migrating...")
            current_save = _migrate_save(current_save)
        load_completed.emit()
        print("Game loaded from ", SAVE_PATH)
    else:
        push_error("Corrupted save file!")
        current_save = _create_new_save()

func _migrate_save(old_save: Dictionary) -> Dictionary:
    var new_save := _create_new_save()
    # Copy valid data
    if old_save.has("player"):
        new_save["player"] = old_save["player"]
    if old_save.has("progression"):
        new_save["progression"] = old_save["progression"]
    if old_save.has("world"):
        new_save["world"] = old_save["world"]
    if old_save.has("settings"):
        new_save["settings"] = old_save["settings"]
    return new_save

func _get_zones() -> Dictionary:
    var world := current_save.get("world", {})
    return world

func _set_zones(zone_data: Dictionary) -> void:
    current_save["world"] = zone_data

func autosave() -> void:
    save_game()

func delete_save() -> void:
    if FileAccess.file_exists(SAVE_PATH):
        DirAccess.remove_absolute(SAVE_PATH)
    current_save = _create_new_save()
