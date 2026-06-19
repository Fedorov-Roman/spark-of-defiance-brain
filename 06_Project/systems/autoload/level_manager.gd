class_name LevelManager extends Node
signal zone_loaded(zone_name: String)
var loading: bool = false
func transition_to(path: String, spawn_id: String = "") -> void:
    if loading: return
    loading = true; SaveManager.save_game()
    await get_tree().create_timer(0.5).timeout
    get_tree().change_scene_to_file(path); loading = false
    zone_loaded.emit(path)
