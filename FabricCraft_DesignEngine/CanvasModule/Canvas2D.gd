extends Node2D

# --- 2D Canvas Logic ---
# This script manages all user interactions on the 2D design canvas.

@onready var drawing_layer = $DrawingLayer
@onready var grid_overlay = $GridOverlay

# --- Input Handling ---

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		# TODO: Handle mouse clicks for drawing, selecting, etc.
		print("Mouse clicked at: ", event.position)

	if event is InputEventMouseMotion:
		# TODO: Handle mouse movement for drawing paths.
		pass

# --- Drawing Functions ---

func draw_line(from, to, color, width):
	# TODO: Implement line drawing logic.
	pass

func draw_curve(points, color, width):
	# TODO: Implement Bezier curve drawing.
	pass

# --- UI Toggles ---

func toggle_grid(is_visible):
	grid_overlay.visible = is_visible
	pass
