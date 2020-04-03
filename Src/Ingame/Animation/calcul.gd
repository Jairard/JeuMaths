extends Node2D

var count = 0
var answer_listeners  : Array = []
#var load_calcul_6 = load_c("res://Assets/Questions/questions_6.json")
#var load_calcul_5 = load_c("res://Assets/Questions/questions_5.json")
#var load_calcul_4 = load_c("res://Assets/Questions/questions_4.json")
#var load_calcul_3 = load_c("res://Assets/Questions/questions_3.json")
var load_calcul = load_c("res://Assets/Questions/questions.json")

var timer : Timer = null
var timer_label : Label = null
var button_answer : Button = null
var control_answer : Control = null
var control_question : Control = null
var question : Label = null
var colorRect : ColorRect = null


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
#	print (dict)
	return dict

func setup_question(dict : Array) -> void:
	var font_question = "res://Assets/Font/Comfortaa-Bold.ttf"
	question = NodeUtils.create_label(Vector2(0,0), Vector2(0,0), 
						   Color.yellowgreen, font_question, 35,3, Color.black)
	control_question = Control.new() 
	control_question.rect_size = Vector2(200,200)
	$CanvasLayer.add_child(control_question)
	control_question.add_child(question)

	var random_theme 	: int 			= RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	question.text = chosen_question["question"]
	var answers 		: Array = chosen_question["answers"]

	var ans_position : Vector2 = Vector2(question.get_position().x - 100 , question.get_position().y + 100)
	for ans in answers:
		control_answer = Control.new()
		button_answer = Button.new()
		button_answer.text = ans["text"]
		ans_position.x += 100
		button_answer.set_position(ans_position)
		question.add_child(control_answer)
		control_answer.add_child(button_answer)

		var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"
		timer = NodeUtils.create_timer(4, true, true)
		add_child(timer)

		if ans["is_good_answer"] == true:
			var style : StyleBoxFlat = StyleBoxFlat.new()
			style.set_bg_color(Color(0,255,0))
			button_answer.add_stylebox_override("hover",style)
		button_answer.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])


func _ready():
#	answer_listeners = []
#	if FileBankUtils.classroom == 6:
#		setup_question(load_calcul_6)
#	if FileBankUtils.classroom == 5:
#		setup_question(load_calcul_5)
#	if FileBankUtils.classroom == 4:
#		setup_question(load_calcul_4)
#	if FileBankUtils.classroom == 3:
#		setup_question(load_calcul_3)
	setup_question(load_calcul)


func _process(delta):

	count += 1
	control_question.set_pivot_offset(Vector2(control_question.rect_size.x/2, control_question.rect_size.y/2))
	control_answer.set_pivot_offset(control_question.get_pivot_offset())
	print (control_answer.get_pivot_offset())	
	control_answer.set_rotation(count*delta)
	button_answer.set_rotation(-count*delta)	



	if int(timer.get_time_left()) > 0:
		question.add_color_override("font_color", Color.greenyellow)
	else:
		question.add_color_override("font_color", Color.green)		


func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)


