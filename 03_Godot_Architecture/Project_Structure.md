# 🏗️ Godot Project Structure

> **Версия:** Godot 4.6.3 Stable  
> **Язык:** GDScript (строгая типизация)  
> **Стиль:** Модульная структура

## 1. Дерево папок

```
res://
├── .godot/                    # Автогенерация (в .gitignore)
├── assets/
│   ├── art/
│   │   ├── player/            # Спрайты Кая (SpriteSheets)
│   │   ├── enemies/           # Спрайты врагов
│   │   ├── backgrounds/       # Parallax фоны (3 слоя)
│   │   ├── tiles/             # TileSet текстуры (32×32)
│   │   ├── ui/                # UI-элементы, иконки, портреты
│   │   ├── effects/           # Частицы, шейдеры, вспышки
│   │   └── leonardo/          # Концепты от Leonardo.Ai
│   ├── audio/
│   │   ├── music/             # Музыкальные треки (динамические)
│   │   ├── sfx/               # Звуки (шаги, выстрелы, UI)
│   │   └── ambient/           # Амбиенты зон
│   └── fonts/                 # M5x7, Pixel Operator
├── scenes/
│   ├── core/                  # Глобальные сцены (камера, менеджеры)
│   ├── levels/                # Уровни-зоны
│   │   ├── zone_1_red_dunes/
│   │   ├── zone_2_polar_oasis/
│   │   ├── zone_3_deep_labs/
│   │   └── hub/
│   ├── entities/              # Сущности
│   │   ├── player/
│   │   ├── enemies/
│   │   ├── npcs/
│   │   ├── bosses/
│   │   └── interactables/     # Двери, терминалы, чекпоинты
│   └── ui/                    # UI-сцены
│       ├── hud/
│       ├── menus/
│       └── dialogues/
├── scripts/
│   ├── core/                  # AutoLoad Singletons
│   ├── systems/               # Логические системы
│   ├── entities/              # Скрипты сущностей
│   └── ui/                    # Скрипты UI
├── resources/                 # .tres файлы
│   ├── themes/                # UI темы
│   ├── tilesets/              # TileSet ресурсы
│   ├── materials/             # Шейдерные материалы
│   └── save_data/             # JSON сохранения (runtime)
└── docs/                      # Документация (опционально)
```

## 2. AutoLoad (Singletons) — порядок инициализации

| Имя | Скрипт | Порядок | Назначение |
|-----|--------|---------|------------|
| `GameManager` | `scripts/core/game_manager.gd` | 1 | Глобальное состояние, смена сцен, пауза |
| `ProgressionManager` | `scripts/core/progression_manager.gd` | 2 | Флаги NPC, открытые способности, зоны |
| `SaveManager` | `scripts/core/save_manager.gd` | 3 | Сохранение/загрузка JSON, автосейвы |
| `TimeManager` | `scripts/core/time_manager.gd` | 4 | Кинжал Времени (замедление, энергия) |
| `InputManager` | `scripts/core/input_manager.gd` | 5 | Обработка ввода, rebinding, InputMap |
| `AudioManager` | `scripts/core/audio_manager.gd` | 6 | Музыка, SFX, амбиент, динамические переходы |
| `DialogueManager` | `scripts/core/dialogue_manager.gd` | 7 | Текстовые окна, портреты, скорость текста |
| `UIManager` | `scripts/core/ui_manager.gd` | 8 | HUD, меню, инвентарь, карта |

**Порядок важен:** `GameManager` инициализируется первым, `UIManager` — последним.

## 3. Группы (Groups)

| Группа | Назначение |
|--------|------------|
| `"enemies"` | Все враги (для массовых операций) |
| `"drones"` | Летающие дроны |
| `"guards"` | Наземные стражи |
| `"traps"` | Ловушки, турели, лазеры |
| `"time_affected"` | Объекты, подверженные замедлению времени |
| `"noise_sources"` | Источники шума (взрывы, выстрелы) |
| `"cover_zones"` | Укрытия (трава, дым, ниши) |
| `"interactables"` | Объекты для взаимодействия (двери, терминалы) |
| `"checkpoints"` | Чекпоинты |
| `"spawners"` | Точки спавна подкреплений |

## 4. Сигналы (Global vs Local)

### Глобальные (через AutoLoad):
- `GameManager.scene_changed`
- `ProgressionManager.npc_rescued(npc_id: String)`
- `SaveManager.game_saved` / `game_loaded`
- `TimeManager.time_slow_started` / `time_slow_ended`
- `AudioManager.music_changed`

### Локальные (внутри сцен):
- `Player.dashed`, `Player.jumped`, `Player.died`
- `Enemy.player_detected`, `Enemy.died`
- `Boss.phase_changed(phase: int)`
- `Interactable.interacted`

## 5. Физика и слои

### Collision Layers (2D):

| Layer | Назначение |
|-------|------------|
| 1 | `World` — стены, пол, TileMap |
| 2 | `Player` — Кай |
| 3 | `Enemies` — враги |
| 4 | `Hitboxes` — атаки, урон |
| 5 | `Hurtboxes` — уязвимые зоны |
| 6 | `Interactables` — двери, терминалы |
| 7 | `Cover` — укрытия |
| 8 | `Projectiles` — пули, импульсы |
| 9 | `Traps` — ловушки, лазеры |
| 10 | `Items` — подбираемые предметы |

### Collision Masks (пример для Player):
- Слой 2 (Player) взаимодействует с: 1 (World), 3 (Enemies), 6 (Interactables), 7 (Cover), 9 (Traps), 10 (Items).

## 6. TileMap структура

```gdscript
# TileMap слои (снизу вверх):
# 0: Background (декоративные тайлы, без коллизий)
# 1: Ground (пол, платформы — коллизия)
# 2: Walls (стены — коллизия)
# 3: Details (мелкие объекты, без коллизий)
# 4: Cover (трава, укрытия — Area2D overlay)
# 5: Foreground (передний план, полупрозрачный)
```

## 7. Шейдеры

| Шейдер | Назначение | Файл |
|--------|------------|------|
| `time_slow.gdshader` | Синий фильтр + искажение при замедлении времени | `assets/art/effects/` |
| `vision_cone.gdshader` | Полупрозрачный конус зрения | `assets/art/effects/` |
| `pixel_perfect.gdshader` | Pixel-perfect рендеринг (опционально) | `assets/art/effects/` |

## 8. Viewport настройки

```gdscript
# Project Settings -> Display -> Window:
# Size: 640×360 (базовое, 32×32 тайлы × 20 ширина)
# Stretch: Mode = canvas_items, Aspect = keep
# Scale: 2x или 3x (в runtime через код или настройки)
```

**Pixel Perfect:** `Rendering -> 2D -> Snap 2D Vertices to Pixel = ON`

---

*Структура фиксирована. Любое изменение — через Architect'а.*
