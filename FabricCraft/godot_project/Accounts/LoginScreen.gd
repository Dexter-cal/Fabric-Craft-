extends Control

# --- Login Screen Logic ---

@onready var email_edit = $VBoxContainer/EmailEdit
@onready var password_edit = $VBoxContainer/PasswordEdit
@onready var login_button = $VBoxContainer/LoginButton
@onready var status_label = $VBoxContainer/StatusLabel
@onready var http_request = $HTTPRequest

func _ready():
	login_button.pressed.connect(_on_login_button_pressed)
	http_request.request_completed.connect(_on_request_completed)

func _on_login_button_pressed():
	var email = email_edit.text
	var password = password_edit.text

	if email.is_empty() or password.is_empty():
		status_label.text = "Please enter email and password."
		return

	var body = { "email": email, "password": password }
	var body_json = JSON.stringify(body)

	var headers = ["Content-Type: application/json"]
	var error = http_request.request("http://localhost:3000/api/auth/login", headers, HTTPClient.METHOD_POST, body_json)

	if error != OK:
		status_label.text = "An error occurred in the request."
		return

	status_label.text = "Logging in..."

func _on_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())

	if result != HTTPRequest.RESULT_SUCCESS or response_code >= 400:
		status_label.text = "Login failed: " + response.get("message", "Invalid credentials.")
		return

	status_label.text = "Login successful! Welcome, " + response.get("username", "") + "!"

	# Wait for a moment so the user can see the success message.
	await get_tree().create_timer(1.0).timeout

	# Change to the User Dashboard scene.
	get_tree().change_scene_to_file("res://Accounts/UserDashboard/UserDashboard.tscn")
