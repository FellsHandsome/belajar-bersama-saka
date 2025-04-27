extends Node2D

@export var nomor_soal: int = 1
var soal_manager

func _ready():
	# Menggunakan path yang benar sesuai struktur scene
	soal_manager = get_node("../../SoalManager")
	setup_opsi_signals()

func setup_opsi_signals():
	var opsi_nodes = {
		"A": get_node_or_null("A"),
		"B": get_node_or_null("B"),
		"C": get_node_or_null("C"),
		"D": get_node_or_null("D")
	}
	
	for huruf in opsi_nodes:
		var node = opsi_nodes[huruf]
		if node:
			node.input_event.connect(
				func(_viewport, event, _shape_idx):
					if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
						on_opsi_pressed(huruf)
			)

func on_opsi_pressed(jawaban: String):
	reset_opsi()
	highlight_opsi(jawaban)
	if soal_manager:
		soal_manager.set_jawaban(nomor_soal, jawaban.to_lower())

func reset_opsi():
	for huruf in ["A", "B", "C", "D"]:
		var node = get_node_or_null(huruf)
		if node:
			node.modulate = Color(1, 1, 1, 1)

func highlight_opsi(huruf: String):
	var node = get_node_or_null(huruf)
	if node:
		node.modulate = Color(0.8, 1, 0.8, 1)
