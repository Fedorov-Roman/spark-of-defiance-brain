# State Machine Pattern
```gdscript
class_name StateMachine extends Node
signal state_changed(new: String)
var current: State = null
func transition(to: String) -> void:
    if current: current.exit()
    current = get_node_or_null(to)
    if current: current.enter()
    emit_signal("state_changed", to)
func _physics_process(delta: float) -> void:
    if current: current.physics_update(delta)
func _process(delta: float) -> void:
    if current: current.update(delta)

class_name State extends Node:
func enter() -> void: pass
func exit() -> void: pass
func update(delta: float) -> void: pass
func physics_update(delta: float) -> void: pass
```
