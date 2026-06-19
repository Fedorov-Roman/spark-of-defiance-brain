# CP-6: Enemies
## Goal
4 enemy types with State Machine: Drone, Guard, Silicon Beast, Elite Sniper.
## Checklist
- [ ] Drone: flying, waypoints, 90° cone, 100px range
- [ ] Guard: ground patrol, 90° cone, 120px, melee 1 heart
- [ ] Silicon Beast: blind, sound-reactive 120px, rush, 3 HP
- [ ] Elite Sniper: static, 60° narrow cone 200px, laser lock 1s
- [ ] All use StateMachine (Idle/Suspicious/Alert)
- [ ] Body discovery: enemy sees body → instant Alert
## Files
- `entities/enemies/drone_eye.tscn`, `drone_eye.gd`
- `entities/enemies/guard_sun.tscn`, `guard_sun.gd`
- `entities/enemies/silicon_beast.tscn`, `silicon_beast.gd`
- `entities/enemies/elite_sniper.tscn`, `elite_sniper.gd`
- `systems/components/vision_cone.gd`
- `systems/components/noise_listener.gd`
## Class: EnemyStateMachine
```gdscript
class_name EnemyStateMachine extends StateMachine
enum StateName { IDLE, SUSPICIOUS, ALERT }
var alert_timer: float = 0.0
var suspicion: float = 0.0
func _physics_process(delta: float) -> void:
    var eff_delta := TimeManager.get_delta(delta) if is_in_group("time_affected") else delta
    super._physics_process(eff_delta)
```
## Rules
1. Vision cone: `Polygon2D` + `RayCast2D` array (12 rays) for occlusion.
2. Noise: `Area2D` entered → signal to `noise_listener`.
3. Alert decay: 30s timer, returns to Idle if Kai lost.
## Pitfalls
- Don't raycast every frame for all enemies; stagger via `hash(instance_id) % 3`.

---

## Связанные разделы

- [[CP_Index]]
- [[MOC_03_Architecture]]
- [[Master_Plan_v2]]
- [[CP_Template]]
