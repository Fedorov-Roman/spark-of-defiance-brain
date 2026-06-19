class_name InputManager extends Node

## Unified input abstraction for gamepad + keyboard/mouse.

signal input_device_changed(device_type: String)

var _current_device: String = "gamepad"
var _mouse_movement: Vector2 = Vector2.ZERO

func _ready() -> void:
    Input.joy_connection_changed.connect(_on_joy_connection_changed)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion or event is InputEventKey:
        if _current_device != "keyboard":
            _current_device = "keyboard"
            input_device_changed.emit(_current_device)
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
        if _current_device != "gamepad":
            _current_device = "gamepad"
            input_device_changed.emit(_current_device)

func _on_joy_connection_changed(_device: int, _connected: bool) -> void:
    pass

func is_action_pressed(action: String) -> bool:
    return Input.is_action_pressed(action)

func is_action_just_pressed(action: String) -> bool:
    return Input.is_action_just_pressed(action)

func is_action_just_released(action: String) -> bool:
    return Input.is_action_just_released(action)

func get_vector(negative_x: String, positive_x: String, negative_y: String, positive_y: String) -> Vector2:
    return Input.get_vector(negative_x, positive_x, negative_y, positive_y)

func get_aim_direction() -> Vector2:
    if _current_device == "keyboard":
        var mouse_pos := get_viewport().get_mouse_position()
        var player_pos := get_viewport().get_camera_2d().global_position if get_viewport().get_camera_2d() else Vector2.ZERO
        return (mouse_pos - player_pos).normalized()
    else:
        return Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
