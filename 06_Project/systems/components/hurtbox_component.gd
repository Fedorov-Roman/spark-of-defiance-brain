class_name HurtboxComponent extends Area2D

## Зона, которая ПОЛУЧАЕТ урон
signal damage_taken(amount: int)

@export var health_component: HealthComponent

func take_damage(amount: int) -> void:
    damage_taken.emit(amount)
    if health_component:
        health_component.take_damage(amount)
