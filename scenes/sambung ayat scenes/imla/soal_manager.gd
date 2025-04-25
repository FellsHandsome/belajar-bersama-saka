extends Node
var jawaban_benar = {
	1: "A", 2: "C", 3: "D", 4: "C",
	5: "b", 6: "A", 7: "B", 8: "C"
}
var jawaban_user = {
	1: "", 2: "", 3: "", 4: "",
	5: "", 6: "", 7: "", 8: ""
}
var soal_aktif = 1
var total_soal = 8
var nilai = 0
@onready var canvas_group = $"../CanvasGroup"
@onready var nilai_scene = $"../NilaiScene"
@onready var countdown_timer = $"../CountdownTimer"
@onready var timer = countdown_timer.get_node("Timer") if countdown_timer else null
@onready var notif_cobalagi = canvas_group.get_node("NotificationCobaLagi")
@onready var notif_pintar = canvas_group.get_node("NotificationPintar")
@onready var notif_hebat = canvas_group.get_node("NotificationHebat")

func _ready():
	print("SoalManager _ready() called")
	print("INIT jawaban_benar:", jawaban_benar)
	for i in range(1, total_soal + 1):
		var soal_node = canvas_group.get_node("imlasoal" + str(i))
		if soal_node:
			soal_node.visible = (i == 1)
	if nilai_scene:
		nilai_scene.visible = false
	var next_button = canvas_group.get_node("Button")
	if next_button:
		next_button.pressed.connect(_on_next_button_pressed)
	hide_all_notifications()

func set_jawaban(nomor_soal, jawaban):
	var jawaban_lower = jawaban.to_lower()
	jawaban_user[nomor_soal] = jawaban_lower
	print("SET_JAWABAN: Soal", nomor_soal, "jawaban:", jawaban_lower)
	var jawaban_yang_benar = jawaban_benar.get(nomor_soal, "").to_lower()
	print("SET_JAWABAN: Jawaban benar?", jawaban_lower == jawaban_yang_benar)

func _on_next_button_pressed():
	hide_all_notifications()
	print("\n--- NEXT BUTTON PRESSED ---")
	var jawaban = jawaban_user.get(soal_aktif, "").strip_edges().to_lower()
	var jawaban_yang_benar = jawaban_benar.get(soal_aktif, "").strip_edges().to_lower()
	var benar = jawaban != "" and jawaban == jawaban_yang_benar
	print("NEXT: Jawaban user:", jawaban)
	print("NEXT: Jawaban benar?", benar)
	var waktu_sisa = timer.time_left if timer else 0
	var waktu_digunakan = 60 - waktu_sisa
	print("NEXT: Waktu digunakan:", waktu_digunakan)

	if benar:
		if waktu_digunakan <= 21:
			notif_pintar.visible = true
			print(">> NotificationPintar ditampilkan")
		elif waktu_digunakan <= 59:
			notif_hebat.visible = true
			print(">> NotificationHebat ditampilkan")
		else:
			print(">> Jawaban benar tapi waktu habis, tidak ada notifikasi")
	else:
		notif_cobalagi.visible = true
		print(">> NotificationCobaLagi ditampilkan")

	var soal_sekarang = canvas_group.get_node("imlasoal" + str(soal_aktif))
	if soal_sekarang:
		soal_sekarang.visible = false
	soal_aktif += 1
	print("NEXT: Soal aktif sekarang:", soal_aktif)
	if soal_aktif > total_soal:
		hitung_nilai()
		tampilkan_nilai()
	else:
		var soal_berikutnya = canvas_group.get_node("imlasoal" + str(soal_aktif))
		if soal_berikutnya:
			soal_berikutnya.visible = true

func hitung_nilai():
	var total_benar = 0
	for i in jawaban_benar:
		var user = jawaban_user.get(i, "").to_lower()
		var benar = jawaban_benar.get(i, "").to_lower()
		if user == benar:
			total_benar += 1
	nilai = (total_benar / float(total_soal)) * 100
	print("Nilai akhir:", nilai)

func tampilkan_nilai():
	if canvas_group:
		canvas_group.visible = false
	if nilai_scene:
		nilai_scene.visible = true
		nilai_scene.set_nilai_text(nilai)
	if timer:
		timer.stop()

func _on_nilai_button_pressed():
	soal_aktif = 1
	jawaban_user.clear()
	if nilai_scene:
		nilai_scene.visible = false
	if canvas_group:
		canvas_group.visible = true
	for i in range(1, total_soal + 1):
		var soal_node = canvas_group.get_node("imlasoal" + str(i))
		if soal_node:
			soal_node.visible = (i == 1)
	if timer:
		timer.start()

func hide_all_notifications():
	notif_cobalagi.visible = false
	notif_pintar.visible = false
	notif_hebat.visible = false
