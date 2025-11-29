extends Node


const SALARY_AMOUNT: int = 100
const TIP_AMOUNT: int = 10
const NASEL_MANZELKU_BONUSES: Array[int] = [15, 30, 40]
const RENT_AMOUNT: int = 100
const BILL_AMOUNTS: Array[int] = [0, 25, 50, 75, 100, 150, 200]
const INITIAL_MONEY: int = 250
var money: int = INITIAL_MONEY
var money_today: int = 0
var customers_served_today: int = 0
var customers_served_quickly_today: int = 0
var nasel_manzelku_bonuses_today: Array[int] = []

var current_day: int = 0


func serve_customer(quickly: bool, nasel_manzelku_bonus: bool) -> void:
	money += SALARY_AMOUNT
	customers_served_today += 1

	if quickly:
		money_today += TIP_AMOUNT
		customers_served_quickly_today += 1

	if nasel_manzelku_bonus:
		var bonus = NASEL_MANZELKU_BONUSES.pick_random()
		money_today += bonus
		nasel_manzelku_bonuses_today += [bonus]


func pay_rent() -> void:
	money -= RENT_AMOUNT


func pay_bill() -> void:
	money -= BILL_AMOUNTS[current_day]


func next_day() -> void:
	current_day += 1
	money += money_today
	money_today = 0
	customers_served_today = 0
	customers_served_quickly_today = 0
	nasel_manzelku_bonuses_today = []