extends Node
@export var waktu_soal: int = 60 # Waktu dalam detik untuk setiap soal
@onready var timer = $Timer
@onready var label_waktu = $Label
var waktu_tersisa: float  # Ubah ke float untuk penghitungan yang lebih akurat
func _ready():
	if timer:
		timer.wait_time = 1.0
		timer.one_shot = false  # Pastikan timer terus berjalan
		timer.timeout.connect(_on_timer_timeout)
		reset_waktu()
		timer.start()
func reset_waktu():
	waktu_tersisa = float(waktu_soal)  # Konversi ke float
	update_label()
func _on_timer_timeout():
	waktu_tersisa -= 1.0
	update_label()
	
	if waktu_tersisa <= 0:
		timer.stop()  # Hentikan timer saat waktu habis
		var next_button = $"../CanvasGroup/Button"
		if next_button:
			next_button.pressed.emit()
		reset_waktu()
		timer.start()  # Mulai lagi timer untuk soal berikutnya
func update_label():
	if label_waktu:
		var minutes = int(waktu_tersisa) / 60
		var seconds = int(waktu_tersisa) % 60
		label_waktu.text = "%02d:%02d" % [minutes, seconds]
# Tambahan untuk memastikan timer tetap update
func _process(delta):
	if timer and timer.is_stopped() and waktu_tersisa > 0:
		timer.start()
