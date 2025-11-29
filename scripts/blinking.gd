extends Node3D


var top_lid: TextureRect
var bot_lid: TextureRect
var start_top_y: float
var start_bot_y: float
var end_top_y: float
var end_bot_y: float


func _ready() -> void:
	top_lid = $TopLid
	bot_lid = $BottomLid
	start_top_y = top_lid.global_position.y
	start_bot_y = bot_lid.global_position.y
	end_top_y = start_top_y + top_lid.size.y
	end_bot_y = start_bot_y - bot_lid.size.y
	print(start_top_y)
	print(top_lid.size.y)
	print(end_top_y)


func _process(delta: float) -> void:
	# on interaction, blink
	if Input.is_action_just_pressed("Interact"):
		blink_eyes()


func blink_eyes() -> void:
	var top_tween = create_tween()
	var bot_tween = create_tween()
	
	var duration: float = .1
	top_tween.tween_property(top_lid, "global_position:y", end_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	bot_tween.tween_property(bot_lid, "global_position:y", end_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	top_tween.tween_property(top_lid, "global_position:y", start_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	bot_tween.tween_property(bot_lid, "global_position:y", start_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	duration = .1
	var delay = 0.1
	top_tween.tween_property(top_lid, "global_position:y", end_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(delay)
	bot_tween.tween_property(bot_lid, "global_position:y", end_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN).set_delay(delay)
	top_tween.tween_property(top_lid, "global_position:y", start_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	bot_tween.tween_property(bot_lid, "global_position:y", start_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	duration = .5
	delay = 0.5
	top_tween.tween_property(top_lid, "global_position:y", end_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	bot_tween.tween_property(bot_lid, "global_position:y", end_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	top_tween.tween_property(top_lid, "global_position:y", start_top_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
	bot_tween.tween_property(bot_lid, "global_position:y", start_bot_y, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_delay(delay)
