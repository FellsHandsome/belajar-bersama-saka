extends Node

# Menyimpan referensi button yang sedang dipilih
var selected_button: Button = null

func _ready():
	for button in get_children():
		if button is Button:
			button.pressed.connect(_on_button_pressed.bind(button))	
			set_button_appearance(button, Color(0.8, 0.8, 0.8, 0.0))  # Transparan awal

func _on_button_pressed(button: Button):
	if selected_button == button:
		set_button_appearance(button, Color(0.8, 0.8, 0.8, 0.0))
		selected_button = null
	else:
		for btn in get_children():
			if btn is Button:
				set_button_appearance(btn, Color(0.8, 0.8, 0.8, 0.0))
		set_button_appearance(button, Color(0.7, 0.7, 0.7, 1.0))  # Abu-abu saat dipilih
		selected_button = button

func set_button_appearance(button: Button, bg_color: Color):
	var stylebox := StyleBoxFlat.new()
	stylebox.bg_color = bg_color
	stylebox.corner_radius_top_left = 50
	stylebox.corner_radius_top_right = 50
	stylebox.corner_radius_bottom_left = 50
	stylebox.corner_radius_bottom_right = 50
	stylebox.border_width_left = 2
	stylebox.border_width_top = 2
	stylebox.border_width_right = 2
	stylebox.border_width_bottom = 2
	stylebox.border_color = Color(0, 0, 0, 1.0)
	button.add_theme_stylebox_override("normal", stylebox)
	button.add_theme_stylebox_override("pressed", stylebox)
	button.add_theme_stylebox_override("hover", stylebox)
	button.add_theme_stylebox_override("disabled", stylebox)

# Fungsi untuk diakses SoalManager, mengembalikan pilihan ('a', 'b', 'c', 'd') atau "" jika belum ada
func get_selected_pilihan() -> String:
	if selected_button == null:
		return ""
	return selected_button.name.right(1).to_lower() # Mengambil huruf terakhir dari nama button (A/B/C/D)
