extends Node2D

@onready var soal_manager = $"../../../SoalManager"
@export var nomor_soal: int = 1
var jawaban_terpilih: String = ""

@onready var opsi_a = $A
@onready var opsi_b = $B
@onready var opsi_c = $C
@onready var opsi_d = $D

func _ready():
	setup_opsi_signals()
	restore_jawaban()

func setup_opsi_signals():
	for opsi in [
		{"node": opsi_a, "jawaban": "a"},
		{"node": opsi_b, "jawaban": "b"},
		{"node": opsi_c, "jawaban": "c"},
		{"node": opsi_d, "jawaban": "d"}
	]:
		if opsi.node:
			opsi.node.input_event.connect(
				func(_viewport, event, _shape_idx):
					if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
						on_opsi_pressed(opsi.jawaban)
			)

func on_opsi_pressed(jawaban: String):
	reset_opsi()
	jawaban_terpilih = jawaban.to_lower()
	highlight_opsi(jawaban.to_upper())
	
	if soal_manager:
		soal_manager.set_jawaban(nomor_soal, jawaban_terpilih)

func reset_opsi():
	for opsi in [opsi_a, opsi_b, opsi_c, opsi_d]:
		if opsi:
			opsi.modulate = Color(1, 1, 1, 1)

func highlight_opsi(huruf: String):
	var opsi_dict = {
		"A": opsi_a,
		"B": opsi_b,
		"C": opsi_c,
		"D": opsi_d
	}
	var target_opsi = opsi_dict.get(huruf)
	if target_opsi:
		target_opsi.modulate = Color(0.8, 1, 0.8, 1)

func restore_jawaban():
	if soal_manager and soal_manager.jawaban_user.has(nomor_soal):
		var jawaban = soal_manager.jawaban_user[nomor_soal]
		if jawaban != "":
			jawaban_terpilih = jawaban
			highlight_opsi(jawaban.to_upper())
