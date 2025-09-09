extends Control

const PostCardScene = preload("res://Community/PostCard.tscn")

@onready var post_container = $ScrollContainer/PostContainer
@onready var http_request = HTTPRequest.new()
@onready var back_button = $BackButton

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	back_button.pressed.connect(_on_back_button_pressed)
	fetch_posts()

func fetch_posts():
	http_request.request("http://localhost:3000/api/community/feed")

func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS or response_code >= 400:
		return
	var posts = JSON.parse_string(body.get_string_from_utf8())
	if posts:
		for post_data in posts:
			var card = PostCardScene.instantiate()
			post_container.add_child(card)
			card.set_data(post_data)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Accounts/UserDashboard/UserDashboard.tscn")
