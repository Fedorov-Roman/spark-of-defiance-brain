class_name ProgressionManager extends Node

## Флаги спасённых NPC
var rescued_uno: bool = false
var rescued_liara: bool = false
var rescued_jaan: bool = false
var rescued_elia: bool = false
var rescued_kess: bool = false
var rescued_finch: bool = false

## Открытые способности
var has_double_dash: bool = false
var has_time_echo: bool = false
var has_grapple: bool = false
var has_fast_travel: bool = false
var has_minimap: bool = false

## Сигналы
signal ability_unlocked(ability_name: String)
signal npc_rescued(npc_name: String)

func rescue_npc(npc_name: String) -> void:
    # TODO Builder: установить rescued_* = true, emit npc_rescued(npc_name), вызвать SaveManager.save_game()
    pass

func unlock_ability(ability: String) -> void:
    # TODO Builder: проверить, что NPC спасён (например, has_double_dash требует rescued_jaan). emit ability_unlocked(ability)
    pass
