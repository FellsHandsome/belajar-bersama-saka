extends Node

const JAWABAN_BENAR := ['a', 'c', 'd', 'c', 'b', 'a', 'b', 'c']
var soal_aktif: int = 0
var cerita_aktif: int = 0
var cerita_nodes: Array = []
var soalkuis_nodes: Array = []
var main_buttons: Array = []
var jawaban_user: Array[String] = ["", "", "", "", "", "", "", ""]
var skor_per_soal := 375
var sedang_notifikasi := false

@onready var canvas_group := $"../CanvasGroup"
@onready var button_next: Button = $"../CanvasGroup/Button"
@onready var countdown_timer = $"../CanvasGroup/CountdownTimer"
@onready var countdown_panel = $"../CanvasGroup/CountdownTimer/Panel"
@onready var nilai_scene = $"../NilaiScene"

@onready var notif_hebat = $"../CanvasGroup/NotificationHebat"
@onready var notif_pintar = $"../CanvasGroup/NotificationPintar"
@onready var notif_cobalagi = $"../CanvasGroup/NotificationCobaLagi"

var cerita_timer: Timer

func _ready():
	randomize()
	canvas_group.visible = true
	nilai_scene.visible = false
	sembunyikan_semua_notifikasi()

	# Siapkan array Cerita dan SoalKuis sesuai struktur node
	for i in range(8):
		var cerita_node = canvas_group.get_node("Cerita%d" % (i + 1))
		cerita_nodes.append(cerita_node)
		var soal_node = canvas_group.get_node("Soal").get_node("SoalKuis%d" % (i + 1))
		soalkuis_nodes.append(soal_node)
		var mb = soal_node.get_node("MainButton")
		main_buttons.append(mb)
		cerita_node.visible = false
		soal_node.visible = false

	soal_aktif = 0
	cerita_aktif = 0

	button_next.pressed.connect(_on_next_button_pressed)

	# Timer untuk transisi cerita (5 detik)
	cerita_timer = Timer.new()
	cerita_timer.one_shot = true
	cerita_timer.wait_time = 5.0
	add_child(cerita_timer)
	cerita_timer.timeout.connect(_on_cerita_timer_timeout)

	mulai_kuis()

func mulai_kuis():
	# Tampilkan Cerita1 saja di awal, hide semua soal
	for i in range(cerita_nodes.size()):
		cerita_nodes[i].visible = (i == 0)
	for i in range(soalkuis_nodes.size()):
		soalkuis_nodes[i].visible = false
	button_next.visible = false
	sembunyikan_semua_notifikasi()
	cerita_aktif = 0
	soal_aktif = 0
	if countdown_panel:
		countdown_panel.visible = true
	cerita_timer.start()

func _on_cerita_timer_timeout():
	# Setelah 5 detik cerita, tampilkan soal terkait
	for cerita in cerita_nodes:
		cerita.visible = false
	show_soal(soal_aktif)

func show_soal(idx: int):
	for i in range(soalkuis_nodes.size()):
		soalkuis_nodes[i].visible = (i == idx)
		if i == idx:
			var mb = main_buttons[i]
			for button in mb.get_children():
				if button is Button:
					button.visible = true
	if countdown_timer:
		countdown_timer.reset_waktu()
	sembunyikan_semua_notifikasi()
	sedang_notifikasi = false
	button_next.visible = true
	button_next.disabled = false

func _on_next_button_pressed():
	if sedang_notifikasi:
		return

	if soal_aktif >= main_buttons.size():
		selesai_kuis()
		return

	var pilihan = main_buttons[soal_aktif].get_selected_pilihan()
	if pilihan == "":
		return
	jawaban_user[soal_aktif] = pilihan

	# Hitung waktu menjawab
	var waktu_sisa = countdown_timer.get_node("Timer").time_left
	var waktu_total = countdown_timer.get_node("Timer").wait_time
	var waktu_jawab = waktu_total - waktu_sisa

	var benar = (pilihan == JAWABAN_BENAR[soal_aktif])
	if benar:
		print("Soal ", soal_aktif + 1, ": Benar")
	else:
		print("Soal ", soal_aktif + 1, ": Salah (Jawaban benar: ", JAWABAN_BENAR[soal_aktif], ")")

	tampilkan_notifikasi_lalu_lanjut(benar, waktu_jawab)

func tampilkan_notifikasi_lalu_lanjut(jawaban_benar: bool, waktu_jawab: float):
	sedang_notifikasi = true
	button_next.disabled = true
	sembunyikan_semua_notifikasi()

	if jawaban_benar:
		var notif_array = [notif_hebat, notif_pintar]
		var idx = randi() % notif_array.size()
		notif_array[idx].visible = true
	else:
		notif_cobalagi.visible = true

	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect(func ():
		sembunyikan_semua_notifikasi()
		sedang_notifikasi = false
		button_next.disabled = false

		# Hide soal, timer off, button off
		soalkuis_nodes[soal_aktif].visible = false
		countdown_timer.get_node("Timer").stop()
		button_next.visible = false

		soal_aktif += 1
		cerita_aktif += 1
		if soal_aktif >= soalkuis_nodes.size():
			selesai_kuis()
		else:
			# Tampilkan cerita berikutnya (kalau ada), lalu otomatis lanjut ke soal berikutnya
			for i in range(cerita_nodes.size()):
				cerita_nodes[i].visible = (i == cerita_aktif)
			cerita_timer.start()
		timer.queue_free()
	)

func sembunyikan_semua_notifikasi():
	notif_hebat.visible = false
	notif_pintar.visible = false
	notif_cobalagi.visible = false

func get_skor() -> int:
	var skor = 0
	for i in JAWABAN_BENAR.size():
		if jawaban_user[i] == JAWABAN_BENAR[i]:
			skor += 1
	return skor

func selesai_kuis():
	var skor_akhir = get_skor() * skor_per_soal
	Global.skor = skor_akhir
	print("Skor akhir sebelum ke NilaiScene: ", skor_akhir)
	if countdown_panel:
		countdown_panel.visible = false
	canvas_group.visible = false
	nilai_scene.visible = true
	nilai_scene.tampilkan_nilai()
