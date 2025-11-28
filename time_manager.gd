extends Node


const DEFAULT_TIME_LIMIT: int = 1 * 60
const SHORT_PASS_TIME: int = 5
const LONG_PASS_TIME: int = 15
var time_remaining: int = DEFAULT_TIME_LIMIT


func pass_time_short() -> void:
    time_remaining -= SHORT_PASS_TIME


func pass_time_long() -> void:
    time_remaining -= LONG_PASS_TIME


func reset_time() -> void:
    time_remaining = DEFAULT_TIME_LIMIT
