extends Control
#
#@onready var label_nilai = $Label
#@onready var bintang_putih1 = $BintangPutih1
#@onready var bintang_putih2 = $BintangPutih2
#@onready var bintang_putih3 = $BintangPutih3
#@onready var bintang_kuning1 = $BintangKuning1
#@onready var bintang_kuning2 = $BintangKuning2
#@onready var bintang_kuning3 = $BintangKuning3
#
## Nilai threshold untuk bintang
#const BINTANG1_THRESHOLD = 1000  # Lebih dari 1000
#const BINTANG2_THRESHOLD = 2000  # Lebih dari 2000
#const BINTANG3_THRESHOLD = 3000  # Tepat 3000
#
#@onready var button = $Button
#
#func _ready():
	## Set initial visibility
	#set_bintang_visibility(0)
	#
	#if button:
		#button.pressed.connect(_on_button_pressed)
#
#func set_nilai_text(nilai: int):
	#if label_nilai:
		#label_nilai.text = "NILAI: %d" % nilai
	#
	## Tentukan jumlah bintang berdasarkan nilai
	#var jumlah_bintang = 0
	#if nilai > BINTANG1_THRESHOLD:
		#jumlah_bintang = 1
	#if nilai > BINTANG2_THRESHOLD:
		#jumlah_bintang = 2
	#if nilai == BINTANG3_THRESHOLD:
		#jumlah_bintang = 3
	#
	#set_bintang_visibility(jumlah_bintang)
#
#func set_bintang_visibility(jumlah_bintang: int):
	## Semua BintangPutih selalu visible
	#if bintang_putih1: bintang_putih1.visible = true
	#if bintang_putih2: bintang_putih2.visible = true
	#if bintang_putih3: bintang_putih3.visible = true
	#
	## Set visibility BintangKuning berdasarkan jumlah bintang
	#if bintang_kuning1: bintang_kuning1.visible = jumlah_bintang >= 1
	#if bintang_kuning2: bintang_kuning2.visible = jumlah_bintang >= 2
	#if bintang_kuning3: bintang_kuning3.visible = jumlah_bintang >= 3
#
#func _on_button_pressed():
	#var canvas_group = $"../CanvasGroup"
	#var soal_manager = $"../SoalManager"
	#
	#if canvas_group:
		#canvas_group.visible = true
	#
	#self.visible = false
	#
	#if soal_manager:
		## Reset jawaban user
		#for i in range(1, soal_manager.total_soal + 1):
			#soal_manager.jawaban_user[i] = ""
		#
		## Reset soal aktif
		#soal_manager.soal_aktif = 1
		#
		## Tampilkan soal pertama
		#for i in range(1, soal_manager.total_soal + 1):
			#var soal_node = canvas_group.get_node("imlasoal" + str(i))
			#if soal_node:
				#soal_node.visible = (i == 1)
		#
		## Reset timer
		#var countdown_timer = $"../CountdownTimer"
		#if countdown_timer and countdown_timer.has_method("reset_waktu"):
			#countdown_timer.reset_waktu()


func _on_button_pressed() -> void:
	SoundManager.play_button_click_sound()
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
