class_name EnemyBase extends CharacterBody2D
enum State { IDLE, SUSPICIOUS, ALERT }
var state: State = State.IDLE
var alert_timer: float = 0.0
var suspicion: float = 0.0
@onready var health: HealthComponent = $HealthComponent
func _physics_process(delta: float) -> void:
    var eff_delta := TimeManager.get_delta(delta) if is_in_group("time_affected") else delta
    _update_ai(eff_delta)
    move_and_slide()
func _update_ai(delta: float) -> void: pass # override
func take_damage(a: int) -> void: health.damage(a)
func paralyze(d: float) -> void: pass # override
