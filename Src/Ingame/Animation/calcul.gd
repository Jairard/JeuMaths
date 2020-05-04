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

const addition_fractions_simple = 0;const soustraction_fractions_simple = 1;const addition_fractions_multiple = 2
const soustration_fractions_multiple = 3;const addition_fractions_general = 4;const soustraction_fractions_general = 5
const multiplication_fractions = 6;const division_fractions = 7;const fractions_irreductible = 8
const tester_valeur = 9;const tester_egalite_simple = 10;const tester_egalite_generale = 11
const reduire_sans_parentheses = 12;const reduire_avec_parentheses = 13;const developpement_simple = 14
const developpement_double = 15;const factorisarion_simple = 16;const factorisation_id_remarquable = 17
const addition_entiers = 18;const soustraction_entiers = 19;const multiplication_entiers = 20
const division_entiers = 21;const addition_decimaux = 22;const soustraction_decimaux = 23
const multiplication_decimaux = 24;const division_decimaux = 25;const addition_relatifs = 26
const soustraction_relatifs = 27;const multiplication_relatifs = 28;const division_relatifs = 29
const appliquer_pourcentage = 30;const trouver_pourcentage_simple = 31;const trouver_pourcentage = 32
const priorites_sans_parentheses = 33;const priorites_avec_parentheses = 34;const decomposition = 35

var notions_show : Array = ["Fractions", "Fractions_irreductible", "Calcul", "Calcul_litteral",
					"Calcul_litteral_reduction", "Calcul_factorisation", "Percentages"]

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


func setup_question(dict : Array) -> void:

	var random_theme 	: int 			= RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
	timer = NodeUtils.create_timer(4, true, true)
	add_child(timer)

	print ("theme : ", random_theme)
	if random_theme < fractions_irreductible:
		show_notion(notions_show, "Fractions")
		var frac_1 = chosen_question["question"][0]
		$Fractions/question/fraction_1.texture = FileBankUtils.loaded_fractions[frac_1]
		var question_txt = chosen_question["question"][1]
		$Fractions/question/operator.text = question_txt
		var frac_2 = chosen_question["question"][2]
		$Fractions/question/fraction_2.texture = FileBankUtils.loaded_fractions[frac_2]
		question = $Fractions/question/operator
	elif random_theme == fractions_irreductible:
		show_notion(notions_show, "Fractions_irreductible")
		var question_txt = chosen_question["question"][0]
		$Fractions_irreductible/question/question.text = question_txt
		var frac = chosen_question["question"][1]
		$Fractions_irreductible/question/fraction.texture = FileBankUtils.loaded_fractions[frac]
		question = $Fractions_irreductible/question/question
	elif random_theme == tester_valeur:
		show_notion(notions_show, "Calcul_litteral")
		var title = chosen_question["question"][0]
		$Calcul_litteral/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_litteral/question/equation.text = equation
		var value = chosen_question["question"][2]
		$Calcul_litteral/question/value.text = value
		question = $Calcul_litteral/question/equation
	elif random_theme == reduire_sans_parentheses or random_theme == reduire_avec_parentheses:
		show_notion(notions_show, "Calcul_litteral_reduction")
		var title = chosen_question["question"][0]
		$Calcul_litteral_reduction/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_litteral_reduction/question/equation.text = equation
		var value = chosen_question["question"][2]
		$Calcul_litteral_reduction/question/value.text = value
		question = $Calcul_litteral_reduction/question/equation
	elif random_theme == factorisarion_simple:
		show_notion(notions_show, "Calcul_factorisation")
		var title = chosen_question["question"][0]
		$Calcul_factorisation/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_factorisation/question/equation.text = equation
		question = $Calcul_factorisation/question/equation
	elif (random_theme == appliquer_pourcentage or random_theme == trouver_pourcentage_simple 
		  or random_theme == trouver_pourcentage):
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

	if random_theme < fractions_irreductible:
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
	elif random_theme == fractions_irreductible:
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
	elif random_theme == tester_valeur:
		calcul_1 = answers[0]
		$Calcul_litteral/Control/answer/label1.text = str(calcul_1["text"])
		calcul_2 = answers[1]
		$Calcul_litteral/Control/answer/label2.text = str(calcul_2["text"])
		calcul_3 = answers[2]
		$Calcul_litteral/Control/answer/label3.text = str(calcul_3["text"])
		calcul_4 = answers[3]
		$Calcul_litteral/Control/answer/label4.text = str(calcul_4["text"])
		control = $Calcul_litteral/Control
		hbox = $Calcul_litteral/Control/answer
		buttons = $Calcul_litteral/Control/buttons_litteral
	elif random_theme == reduire_sans_parentheses or random_theme == reduire_avec_parentheses:
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
	elif random_theme == factorisarion_simple :
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
	elif (random_theme == appliquer_pourcentage or random_theme == trouver_pourcentage_simple 
		  or random_theme == trouver_pourcentage):
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



func _on_Button1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_Button2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_Button3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_Button4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])


func _on_litteral1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])


func _on_litteral2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])


func _on_litteral3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])


func _on_litteral4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_calcul1_pressed():
#	on_answer_pressed()
#	var test = answers[0]["is_good_answer"]
	$Calcul/Control/Buttons_calculs/calcul1.connect("pressed", self, "on_answer_pressed", [answers[0]["is_good_answer"]])


func _on_calcul2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_calcul4_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_calcul3_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_reduction1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_reduction2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_reduction3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_reduction4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_factorisation1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_factorisation2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_factorisation3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_factorisation4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_3_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_2_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

func _on_percent1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])

func _on_percent2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_percent3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_percent4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])
