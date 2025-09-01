extends Control

# --- User Dashboard Logic ---

@onready var header_label = $VBoxContainer/HeaderLabel

func _ready():
	# In a real app, user data would be fetched from a global session manager.
	# For now, we'll just use a placeholder name.
	# e.g., header_label.text = "Welcome, " + UserSession.username
	header_label.text = "Welcome, User!"
	print("User Dashboard loaded.")
