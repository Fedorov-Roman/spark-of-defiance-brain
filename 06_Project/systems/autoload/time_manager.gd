extends Node

signal started(duration: float)
signal ended

var is_active: bool = false
var energy: float = 100.0
const MAX_ENERGY: float = 100.0
const COST: float = 40.0
const DURATION: float = 2.5
const RECHARGE: float = 5.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not is_active and energy < MAX_ENERGY:
		energy = min(MAX_ENERGY, energy + RECHARGE * delta)

func activate() -> void:
	pass

func get_delta(d: float) -> float:
	return d * 0.3 if is_active else d
