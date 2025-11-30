extends Node2D

@export var cur_ending: ENDING = ENDING.BALANCED

var text_label: Label
var warning_label: Label
var paper: Node2D
var continue_button_label: Label
var background: Sprite2D

enum ENDING {RICH, POOR, BALANCED}

@export var note_text_dic: Dictionary[ENDING, String]
@export var warning_text_dic: Dictionary[ENDING, String]
@export var background_pos_dict: Dictionary[ENDING,Vector2]
@export var background_scale_dict: Dictionary[ENDING,Vector2]
@export var paper_pos_dict: Dictionary[ENDING,Vector2]
@export var paper_rot_dict: Dictionary[ENDING,float]

@export var poor_balanced_threshold: int = 0
@export var balnced_rich_threshold: int = 2000

func _ready() -> void:
	init_references()
	set_ending_from_money()
	set_scene_for_cur_ending()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		cur_ending +=1
		cur_ending %=3
		set_scene_for_cur_ending()
	
func init_references():
	text_label = $Paper/Label
	warning_label = $Paper/Warning
	paper = $Paper
	continue_button_label = $ContinueButton
	background = $Background

func set_ending_from_money():
	MoneyManager.next_day()
	var money= MoneyManager.money
	if money < poor_balanced_threshold:
		cur_ending = ENDING.POOR
	elif money > poor_balanced_threshold:
		cur_ending = ENDING.RICH
	else:
		cur_ending = ENDING.BALANCED

func set_scene_for_cur_ending():
	text_label.text = note_text_dic.get(cur_ending)
	warning_label.text = warning_text_dic.get(cur_ending)
	paper.position = paper_pos_dict.get(cur_ending)
	paper.rotation = paper_rot_dict.get(cur_ending)
	background.position = background_pos_dict.get(cur_ending)
	background.scale = background_scale_dict.get(cur_ending)
