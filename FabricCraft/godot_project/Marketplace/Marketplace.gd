extends Control

const ProductCardScene = preload("res://Marketplace/ProductCard.tscn")

@onready var product_grid = $ScrollContainer/ProductGrid
@onready var http_request = HTTPRequest.new()

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	fetch_products()

func fetch_products():
	# This request goes to the backend server we created.
	http_request.request("http://localhost:3000/api/marketplace/products")

func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS or response_code >= 400:
		print("Error fetching products from backend.")
		return

	var products = JSON.parse_string(body.get_string_from_utf8())
	if products:
		populate_grid(products)

func populate_grid(products_data):
	# Clear any existing cards before populating
	for child in product_grid.get_children():
		child.queue_free()

	for product_data in products_data:
		var card = ProductCardScene.instantiate()
		product_grid.add_child(card)
		card.set_data(product_data)
