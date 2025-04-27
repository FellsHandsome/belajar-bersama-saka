extends Node

var backsound_player: AudioStreamPlayer
var button_click_player: AudioStreamPlayer
var is_muted := false

func _ready():
	backsound_player = AudioStreamPlayer.new()
	backsound_player.stream = load("res://assets/Asset game/Musik/middle-eastern-arabian-night-version-5-very-short-SBA-300504727-preview.ogg")
	add_child(backsound_player)
	backsound_player.play()

	backsound_player.finished.connect(_on_backsound_finished)

	button_click_player = AudioStreamPlayer.new()
	add_child(button_click_player)

func _on_backsound_finished():
	backsound_player.play()
	
func play_backsound():
	if not backsound_player.playing:
		backsound_player.play()

func mute():
	is_muted = true
	backsound_player.volume_db = -80

func unmute():
	is_muted = false
	backsound_player.volume_db = 0

func play_button_click_sound():
	button_click_player.stream = load("res://assets/Asset game/Musik/button-305770.wav")
	button_click_player.play()
