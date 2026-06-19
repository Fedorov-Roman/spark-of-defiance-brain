# CP-8: NPC & Hub
## Goal
Dynamic hub, 6 NPCs, rescue flags, Uno shop, Data Drive currency.
## Checklist
- [ ] Hub scene: one scene, NPCs visible by `ProgressionManager` flags
- [ ] 6 NPC stations: Uno, Liara, Jaan, Elia, Kess, Finch
- [ ] Uno shop: spend Data Drives for EMP/Smoke/Batteries
- [ ] Rescue triggers ability unlock + hub visual change
- [ ] Vspyshka terminal for fast travel
## Files
- `scenes/hub/hub.tscn`
- `entities/npc/npc_master.gd`
- `entities/npc/uno.gd`
- `ui/shop/shop_menu.gd`
## Class: NPCMaster
```gdscript
class_name NPCMaster extends StaticBody2D
@export var npc_id: String = ""
@export var unlocks_ability: String = ""
func _ready() -> void:
    visible = ProgressionManager.rescued_npcs.get(npc_id, false)
    if visible: _activate_station()
func rescue() -> void:
    ProgressionManager.rescue_npc(npc_id)
    if unlocks_ability: ProgressionManager.unlock_ability(unlocks_ability)
    visible = true; _activate_station()
func _activate_station() -> void: pass # visual upgrade
```
## Rules
1. NPCs static (no animation) to save budget.
2. Shop prices in Data Drives (free after rescue, but modules cost drives).
3. Hub state saved in JSON.
## Pitfalls
- Don't instance separate hub scenes per state; use visibility.
