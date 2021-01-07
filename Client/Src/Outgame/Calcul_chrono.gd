extends Node2D

var chrono : Component = null
var exercices : Array = []
var answers_mix : Array = []
var random_question_1 : int = 0
var random_question_2 : int = 0
var random_question_3 : int = 0
var random_question_4 : int = 0
var question_1 : String = ""
var question_2 : String = ""
var question_3 : String = ""
var question_4 : String = ""
var answer_1 : String = ""
var answer_2 : String = ""
var answer_3 : String = ""
var answer_4 : String = ""

var questions : Array = ["questions/question1/question1", "questions/question2/question2",
						 "questions/question3/question3", "questions/question4/question4"]
var answers : Array = ["answers/answer1/answer1", "answers/answer2/answer2",
						 "answers/answer3/answer3", "answers/answer4/answer4"]
var selected_question : String = ""
var selected_answer : String = ""

func _process(delta):
	if chrono.get_delete_nodes():
		get_node(selected_question).queue_free()
		get_node(selected_answer).queue_free()
		chrono.set_delete_nodes(false)
	
	if chrono.get_discolor_nodes():
		set_modulate_question("")
		set_modulate_answer("")
		chrono.set_discolor_nodes(false)

func setup_question(_exercices : Array,  _chrono : Component) -> void:
	chrono = _chrono
	exercices  = _exercices

	random_question_1 = RandomUtils.randi_to(len(exercices))
	question_1 = exercices[random_question_1][0]
	$questions/question1/question1.text = str(question_1)

	random_question_2 = RandomUtils.randi_to(len(exercices))
	question_2 = exercices[random_question_2][0]
	$questions/question2/question2.text = str(question_2)

	random_question_3 = RandomUtils.randi_to(len(exercices))
	question_3 = exercices[random_question_3][0]
	$questions/question3/question3.text = str(question_3)

	random_question_4 = RandomUtils.randi_to(len(exercices))
	question_4 = exercices[random_question_4][0]
	$questions/question4/question4.text = str(question_4)

	var answers : Array = [exercices[random_question_1][1],exercices[random_question_2][1],
							exercices[random_question_3][1], exercices[random_question_4][1]]
	
	for i in range(4):
		var random_answer : int = RandomUtils.randi_to(len(answers))
		answers_mix.append(answers[random_answer])
		answers.remove(random_answer)

	for i in range(len(answers_mix)):
		match i:
			0:
				answer_1= answers_mix[0]
				$answers/answer1/answer1.text = str(answer_1)
			1:
				answer_2 = answers_mix[1]
				$answers/answer2/answer2.text = str(answer_2)
			2:
				answer_3 = answers_mix[2]
				$answers/answer3/answer3.text = str(answer_3)
			3:
				answer_4 = answers_mix[3]
				$answers/answer4/answer4.text = str(answer_4)

func set_modulate_question(node):
	for i in questions:
		if get_node(i) != null:
			if i == node :
				get_node(i).set_modulate(Color.red)
			else:
				get_node(i).set_modulate(Color.white)

func set_modulate_answer(node):
	for i in answers:
		if get_node(i) != null:
			if i == node:
				get_node(i).set_modulate(Color.red)
			else:
				get_node(i).set_modulate(Color.white)


func _on_question1_pressed():
	chrono.set_associated_answer(str(exercices[random_question_1][1]))
	chrono.set_new_question(true)
	selected_question = "questions/question1"
	set_modulate_question("questions/question1/question1")

func _on_question2_pressed():
	chrono.set_associated_answer(exercices[random_question_2][1])
	chrono.set_new_question(true)
	selected_question = "questions/question2"
	set_modulate_question("questions/question2/question2")

func _on_question3_pressed():
	chrono.set_associated_answer(exercices[random_question_3][1])
	chrono.set_new_question(true)
	selected_question = "questions/question3"
	set_modulate_question("questions/question3/question3")

func _on_question4_pressed():
	chrono.set_associated_answer(exercices[random_question_4][1])
	chrono.set_new_question(true)
	selected_question = "questions/question4"
	set_modulate_question("questions/question4/question4")

func _on_answer1_pressed():
	chrono.set_answer(answers_mix[0])
	chrono.set_new_answer(true)
	selected_answer = "answers/answer1"
	set_modulate_answer("answers/answer1/answer1")


func _on_answer2_pressed():
	chrono.set_answer(answers_mix[1])
	chrono.set_new_answer(true)
	selected_answer = "answers/answer2"
	set_modulate_answer("answers/answer2/answer2")



func _on_answer3_pressed():
	chrono.set_answer(answers_mix[2])
	chrono.set_new_answer(true)
	selected_answer = "answers/answer3"
	set_modulate_answer("answers/answer3/answer3")


func _on_answer4_pressed():
	chrono.set_answer(answers_mix[3])
	chrono.set_new_answer(true)
	selected_answer = "answers/answer4"
	set_modulate_answer("answers/answer4/answer4")
