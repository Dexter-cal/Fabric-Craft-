extends Control

@onready var open_engine_button = $VBoxContainer/OpenDesignEngineButton

func _ready():
	open_engine_button.pressed.connect(_on_open_design_engine_pressed)

func _on_open_design_engine_pressed():
	# This path will be created in a later step.
	get_tree().change_scene_to_file("res://DesignEngine/DesignEngine.tscn")
