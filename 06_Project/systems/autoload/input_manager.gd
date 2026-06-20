extends Node

signal input_device_changed(device_type: String)

var _current_device: String = "gamepad"

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
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
	return Vector2.RIGHT
