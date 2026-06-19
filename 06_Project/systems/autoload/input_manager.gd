class_name InputManager extends Node

## Двойное управление: геймпад + клавиатура/мышь
## Answers Bible: геймпад + KB/M, стик для снайперки, мышь тоже

func get_movement_vector() -> Vector2:
    # TODO Builder: return Input.get_vector("move_left", "move_right", "move_up", "move_down") — Godot автоматически объединяет KB и pad
    return Vector2.ZERO

func get_aim_direction() -> Vector2:
    # TODO Builder: если Input.get_last_mouse_velocity() > 0: return get_global_mouse_position() - player_pos. Иначе: Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down") * 100
    return Vector2.ZERO

func is_action_just_pressed_action(action: String) -> bool:
    # TODO Builder: return Input.is_action_just_pressed(action) — простой проброс, но централизованно
    return false
