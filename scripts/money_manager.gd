extends Node


const SALARY_AMOUNT: int = 100
const TIP_AMOUNT: int = 10
const NASEL_MANZELKU_BONUSES: Array[int] = [15, 30, 40]
const RENT_AMOUNT: int = 100
const BILL_AMOUNTS: Array[int] = [0, 25, 50, 75, 100, 150, 200]
const INITIAL_MONEY: int = 250
var money: int = INITIAL_MONEY
var customers_served_today: int = 0
var customers_served_quickly_today: int = 0
var nasel_manzelku_bonuses_today: int = 0

var current_day: int = 0

'''
GAME LOOP:
	1. Player chooses LEARN or GUESS - can't learn over 100%
	2. Add SALARY and TIP based on choice (TIP only if you CAN'T know the answer)
    3. Pass TIME based on choice
    --- Go back to 1. until TIME runs out ---
    4. Pay RENT and BILLS, get NASEL MANZELKU BONUS
    5. Advance DAY -> Go to 1.
'''


func serve_customer(quickly: bool, nasel_manzelku_bonus: bool) -> void:
	money += SALARY_AMOUNT
	customers_served_today += 1

	if quickly:
		money += TIP_AMOUNT
		customers_served_quickly_today += 1

	if nasel_manzelku_bonus:
		var bonus = NASEL_MANZELKU_BONUSES.pick_random()
		money += bonus
		nasel_manzelku_bonuses_today += 1


func pay_rent() -> void:
	money -= RENT_AMOUNT


func pay_bill() -> void:
	money -= BILL_AMOUNTS[current_day]


func next_day() -> void:
	current_day += 1
	customers_served_today = 0
	customers_served_quickly_today = 0
	nasel_manzelku_bonuses_today = 0
