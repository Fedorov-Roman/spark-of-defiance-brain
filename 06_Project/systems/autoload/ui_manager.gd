class_name UIManager extends Node
var hud: Control = null
func _ready() -> void:
    if ResourceLoader.exists("res://ui/hud/hud.tscn"):
        hud = load("res://ui/hud/hud.tscn").instantiate(); add_child(hud)
func update_health(c: int, m: int) -> void: if hud: hud.update_health(c, m)
