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
var nilai = 0

@onready var canvas_group = $"../CanvasGroup"
@onready var nilai_scene = $"../NilaiScene"
@onready var countdown_timer = $"../CountdownTimer"

func _ready():
	for i in range(1, total_soal + 1):
		var soal_node = canvas_group.get_node("imla soal " + str(i))
		if soal_node:
			soal_node.visible = i == 1

	nilai_scene.visible = false

	var next_button = canvas_group.get_node("Button")
	if next_button:
		next_button.pressed.connect(_on_next_button_pressed)

	var nilai_button = nilai_scene.get_node("ButtonNilai-1")
	if nilai_button:
		nilai_button.pressed.connect(_on_nilai_button_pressed)

func set_jawaban(nomor_soal: int, jawaban: String):
	jawaban_user[nomor_soal] = jawaban
	print("Jawaban soal " + str(nomor_soal) + " = " + jawaban)

func _on_next_button_pressed():
	var soal_sekarang = canvas_group.get_node("imla soal " + str(soal_aktif))
	if soal_sekarang:
		soal_sekarang.visible = false

	soal_aktif += 1

	if soal_aktif > total_soal:
		hitung_nilai()
		tampilkan_nilai()
	else:
		var soal_berikutnya = canvas_group.get_node("imla soal " + str(soal_aktif))
		if soal_berikutnya:
			soal_berikutnya.visible = true

func hitung_nilai():
	nilai = 0
	var total_benar = 0

	for i in range(1, total_soal + 1):
		if jawaban_user[i] == jawaban_benar[i]:
			total_benar += 1

	nilai = (total_benar / float(total_soal)) * 100
	print("Total benar: " + str(total_benar) + "/" + str(total_soal))
	print("Nilai: " + str(nilai))

func tampilkan_nilai():
	canvas_group.visible = false
	nilai_scene.visible = true

	nilai_scene.set_nilai_text(nilai)
	update_bintang()

func update_bintang():
	var bintang1 = nilai_scene.get_node("Bintang 1")
	var bintang2 = nilai_scene.get_node("Bintang 2")
	var bintang3 = nilai_scene.get_node("Bintang 3")

	if bintang1:
		bintang1.modulate.a = 0.3
	if bintang2:
		bintang2.modulate.a = 0.3
	if bintang3:
		bintang3.modulate.a = 0.3

	if nilai >= 40:
		if bintang1:
			bintang1.modulate.a = 1.0
	if nilai >= 70:
		if bintang2:
			bintang2.modulate.a = 1.0
	if nilai >= 90:
		if bintang3:
			bintang3.modulate.a = 1.0

func _on_nilai_button_pressed():
	soal_aktif = 1
	for i in range(1, total_soal + 1):
		jawaban_user[i] = ""

	nilai_scene.visible = false
	canvas_group.visible = true

	for i in range(1, total_soal + 1):
		var soal_node = canvas_group.get_node("imla soal " + str(i))
		if soal_node:
			soal_node.visible = i == 1
