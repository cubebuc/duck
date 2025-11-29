extends Node

var curtain_packed_scene: PackedScene = load("res://scenes/curtain.tscn")
var curtain: Node2D

signal transition_done

@export var curtain_offset_base: Vector2 = Vector2.RIGHT*1500

var current_curtain_offset: Vector2

func _ready() -> void:
	curtain = curtain_packed_scene.instantiate()
	

func change_scene(next_packed_scene: PackedScene, origin_scene, reversed_curtain:bool = false):
	if curtain.get_parent() != get_tree().root:
		get_tree().root.add_child(curtain)
		
	current_curtain_offset = curtain_offset_base
	if reversed_curtain:
		current_curtain_offset = -curtain_offset_base
	
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+current_curtain_offset, 2)
	curtain_draw_tween.tween_callback(func(): instantiate_next_scene_to_root(next_packed_scene, origin_scene))

func instantiate_next_scene_to_root(next_packed_scene: PackedScene, origin_scene):	
	get_tree().change_scene_to_packed(next_packed_scene)
	
	get_tree().scene_changed.connect(func(): reveal_next_scene())

func reveal_next_scene():
	print("ready")
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+current_curtain_offset, 2)
	curtain_draw_tween.tween_callback(func(): transition_done.emit())
	
