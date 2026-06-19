class_name GameState extends Node
var current_zone: String = "hub"
var session_time: float = 0.0
var is_paused: bool = false
func change_zone(path: String, spawn_id: String = "") -> void: LevelManager.transition_to(path, spawn_id)
func _process(delta: float) -> void: if not is_paused: session_time += delta
