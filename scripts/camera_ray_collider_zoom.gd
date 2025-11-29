extends Area3D

@export var camera: Camera3D

var default_fov: float
var zoomed_fov: float = 30.0

var is_player_inside: bool = false


func _ready() -> void:
    default_fov = camera.fov


func _process(delta: float) -> void:
    if is_player_inside:
        camera.fov = lerp(camera.fov, zoomed_fov, 0.1)
    else:
        camera.fov = lerp(camera.fov, default_fov, 0.1)


func camera_ray_entered():
    is_player_inside = true
	

func camera_ray_left():
    is_player_inside = false
