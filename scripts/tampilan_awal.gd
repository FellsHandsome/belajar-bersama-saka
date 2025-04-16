extends Control

func _on_button_pressed() -> void:
	$CanvasLayer/Button/Click.play()
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
	
