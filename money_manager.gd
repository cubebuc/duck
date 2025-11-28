extends Node


const SALARY_AMOUNT: int = 100
const TIP_AMOUNTS: Array[int] = [5, 10, 15]
const NASEL_MANZELKU_BONUSES: Array[int] = [15, 30, 40]
const RENT_AMOUNT: int = 100
const BILL_AMOUNTS: Array[int] = [0, 25, 50, 75, 100, 150, 200]
const INITIAL_MONEY: int = 250
var money: int = INITIAL_MONEY
var todays_salary: int = 0
var todays_tips: int = 0
var todays_nasel_manzelku_bonuses_count: int = 0

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


func add_money_salary() -> void:
    money += SALARY_AMOUNT


func add_money_tip() -> void:
    var tip = TIP_AMOUNTS.pick_random()
    money += tip
    todays_tips += tip


func add_money_nasel_manzelku_bonus() -> void:
    var bonus = NASEL_MANZELKU_BONUSES.pick_random()
    money += bonus


func pay_rent() -> void:
    money -= RENT_AMOUNT


func pay_bill() -> void:
    money -= BILL_AMOUNTS[current_day]


func next_day() -> void:
    current_day += 1
    todays_salary = 0
    todays_tips = 0
    todays_nasel_manzelku_bonuses_count = 0
