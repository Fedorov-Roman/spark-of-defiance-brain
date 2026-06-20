extends Node

signal npc_rescued(id: String)
signal ability_unlocked(id: String)

var rescued_npcs: Dictionary = {}
var unlocked_abilities: Dictionary = {}
var data_drives: int = 0
var discovered_pads: Dictionary = {}

func _ready() -> void:
	pass

func rescue_npc(id: String) -> void:
	pass

func unlock_ability(id: String) -> void:
	pass

func has_ability(id: String) -> bool:
	return unlocked_abilities.get(id, false)

func discover_pad(id: String) -> void:
	pass

func serialize() -> Dictionary:
	return {}

func deserialize(d: Dictionary) -> void:
	pass
