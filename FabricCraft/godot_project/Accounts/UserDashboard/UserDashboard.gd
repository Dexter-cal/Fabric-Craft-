extends Control

@onready var header_label = $VBoxContainer/HeaderLabel
@onready var open_engine_button = $VBoxContainer/OpenDesignEngineButton

func _ready():
	header_label.text = "Welcome to your Dashboard!"
	open_engine_button.pressed.connect(_on_open_design_engine_pressed)

func _on_open_design_engine_pressed():
	# This path will be created in the next step
	get_tree().change_scene_to_file("res://DesignEngine/DesignEngine.tscn")
