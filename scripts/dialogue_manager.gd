extends Node3D

var text_real: String
var text_to_display: String

var speech_resource: AnimalSpeech

func adjust_text():
	text_to_display = ""
	var words = text_real.split()
	
	for word in words:
		if word.length() < speech_resource.base_sound_length:
			text_to_display += speech_resource.short_sound + " "
		else:
			var repetitions = word.length() - speech_resource.fixed_prefix.length() - speech_resource.fixed_suffix.length()
			var sound_from_word = speech_resource.fixed_prefix
			for i in range(repetitions):
				sound_from_word += speech_resource.repeatable_letter
			sound_from_word += speech_resource.fixed_suffix
			text_to_display += sound_from_word

func display_text():
	$Label3D.text = text_to_display
	
func set_speech_resource(AnimalType type):
	#TODO: set speech_resource to the correct animal type
