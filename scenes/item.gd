extends Button
class_name Skinitem

@export var item_name : String
@export var item_texture: Texture
@export var given_item_texture: Texture

@onready var title_label = $Boxes/Title/TitleLabel
@onready var texture_rect = $Boxes/Icon/TextureRect

func _ready():
	title_label.text = item_name
	texture_rect.texture = item_texture
