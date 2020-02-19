extends Node2D

var count = 0
var answer_listeners  : Array = []
#var load_calcul_6 = load_c("res://Assets/Questions/questions_6.json")
#var load_calcul_5 = load_c("res://Assets/Questions/questions_5.json")
#var load_calcul_4 = load_c("res://Assets/Questions/questions_4.json")
#var load_calcul_3 = load_c("res://Assets/Questions/questions_3.json")
var load_calcul = load_c("res://Assets/Questions/questions.json")


var button_answer : Button = null
var button_question : Button = null

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
#	var container : Node2D = Node2D.new()
#	add_child(container)
	
	button_question = Button.new()
	add_child(button_question)
#	container.add_child(button_question)
#	button_question.rect_scale(button_question.rect_size / 2)

	var random_theme 	: int 			= RandomUtils.randi_to(len(dict))
	var questions		: Array 		= dict[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	button_question.text = chosen_question["question"]
	var answers 		: Array = chosen_question["answers"]

	var ans_position : Vector2 = Vector2(0,100)
	for ans in answers:
		button_answer = Button.new()
		button_answer.text = ans["text"]
		ans_position.x += 100
		button_answer.set_position(ans_position)
		add_child(button_answer)
		if ans["is_good_answer"] == true:
			var style : StyleBoxFlat = StyleBoxFlat.new()
			style.set_bg_color(Color(0,255,0))
			button_answer.add_stylebox_override("hover",style)
		button_answer.connect("pressed", self, "on_answer_pressed", [ans["is_good_answer"]])


func _ready():
	
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
#	button_answer.set_rotation(count*delta)
#	$ans_1.rotation = count * delta
#	$ans_2.rotation = count * delta
	pass

func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)


