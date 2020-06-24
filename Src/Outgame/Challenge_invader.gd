extends Node2D

onready var calcul 			= preload("res://Src/Outgame/Calcul_invader.tscn")
onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
onready var hud				= preload("res://Assets/Textures/hud/hud_invader.tscn")

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
	node.setup_question(questions)
	node.set_answer_listener(answer_listener)

	var comp_end = ECS.__get_component(node.get_instance_id(), ComponentsLibrary.End_invader) as EndInvaderComponent
	comp_end.set_end(true)
	comp_end.set_answer(true)

	ECS.__get_component(node.get_instance_id(), ComponentsLibrary.Invader) as InvaderComponent
	listener_hero = ECS.__get_component(node.get_instance_id(), ComponentsLibrary.AnswerListener) as AnswerListenerComponent
	answer_listener.append(listener_hero)
	load_questions()
	calcul_invader.setup_question(questions)
	calcul_invader.set_answer_listener(answer_listener)

	add_child(node)

func _ready():
	ECS.register_system(SystemsLibrary.Answer_invader)
	ECS.register_system(SystemsLibrary.End_invader)
	ECS.register_system(SystemsLibrary.Hud)

	ECS.add_component(calcul_invader, ComponentsLibrary.Hud_fight)
	var comp_end = ECS.add_component(calcul_invader, ComponentsLibrary.End_invader)
	comp_end.set_end(true)
	comp_end.set_answer(true)

	ECS.add_component(calcul_invader, ComponentsLibrary.Invader)
	listener_hero = ECS.add_component(calcul_invader, ComponentsLibrary.AnswerListener) 	as AnswerListenerComponent
	answer_listener.append(listener_hero)
	load_questions()
	calcul_invader.setup_question(questions)
	calcul_invader.set_answer_listener(answer_listener)
	add_child(calcul_invader)

	var hudNode = hud.instance()
	add_child(hudNode)

	var hud_invader = ECS.add_component(calcul_invader, ComponentsLibrary.Hud_invader) as HudInvaderComponent

	hud_invader.init(hudNode.get_gold())

	ECS.clear_ghosts()


func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))

	if int(game_timer.get_time_left()) <1:
		var new_calcul_invader = calcul.instance()
		game_timer.start(7)
		init(new_calcul_invader)

