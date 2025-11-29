extends Node2D

@export var start_showing_rows_delay: float = 2
@export var between_rows_delay: float = 1

var money_label: money_label_class
var customers_served_label: result_row
var customers_served_quickly_label: result_row
var rent_label: result_row


var customers_served_count: int = 8
var customers_served_money: int = 80
var customers_served_quickly_count: int = 2
var customers_served_quickly_money: int = 4
var rent_money:int = -80


func _ready() -> void:
	money_label = $MoneyLabel
	customers_served_label = $CustomersServedLabel
	customers_served_quickly_label = $CustomersServedFastLabel
	rent_label = $RentLabel
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		start_showing_all()
		

func start_showing_all():
	money_label.appear()
	var start_delay_timer = get_tree().create_timer(start_showing_rows_delay)
	start_delay_timer.timeout.connect(start_showing_rows)

func start_showing_rows():	
	customers_served_label.show_row(customers_served_count, customers_served_money, \
	func(): add_money_and_call_after_delay(customers_served_money, between_rows_delay, \
	func(): customers_served_quickly_label.show_row(customers_served_quickly_count, customers_served_quickly_money, \
	func(): add_money_and_call_after_delay(customers_served_quickly_money, between_rows_delay, \
	func(): rent_label.show_row(0,rent_money, \
	func(): add_money_and_call_after_delay(rent_money,0,on_finished_showing_rows))))))

func add_money_and_call_after_delay(money:int, delay: float, callback: Callable):
	money_label.add_money(money)
	var delay_timer = get_tree().create_timer(delay)
	delay_timer.timeout.connect(callback)

func on_finished_showing_rows():
	print("finished showing rows")
