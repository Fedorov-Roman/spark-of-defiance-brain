# MOC: 06_Project

ACTUAL GODOT PROJECT FILES. This is not documentation — these are the real `.gd`, `.tscn`, and `.godot` files that run in Godot 4.6.3.

## Structure

- `project.godot` — Project settings, rendering, input map, layers
- `.gitignore` — Git ignore rules for Godot 4
- `README.md` — How to open this project in Godot
- `entities/` — Player, enemies, NPCs
- `systems/` — AutoLoad singletons, state machine
- `scenes/` — Hub, zones, test scenes
- `ui/` — HUD, menus
- `assets/` — Placeholder art, concept art
- `dialogues/` — JSON dialogue files

## Key Files

- [[player_gd]] — `entities/player/player.gd` (working CharacterBody2D with State Machine)
- [[save_manager_gd]] — `systems/autoload/save_manager.gd` (JSON save/load)
- [[progression_manager_gd]] — `systems/autoload/progression_manager.gd` (NPC flags)
- [[project_godot]] — `project.godot` (configured for 4.6.3)

## Up

[[Start_Here]]
