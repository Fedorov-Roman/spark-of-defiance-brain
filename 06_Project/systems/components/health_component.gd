class_name HealthComponent extends Node

signal changed(current: int, maximum: int)
signal died

@export var max_hp: int = 3
var current: int = 3

func damage(a: int) -> void:
	pass

func heal(a: int) -> void:
	pass

func serialize() -> Dictionary:
	return {}

func deserialize(d: Dictionary) -> void:
	pass
