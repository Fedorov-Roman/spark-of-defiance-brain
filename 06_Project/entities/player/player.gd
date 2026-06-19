class_name Player extends CharacterBody2D

## Константы движения (из Answers Bible)
const SPEED: float = 120.0
const GRAVITY: float = 900.0
const JUMP_VELOCITY: float = -280.0
const DASH_SPEED: float = 300.0
const WALL_SLIDE_SPEED: float = 60.0
const ROLL_IFRAMES: float = 0.4

## @onready
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray: RayCast2D = $WallRayCast
@onready var ground_ray: RayCast2D = $GroundRayCast

## Состояние
enum State { IDLE, RUN, JUMP, WALL_SLIDE, DASH, ROLL, CROUCH, LEDGE_GRAB, GRAPPLE }
var current_state: State = State.IDLE
var can_air_dash: bool = false  # Открывает Мастер Джаан
var hp: int = 3
var ammo: int = 5
var energy: int = 100

func _ready() -> void:
    # TODO Builder: подключить сигналы animated_sprite.animation_finished, настроить collision layers (player=1, enemy=2)
    pass

func _physics_process(delta: float) -> void:
    # TODO Builder: реализовать State Machine (Idle→Run→Jump→WallSlide→Dash→Roll). Использовать match current_state. Для Dash: i-frames 0.4с. Для WallSlide: velocity.y = clamp(velocity.y, -WALL_SLIDE_SPEED, WALL_SLIDE_SPEED)
    pass

func _unhandled_input(event: InputEvent) -> void:
    # TODO Builder: InputManager.get_movement_vector(), прыжок (SPACE/A), dash (SHIFT/X), crouch (CTRL/L3), grapple (F/Y). Проверить can_air_dash для двойного рывка
    pass
