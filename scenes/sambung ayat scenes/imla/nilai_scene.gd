extends Control

@onready var soal_manager = $"../SoalManager"
@onready var assets_nilai = $"AssetsNilai-3"
@onready var button_nilai = $"ButtonNilai-1"
@onready var label_nilai: Label = null

func _ready():
	visible = false

	# Siapkan label nilai
	if assets_nilai and assets_nilai is Sprite2D:
		label_nilai = assets_nilai.get_node_or_null("NilaiLabel")
		
		if not label_nilai:
			label_nilai = Label.new()
			label_nilai.name = "NilaiLabel"
			label_nilai.position = Vector2(100, 100) # Ubah sesuai kebutuhan
			label_nilai.set("theme_override_colors/font_color", Color.BLACK)
			label_nilai.set("theme_override_font_sizes/font_size", 32)
			assets_nilai.add_child(label_nilai)

	# Siapkan tombol kembali
	if button_nilai and button_nilai is Sprite2D:
		button_nilai.set_process_input(true)
		var area = button_nilai.get_node_or_null("ButtonArea")
		if not area:
			area = Area2D.new()
			area.name = "ButtonArea"
			button_nilai.add_child(area)

			var collision = CollisionShape2D.new()
			var rect = RectangleShape2D.new()
			rect.extents = button_nilai.texture.get_size() / 2
			collision.shape = rect
			area.add_child(collision)

			area.input_event.connect(_on_button_area_input_event)

func set_nilai_text(nilai: float):
	if label_nilai:
		label_nilai.text = "Nilai: " + str(int(nilai))

func _on_button_area_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_on_back_button_pressed()

func _on_back_button_pressed():
	if soal_manager:
		soal_manager._on_nilai_button_pressed()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
