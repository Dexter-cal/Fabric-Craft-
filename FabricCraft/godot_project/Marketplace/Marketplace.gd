extends Control

const ProductCardScene = preload("res://Marketplace/ProductCard.tscn")

@onready var product_grid = $VBoxContainer/ScrollContainer/ProductGrid
@onready var http_request = HTTPRequest.new()

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
		for product_data in products:
			var card = ProductCardScene.instantiate()
			product_grid.add_child(card)
			card.set_data(product_data)
