extends Node2D

onready var time_label = get_node("timer")
onready var game_timer = get_node("Timer")
onready var hud				= preload("res://Assets/Textures/hud/hud_invader.tscn")
onready var calcul			= preload("res://Src/Outgame/Calcul_chrono.tscn")
var chrono_component : ChronoComponent = null


var questions : Array = []

func load_questions() -> void:
	questions = FileBankUtils.loaded_chrono

func create_calcul():
	var node = calcul.instance()
	var chrono_calcul = ECS.add_component(node, ComponentsLibrary.Chrono_calcul) as ChronoCalculComponent
	chrono_calcul.init(chrono_component)
	node.setup_question(questions, chrono_component)
	chrono_calcul.init(chrono_component)
	add_child(node)

func _ready():
	ECS.register_system(SystemsLibrary.Hud)
	ECS.register_system(SystemsLibrary.Chrono)
	ECS.register_system(SystemsLibrary.End_chrono)
	ECS.add_component(self, ComponentsLibrary.Hud_fight) 

	chrono_component = ECS.add_component(self, ComponentsLibrary.Chrono) as ChronoComponent

	load_questions()

	create_calcul()

	var hudNode = hud.instance()
	add_child(hudNode)
	var hud_chrono = ECS.add_component(self, ComponentsLibrary.Hud_invader) as HudInvaderComponent
	hud_chrono.init(hudNode.get_gold(), hudNode)
	hudNode.deactivate_health()

	ECS.clear_ghosts()


func _process(delta):
	time_label.set_text(str(int(game_timer.get_time_left())))

	if chrono_component.get_answer_count() %5 == 0:
		chrono_component.set_answer_count(1)
		create_calcul()



