# 🦎 Enemy: Silicon Beast (Кремневая Тварь)

> **Класс Godot:** `CharacterBody2D`  
> **Группа:** `"enemies"`, `"time_affected"`  
> **HP:** 3 (только ножом, много ударов)  

## Визуал
- Шестиногое существо, покрытое кремниевой чешуёй.
- Алмазные резцы, сверкают на свету.
- Без глаз (слепое).

## AI Behavior

### State: WANDER
- Случайное блуждание в радиусе 100 px от точки спавна.
- Скорость: 40 px/sec.
- Останавливается на 2-3 сек, "нюхает" (анимация).

### State: HUNT
- Реакция на ЛЮБОЙ звук (шаги, выстрелы, приманки, взрывы).
- Бег к источнику шума (скорость 100 px/sec).
- Если нашёл Кая → атака (быстрый выпад, 1 урон).
- Если шум исчез → 5 сек поиска → WANDER.

### State: ATTACK
- Выпад вперёд на 60 px.
- Если промахнулся — 1.5 сек recovery.
- Уязвимо во время recovery (можно убить со спины).

## Особенности
- **Слепое:** Не реагирует на зрение, только на шум.
- **Глухое к дыму:** Дым не влияет на слух.
- **Устойчиво к снайперке:** Паралич длится 3 сек вместо 10.

## Godot Specification

```gdscript
class_name SiliconBeast extends CharacterBody2D

enum State { WANDER, HUNT, ATTACK, RECOVERY }

@export var wander_speed: float = 40.0
@export var hunt_speed: float = 100.0
@export var attack_range: float = 60.0
@export var hearing_radius: float = 120.0
@export var recovery_time: float = 1.5

@onready var noise_area: Area2D = $NoiseDetectionArea

func _ready() -> void:
    add_to_group("enemies")
    add_to_group("time_affected")
    noise_area.body_entered.connect(_on_noise_detected)

func _on_noise_detected(body: Node2D) -> void:
    if body.is_in_group("noise_sources") or body.is_in_group("player"):
        _transition_to(State.HUNT)
```

---

*Кремневая Тварь — звуковой охотник. Требует тишины или приманки.*
