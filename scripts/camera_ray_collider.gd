extends Area3D

@export var displayed_text: String = ""
@export var deafult_sprite: Texture2D
@export var highlighted_sprite: Texture2D

var table_sprite: Sprite3D


var is_active: bool = false

func _ready() -> void:
	table_sprite = $InteractableSprite
	$SpriteLetterE.visible = false
	
func _process(delta: float) -> void:
	if is_active:
		if Input.is_action_just_pressed("Interact"):
			interact()

func camera_ray_entered():
	$SpriteLetterE.visible = true
	is_active = true
	table_sprite.texture = highlighted_sprite
	
	#testing purposes - remove
	table_sprite.modulate = Color.BISQUE

func camera_ray_left():
	$SpriteLetterE.visible = false
	is_active = false
	table_sprite.texture = highlighted_sprite
	
	#testing purposes - remove
	table_sprite.modulate = Color.WHITE

func interact():
	if not displayed_text:
		print("Congratulations! You just read the book and lost 2 hours of your life. Hope you are balder next time")
	else:
		print(displayed_text)
