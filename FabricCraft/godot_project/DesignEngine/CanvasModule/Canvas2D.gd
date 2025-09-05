extends Node2D

enum Mode { DRAW, CUT, STITCH }
var current_mode = Mode.DRAW

var is_drawing = false
var current_line_points = PackedVector2Array()
var all_lines = []
var stitch_points = []

func _ready():
	set_process_input(false)
	queue_redraw()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		match current_mode:
			Mode.DRAW:
				is_drawing = true
				current_line_points.clear()
				current_line_points.append(event.position)
			Mode.CUT:
				print("Placeholder: Cut operation at: ", event.position)
			Mode.STITCH:
				stitch_points.append(event.position)
				if stitch_points.size() == 2:
					all_lines.append(stitch_points)
					stitch_points.clear()
				queue_redraw()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		if current_mode == Mode.DRAW and is_drawing:
			is_drawing = false
			if current_line_points.size() > 1:
				all_lines.append(current_line_points)
				current_line_points = PackedVector2Array()
			queue_redraw()

	if event is InputEventMouseMotion and current_mode == Mode.DRAW and is_drawing:
		current_line_points.append(event.position)
		queue_redraw()

func _draw():
	for line in all_lines:
		if line.size() > 1:
			draw_polyline(line, Color.WHITE, 2.0, true)
	if is_drawing and current_line_points.size() > 1:
		draw_polyline(current_line_points, Color.AQUA, 2.0, true)

func set_active_mode(mode: Mode):
	current_mode = mode
	set_process_input(true)
	is_drawing = false
	stitch_points.clear()
	print("Mode changed to: ", Mode.keys()[mode])

func disable_all_modes():
	set_process_input(false)
	print("All modes disabled.")
