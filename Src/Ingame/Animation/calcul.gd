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

	var font_question = "res://font/Lato-Black.ttf"
	var font_answer = "res://font/Lato-Black.ttf"
#	question = NodeUtils.create_label(Vector2(0,0), Vector2(0,0), 
#						   Color.yellowgreen, font_question, 60,2, Color.black)

	var random_theme 	: int 			= 4#RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

#	print ("theme : ", random_theme)
	if random_theme < 8:
		var frac_1 = chosen_question["question"][0]
		$Buttons/Fractions/question/fraction_1.texture = pictures[frac_1]
		var operator = chosen_question["question"][1]
		$Buttons/Fractions/question/operator.text = operator
		var frac_2 = chosen_question["question"][2]
		$Buttons/Fractions/question/fraction_2.texture = pictures[frac_2]
	elif random_theme == 8:
		question.text = chosen_question["question"][0]
		var texture_frac = TextureRect.new()
		texture_frac.SIZE_EXPAND_FILL
		var frac = chosen_question["question"][1]
		texture_frac.texture = pictures[frac]
		$control/question.add_child(texture_frac)
		texture_frac.set_position(question.get_position() + Vector2(900,40))
	else:
		question.text = chosen_question["question"]

	answers = chosen_question["answers"]

#	var ans_position : Vector2 = Vector2(question.get_position().x - 500 , question.get_position().y + 50)
#	for ans in answers:

	if random_theme < 9:
		var frac_1 = answers[0] 
		$Buttons/Fractions/answer/fraction_1.texture = pictures[frac_1["text"]]
		var frac_2 = answers[1] 
		$Buttons/Fractions/answer/fraction_2.texture = pictures[frac_2["text"]]
		var frac_3 = answers[2] 
		$Buttons/Fractions/answer/fraction_3.texture = pictures[frac_3["text"]]
		var frac_4 = answers[3] 
		$Buttons/Fractions/answer/fraction_4.texture = pictures[frac_4["text"]]
	else:
#		var label_answer = NodeUtils.create_label(Vector2(0,0), Vector2(0,0), 
#					   Color.orangered, font_question, 60,1, Color.black)
		pass

		var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
		timer = NodeUtils.create_timer(4, true, true)
		add_child(timer)

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


func _process(delta):

#	angle += delta
#	$control/answer.set_rotation(angle)
#	$control/answer/control.set_rotation(-angle)


#	if int(timer.get_time_left()) > 0:
#		question.add_color_override("font_color", Color.greenyellow)
#	else:
#		question.add_color_override("font_color", Color.green)
	pass

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
#	connect("pressed", self, "on_answer_pressed", answers[0]["is_good_answer"])
	

func _on_Button2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])

func _on_Button3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])

func _on_Button4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])

