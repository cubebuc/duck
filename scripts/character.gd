extends Node3D

@export var animal_configs: Array[AnimalConfig]

var my_config: AnimalConfig

func _ready() -> void:
	randomize()
	_pick_animal_type()
	_assign_textures()
	_randomize_accessories()


func _pick_animal_type() -> void:
	var index = randi_range(0, len(animal_configs) - 1)
	my_config = animal_configs[index]
	
func _assign_textures() -> void:
	$Character.texture = my_config.character_texture
	$Character/Hat.texture = my_config.hat_texture
	$Character/Glasses.texture = my_config.glasses_texture

func _randomize_accessories() -> void:
	for accessory in $Character.get_children():
		if randf() <= 0.5:
			accessory.visible = true
