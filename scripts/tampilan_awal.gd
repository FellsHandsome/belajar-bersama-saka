extends Control

func _on_button_pressed() -> void:
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
	
func _ready():
	if not SoundManager.backsound_player.playing:
		SoundManager.play_backsound()
