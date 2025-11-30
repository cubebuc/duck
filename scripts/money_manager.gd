extends Node


class WrongAnswer:
	var animal_type: AnimalConfig.AnimalType
	var correct_answer: DialogueText.Answer
	var given_answer: DialogueText.Answer


class NaselManzelkuBonus:
	var amount: int
	var given_answer: DialogueText.Answer


const SALARY_AMOUNT: int = 100
const TIP_AMOUNT: int = 10
const NASEL_MANZELKU_BONUSES: Array[int] = [15, 30, 40]
const MAX_NASEL_MANZELKU_BONUSES_PER_LOCATION: int = 2
const RENT_AMOUNT: int = 100
const BILL_AMOUNTS: Array[int] = [0, 25, 50, 75, 100, 150, 200]
const INITIAL_MONEY: int = 250

var money: int = INITIAL_MONEY
var money_today: int = 0
var customers_served_today: int = 0
var customers_served_quickly_today: int = 0
var nasel_manzelku_bonuses_today: Array[NaselManzelkuBonus] = []

var current_day: int = 0
var day_money_history: Array[int] = []

var wrong_answers: Array[WrongAnswer] = []


func serve_customer(quickly: bool, nasel_manzelku_bonus: bool, answer: DialogueText.Answer) -> void:
	money += SALARY_AMOUNT
	customers_served_today += 1

	if quickly:
		money_today += TIP_AMOUNT
		customers_served_quickly_today += 1

	if nasel_manzelku_bonus:
		var same_answer_count = 0
		for bonus in nasel_manzelku_bonuses_today:
			if bonus.given_answer == answer:
				same_answer_count += 1
		if same_answer_count < MAX_NASEL_MANZELKU_BONUSES_PER_LOCATION:
			var amount = NASEL_MANZELKU_BONUSES.pick_random()
			money_today += amount
			var bonus = NaselManzelkuBonus.new()
			bonus.amount = amount
			bonus.given_answer = answer
			nasel_manzelku_bonuses_today.append(bonus)


func pay_rent() -> void:
	money -= RENT_AMOUNT


func pay_bill() -> void:
	money -= BILL_AMOUNTS[current_day]


func next_day() -> void:
	current_day += 1
	money += money_today
	day_money_history.append(money_today)
	money_today = 0
	customers_served_today = 0
	customers_served_quickly_today = 0
	nasel_manzelku_bonuses_today = []
	wrong_answers = []
