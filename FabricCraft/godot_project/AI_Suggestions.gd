extends PanelContainer

# --- AI Suggestions UI Script ---
# This script handles fetching and displaying AI-powered suggestions.

@onready var suggestion_label = $VBoxContainer/SuggestionText
@onready var refresh_button = $VBoxContainer/RefreshButton

# --- Core Functions ---

func _ready():
	# Connect the refresh button's pressed signal to our function.
	refresh_button.pressed.connect(_on_refresh_button_pressed)
	# Fetch an initial suggestion when the scene loads.
	_fetch_ai_suggestion()
	pass

# --- AI Interaction ---

func _fetch_ai_suggestion():
	# This function will make an HTTP request to the backend's AI endpoint.
	# TODO: Create an HTTPRequest node to handle the API call.
	# The request would be to GET /api/ai/suggest
	print("Fetching new AI suggestion from the backend...")
	# Placeholder logic:
	var suggestions = [
		"This would look great in a pastel color.",
		"Trending now: floral patterns. Try one!",
		"Consider pairing this with some minimalist accessories.",
		"A bold, contrasting color would make this pop."
	]
	suggestion_label.text = suggestions.pick_random()
	pass

# --- Signal Handlers ---

func _on_refresh_button_pressed():
	_fetch_ai_suggestion()
	pass
