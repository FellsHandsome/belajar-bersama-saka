extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_setting_button_pressed() -> void:
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://scenes/tampilan_setting.tscn")

func _on_back_button_pressed() -> void:
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")

func _on_mulai_button_pressed() -> void:
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://scenes/tebak gambar scenes/tebak gambar background.tscn")
