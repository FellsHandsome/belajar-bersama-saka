extends Node

@export var waktu_soal: int = 60 # Waktu dalam detik untuk setiap soal
@onready var soal_manager = $"../SoalManager"
@onready var timer = $Timer
@onready var label_waktu = $Label

var waktu_tersisa: int

func _ready():
	if timer:
		timer.wait_time = 1.0 # Update setiap 1 detik
		timer.timeout.connect(_on_timer_timeout)
		
		# Reset waktu
		reset_waktu()
		
		# Start timer
		timer.start()

func reset_waktu():
	waktu_tersisa = waktu_soal
	if label_waktu:
		label_waktu.text = "Waktu: " + format_waktu(waktu_tersisa)

func _on_timer_timeout():
	waktu_tersisa -= 1
	
	if label_waktu:
		label_waktu.text = "Waktu: " + format_waktu(waktu_tersisa)
	
	if waktu_tersisa <= 0:
		# Waktu habis, pindah ke soal berikutnya
		var next_button = $"../CanvasGroup/Button"
		if next_button:
			next_button.emit_signal("pressed")
		
		# Reset waktu untuk soal berikutnya
		reset_waktu()

func format_waktu(seconds: int) -> String:
	var minutes = seconds / 60
	var remaining_seconds = seconds % 60
	return "%02d:%02d" % [minutes, remaining_seconds]
