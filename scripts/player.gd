extends Node3D

class_name player


var camera_holder: Node3D
var camera: Camera3D

var default_fov: float
var zoomed_fov: float = 30.0
var mouse_speed: float = 0.002

var last_mouse_position: Vector2

var moving_enabled:bool = true

func _ready() -> void:
	camera_holder = $CameraHolder
	camera = camera_holder.get_node("Camera3D")

	default_fov = camera.fov
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	var mouse_movement = Input.get_last_mouse_velocity()
	
	if moving_enabled:
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
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
