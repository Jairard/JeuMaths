extends Node2D

onready var calcul 			= preload("res://Src/Outgame/Calcul_invader.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")

onready var time_label = get_node("timer")
onready var game_timer = get_node("Timer")
onready var calcul_invader = calcul.instance()
var listener_hero : Component = null
var answer_listener : Array = []
var questions : Array = []

func load_questions() -> void:
	var full_questions = FileBankUtils.loaded_questions
	for i in full_questions:
		if i["text"] == "addition_entiers" or i["text"] == "soustraction_entiers" or i["text"] == "multiplication_entiers" or i["text"] == "division_entiers":
				questions.append(i)

func init(node : Node2D) -> void:
	load_questions()
	calcul_invader.setup_question(questions)
	calcul_invader.set_answer_listener(answer_listener)
	add_child(calcul_invader)

func _ready():
	ECS.register_system(SystemsLibrary.Answer_invader)
	ECS.register_system(SystemsLibrary.End_invader)
	var comp_end = ECS.add_component(calcul_invader, ComponentsLibrary.End_invader)
	comp_end.set_end(true)
	comp_end.set_answer(true)

	ECS.add_component(calcul_invader, ComponentsLibrary.Invader)
	listener_hero = ECS.add_component(calcul_invader, ComponentsLibrary.AnswerListener) 	as AnswerListenerComponent
	answer_listener.append(listener_hero)
	init(calcul_invader)

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))

	if int(game_timer.get_time_left()) <1:
		var new_calcul_invader = calcul.instance()
		game_timer.start(7)
		init(new_calcul_invader)

