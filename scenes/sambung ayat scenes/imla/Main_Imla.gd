extends Node

# Variabel untuk menyimpan referensi ke node-node soal
var questions = []
var current_question_index = 0

# Array untuk menyimpan jawaban yang benar
var correct_answers = ["A", "C", "D", "C", "B", "A", "B", "C"]

# Referensi ke node notifikasi
var pintar_notification
var hebat_notification
var cobalagi_notification

# Variabel untuk menandai apakah notifikasi sedang ditampilkan
var is_showing_notification = false

# Untuk melacak jawaban benar berturut-turut
var consecutive_correct_answers = 0

func _ready():
	# Initialize notification references
	pintar_notification = $Notifications/Pintar
	hebat_notification = $Notifications/Hebat
	cobalagi_notification = $Notifications/Coba_lagi
	
	# Debug: Print notification nodes to see if they're found
	print("Pintar node: ", pintar_notification)
	print("Hebat node: ", hebat_notification)
	print("Coba lagi node: ", cobalagi_notification)
	
	# Dapatkan referensi ke CanvasGroup
	var canvas_group = $CanvasGroup
	
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
	
	# Sembunyikan semua notifikasi jika mereka ada
	if pintar_notification != null:
		pintar_notification.visible = false
	if hebat_notification != null:
		hebat_notification.visible = false
	if cobalagi_notification != null:
		cobalagi_notification.visible = false
	
	# Tampilkan soal pertama saat game dimulai
	show_question(current_question_index)
	
	# Hubungkan sinyal dari tombol-tombol jawaban
	connect_answer_buttons()

func connect_answer_buttons():
	# Pastikan setiap soal memiliki tombol jawaban A, B, C, dan D
	for question in questions:
		# Cari semua tombol jawaban dalam soal
		var buttons = question.find_children("*", "Button")
		for button in buttons:
			# Dapatkan jawaban dari nama tombol atau properti lain
			var answer = button.name.right(1)  # Misalnya jika nama tombol adalah "OptionA", ambil "A"
			# Hubungkan sinyal pressed ke fungsi on_answer_button_pressed
			button.pressed.connect(on_answer_button_pressed.bind(answer))

func show_question(index):
	# Sembunyikan semua soal
	for question in questions:
		question.visible = false
	
	# Tampilkan soal yang dipilih
	questions[index].visible = true
	print("Menampilkan soal:", questions[index].name)

func check_answer(selected_answer):
	if is_showing_notification:
		return  # Jangan proses jawaban jika notifikasi sedang ditampilkan
	
	is_showing_notification = true  # Tandai bahwa notifikasi sedang ditampilkan
	
	if selected_answer == correct_answers[current_question_index]:
		# Jawaban benar
		consecutive_correct_answers += 1
		
		# Jika jawaban benar berturut-turut lebih dari 1, tampilkan "Pintar"
		if consecutive_correct_answers > 1:
			if pintar_notification != null:
				await show_notification(pintar_notification)
		else:
			# Jika hanya 1 jawaban benar, tampilkan "Hebat"
			if hebat_notification != null:
				await show_notification(hebat_notification)
	else:
		# Jawaban salah, reset hitungan jawaban benar berturut-turut
		consecutive_correct_answers = 0
		# Tampilkan notifikasi "Coba lagi"
		if cobalagi_notification != null:
			await show_notification(cobalagi_notification)
	
	is_showing_notification = false  # Tandai bahwa notifikasi selesai
	
	# Lanjutkan ke soal berikutnya setelah notifikasi selesai
	go_to_next_question()

func show_notification(notification_node):
	# Check if notification_node is valid
	if notification_node == null:
		print("Error: Notification node is null!")
		return
		
	# Sembunyikan semua notifikasi terlebih dahulu
	if pintar_notification != null:
		pintar_notification.visible = false
	if hebat_notification != null:
		hebat_notification.visible = false
	if cobalagi_notification != null:
		cobalagi_notification.visible = false
	
	# Tampilkan notifikasi yang dipilih
	notification_node.visible = true
	
	# Check if AnimationPlayer exists
	var anim_player = notification_node.get_node_or_null("AnimationPlayer")
	if anim_player == null:
		print("Error: AnimationPlayer not found for notification:", notification_node.name)
		await get_tree().create_timer(2.0).timeout
		notification_node.visible = false
		return
	
	# Mainkan animasi muncul (scale up)
	anim_player.play("show_notification")
	
	# Tunggu animasi muncul selesai
	await anim_player.animation_finished
	
	# Tunggu 2 detik
	await get_tree().create_timer(2.0).timeout
	
	# Mainkan animasi menghilang (scale down)
	anim_player.play("hide_notification")
	
	# Tunggu animasi menghilang selesai
	await anim_player.animation_finished
	
	# Sembunyikan notifikasi
	notification_node.visible = false

func go_to_next_question():
	current_question_index += 1
	if current_question_index >= questions.size():
		current_question_index = 0  # Kembali ke soal pertama jika sudah mencapai akhir
	show_question(current_question_index)

# Fungsi yang akan dipanggil ketika tombol jawaban ditekan
func on_answer_button_pressed(selected_answer):
	print("Jawaban yang dipilih:", selected_answer)
	check_answer(selected_answer)

# Fungsi yang akan dipanggil ketika tombol next ditekan
func _on_next_button_pressed():
	print("Tombol Next ditekan! Pindah ke soal berikutnya.")
	go_to_next_question()
