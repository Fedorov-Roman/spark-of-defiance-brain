# Godot Architecture v2

## Scene Tree Philosophy
Everything is a scene. Player, enemy, NPC, UI panel, zone, hub — all `.tscn`.

## Core Scene Types
- **Level:** `Node2D` root → `TileMapLayer`(s) + `Entities` container + `UI` CanvasLayer
- **Entity:** `CharacterBody2D` root → `Sprite` + `Collision` + `Logic` scripts
- **UI:** `Control` root → containers + theme
- **Manager:** `Node` root (AutoLoad)

## AutoLoad (Singletons) — 9 total
1. **GameState** (`[[game_state.gd]]`) — session data, current zone, flags
2. **SaveManager** (`[[save_manager.gd]]`) — JSON save/load, autosave
3. **ProgressionManager** (`[[progression_manager.gd]]`) — NPCs, abilities, Data Drives, hub state
4. **InputManager** (`input_manager.gd`) — dual input detection, action mapping, device switching
5. **DialogueManager** (`dialogue_manager.gd`) — text boxes, portraits, typewriter, skipping
6. **AudioManager** (`audio_manager.gd`) — music states, crossfade, SFX, buses
7. **TimeManager** (`[[time_manager.gd]]`) — hybrid time scale, shader control, energy
8. **UIManager** (`ui_manager.gd`) — HUD, minimap, inventory, pause, menus
9. **LevelManager** (`level_manager.gd`) — zone transitions, loading screen, spawn points

## Folder Structure (res://)
```
assets/
  art/
    placeholder/          # colored rects 32x32
    leonardo/           # concept PNGs
    final/              # pixel-art spritesheets
  audio/
    music/
    sfx/
    ambient/
  fonts/
    m5x7.ttf
entities/
  player/
    [[player.gd]]
    player.tscn
  enemies/
    drone_eye.gd
    drone_eye.tscn
    guard_sun.gd
    guard_sun.tscn
    silicon_beast.gd
    silicon_beast.tscn
    elite_sniper.gd
    elite_sniper.tscn
  npc/
    uno.gd
    uno.tscn
    # ... etc
scenes/
  zones/
    zone_1.tscn
    zone_2.tscn
    zone_3.tscn
  hub/
    hub.tscn
  ui/
    hud.tscn
    pause_menu.tscn
    map_screen.tscn
    dialogue_box.tscn
systems/
  autoload/
    # 9 singletons listed above
  components/
    health_component.gd
    hitbox_component.gd
    hurtbox_component.gd
    vision_cone.gd
    noise_emitter.gd
resources/
  themes/
    default_theme.tres
  materials/
    time_dagger_shader.tres
  tilesets/
    zone_1_tiles.tres
```

## Collision Layers & Masks
| Layer | Name | Used by |
|-------|------|---------|
| 1 | World | TileMap, static geometry |
| 2 | Player | Kai |
| 3 | Enemies | All foes |
| 4 | NPCs | Hub characters |
| 5 | Interactables | Doors, terminals, items |
| 6 | Projectiles | Sniper rounds, grenades |
| 7 | Traps | Lasers, spikes |
| 8 | GrapplePoints | Anchor points |
| 9 | HideZones | Tall grass |
| 10 | SoundEmitters | Noise sources |
| 11 | LightOccluders | Wall shadows |
| 12 | Checkpoints | Save points |

## Signals (Decoupling)
- `health_changed(current, max)` — HealthComponent
- `died()` — HealthComponent
- `state_changed(new_state)` — EnemyStateMachine
- `noise_emitted(position, radius)` — NoiseEmitter
- `time_dagger_activated(duration)` — TimeManager
- `npc_rescued(npc_id)` — ProgressionManager
- `zone_entered(zone_name)` — LevelManager
- `dialogue_started(text, portrait)` — DialogueManager

## Groups
- `"time_affected"` — enemies, traps, doors, projectiles (custom delta)
- `"enemies"` — all foes (for mass commands)
- `"hide_zones"` — tall grass areas
- `"grapple_points"` — anchor points
- `"saveables"` — objects that serialize state

---

## Связанные разделы

- [[MOC_03_Architecture]]
- [[AutoLoad_Singletons_v2]]
- [[Project_Structure_v2]]
- [[Component_Pattern]]
