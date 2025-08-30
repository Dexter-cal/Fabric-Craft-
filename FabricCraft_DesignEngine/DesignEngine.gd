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

	var color_picker = toolbar.get_node("ColorPicker")
	if color_picker:
		# Connect the color_changed signal to the canvas script's future function
		color_picker.color_changed.connect(canvas_instance.set_draw_color)
		# Set the initial color on the canvas
		canvas_instance.set_draw_color(color_picker.color)

	print("Toolbar signals connected to Canvas.")

	# Connect the tutorial button
	var tutorial_button = toolbar.get_node("StartTutorialButton")
	if tutorial_button:
		tutorial_button.pressed.connect(start_tutorial)

	# Connect the Material Panel
	var material_panel = $MainLayout/WorkspaceLayout/LeftPanel/MaterialPanel
	if material_panel:
		material_panel.material_updated.connect(canvas_instance.update_material_properties)

	pass

@onready var tutorial_manager = $TutorialManager

func start_tutorial():
	if tutorial_manager == null:
		print("Tutorial Manager node not found.")
		return

	var steps = _define_tutorial_steps()
	tutorial_manager.start_tutorial(steps)

func _define_tutorial_steps():
	# This function defines the content of our tutorial.
	var steps = [
		{
			"text": "Welcome to the Design Engine! Let's learn how to draw. First, click the 'Draw' button to enable drawing mode.",
			"target_node": toolbar.get_node("DrawButton"),
			"wait_for_signal": "toggled"
		},
		{
			"text": "Great! Now, click and drag on the canvas to draw a line.",
			"target_node": preview_panel
			# We can't easily wait for a line to be drawn, so we'll just use the 'Next' button for this step.
		},
		{
			"text": "Excellent! Now let's change the color. Click the color swatch to open the color picker.",
			"target_node": toolbar.get_node("ColorPicker"),
			"wait_for_signal": "picker_created"
		},
		{
			"text": "Pick a new color and try drawing again. You've completed the tutorial!",
			"target_node": null
		}
	]
	return steps
