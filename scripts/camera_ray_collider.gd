extends Area3D

@export var displayed_text: String = ""
@export var default_sprite: Texture2D
@export var highlighted_sprite: Texture2D

@export var target_sprite: Sprite3D

@export var game_manager: game_manager
@export var answer_type: DialogueText.Answer
@export var is_book: bool = true

var label_on_hover: Label3D

var is_active: bool = false

func _ready() -> void:
	if not target_sprite:
		target_sprite = $InteractableSprite
	
	label_on_hover = $LabelOnHover
	if label_on_hover:
		label_on_hover.visible = false
	
func _process(delta: float) -> void:
	if is_active:
		if Input.is_action_just_pressed("Interact"):
			interact()

func camera_ray_entered():	
	is_active = true
	target_sprite.texture = highlighted_sprite
	
	if label_on_hover:
		label_on_hover.visible = true
	

func camera_ray_left():
	is_active = false
	target_sprite.texture = default_sprite
	
	if label_on_hover:
		label_on_hover.visible = false
	

func interact():
	#camera_ray_left()
	
	if is_book:
		game_manager.read_book()
		return
	
	game_manager.answer_animal(answer_type)
	return
