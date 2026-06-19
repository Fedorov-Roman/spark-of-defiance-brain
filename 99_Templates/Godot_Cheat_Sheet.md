# Godot Cheat Sheet

Быстрые ссылки для Builder'а.

## Жизненный цикл
```gdscript
_enter_tree()     # Нода добавлена в дерево
_ready()          # Все дети готовы, @onready инициализированы
_process(delta)   # Каждый кадр (UI, анимации, ввод)
_physics_process(delta) # Физический тик (60 Гц, движение)
_input(event)     # Глобальный ввод
_unhandled_input(event) # Ввод, не обработанный другими
_exit_tree()      # Нода удаляется (cleanup)
```

## Типизация
```gdscript
func move(speed: float, dir: Vector2) -> Vector2:
    return dir * speed
var count: int = 0
var active: bool = false
```

## Ноды
```gdscript
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
```

## Сигналы
```gdscript
signal health_changed(new_hp: int)
# emit
health_changed.emit(50)
# connect (в _ready)
player.health_changed.connect(_on_player_health_changed)
# disconnect (в _exit_tree)
player.health_changed.disconnect(_on_player_health_changed)
```

## Tween
```gdscript
var tween := create_tween()
tween.tween_property(node, "position", target_pos, 1.0)
tween.set_ease(Tween.EASE_OUT)
tween.set_trans(Tween.TRANS_QUAD)
```

## Физика 2D
```gdscript
# CharacterBody2D
velocity.y += gravity * delta
velocity.x = direction * speed
move_and_slide()

# Проверки
is_on_floor()
is_on_wall()
is_on_ceiling()
```

## TileMapLayer (Godot 4.6)
```gdscript
var layer: TileMapLayer = $TileMapLayer
layer.set_cell(pos, atlas_coords)
layer.get_cell_atlas_coords(pos)
```

## AutoLoad
```gdscript
# Доступ из любой сцены
GameState.player_hp
SaveManager.save_game()
```

## Группы
```gdscript
# Добавить
add_to_group("time_affected")
# Обход
for node in get_tree().get_nodes_in_group("time_affected"):
    node.process_custom(delta * 0.3)
```

## Сохранение JSON
```gdscript
var file := FileAccess.open("user://save.json", FileAccess.WRITE)
file.store_string(JSON.stringify(data))
file.close()
```

## Связанные файлы
- [[Builder_Onboarding]] — полная инструкция для Builder'а
- [[Godot_State_Machine_Pattern]] — паттерн State Machine
- [[Godot_Performance_Guide]] — оптимизация
