extends Node3D

signal tutorial_end

@export var player_node: player

var bubble: Sprite2D
var label: Label
var current_step:int = 0

const camera_slide_duration = 1

@export var texts_in_steps: Array[String]
@export var camera_angles_steps:Array[Vector3]

var origin_camera_angle: Vector3
var camera: Camera3D

func _ready() -> void:
	if SceneTransition.tutorial_done:
		queue_free()
		return
	player_node.moving_enabled = false
	SceneTransition.is_tutorial_running = true
	
	camera =  get_viewport().get_camera_3d()
	
	origin_camera_angle = camera.rotation_degrees
	
	bubble = $Bubble
	label = $Bubble/Label

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and SceneTransition.is_tutorial_running:
		next()
	
func next():
	label.text = texts_in_steps [current_step]
	var camera_move_tween = get_tree().create_tween()
	camera_move_tween.tween_property(camera, "rotation_degrees", camera_angles_steps[current_step], camera_slide_duration)
	
	
	if current_step == len(texts_in_steps)-1:
		finish_tutorial()
		return
		
	current_step+=1

func finish_tutorial():
	var camera_move_tween = get_tree().create_tween()
	camera_move_tween.tween_property(camera, "rotation_degrees", origin_camera_angle, camera_slide_duration)
	await camera_move_tween.finished
	
	player_node.moving_enabled = true
	SceneTransition.is_tutorial_running = false
	SceneTransition.tutorial_done = true
	bubble.visible = false
