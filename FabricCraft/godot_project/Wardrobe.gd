extends Node3D

# --- Wardrobe Interaction Script ---
# Handles avatar and clothing swapping logic.

# --- Preload Assets ---
# Preload the scenes for the avatar and clothing items.
const AvatarPlaceholder = preload("res://assets/avatars/avatar_placeholder.tscn")
const ShirtPlaceholder = preload("res://assets/clothes/shirt_placeholder.tscn")
const PantsPlaceholder = preload("res://assets/clothes/pants_placeholder.tscn")

# --- Node References ---
# Get references to nodes from the scene tree.
@onready var avatar_container = $AvatarContainer
@onready var equip_shirt_button = $UI/ClothingButtons/EquipShirtButton
@onready var equip_pants_button = $UI/ClothingButtons/EquipPantsButton

var current_avatar = null

# --- Core Functions ---

func _ready():
	# This function is called when the node enters the scene tree.
	print("Wardrobe scene is ready.")

	# Instantiate the avatar and add it to the scene.
	current_avatar = AvatarPlaceholder.instantiate()
	avatar_container.add_child(current_avatar)

	# Connect the UI button signals to the equip function.
	# We use bind() to pass the specific clothing scene as an argument.
	equip_shirt_button.pressed.connect(equip_item.bind(ShirtPlaceholder))
	equip_pants_button.pressed.connect(equip_item.bind(PantsPlaceholder))
	pass

# --- Avatar & Clothing Logic ---

func equip_item(item_scene: PackedScene):
	# This function equips a new item to the avatar.
	if not current_avatar:
		print("Avatar not loaded yet.")
		return

	# First, remove any existing items of the same type (a real system would be more complex).
	# For this placeholder, we'll just clear all children (all clothes).
	for child in current_avatar.get_children():
		child.queue_free()

	# Instantiate the new clothing item and add it as a child of the avatar.
	var new_item = item_scene.instantiate()
	current_avatar.add_child(new_item)
	print("Equipped item: ", new_item.name)
	pass
