extends Node2D

@export var cur_ending: ENDING = ENDING.BALANCED

var text_label: Label
var warning_label: Label
var paper: Node2D
var continue_button_label: Label
var background: Sprite2D
var ending: Node2D

enum ENDING {RICH, POOR, BALANCED}

@export var note_text_dic: Dictionary[ENDING, String]
@export var warning_text_dic: Dictionary[ENDING, String]
@export var background_pos_dict: Dictionary[ENDING,Vector2]
@export var background_scale_dict: Dictionary[ENDING,Vector2]
@export var paper_pos_dict: Dictionary[ENDING,Vector2]
@export var paper_rot_dict: Dictionary[ENDING,float]

@export var poor_balanced_threshold: int = 0
@export var balnced_rich_threshold: int = 2000

var can_continue

func _ready() -> void:
	init_references()
	continue_button_label.self_modulate = Color(continue_button_label.self_modulate,0)
	ending.modulate = Color(ending.modulate,0)
	var continue_delay_timer = get_tree().create_timer(5)
	continue_delay_timer.timeout.connect(enable_continue)
	#set_ending_from_money()
	#set_scene_for_cur_ending()

func _process(delta: float) -> void:
	if can_continue:
		if Input.is_action_just_pressed("Interact"):
			continue_button_label.visible = false
			var end_appear_tween = get_tree().create_tween()
			end_appear_tween.tween_property(ending, "modulate", Color(ending.modulate,1), 4)
	
	
func init_references():
	text_label = $Paper/Label
	warning_label = $Paper/Warning
	paper = $Paper
	continue_button_label = $ContinueButton
	background = $Background
	ending = $Ending
	
func enable_continue():
	can_continue = true
	var blinking_tween = get_tree().create_tween()
	blinking_tween.set_loops(100)
	blinking_tween.tween_property(continue_button_label, "self_modulate", Color(continue_button_label.self_modulate,1), 1)
	blinking_tween.tween_property(continue_button_label, "self_modulate", Color(continue_button_label.self_modulate,0), 1)
	



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
