class_name HealthComponent extends Node

signal health_changed(new_hp: int, max_hp: int)
signal died

@export var max_hp: int = 3
var current_hp: int = max_hp

func take_damage(amount: int) -> void:
    current_hp = max(0, current_hp - amount)
    health_changed.emit(current_hp, max_hp)
    if current_hp <= 0:
        died.emit()

func heal(amount: int) -> void:
    current_hp = min(max_hp, current_hp + amount)
    health_changed.emit(current_hp, max_hp)
