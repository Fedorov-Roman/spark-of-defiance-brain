class_name InputManager extends Node
enum Device { GAMEPAD, KEYBOARD_MOUSE }
var active_device: Device = Device.GAMEPAD
func _ready() -> void: _setup_actions()
func _setup_actions() -> void:
    _add("move_left", KEY_A, JOY_AXIS_LEFT_X, -1.0); _add("move_right", KEY_D, JOY_AXIS_LEFT_X, 1.0)
    _add("move_up", KEY_W, JOY_AXIS_LEFT_Y, -1.0); _add("move_down", KEY_S, JOY_AXIS_LEFT_Y, 1.0)
    _add("jump", KEY_SPACE, -1, 0.0, JOY_BUTTON_A); _add("dash", KEY_SHIFT, -1, 0.0, JOY_BUTTON_B)
    _add("crouch", KEY_CTRL, -1, 0.0, JOY_BUTTON_LEFT_STICK); _add("roll", KEY_R, -1, 0.0, JOY_BUTTON_RIGHT_SHOULDER)
    _add("interact", KEY_E, -1, 0.0, JOY_BUTTON_X); _add("time_dagger", KEY_Q, -1, 0.0, JOY_BUTTON_DPAD_LEFT)
func _add(n: String, k: int, ax: int, av: float, jb: int = -1) -> void:
    if InputMap.has_action(n): return
    InputMap.add_action(n)
    if k != KEY_NONE: var e := InputEventKey.new(); e.keycode = k; InputMap.action_add_event(n, e)
    if jb >= 0: var b := InputEventJoypadButton.new(); b.button_index = jb; InputMap.action_add_event(n, b)
    if ax >= 0: var m := InputEventJoypadMotion.new(); m.axis = ax; m.axis_value = av; InputMap.action_add_event(n, m)
func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and event.relative.length() > 2.0: active_device = Device.KEYBOARD_MOUSE
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion: active_device = Device.GAMEPAD
