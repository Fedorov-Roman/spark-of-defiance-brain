# CP-4: Weapons
## Goal
Sniper, knife, EMP, smoke, decoy. Health. Pickups.
## Checklist
- [ ] Sniper: RayCast2D, paralyze 10s, 5 ammo max, reload 1.5s
- [ ] Knife: instant kill from back, 1 damage front + knockback
- [ ] EMP: arc throw, disable drones 10s, radius 150px
- [ ] Smoke: radius 100px, 8s, blocks vision
- [ ] Decoy: rock throw, noise 100px 2s, infinite
- [ ] Health: 3 hearts, medkit +1, invulnerability 1s
## Files
- `entities/weapons/sniper.gd`
- `entities/weapons/knife.gd`
- `entities/weapons/emp.gd`
- `entities/weapons/smoke.gd`
- `entities/weapons/decoy.gd`
- `systems/components/health_component.gd`
## Class: Sniper
```gdscript
class_name Sniper extends Node2D
@export var max_ammo: int = 5
var ammo: int = 5
var is_aiming: bool = false
func aim(direction: Vector2) -> void: is_aiming = true
func fire() -> void:
    if ammo <= 0: return
    ammo -= 1
    var space := get_world_2d().direct_space_state
    var query := PhysicsRayQueryParameters2D.create(global_position, global_position + direction * 640, 6) # layer 6 = enemies
    var result := space.intersect_ray(query)
    if result: result.collider.get_node("HealthComponent").paralyze(10.0)
func reload() -> void: pass # 1.5s timer
```
## Rules
1. Sniper is hitscan (instant), not projectile.
2. Knife uses `Area2D` overlap + angle check (back = dot < -0.5).
3. EMP arc: quadratic bezier preview, collision on landing.
## Pitfalls
- Don't use `get_node()` every frame; cache in `@onready`.

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_03_Architecture]]
- [[Master_Plan_v2]]
- [[CP_Template]]
