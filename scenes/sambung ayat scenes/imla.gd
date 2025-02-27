extends Button

func _ready():
	# Hubungkan sinyal "pressed" ke fungsi _on_Button_pressed menggunakan Callable
	connect("pressed", Callable(self, "_on_Button_pressed"))

func _on_Button_pressed():
	# Pindah ke scene Main_Imla
	var main_imla_scene = preload("res://scenes/sambung ayat scenes/Main_Imla.tscn")
	get_tree().change_scene_to(main_imla_scene)
