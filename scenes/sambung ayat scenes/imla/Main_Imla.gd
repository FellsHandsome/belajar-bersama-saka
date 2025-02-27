extends Node

var current_scene = null
var current_scene_index = 1
const TOTAL_SCENES = 10

func _ready():
	load_scene("res://scenes/Imla_soal_1.tscn")

func load_scene(scene_path):
	if current_scene != null:
		# Hide the current scene
		current_scene.visible = false
	
	# Load the new scene
	var new_scene = load(scene_path).instance()
	
	# Add the new scene to the scene tree
	get_tree().root.add_child(new_scene)
	
	# Set the new scene as the current scene
	current_scene = new_scene

func next_scene():
	if current_scene_index < TOTAL_SCENES:
		current_scene_index += 1
		var scene_path = "res://scenes/Imla_soal_%d.tscn" % current_scene_index
		load_scene(scene_path)
	else:
		print("All scenes have been completed")

# Call this function to start the first scene
func start_game():
	_ready()
