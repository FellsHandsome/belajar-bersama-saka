extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_suara_pressed():
	pass

func _on_button_music_pressed() -> void:
	SoundManager.play_button_click_sound()
	if SoundManager.is_muted:
		SoundManager.unmute()
	else:
		SoundManager.mute()

func _on_button_back_pressed():
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
