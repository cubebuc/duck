extends Node3D
class_name Character

@export var animal_configs: Array[AnimalConfig]

var my_config: AnimalConfig
	

func _setup_random_animal(config: AnimalConfig):
	my_config = config
	randomize()
	_assign_textures()
	_randomize_accessories()

	
func _assign_textures() -> void:
	$Character.texture = my_config.character_texture
	$Character/Hat.texture = my_config.hat_texture
	$Character/Glasses.texture = my_config.glasses_texture

func _randomize_accessories() -> void:
	for accessory in $Character.get_children():
		if randf() <= 0.5:
			accessory.visible = true
