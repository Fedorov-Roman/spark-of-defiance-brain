class_name GameState extends Node

## Глобальное состояние (сериализуется в JSON)
var player_hp: int = 3
var player_ammo: int = 5
var player_energy: int = 100
var current_zone: String = "hub"
var checkpoint_position: Vector2 = Vector2.ZERO

## Сигналы
signal hp_changed(new_hp: int)
signal ammo_changed(new_ammo: int)
signal energy_changed(new_energy: int)

func _ready() -> void:
    # TODO Builder: в _ready вызвать SaveManager.load_game(). Если false — начать новую игру (reset()). Подписаться на сигналы hp_changed, ammo_changed
    pass

func reset() -> void:
    player_hp = 3
    player_ammo = 5
    player_energy = 100
    current_zone = "hub"
