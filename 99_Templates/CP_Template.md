# ТЗ — CP-N: [Название]

## Цель
[1-2 предложения. Что будет работать после этого CP?]

## Критерий готовности (чеклист для Романа)
- [ ] пункт 1 — конкретное действие пользователя и ожидаемый результат
- [ ] пункт 2

## Файлы и сцены
### Создать
- `путь/файл.tscn` — назначение, корневой тип ноды
- `путь/файл.gd` — скрипт, какой класс расширяет (extends)
### Модифицировать
- `путь/файл.gd` — что именно меняется
### Ресурсы
- `путь/файл.tres` — какой тип ресурса

## Спецификация нод и сцен
### Сцена: `scene_name.tscn`
- Корень: `Node2D` (или Control / CharacterBody2D)
- Дочерние ноды:
  - `Sprite2D` / `AnimatedSprite2D` — спрайт
  - `CollisionShape2D` — коллизия
  - `Camera2D` — камера
- Скрипт: `script.gd` (extends ...)
- Сигналы: `signal_name` → куда подключен

### Класс: `ClassName` (extends ...)
```gdscript
class_name ClassName extends Node2D

## @export переменные
@export var speed: float = 10.0

## @onready переменные
@onready var sprite: Sprite2D = $Sprite2D

## Сигналы
signal completed(value: int)

## Переменные состояния
var _is_active: bool = false

func _ready() -> void:
    pass  # Builder реализует

func _process(delta: float) -> void:
    pass  # Builder реализует

func _physics_process(delta: float) -> void:
    pass  # Builder реализует
```

## Правила реализации
1. Правило 1 — конкретное ограничение
2. Правило 2

## Подводные камни (Godot-специфичные)
- [Описание типичной ошибки и как её избежать]
- [Например: "Не используй _process для физики"]
