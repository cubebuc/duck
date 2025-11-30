extends Area3D

@export var camera: Camera3D
@export var zoomed_fov: float = 30.0

var default_fov: float

var is_player_inside: bool = false


func _ready() -> void:
	default_fov = camera.fov


func camera_ray_entered():
	var tween = create_tween()
	tween.tween_property(camera, "fov", zoomed_fov, 0.8).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	

func camera_ray_left():
	var tween = create_tween()
	tween.tween_property(camera, "fov", default_fov, 0.8).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
