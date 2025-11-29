extends Area3D

@export var displayed_text: String = ""
@export var default_sprite: Texture2D
@export var highlighted_sprite: Texture2D

@export var target_sprite: Sprite3D


var is_active: bool = false

func _ready() -> void:
	if not target_sprite:
		target_sprite = $InteractableSprite
	#$SpriteLetterE.visible = false
	
func _process(delta: float) -> void:
	if is_active:
		if Input.is_action_just_pressed("Interact"):
			interact()

func camera_ray_entered():	
	#$SpriteLetterE.visible = true
	is_active = true
	target_sprite.texture = highlighted_sprite
	

func camera_ray_left():
	#$SpriteLetterE.visible = false
	is_active = false
	target_sprite.texture = default_sprite
	

func interact():
	if not displayed_text:
		print("Congratulations! You just read the book and lost 2 hours of your life. Hope you are balder next time")
	else:
		print(displayed_text)
