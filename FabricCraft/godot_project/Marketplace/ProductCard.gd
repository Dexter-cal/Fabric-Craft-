extends PanelContainer

@onready var name_label = $VBoxContainer/NameLabel
@onready var price_label = $VBoxContainer/PriceLabel
@onready var image_rect = $VBoxContainer/ProductImage

const PLACEHOLDER_IMAGE = preload("res://assets/placeholder.png")

func set_data(product_data: Dictionary):
	name_label.text = product_data.get("name", "N/A")
	price_label.text = "$%.2f" % product_data.get("price", 0.0)
	image_rect.texture = PLACEHOLDER_IMAGE
