class_name HUD extends CanvasLayer

## Минималистичный HUD (Answers Bible: сердца, патроны, энергия, иконки)
@onready var hearts_container: HBoxContainer = $HeartsContainer
@onready var ammo_label: Label = $AmmoLabel
@onready var energy_bar: TextureProgressBar = $EnergyBar

func update_hp(hp: int, max_hp: int) -> void:
    # TODO Builder: очистить HBoxContainer, добавить TextureRect с heart_full/heart_empty для каждого HP
    pass

func update_ammo(ammo: int, max_ammo: int = 5) -> void:
    # TODO Builder: ammo_label.text = str(ammo) + "/5"
    pass

func update_energy(energy: int, max_energy: int = 100) -> void:
    # TODO Builder: energy_bar.value = energy (0-100). Цвет: зелёный (>60), жёлтый (30-60), красный (<30)
    pass
