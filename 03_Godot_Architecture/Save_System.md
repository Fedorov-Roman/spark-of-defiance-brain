# 💾 Save System

> **Формат:** JSON  
> **Путь:** `user://save.json`  
> **Тип:** Автосейвы на чекпоинтах + ручное сохранение в меню паузы  
> **Сохраняется:** Полное состояние мира

## 1. Структура JSON

```json
{
    "version": "1.0",
    "timestamp": 1718800000,
    "player": {
        "current_zone": "zone_1_red_dunes",
        "position": {"x": 120.5, "y": 200.0},
        "hp": 2,
        "max_hp": 3,
        "energy": 75.0,
        "ammo": 3,
        "data_drives": 12,
        "gadgets": {
            "emi": 2,
            "smoke": 1,
            "decoy": 0
        }
    },
    "progression": {
        "rescued_npcs": {
            "uno": true,
            "liara": false,
            "jaan": false,
            "elia": false,
            "kess": false,
            "finch": false
        },
        "unlocked_abilities": {
            "grappling_hook": true,
            "double_dash": false,
            "time_echo": false,
            "fast_travel": false,
            "world_map": false
        },
        "unlocked_platforms": ["hub", "zone_1_platform_1", "zone_1_platform_2"]
    },
    "zones": {
        "zone_1_red_dunes": {
            "visited": true,
            "enemies_defeated": ["drone_1", "drone_2", "guard_1"],
            "secrets_found": ["datadrive_1", "datadrive_3"],
            "doors_opened": ["door_a"],
            "checkpoints_reached": ["cp_1", "cp_2", "cp_3"]
        },
        "zone_2_polar_oasis": {
            "visited": false,
            "enemies_defeated": [],
            "secrets_found": [],
            "doors_opened": [],
            "checkpoints_reached": []
        }
    },
    "hub": {
        "npcs_present": ["uno"],
        "upgrades_purchased": ["grappling_range_1"]
    },
    "settings": {
        "resolution": "1920x1080",
        "fullscreen": false,
        "vsync": true,
        "music_volume": 0.8,
        "sfx_volume": 1.0,
        "text_speed": "normal"
    }
}
```

## 2. Godot Implementation

```gdscript
class_name SaveManager extends Node

signal game_saved
signal game_loaded

const SAVE_PATH: String = "user://save.json"
const SAVE_VERSION: String = "1.0"

func save_current_state() -> void:
    var data: Dictionary = {
        "version": SAVE_VERSION,
        "timestamp": Time.get_unix_time_from_system(),
        "player": _get_player_data(),
        "progression": _get_progression_data(),
        "zones": _get_zones_data(),
        "hub": _get_hub_data(),
        "settings": _get_settings_data()
    }
    var json := JSON.stringify(data, "	")  # Форматированный JSON
    var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(json)
        file.close()
        game_saved.emit()
        print("Game saved to ", SAVE_PATH)

func load_game() -> bool:
    if not FileAccess.file_exists(SAVE_PATH):
        print("No save file found")
        return false

    var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
    if not file:
        return false

    var json := file.get_as_text()
    file.close()

    var data: Dictionary = JSON.parse_string(json)
    if not data:
        print("Failed to parse save file")
        return false

    if data.get("version", "") != SAVE_VERSION:
        print("Save version mismatch: ", data.get("version"))
        # Миграция или отказ
        return false

    _apply_player_data(data.get("player", {}))
    _apply_progression_data(data.get("progression", {}))
    _apply_zones_data(data.get("zones", {}))
    _apply_hub_data(data.get("hub", {}))
    _apply_settings_data(data.get("settings", {}))

    game_loaded.emit()
    return true

func _get_player_data() -> Dictionary:
    var player := get_tree().get_first_node_in_group("player") as Player
    if not player:
        return {}
    return {
        "current_zone": GameManager.current_scene,
        "position": {"x": player.global_position.x, "y": player.global_position.y},
        "hp": player.hp,
        "max_hp": player.max_hp,
        "energy": TimeManager.energy,
        "ammo": player.ammo,
        "data_drives": ProgressionManager.data_drives,
        "gadgets": {
            "emi": player.gadget_emi,
            "smoke": player.gadget_smoke,
            "decoy": player.gadget_decoy
        }
    }

func _apply_player_data(data: Dictionary) -> void:
    # Применяется при загрузке сцены
    GameManager.pending_player_data = data
```

## 3. Автосейвы

- **Триггеры:** Чекпоинт (Area2D), смена зоны, выход из игры.
- **Индикатор:** Маленькая иконка дискеты в углу (1 сек).
- **Частота:** Не чаще 1 раза в 30 секунд (чтобы не лагало).

## 4. Бэкапы

- **Ротация:** 3 слота (`save_1.json`, `save_2.json`, `save_3.json`).
- **Автобэкап:** Перед перезаписью — копия в `save_backup.json`.

## 5. Подводные камни

- **JSON и Vector2:** `Vector2` не сериализуется в JSON напрямую. Использовать `{"x": v.x, "y": v.y}`.
- **Node пути:** Не сохранять пути нод (`get_path()`), они могут измениться. Использовать уникальные ID.
- **PackedScene:** Не сохранять сцены. Сохранять только флаги состояния.
- **Асинхронность:** `FileAccess` синхронный, но для больших файлов — использовать `Thread` (в Godot 4.6 `FileAccess` в потоке безопасен).

---

*Сохранение — страховка. JSON выбран для удобства дебага и читаемости.*
