extends Node
# Variabel untuk menyimpan referensi ke node-node soal
var questions = []
var current_question_index = 0
# Array untuk menyimpan jawaban yang benar
var correct_answers = ["A", "C", "D", "C", "B", "A", "B", "C"]
# Menyimpan jawaban yang dipilih saat ini
var current_selected_answer = ""
# Variabel untuk menandai apakah notifikasi sedang ditampilkan
var is_showing_notification = false
# Untuk melacak jawaban benar berturut-turut
var consecutive_correct_answers = 0

func _ready():
	# Dapatkan referensi ke CanvasGroup dengan path yang benar
	var canvas_group = get_node("../CanvasGroup")
	
	# Pastikan CanvasGroup ditemukan
	if canvas_group == null:
		print("Error: CanvasGroup tidak ditemukan!")
		return
	
	# Inisialisasi array questions dengan node soal yang ada di CanvasGroup
	questions = []
	for i in range(1, 9):
		var node_name = "imla soal " + str(i)
		var question_node = canvas_group.get_node(node_name)
		if question_node != null:
			questions.append(question_node)
			print("Node soal ditemukan:", question_node.name)
		else:
			print("Error: Node soal tidak ditemukan! Name:", node_name)
	
	# Sembunyikan semua soal terlebih dahulu
	for question in questions:
		question.visible = false
	
	# Tampilkan soal pertama saat game dimulai
	if questions.size() > 0:
		show_question(current_question_index)
	else:
		print("Error: Tidak ada soal yang ditemukan!")
	
	# Dapatkan referensi ke tombol kirim
	var kirim_button = canvas_group.get_node("Button")
	if kirim_button != null:
		kirim_button.connect("pressed", Callable(self, "_on_kirim_button_pressed"))
		print("Tombol KIRIM terhubung dengan sinyal pressed")
	else:
		print("Error: Button KIRIM tidak ditemukan!")
	
	# Hubungkan sinyal dari tombol-tombol pilihan
	connect_option_buttons()

func connect_option_buttons():
	# Untuk setiap soal
	for question in questions:
		# Cari semua tombol pilihan dalam soal
		var option_buttons = []
		
		# Cari semua node yang mungkin tombol pilihan
		var all_buttons = get_all_children(question)
		
		for node in all_buttons:
			# Cek apakah node adalah tombol dan namanya mengandung A, B, C, atau D
			if (node is Button or node is CheckBox or node is TextureButton):
				for letter in ["A", "B", "C", "D"]:
					if letter in node.name:
						option_buttons.append({"node": node, "letter": letter})
						break
		
		# Hubungkan sinyal dari tombol-tombol pilihan
		for option in option_buttons:
			var button = option["node"]
			var letter = option["letter"]
			
			# Hubungkan sinyal pressed atau toggled (tergantung jenis tombol)
			if button.has_signal("toggled"):
				if not button.toggled.is_connected(Callable(self, "_on_option_toggled")):
					button.toggled.connect(Callable(self, "_on_option_toggled").bind(letter, button))
			else:
				if not button.pressed.is_connected(Callable(self, "_on_option_pressed")):
					button.pressed.connect(Callable(self, "_on_option_pressed").bind(letter, button))
			
			print("Terhubung tombol pilihan:", button.name, "dengan jawaban:", letter)

# Fungsi untuk mendapatkan semua child node secara rekursif
func get_all_children(node):
	var children = []
	for child in node.get_children():
		children.append(child)
		children.append_array(get_all_children(child))
	return children

func _on_option_toggled(toggled, option_letter, button):
	if toggled:
		select_answer(option_letter)
		# Ubah tampilan tombol menjadi abu-abu
		button.modulate = Color(0.5, 0.5, 0.5) # Abu-abu
		
		# Reset tombol lain pada soal yang sama
		reset_other_option_buttons(button)

func _on_option_pressed(option_letter, button):
	select_answer(option_letter)
	# Ubah tampilan tombol menjadi abu-abu
	button.modulate = Color(0.5, 0.5, 0.5) # Abu-abu
	
	# Reset tombol lain pada soal yang sama
	reset_other_option_buttons(button)

func reset_other_option_buttons(selected_button):
	var parent = selected_button.get_parent()
	var all_buttons = get_all_children(parent)
	
	# Reset tampilan tombol lain
	for button in all_buttons:
		if button != selected_button and (button is Button or button is CheckBox or button is TextureButton):
			button.modulate = Color(1, 1, 1) # Putih (warna default)
			if button is CheckBox and button.button_pressed:
				button.button_pressed = false

func select_answer(option_letter):
	current_selected_answer = option_letter
	print("Pilihan yang dipilih:", current_selected_answer)

func show_question(index):
	# Pastikan index valid
	if index < 0 or index >= questions.size():
		print("Error: Index soal tidak valid!")
		return
	
	# Sembunyikan semua soal
	for question in questions:
		question.visible = false
	
	# Tampilkan soal yang dipilih
	questions[index].visible = true
	print("Menampilkan soal:", questions[index].name)
	
	# Reset pilihan saat menampilkan soal baru
	current_selected_answer = ""
	
	# Reset warna tombol pilihan
	var all_buttons = get_all_children(questions[index])
	for button in all_buttons:
		if button is Button or button is CheckBox or button is TextureButton:
			button.modulate = Color(1, 1, 1) # Reset ke warna default (putih)
			if button is CheckBox and button.button_pressed:
				button.button_pressed = false

func check_answer():
	if is_showing_notification:
		return false # Jangan proses jawaban jika notifikasi sedang ditampilkan
	
	# Jika belum ada jawaban yang dipilih
	if current_selected_answer == "":
		print("Belum ada jawaban yang dipilih!")
		return false
	
	is_showing_notification = true # Tandai bahwa notifikasi sedang ditampilkan
	
	var is_correct = (current_selected_answer == correct_answers[current_question_index])
	
	if is_correct:
		# Jawaban benar
		consecutive_correct_answers += 1
		print("Jawaban benar! Jawaban benar berturut-turut:", consecutive_correct_answers)
	else:
		# Jawaban salah, reset hitungan jawaban benar berturut-turut
		consecutive_correct_answers = 0
		print("Jawaban salah! Jawaban yang benar adalah:", correct_answers[current_question_index])
	
	is_showing_notification = false # Tandai bahwa notifikasi selesai
	
	return true

func go_to_next_question():
	current_question_index += 1
	if current_question_index >= questions.size():
		current_question_index = 0 # Kembali ke soal pertama jika sudah mencapai akhir
	show_question(current_question_index)

# Fungsi yang akan dipanggil ketika tombol KIRIM ditekan
func _on_kirim_button_pressed():
	print("Tombol KIRIM ditekan!")
	if check_answer():
		# Lanjutkan ke soal berikutnya jika jawaban telah diperiksa
		go_to_next_question()
