extends Control

@onready var marketplace_button = $VBoxContainer/MarketplaceButton
@onready var community_button = $VBoxContainer/CommunityButton
@onready var design_engine_button = $VBoxContainer/DesignEngineButton

func _ready():
	marketplace_button.pressed.connect(_on_marketplace_pressed)
	community_button.pressed.connect(_on_community_pressed)
	design_engine_button.pressed.connect(_on_design_engine_pressed)

func _on_marketplace_pressed():
	get_tree().change_scene_to_file("res://Marketplace/Marketplace.tscn")

func _on_community_pressed():
	get_tree().change_scene_to_file("res://Community/CommunityFeed.tscn")

func _on_design_engine_pressed():
	get_tree().change_scene_to_file("res://DesignEngine/DesignEngine.tscn")
