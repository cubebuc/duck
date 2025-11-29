extends Node3D


var hour_holder: Node3D
var minute_holder: Node3D

var hour_start_angle: float = 0
var minute_start_angle: float = 0

var local_minutes: float = 0


func _ready() -> void:
    hour_holder = $Base/HourHolder
    minute_holder = $Base/MinuteHolder
    hour_start_angle = hour_holder.rotation_degrees.z
    minute_start_angle = minute_holder.rotation_degrees.z


func _process(delta: float) -> void:
    # move clock
    local_minutes += delta * 20 # Speed up time for demonstration
    update_clock(local_minutes)


func update_clock(minutes: int) -> void:
    var hours = minutes / 60
    var minute_angle = (minutes % 60) * 6.0
    var hour_angle = (hours % 12) * 30.0 + (minutes % 60) * 0.5

    minute_holder.rotation_degrees = Vector3(0, 0, minute_start_angle - minute_angle)
    hour_holder.rotation_degrees = Vector3(0, 0, hour_start_angle - hour_angle)