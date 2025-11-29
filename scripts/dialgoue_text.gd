extends Resource
class_name DialogueText

enum Answer {
	Airport,
	Toilet,
	Cafe,
	Arcade,
	Library
}

@export var text: String
@export var priorities: Array[int]
@export var answer: Answer
