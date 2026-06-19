class_name HurtboxComponent extends Area2D
signal took_damage(amount: int)
@export var health: HealthComponent
func take_damage(a: int) -> void:
    if health: health.damage(a)
    took_damage.emit(a)
