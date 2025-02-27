extends Control

func _ready():
	$NextButton.connect("pressed", Callable(get_node("/root/SoalManager"), "next_scene"))
