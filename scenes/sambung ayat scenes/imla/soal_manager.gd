extends Control

const SOAL_DAN_OPSI = [
	"""1. Soal pertama...
	A. Pilihan A
	B. Pilihan B
	C. Pilihan C
	D. Pilihan D""",
	# ... soal 2-8 ...
]

const KUNCI_JAWABAN = ["a", "c", "d", "c", "b", "a", "b", "c"]

@onready var text_soal = $TextEdit
@onready var tombol_lanjut = $Button
var soal_aktif = 0
var skor = 0

func _ready():
	tampilkan_soal(0)
	tombol_lanjut.pressed.connect(_on_lanjut_ditekan)

func tampilkan_soal(no_soal):
	text_soal.text = SOAL_DAN_OPSI[no_soal]
	soal_aktif = no_soal

func _on_lanjut_ditekan():
	var jawaban = baca_jawaban()
	if jawaban == KUNCI_JAWABAN[soal_aktif]:
		skor += 1
		
	if soal_aktif < SOAL_DAN_OPSI.size() - 1:
		tampilkan_soal(soal_aktif + 1)
	else:
		tampilkan_hasil()

func baca_jawaban():
	var teks = text_soal.text.to_lower()
	if "a." in teks: return "a"
	if "b." in teks: return "b"
	if "c." in teks: return "c"
	if "d." in teks: return "d"
	return ""

func tampilkan_hasil():
	text_soal.text = "Skor akhir: %d/8" % skor
	tombol_lanjut.hide()
