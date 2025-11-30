extends Node2D

class_name manzelka_note

var background: Sprite2D
var label: Label

func _ready() -> void:
	background = $Background
	label = $Text
	
func set_text(text: String):
	label.text = text
