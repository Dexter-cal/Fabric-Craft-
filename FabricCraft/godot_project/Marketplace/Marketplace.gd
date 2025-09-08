extends Control

const ProductCardScene = preload("res://Marketplace/ProductCard.tscn")
const ProductDetailPageScene = preload("res://Marketplace/ProductDetailPage.tscn")

@onready var scroll_container = $ScrollContainer
@onready var product_grid = $ScrollContainer/ProductGrid
@onready var http_request = HTTPRequest.new()

var current_detail_page = null

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	fetch_products()

func fetch_products():
	http_request.request("http://localhost:3000/api/marketplace/products")

func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS or response_code >= 400:
		print("Error fetching products.")
		return
	var products = JSON.parse_string(body.get_string_from_utf8())
	if products:
		populate_grid(products)

func populate_grid(products_data):
	for child in product_grid.get_children():
		child.queue_free()
	for product_data in products_data:
		var card = ProductCardScene.instantiate()
		product_grid.add_child(card)
		card.set_data(product_data)
		card.gui_input.connect(_on_product_card_pressed.bind(product_data))

func _on_product_card_pressed(event, product_data):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if current_detail_page != null:
			return

		scroll_container.visible = false
		current_detail_page = ProductDetailPageScene.instantiate()
		add_child(current_detail_page)
		current_detail_page.set_data(product_data)
		current_detail_page.back_pressed.connect(hide_detail_page)

func hide_detail_page():
	if current_detail_page != null:
		current_detail_page.queue_free()
		current_detail_page = null
	scroll_container.visible = true
