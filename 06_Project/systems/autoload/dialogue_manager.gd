class_name DialogueManager extends Node
signal dialogue_started(text: String, portrait: String)
signal dialogue_finished
var is_active: bool = false
func show_dialogue(text: String, portrait: String = "") -> void: is_active = true; emit_signal("dialogue_started", text, portrait)
func advance() -> void: emit_signal("dialogue_finished"); is_active = false
