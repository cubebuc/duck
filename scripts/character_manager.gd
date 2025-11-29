extends Node3D


@export var character_prefab: PackedScene
@export var character_offset: Vector3 = Vector3(0.5, 0, -1)
var characters: Array[Character] = []


func add_character() -> void:
	var new_character = character_prefab.instantiate() as Character
	var spawn_position = global_transform.origin + character_offset * (characters.size() + 1)
	add_child(new_character)
	new_character.global_transform.origin = spawn_position
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