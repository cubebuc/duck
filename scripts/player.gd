extends Node3D


var camera_holder: Node3D
var camera: Camera3D

var default_fov: float
var zoomed_fov: float = 30.0
var mouse_speed: float = 0.1

var last_mouse_position: Vector2


func _ready() -> void:
	camera_holder = $CameraHolder
	camera = camera_holder.get_node("Camera3D")

	default_fov = camera.fov
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)


func _process(delta: float) -> void:
	var mouse_position = get_window().get_mouse_position()
	var mouse_movement = mouse_position - last_mouse_position
	last_mouse_position = mouse_position

	if Input.mouse_mode == Input.MOUSE_MODE_CONFINED_HIDDEN:
		# if mouse is on the right side of the screen, warp to left side
		var window_size = get_window().get_size()
		if mouse_position.x >= window_size.x - 1:
			get_window().warp_mouse(Vector2(0, mouse_position.y))
			last_mouse_position = Vector2(0, mouse_position.y)
		# if mouse is on the left side of the screen, warp to right side
		elif mouse_position.x <= 0:
			get_window().warp_mouse(Vector2(window_size.x - 1, mouse_position.y))
			last_mouse_position = Vector2(window_size.x - 1, mouse_position.y)
		# if mouse is on the bottom side of the screen, warp to top side
		elif mouse_position.y >= window_size.y - 1:
			get_window().warp_mouse(Vector2(mouse_position.x, 0))
			last_mouse_position = Vector2(mouse_position.x, 0)
		# if mouse is on the top side of the screen, warp to bottom side
		elif mouse_position.y <= 0:
			get_window().warp_mouse(Vector2(mouse_position.x, window_size.y - 1))
			last_mouse_position = Vector2(mouse_position.x, window_size.y - 1)
	
	# left/right rotation
	camera_holder.rotate_y(-mouse_movement.x * delta * mouse_speed)
	camera_holder.rotation_degrees.y = clamp(camera_holder.rotation_degrees.y, -75, 75)

	# up/down rotation
	camera.rotate_x(-mouse_movement.y * delta * mouse_speed)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -40, 30)

	# exit with esc
	if Input.is_key_pressed(Key.KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
