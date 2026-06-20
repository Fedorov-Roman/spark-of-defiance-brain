extends Node

const SAVE_PATH: String = "user://save.json"
const SAVE_VERSION: String = "1.0"

signal save_completed
signal load_completed

var current_save: Dictionary = {}

func _ready() -> void:
	pass

func save_game() -> void:
	pass

func load_game() -> void:
	pass

func _create_new_save() -> Dictionary:
	return {
		"version": SAVE_VERSION,
		"timestamp": Time.get_datetime_string_from_system(),
		"player": {
			"hp": 3, "max_hp": 3,
			"ammo": 3, "max_ammo": 5,
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
