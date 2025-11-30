extends Node

var curtain_packed_scene: PackedScene = load("res://scenes/curtain.tscn")
var curtain: Node2D

signal transition_done

@export var curtain_offset_base: Vector2 = Vector2.RIGHT*5000

var curtain_on_right:bool = false

var current_curtain_offset: Vector2

var is_transition_running: bool = false

var is_tutorial_running:bool = false

var tutorial_done:bool = false

func _ready() -> void:
	curtain = curtain_packed_scene.instantiate()
	curtain_offset_base = Vector2.RIGHT*curtain.get_child(0).texture.get_width()
	

func change_scene(next_packed_scene: PackedScene):
	if is_transition_running:
		print("transition is already running!")
		return
	
	is_transition_running = true
	#print("setting input process to false")
	set_process_input(false)
	
	if curtain.get_parent() != get_tree().root:
		get_tree().root.add_child(curtain)
		
	
	print("Curtain is on righ " + str(curtain_on_right))
	current_curtain_offset = curtain_offset_base
	if curtain_on_right:
		current_curtain_offset = -curtain_offset_base
	
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+current_curtain_offset, 2)
	curtain_draw_tween.tween_callback(func(): instantiate_next_scene_to_root(next_packed_scene))

func instantiate_next_scene_to_root(next_packed_scene: PackedScene):	
	get_tree().change_scene_to_packed(next_packed_scene)
	
	if not get_tree().scene_changed.is_connected(reveal_next_scene):
		get_tree().scene_changed.connect(reveal_next_scene)

func reveal_next_scene():
	#print("ready")
	curtain_on_right = not curtain_on_right
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+current_curtain_offset, 2)
	curtain_draw_tween.tween_callback(func(): 
		transition_done.emit()
		is_transition_running = false
		set_process_input(true)
		)

	
