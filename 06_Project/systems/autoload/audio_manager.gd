extends Node

enum MusicState { EXPLORATION, SUSPICION, ALERT, BOSS, HUB }

var current_music_state: MusicState = MusicState.EXPLORATION

func _ready() -> void:
	pass

func set_music_state(state: MusicState) -> void:
	pass

func play_sfx(sfx_name: String) -> void:
	pass

func set_ambient(ambient_name: String) -> void:
	pass
