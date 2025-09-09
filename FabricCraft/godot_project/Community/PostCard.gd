extends PanelContainer

@onready var creator_label = $VBoxContainer/CreatorLabel
@onready var post_image = $VBoxContainer/PostImage
@onready var caption_label = $VBoxContainer/CaptionLabel
@onready var like_button = $VBoxContainer/LikeButton

func set_data(post_data: Dictionary):
	creator_label.text = post_data.get("creator", "N/A")
	caption_label.text = post_data.get("caption", "")
	like_button.text = "Like (%d)" % post_data.get("likes", 0)
	var image_path = post_data.get("image", "")
	if not image_path.is_empty() and FileAccess.file_exists(image_path):
		post_image.texture = load(image_path)
