extends Node

@onready var label = $Label
@onready var timer = $Timer

const TIMER_DURATION = 60.0  # Durasi timer dalam detik

func _ready():
	if timer:
		timer.wait_time = TIMER_DURATION
		timer.start()
	
func time_left_to_live():
	if timer:
		var time_left = timer.time_left
		var minute = floor(time_left / 60)
		var second = int(time_left) % 60
		return [minute, second]
	return [0, 0]

func _process(_delta):
	var time = time_left_to_live()
	label.text = "%02d:%02d" % [time[0], time[1]]
	
	if timer and timer.time_left <= 0:
		# Timer habis, lakukan tindakan yang diperlukan
		timer.stop()  # Hentikan timer agar tidak me-looping
		emit_signal("timeout")  # Emit sinyal timeout untuk tindakan lebih lanjut

# Fungsi untuk mereset timer dari luar
func reset():
	if timer:
		timer.stop()
		timer.start()
