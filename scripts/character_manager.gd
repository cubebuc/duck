extends Node3D

@export var animal_config_types: Array[AnimalConfig]
var random_indices: Array[int]
var config_weights: Array[int]
const starting_weight: int = 128

@export var character_prefab: PackedScene
@export var character_offset: Vector3 = Vector3(0.5, 0, -1)
var characters: Array[Character] = []


func _ready() -> void:
	for index in range(len(animal_config_types)):
		for k in starting_weight:
			random_indices.append(index)
		config_weights.append(starting_weight)
	print("after setup: ", len(random_indices) )
			
func halve_weights(index: int):
	if(config_weights[index] == 1):
		return
	
	var reduce_by = config_weights[index]/2
	config_weights[index] -= reduce_by
	
	var index_to_remove_at = 0
	for n in range(index):
		index_to_remove_at += config_weights[n]
		
	for i in range(reduce_by):
		random_indices.remove_at(index_to_remove_at)
	

func add_character() -> void:
	var new_character = character_prefab.instantiate() as Character
	var spawn_position = global_transform.origin + character_offset * (characters.size() + 1)
	add_child(new_character)
	new_character.global_transform.origin = spawn_position
	
	#randomise animal type for new character
	print(len(random_indices))
	var random_index = randi_range(0, len(random_indices)-1)
	new_character._setup_random_animal(animal_config_types[random_indices[random_index]])
	halve_weights(random_indices[random_index])
	
	characters.append(new_character)


func advance_characters() -> void:
	# remove first
	if characters.size() > 0:
		var last_character = characters.pop_front()
		last_character.queue_free()

	# move others forward
	for i in range(characters.size()):
		var character = characters[i]
		character.global_transform.origin -= character_offset
