extends Button

var is_pressed = false  # Status tombol

func _ready():
	set_button_appearance(Color(0.8, 0.8, 0.8, 0.0))  # Warna awal transparan

func _pressed():
	is_pressed = !is_pressed  # Toggle status

	if is_pressed:
		set_button_appearance(Color(0.8, 0.8, 0.8, 1.0))  # Warna abu-abu saat ditekan
	else:
		set_button_appearance(Color(0.8, 0.8, 0.8, 0.0))  # Kembali transparan

func set_button_appearance(bg_color: Color):
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = bg_color  # Warna latar belakang (bisa transparan)
	
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
	add_theme_stylebox_override("normal", stylebox)
	add_theme_stylebox_override("pressed", stylebox)
	add_theme_stylebox_override("hover", stylebox)
	add_theme_stylebox_override("disabled", stylebox)
