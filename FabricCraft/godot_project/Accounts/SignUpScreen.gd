extends Control

# --- Sign-Up Screen Logic ---

@onready var username_edit = $VBoxContainer/UsernameEdit
@onready var email_edit = $VBoxContainer/EmailEdit
@onready var password_edit = $VBoxContainer/PasswordEdit
@onready var register_button = $VBoxContainer/RegisterButton
@onready var status_label = $VBoxContainer/StatusLabel
@onready var http_request = $HTTPRequest

func _ready():
	register_button.pressed.connect(_on_register_button_pressed)
	http_request.request_completed.connect(_on_request_completed)

func _on_register_button_pressed():
	var username = username_edit.text
	var email = email_edit.text
	var password = password_edit.text

	if username.is_empty() or email.is_empty() or password.is_empty():
		status_label.text = "Please fill in all fields."
		return

	var body = {
		"username": username,
		"email": email,
		"password": password
	}
	var body_json = JSON.stringify(body)

	var headers = ["Content-Type: application/json"]
	var error = http_request.request("http://localhost:3000/api/auth/register", headers, HTTPClient.METHOD_POST, body_json)

	if error != OK:
		status_label.text = "An error occurred in the request."
		return

	status_label.text = "Registering..."

func _on_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())

	if result != HTTPRequest.RESULT_SUCCESS or response_code >= 400:
		status_label.text = "Error: " + response.get("message", "Unknown error.")
		return

	status_label.text = "Registration successful! You can now log in."
