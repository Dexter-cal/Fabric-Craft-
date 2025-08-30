extends Node2D

# --- 2D Canvas Logic ---
# This script manages all user interactions on the 2D design canvas.

var is_drawing = false
var current_line_points = PackedVector2Array()
var all_lines = [] # Array of Dictionaries: [{"points": PackedVector2Array, "color": Color, "material": Dictionary}]
var current_color = Color.WHITE
var current_material = {"transparency": 0.0}

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
						var new_line = {
							"points": current_line_points,
							"color": current_color,
							"material": current_material
						}
						all_lines.append(new_line)
						current_line_points = PackedVector2Array() # Clear for next line
					queue_redraw()

	if event is InputEventMouseMotion and is_drawing:
		current_line_points.append(event.position)
		# Request a redraw to show the line as it's being drawn
		queue_redraw()

func _draw():
	# This function is called by the engine to draw on this Node2D.

	# Draw all the completed lines
	for line_data in all_lines:
		if line_data.points.size() > 1:
			var draw_color = line_data.color
			draw_color.a = 1.0 - line_data.material.get("transparency", 0.0)
			draw_polyline(line_data.points, draw_color, 2.0, true)

	# Draw the line currently being drawn
	if is_drawing and current_line_points.size() > 1:
		var draw_color = current_color
		draw_color.a = 1.0 - current_material.get("transparency", 0.0)
		draw_polyline(current_line_points, draw_color, 2.0, true)

# --- Public Functions for Toolbar & Panels ---

func set_draw_mode(is_enabled):
	set_process_input(is_enabled)
	print("Drawing mode ", "enabled" if is_enabled else "disabled")

func set_draw_color(new_color: Color):
	current_color = new_color
	print("Draw color set to: ", new_color)

func update_material_properties(properties: Dictionary):
	# Called by the DesignEngine when the MaterialPanel changes.
	current_material = properties
	queue_redraw() # Redraw to reflect new material properties
	print("Material properties updated: ", properties)

func clear_canvas():
	all_lines.clear()
	current_line_points.clear()
	queue_redraw()
	print("Canvas cleared.")
