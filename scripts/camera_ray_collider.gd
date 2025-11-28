extends Area3D

func _ready() -> void:
	$SpriteLetterE.visible = false

func camera_ray_entered():
	$SpriteLetterE.visible = true

func camera_ray_left():
	$SpriteLetterE.visible = false
