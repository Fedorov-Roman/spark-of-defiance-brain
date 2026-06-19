class_name DialogueManager extends Node
signal dialogue_started(text: String, portrait: String)
signal dialogue_finished
var is_active: bool = false
func show_dialogue(text: String, portrait: String = "") -> void: is_active = true; dialogue_started.emit(text, portrait)
func advance() -> void: dialogue_finished.emit(); is_active = false
