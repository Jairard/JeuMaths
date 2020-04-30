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

	var random_theme 	: int 			= 14#RandomUtils.randi_to(len(dict))
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
		var frac_1 = chosen_question["question"][0]
		$Fractions/question/fraction_1.texture = pictures[frac_1]
		var question_txt = chosen_question["question"][1]
		$Fractions/question/operator.text = question_txt
		var frac_2 = chosen_question["question"][2]
		$Fractions/question/fraction_2.texture = pictures[frac_2]
		question = $Fractions/question/operator
	elif random_theme == 8:
		$Fraction_irreductible.show()
		$Fractions.hide()
		$Calcul.hide()
		var question_txt = chosen_question["question"][0]
		$Fraction_irreductible/question/question.text = question_txt
		var frac = chosen_question["question"][1]
		$Fraction_irreductible/question/fraction.texture = pictures[frac]
		question = $Fraction_irreductible/question/question
	else:
		$Fraction_irreductible.hide()
		$Fractions.hide()
		$Calcul.show()
		var question_txt = chosen_question["question"]
		$Calcul/question/question.text = question_txt
		question = $Calcul/question/question

	answers = chosen_question["answers"]

	if random_theme < 8:
		$Fractions/Control/Buttons_fractions.show()
		$Fraction_irreductible/Control/Buttons_irreductible.hide()
		$Calcul/Control/Buttons_calculs.hide()
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
		$Fraction_irreductible/Control/Buttons_irreductible.show()
		$Fractions/Control/Buttons_fractions.hide()
		$Calcul/Control/Buttons_calculs.hide()
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
	else:
		$Fractions/Control/Buttons_fractions.hide()
		$Fraction_irreductible/Control/Buttons_irreductible.hide()
		$Calcul/Control/Buttons_calculs.show()
		var calcul_1 = answers[0]
		$Calcul/Control/answer/Label1.text = str(calcul_1["text"])
		var calcul_2 = answers[1]
		$Calcul/Control/answer/Label2.text = str(calcul_2["text"])
		var calcul_3 = answers[2]
		$Calcul/Control/answer/Label3.text = str(calcul_3["text"])
		var calcul_4 = answers[3]
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

func _on_calcul1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])
#	var test = answers[0]["is_good_answer"]
#	connect("pressed", self, "on_answer_pressed", test)

func _on_calcul2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_calcul3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_calcul4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])
