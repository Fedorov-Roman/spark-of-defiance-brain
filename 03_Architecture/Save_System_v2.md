# Save System v2

## Format: JSON
Path: `user://save.json`

## Structure
```json
{
  "version": 1,
  "timestamp": 1234567890,
  "progression": {
    "npcs": {"uno": true, "liara": false},
    "abilities": {"air_dash": true, "time_dagger": false},
    "data_drives": 12,
    "hub_upgrades": {"workshop": true}
  },
  "player": {
    "max_hp": 3,
    "current_hp": 2,
    "ammo": 4,
    "gadgets": {"emp": 2, "smoke": 1, "decoy": 1},
    "energy": 80,
    "position": {"zone": "zone_1", "x": 1200, "y": 800}
  },
  "zones": {
    "zone_1": {
      "visited": true,
      "enemies_defeated": ["e_01", "e_02"],
      "doors_open": ["d_01"],
      "items_collected": ["drive_01", "drive_02"],
      "landing_pads_found": ["pad_1", "pad_2"]
    }
  }
}
```

## Autosave Triggers
- Checkpoint touched
- NPC rescued
- Boss defeated
- Zone exit (before loading screen)
- Manual save (pause menu)

## Fallback
If JSON corrupt or version mismatch: start new game with warning.
