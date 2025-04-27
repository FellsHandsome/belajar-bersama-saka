extends Node

var jawaban_benar = {
	1: "B",  # Domba
	2: "B",  # Membelah Laut Merah
	3: "B",  # Solat 5 waktu
	4: "C",  # Membangun kapal
	5: "B",  # Karena difitnah oleh istri pembesar
	6: "B",  # Menyembuhkan orang buta
	7: "B",  # Jalut
	8: "B"   # Nabi Adam
}

var jawaban_user = {}
var soal_aktif = 1
var total_soal = 8

@onready var current_scene = null

func _ready():
	# Inisialisasi jawaban_user
	for i in range(1, total_soal + 1):
		jawaban_user[i] = ""
	
	# Tampilkan scene pertama
	show_scene("Soal1" if has_node("../Soal1") else "Soal1")  # Handle typo

func show_scene(scene_name: String):
	# Sembunyikan scene sebelumnya
	if current_scene:
		current_scene.visible = false
	
	# Tampilkan scene baru
	current_scene = get_node("../" + scene_name)
	current_scene.visible = true
	
	# Hubungkan tombol berikutnya
	var next_button = current_scene.get_node("Button")
	if next_button and not next_button.is_connected("pressed", _on_next_button_pressed):
		next_button.connect("pressed", _on_next_button_pressed)

func set_jawaban(nomor_soal, jawaban):
	jawaban_user[nomor_soal] = jawaban.to_upper().strip_edges()
	print("Jawaban untuk soal", nomor_soal, ":", jawaban_user[nomor_soal])

func _on_next_button_pressed():
	# Validasi jawaban sebelum lanjut
	if jawaban_user[soal_aktif].is_empty():
		print("Silakan pilih jawaban terlebih dahulu!")
		return
	
	# Tentukan scene berikutnya
	var next_scene = ""
	if soal_aktif % 2 == 1:  # Ganti ke scene kuis setelah cerita
		next_scene = "Soalkuis" + str((soal_aktif + 1) / 2)
	else:  # Ganti ke cerita berikutnya
		next_scene = "Soal" + str(soal_aktif / 2 + 1)
	
	soal_aktif += 1
	
	if soal_aktif > total_soal * 2:  # Total scene = cerita + kuis
		tampilkan_nilai_scene()
	else:
		show_scene(next_scene)

func tampilkan_nilai_scene():
	get_tree().change_scene("res://Nilai.tscn")

func hitung_nilai():
	var score = 0
	for i in range(1, total_soal + 1):
		if jawaban_user[i] == jawaban_benar[i]:
			score += 1
	print("Total Nilai:", score, "/", total_soal)
