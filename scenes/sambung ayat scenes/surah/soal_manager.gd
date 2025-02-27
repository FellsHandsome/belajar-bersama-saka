extends Node

# Variabel untuk menyimpan referensi ke node-node soal
var questions = []
var current_question_index = 0

func _ready():
	# Dapatkan referensi ke CanvasGroup
	var canvas_group = get_node("../CanvasGroup")
	
	# Pastikan CanvasGroup ditemukan
	if canvas_group == null:
		print("Error: CanvasGroup tidak ditemukan!")
		return
	
	# Inisialisasi array questions dengan node soal yang ada di CanvasGroup
	questions = [
		canvas_group.get_node("surah soal 1"),
		canvas_group.get_node("surah soal 3"),
		canvas_group.get_node("surah soal 4"),
		canvas_group.get_node("surah soal 5")
	]
	
	# Debugging: Cetak isi array questions
	print("Isi array questions:", questions)
	
	# Pastikan semua node soal ada
	for i in range(questions.size()):
		if questions[i] == null:
			print("Error: Node soal tidak ditemukan! Index:", i)
		else:
			print("Node soal ditemukan:", questions[i].name)
	
	# Pastikan array questions tidak kosong
	if questions.size() == 0:
		print("Error: Tidak ada soal yang ditemukan!")
		return
	
	# Sembunyikan semua soal terlebih dahulu
	for question in questions:
		if question != null:
			question.visible = false
	
	# Tampilkan soal pertama saat game dimulai
	show_question(current_question_index)

func show_question(index):
	# Pastikan array questions tidak kosong
	if questions.size() == 0:
		print("Error: Tidak ada soal yang ditemukan!")
		return
	
	# Pastikan index valid
	if index < 0 or index >= questions.size():
		print("Error: Index soal tidak valid! Index:", index)
		return
	
	# Sembunyikan semua soal
	for question in questions:
		if question != null:
			question.visible = false
	
	# Tampilkan soal yang dipilih
	if questions[index] != null:
		questions[index].visible = true
		print("Menampilkan soal:", questions[index].name)
	else:
		print("Error: Node soal pada index", index, "tidak valid!")

func _on_KirimButton_pressed():
	print("Tombol Kirim ditekan! Pindah ke soal berikutnya.")
	
	# Pindah ke soal berikutnya
	current_question_index += 1
	
	# Jika sudah mencapai soal terakhir, kembali ke soal pertama
	if current_question_index >= questions.size():
		current_question_index = 0
		print("Kembali ke soal pertama.")
	
	# Pastikan index valid sebelum menampilkan soal
	if current_question_index < questions.size():
		show_question(current_question_index)
	else:
		print("Error: Index soal tidak valid!")
