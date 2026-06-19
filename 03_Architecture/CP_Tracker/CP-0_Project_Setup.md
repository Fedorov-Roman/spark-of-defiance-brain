

---

## Additional Notes (Brain 2)

# CP-0: Project Setup

## Goal
Create runnable Godot 4.6.3 project with correct structure, InputMap, placeholders, and AutoLoad skeletons.

## Checklist for Roman
- [ ] Open Godot 4.6.3 → New Project → `spark-of-defiance`
- [ ] Set viewport: 640×360, stretch canvas_items, filter NEAREST
- [ ] Create folder structure (see [[Project_Structure_v2]])
- [ ] Set collision layers (1-12) with names
- [ ] Create InputMap actions (see [[Input_Map]])
- [ ] Create 9 AutoLoad scripts (empty, extends Node, class_name)
- [ ] Placeholder sprites: 32×32 colored rects (player=green, enemy=red, npc=blue, wall=gray)
- [ ] `.gitignore` committed
- [ ] Project runs without errors (black screen is OK)

## Files to Create
- `project.godot`
- `.gitignore`
- `systems/autoload/game_state.gd`
- `systems/autoload/save_manager.gd`
- `systems/autoload/progression_manager.gd`
- `systems/autoload/input_manager.gd`
- `systems/autoload/dialogue_manager.gd`
- `systems/autoload/audio_manager.gd`
- `systems/autoload/time_manager.gd`
- `systems/autoload/ui_manager.gd`
- `systems/autoload/level_manager.gd`
- `assets/art/placeholder/player.png` (32×32 green)
- `assets/art/placeholder/enemy.png` (32×32 red)
- `assets/art/placeholder/wall.png` (32×32 gray)
- `assets/art/placeholder/npc.png` (32×32 blue)

## Rules
1. All scripts have `class_name` and `extends Node`.
2. All AutoLoad scripts have empty `_ready()` and `_process(delta)`.
3. No logic yet — only structure.
4. Use `snake_case` for file names.

## Pitfalls
- Do NOT forget to add AutoLoad in Project Settings.
- Do NOT set `Engine.time_scale` anywhere yet.
- Do NOT create complex scenes — placeholders only.

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_05_Production]]
- [[Master_Plan_v2]]
- [[CP_Template]]
