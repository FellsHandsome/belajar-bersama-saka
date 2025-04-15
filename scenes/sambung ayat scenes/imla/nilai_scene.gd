extends Node

# Variabel untuk menyimpan referensi ke node-node soal
var questions = []
var current_question_index = 0
var correct_answers = ["A", "C", "D", "C", "B", "A", "B", "C"]
var current_selected_answer = ""
var is_showing_notification = false

# Variabel untuk skor dan bintang
var player_score = 0
var stars = 0

# Ganti dengan path sebenarnya dari scene nilai_scenes.tscn
var nilai_scene_path = "res://nilai_scenes.tscn"

func _ready():
	var canvas_group = get_node("../CanvasGroup")
	
	if canvas_group == null:
		print("Error: CanvasGroup tidak ditemukan!")
		return
	
	# Ambil node-node soal dari CanvasGroup
	questions = []
	for i in range(1, 9):
		var node_name = "imla soal " + str(i)
		var question_node = canvas_group.get_node(node_name)
		if question_node != null:
			questions.append(question_node)
			print("Node soal ditemukan:", question_node.name)
		else:
			print("Error: Node soal tidak ditemukan! Name:", node_name)
	
	# Sembunyikan semua soal
	for question in questions:
		question.visible = false
	
	# Tampilkan soal pertama
	if questions.size() > 0:
		show_question(current_question_index)
	else:
		print("Error: Tidak ada soal yang ditemukan!")
	
	var kirim_button = canvas_group.get_node("Button")
	if kirim_button != null:
		kirim_button.connect("pressed", Callable(self, "_on_kirim_button_pressed"))
		print("Tombol KIRIM terhubung dengan sinyal pressed")
	else:
		print("Error: Button KIRIM tidak ditemukan!")
	
	connect_option_buttons()

func connect_option_buttons():
	for question in questions:
		var option_buttons = []
		var all_buttons = get_all_children(question)
		for node in all_buttons:
			if (node is Button or node is CheckBox or node is TextureButton):
				for letter in ["A", "B", "C", "D"]:
					if letter in node.name:
						option_buttons.append({"node": node, "letter": letter})
						break
		
		for option in option_buttons:
			var button = option["node"]
			var letter = option["letter"]
			if button.has_signal("toggled"):
				if not button.toggled.is_connected(Callable(self, "_on_option_toggled")):
					button.toggled.connect(Callable(self, "_on_option_toggled").bind(letter, button))
			else:
				if not button.pressed.is_connected(Callable(self, "_on_option_pressed")):
					button.pressed.connect(Callable(self, "_on_option_pressed").bind(letter, button))
			print("Terhubung tombol pilihan:", button.name, "dengan jawaban:", letter)

func get_all_children(node):
	var children = []
	for child in node.get_children():
		children.append(child)
		children.append_array(get_all_children(child))
	return children

func _on_option_toggled(toggled, option_letter, button):
	if toggled:
		select_answer(option_letter)
		button.modulate = Color(0.5, 0.5, 0.5)
		reset_other_option_buttons(button)

func _on_option_pressed(option_letter, button):
	select_answer(option_letter)
	button.modulate = Color(0.5, 0.5, 0.5)
	reset_other_option_buttons(button)

func reset_other_option_buttons(selected_button):
	var parent = selected_button.get_parent()
	var all_buttons = get_all_children(parent)
	for button in all_buttons:
		if button != selected_button and (button is Button or button is CheckBox or button is TextureButton):
			button.modulate = Color(1, 1, 1)
			if button is CheckBox and button.button_pressed:
				button.button_pressed = false

func select_answer(option_letter):
	current_selected_answer = option_letter
	print("Pilihan yang dipilih:", current_selected_answer)

func show_question(index):
	if index < 0 or index >= questions.size():
		print("Error: Index soal tidak valid!")
		return
	for question in questions:
		question.visible = false
	questions[index].visible = true
	print("Menampilkan soal:", questions[index].name)
	current_selected_answer = ""
	var all_buttons = get_all_children(questions[index])
	for button in all_buttons:
		if button is Button or button is CheckBox or button is TextureButton:
			button.modulate = Color(1, 1, 1)
			if button is CheckBox and button.button_pressed:
				button.button_pressed = false

func check_answer():
	if is_showing_notification:
		return false
	if current_selected_answer == "":
		print("Belum ada jawaban yang dipilih!")
		return false
	is_showing_notification = true
	if current_selected_answer == correct_answers[current_question_index]:
		player_score += 375
		print("Jawaban benar! Skor saat ini:", player_score)
	else:
		print("Jawaban salah! Jawaban yang benar adalah:", correct_answers[current_question_index])
	is_showing_notification = false
	return true

func go_to_next_question():
	current_question_index += 1
	if current_question_index >= questions.size():
		show_nilai_scene()
	else:
		show_question(current_question_index)

func show_nilai_scene():
	print("Semua soal telah dijawab.")
	print("Skor Akhir:", player_score)

	var scene_res = load(nilai_scene_path)
	if scene_res == null:
		print("Error: Gagal memuat scene nilai!")
		return

	var nilai_scene_instance = scene_res.instantiate()
	if nilai_scene_instance == null:
		print("Error: Gagal membuat instance dari scene nilai!")
		return

	nilai_scene_instance.set_score_and_stars(player_score, calculate_stars(player_score))
	get_tree().root.add_child(nilai_scene_instance)

func calculate_stars(score):
	if score >= 9000:
		return 3
	elif score >= 4500:
		return 2
	elif score >= 2250:
		return 1
	else:
		return 0

func _on_kirim_button_pressed():
	print("Tombol KIRIM ditekan!")
	if check_answer():
		go_to_next_question()
