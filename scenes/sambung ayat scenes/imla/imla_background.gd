extends Node

# Referensi ke SoalManager
@onready var soal_manager = $SoalManager

func _ready():
	# Pastikan SoalManager ditemukan
	if soal_manager == null:
		print("Error: SoalManager tidak ditemukan!")
		return
	
	# Inisialisasi SoalManager
	soal_manager.initialize()

	# Hubungkan sinyal dari SoalManager untuk berpindah scene
	soal_manager.connect("all_questions_answered", self, "_on_all_questions_answered")

# Fungsi yang dipanggil ketika semua soal selesai dijawab
func _on_all_questions_answered():
	# Pindah ke "nilai scene"
	get_tree().change_scene_to_file("res://nilai_scene.tscn")
