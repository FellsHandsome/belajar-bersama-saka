extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")


func _on_imla_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sambung ayat scenes/imla/imla_background.tscn")


func _on_surah_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sambung ayat scenes/surah/surah_background.tscn")
