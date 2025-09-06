extends Control

@onready var toolbar = $VBoxContainer/Toolbar
@onready var canvas = $VBoxContainer/Canvas2D
@onready var back_button = $BackButton

func _ready():
	# Connect the Back button
	back_button.pressed.connect(_on_back_button_pressed)

	# --- Connect Toolbar Signals ---
	var tool_button_group = ButtonGroup.new()
	var draw_button = toolbar.get_node("DrawButton")
	var cut_button = toolbar.get_node("CutButton")
	var stitch_button = toolbar.get_node("StitchButton")

	draw_button.button_group = tool_button_group
	cut_button.button_group = tool_button_group
	stitch_button.button_group = tool_button_group

	draw_button.toggled.connect(canvas.set_active_mode.bind(canvas.Mode.DRAW))
	cut_button.toggled.connect(canvas.set_active_mode.bind(canvas.Mode.CUT))
	stitch_button.toggled.connect(canvas.set_active_mode.bind(canvas.Mode.STITCH))

	# Set initial state
	draw_button.button_pressed = true

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Accounts/UserDashboard/UserDashboard.tscn")
