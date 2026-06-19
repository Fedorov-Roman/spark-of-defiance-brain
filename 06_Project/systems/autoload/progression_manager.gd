class_name ProgressionManager extends Node
signal npc_rescued(id: String)
signal ability_unlocked(id: String)
var rescued_npcs: Dictionary = {}
var unlocked_abilities: Dictionary = {}
var data_drives: int = 0
var discovered_pads: Dictionary = {}
func rescue_npc(id: String) -> void:
    if not rescued_npcs.get(id, false): rescued_npcs[id] = true; emit_signal("npc_rescued", id)
func unlock_ability(id: String) -> void:
    if not unlocked_abilities.get(id, false): unlocked_abilities[id] = true; emit_signal("ability_unlocked", id)
func has_ability(id: String) -> bool: return unlocked_abilities.get(id, false)
func discover_pad(id: String) -> void: discovered_pads[id] = true
func serialize() -> Dictionary: return {"npcs": rescued_npcs.duplicate(), "abilities": unlocked_abilities.duplicate(), "drives": data_drives, "pads": discovered_pads.duplicate()}
func deserialize(d: Dictionary) -> void: rescued_npcs = d.get("npcs", {}).duplicate(); unlocked_abilities = d.get("abilities", {}).duplicate(); data_drives = d.get("drives", 0); discovered_pads = d.get("pads", {}).duplicate()
