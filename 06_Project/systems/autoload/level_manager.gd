class_name LevelManager extends Node

const HUB_PATH: String = "res://scenes/hub.tscn"
const ZONE_PATHS: Dictionary = {
    "zone_1": "res://scenes/zone_1.tscn",
    "zone_2": "res://scenes/zone_2.tscn",
    "zone_3": "res://scenes/zone_3.tscn"
}

signal zone_loaded(zone_name: String)

func change_zone(zone_name: String) -> void:
    # TODO Builder: 1) SaveManager.save_game(), 2) UIManager.show_loading_screen(lore_text), 3) await get_tree().create_timer(1.5).timeout, 4) get_tree().change_scene_to_file(path)
    pass

func change_to_hub() -> void:
    change_zone("hub")
