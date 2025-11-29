extends Node2D

@export var time_before_can_start: float = 5

var next_scene: PackedScene = preload("res://scenes/dave_test_scene.tscn")

var curtain: Sprite2D

var can_start: bool = false

var start_game_label: Label

func _ready() -> void:
	start_game_label = $StartGameLabel
	start_game_label.self_modulate = Color(start_game_label.self_modulate, 0)
	
	curtain = $Curtain
	
	var start_delay_timer = get_tree().create_timer(time_before_can_start)
	start_delay_timer.timeout.connect(enable_start_game)
	
func enable_start_game():
	can_start = true
	var blinking_tween = get_tree().create_tween()
	blinking_tween.set_loops()
	blinking_tween.tween_property(start_game_label, "self_modulate", Color(start_game_label.self_modulate,1), 1)
	blinking_tween.tween_property(start_game_label, "self_modulate", Color(start_game_label.self_modulate,0), 1)
	
	
func _process(delta: float) -> void:
	if can_start:
		if Input.is_action_just_pressed("Interact"):
			change_scene()
			
func change_scene():
	curtain.reparent(get_tree().root)
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+Vector2.RIGHT*curtain.scale.x, 2)
	curtain_draw_tween.tween_callback(instantiate_next_scene_to_root)

func instantiate_next_scene_to_root():
	var cur_scene = get_tree().current_scene
	
	var instanciated_scene: Node = next_scene.instantiate()
	instanciated_scene.ready.connect(func(): reveal_next_scene())
	
	get_tree().root.add_child(instanciated_scene)
	
	get_tree().root.remove_child(cur_scene)
func reveal_next_scene():
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+Vector2.RIGHT*curtain.scale.x, 2)
	curtain_draw_tween.tween_callback(remove_self_and_curtain)
	
func remove_self_and_curtain():
	curtain.queue_free()
	self.queue_free()
