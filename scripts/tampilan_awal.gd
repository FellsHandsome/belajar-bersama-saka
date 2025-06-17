extends Control

func _ready():
	if not SoundManager.backsound_player.playing:
		SoundManager.play_backsound()

func _on_mulai_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
