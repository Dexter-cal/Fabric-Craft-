extends CanvasLayer

# --- Tutorial Manager Logic ---
# Manages the step-by-step interactive tutorial.

@onready var highlight_rect = $HighlightRect
@onready var instruction_label = $InfoBox/InstructionLabel
@onready var next_button = $InfoBox/NextButton

var tutorial_steps = []
var current_step_index = -1

func _ready():
	# The tutorial is hidden by default.
	hide()
	next_button.pressed.connect(_on_next_pressed)

func start_tutorial(steps: Array):
	# Called by the DesignEngine to begin the tutorial.
	if steps.is_empty():
		print("No tutorial steps provided.")
		return

	tutorial_steps = steps
	current_step_index = -1
	show()
	_advance_to_next_step()
	print("Tutorial started.")

func _on_next_pressed():
	_advance_to_next_step()

func _advance_to_next_step():
	current_step_index += 1
	if current_step_index >= tutorial_steps.size():
		# Tutorial finished
		print("Tutorial finished.")
		hide()
		return

	var current_step = tutorial_steps[current_step_index]

	# Update instruction text
	instruction_label.text = current_step.get("text", "No text for this step.")

	# Update highlight box
	var target_node = current_step.get("target_node", null)
	if target_node and is_instance_valid(target_node):
		highlight_rect.global_position = target_node.global_position - Vector2(5, 5)
		highlight_rect.size = target_node.size + Vector2(10, 10)
		highlight_rect.show()

		# If the step requires waiting for a signal, connect to it.
		if "wait_for_signal" in current_step:
			next_button.hide()
			var signal_name = current_step.wait_for_signal
			# We use await to pause execution until the signal is emitted.
			await target_node.get(signal_name)
			_advance_to_next_step()
		else:
			next_button.show()
	else:
		highlight_rect.hide()
		next_button.show()
