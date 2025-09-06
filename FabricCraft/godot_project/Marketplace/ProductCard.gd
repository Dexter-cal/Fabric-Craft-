extends PanelContainer

@onready var name_label = $VBoxContainer/NameLabel
@onready var price_label = $VBoxContainer/PriceLabel
@onready var image_rect = $VBoxContainer/ProductImage

func set_data(product_data: Dictionary):
	name_label.text = product_data.get("name", "N/A")
	price_label.text = "$%.2f" % product_data.get("price", 0.0)

	# In a real game, you'd handle image loading more robustly,
	# possibly downloading from a URL if the backend provided one.
	# For now, we assume the path is local.
	var image_path = product_data.get("image", "")
	if not image_path.is_empty():
		image_rect.texture = load(image_path)
	else:
		# Use a placeholder if no image is provided
		image_rect.texture = load("res://icon.svg")
