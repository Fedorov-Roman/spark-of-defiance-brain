# Save System

## Format

JSON (`user://save.json`). Human-readable, debug-friendly.

## Structure

```json
{
  "version": "1.0",
  "timestamp": "2026-06-20T12:00:00",
  "player": {
    "hp": 3,
    "max_hp": 3,
    "ammo": 3,
    "max_ammo": 5,
    "position": {"x": 120.5, "y": 340.0},
    "zone": "zone_1",
    "checkpoint": "cp_ruins_entrance"
  },
  "progression": {
    "npcs_rescued": ["uno", "liara"],
    "abilities": ["wall_jump", "dash"],
    "data_drives": 12
  },
  "world": {
    "doors_open": ["door_lab_3", "door_boss_1"],
    "chests_open": ["chest_dunes_2"],
    "bosses_defeated": ["leviathan"]
  },
  "settings": {
    "fullscreen": false,
    "music_volume": 0.8,
    "sfx_volume": 1.0
  }
}
```

## Autosave Triggers

- Checkpoint reached
- NPC rescued
- Boss defeated
- Zone transition
- Manual save (if implemented)

## Up

[[MOC_03_Architecture]]
