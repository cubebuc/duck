extends Resource
class_name AnimalConfig


enum AnimalType {
    Cow,
    Rabbit,
    Goose
}


@export var animal_type: AnimalType
@export var character_texture: Texture2D
@export var hat_texture: Texture2D
@export var glasses_texture: Texture2D
