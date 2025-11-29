extends Label

class_name result_row

@export var text_appear_duration: float = 1
@export var count_appear_delay: float = 0.2
@export var count_appear_duration: float = 0.4
@export var money_appear_delay: float = 0.3
@export var money_appear_duration: float = 0.3

var appear_tween: Tween


func _ready() -> void:
	self_modulate = Color(self_modulate, 0)
	$CountLabel.self_modulate = Color($CountLabel.self_modulate, 0)
	$MoneyLabel.self_modulate = Color($MoneyLabel.self_modulate, 0)

func show_row(count:int, money:int, callback: Callable = func(): print(" ")):
	var count_label = $CountLabel
	var money_label = $MoneyLabel
	
	if money >= 0:
		$MoneyLabel.self_modulate = Color(Color.WEB_GREEN, 0)
	else:
		$MoneyLabel.self_modulate = Color(Color.DARK_RED, 0)

	count_label.text = str(count)
	money_label.text = str(money)

	if count == 0:
		count_label.text = ""
	
	appear_tween = get_tree().create_tween()
	
	appear_tween.tween_property(self, "self_modulate", Color(self_modulate,1), text_appear_duration)
	appear_tween.tween_interval(count_appear_delay)
	appear_tween.tween_property(count_label, "self_modulate", Color($CountLabel.self_modulate,1), count_appear_duration)
	appear_tween.tween_interval(money_appear_delay)
	appear_tween.tween_property(money_label, "self_modulate", Color($MoneyLabel.self_modulate,1), money_appear_duration)
	appear_tween.tween_callback(callback)
	
	
	
