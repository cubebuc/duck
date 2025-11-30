extends Node


const DEFAULT_TIME_LIMIT: int = 1 * 60
const SHORT_PASS_TIME: int = 5
const LONG_PASS_TIME: int = 15
var current_time: int = 0


func pass_time_short() -> void:
	current_time += SHORT_PASS_TIME


func pass_time_long() -> void:
	current_time += LONG_PASS_TIME


func reset_time() -> void:
	current_time = 0


func is_time_up() -> bool:
	return current_time >= DEFAULT_TIME_LIMIT
