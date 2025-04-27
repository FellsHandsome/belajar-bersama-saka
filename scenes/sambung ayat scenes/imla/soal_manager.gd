extends Node
var jawaban_benar = {
	1: "A", 2: "C", 3: "D", 4: "C",
	5: "B", 6: "A", 7: "B", 8: "C"
}
var jawaban_user = {
	1: "", 2: "", 3: "", 4: "", 
	5: "", 6: "", 7: "", 8: ""
}
var soal_aktif = 1
var total_soal = 8
@onready var canvas_group = $"../CanvasGroup"
@onready var nilai_scene = $"../NilaiScene"
@onready var countdown_timer = $"../CountdownTimer"
@onready var timer = countdown_timer.get_node("Timer") if countdown_timer else null
func _ready():
	print("SoalManager _ready() called")
	print("INIT jawaban_benar:", jawaban_benar)
	
	# Initialize soal visibility
	for i in range(1, total_soal + 1):
		var soal_node = canvas_group.get_node("imlasoal" + str(i))
		if soal_node:
			soal_node.visible = (i == 1)
	
	# Hide nilai scene and show timer
	if nilai_scene:
		nilai_scene.visible = false
	if countdown_timer:
		# Make all children of countdown_timer visible
		for child in countdown_timer.get_children():
			if child is Control:
				child.visible = true
	
	# Connect next button
	var next_button = canvas_group.get_node("Button")
	if next_button:
		if next_button.is_connected("pressed", _on_next_button_pressed):
			next_button.pressed.disconnect(_on_next_button_pressed)
		next_button.pressed.connect(_on_next_button_pressed)
func set_jawaban(nomor_soal, jawaban):
	var jawaban_lower = jawaban.to_lower()
	jawaban_user[nomor_soal] = jawaban_lower
	print("SET_JAWABAN: Soal", nomor_soal, "jawaban:", jawaban_lower)
	
	var jawaban_yang_benar = jawaban_benar.get(nomor_soal, "").to_lower()
	print("SET_JAWABAN: Jawaban benar?", jawaban_lower == jawaban_yang_benar)
func _on_next_button_pressed():
	print("\n--- NEXT BUTTON PRESSED ---")
	var jawaban = jawaban_user.get(soal_aktif, "").strip_edges().to_lower()
	var jawaban_yang_benar = jawaban_benar.get(soal_aktif, "").strip_edges().to_lower()
	var benar = jawaban != "" and jawaban == jawaban_yang_benar
	print("NEXT: Jawaban user:", jawaban)
	print("NEXT: Jawaban benar?", benar)
	# Hide current question
	var soal_sekarang = canvas_group.get_node("imlasoal" + str(soal_aktif))
	if soal_sekarang:
		soal_sekarang.visible = false
	
	soal_aktif += 1
	print("NEXT: Soal aktif sekarang:", soal_aktif)
	
	if soal_aktif > total_soal:
		tampilkan_nilai_scene()
	else:
		# Show next question
		var soal_berikutnya = canvas_group.get_node("imlasoal" + str(soal_aktif))
		if soal_berikutnya:
			soal_berikutnya.visible = true
		
		# Reset timer
		if countdown_timer:
			countdown_timer.reset_waktu()
func tampilkan_nilai_scene():
	print("Menampilkan scene nilai")
	
	# Hide all UI elements
	if canvas_group:
		canvas_group.visible = false
	if countdown_timer:
		# Hide all children of countdown_timer
		for child in countdown_timer.get_children():
			if child is Control:
				child.visible = false
	
	# Show score screen
	if nilai_scene:
		nilai_scene.visible = true
	
	# Stop timer
	if timer:
		timer.stop()
