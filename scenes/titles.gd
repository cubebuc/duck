extends Node2D

var scene = load("res://scenes/intro_paper.tscn")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SceneTransition.change_scene(scene)
