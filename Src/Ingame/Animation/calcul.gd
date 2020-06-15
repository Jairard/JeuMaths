extends Node2D

var count = 0
var angle : float = 0
var answer_listeners  : Array = []

var timer : Timer = null
var timer_label : Label = null
var button_answer : Button = null
var question : Label = null
var colorRect : ColorRect = null
var answers : Array = []
var control : Control = null
var hbox : HBoxContainer = null
var buttons : HBoxContainer = null

var calcul_1 : Dictionary = {}
var calcul_2 : Dictionary = {}
var calcul_3 : Dictionary = {}
var calcul_4 : Dictionary = {}

const addition_fraction_simple = 0;const soustraction_fraction_simple = 1;const addition_fraction_multiple = 2
const soustraction_fraction_multiple = 3;const addition_fraction_general = 4;const soustraction_fraction_general = 5
const multiplication_fraction = 6;const division_fraction = 7;const fraction_irreductible = 8
const calcul_valeur = 9;const tester_egalite_simple = 10;const tester_egalite_general = 11
const reduire_simple = 12;const reduire_parentheses = 13;const developpement_simple = 14
const developpement_double = 15;const factorisation_simple = 16;const factorisation_id_rem = 17
const addition_entiers = 18;const soustraction_entiers = 19;const multiplication_entiers = 20
const division_entiers = 21;const addition_decimaux = 22;const soustraction_decimaux = 23
const multiplication_decimaux = 24;const division_decimaux = 25;const addition_relatifs = 26
const soustraction_relatifs = 27;const multiplication_relatifs = 28;const division_relatifs = 29
const appliquer_pourcentage = 30;const trouver_pourcentage_simple = 31;const trouver_pourcentage = 32
const priorites_simple = 33;const priorites_parentheses = 34;const decomposition = 35

var notions_show : Array = ["Fractions", "Fractions_irreductible", "Calcul", "Calcul_litteral_distribution",
					"Calcul_litteral_reduction", "Decomposition", "Calcul_factorisation", "Percentages"]

func show_notion(notions_show : Array, lesson : String) -> void:
	for i in notions_show:
		if i == lesson:
			get_node(i).show()
		else:
			get_node(i).hide()

func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners

func get_answer_listener() -> Array:
	return answer_listeners


func setup_question(exercices : Array, constants : Array) -> void:

	var random_theme 	: int 			= RandomUtils.randi_to(len(exercices))
	var theme = constants[random_theme]
	var questions		: Array 		= exercices[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
	timer = NodeUtils.create_timer(4, true, true)
	add_child(timer)

	if theme < fraction_irreductible:
		show_notion(notions_show, "Fractions")
		var frac_1 = chosen_question["question"][0]
		$Fractions/question/fraction_1.texture = FileBankUtils.loaded_fractions[frac_1]
		var question_txt = chosen_question["question"][1]
		$Fractions/question/operator.text = question_txt
		var frac_2 = chosen_question["question"][2]
		$Fractions/question/fraction_2.texture = FileBankUtils.loaded_fractions[frac_2]
		question = $Fractions/question/operator
	elif theme == fraction_irreductible:
		show_notion(notions_show, "Fractions_irreductible")
		var question_txt = chosen_question["question"][0]
		$Fractions_irreductible/question/question.text = question_txt
		var frac = chosen_question["question"][1]
		$Fractions_irreductible/question/fraction.texture = FileBankUtils.loaded_fractions[frac]
		question = $Fractions_irreductible/question/question
	elif theme == reduire_simple or theme == reduire_parentheses or theme == calcul_valeur:
		show_notion(notions_show, "Calcul_litteral_reduction")
		var title = chosen_question["question"][0]
		$Calcul_litteral_reduction/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_litteral_reduction/question/equation.text = equation
		var value = chosen_question["question"][2]
		$Calcul_litteral_reduction/question/value.text = value
		question = $Calcul_litteral_reduction/question/equation
	elif theme == factorisation_simple:
		show_notion(notions_show, "Calcul_factorisation")
		var title = chosen_question["question"][0]
		$Calcul_factorisation/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_factorisation/question/equation.text = equation
		question = $Calcul_factorisation/question/equation
	elif (theme == developpement_simple or theme == developpement_double 
		or theme == factorisation_id_rem):
		show_notion(notions_show, "Calcul_litteral_distribution")
		var question_txt = chosen_question["question"]
		$Calcul_litteral_distribution/question/title.text = question_txt
		question = $Calcul_litteral_distribution/question/title
	elif theme == decomposition:
		show_notion(notions_show, "Decomposition")
		var question_txt = chosen_question["question"]
		$Decomposition/question/title.text = question_txt
		question = $Decomposition/question/title
	elif (theme == appliquer_pourcentage or theme == trouver_pourcentage_simple 
		  or theme == trouver_pourcentage):
		show_notion(notions_show, "Percentages")
		var question_txt = chosen_question["question"]
		$Percentages/question/question.text = question_txt
		question = $Percentages/question/question
	else:
		show_notion(notions_show, "Calcul")
		var question_txt = chosen_question["question"]
		$Calcul/question/question.text = question_txt
		question = $Calcul/question/question

	answers = chosen_question["answers"]

	if theme < fraction_irreductible:
		var frac_1 = answers[0] 
		$Fractions/Control/answer/fraction_1.texture = FileBankUtils.loaded_fractions[frac_1["text"]]
		var frac_2 = answers[1] 
		$Fractions/Control/answer/fraction_2.texture = FileBankUtils.loaded_fractions[frac_2["text"]]
		var frac_3 = answers[2] 
		$Fractions/Control/answer/fraction_3.texture = FileBankUtils.loaded_fractions[frac_3["text"]]
		var frac_4 = answers[3] 
		$Fractions/Control/answer/fraction_4.texture = FileBankUtils.loaded_fractions[frac_4["text"]]
		control = $Fractions/Control
		hbox = $Fractions/Control/answer
		buttons = $Fractions/Control/Buttons_fractions
	elif theme == fraction_irreductible:
		var frac_1 = answers[0]
		$Fractions_irreductible/Control/answer/fraction_1.texture = FileBankUtils.loaded_fractions[frac_1["text"]]
		var frac_2 = answers[1]
		$Fractions_irreductible/Control/answer/fraction_2.texture = FileBankUtils.loaded_fractions[frac_2["text"]]
		var frac_3 = answers[2]
		$Fractions_irreductible/Control/answer/fraction_3.texture = FileBankUtils.loaded_fractions[frac_3["text"]]
		var frac_4 = answers[3]
		$Fractions_irreductible/Control/answer/fraction_4.texture = FileBankUtils.loaded_fractions[frac_4["text"]]
		control = $Fractions_irreductible/Control
		hbox = $Fractions_irreductible/Control/answer
		buttons = $Fractions_irreductible/Control/Buttons_irreductible
	elif theme == reduire_simple or theme == reduire_parentheses or theme == calcul_valeur:
		calcul_1 = answers[0]
		$Calcul_litteral_reduction/Control/answer/label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Calcul_litteral_reduction/Control/answer/label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Calcul_litteral_reduction/Control/answer/label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Calcul_litteral_reduction/Control/answer/label4.text = str(calcul_4["text"])
		control = $Calcul_litteral_reduction/Control
		hbox = $Calcul_litteral_reduction/Control/answer
		buttons = $Calcul_litteral_reduction/Control/buttons_litteral
	elif theme == factorisation_simple :
		calcul_1 = answers[0]
		$Calcul_factorisation/Control/answer/label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Calcul_factorisation/Control/answer/label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Calcul_factorisation/Control/answer/label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Calcul_factorisation/Control/answer/label4.text = str(calcul_4["text"])
		control = $Calcul_factorisation/Control
		hbox = $Calcul_factorisation/Control/answer
		buttons = $Calcul_factorisation/Control/buttons_factorisation
	elif (theme == developpement_simple or theme == developpement_double 
			or theme == factorisation_id_rem) :
		calcul_1 = answers[0]
		$Calcul_litteral_distribution/Control/answer/label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Calcul_litteral_distribution/Control/answer/label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Calcul_litteral_distribution/Control/answer/label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Calcul_litteral_distribution/Control/answer/label4.text = str(calcul_4["text"])
		control = $Calcul_litteral_distribution/Control
		hbox = $Calcul_litteral_distribution/Control/answer
		buttons = $Calcul_litteral_distribution/Control/buttons_litteral
	elif theme == decomposition :
		calcul_1 = answers[0]
		$Decomposition/Control/answer_up/label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Decomposition/Control/answers_down/label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Decomposition/Control/answer_up/label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Decomposition/Control/answers_down/label4.text = str(calcul_4["text"])
		control = null
		hbox = null
		buttons = null
	elif (theme == appliquer_pourcentage or theme == trouver_pourcentage_simple 
		  or theme == trouver_pourcentage):
		calcul_1 = answers[0]
		$Percentages/Control/answer/Label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Percentages/Control/answer/Label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Percentages/Control/answer/Label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Percentages/Control/answer/Label4.text = str(calcul_4["text"])
		control = $Percentages/Control
		hbox = $Percentages/Control/answer
		buttons = $Percentages/Control/Buttons_percentages
	else:
		calcul_1 = answers[0]
		$Calcul/Control/answer/Label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Calcul/Control/answer/Label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Calcul/Control/answer/Label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Calcul/Control/answer/Label4.text = str(calcul_4["text"])
		control = $Calcul/Control
		hbox = $Calcul/Control/answer
		buttons = $Calcul/Control/Buttons_calculs


#		if ans["is_good_answer"] == true:
#			var style : StyleBoxFlat = StyleBoxFlat.new()
#			style.set_bg_color(Color(0,255,0))
#			button_answer.add_stylebox_override("hover",style)

func critic(qestion : Label, delta : float) -> void:
	if int(timer.get_time_left()) > 0:
		question.add_color_override("font_color", Color.darkorchid)
	else:
		question.add_color_override("font_color", Color.blue)
	rotation(control, hbox, buttons, delta)

func rotation(control : Control, hbox : HBoxContainer, buttons : HBoxContainer, delta : float) -> void:
	if control != null and hbox != null and buttons != null:
		control.set_rotation(control.get_rotation() + delta)
		hbox.set_rotation(hbox.get_rotation() - delta)
		buttons.set_rotation(buttons.get_rotation() - delta)

func _process(delta):

	critic(question, delta)

func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)


func _on_fraction1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_fraction2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_fraction3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_fraction4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_fraction_irreductible1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_fraction_irreductible2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_fraction_irreductible3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_fraction_irreductible4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_calcul1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_calcul2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_calcul3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_calcul4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_reduction1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_reduction3_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_reduction2_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_reduction4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_distribution1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_distribution2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_distribution3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_distribution4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_decomposition1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_decomposition2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_decomposition3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_decomposition4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_factorisation1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_factorisation2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_factorisation3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_factorisation4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_percent1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_percent2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_percent3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_percent4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])
