class_name AudioManager extends Node

enum MusicState { EXPLORATION, SUSPICION, ALERT, BOSS, HUB }

@export var music_volume: float = 0.8
@export var sfx_volume: float = 1.0

var current_music_state: MusicState = MusicState.EXPLORATION
var _music_players: Dictionary = {}
var _current_music_player: AudioStreamPlayer

func _ready() -> void:
    # Create music players for each state
    for state in MusicState.keys():
        var player := AudioStreamPlayer.new()
        player.name = "Music_" + state
        player.bus = "Music"
        add_child(player)
        _music_players[MusicState[state]] = player

    set_music_state(MusicState.EXPLORATION)

func set_music_state(state: MusicState) -> void:
    if current_music_state == state:
        return
    current_music_state = state

    # Crossfade
    var new_player: AudioStreamPlayer = _music_players.get(state)
    if not new_player:
        return

    # Stop previous
    if _current_music_player and _current_music_player.playing:
        _current_music_player.stop()

    # Start new (placeholder: load actual streams in CP-12+)
    _current_music_player = new_player
    # _current_music_player.stream = preload("res://assets/music/exploration.ogg")
    _current_music_player.volume_db = linear_to_db(music_volume)
    _current_music_player.play()

func play_sfx(sfx_name: String) -> void:
    var player := AudioStreamPlayer.new()
    player.bus = "SFX"
    player.volume_db = linear_to_db(sfx_volume)
    # player.stream = load("res://assets/sfx/" + sfx_name + ".ogg")
    add_child(player)
    player.play()
    await player.finished
    player.queue_free()

func set_ambient(ambient_name: String) -> void:
    pass  # TODO: ambient layers
