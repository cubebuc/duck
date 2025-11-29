extends Node

var curtain_packed_scene: PackedScene = preload("res://scenes/curtain.tscn")
var curtain: Node2D


func _ready() -> void:
	curtain = curtain_packed_scene.instantiate()
	

func change_scene(nextPackedScene: PackedScene):
	curtain.reparent(get_tree().root)
	var curtain_draw_tween = get_tree().create_tween()
	curtain_draw_tween.tween_property(curtain, "position", curtain.position+Vector2.RIGHT*curtain.scale.x, 2)
	curtain_draw_tween.tween_callback(instantiate_next_scene_to_root)

func instantiate_next_scene_to_root(nextPackedScene: PackedScene):
	var cur_scene = get_tree().current_scene
	
	var instanciated_scene: Node = nextPackedScene.instantiate()
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
