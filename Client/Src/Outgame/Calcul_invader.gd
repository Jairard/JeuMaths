extends Node2D

var calcul_1 : Dictionary = {}
var calcul_2 : Dictionary = {}
var calcul_3 : Dictionary = {}
var calcul_4 : Dictionary = {}
var answer_listeners  : Array = []
var answers : Array = []
var invader : Component = null

func set_answer_listener(listeners : Array) -> void:
	answer_listeners  = listeners

func get_answer_listener() -> Array:
	return answer_listeners

func setup_question(exercices : Array,  _invader : Component) -> void:
	invader = _invader

	var random_theme 	: int 			= RandomUtils.randi_to(len(exercices))
	var questions		: Array 		= exercices[random_theme]["questions"]
	var random_question : int 			= RandomUtils.randi_to(len(questions))
	var chosen_question : Dictionary 	= questions[random_question]

	var font_timer = "res://Assets/Font/Comfortaa-Bold.ttf"

	var question_txt = chosen_question["question"]
	$RigidBody2D/answers/calcul.text = question_txt + " = "

	answers = chosen_question["answers"]

	calcul_1 = answers[0]
	$RigidBody2D/answers/answer1.text = str(calcul_1["text"])
	calcul_2 = answers[1]
	$RigidBody2D/answers/answer2.text = str(calcul_2["text"])
	calcul_3 = answers[2]
	$RigidBody2D/answers/answer3.text = str(calcul_3["text"])
	calcul_4 = answers[3]
	$RigidBody2D/answers/answer4.text = str(calcul_4["text"])


func on_answer_pressed(is_good_answer : bool):
	var answer = AnswerListenerComponent.answer.false
	if is_good_answer == true:
		answer = AnswerListenerComponent.answer.true
	for listener in answer_listeners:
		var component : AnswerListenerComponent = listener as AnswerListenerComponent
		if component != null:
			component.set_answer(answer)


var time = 0
var time_animation = 3
func _process(delta):
	if time < time_animation:
		self.set_modulate(lerp(Color(1,1,1,0), Color(1,1,1,1),time/time_animation))
		time += delta

func _on_Area2D_body_entered(body):
	invader.lose_health = true
	body.queue_free()


func _on_answer1_pressed():
	on_answer_pressed(answers[0]["is_good_answer"])


func _on_answer2_pressed():
	on_answer_pressed(answers[1]["is_good_answer"])


func _on_answer3_pressed():
	on_answer_pressed(answers[2]["is_good_answer"])


func _on_answer4_pressed():
	on_answer_pressed(answers[3]["is_good_answer"])
