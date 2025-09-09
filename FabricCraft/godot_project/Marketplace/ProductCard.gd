extends PanelContainer

@onready var name_label = $VBoxContainer/NameLabel
@onready var price_label = $VBoxContainer/PriceLabel
@onready var image_rect = $VBoxContainer/ProductImage

func set_data(product_data: Dictionary):
	name_label.text = product_data.get("name", "N/A")
	price_label.text = "$%.2f" % product_data.get("price", 0.0)
	var image_path = product_data.get("image", "")
	if not image_path.is_empty() and FileAccess.file_exists(image_path):
		image_rect.texture = load(image_path)
