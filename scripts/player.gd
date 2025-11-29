extends Node3D


var camera_holder: Node3D
var camera: Camera3D

var default_fov: float
var zoomed_fov: float = 30.0


func _ready() -> void:
	camera_holder = $CameraHolder
	camera = camera_holder.get_node("Camera3D")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	default_fov = camera.fov


func _process(delta: float) -> void:
	var mouse_movement = Input.get_last_mouse_velocity()
	
	# left/right rotation
	camera_holder.rotate_y(-mouse_movement.x * delta * 0.002)
	camera_holder.rotation_degrees.y = clamp(camera_holder.rotation_degrees.y, -20, 75)

	# up/down rotation
	camera.rotate_x(-mouse_movement.y * delta * 0.002)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -30, 30)

	# exit with esc
	if Input.is_key_pressed(Key.KEY_ESCAPE):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
