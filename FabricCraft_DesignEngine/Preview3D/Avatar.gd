extends Node3D

# --- Avatar Logic ---
# This script manages the avatar's animations and body morphing.

@onready var skeleton = $Skeleton3D

# --- Morphing ---
# In a real implementation, these would likely be blend shape values.
var height = 1.0
var weight = 1.0

func set_morph_shape(shape_name, value):
	# TODO: Implement blend shape logic to change the avatar's body shape.
	print("Setting morph '", shape_name, "' to: ", value)
	pass

# --- Animations ---
func play_animation(anim_name):
	# TODO: Get the AnimationPlayer node and play the specified animation.
	print("Playing animation: ", anim_name)
	pass
