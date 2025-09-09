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
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			match current_mode:
				Mode.DRAW, Mode.CUT:
					is_drawing = true
					current_line_points.clear()
					current_line_points.append(event.position)
				Mode.STITCH:
					stitch_points.append(event.position)
					if stitch_points.size() == 2:
						all_lines.append(stitch_points)
						stitch_points = []
					queue_redraw()
		elif not event.is_pressed():
			if is_drawing:
				is_drawing = false
				if current_line_points.size() > 1:
					if current_mode == Mode.DRAW:
						all_lines.append(current_line_points)
					elif current_mode == Mode.CUT:
						_perform_cut(current_line_points)
				current_line_points = PackedVector2Array()
				queue_redraw()
	if event is InputEventMouseMotion and is_drawing:
		current_line_points.append(event.position)
		queue_redraw()

func _draw():
	for line in all_lines:
		if line.size() > 1:
			draw_polyline(line, Color.WHITE, 2.0, true)
	if is_drawing:
		var draw_color = Color.AQUA if current_mode == Mode.DRAW else Color.RED
		draw_polyline(current_line_points, draw_color, 2.0, true)

func _perform_cut(cut_line):
	var resulting_lines = []
	var lines_to_process = all_lines.duplicate()
	all_lines.clear()
	for existing_line in lines_to_process:
		var intersection = Geometry2D.line_intersects_line(existing_line[0], existing_line[existing_line.size()-1], cut_line[0], cut_line[cut_line.size()-1])
		if intersection == null:
			resulting_lines.append(existing_line)
			continue
		# Basic split logic for demonstration
		var line1 = PackedVector2Array([existing_line[0], intersection])
		var line2 = PackedVector2Array([intersection, existing_line[existing_line.size()-1]])
		resulting_lines.append(line1)
		resulting_lines.append(line2)
	all_lines = resulting_lines

func set_active_mode(mode: Mode):
	current_mode = mode
	set_process_input(true)
	is_drawing = false
	stitch_points.clear()
