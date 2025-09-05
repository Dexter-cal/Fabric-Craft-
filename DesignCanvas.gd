extends Node2D

enum Mode { DRAW, CUT, STITCH }
var current_mode = Mode.DRAW

# --- Node References ---
@onready var toolbar = $Toolbar

# --- State Variables ---
var is_drawing = false
var current_line_points = PackedVector2Array()
var all_lines = []
var stitch_points = []

func _ready():
	# --- Connect Toolbar Signals ---
	var tool_button_group = ButtonGroup.new()
	var draw_button = toolbar.get_node("DrawButton")
	var cut_button = toolbar.get_node("CutButton")
	var stitch_button = toolbar.get_node("StitchButton")

	draw_button.button_group = tool_button_group
	cut_button.button_group = tool_button_group
	stitch_button.button_group = tool_button_group

	draw_button.toggled.connect(set_active_mode.bind(Mode.DRAW))
	cut_button.toggled.connect(set_active_mode.bind(Mode.CUT))
	stitch_button.toggled.connect(set_active_mode.bind(Mode.STITCH))

	# Set initial state
	draw_button.button_pressed = true
	set_active_mode(Mode.DRAW)
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
						all_lines.append(stitch_points) # Simulate stitch for now
						stitch_points = []
					queue_redraw()
		elif not event.is_pressed(): # Mouse button released
			if is_drawing:
				is_drawing = false
				if current_line_points.size() > 1:
					if current_mode == Mode.DRAW:
						all_lines.append(current_line_points)
					elif current_mode == Mode.CUT:
						_perform_cut(current_line_points)
				current_line_points = PackedVector2Array()
				queue_redraw()

	if event is InputEventMouseMotion and is_drawing and (current_mode == Mode.DRAW or current_mode == Mode.CUT):
		current_line_points.append(event.position)
		queue_redraw()

func _draw():
	for line in all_lines:
		if line.size() > 1:
			draw_polyline(line, Color.WHITE, 2.0, true)
	if is_drawing and current_line_points.size() > 1:
		var draw_color = Color.AQUA if current_mode == Mode.DRAW else Color.RED
		draw_polyline(current_line_points, draw_color, 2.0, true)

# --- Bug-fixed Cut Logic ---
func _perform_cut(cut_line):
	var resulting_lines = []
	var lines_to_process = all_lines.duplicate() # Work on a copy
	all_lines.clear()

	for existing_line in lines_to_process:
		var intersection = _find_intersection(existing_line, cut_line)
		if intersection == null:
			resulting_lines.append(existing_line) # No cut, keep original
			continue

		# Found an intersection, now split the line
		var line1 = PackedVector2Array()
		var line2 = PackedVector2Array()
		var has_split = false

		line1.append(existing_line[0])
		for i in range(1, existing_line.size()):
			var p1 = existing_line[i-1]
			var p2 = existing_line[i]
			var check_intersect = Geometry2D.line_intersects_line(p1, p2, cut_line[0], cut_line[cut_line.size()-1])

			if not has_split and check_intersect != null:
				line1.append(check_intersect)
				line2.append(check_intersect)
				has_split = true

			if has_split:
				line2.append(p2)
			else:
				line1.append(p2)

		if line1.size() > 1: resulting_lines.append(line1)
		if line2.size() > 1: resulting_lines.append(line2)

	all_lines = resulting_lines

func _find_intersection(line_to_check, cutting_line):
	for i in range(line_to_check.size() - 1):
		for j in range(cutting_line.size() - 1):
			var p1 = line_to_check[i]
			var p2 = line_to_check[i+1]
			var p3 = cutting_line[j]
			var p4 = cutting_line[j+1]
			var intersection = Geometry2D.line_intersects_line(p1, p2, p3, p4)
			if intersection != null:
				return intersection
	return null

# --- Mode Switching ---
func set_active_mode(mode: Mode):
	current_mode = mode
	is_drawing = false
	stitch_points.clear()
	print("Mode changed to: ", Mode.keys()[mode])
