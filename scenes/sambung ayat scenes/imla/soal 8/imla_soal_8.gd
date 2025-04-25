extends Node2D
@onready var soal_manager = $"../../../SoalManager"
@export var nomor_soal: int = 1
var jawaban_terpilih: String = ""

# Cari node dengan nama yang benar
# Sesuaikan dengan nama node yang sebenarnya di scene Anda
@onready var opsi_a = $A  # Jika node pilihan A sebenarnya bernama "A"
@onready var opsi_b = $B  # Jika node pilihan B sebenarnya bernama "B"
@onready var opsi_c = $C  # Jika node pilihan C sebenarnya bernama "C"
@onready var opsi_d = $D  # Jika node pilihan D sebenarnya bernama "D"

func _ready():
	print("ImLaSoal", nomor_soal, "_ready() called")
	# Debug untuk memeriksa node yang ditemukan
	print("Node OpsiA found:", opsi_a != null)
	print("Node OpsiB found:", opsi_b != null)
	print("Node OpsiC found:", opsi_c != null)
	print("Node OpsiD found:", opsi_d != null)
	
	setup_opsi_signals()
	restore_jawaban()

func setup_opsi_signals():
	setup_opsi_signal(opsi_a, "a")
	setup_opsi_signal(opsi_b, "b")
	setup_opsi_signal(opsi_c, "c")
	setup_opsi_signal(opsi_d, "d")

func setup_opsi_signal(opsi_node, jawaban):
	if not opsi_node:
		print("Opsi node", jawaban, "tidak ditemukan")
		return
		
	if opsi_node is Button:
		# Disconnect existing connections first to avoid duplicates
		if opsi_node.is_connected("pressed", Callable(self, "on_opsi_pressed")):
			opsi_node.pressed.disconnect(Callable(self, "on_opsi_pressed"))
		
		opsi_node.pressed.connect(func(): on_opsi_pressed(jawaban))
		print("Setup signal untuk Button", jawaban)
	elif opsi_node is Sprite2D:
		opsi_node.set_process_input(true)
		var area = opsi_node.get_node_or_null("ClickArea")
		if not area:
			area = Area2D.new()
			area.name = "ClickArea"
			opsi_node.add_child(area)
			var collision = CollisionShape2D.new()
			collision.shape = RectangleShape2D.new()
			if opsi_node.texture:
				collision.shape.extents = opsi_node.texture.get_size() / 2
			else:
				collision.shape.extents = Vector2(50, 50)
			area.add_child(collision)
			area.input_event.connect(func(_v, event, _i):
				if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
					on_opsi_pressed(jawaban)
			)
			print("Setup signal untuk Sprite2D", jawaban)

func on_opsi_pressed(jawaban: String):
	print("Opsi", jawaban, "dipilih untuk soal", nomor_soal)
	reset_opsi()
	
	# Pastikan jawaban disimpan dalam lowercase
	jawaban_terpilih = jawaban.to_lower()
	
	# Highlight opsi yang dipilih
	highlight_opsi(jawaban.to_upper())
	
	if soal_manager:
		# Gunakan fungsi set_jawaban
		soal_manager.set_jawaban(nomor_soal, jawaban_terpilih)
		print("Jawaban", jawaban_terpilih, "dikirim ke SoalManager untuk soal", nomor_soal)
	else:
		print("ERROR: SoalManager tidak ditemukan!")

func reset_opsi():
	for opsi in [opsi_a, opsi_b, opsi_c, opsi_d]:
		if opsi:
			opsi.modulate = Color(1, 1, 1, 1)

func highlight_opsi(huruf: String):
	var opsi_dict = {
		"A": opsi_a,
		"B": opsi_b,
		"C": opsi_c,
		"D": opsi_d
	}
	var target_opsi = opsi_dict.get(huruf, null)
	if target_opsi:
		target_opsi.modulate = Color(0.8, 1, 0.8, 1)
		print("Opsi", huruf, "dihighlight")
	else:
		print("ERROR: Opsi", huruf, "tidak ditemukan untuk highlight")

func restore_jawaban():
	if soal_manager and soal_manager.jawaban_user.has(nomor_soal):
		var jawaban = soal_manager.jawaban_user[nomor_soal]
		if jawaban != "":
			jawaban_terpilih = jawaban
			highlight_opsi(jawaban.to_upper())
			print("Restore jawaban", jawaban, "untuk soal", nomor_soal)

func get_jawaban_terpilih() -> String:
	return jawaban_terpilih

func set_nomor_soal(nomor: int):
	nomor_soal = nomor
