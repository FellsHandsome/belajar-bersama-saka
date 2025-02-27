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
		canvas_group.get_node("imla soal 1"),
		canvas_group.get_node("imla soal 2"),
		canvas_group.get_node("imla soal 3"),
		canvas_group.get_node("imla soal 4"),
		canvas_group.get_node("imla soal 5"),
		canvas_group.get_node("imla soal 6"),
		canvas_group.get_node("imla soal 7"),
		canvas_group.get_node("imla soal 8")
	]
	
	# Pastikan semua node soal ada
	for i in range(questions.size()):
		if questions[i] == null:
			print("Error: Node soal tidak ditemukan! Index:", i)
			return
		else:
			print("Node soal ditemukan:", questions[i].name)
	
	# Sembunyikan semua soal terlebih dahulu
	for question in questions:
		question.visible = false
	
	# Tampilkan soal pertama saat game dimulai
	show_question(current_question_index)

func show_question(index):
	# Sembunyikan semua soal
	for question in questions:
		question.visible = false
	
	# Tampilkan soal yang dipilih
	questions[index].visible = true
	print("Menampilkan soal:", questions[index].name)

func _on_next_question_button_pressed():
	print("Tombol ditekan! Pindah ke soal berikutnya.")
	current_question_index += 1
	
	# Jika sudah mencapai soal terakhir, kembali ke soal pertama
	if current_question_index >= questions.size():
		current_question_index = 0
		print("Kembali ke soal pertama.")
	
	# Tampilkan soal baru
	show_question(current_question_index)


func _on_button_pressed() -> void:
	pass # Replace with function body.
