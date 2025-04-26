extends Control

var backsound_player: AudioStreamPlayer
var is_muted := false

func _ready():
	var backsound_stream = load("res://assets/Asset game/Musik/middle-eastern-arabian-night-version-5-very-short-SBA-300504727-preview.ogg")
	backsound_stream.loop = true

	backsound_player = AudioStreamPlayer.new()
	backsound_player.stream = backsound_stream
	backsound_player.volume_db = 0
	add_child(backsound_player)
	backsound_player.play()

func mute():
	is_muted = true
	backsound_player.volume_db = -80

func unmute():
	is_muted = false
	backsound_player.volume_db = 0
