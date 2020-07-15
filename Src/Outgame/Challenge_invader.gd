extends Node2D

onready var calcul 			= preload("res://Src/Outgame/Calcul_invader.tscn")
onready var hud				= preload("res://Assets/Textures/hud/hud_invader.tscn")

onready var time_label = get_node("timer")
onready var game_timer = get_node("Timer")
onready var calcul_invader = calcul.instance()

var gravity_acceleration : float = 0.1

var invader_component : InvaderComponent = null
var questions : Array = []

func load_questions() -> void:
	questions = FileBankUtils.loaded_invader

func create_calcul() -> void:
#	gravity_acceleration += 0.05
	var node = calcul.instance()
	var invader_calcul = ECS.add_component(node, ComponentsLibrary.Invader_calcul) as InvaderCalculComponent
	invader_calcul.init(invader_component)
	game_timer.start(5.5)
	var listener_hero = ECS.add_component(node, ComponentsLibrary.AnswerListener) as AnswerListenerComponent
	node.setup_question(questions, invader_component)
	node.set_answer_listener([listener_hero])

	add_child(node)
	var new_gravity = node.get_node("RigidBody2D")
	new_gravity.set_gravity_scale(gravity_acceleration)


func _ready():
	ECS.register_system(SystemsLibrary.Answer_invader)
	ECS.register_system(SystemsLibrary.End_invader)
	ECS.register_system(SystemsLibrary.Hud)

	ECS.add_component(self, ComponentsLibrary.Hud_fight) 

	invader_component = ECS.add_component(self, ComponentsLibrary.Invader) as InvaderComponent
	load_questions()

	create_calcul()

	var hudNode = hud.instance()
	add_child(hudNode)

	var hud_invader = ECS.add_component(self, ComponentsLibrary.Hud_invader) as HudInvaderComponent

	hud_invader.init(hudNode.get_gold(), hudNode)

	ECS.clear_ghosts()

func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))

	if int(game_timer.get_time_left()) <1:
		create_calcul()
