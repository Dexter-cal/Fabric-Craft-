extends Control

@onready var toolbar = $VBoxContainer/Toolbar
@onready var canvas = $VBoxContainer/Canvas2D

func _ready():
	var tool_button_group = ButtonGroup.new()

	var draw_button = toolbar.get_node("DrawButton")
	var cut_button = toolbar.get_node("CutButton")
	var stitch_button = toolbar.get_node("StitchButton")

	draw_button.button_group = tool_button_group
	cut_button.button_group = tool_button_group
	stitch_button.button_group = tool_button_group

	draw_button.toggled.connect(
		func(is_toggled):
			if is_toggled: canvas.set_active_mode(canvas.Mode.DRAW)
			else: canvas.disable_all_modes()
	)
	cut_button.toggled.connect(
		func(is_toggled):
			if is_toggled: canvas.set_active_mode(canvas.Mode.CUT)
	)
	stitch_button.toggled.connect(
		func(is_toggled):
			if is_toggled: canvas.set_active_mode(canvas.Mode.STITCH)
	)

	draw_button.button_pressed = true
