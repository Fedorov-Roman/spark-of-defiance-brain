class_name UIManager extends Node

## Управление UI-экранами
enum Screen { HUD, PAUSE, MAP, INVENTORY, DIALOGUE, LOADING }
var current_screen: Screen = Screen.HUD

func show_screen(screen: Screen) -> void:
    # TODO Builder: для каждого Screen: get_node(screen_name).visible = true/false. При показе PAUSE: Engine.time_scale = 0 (кроме UI)
    pass

func show_loading_screen(lore_text: String) -> void:
    # TODO Builder: Label.text = lore_text, Tween на progress bar (0→100 за 2с), затем fade out
    pass
