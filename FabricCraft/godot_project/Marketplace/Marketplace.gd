extends Control

const ProductCardScene = preload("res://Marketplace/ProductCard.tscn")

@onready var product_grid = $ScrollContainer/ProductGrid

# Hardcoded product data, as planned. No backend call.
const products = [
  { "name": "Classic T-Shirt", "price": 19.99 },
  { "name": "Denim Jeans", "price": 49.99 },
  { "name": "Running Shoes", "price": 79.99 },
  { "name": "Leather Jacket", "price": 149.99 },
  { "name": "Beanie Hat", "price": 14.99 },
  { "name": "Smartphone X", "price": 699.99 },
  { "name": "Leather Sofa", "price": 899.99 },
  { "name": "Coffee Mug", "price": 9.99 },
]

func _ready():
	populate_grid()

func populate_grid():
	for product_data in products:
		var card = ProductCardScene.instantiate()
		product_grid.add_child(card)
		card.set_data(product_data)
