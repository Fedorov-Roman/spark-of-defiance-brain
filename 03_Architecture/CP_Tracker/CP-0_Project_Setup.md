# CP-0: Project Setup

## Status
- **State**: ✅ COMPLETED
- **Review Date**: 2026-06-20
- **Approved by**: Kimi (Architect)
- **Blockers**: 0
- **Minor**: Camera2D position fixed (320, 180) to center on ColorRect

## Goal
Создать runnable Godot 4.6.3 проект с корректной структурой, viewport, InputMap, AutoLoad-каркасами и placeholder-артами.

## Critical Decisions
- **Renderer**: GL Compatibility (Mobile ломает pixel-perfect 2D)
- **Stretch**: canvas_items + integer scale_mode + NEAREST filter
- **Time**: НЕТ Engine.time_scale нигде. Time Dagger через кастомный delta.
- **AutoLoad scripts**: `extends Node` only — **НЕТ `class_name`** (конфликт с singleton именем в Godot 4.x)
- **Non-AutoLoad scripts** (components, entities, UI): `class_name` + `extends Node/Area2D/etc` — OK

## InputMap Actions (полный список)
| Action | Keyboard | Gamepad | Тип |
|--------|----------|---------|-----|
| move_left | A / Left | LStick left | axis |
| move_right | D / Right | LStick right | axis |
| move_up | W / Up | LStick up | axis |
| move_down | S / Down | LStick down | axis |
| jump | Space / Z | A (btn 0) | action |
| dash | X | B (btn 1) | action |
| roll | Ctrl / C | RB (btn 5) | action |
| crouch | Shift (hold) | LT (axis 4) | action |
| interact | E / F | X (btn 3) | action |
| attack | LMB / J | RT (btn 7) | action |
| aim | RMB / K | LB (btn 4) | action |
| pause | Esc / P | Start (btn 6) | action |
| time_dagger | Q / V | Select (btn 8) | action |

> ⚠️ `dash` и `crouch` НЕ должны конфликтовать. `dash` — X/B, `crouch` — Shift/LT. Left Shift только у crouch.

## AutoLoad Order (строго)
1. GameState
2. SaveManager
3. ProgressionManager
4. InputManager
5. AudioManager
6. TimeManager
7. DialogueManager
8. UIManager
9. LevelManager

## Placeholder Assets (assets/art/placeholder/)
| Файл | Размер | Hex | Назначение |
|------|--------|-----|------------|
| player.png | 32×32 | #00FF00 | Кай |
| enemy.png | 32×32 | #FF0000 | Враги |
| npc.png | 32×32 | #0000FF | NPC |
| wall.png | 32×32 | #808080 | Стены |
| ground.png | 32×32 | #8B4513 | Земля |
| collectible.png | 32×32 | #FFD700 | Предметы |
| ui_panel.png | 64×64 | #333333 | UI фон |
| transition.png | 640×360 | #000000 | Переходы |
| boss.png | 48×48 | #800080 | Боссы |
| icon.png | 128×128 | #00FF00 | Иконка |

## Files to Create
- `project.godot` (renderer=gl_compatibility, stretch integer)
- `.gitignore`
- `systems/autoload/*.gd` (9 штук, **extends Node**, пустые _ready/_process, **НЕТ class_name**)
- `systems/components/*.gd` (3 штуки, **class_name** + extends Node/Area2D)
- `tools/generate_placeholders.gd` (EditorScript, DirAccess.make_dir_recursive)
- `scenes/hub.tscn` (Camera2D at 320,180; ColorRect 640×360)
- `scenes/test_movement.tscn` (пустая, наполняется в CP-1)

## Rules
1. AutoLoad scripts: `extends Node` only — **NO `class_name`**.
2. Non-AutoLoad scripts: `class_name` + `extends` — OK.
3. All file names in `snake_case`.
4. No logic in AutoLoads — only skeletons.
5. No `Engine.time_scale` anywhere.

## Pitfalls
- НЕ Mobile renderer
- НЕ забыть stretch/scale_mode="integer"
- НЕ писать логику в AutoLoads — только каркасы
- НЕ забыть добавить AutoLoad в Project Settings
- **НЕ использовать `class_name` в AutoLoad скриптах** — Godot throws "Class X hides an autoload singleton"
- `generate_placeholders.gd` должен создавать директорию через `DirAccess.make_dir_recursive_absolute()` перед `save_png()`
- `ColorRect` в Node2D-сцене не использует anchors — задавать `offset_right/bottom` явно
- Инструментальные скрипты (`@tool`) хранить в `tools/`, не в корне
- Camera2D в hub.tscn: position = Vector2(320, 180) чтобы центрировать на ColorRect

## Checklist
- [ ] Godot 4.6.3 открывает проект без ошибок импорта
- [ ] 640×360, integer scale, NEAREST filter
- [ ] 12 collision layers именованы
- [ ] 13 InputMap actions настроены (KB + gamepad), без конфликтов
- [ ] 9 AutoLoad скриптов созданы, добавлены в Project Settings, **НЕТ class_name**
- [ ] .gitignore в корне, .godot/ игнорируется
- [ ] 10 placeholder PNG созданы и импортированы
- [ ] hub.tscn запускается без ошибок (тёмный экран, Camera2D centered)
- [ ] Нет Engine.time_scale нигде
- [ ] Все имена в snake_case
