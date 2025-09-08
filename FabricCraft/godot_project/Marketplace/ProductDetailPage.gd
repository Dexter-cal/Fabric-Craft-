extends PanelContainer

signal back_pressed

@onready var name_label = $MarginContainer/VBoxContainer/NameLabel
@onready var image_rect = $MarginContainer/VBoxContainer/ProductImage
@onready var description_label = $MarginContainer/VBoxContainer/DescriptionLabel
@onready var back_button = $MarginContainer/VBoxContainer/BackButton

func _ready():
	back_button.pressed.connect(_on_back_button_pressed)

func set_data(product_data: Dictionary):
	name_label.text = product_data.get("name", "N/A")
	description_label.text = product_data.get("description", "")

	var image_path = product_data.get("image", "")
	if not image_path.is_empty() and FileAccess.file_exists(image_path):
		image_rect.texture = load(image_path)
	else:
		if FileAccess.file_exists("res://assets/placeholder.png"):
			image_rect.texture = load("res://assets/placeholder.png")
		else:
			image_rect.texture = null

func _on_back_button_pressed():
	back_pressed.emit()
