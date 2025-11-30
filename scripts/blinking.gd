extends Node3D


var top_lid: TextureRect
var bot_lid: TextureRect
var start_top_y: float
var start_bot_y: float
var end_top_y: float
var end_bot_y: float

var pb: bool = false


func _ready() -> void:
	top_lid = $TopLid
	bot_lid = $BottomLid

	start_top_y = top_lid.global_position.y
	start_bot_y = bot_lid.global_position.y
	end_top_y = start_top_y + top_lid.size.y
	end_bot_y = start_bot_y - bot_lid.size.y


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		if not pb:
			pb = true
			blink_eyes(func() -> void: pass )
	else:
		pb = false


# blinking with callback as argument
func blink_eyes(callback: Callable) -> void:
	var tween = create_tween()
	
	var duration: float = .15
	var x_scale = 2
	tween.tween_property(top_lid, "global_position:y", end_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(bot_lid, "global_position:y", end_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().parallel().tween_property(top_lid, "scale:x", x_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().parallel().tween_property(bot_lid, "scale:x", x_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(top_lid, "global_position:y", start_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(bot_lid, "global_position:y", start_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().parallel().tween_property(top_lid, "scale:x", 1, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().parallel().tween_property(bot_lid, "scale:x", 1, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	var delay = 0.1
	tween.tween_property(top_lid, "global_position:y", end_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(delay)
	tween.parallel().tween_property(bot_lid, "global_position:y", end_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(delay)
	tween.parallel().parallel().tween_property(top_lid, "scale:x", x_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().parallel().tween_property(bot_lid, "scale:x", x_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(top_lid, "global_position:y", start_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(bot_lid, "global_position:y", start_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().parallel().tween_property(top_lid, "scale:x", 1, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().parallel().tween_property(bot_lid, "scale:x", 1, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	
	duration = 0.5
	delay = 0.35
	tween.tween_property(top_lid, "global_position:y", end_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	tween.parallel().tween_property(bot_lid, "global_position:y", end_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	tween.parallel().parallel().tween_property(top_lid, "scale:x", x_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(delay)
	tween.parallel().parallel().tween_property(bot_lid, "scale:x", x_scale, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(delay)
	
	tween.tween_callback(callback)

	delay = 0.25
	tween.tween_property(top_lid, "global_position:y", start_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	tween.parallel().tween_property(bot_lid, "global_position:y", start_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	tween.parallel().parallel().tween_property(top_lid, "scale:x", 1, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_delay(delay)
	tween.parallel().parallel().tween_property(bot_lid, "scale:x", 1, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT).set_delay(delay)
