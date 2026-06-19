# ТЗ — CP-0: Project Setup

## Цель
Создать рабочий скелет проекта Godot 4.6.3 с правильной структурой папок, настройками viewport, Input Map и каркасами AutoLoad.

## Критерий готовности (чеклист для Романа)
- [ ] Проект открывается в Godot 4.6.3 без ошибок.
- [ ] Окно 640×360, масштаб x2, pixel-perfect.
- [ ] Нажатие WASD/Стрелок + Space двигает placeholder (красный квадрат).
- [ ] Все 8 AutoLoad Singletons созданы и инициализируются без крашей.
- [ ] Git репозиторий инициализирован, `.gitignore` настроен.

## Файлы и сцены

### Создать
- `project.godot` — настройки проекта (уже создано Godot, но нужно настроить).
- `assets/art/player/placeholder.png` — 32×32 красный квадрат.
- `scripts/core/game_manager.gd`
- `scripts/core/progression_manager.gd`
- `scripts/core/save_manager.gd`
- `scripts/core/time_manager.gd`
- `scripts/core/input_manager.gd`
- `scripts/core/audio_manager.gd`
- `scripts/core/dialogue_manager.gd`
- `scripts/core/ui_manager.gd`
- `scenes/core/main.tscn` — корневая сцена с placeholder игроком.
- `.gitignore`

### Модифицировать
- `project.godot` — Input Map, AutoLoad, Display settings.

## Спецификация нод и сцен

### Сцена: `scenes/core/main.tscn`
- Корень: `Node2D`
- Дочерние:
  - `TileMap` (пустой, для теста)
  - `Player` (Sprite2D с placeholder.png)
  - `Camera2D` (current = true, smoothing)

### Класс: `GameManager` (extends Node)
```gdscript
class_name GameManager extends Node

signal scene_changed(scene_path: String)
signal game_paused(is_paused: bool)

var current_scene: String = "res://scenes/core/main.tscn"
var is_paused: bool = false

func _ready() -> void:
    print("GameManager initialized")

func change_scene(path: String) -> void:
    current_scene = path
    get_tree().change_scene_to_file(path)
    scene_changed.emit(path)
```

### Класс: `ProgressionManager` (extends Node)
```gdscript
class_name ProgressionManager extends Node

signal npc_rescued(npc_id: String)
signal ability_unlocked(ability_id: String)

var rescued_npcs: Dictionary = {}
var unlocked_abilities: Dictionary = {}

func _ready() -> void:
    print("ProgressionManager initialized")

func rescue_npc(npc_id: String) -> void:
    rescued_npcs[npc_id] = true
    npc_rescued.emit(npc_id)
```

### Класс: `SaveManager` (extends Node)
```gdscript
class_name SaveManager extends Node

signal game_saved
signal game_loaded

const SAVE_PATH: String = "user://save.json"

func _ready() -> void:
    print("SaveManager initialized")

func save_current_state() -> void:
    var data: Dictionary = {
        "progression": ProgressionManager.rescued_npcs,
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
            ProgressionManager.rescued_npcs = data.get("progression", {})
            game_loaded.emit()
```

### Класс: `TimeManager` (extends Node)
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

func _ready() -> void:
    print("TimeManager initialized")

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
```

### Класс: `InputManager` (extends Node)
```gdscript
class_name InputManager extends Node

func _ready() -> void:
    print("InputManager initialized")
```

### Класс: `AudioManager` (extends Node)
```gdscript
class_name AudioManager extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

func _ready() -> void:
    print("AudioManager initialized")
    if not music_player:
        music_player = AudioStreamPlayer.new()
        add_child(music_player)
    if not sfx_player:
        sfx_player = AudioStreamPlayer.new()
        add_child(sfx_player)
```

### Класс: `DialogueManager` (extends Node)
```gdscript
class_name DialogueManager extends Node

func _ready() -> void:
    print("DialogueManager initialized")
```

### Класс: `UIManager` (extends Node)
```gdscript
class_name UIManager extends Node

func _ready() -> void:
    print("UIManager initialized")
```

## Настройки project.godot

### Display → Window
- Size: Width = 640, Height = 360
- Stretch: Mode = `canvas_items`, Aspect = `keep`

### Rendering → 2D
- Snap 2D Vertices to Pixel = ON
- Snap 2D Transforms to Pixel = ON

### Input Map
```
move_left: A, Left Arrow
move_right: D, Right Arrow
move_up: W, Up Arrow
move_down: S, Down Arrow
jump: Space, Gamepad A
dash: Shift, Gamepad RB
crouch: Ctrl, Gamepad L3
roll: Alt, Gamepad B
attack: Mouse Left, Gamepad X
aim: Mouse Right (hold), Gamepad RT
hook: F, Gamepad LB
interact: E, Gamepad Y
gadget_1: 1, Gamepad D-Pad Up
gadget_2: 2, Gamepad D-Pad Down
gadget_3: 3, Gamepad D-Pad Left
time_dagger: Q, Gamepad D-Pad Right
map: M, Gamepad Select
pause: Escape, Gamepad Start
inventory: Tab
```

### AutoLoad
1. `GameManager` — `scripts/core/game_manager.gd`
2. `ProgressionManager` — `scripts/core/progression_manager.gd`
3. `SaveManager` — `scripts/core/save_manager.gd`
4. `TimeManager` — `scripts/core/time_manager.gd`
5. `InputManager` — `scripts/core/input_manager.gd`
6. `AudioManager` — `scripts/core/audio_manager.gd`
7. `DialogueManager` — `scripts/core/dialogue_manager.gd`
8. `UIManager` — `scripts/core/ui_manager.gd`

## .gitignore
```
# Godot 4 .gitignore
.godot/
.import/
export.cfg
export_presets.cfg
*.tmp
```

## Правила реализации
1. Все скрипты используют `class_name` и строгую типизацию (`-> void`, `-> int`).
2. Все Singletons имеют `print()` в `_ready()` для проверки инициализации.
3. Placeholder игрок — просто `Sprite2D` с `placeholder.png`, без скрипта.
4. Камера — `Camera2D` с `position_smoothing_enabled = true`.

## Подводные камни
- **Godot 4.6:** `FileAccess` вместо устаревших `File` (Godot 3.x). Проверь `FileAccess.file_exists()`.
- **AutoLoad порядок:** Если Singleton A обращается к Singleton B в `_ready()`, B должен быть выше в списке AutoLoad.
- **Viewport:** 640×360 — базовое разрешение. Не путать с `window_size`. Stretch `canvas_items` масштабирует пиксели, а не растягивает.
- **InputMap:** Не хардкодить клавиши в скриптах — использовать `Input.is_action_pressed("move_left")`.

---

*CP-0 — фундамент. Без него невозможны все остальные CP.*
