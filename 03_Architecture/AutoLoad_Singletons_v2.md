# AutoLoad Singletons v2

## 1. GameState
```gdscript
extends Node
var current_zone: String = "hub"
var session_time: float = 0.0
var is_paused: bool = false
func change_zone(path: String, spawn_id: String) -> void:
    LevelManager.transition_to(path, spawn_id)
```

## 2. SaveManager
```gdscript
extends Node
const SAVE_PATH: String = "user://save.json"
func save_game() -> void:
    var data := {
        "progression": ProgressionManager.serialize(),
        "player": PlayerStats.serialize(),
        "zones": ZoneStates.serialize(),
        "timestamp": Time.get_unix_time_from_system()
    }
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    file.store_string(JSON.stringify(data))
func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH): return false
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    var data := JSON.parse_string(file.get_as_string())
    ProgressionManager.deserialize(data["progression"])
    PlayerStats.deserialize(data["player"])
    ZoneStates.deserialize(data["zones"])
    return true
```

## 3. ProgressionManager
```gdscript
extends Node
var rescued_npcs: Dictionary = {}  # npc_id: bool
var unlocked_abilities: Dictionary = {}  # ability_id: bool
var data_drives: int = 0
var hub_upgrades: Dictionary = {}
func rescue_npc(id: String) -> void:
    rescued_npcs[id] = true
    emit_signal("npc_rescued", id)
func has_ability(id: String) -> bool:
    return unlocked_abilities.get(id, false)
func serialize() -> Dictionary:
    return { "npcs": rescued_npcs, "abilities": unlocked_abilities, "drives": data_drives }
```

## 4. InputManager
```gdscript
extends Node
enum Device { GAMEPAD, KEYBOARD_MOUSE }
var active_device: Device = Device.GAMEPAD
func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and event.relative.length() > 0:
        active_device = Device.KEYBOARD_MOUSE
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
        active_device = Device.GAMEPAD
```

## 5. DialogueManager
```gdscript
extends Node
signal dialogue_started(text: String, portrait: String)
signal dialogue_finished()
var is_active: bool = false
func show_dialogue(text: String, portrait: String = "") -> void:
    is_active = true
    emit_signal("dialogue_started", text, portrait)
```

## 6. AudioManager
```gdscript
extends Node
enum MusicState { AMBIENT, TENSION, COMBAT, STEALTH, BOSS }
var current_state: MusicState = MusicState.AMBIENT
func set_music_state(state: MusicState) -> void:
    if current_state == state: return
    current_state = state
    # crossfade logic here
```

## 7. TimeManager
```gdscript
extends Node
signal time_dagger_started(duration: float)
signal time_dagger_ended()
var is_active: bool = false
var energy: float = 100.0
var effective_scale: float = 0.3
func activate() -> void:
    if energy < 40: return
    is_active = true
    energy -= 40
    emit_signal("time_dagger_started", 2.5)
    await get_tree().create_timer(2.5).timeout
    is_active = false
    emit_signal("time_dagger_ended")
func get_delta(base_delta: float) -> float:
    return base_delta * (effective_scale if is_active else 1.0)
```

## 8. UIManager
```gdscript
extends Node
@onready var hud: Control = preload("res://scenes/ui/hud.tscn").instantiate()
func show_hud() -> void: add_child(hud)
func update_health(current: int, max: int) -> void: hud.update_health(current, max)
```

## 9. LevelManager
```gdscript
extends Node
signal zone_loaded(zone_name: String)
func transition_to(path: String, spawn_id: String) -> void:
    SaveManager.save_game()
    # show loading screen
    await get_tree().create_timer(0.5).timeout
    get_tree().change_scene_to_file(path)
    # spawn player at spawn_id
    emit_signal("zone_loaded", path)
```
