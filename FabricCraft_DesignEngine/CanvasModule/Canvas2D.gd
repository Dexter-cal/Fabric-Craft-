extends Node2D

# --- 2D Canvas Logic ---
# This script manages all user interactions on the 2D design canvas.

var is_drawing = false
var current_line_points = PackedVector2Array()
var all_lines = []

func _ready():
	# This ensures the _draw function is called, allowing drawing to happen.
	queue_redraw()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_drawing = true
				current_line_points.clear()
				current_line_points.append(event.position)
			else: # Mouse button released
				if is_drawing:
					is_drawing = false
					if current_line_points.size() > 1:
						# Finalize the line and add it to the list of all lines
						all_lines.append(current_line_points)
						current_line_points = PackedVector2Array() # Clear for next line
					queue_redraw()

	if event is InputEventMouseMotion and is_drawing:
		current_line_points.append(event.position)
		# Request a redraw to show the line as it's being drawn
		queue_redraw()

func _draw():
	# This function is called by the engine to draw on this Node2D.

	# Draw all the completed lines
	for line in all_lines:
		if line.size() > 1:
			draw_polyline(line, Color.WHITE, 2.0, true)

	# Draw the line currently being drawn
	if is_drawing and current_line_points.size() > 1:
		draw_polyline(current_line_points, Color.AQUA, 2.0, true)

# --- Public Functions for Toolbar ---

func set_draw_mode(is_enabled):
	# Allows enabling/disabling drawing from the toolbar.
	set_process_input(is_enabled)
	if is_enabled:
		print("Drawing mode enabled.")
	else:
		print("Drawing mode disabled.")

func clear_canvas():
	all_lines.clear()
	current_line_points.clear()
	queue_redraw()
	print("Canvas cleared.")
