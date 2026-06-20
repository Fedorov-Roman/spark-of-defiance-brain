extends Node

signal dialogue_started(text: String, portrait: String)
signal dialogue_finished

var is_active: bool = false

func _ready() -> void:
	pass

func show_dialogue(text: String, portrait: String = "") -> void:
	pass

func advance() -> void:
	pass
