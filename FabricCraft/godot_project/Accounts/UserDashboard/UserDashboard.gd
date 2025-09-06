extends Control

@onready var header_label = $VBoxContainer/HeaderLabel

func _ready():
	# In a real app, this data would come from a global session manager.
	# For example: header_label.text = "Welcome, " + UserSession.username
	print("User Dashboard loaded.")
