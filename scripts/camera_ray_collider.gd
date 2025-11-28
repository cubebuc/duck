extends Area3D

func _ready() -> void:
	#$SpriteLetterE.process_mode = Node.PROCESS_MODE_DISABLED
	$SpriteLetterE.visible = false

func camera_ray_entered():
	#print("ray_entered")
	#$SpriteLetterE.process_mode = Node.PROCESS_MODE_ALWAYS
	$SpriteLetterE.visible = true

func camera_ray_left():
	#print("ray_left")
	#$SpriteLetterE.process_mode = Node.NOTIFICATION_DISABLED
	$SpriteLetterE.visible = false
