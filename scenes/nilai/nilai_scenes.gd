#extends Node
#
#var bintang1
#var bintang2
#var bintang3
#var bintang_kuning1
#var bintang_kuning2
#var bintang_kuning3
#var nilai_label
#
#func _ready():
	## Tunggu hingga tree benar-benar siap
	#call_deferred("_initialize_nodes")
	#
#func _initialize_nodes():
	## Cari semua node yang diperlukan
	#bintang1 = get_node_or_null("TextureRect/Bintang1")
	#bintang2 = get_node_or_null("TextureRect/Bintang2")
	#bintang3 = get_node_or_null("TextureRect/Bintang3")
	#bintang_kuning1 = get_node_or_null("TextureRect/BintangKuning1")
	#bintang_kuning2 = get_node_or_null("TextureRect/BintangKuning2")
	#bintang_kuning3 = get_node_or_null("TextureRect/BintangKuning3")
	#nilai_label = get_node_or_null("TextureRect/AssetsnIlai3")
	#
	## Debugging
	#print("Nodes found:")
	#print("Bintang1:", bintang1)
	#print("Bintang2:", bintang2)
	#print("Bintang3:", bintang3)
	#print("BintangKuning1:", bintang_kuning1)
	#print("BintangKuning2:", bintang_kuning2)
	#print("BintangKuning3:", bintang_kuning3)
	#
	## Pastikan bintang abu-abu terlihat
	#if bintang1:
		#bintang1.visible = true
	#else:
		#print("Bintang1 tidak ditemukan!")
		#
	#if bintang2:
		#bintang2.visible = true
	#else:
		#print("Bintang2 tidak ditemukan!")
		#
	#if bintang3:
		#bintang3.visible = true
	#else:
		#print("Bintang3 tidak ditemukan!")
	#
	## Sembunyikan bintang kuning di awal
	#if bintang_kuning1:
		#bintang_kuning1.visible = false
	#else:
		#print("BintangKuning1 tidak ditemukan!")
		#
	#if bintang_kuning2:
		#bintang_kuning2.visible = false
	#else:
		#print("BintangKuning2 tidak ditemukan!")
		#
	#if bintang_kuning3:
		#bintang_kuning3.visible = false
	#else:
		#print("BintangKuning3 tidak ditemukan!")
#
#func set_nilai_text(nilai):
	#print("Nilai yang diterima:", nilai)
	#
	## Tampilkan nilai jika ada label
	#if nilai_label:
		#nilai_label.text = str(nilai)
	#else:
		#print("Label nilai tidak ditemukan!")
	#
	## Logika menampilkan bintang sesuai nilai
	#if bintang_kuning1:
		#bintang_kuning1.visible = (nilai > 1000)
		#print("Bintang kuning 1:", bintang_kuning1.visible)
	#
	#if bintang_kuning2:
		#bintang_kuning2.visible = (nilai > 2000)
		#print("Bintang kuning 2:", bintang_kuning2.visible)
	#
	#if bintang_kuning3:
		#bintang_kuning3.visible = (nilai == 3000)
		#print("Bintang kuning 3:", bintang_kuning3.visible)
#
## Fungsi bantuan untuk debugging
#func print_node_tree():
	#print("\n--- STRUKTUR NODE ---")
	#_print_node_and_children(self)
	#print("--------------------\n")
#
#func _print_node_and_children(node, indent=""):
	#print(indent + node.name)
	#for child in node.get_children():
		#_print_node_and_children(child, indent + "  ")
