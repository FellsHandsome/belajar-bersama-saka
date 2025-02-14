extends Control

func _on_setting_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tampilan_setting.tscn") # Replace with function body.

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tampilan_awal.tscn")

func _on_tebak_gambar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tebak gambar scenes/tebak_gambar_menu.tscn")

func _on_sambung_ayat_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sambung ayat scenes/sambunng_ayat_menu.tscn")

func _on_kuis_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/kuis scenes/kuis_menu.tscn")
