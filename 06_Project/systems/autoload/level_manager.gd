extends Node

signal zone_loaded(zone_name: String)
var loading: bool = false

func _ready() -> void:
	pass

func transition_to(path: String, spawn_id: String = "") -> void:
	pass
