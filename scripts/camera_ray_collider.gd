extends Area3D

var is_active: bool = false

func _ready() -> void:
	$SpriteLetterE.visible = false
	
func _process(delta: float) -> void:
	if is_active:
		if Input.is_action_just_pressed("Interact"):
			interact()

func camera_ray_entered():
	$SpriteLetterE.visible = true
	is_active = true
	

func camera_ray_left():
	$SpriteLetterE.visible = false
	is_active = false

func interact():
	print("Congratulations! You just read the book and lost 2 hours of your life. Hope you are balder next time")
