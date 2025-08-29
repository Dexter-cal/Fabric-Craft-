extends Control

# --- Community Feed Logic Script ---
# Manages the loading, display, and interaction of posts in the feed.

# Preload the PostCard scene to instantiate it for each post
const PostCard = preload("res://PostCard.tscn")

# Reference to the container that will hold the posts
@onready var post_container = $VBoxContainer
@onready var feed_request = $FeedRequest

# --- Core Functions ---

func _ready():
	# Called when the node enters the scene tree for the first time.
	print("Community Feed is ready. Fetching posts...")
	feed_request.request_completed.connect(_on_feed_request_completed)
	feed_request.request("http://localhost:3000/api/community/feed")
	pass

# --- Feed Management ---

func _on_feed_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS or response_code != 200:
		print("Error fetching feed: ", result, ", Response Code: ", response_code)
		# Optionally, display an error message to the user
		return

	var json = JSON.parse_string(body.get_string_from_utf8())
	if json == null:
		print("Error parsing JSON response.")
		return

	# Clear any existing placeholder posts
	for child in post_container.get_children():
		child.queue_free()

	# Populate feed with data from the backend
	for post_data in json:
		var post_card = PostCard.instantiate()
		post_container.add_child(post_card)
		# Assuming the PostCard scene has a script with this function
		if post_card.has_method("set_post_data"):
			post_card.set_post_data(post_data)

# --- Signal Handlers ---

func _on_like_button_pressed(post_id):
	# TODO: Send a 'like' request to the backend API.
	# POST /api/community/like with { "post_id": post_id }
	print("Liked post: ", post_id)
	pass

func _on_follow_button_pressed(creator_id):
	# TODO: Send a 'follow' request to the backend API.
	# POST /api/community/follow with { "user_id": creator_id }
	print("Following user: ", creator_id)
	pass
