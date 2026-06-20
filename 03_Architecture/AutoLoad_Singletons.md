# AutoLoad Singletons

## Global Managers
| Singleton | File | Purpose |
|-----------|------|---------|
| **GameState** | `game_state.gd` | Current zone, flags, session data |
| **SaveManager** | `save_manager.gd` | JSON save/load, autosaves |
| **ProgressionManager** | `progression_manager.gd` | NPC flags, ability unlocks |
| **TimeManager** | `time_manager.gd` | Custom time dilation |
| **InputManager** | `input_manager.gd` | Input abstraction (gamepad + KB/M) |
| **AudioManager** | `audio_manager.gd` | Dynamic music, SFX, ambient |
| **DialogueManager** | `dialogue_manager.gd` | Text boxes, portraits, JSON parsing |
| **UIManager** | `ui_manager.gd` | HUD, menus overlay |
| **LevelManager** | `level_manager.gd` | Scene transitions, zone loading |

## Initialization Order
1. GameState
2. SaveManager
3. ProgressionManager
4. InputManager
5. AudioManager
6. TimeManager
7. DialogueManager
8. UIManager
9. LevelManager

## CRITICAL RULE
**AutoLoad scripts: `extends Node` only — NO `class_name`.**
Godot 4.x throws "Class X hides an autoload singleton" if `class_name` is used in an AutoLoad script.

`class_name` is allowed ONLY in non-AutoLoad scripts (components, entities, UI).

## Up
[[MOC_03_Architecture]]
