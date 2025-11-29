extends Label

@export var tween_fly_in_duration: float = 0.5
@export var tween_color_change_duration: float = 0.2
@export var tween_color_stay_duration: float = 0.1
@export var color_after_money_insert: Color = Color.WEB_GREEN

var orig_color: Color

var money_count:int = 0
var money_color_tween: Tween
var money_fly_in_tween: Tween
var money_fly_in_fade_tween: Tween

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		add_money(1)

func _ready() -> void:
	orig_color = self.self_modulate

func add_money(count:int):
	print("add money")
	
	fly_in_money(count)
	
	money_count += count
	money_color_tween = get_tree().create_tween()
	money_color_tween.tween_property(self, "self_modulate", orig_color, tween_fly_in_duration*0.7)
	money_color_tween.tween_property(self, "self_modulate", color_after_money_insert, tween_color_change_duration)
	money_color_tween.set_trans(Tween.TRANS_CUBIC)
	var lambda_set_orig_color = func():self_modulate = orig_color
	money_color_tween.tween_callback(lambda_set_orig_color).set_delay(tween_color_stay_duration)
	
func fly_in_money(count:int):
	var money_label = $AddedMoney
	
	var start_pos = self.position + Vector2.DOWN*100 + Vector2.RIGHT*200
	var end_pos = self.position + Vector2.RIGHT*100
	
	money_label.visible = true
	money_fly_in_tween = get_tree().create_tween()
	money_fly_in_fade_tween = get_tree().create_tween()
	money_label.position = start_pos
	money_fly_in_tween.tween_property(money_label, "position", end_pos, tween_fly_in_duration)
	var faded_color = Color(money_label.self_modulate, 0)
	money_fly_in_fade_tween.tween_property(money_label, "self_modulate", faded_color, tween_fly_in_duration)
	var lambda_reset_money_label = func(): 
		money_label.visible = false
		money_label.self_modulate = Color(money_label.self_modulate,1)
	
	money_fly_in_fade_tween.tween_callback(lambda_reset_money_label)
