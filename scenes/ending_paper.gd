extends Node2D

var text_label: Label
var paper: Node2D
var continue_button_label: Label
var background: Sprite2D

enum ENDING {RICH, POOR, BALANCED}


@export var background_pos_dict: Dictionary[ENDING,Vector2]
@export var background_scale_dict: Dictionary[ENDING,Vector2]
@export var paper_pos_dict: Dictionary[ENDING,Vector2]
@export var background_rot_dict: Dictionary[ENDING,float]

func _ready() -> void:
	init_references()
	
	
	
func init_references():
	text_label = $Paper/Label
	paper = $LabelBackground
	continue_button_label = $ContinueButton
	background = $Background
