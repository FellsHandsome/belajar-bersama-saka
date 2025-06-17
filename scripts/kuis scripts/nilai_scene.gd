extends Node

@onready var label_nilai = $LabelNilai

@onready var bintang_putih = [
	$BintangPutih1,   # index 0 = kiri
	$BintangPutih2,   # index 1 = tengah
	$BintangPutih3    # index 2 = kanan
]
@onready var bintang_kuning = [
	$BintangKuning1,  # index 0 = kiri
	$BintangKuning2,  # index 1 = tengah
	$BintangKuning3   # index 2 = kanan
]

func tampilkan_nilai():
	var skor = Global.skor
	if label_nilai:
		label_nilai.text = str(skor)

	var bintang = 0
	if skor >= 2999:
		bintang = 3
	elif skor >= 2249:
		bintang = 2
	elif skor >= 1124:
		bintang = 1
	else:
		bintang = 0

	# Reset semua bintang ke tidak kelihatan
	for i in range(3):
		bintang_putih[i].visible = false
		bintang_kuning[i].visible = false

	if bintang == 1:
		# Hanya BintangPutih1 dan BintangKuning1 yang nyala (kiri)
		bintang_putih[0].visible = true
		bintang_kuning[0].visible = true
	elif bintang == 2:
		# Bintang kuning kiri & tengah, putih kanan
		bintang_kuning[0].visible = true
		bintang_kuning[1].visible = true
		bintang_putih[2].visible = true
	elif bintang == 3:
		# Semua kuning
		for i in range(3):
			bintang_kuning[i].visible = true
