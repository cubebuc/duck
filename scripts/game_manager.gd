extends Node3D

class_name game_manager


@export var blinking_manager: Node
@export var dialog_manager: Node
@export var time_manager: Node
@export var character_manager: Node
@export var knowledge_guess_threshold: int = 1
@export var base_character_count: int = 3

var knowledge_map = {}
var book_used: bool = false
var wrong_answer_count: int = 0

var pr: bool = false
var pa: bool = false

var end_of_day_scene: PackedScene = load("res://scenes/end_of_day_scene.tscn")

func _ready() -> void:
	for animal_type in AnimalConfig.AnimalType.values():
		knowledge_map[animal_type] = 0

	if (not character_manager.is_node_ready()):
		await character_manager.ready
	for i in base_character_count:
		character_manager.add_character()
	
	var timer = get_tree().create_timer(0.1)
	await timer.timeout
		
	dialog_manager.set_speech_resource(character_manager.characters[0].my_config.animal_type)
	dialog_manager.set_knowledge_level(0)
	dialog_manager.adjust_text()
	dialog_manager.display_text()


func read_book() -> void:
	'''
	1. Close eyes
	2. Update knowledge
	3. Update dialog
	4. Advance time (check time limit)
	5. Open eyes
	'''
	blinking_manager.blink_eyes(func() -> void:
		# Mark as read
		book_used = true

		# Update knowledge
		var animal_type = character_manager.characters[0].my_config.animal_type
		knowledge_map[animal_type] += 1

		# Update dialog
		dialog_manager.set_knowledge_level(knowledge_map[animal_type])
		dialog_manager.adjust_text()
		dialog_manager.display_text()

		# Advance time
		time_manager.pass_time_long()
		if time_manager.is_time_up():
			MoneyManager.pay_rent()
			MoneyManager.pay_bill()
			SceneTransition.change_scene(end_of_day_scene, get_tree().current_scene)
	)
	

func answer_animal(answer: DialogueText.Answer) -> void:
	'''
	1. Close eyes
	2. Update money (bonus for quick and random)
	3. Check for wrong answer if has enough knowledge
	4. Update animals
	5. Update dialog
	6. Advance time (check time limit)
	7. Open eyes
	'''
	blinking_manager.blink_eyes(func() -> void:
		# Update money
		var animal_type = character_manager.characters[0].my_config.animal_type
		var knowledge_level = knowledge_map[animal_type]
		var answered_quickly = not book_used
		var answered_randomly = knowledge_level <= knowledge_guess_threshold
		MoneyManager.serve_customer(answered_quickly, answered_randomly)

		# Check for wrong answer
		if knowledge_level > knowledge_guess_threshold and answer != dialog_manager.get_correct_answer():
			wrong_answer_count += 1

		# Update animals
		character_manager.advance_characters()
		character_manager.add_character()

		# Update dialog
		dialog_manager.set_speech_resource(character_manager.characters[0].my_config.animal_type)
		dialog_manager.set_knowledge_level(knowledge_map[character_manager.characters[0].my_config.animal_type])
		dialog_manager.adjust_text()
		dialog_manager.display_text()

		# Advance time
		time_manager.pass_time_short()
		if time_manager.is_time_up():
			MoneyManager.pay_rent()
			MoneyManager.pay_bill()
			SceneTransition.change_scene(end_of_day_scene, get_tree().current_scene)
	)
