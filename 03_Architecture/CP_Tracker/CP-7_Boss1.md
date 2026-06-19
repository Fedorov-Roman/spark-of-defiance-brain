# CP-7: Boss 1 (Sand Leviathan)
## Goal
Arena, 3 phases, steam valve mechanic, checkpoint.
## Checklist
- [ ] Arena 40×40 tiles, separate scene
- [ ] Phase 1: burrow → emerge → bite (2 hearts), dodge with dash
- [ ] Phase 2: sand waves (jump over)
- [ ] Phase 3: shoot 4 steam valves → stun 3s → weak point exposed
- [ ] 3 stuns required to kill
- [ ] Checkpoint right before arena
## Files
- `scenes/bosses/sand_leviathan.tscn`
- `entities/bosses/sand_leviathan.gd`
- `entities/bosses/steam_valve.gd`
## Class: SandLeviathan
```gdscript
class_name SandLeviathan extends CharacterBody2D
enum Phase { BURROW, SURFACE, STUNNED }
var phase: Phase = Phase.BURROW
var stun_count: int = 0
const MAX_STUNS: int = 3
func take_stun() -> void:
    phase = Phase.STUNNED; stun_count += 1
    if stun_count >= MAX_STUNS: die()
    else: await get_tree().create_timer(3.0).timeout; phase = Phase.BURROW
```
## Rules
1. Boss is NOT in "time_affected" group (too complex with phases).
2. Steam valves: `StaticBody2D` with `hurtbox`, react to sniper/knife.
3. Arena camera: limits, no parallax.
## Pitfalls
- Boss HP != stun count; use stun mechanic, not damage.
- Avoid `move_and_slide` for burrow (use position lerp + animation).

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_03_Architecture]]
- [[Master_Plan_v2]]
- [[CP_Template]]
