extends Node2D

# Referensi ke SoalManager
@onready var soal_manager = $"../../../SoalManager"

# Nomor soal ini
@export var nomor_soal: int = 1

# Opsi jawaban (sesuaikan berdasarkan node di scene)
# Asumsikan setiap opsi adalah button, sprite, atau area yang bisa diklik
@onready var opsi_a = $OpsiA
@onready var opsi_b = $OpsiB
@onready var opsi_c = $OpsiC
@onready var opsi_d = $OpsiD

func _ready():
	# Connect signals
	_setup_opsi_signals()
	
	# Restore jawaban jika ada
	restore_jawaban()

# Setup signals untuk opsi
func _setup_opsi_signals():
	# Untuk setiap opsi, kita perlu menyesuaikan berdasarkan tipe node
	_setup_opsi_signal(opsi_a, "A")
	_setup_opsi_signal(opsi_b, "B")
	_setup_opsi_signal(opsi_c, "C")
	_setup_opsi_signal(opsi_d, "D")

# Setup signal untuk satu opsi
func _setup_opsi_signal(opsi_node, jawaban):
	if not opsi_node:
		return
		
	if opsi_node is Button:
		# Jika opsi adalah button
		opsi_node.pressed.connect(func(): _on_opsi_pressed(jawaban))
	elif opsi_node is Sprite2D:
		# Jika opsi adalah sprite, tambahkan area2D untuk deteksi klik
		opsi_node.set_process_input(true)
		
		# Tambahkan area2D untuk deteksi klik jika belum ada
		var area = opsi_node.get_node_or_null("ClickArea")
		if not area:
			area = Area2D.new()
			area.name = "ClickArea"
			opsi_node.add_child(area)
			
			var collision = CollisionShape2D.new()
			collision.shape = RectangleShape2D.new()
			# Sesuaikan ukuran dengan ukuran sprite
			if opsi_node.texture:
				collision.shape.extents = opsi_node.texture.get_size() / 2
			else:
				collision.shape.extents = Vector2(50, 50) # Default jika tidak ada texture
			area.add_child(collision)
			
			# Connect signal
			area.input_event.connect(func(_viewport, event, _shape_idx): 
				if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
					_on_opsi_pressed(jawaban)
			)

# Ketika opsi ditekan
func _on_opsi_pressed(jawaban: String):
	# Reset tampilan semua opsi
	reset_opsi()
	
	# Highlight opsi yang dipilih
	highlight_opsi(jawaban)
	
	# Set jawaban ke SoalManager
	if soal_manager:
		soal_manager.set_jawaban(nomor_soal, jawaban)

# Reset tampilan semua opsi
func reset_opsi():
	var opsi_list = [opsi_a, opsi_b, opsi_c, opsi_d]
	for opsi in opsi_list:
		if opsi:
			opsi.modulate = Color(1, 1, 1, 1) # Reset warna

# Highlight opsi yang dipilih
func highlight_opsi(opsi_huruf: String):
	var target_opsi
	match opsi_huruf:
		"A": target_opsi = opsi_a
		"B": target_opsi = opsi_b
		"C": target_opsi = opsi_c
		"D": target_opsi = opsi_d
	
	if target_opsi:
		target_opsi.modulate = Color(0.8, 1, 0.8, 1) # Highlight dengan warna hijau

# Restore jawaban jika sebelumnya sudah dijawab
func restore_jawaban():
	if soal_manager:
		var jawaban = soal_manager.jawaban_user[nomor_soal]
		if jawaban != "":
			highlight_opsi(jawaban)
