#extends Control
#
## Variabel untuk menyimpan skor dan jumlah bintang
#var player_score = 0
#var stars = 0
#
## Fungsi untuk menerima data dari SoalManager
#func set_score_and_stars(score, star_count):
	#player_score = score
	#stars = star_count
	#update_ui()
#
## Fungsi untuk memperbarui tampilan UI
#func update_ui():
	## Tampilkan skor dan jumlah bintang di UI
	#var score_label = get_node("ScoreLabel")
	#var stars_label = get_node("StarsLabel")
	#
	#if score_label:
		#score_label.text = "Skor: " + str(player_score)
	#if stars_label:
		#stars_label.text = "Bintang: " + str(stars)
#
#func _ready():
	## Pastikan tampilan UI diperbarui ketika scene dimuat
	#update_ui()
