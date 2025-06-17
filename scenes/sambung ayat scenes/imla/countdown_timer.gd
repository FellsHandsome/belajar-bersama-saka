extends Node

@export var waktu_soal: int = 60
@onready var timer: Timer = $Timer
@onready var label_waktu = $Panel/Label
var waktu_tersisa: float

func _ready():
	if timer:
		timer.wait_time = 1.0
		timer.one_shot = false
		timer.timeout.connect(_on_timer_timeout)
		reset_waktu()

func reset_waktu():
	waktu_tersisa = float(waktu_soal)
	update_label()
	if timer:
		timer.start()

func _on_timer_timeout():
	waktu_tersisa -= 1.0
	update_label()
	if waktu_tersisa <= 0:
		timer.stop()
		var next_button = get_node("../Button")
		if next_button:
			next_button.pressed.emit()
		reset_waktu()

func update_label():
	if label_waktu:
		var minutes = int(waktu_tersisa) / 60
		var seconds = int(waktu_tersisa) % 60
		label_waktu.text = "%02d:%02d" % [minutes, seconds]
