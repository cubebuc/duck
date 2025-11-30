extends Area3D


enum InteractionType {
	BOOK,
	ANIMAL_ANSWER,
	RADIO,
	TABLE_DUCK,
	ANIMAL
}

enum RadioInteraction {
	PLAY_PAUSE,
	PREVIOUS,
	NEXT,
	VOLUME_UP,
	VOLUME_DOWN
}

@export var displayed_text: String = ""
@export var default_sprite: Texture2D
@export var highlighted_sprite: Texture2D

@export var target_sprite: Sprite3D

@export var gm: game_manager
@export var answer_type: DialogueText.Answer
@export var interaction_type: InteractionType
@export var radio_interaction: RadioInteraction
@export var next_scene_path: PackedScene = preload("res://scenes/end_of_day_scene.tscn")

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
		if Input.is_action_just_pressed("Interact") and (not gm or not gm.is_interacting):
			interact()
		

func camera_ray_entered():
	print("Camera ray entered")
	is_active = true
	target_sprite.texture = highlighted_sprite
	
	if label_on_hover:
		label_on_hover.visible = true
	

func camera_ray_left():
	print("Camera ray left")
	is_active = false
	target_sprite.texture = default_sprite
	
	if label_on_hover:
		label_on_hover.visible = false
	

func interact():
	if interaction_type == InteractionType.BOOK:
		gm.read_book()
		AudioManager.play_book_sound()
	elif interaction_type == InteractionType.ANIMAL_ANSWER:
		gm.answer_animal(answer_type)
		AudioManager.play_map_sound()
	elif interaction_type == InteractionType.RADIO:
		match radio_interaction:
			RadioInteraction.PLAY_PAUSE:
				AudioManager.pause_unpause_music()
			RadioInteraction.PREVIOUS:
				AudioManager.play_music_previous()
			RadioInteraction.NEXT:
				AudioManager.play_music_next()
			RadioInteraction.VOLUME_UP:
				AudioManager.music_volume_up()
			RadioInteraction.VOLUME_DOWN:
				AudioManager.music_volume_down()
		AudioManager.play_radio_sound()
	elif interaction_type == InteractionType.TABLE_DUCK:
		AudioManager.play_tableduck_sound()
	elif interaction_type == InteractionType.ANIMAL:
		var character_manager = gm.character_manager
		var animal_type = character_manager.characters[0].my_config.animal_type
		AudioManager.play_animal_sound(animal_type)
