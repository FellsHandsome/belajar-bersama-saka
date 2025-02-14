extends Node

var selected_button = null  # Tombol yang sedang dipilih

func _ready():
	for button in get_children():
		if button is Button:
			button.pressed.connect(_on_button_pressed.bind(button))
			set_button_appearance(button, Color(0.8, 0.8, 0.8, 0.0))  # Awalnya transparan

func _on_button_pressed(button):
	if selected_button == button:
		# Jika tombol yang dipilih ditekan lagi, buat transparan
		set_button_appearance(button, Color(0.8, 0.8, 0.8, 0.0))
		selected_button = null
	else:
		# Reset semua tombol ke transparan
		for btn in get_children():
			if btn is Button:
				set_button_appearance(btn, Color(0.8, 0.8, 0.8, 0.0))
		
		# Ubah warna tombol yang ditekan menjadi abu-abu
		set_button_appearance(button, Color(0.8, 0.8, 0.8, 1.0))
		selected_button = button

func set_button_appearance(button: Button, bg_color: Color):
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = bg_color  # Warna latar belakang

	# Membuat tombol tetap bulat
	stylebox.corner_radius_top_left = 50
	stylebox.corner_radius_top_right = 50
	stylebox.corner_radius_bottom_left = 50
	stylebox.corner_radius_bottom_right = 50

	# Atur border (garis tepi) tipis
	stylebox.border_width_left = 2
	stylebox.border_width_top = 2
	stylebox.border_width_right = 2
	stylebox.border_width_bottom = 2
	stylebox.border_color = Color(0, 0, 0, 1.0)  # Warna garis hitam

	# Menetapkan tampilan tombol
	button.add_theme_stylebox_override("normal", stylebox)
	button.add_theme_stylebox_override("pressed", stylebox)
	button.add_theme_stylebox_override("hover", stylebox)
	button.add_theme_stylebox_override("disabled", stylebox)
