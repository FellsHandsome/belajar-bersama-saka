# NilaiScene.gd
extends Control

@onready var label_nilai = $Label
@onready var bintang1 = $Bintang1
@onready var bintang2 = $Bintang2
@onready var bintang3 = $Bintang3

# Nilai minimum untuk mendapatkan bintang
var bintang1_threshold = 3000  # Bintang 1 jika nilai >= 3000
var bintang2_threshold = 6000  # Bintang 2 jika nilai >= 6000  
var bintang3_threshold = 9000  # Bintang 3 jika nilai >= 9000

# Button untuk kembali ke menu
@onready var button = $Button

func _ready():
	# Sembunyikan semua bintang dulu
	if bintang1: bintang1.visible = true  # Set visible tetapi dengan alpha rendah
	if bintang2: bintang2.visible = true
	if bintang3: bintang3.visible = true
	
	# Set semua bintang ke abu-abu (alpha 0.3)
	if bintang1: bintang1.modulate = Color(1, 1, 1, 0.3)
	if bintang2: bintang2.modulate = Color(1, 1, 1, 0.3)
	if bintang3: bintang3.modulate = Color(1, 1, 1, 0.3)
	
	# Connect button jika ada
	if button:
		button.pressed.connect(_on_button_pressed)

func set_nilai_text(nilai: int):
	# Set text nilai
	if label_nilai:
		label_nilai.text = "NILAI: %d" % nilai
	
	# Tentukan berapa bintang yang didapat
	var jumlah_bintang = 0
	if nilai >= bintang1_threshold: jumlah_bintang = 1
	if nilai >= bintang2_threshold: jumlah_bintang = 2  
	if nilai >= bintang3_threshold: jumlah_bintang = 3
	
	# Tampilkan bintang sesuai nilai
	tampilkan_bintang(jumlah_bintang)

func tampilkan_bintang(jumlah: int):
	# Reset semua bintang ke abu-abu
	if bintang1: bintang1.modulate = Color(1, 1, 1, 0.3)
	if bintang2: bintang2.modulate = Color(1, 1, 1, 0.3)
	if bintang3: bintang3.modulate = Color(1, 1, 1, 0.3)
	
	match jumlah:
		1:
			# Tampilkan hanya bintang tengah untuk 1 bintang
			if bintang2: 
				bintang2.modulate = Color(1, 1, 0, 1)  # Kuning dengan alpha penuh
		2:
			# Tampilkan bintang kiri dan kanan untuk 2 bintang
			if bintang1: 
				bintang1.modulate = Color(1, 1, 0, 1)  # Kuning dengan alpha penuh
			if bintang3: 
				bintang3.modulate = Color(1, 1, 0, 1)  # Kuning dengan alpha penuh
		3:
			# Tampilkan semua bintang untuk 3 bintang
			if bintang1: 
				bintang1.modulate = Color(1, 1, 0, 1)  # Kuning dengan alpha penuh
			if bintang2: 
				bintang2.modulate = Color(1, 1, 0, 1)  # Kuning dengan alpha penuh
			if bintang3: 
				bintang3.modulate = Color(1, 1, 0, 1)  # Kuning dengan alpha penuh

func _on_button_pressed():
	# Kembali ke menu atau scene lain
	# Uncomment dan sesuaikan jika diperlukan:
	# get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	# Atau kembali ke scene soal pertama
	var canvas_group = $"../CanvasGroup"
	var soal_manager = $"../SoalManager"
	
	if canvas_group:
		canvas_group.visible = true
	
	self.visible = false
	
	# Reset soal manager jika perlu
	if soal_manager:
		# Reset jawaban user
		for i in range(1, soal_manager.total_soal + 1):
			soal_manager.jawaban_user[i] = ""
		
		# Reset soal aktif
		soal_manager.soal_aktif = 1
		
		# Tampilkan soal pertama
		for i in range(1, soal_manager.total_soal + 1):
			var soal_node = canvas_group.get_node("imla soal " + str(i))
			if soal_node:
				soal_node.visible = (i == 1)
		
		# Mulai timer lagi
		var countdown_timer = $"../CountdownTimer"
		if countdown_timer and countdown_timer.timer:
			countdown_timer.reset_waktu()
			countdown_timer.timer.start()
