extends Control

# --- Design Engine Main Controller ---
# This script is the central hub that connects all the different modules
# (UI, Canvas, AI, etc.) and manages the overall state of the design tool.

const CanvasScene = preload("res://CanvasModule/Canvas2D.tscn")

@onready var toolbar = $MainLayout/Toolbar
@onready var preview_panel = $MainLayout/WorkspaceLayout/PreviewPanel
@onready var sub_viewport = $MainLayout/WorkspaceLayout/PreviewPanel/SubViewport

var canvas_instance

func _ready():
	print("Design Engine is ready.")

	# Instance the canvas and add it to the SubViewport
	canvas_instance = CanvasScene.instantiate()
	sub_viewport.add_child(canvas_instance)

	# Get references to the buttons on the toolbar
	var draw_button = toolbar.get_node("DrawButton")
	var clear_button = toolbar.get_node("CutButton") # We'll repurpose 'Cut' to 'Clear' for now

	# Connect signals
	# The 'toggled' signal is for toggle-mode buttons. It passes a boolean (is_pressed).
	# We'll need to update the button in the .tscn file to be a toggle button.
	if draw_button:
		draw_button.toggled.connect(canvas_instance.set_draw_mode)

	if clear_button:
		clear_button.text = "Clear Canvas" # Change button text for clarity
		clear_button.pressed.connect(canvas_instance.clear_canvas)

	print("Toolbar signals connected to Canvas.")
	pass
