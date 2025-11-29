extends Area3D

@export var displayed_text: String = ""
@export var deafult_sprite: Texture2D
@export var highlighted_sprite: Texture2D



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
	$Sprite3D.texture = highlighted_sprite
	
	#testing purposes - remove
	$Sprite3D.modulate = Color.BISQUE

func camera_ray_left():
	$SpriteLetterE.visible = false
	is_active = false
	$Sprite3D.texture = highlighted_sprite
	
	#testing purposes - remove
	$Sprite3D.modulate = Color.WHITE

func interact():
	if not displayed_text:
		print("Congratulations! You just read the book and lost 2 hours of your life. Hope you are balder next time")
	else:
		print(displayed_text)
