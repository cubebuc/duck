extends Node


class WrongAnswer:
	var animal_type: AnimalConfig.AnimalType
	var correct_answer: DialogueText.Answer
	var given_answer: DialogueText.Answer


class NaselManzelkuBonus:
	var amount: int
	var given_answer: DialogueText.Answer


const SALARY_AMOUNT: int = 10
const TIP_AMOUNT: int = 3
const NASEL_MANZELKU_BONUSES: Array[int] = [2, 3, 4]
const MAX_NASEL_MANZELKU_BONUSES_PER_LOCATION: int = 2
const RENT_AMOUNT: int = 70
const BILL_AMOUNTS: Array[int] = [0, 20, 30, 50, 70]
const INITIAL_MONEY: int = 100

var money: int = INITIAL_MONEY
var money_today: int = 0
var customers_served_today: int = 0
var customers_served_quickly_today: int = 0
var nasel_manzelku_bonuses_today: Array[NaselManzelkuBonus] = []

var current_day: int = 0
var day_money_history: Array[int] = []

var wrong_answers: Array[WrongAnswer] = []


func serve_customer(quickly: bool, nasel_manzelku_bonus: bool, answer: DialogueText.Answer) -> void:
	money_today += SALARY_AMOUNT
	
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
	money_today -= RENT_AMOUNT


func pay_bill() -> void:
	money_today -= BILL_AMOUNTS[current_day]


func next_day() -> void:
	current_day += 1
	money += money_today
	day_money_history.append(money_today)
	money_today = 0
	customers_served_today = 0
	customers_served_quickly_today = 0
	nasel_manzelku_bonuses_today = []
	wrong_answers = []
