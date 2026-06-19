# MOC: 06_Project

Кодовая база Godot 4.6.3. Рабочий проект.

## Структура
```
project.godot
assets/art/placeholder/     — placeholder-спрайты
entities/
  player/                     — Кай (CharacterBody2D)
  enemies/                    — базовый враг
systems/
  autoload/                   — 9 синглтонов
  components/                 — Health, Hitbox, Hurtbox
scenes/                       — hub, zone_1, test_movement
ui/hud/                       — HUD (сердца, энергия, патроны)
resources/themes/             — default_theme.tres
```

## Ключевые файлы
- [[project.godot]] — настройки движка
- [[player.gd]] — логика игрока
- [[player.tscn]] — сцена игрока
- [[enemy_base.gd]] — базовый AI врага
- [[game_state.gd]] — глобальное состояние
- [[save_manager.gd]] — JSON-сохранения
- [[time_manager.gd]] — кастомное замедление времени
- [[hud.gd]] / [[hud.tscn]] — интерфейс

## Связанные разделы
- [[MOC_03_Architecture]] — архитектурные описания
- [[MOC_05_Production]] — CP, к которым относится код
- [[AutoLoad_Index]] — описание синглтонов
- [[Entities_Index]] — описание сущностей
