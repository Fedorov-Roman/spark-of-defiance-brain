class_name AudioManager extends Node
enum MusicState { AMBIENT, TENSION, COMBAT, STEALTH, BOSS }
var current_state: MusicState = MusicState.AMBIENT
@onready var music: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var sfx: AudioStreamPlayer = AudioStreamPlayer.new()
func _ready() -> void: add_child(music); add_child(sfx)
func set_music_state(s: MusicState) -> void: if current_state == s: return; current_state = s
func play_sfx(stream: AudioStream) -> void: sfx.stream = stream; sfx.play()
