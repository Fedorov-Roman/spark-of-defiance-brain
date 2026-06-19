# Godot Architecture

> **Версия:** 2.0  
> **Движок:** Godot 4.6.3 stable  
> **Язык:** GDScript (строгая типизация)  
> **Дата:** 2026-06-19

---

## 1. Структура проекта (File System)

```
res://
├── assets/
│   ├── art/
│   │   ├── concept/          # Leonardo.Ai концепты (PNG)
│   │   ├── sprites/
│   │   │   ├── player/       # SpriteSheets Кая
│   │   │   ├── enemies/      # SpriteSheets врагов
│   │   │   ├── npc/          # SpriteSheets NPC
│   │   │   └── bosses/       # SpriteSheets боссов
│   │   ├── tilesets/         # TileSet ресурсы (.tres)
│   │   ├── backgrounds/      # Parallax фоны
│   │   └── ui/               # UI элементы, иконки, портреты
│   ├── audio/
│   │   ├── sfx/              # Звуковые эффекты (.ogg/.wav)
│   │   └── music/            # Музыкальные треки (.ogg)
│   ├── fonts/                # M5x7, Pixel Operator (.ttf)
│   └── shaders/              # .gdshader файлы
│       ├── time_dagger.gdshader
│       ├── vision_cone.gdshader
│       └── screen_effects.gdshader
├── scenes/
│   ├── levels/
│   │   ├── zone_1/
│   │   │   ├── zone_1_main.tscn
│   │   │   ├── zone_1_dungeon.tscn
│   │   │   └── boss_leviathan_arena.tscn
│   │   ├── zone_2/
│   │   │   ├── zone_2_main.tscn
│   │   │   └── boss_helios_arena.tscn
│   │   ├── zone_3/
│   │   │   ├── zone_3_main.tscn
│   │   │   └── boss_biomech_arena.tscn
│   │   └── hub/
│   │       └── hub_base.tscn
│   ├── entities/
│   │   ├── player/
│   │   │   └── player.tscn
│   │   ├── enemies/
│   │   │   ├── drone_eye.tscn
│   │   │   ├── guard_sun.tscn
│   │   │   ├── silicon_beast.tscn
│   │   │   └── elite_sniper.tscn
│   │   ├── npc/
│   │   │   ├── engineer_uno.tscn
│   │   │   ├── medic_liara.tscn
│   │   │   └── chronomant_elia.tscn
│   │   └── bosses/
│   │       ├── leviathan.tscn
│   │       ├── helios7.tscn
│   │       └── biomechanoid.tscn
│   ├── interactables/
│   │   ├── checkpoint.tscn
│   │   ├── landing_pad.tscn
│   │   ├── data_drive.tscn
│   │   ├── steam_valve.tscn
│   │   ├── laser_gate.tscn
│   │   ├── locked_door.tscn
│   │   └── vspyshka_terminal.tscn
│   ├── ui/
│   │   ├── hud.tscn
│   │   ├── pause_menu.tscn
│   │   ├── dialogue_box.tscn
│   │   ├── inventory_screen.tscn
│   │   ├── world_map.tscn
│   │   ├── minimap.tscn
│   │   ├── loading_screen.tscn
│   │   ├── settings_menu.tscn
│   │   └── prologue_screen.tscn
│   └── effects/
│       ├── dust_storm.tscn
│       ├── smoke_cloud.tscn
│       ├── emp_burst.tscn
│       └── noise_ripple.tscn
├── scripts/
│   ├── core/
│   │   ├── game_manager.gd           # AutoLoad
│   │   ├── save_manager.gd           # AutoLoad
│   │   ├── progression_manager.gd    # AutoLoad
│   │   ├── scene_manager.gd          # AutoLoad
│   │   ├── audio_manager.gd          # AutoLoad
│   │   ├── music_manager.gd          # AutoLoad
│   │   ├── input_manager.gd          # AutoLoad
│   │   ├── settings_manager.gd       # AutoLoad
│   │   └── dialogue_manager.gd       # AutoLoad
│   ├── entities/
│   │   ├── player/
│   │   │   └── player.gd
│   │   ├── enemies/
│   │   │   ├── base_enemy.gd
│   │   │   ├── drone_eye.gd
│   │   │   ├── guard_sun.gd
│   │   │   ├── silicon_beast.gd
│   │   │   └── elite_sniper.gd
│   │   ├── npc/
│   │   │   └── base_npc.gd
│   │   └── bosses/
│   │       ├── base_boss.gd
│   │       ├── leviathan.gd
│   │       ├── helios7.gd
│   │       └── biomechanoid.gd
│   ├── systems/
│   │   ├── stealth/
│   │   │   ├── vision_cone.gd
│   │   │   ├── noise_emitter.gd
│   │   │   └── stealth_kill_zone.gd
│   │   ├── combat/
│   │   │   ├── sniper_rifle.gd
│   │   │   ├── energy_knife.gd
│   │   │   └── projectile.gd
│   │   ├── time/
│   │   │   └── time_dagger.gd
│   │   ├── movement/
│   │   │   ├── grapple_hook.gd
│   │   │   └── dash_controller.gd
│   │   └── save/
│   │       └── save_data.gd
│   ├── ui/
│   │   ├── hud.gd
│   │   ├── pause_menu.gd
│   │   ├── dialogue_box.gd
│   │   ├── inventory_screen.gd
│   │   ├── world_map.gd
│   │   └── settings_menu.gd
│   └── level/
│       ├── zone_manager.gd
│       ├── checkpoint.gd
│       └── landing_pad.gd
└── resources/
    ├── themes/
    │   └── default_theme.tres
    ├── tilesets/
    │   ├── zone_1_tileset.tres
    │   ├── zone_2_tileset.tres
    │   └── zone_3_tileset.tres
    ├── materials/
    │   ├── vision_cone_material.tres
    │   └── time_dagger_material.tres
    └── save/
        └── default_save.tres
```

---

## 2. AutoLoad (Singletons) — порядок инициализации

| Порядок | Имя | Скрипт | Назначение |
|---------|-----|--------|------------|
| 1 | **SettingsManager** | `settings_manager.gd` | Загрузка настроек (графика, звук, управление) из JSON |
| 2 | **InputManager** | `input_manager.gd` | Настройка InputMap, переназначение клавиш |
| 3 | **AudioManager** | `audio_manager.gd` | SFX, пул AudioStreamPlayers |
| 4 | **MusicManager** | `music_manager.gd` | Динамическая музыка, crossfade |
| 5 | **GameManager** | `game_manager.gd` | Глобальное состояние: текущая зона, HP, боезапас, гаджеты |
| 6 | **ProgressionManager** | `progression_manager.gd` | Флаги прогресса: спасённые NPC, открытые способности, Data Drives |
| 7 | **SaveManager** | `save_manager.gd` | Сериализация/десериализация JSON, autosave/load |
| 8 | **SceneManager** | `scene_manager.gd` | Переходы между сценами, загрузочный экран, fade in/out |
| 9 | **DialogueManager** | `dialogue_manager.gd` | Очередь диалогов, печать текста, портреты |

**Порядок в Project Settings → AutoLoad:**
```
SettingsManager (0)
InputManager (1)
AudioManager (2)
MusicManager (3)
GameManager (4)
ProgressionManager (5)
SaveManager (6)
SceneManager (7)
DialogueManager (8)
```

---

## 3. Scene Tree (типичная зона)

```
Zone1Main (Node2D)
├── ParallaxBackground
│   ├── ParallaxLayer (far, motion_scale=0.2)
│   ├── ParallaxLayer (mid, motion_scale=0.5)
│   └── ParallaxLayer (close, motion_scale=0.8)
├── TileMapLayer (ground)
├── TileMapLayer (walls)
├── TileMapLayer (decorations)
├── Lighting
│   ├── CanvasModulate (color: #000000, darkness)
│   ├── PointLight2D (lanterns)
│   └── DirectionalLight2D (moonlight)
├── Entities
│   ├── Player (CharacterBody2D)
│   │   ├── Sprite2D
│   │   ├── CollisionShape2D
│   │   ├── PointLight2D (player lantern)
│   │   ├── LightOccluder2D
│   │   ├── RayCast2D (ground)
│   │   ├── RayCast2D (wall_left)
│   │   ├── RayCast2D (wall_right)
│   │   ├── RayCast2D (ledge)
│   │   ├── Area2D (hurtbox)
│   │   ├── Area2D (noise)
│   │   └── StateMachine (Node)
│   ├── Enemies (Node)
│   │   ├── DroneEye1
│   │   ├── GuardSun1
│   │   └── ...
│   └── NPCs (Node)
│       ├── EngineerUno
│       └── ...
├── Interactables (Node)
│   ├── Checkpoint1
│   ├── DataDrive1
│   ├── LandingPad1
│   └── ...
├── Effects (Node)
│   ├── DustStorm
│   └── ...
├── Camera2D
│   └── RemoteTransform2D (привязка к Player)
└── UI (CanvasLayer)
    └── HUD
```

---

## 4. Ключевые классы (каркасы)

### 4.1. Player (CharacterBody2D)

```gdscript
class_name Player extends CharacterBody2D

## @export — видны в Inspector
@export var speed: float = 120.0
@export var jump_force: float = 280.0
@export var wall_slide_friction: float = 0.3
@export var dash_distance: float = 200.0
@export var dash_duration: float = 0.2
@export var roll_iframes: float = 0.4
@export var max_health: int = 3
@export var max_ammo: int = 5

## @onready — кэширование нод
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var crouch_shape: CollisionShape2D = $CrouchCollisionShape2D
@onready var ground_ray: RayCast2D = $GroundRayCast
@onready var wall_left_ray: RayCast2D = $WallLeftRayCast
@onready var wall_right_ray: RayCast2D = $WallRightRayCast
@onready var ledge_ray: RayCast2D = $LedgeRayCast
@onready var hurtbox: Area2D = $Hurtbox
@onready var noise_area: Area2D = $NoiseArea
@onready var state_machine: Node = $StateMachine
@onready var dash_timer: Timer = $DashTimer
@onready var roll_timer: Timer = $RollTimer

## Сигналы
signal health_changed(new_health: int, max_health: int)
signal ammo_changed(new_ammo: int, max_ammo: int)
signal died()
signal checkpoint_reached(checkpoint_id: String)

## Состояние
var health: int = 3
var ammo: int = 5
var is_crouching: bool = false
var is_invincible: bool = false
var can_air_dash: bool = true
var facing_direction: int = 1  # 1 = right, -1 = left
var current_state: String = "idle"

func _ready() -> void:
    # Builder реализует
    pass

func _physics_process(delta: float) -> void:
    # Builder реализует: движение, wall-slide, jump, dash
    pass

func _unhandled_input(event: InputEvent) -> void:
    # Builder реализует: ввод, приседание, стрельба, гаджеты
    pass

func take_damage(amount: int) -> void:
    # Builder реализует
    pass

func heal(amount: int) -> void:
    # Builder реализует
    pass

func respawn_at_checkpoint() -> void:
    # Builder реализует: загрузка позиции из SaveManager
    pass
```

### 4.2. BaseEnemy (CharacterBody2D)

```gdscript
class_name BaseEnemy extends CharacterBody2D

## @export
@export var patrol_speed: float = 40.0
@export var alert_speed: float = 80.0
@export var vision_range: float = 200.0
@export var vision_angle: float = 60.0
@export var hearing_radius: float = 100.0
@export var suspicion_threshold: float = 2.0
@export var alert_threshold: float = 5.0
@export var return_to_patrol_time: float = 30.0

## @onready
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var vision_area: Area2D = $VisionArea
@onready var hearing_area: Area2D = $HearingArea
@onready var state_machine: Node = $StateMachine
@onready var suspicion_timer: Timer = $SuspicionTimer
@onready var alert_timer: Timer = $AlertTimer
@onready return_timer: Timer = $ReturnTimer

## Сигналы
signal player_detected()
signal player_lost()
signal died()

## Состояние
enum State { IDLE, SUSPICIOUS, ALERT, RETURNING, PARALYZED, DEAD }
var current_state: State = State.IDLE
var suspicion_level: float = 0.0
var last_known_player_position: Vector2 = Vector2.ZERO

func _ready() -> void:
    pass  # Builder реализует

func _physics_process(delta: float) -> void:
    pass  # Builder реализует: патруль, преследование, возврат

func _on_vision_area_body_entered(body: Node2D) -> void:
    pass  # Builder реализует: проверка линии видимости

func _on_hearing_area_body_entered(body: Node2D) -> void:
    pass  # Builder реализует: реакция на шум

func take_damage(amount: int) -> void:
    pass  # Builder реализует

func paralyze(duration: float) -> void:
    pass  # Builder реализует
```

### 4.3. StateMachine (Node)

```gdscript
class_name StateMachine extends Node

signal state_changed(new_state: String, old_state: String)

var current_state: State = null
var previous_state: State = null
var states: Dictionary = {}

func _ready() -> void:
    pass  # Builder: инициализация состояний

func add_state(state_name: String, state: State) -> void:
    pass  # Builder: регистрация состояния

func change_to(state_name: String) -> void:
    pass  # Builder: смена состояния с exit/enter

func _physics_process(delta: float) -> void:
    if current_state:
        current_state.physics_update(delta)

func _process(delta: float) -> void:
    if current_state:
        current_state.update(delta)
```

### 4.4. SaveManager (AutoLoad)

```gdscript
extends Node

const SAVE_PATH: String = "user://save.json"

var current_save: Dictionary = {}

func _ready() -> void:
    pass  # Builder: создание default save если нет файла

func save_game() -> void:
    pass  # Builder: сериализация в JSON

func load_game() -> bool:
    pass  # Builder: десериализация из JSON

func get_checkpoint_position() -> Vector2:
    pass  # Builder: возврат позиции

func set_checkpoint_position(pos: Vector2, zone: String) -> void:
    pass  # Builder: сохранение позиции
```

### 4.5. TimeDagger (Node)

```gdscript
class_name TimeDagger extends Node

## @export
@export var slow_factor: float = 0.3
@export var duration: float = 3.0
@export var cooldown: float = 10.0
@export var energy_cost: float = 30.0

## @onready
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var duration_timer: Timer = $DurationTimer

## Сигналы
signal activated()
signal deactivated()
signal cooldown_finished()

var is_active: bool = false
var is_on_cooldown: bool = false

func activate() -> void:
    pass  # Builder: замедление группы "time_affected"

func deactivate() -> void:
    pass  # Builder: восстановление нормального времени

func _apply_time_scale(scale: float) -> void:
    pass  # Builder: обход всех нод в группе, модификация delta
```

---

## 5. Сигнальная система (Decoupling)

| Сигнал | Отправитель | Получатели | Назначение |
|--------|-------------|------------|------------|
| `health_changed` | Player | HUD, SaveManager | Обновление UI и сохранение |
| `ammo_changed` | Player | HUD | Обновление счётчика патрон |
| `died` | Player | SceneManager, SaveManager | Респаун, fade out |
| `checkpoint_reached` | Checkpoint | SaveManager, GameManager | Автосейв |
| `player_detected` | BaseEnemy | MusicManager, nearby enemies | Смена музыки, тревога |
| `player_lost` | BaseEnemy | MusicManager | Возврат к спокойной музыке |
| `npc_rescued` | NPC | ProgressionManager, Hub | Открытие способностей |
| `time_dagger_activated` | TimeDagger | Shader, MusicManager | Синий фильтр, замедление музыки |
| `zone_entered` | ZoneManager | MusicManager, Ambient | Смена музыки и амбиента |
| `dialogue_started` | DialogueManager | Player, MusicManager | Блокировка ввода, приглушение музыки |
| `dialogue_finished` | DialogueManager | Player, MusicManager | Разблокировка ввода |

---

## 6. Collision Layers и Masks

| Layer | Назначение | Кто на нём | Кто проверяет |
|-------|-----------|------------|---------------|
| **1** | Player | Player | — |
| **2** | Enemies | Drones, Guards, Beasts, Snipers | Player (hurtbox) |
| **3** | World | TileMap (стены, земля) | Player, Enemies |
| **4** | Interactables | Checkpoints, Doors, Data Drives | Player (interact area) |
| **5** | Projectiles | Sniper shots, EMP waves | Enemies, Electronics |
| **6** | Vision | VisionCone Area2D | — (триггер) |
| **7** | Noise | NoiseEmitter Area2D | Enemy hearing |
| **8** | Hurtbox (Player) | Player Hurtbox | Enemy attacks |
| **9** | Hurtbox (Enemy) | Enemy Hurtbox | Player attacks |
| **10** | LightOccluder | Walls, Objects | PointLight2D |

**Настройка:** Project Settings → Layer Names → 2D Physics

---

## 7. Важные Godot-специфичные решения

### 7.1. TileMap → TileMapLayer (Godot 4.6)

В Godot 4.6 `TileMap` устарел, используем `TileMapLayer`:
```gdscript
# TileMapLayer — отдельная нода для каждого слоя
$TileMapLayerGround.set_cells_terrain_connect(...)  # новый API
```

### 7.2. Pixel-Perfect рендеринг

```gdscript
# Project Settings -> Rendering -> 2D
# Stretch Mode: canvas_items
# Stretch Aspect: expand
# Scale Mode: integer

# Для спрайтов:
sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
```

### 7.3. Кастомное время (Time Dagger)

**НЕ использовать `Engine.time_scale`** — это сломает UI и анимации Кая.

Вместо этого:
```gdscript
# Ноды, которые замедляются, добавляются в группу "time_affected"
# В их _physics_process:
func _physics_process(delta: float) -> void:
    var effective_delta := delta
    if TimeDagger.is_active:
        effective_delta *= TimeDagger.slow_factor
    # использовать effective_delta вместо delta
```

### 7.4. Сохранение через JSON

```gdscript
# SaveManager
func save_game() -> void:
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    var json_string := JSON.stringify(current_save, "	", true)
    file.store_string(json_string)
    file.close()
```

---

## 8. Подводные камни (критично для Builder'а)

1. **`queue_free()`** не удаляет мгновенно. Нода удалится в конце кадра. Не обращаться к ней сразу после вызова.
2. **`Tween`** создаётся через `create_tween()`, не `new Tween()`.
3. **`get_node()`** в `_process` — это O(N) поиск каждый кадр. Использовать только `@onready`.
4. **`global_position` vs `position`** — `global_position` для мировых координат, `position` — локальные (относительно родителя).
5. **`_input()` vs `_unhandled_input()`** — `_input()` перехватывает всё, `_unhandled_input()` — только непоглощённое. UI использует `_input()`, игра — `_unhandled_input()`.
6. **`move_and_slide()`** в Godot 4 возвращает `bool`, не `Vector2`. Для проверки коллизий использовать `get_slide_collision_count()`.
7. **`TileMapLayer`** в 4.6 — новый API. Не использовать старые методы `TileMap`.
8. **`CharacterBody2D`** — `velocity` применяется автоматически в `move_and_slide()`, не нужно вручную менять `position`.

---

*Архитектура зафиксирована. Изменения — через Decision Log и обновление этого документа.*
