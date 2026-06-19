# 🔌 AutoLoad Singletons Specification

## GameManager

```gdscript
class_name GameManager extends Node

signal scene_changed(scene_path: String)
signal game_paused(is_paused: bool)

var current_scene: String = ""
var is_paused: bool = false

func change_scene(path: String) -> void:
    # Сохранение перед сменой сцены
    SaveManager.save_current_state()
    get_tree().change_scene_to_file(path)
    current_scene = path
    scene_changed.emit(path)

func pause_game() -> void:
    is_paused = true
    get_tree().paused = true
    game_paused.emit(true)

func resume_game() -> void:
    is_paused = false
    get_tree().paused = false
    game_paused.emit(false)
```

## ProgressionManager

```gdscript
class_name ProgressionManager extends Node

signal npc_rescued(npc_id: String)
signal ability_unlocked(ability_id: String)
signal zone_unlocked(zone_id: String)

var rescued_npcs: Dictionary = {}      # { "uno": true, "liara": false, ... }
var unlocked_abilities: Dictionary = {}  # { "double_dash": false, ... }
var unlocked_zones: Dictionary = {}    # { "zone_1": true, "zone_2": false, ... }
var data_drives: int = 0

func rescue_npc(npc_id: String) -> void:
    rescued_npcs[npc_id] = true
    npc_rescued.emit(npc_id)
    # Автоматическое открытие способности
    match npc_id:
        "uno": unlock_ability("grappling_hook")
        "liara": unlock_ability("medkit_access")
        "jaan": unlock_ability("double_dash")
        "elia": unlock_ability("time_echo")
        "kess": unlock_ability("fast_travel")
        "finch": unlock_ability("world_map")

func unlock_ability(ability_id: String) -> void:
    unlocked_abilities[ability_id] = true
    ability_unlocked.emit(ability_id)

func has_ability(ability_id: String) -> bool:
    return unlocked_abilities.get(ability_id, false)
```

## SaveManager

```gdscript
class_name SaveManager extends Node

signal game_saved
signal game_loaded

const SAVE_PATH: String = "user://save.json"

func save_current_state() -> void:
    var data: Dictionary = {
        "progression": ProgressionManager.get_save_data(),
        "player": PlayerManager.get_save_data(),  # если есть
        "current_scene": GameManager.current_scene,
        "timestamp": Time.get_unix_time_from_system()
    }
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(data))
        file.close()
        game_saved.emit()

func load_game() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        return
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if file:
        var text := file.get_as_text()
        file.close()
        var data: Dictionary = JSON.parse_string(text)
        if data:
            ProgressionManager.load_save_data(data.get("progression", {}))
            # ... восстановление других систем
            game_loaded.emit()
```

## TimeManager

```gdscript
class_name TimeManager extends Node

signal time_slow_started
signal time_slow_ended
signal energy_changed(new_value: float)

var time_scale: float = 1.0
var is_slowed: bool = false
var energy: float = 100.0
const MAX_ENERGY: float = 100.0
const DRAIN_RATE: float = 33.33
const RECHARGE_RATE: float = 10.0  # в хабе

func activate_slow() -> void:
    if energy <= 0 or is_slowed: return
    is_slowed = true
    time_scale = 0.3
    time_slow_started.emit()

func deactivate_slow() -> void:
    if not is_slowed: return
    is_slowed = false
    time_scale = 1.0
    time_slow_ended.emit()

func _process(delta: float) -> void:
    if is_slowed:
        energy = max(0.0, energy - DRAIN_RATE * delta)
        if energy <= 0:
            deactivate_slow()
        energy_changed.emit(energy)
    else:
        # Перезарядка только в хабе (проверка через GameManager)
        if GameManager.current_scene == "hub":
            energy = min(MAX_ENERGY, energy + RECHARGE_RATE * delta)
            energy_changed.emit(energy)
```

## InputManager

```gdscript
class_name InputManager extends Node

signal input_rebound(action: String, event: InputEvent)

const ACTIONS: Array[String] = [
    "move_left", "move_right", "move_up", "move_down",
    "jump", "dash", "crouch", "roll", "attack", "aim", "fire",
    "hook", "interact", "gadget_1", "gadget_2", "gadget_3",
    "time_dagger", "map", "pause", "inventory"
]

func rebind_action(action: String, event: InputEvent) -> void:
    InputMap.action_erase_events(action)
    InputMap.action_add_event(action, event)
    input_rebound.emit(action, event)

func load_default_bindings() -> void:
    # Загрузка дефолтных биндингов из InputMap (настроены в Project Settings)
    pass
```

## AudioManager

```gdscript
class_name AudioManager extends Node

signal music_changed(track: String)

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
@onready var ambient_player: AudioStreamPlayer = $AmbientPlayer

var current_music: String = ""
var current_ambient: String = ""

func play_music(track: String, crossfade: float = 1.0) -> void:
    if current_music == track: return
    current_music = track
    # Tween для crossfade
    var tween := create_tween()
    tween.tween_property(music_player, "volume_db", -80.0, crossfade)
    tween.tween_callback(func():
        music_player.stream = load("res://assets/audio/music/" + track + ".ogg")
        music_player.play()
        music_player.volume_db = -80.0
        var tween2 := create_tween()
        tween2.tween_property(music_player, "volume_db", 0.0, crossfade)
    )
    music_changed.emit(track)

func play_sfx(sound: String) -> void:
    sfx_player.stream = load("res://assets/audio/sfx/" + sound + ".wav")
    sfx_player.play()

func play_ambient(zone: String) -> void:
    if current_ambient == zone: return
    current_ambient = zone
    ambient_player.stream = load("res://assets/audio/ambient/" + zone + ".ogg")
    ambient_player.play()
```

---

*Все Singletons — AutoLoad в Project Settings. Порядок инициализации критичен.*
