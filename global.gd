extends Node


const DEFAULT_TIME_LIMIT: int = 1 * 60
const SHORT_PASS_TIME: int = 5
const LONG_PASS_TIME: int = 15
var time_remaining: int = DEFAULT_TIME_LIMIT

const SALARY_AMOUNT: int = 100
const TIP_AMOUNTS: Array[int] = [15, 20, 25]
const RENT_AMOUNT: int = 100
const BILL_AMOUNTS: Array[int] = [0, 25, 50, 75, 100, 150, 200]
const INITIAL_MONEY: int = 250
var money: int = INITIAL_MONEY


func reset_time() -> void:
    time_remaining = DEFAULT_TIME_LIMIT


func pass_time_short() -> void:
    time_remaining -= SHORT_PASS_TIME


func pass_time_long() -> void:
    time_remaining -= LONG_PASS_TIME


func add_money_salary() -> void:
    money += SALARY_AMOUNT


func add_money_tip() -> void:
    var tip_index = randi() % TIP_AMOUNTS.size()
    money += TIP_AMOUNTS[tip_index]


func pay_rent() -> void:
    money -= RENT_AMOUNT


func pay_bill(bill_index: int) -> void:
    money -= BILL_AMOUNTS[bill_index]
