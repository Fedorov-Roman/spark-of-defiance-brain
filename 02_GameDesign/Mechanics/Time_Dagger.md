# ⏳ Time Dagger (Кинжал Времени)

> **Решение:** Гибрид. Мир замедляется до 30%, Кай движется на 100%.  
> **Визуал:** Полноэкранный синий шейдер.  
> **Godot:** НЕ `Engine.time_scale`. Кастомная группа `"time_affected"`.

## 1. Почему не Engine.time_scale?

`Engine.time_scale = 0.3` замедлит:
- UI (таймеры, анимации интерфейса)
- Анимации Кая (если он двигается)
- Частицы и звук
- `_process` и `_physics_process` глобально

**Решение:** Собственная система модификации `delta`.

## 2. Архитектура

### 2.1 Группа "time_affected"

Все враги, ловушки, двери, пули, частицы, анимации окружения — в группе `"time_affected"`.

```gdscript
# В _ready() каждого врага/ловушки:
add_to_group("time_affected")
```

### 2.2 TimeManager (AutoLoad)

```gdscript
# time_manager.gd
extends Node

var time_scale: float = 1.0  # 1.0 = норма, 0.3 = замедление
var is_slowed: bool = false
var energy: float = 100.0
var max_energy: float = 100.0
var drain_rate: float = 33.33  # ~3 секунды на полный расход

signal time_slow_started
signal time_slow_ended
signal energy_changed(new_value: float)

func activate() -> void:
    if energy <= 0: return
    is_slowed = true
    time_scale = 0.3
    time_slow_started.emit()

func deactivate() -> void:
    is_slowed = false
    time_scale = 1.0
    time_slow_ended.emit()

func _process(delta: float) -> void:
    if is_slowed:
        energy -= drain_rate * delta
        if energy <= 0:
            energy = 0
            deactivate()
        energy_changed.emit(energy)
```

### 2.3 Модификация delta

Каждый объект в группе `"time_affected"` использует `TimeManager.time_scale` в `_process` и `_physics_process`:

```gdscript
# enemy.gd
func _physics_process(delta: float) -> void:
    var effective_delta = delta * TimeManager.time_scale
    # Движение, анимация, AI — используют effective_delta
    velocity = ...
    move_and_slide()
    # Но position обновляется через velocity, который уже масштабирован?
    # ИЛИ:
    position += velocity * effective_delta
```

**Важно:** `move_and_slide()` внутри использует `delta` из `_physics_process`. Если мы масштабируем `velocity` перед `move_and_slide()`, физика работает корректно.

```gdscript
func _physics_process(delta: float) -> void:
    var t = TimeManager.time_scale
    velocity.x = move_toward(velocity.x, target_speed * t, acceleration * delta * t)
    velocity.y += gravity * delta * t
    move_and_slide()
```

### 2.4 Анимации

`AnimatedSprite2D` и `AnimationPlayer` тоже нужно замедлять:

```gdscript
# Для AnimatedSprite2D:
animated_sprite.speed_scale = TimeManager.time_scale

# Для AnimationPlayer:
animation_player.speed_scale = TimeManager.time_scale
```

### 2.5 Частицы

`GPUParticles2D` не поддерживает `speed_scale` напрямую. Нужно либо:
- Останавливать/запускать частицы
- Или использовать `process_material.time_scale` (если доступно)
- Или принять, что частицы окружения замедляются визуально через шейдер

## 3. Визуальный эффект

### 3.1 Полноэкранный шейдер

```glsl
// time_slow_shader.gdshader
shader_type canvas_item;

uniform float blue_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float distortion_amount : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    vec2 uv = SCREEN_UV;
    // Лёгкое искажение по краям
    float dist = distance(uv, vec2(0.5));
    uv += (uv - vec2(0.5)) * distortion_amount * dist;

    vec4 color = texture(SCREEN_TEXTURE, uv);
    // Синий фильтр
    color.b = min(1.0, color.b + blue_intensity);
    color.r = max(0.0, color.r - blue_intensity * 0.3);
    color.g = max(0.0, color.g - blue_intensity * 0.2);

    COLOR = color;
}
```

**Применение:** `ColorRect` на `CanvasLayer` (поверх всего, кроме UI) с материалом `ShaderMaterial`.

### 3.2 UI не затрагивается

`CanvasLayer` UI имеет `layer` выше, чем шейдер. Или шейдер применяется только к `World` `CanvasLayer`, а UI — отдельный `CanvasLayer`.

## 4. Энергия и перезарядка

- **Максимум:** 100 единиц.
- **Расход:** ~33.33/сек (3 секунды полного замедления).
- **Перезарядка:** В хабе (полная), или редкие батареи на уровнях (+25-50).
- **UI:** Полоса энергии (HUD), синяя, под HP.

## 5. "Эхо" (от Хрономанта Элии)

- **Эффект:** Невидимость на 1.5 секунды после рывка.
- **Реализация:** `modulate.a = 0.3` + `collision_layer` отключение для врагов.
- **Визуал:** Остаточный синий след (trail) за Каем.

---

*Кинжал Времени — уникальная механика. Требует точной синхронизации всех систем.*
