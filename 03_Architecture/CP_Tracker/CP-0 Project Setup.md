# ТЗ — CP-0: Project Setup

> **Цель:** Рабочий пустой проект Godot 4.6.3 с настроенным окружением, структурой папок, AutoLoad, InputMap и пиксель-перфект рендерингом.

---

## Критерий готовности (чеклист для Романа)

- [ ] Проект открывается в Godot 4.6.3 без ошибок
- [ ] Структура папок соответствует архитектуре (entities/, systems/, scenes/, assets/)
- [ ] Viewport настроен: 32×32 тайлы, pixel-perfect x2/x3, adaptive resolution
- [ ] InputMap содержит биндинги для геймпада и клавиатуры/мыши
- [ ] Все 9 AutoLoad зарегистрированы (пустые, но существуют)
- [ ] .gitignore настроен для Godot
- [ ] Загрузочный экран с лором (stub) открывается
- [ ] Тестовая сцена с placeholder-спрайтом Кая (красный квадрат 32×32) видна на экране

---

## Файлы и сцены

### Создать

#### `project.godot` (Project Settings)
- **Application → Run → Main Scene:** `scenes/ui/loading_screen.tscn`
- **Display → Window:**
  - Size: Viewport Width = 640, Height = 360 (базовое 32×20 тайлов)
  - Stretch Mode: `canvas_items`
  - Stretch Aspect: `expand`
  - Scale Mode: `integer` (pixel-perfect)
- **Rendering → 2D:**
  - Default Texture Filter: `Nearest` (pixel-art)
- **Layer Names → 2D Physics:**
  - Layer 1: `player`
  - Layer 2: `enemies`
  - Layer 3: `world`
  - Layer 4: `interactables`
  - Layer 5: `projectiles`
  - Layer 6: `vision`
  - Layer 7: `noise`
  - Layer 8: `hurtbox_player`
  - Layer 9: `hurtbox_enemy`
  - Layer 10: `light_occluder`
- **AutoLoad:**
  - `SettingsManager` → `scripts/core/settings_manager.gd`
  - `InputManager` → `scripts/core/input_manager.gd`
  - `AudioManager` → `scripts/core/audio_manager.gd`
  - `MusicManager` → `scripts/core/music_manager.gd`
  - `GameManager` → `scripts/core/game_manager.gd`
  - `ProgressionManager` → `scripts/core/progression_manager.gd`
  - `SaveManager` → `scripts/core/save_manager.gd`
  - `SceneManager` → `scripts/core/scene_manager.gd`
  - `DialogueManager` → `scripts/core/dialogue_manager.gd`

#### `scripts/core/settings_manager.gd`
```gdscript
extends Node

const SETTINGS_PATH: String = "user://settings.json"

var settings: Dictionary = {}

func _ready() -> void:
    _load_settings()

func _load_settings() -> void:
    if FileAccess.file_exists(SETTINGS_PATH):
        var file := FileAccess.open(SETTINGS_PATH, FileAccess.READ)
        var json_string := file.get_as_text()
        file.close()
        var parsed := JSON.parse_string(json_string)
        if parsed is Dictionary:
            settings = parsed
    else:
        _apply_default_settings()

func _apply_default_settings() -> void:
    settings = {
        "resolution": Vector2i(1920, 1080),
        "fullscreen": false,
        "vsync": true,
        "master_volume": 1.0,
        "music_volume": 0.8,
        "sfx_volume": 1.0,
        "text_speed": 0.03
    }

func save_settings() -> void:
    var file := FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
    var json_string := JSON.stringify(settings, "	", true)
    file.store_string(json_string)
    file.close()
```

#### `scripts/core/input_manager.gd`
```gdscript
extends Node

func _ready() -> void:
    _setup_default_input_map()

func _setup_default_input_map() -> void:
    # Movement
    _add_action("move_left", KEY_A, JOY_AXIS_LEFT_X, -1.0)
    _add_action("move_right", KEY_D, JOY_AXIS_LEFT_X, 1.0)
    _add_action("move_up", KEY_W, JOY_AXIS_LEFT_Y, -1.0)
    _add_action("move_down", KEY_S, JOY_AXIS_LEFT_Y, 1.0)

    # Actions
    _add_action("jump", KEY_SPACE, JOY_BUTTON_A)
    _add_action("dash", KEY_SHIFT, JOY_BUTTON_RIGHT_SHOULDER)
    _add_action("crouch", KEY_CTRL, JOY_BUTTON_LEFT_SHOULDER)
    _add_action("interact", KEY_E, JOY_BUTTON_X)
    _add_action("attack", KEY_F, JOY_BUTTON_B)
    _add_action("aim", MOUSE_BUTTON_RIGHT, JOY_AXIS_RIGHT_X)
    _add_action("shoot", MOUSE_BUTTON_LEFT, JOY_AXIS_TRIGGER_RIGHT)
    _add_action("gadget_1", KEY_1, JOY_BUTTON_Y)
    _add_action("map", KEY_M, JOY_BUTTON_BACK)
    _add_action("inventory", KEY_I, JOY_BUTTON_START)
    _add_action("pause", KEY_ESCAPE, JOY_BUTTON_GUIDE)
    _add_action("time_dagger", KEY_Q, JOY_AXIS_TRIGGER_LEFT)

func _add_action(action_name: String, keyboard_event, joypad_event = null, axis_value: float = 0.0) -> void:
    if not InputMap.has_action(action_name):
        InputMap.add_action(action_name)

    var key_event := InputEventKey.new()
    key_event.keycode = keyboard_event
    InputMap.action_add_event(action_name, key_event)

    if joypad_event is int:
        var joy_event := InputEventJoypadButton.new()
        joy_event.button_index = joypad_event
        InputMap.action_add_event(action_name, joy_event)
    elif joypad_event is int and axis_value != 0.0:
        var axis_event := InputEventJoypadMotion.new()
        axis_event.axis = joypad_event
        axis_event.axis_value = axis_value
        InputMap.action_add_event(action_name, axis_event)
```

#### `scripts/core/game_manager.gd`
```gdscript
extends Node

## Глобальное состояние игры (не сохраняется напрямую, синхронизируется с SaveManager)

var current_zone: String = "hub"
var player_health: int = 3
var player_max_health: int = 3
var player_ammo: int = 5
var player_max_ammo: int = 5
var current_gadget: int = 0  # 0 = none, 1 = grapple, 2 = emp, 3 = smoke
var data_drives: int = 0
var time_dagger_energy: float = 100.0
var time_dagger_max_energy: float = 100.0

func _ready() -> void:
    pass  # Builder: инициализация из SaveManager при load

func reset_to_defaults() -> void:
    player_health = 3
    player_ammo = 5
    time_dagger_energy = 100.0
    data_drives = 0
    current_zone = "hub"
```

#### `scripts/core/progression_manager.gd`
```gdscript
extends Node

## Флаги прогресса — источник правды для хаба и способностей

# NPC rescued
var rescued_uno: bool = false
var rescued_liara: bool = false
var rescued_jaan: bool = false
var rescued_elia: bool = false
var rescued_kess: bool = false
var rescued_finch: bool = false

# Abilities unlocked
var unlocked_grapple: bool = false
var unlocked_air_dash: bool = false
var unlocked_time_dagger: bool = false
var unlocked_time_echo: bool = false
var unlocked_fast_travel: bool = false
var unlocked_minimap: bool = false

# Hub decorations
var hub_decoration_count: int = 0

# Zone completion
var zone_1_completed: bool = false
var zone_2_completed: bool = false
var zone_3_completed: bool = false

func _ready() -> void:
    pass  # Builder: загрузка из SaveManager

func rescue_npc(npc_id: String) -> void:
    match npc_id:
        "uno": rescued_uno = true
        "liara": rescued_liara = true
        "jaan": rescued_jaan = true
        "elia": rescued_elia = true
        "kess": rescued_kess = true
        "finch": rescued_finch = true
    SaveManager.save_game()
```

#### `scripts/core/save_manager.gd`
```gdscript
extends Node

const SAVE_PATH: String = "user://save.json"
const DEFAULT_SAVE: Dictionary = {
    "version": 1,
    "checkpoint_zone": "hub",
    "checkpoint_position": {"x": 0.0, "y": 0.0},
    "player_health": 3,
    "player_ammo": 5,
    "time_dagger_energy": 100.0,
    "data_drives": 0,
    "progression": {},
    "world_state": {},
    "settings": {}
}

var current_save: Dictionary = {}

func _ready() -> void:
    if not FileAccess.file_exists(SAVE_PATH):
        current_save = DEFAULT_SAVE.duplicate(true)
        save_game()
    else:
        load_game()

func save_game() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    var json_string := JSON.stringify(current_save, "	", true)
    file.store_string(json_string)
    file.close()

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        return false
    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    var json_string := file.get_as_text()
    file.close()
    var parsed := JSON.parse_string(json_string)
    if parsed is Dictionary:
        current_save = parsed
        return true
    return false
```

#### `scripts/core/scene_manager.gd`
```gdscript
extends Node

signal scene_changed(new_scene: String)

var current_scene: Node = null

func _ready() -> void:
    var root := get_tree().root
    current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(path: String, with_loading: bool = true) -> void:
    if with_loading:
        # Builder: показать loading_screen, затем сменить сцену
        pass
    else:
        _deferred_change_scene(path)

func _deferred_change_scene(path: String) -> void:
    current_scene.free()
    var s := ResourceLoader.load(path)
    current_scene = s.instantiate()
    get_tree().root.add_child(current_scene)
    get_tree().current_scene = current_scene
    scene_changed.emit(path)
```

#### `scripts/core/audio_manager.gd`
```gdscript
extends Node

## SFX manager — пул AudioStreamPlayers

const SFX_POOL_SIZE: int = 16
var sfx_players: Array[AudioStreamPlayer] = []
var available_players: Array[AudioStreamPlayer] = []

func _ready() -> void:
    for i in range(SFX_POOL_SIZE):
        var player := AudioStreamPlayer.new()
        add_child(player)
        sfx_players.append(player)
        available_players.append(player)
        player.finished.connect(_on_player_finished.bind(player))

func _on_player_finished(player: AudioStreamPlayer) -> void:
    available_players.append(player)

func play_sfx(stream: AudioStream, volume_db: float = 0.0) -> void:
    if available_players.is_empty():
        return
    var player := available_players.pop_back()
    player.stream = stream
    player.volume_db = volume_db
    player.play()
```

#### `scripts/core/music_manager.gd`
```gdscript
extends Node

## Динамическая музыка с crossfade

var current_player: AudioStreamPlayer = null
var next_player: AudioStreamPlayer = null
var tween: Tween = null

func _ready() -> void:
    current_player = AudioStreamPlayer.new()
    next_player = AudioStreamPlayer.new()
    add_child(current_player)
    add_child(next_player)

func play_track(stream: AudioStream, crossfade_duration: float = 2.0) -> void:
    # Builder: crossfade между current и next
    pass
```

#### `scripts/core/dialogue_manager.gd`
```gdscript
extends Node

signal dialogue_started()
signal dialogue_finished()
signal line_displayed(text: String, speaker: String)

var is_dialogue_active: bool = false
var dialogue_queue: Array[Dictionary] = []
var current_line_index: int = 0

func start_dialogue(lines: Array[Dictionary]) -> void:
    dialogue_queue = lines
    current_line_index = 0
    is_dialogue_active = true
    dialogue_started.emit()
    _display_next_line()

func _display_next_line() -> void:
    if current_line_index >= dialogue_queue.size():
        end_dialogue()
        return
    var line := dialogue_queue[current_line_index]
    line_displayed.emit(line["text"], line.get("speaker", ""))
    current_line_index += 1

func advance_line() -> void:
    _display_next_line()

func end_dialogue() -> void:
    is_dialogue_active = false
    dialogue_finished.emit()
```

#### `scenes/ui/loading_screen.tscn`
- **Корень:** `Control` (fullscreen)
- **Дочерние:**
  - `ColorRect` (black background)
  - `RichTextLabel` (lore text, centered)
  - `ProgressBar` (bottom, loading progress)
- **Скрипт:** `scripts/ui/loading_screen.gd`

#### `scenes/entities/player/player.tscn` (stub)
- **Корень:** `CharacterBody2D`
- **Дочерние:**
  - `Sprite2D` (red square 32×32, placeholder)
  - `CollisionShape2D` (RectangleShape2D 32×32)
- **Скрипт:** `scripts/entities/player/player.gd` (пустой, extends CharacterBody2D)

---

## Правила реализации

1. **Все AutoLoad — пустые, но с корректными сигнатурами и сигналами.** Builder не добавляет логику, только структуру.
2. **InputMap заполняется программно** (не через редактор), чтобы Роман мог переназначить в настройках.
3. **Project Settings** — Builder редактирует `project.godot` как текстовый файл, если не может через редактор.
4. **Viewport:** базовое разрешение 640×360 (20×11.25 тайлов 32×32). При x2 = 1280×720, при x3 = 1920×1080.
5. **Pixel-perfect:** `canvas_items` + `integer` scale mode. Не `viewport` (размывает).

---

## Подводные камни

- **Godot 4.6 `project.godot`:** формат может отличаться от 4.3. Builder проверяет синтаксис.
- **AutoLoad порядок:** SettingsManager должен быть первым (индекс 0). Если порядок нарушен — настройки не загрузятся до инициализации других менеджеров.
- **InputMap:** `JOY_AXIS_LEFT_X` и `JOY_AXIS_LEFT_Y` — правильные константы для геймпада. Не путать с `JOY_BUTTON`.
- **JSON:** `JSON.parse_string()` возвращает `Variant`, нужна проверка `is Dictionary`.
- **FileAccess:** `user://` — путь к данным пользователя (AppData/Roaming/Godot/... на Windows). Не `res://` (read-only).

---

*ТЗ CP-0 готово. После приёмки — переход к CP-1 (Player Movement).*
