extends Button

@onready var a_1 = $A1

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn") # Replace with function body.
	a_1.play()
