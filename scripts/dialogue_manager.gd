extends Node3D

@export var dialogues: Array[DialogueText]

var text_real: DialogueText

var knowledge_level: int
var text_to_display: String

var speech_resource: AnimalSpeech

@export var cow_speech: AnimalSpeech
@export var duck_speech: AnimalSpeech
@export var rabbit_speech: AnimalSpeech

func _ready() -> void:
	randomize()
	dialogues.shuffle()

func adjust_text():
	text_to_display = ""
	var words = text_real.text.split(" ")
	print(words)
	
	if knowledge_level == 3:
		text_to_display = text_real.text
	else:
		for i in range(len(words)):
			if text_real.priorities[i] > knowledge_level:
				if words[i].length() < speech_resource.base_sound_length:
					text_to_display += speech_resource.short_sound + " "
				else:
					var repetitions = words[i].length() - speech_resource.fixed_prefix.length() - speech_resource.fixed_suffix.length()
					var sound_from_word = speech_resource.fixed_prefix
					for k in range(repetitions):
						sound_from_word += speech_resource.repeatable_letter
					sound_from_word += speech_resource.fixed_suffix
					text_to_display += sound_from_word + " "
			else:
				text_to_display += words[i] + " "

func display_text():
	$Label3D.text = text_to_display
	
func set_knowledge_level(level):
	knowledge_level = level
	
func set_speech_resource(type: AnimalConfig.AnimalType):
	#setup dialog for the new animal
	var first_dialogue = dialogues.pop_front()
	dialogues.append(first_dialogue)
	text_real = dialogues[0]
	
	#setup correct speech resource for the new animal
	match type:
		AnimalConfig.AnimalType.Cow:
			speech_resource = cow_speech
		AnimalConfig.AnimalType.Rabbit:
			speech_resource = rabbit_speech
		AnimalConfig.AnimalType.Goose:
			speech_resource = duck_speech
			
func get_correct_answer() -> DialogueText.Answer:
	return text_real.answer
