class_name AudioManager extends Node

enum MusicState { STEALTH, SUSPICIOUS, ALERT, EXPLORATION, BOSS }
var current_music: MusicState = MusicState.EXPLORATION

## @onready
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
@onready var ambient_player: AudioStreamPlayer = $AmbientPlayer

func play_music(state: MusicState) -> void:
    # TODO Builder: использовать 2 AudioStreamPlayer (current, next). Tween на volume_db (-80 до 0). При смене state: fade out current, fade in next
    pass

func play_sfx(sound_name: String) -> void:
    # TODO Builder: использовать AudioStreamPlayer с bus=SFX. Загрузить звуки из res://assets/audio/sfx/. Dictionary[str, AudioStream] для кэширования
    pass
