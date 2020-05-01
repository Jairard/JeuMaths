extends Node2D

var count = 0
var angle : float = 0
var answer_listeners  : Array = []
var pictures : Dictionary = {}

var load_calcul = load_c("res://Assets/Questions/Questions.json")

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


func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners

func get_answer_listener() -> Array:
	return answer_listeners

func load_c(path : String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text = file.get_as_text()
	var dict = parse_json(text)
	file.close()
	return dict

func setup_question(dict : Array) -> void:

	var random_theme 	: int 			= RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
	timer = NodeUtils.create_timer(4, true, true)
	add_child(timer)

	print ("theme : ", random_theme)
	if random_theme < 8:
		$Fractions.show()
		$Fraction_irreductible.hide()
		$Calcul.hide()
		$Calcul_litteral.hide()
		$Calcul_litteral_reduction.hide()
		$Calcul_factorisation.hide()
		$Percentages.hide()
		var frac_1 = chosen_question["question"][0]
		$Fractions/question/fraction_1.texture = pictures[frac_1]
		var question_txt = chosen_question["question"][1]
		$Fractions/question/operator.text = question_txt
		var frac_2 = chosen_question["question"][2]
		$Fractions/question/fraction_2.texture = pictures[frac_2]
		question = $Fractions/question/operator
	elif random_theme == 8:
		$Fractions.hide()
		$Fraction_irreductible.show()
		$Calcul.hide()
		$Calcul_litteral.hide()
		$Calcul_litteral_reduction.hide()
		$Calcul_factorisation.hide()
		$Percentages.hide()
		var question_txt = chosen_question["question"][0]
		$Fraction_irreductible/question/question.text = question_txt
		var frac = chosen_question["question"][1]
		$Fraction_irreductible/question/fraction.texture = pictures[frac]
		question = $Fraction_irreductible/question/question
	elif random_theme == 9:
		$Fractions.hide()
		$Fraction_irreductible.hide()
		$Calcul.hide()
		$Calcul_litteral.show()
		$Calcul_litteral_reduction.hide()
		$Calcul_factorisation.hide()
		$Percentages.hide()
		var title = chosen_question["question"][0]
		$Calcul_litteral/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_litteral/question/equation.text = equation
		var value = chosen_question["question"][2]
		$Calcul_litteral/question/value.text = value
		question = $Calcul_litteral/question/equation
	elif random_theme == 12 or random_theme == 13:
		$Fractions.hide()
		$Fraction_irreductible.hide()
		$Calcul.hide()
		$Calcul_litteral.hide()
		$Calcul_litteral_reduction.show()
		$Calcul_factorisation.hide()
		$Percentages.hide()
		var title = chosen_question["question"][0]
		$Calcul_litteral_reduction/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_litteral_reduction/question/equation.text = equation
		var value = chosen_question["question"][2]
		$Calcul_litteral_reduction/question/value.text = value
		question = $Calcul_litteral_reduction/question/equation
	elif random_theme == 16:
		$Fractions.hide()
		$Fraction_irreductible.hide()
		$Calcul.hide()
		$Calcul_litteral.hide()
		$Calcul_litteral_reduction.hide()
		$Calcul_factorisation.show()
		$Percentages.hide()
		var title = chosen_question["question"][0]
		$Calcul_factorisation/question/title.text = title
		var equation = chosen_question["question"][1]
		$Calcul_factorisation/question/equation.text = equation
		question = $Calcul_factorisation/question/equation
	elif random_theme == 31 or random_theme == 32 or random_theme == 33:
		$Fractions.hide()
		$Fraction_irreductible.hide()
		$Calcul.hide()
		$Calcul_litteral.hide()
		$Calcul_litteral_reduction.hide()
		$Calcul_factorisation.hide()
		$Percentages.show()
		var question_txt = chosen_question["question"]
		$Percentages/question/question.text = question_txt
		question = $Percentages/question/question
	else:
		$Fractions.hide()
		$Fraction_irreductible.hide()
		$Calcul.show()
		$Calcul_litteral.hide()
		$Calcul_litteral_reduction.hide()
		$Calcul_factorisation.hide()
		$Percentages.hide()
		var question_txt = chosen_question["question"]
		$Calcul/question/question.text = question_txt
		question = $Calcul/question/question

	answers = chosen_question["answers"]

	if random_theme < 8:
		var frac_1 = answers[0] 
		$Fractions/Control/answer/fraction_1.texture = pictures[frac_1["text"]]
		var frac_2 = answers[1] 
		$Fractions/Control/answer/fraction_2.texture = pictures[frac_2["text"]]
		var frac_3 = answers[2] 
		$Fractions/Control/answer/fraction_3.texture = pictures[frac_3["text"]]
		var frac_4 = answers[3] 
		$Fractions/Control/answer/fraction_4.texture = pictures[frac_4["text"]]
		control = $Fractions/Control
		hbox = $Fractions/Control/answer
		buttons = $Fractions/Control/Buttons_fractions
	elif random_theme == 8:
		var frac_1 = answers[0]
		print (frac_1["text"])
		$Fraction_irreductible/Control/answer/fraction_1.texture = pictures[frac_1["text"]]
		var frac_2 = answers[1]
		$Fraction_irreductible/Control/answer/fraction_2.texture = pictures[frac_2["text"]]
		var frac_3 = answers[2]
		$Fraction_irreductible/Control/answer/fraction_3.texture = pictures[frac_3["text"]]
		var frac_4 = answers[3]
		$Fraction_irreductible/Control/answer/fraction_4.texture = pictures[frac_4["text"]]
		control = $Fraction_irreductible/Control
		hbox = $Fraction_irreductible/Control/answer
		buttons = $Fraction_irreductible/Control/Buttons_irreductible
	elif random_theme == 9:
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
	elif random_theme == 12 or random_theme == 13:
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
	elif random_theme == 16 :
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
	elif random_theme == 31 or random_theme == 32 or random_theme == 33:
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
#		button_answer.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])


func _ready():
	var path = "res://Tools/Fractions/"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif file_name.ends_with(".png"):
			pictures[file_name] = load(path + "/" + file_name)
	dir.list_dir_end()
	setup_question(load_calcul)

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
	on_answer_pressed(answers[0]["is_good_answer"])
#	var test = answers[0]["is_good_answer"]
#	connect("pressed", self, "on_answer_pressed", test)


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
