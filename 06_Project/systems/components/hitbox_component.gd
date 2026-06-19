class_name HitboxComponent extends Area2D
signal hit
@export var damage: int = 1
func _ready() -> void: area_entered.connect(_on_area_entered)
func _on_area_entered(area: Area2D) -> void:
    if area is HurtboxComponent: area.take_damage(damage); hit.emit()
