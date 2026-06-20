# CP-1: Player Movement

## Status
- **State**: 🔄 IN PROGRESS
- **Assigned**: DeepSeek v4 Pro (Builder)
- **Review by**: Kimi (Architect)

## Goal
Кай полноценно перемещается в test_movement.tscn: run, jump (variable height), wall-slide, wall-jump, dash (4-dir), roll, crouch, ledge-grab, ledge-pull-up, grapple-pull.

## Architecture
- `extends CharacterBody2D` (NO `class_name` — Player is instantiated via scene, not autoload)
- State Machine через `match current_state` в `_physics_process`
- Все параметры — `@export` для инспектора

## States
```gdscript
enum State {
    IDLE, RUN, JUMP, FALL, WALL_SLIDE, WALL_JUMP,
    DASH, ROLL, CROUCH, LEDGE_GRAB, LEDGE_PULLUP,
    GRAPPLE_PULL, DEAD
}
```

## @export Parameters
| Параметр | Значение | Описание |
|----------|----------|----------|
| speed | 120.0 | Базовая скорость |
| accel | 800.0 | Ускорение |
| decel | 1000.0 | Замедление |
| gravity | 980.0 | Гравитация |
| jump_velocity | -280.0 | Импульс прыжка |
| wall_slide_speed | 60.0 | Скорость скольжения |
| wall_jump_velocity | (180, -250) | Отскок от стены |
| dash_speed | 300.0 | Скорость рывка |
| dash_duration | 0.15 | Длительность рывка |
| roll_speed | 180.0 | Скорость кувырка |
| roll_duration | 0.4 | Длительность кувырка |
| crouch_speed | 60.0 | Скорость в присядке |
| grapple_speed | 400.0 | Скорость pull |
| grapple_max_distance | 160.0 | Макс дистанция hook |

## Node Setup (player.tscn)
- CharacterBody2D (Player)
  - Sprite2D (texture: player.png)
  - CollisionShape2D (RectangleShape2D 14×28)
  - Hitbox (Area2D, layer=1, mask=2|4|12)
    - CollisionShape2D (14×28)
  - Hurtbox (Area2D, layer=1, mask=2|4|7)
    - CollisionShape2D (14×28)
  - WallCheckLeft (RayCast2D, pos=-8,0, target=-6,0, layer=3)
  - WallCheckRight (RayCast2D, pos=8,0, target=6,0, layer=3)
  - LedgeCheck (RayCast2D, pos=0,-14, target=0,-6, layer=3)
  - LedgeBodyCheck (RayCast2D, pos=0,-4, target=12*facing,0, layer=3)
  - GrappleCast (RayCast2D, pos=0,-8, target=160,0, layer=3|11)
  - Camera2D (smoothing, speed=10)

## State Logic Summary
| State | Ключевая логика | Переходы |
|-------|-----------------|----------|
| IDLE | velocity.x → 0 (decel) | input→RUN, jump→JUMP, crouch→CROUCH, roll→ROLL, dash→DASH |
| RUN | velocity.x → input*speed (accel) | input=0→IDLE, jump→JUMP, crouch→CROUCH, roll→ROLL, dash→DASH |
| JUMP | gravity, variable height (отпускание = *0.5) | vy>0→FALL, wall→WALL_SLIDE, dash→DASH |
| FALL | gravity, ledge check | ground→IDLE/RUN, wall→WALL_SLIDE, dash→DASH, ledge→LEDGE_GRAB |
| WALL_SLIDE | vy = min(vy, 60), facing = wall_normal | jump→WALL_JUMP, отрыв→FALL, ground→IDLE |
| WALL_JUMP | таймер 0.12s, velocity = (180*-facing, -250) | таймер→FALL |
| DASH | таймер 0.15s, velocity = dir*dash_speed, i-frames | таймер→FALL/IDLE. Air dash: can_air_dash=false |
| ROLL | таймер 0.4s, velocity = facing*180, i-frames, collision.scale.y=0.5 | таймер→IDLE (ground only!) |
| CROUCH | velocity = input*60, collision.scale.y=0.5 | !crouch→IDLE/RUN |
| LEDGE_GRAB | velocity=0, позиция привязана к ledge_point | вверх→LEDGE_PULLUP, отпускание→FALL |
| LEDGE_PULLUP | таймер 0.35s, velocity=0 | таймер→IDLE (подтягивание +16px Y) |
| GRAPPLE_PULL | velocity = (point - pos).normalized * 400 | distance<8→IDLE, jump→FALL |

## Ledge Grab Conditions
1. `!is_on_floor() && velocity.y > 0`
2. `LedgeBodyCheck.is_colliding()` (есть тело уступа)
3. `!LedgeCheck.is_colliding()` (свободно над уступом)
4. `input.y <= 0` (не нажат вниз)

Если все true → `ledge_point = ledge_body_check.get_collision_point()` → `LEDGE_GRAB`

## Grapple Conditions
1. `Input.is_action_just_pressed("aim")` и `grapple_cast.is_colliding()`
2. `grapple_point = grapple_cast.get_collision_point()`
3. Если `global_position.distance_to(grapple_point) <= grapple_max_distance` → `GRAPPLE_PULL`

## Time Dagger Integration
- Кай НЕ в группе `"time_affected"`
- TimeManager.get_delta(d) используется только объектами в группе `"time_affected"`
- Кай всегда использует чистый delta

## Rules
1. Только `_physics_process` для движения. НЕТ `_process`.
2. `move_and_slide()` в конце `_physics_process`.
3. Wall-jump отталкивает от стены (`-facing`), не прилипает.
4. Dash direction: если input=0 → dash в `facing` (горизонтально).
5. Roll только на земле (`is_on_floor()`).
6. Crouch: менять `scale.y` CollisionShape2D, не `size`.
7. Air dash сбрасывается только на `is_on_floor()`.
8. State timers через `_state_timer` внутри `_physics_process`, НЕ `get_tree().create_timer`.
9. Строгая типизация: `-> void`, `-> int`, `-> float`, `-> Vector2`, `-> bool`.

## Files
- `entities/player/player.gd`
- `entities/player/player.tscn`
- `scenes/test_movement.tscn` (TileMapLayer floor + walls + spawn)

## Checklist
- [ ] Кай двигается влево/вправо с плавным ускорением/замедлением
- [ ] Прыжок с переменной высотой (отпускание = ниже)
- [ ] Автоматический wall-slide при контакте со стеной во время падения
- [ ] Wall-jump отталкивает от стены диагонально
- [ ] Dash в 4 направлениях (input vector), ground + air
- [ ] Air dash только 1 раз до касания земли
- [ ] Roll с 0.4s i-frames, ground only, хитбокс уменьшается вдвое по Y
- [ ] Crouch: медленнее, хитбокс уменьшается, отпускание = встать
- [ ] Ledge grab: висение на уступе, подтягивание по кнопке вверх
- [ ] Grapple: hook к ближайшей точке в пределах 160px, pull к ней
- [ ] Нет hardcoded клавиш — только InputMap actions
- [ ] Все @export параметры настраиваются в инспекторе
- [ ] Строгая типизация везде
- [ ] Тестовая сцена: Кай не падает сквозь землю
- [ ] Нет `Engine.time_scale`
- [ ] Нет `class_name` в player.gd (CharacterBody2D scene, not autoload)

## Pitfalls
- НЕ `_process` для физики
- НЕ забывать `move_and_slide()`
- Wall-jump: отталкивание, не прилипание
- Dash без input = в направлении facing
- Roll только на земле
- Crouch: `scale.y`, не `size`
- Air dash reset только на `is_on_floor()`
- State timers: `_state_timer`, не `create_timer`
- Ledge grab только при падении (`vy > 0`)
- Grapple: проверять `distance_to` ДО перехода в состояние
