class_name EnemyBase extends CharacterBody2D

## Состояния AI
enum AIState { IDLE, PATROL, SUSPICIOUS, ALERT, PARALYZED, DEAD }
var ai_state: AIState = AIState.PATROL

## @onready
@onready var vision_cone: Area2D = $VisionCone
@onready var noise_area: Area2D = $NoiseArea
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

## Параметры (из Answers Bible)
@export var move_speed: float = 40.0
@export var vision_range: float = 120.0
@export var vision_angle: float = 90.0
@export var alert_decay: float = 30.0

func _ready() -> void:
    # TODO Builder: подключить area_entered VisionCone и NoiseArea. Сохранить waypoints для патруля. Установить collision_layer=enemy, mask=player
    pass

func _physics_process(delta: float) -> void:
    # TODO Builder: Idle→Patrol (по waypoints)→Suspicious (при обнаружении шума)→Alert (при визуальном контакте). Alert: 30с decay если потерял игрока. В Alert: вызвать GameState.alert_level += 1
    pass

func paralyze(duration: float) -> void:
    # TODO Builder: Timer на 10с. В состоянии PARALYZED: отключить _physics_process, проиграть анимацию paralyzed, по истечении: восстановить AIState.IDLE
    pass
