extends Node2D

@export var start_showing_rows_delay: float = 2
@export var between_rows_delay: float = 1
@export var before_sticky_notes_delay: float = 2
@export var between_sticky_notes_delay: float = 1.5

var money_label: money_label_class
var customers_served_label: result_row
var customers_served_quickly_label: result_row
var rent_label: result_row
var total_balance_label: result_row

var sticky_note_spaces: Node2D


var customers_served_count: int = 8
var customers_served_money: int = 80
var customers_served_quickly_count: int = 2
var customers_served_quickly_money: int = 4
var rent_money:int = -80

var total_balance:int = 0

var sticky_notes_recieved: int = 0
var sticky_notes_bonuses: Array[int]

func _ready() -> void:
	money_label = $MoneyLabel
	customers_served_label = $CustomersServedLabel
	customers_served_quickly_label = $CustomersServedFastLabel
	rent_label = $RentLabel
	total_balance_label = $EODBalanceLabel
	
	sticky_note_spaces = $StickyNoteSpaces
	
	#Replace with actual data
	sticky_notes_recieved = 6
	sticky_notes_bonuses = [8,4,2,-3,8,-4]
	
	hide_all_sticky_notes()
	
	total_balance = customers_served_money+customers_served_quickly_money+rent_money
		
	start_showing_all()
	
func hide_all_sticky_notes():
	for space in sticky_note_spaces.get_children():
		space.modulate = Color(space.modulate, 0)
	
func _process(delta: float) -> void:
	pass
		

func start_showing_all():
	money_label.appear()
	var start_delay_timer = get_tree().create_timer(start_showing_rows_delay)
	start_delay_timer.timeout.connect(start_showing_rows)

func start_showing_rows():	
	#This mess is just all the row showing functions called as callbacks after each other with delay
	customers_served_label.show_row(customers_served_count, customers_served_money, \
	func(): add_money_and_call_after_delay(customers_served_money, between_rows_delay, \
	func(): customers_served_quickly_label.show_row(customers_served_quickly_count, customers_served_quickly_money, \
	func(): add_money_and_call_after_delay(customers_served_quickly_money, between_rows_delay, \
	func(): rent_label.show_row(0,rent_money, \
	func(): add_money_and_call_after_delay(rent_money,0, \
	func(): total_balance_label.show_row(0, total_balance, on_finished_showing_rows)))))))

func add_money_and_call_after_delay(money:int, delay: float, callback: Callable):
	money_label.add_money(money)
	var delay_timer = get_tree().create_timer(delay)
	delay_timer.timeout.connect(callback)

func on_finished_showing_rows():
	start_showing_sticky_notes()
	print("finished showing rows")

func start_showing_sticky_notes():
	var sticky_note_appear_tween = get_tree().create_tween()
	
	#wait a bit before showing
	sticky_note_appear_tween.tween_interval(before_sticky_notes_delay)
	
	var index = 0
	for space in sticky_note_spaces.get_children():
		if index < sticky_notes_recieved:
			sticky_note_appear_tween.tween_property(space, "modulate", Color(space.modulate,1), 1)
			sticky_note_appear_tween.tween_callback(func(): money_label.add_money(sticky_notes_bonuses[index]))
			sticky_note_appear_tween.tween_interval(between_sticky_notes_delay)
			
		else:
			break
		index += 1
	
	
