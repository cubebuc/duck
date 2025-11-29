extends Label

class_name money_label_class

const basic_string: String = "Total money"

@export var tween_fly_in_duration: float = 0.5
@export var tween_color_change_duration: float = 0.2
@export var tween_color_stay_duration: float = 0.1
@export var color_after_money_insert: Color = Color.WEB_GREEN
@export var color_after_money_remove: Color = Color.DARK_RED
@export var fly_in_label_start_pos: Vector2 = self.position + Vector2.DOWN * 100
@export var fly_in_label_end_pos: Vector2 = self.position

var orig_color: Color

var money_count:int = 0
var money_color_tween: Tween
var money_fly_in_tween: Tween
var money_fly_in_fade_tween: Tween

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	orig_color = self.self_modulate
	self.self_modulate = Color(self_modulate, 0)

func appear():
	self.text = basic_string + ': ' + str(money_count)
	var appear_tween = get_tree().create_tween()
	appear_tween.tween_property(self, "self_modulate", orig_color, 1)
	

func add_money(count:int):
	print("add money")
	
	var target_color: Color
	if count > 0:
		target_color = color_after_money_insert
	elif count == 0:
		return
	else:
		target_color = color_after_money_remove
	
	fly_in_money(count, target_color)
	
	var lambda_set_new_money_count = func():
		money_count += count
		self.text = basic_string + ': ' + str(money_count)
		
	money_color_tween = get_tree().create_tween()
	money_color_tween.tween_property(self, "self_modulate", orig_color, tween_fly_in_duration*0.7)
	money_color_tween.tween_callback(lambda_set_new_money_count)
	money_color_tween.tween_property(self, "self_modulate", target_color, tween_color_change_duration)
	money_color_tween.tween_property(self, "self_modulate", target_color, tween_color_stay_duration)
	money_color_tween.tween_property(self, "self_modulate", orig_color, tween_color_change_duration)

	money_color_tween.set_trans(Tween.TRANS_QUAD)

func fly_in_money(count:int, color: Color):
	var money_label = $AddedMoney
	
	money_label.text = "+" + str(count)
	money_label.self_modulate = color
	
	var start_pos = fly_in_label_start_pos
	var end_pos = fly_in_label_end_pos
		
	money_label.visible = true
	money_fly_in_tween = get_tree().create_tween()
	money_fly_in_fade_tween = get_tree().create_tween()
	money_label.position = start_pos
	money_fly_in_tween.tween_property(money_label, "position", end_pos, tween_fly_in_duration)
	var faded_color = Color(color, 0)
	money_fly_in_fade_tween.tween_property(money_label, "self_modulate", faded_color, tween_fly_in_duration)
	var lambda_reset_money_label = func(): 
		money_label.visible = false
		money_label.self_modulate = Color(money_label.self_modulate,1)
	
	money_fly_in_fade_tween.tween_callback(lambda_reset_money_label)
