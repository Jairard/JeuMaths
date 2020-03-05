extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
var prev_hud_pause_mode = Node.PAUSE_MODE_PROCESS

func _ready():
	prev_hud_pause_mode = ECS.set_system_pause_mode(SystemsLibrary.Hud, Node.PAUSE_MODE_PROCESS)

	var heroNode = hero.instance()
	heroNode.deactivate()
	add_child(heroNode)
	var score_comp : Component = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal) as ScoreglobalcounterComponent
	score_comp.init(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)
	var hud_comp : Component = ECS.add_component(heroNode, ComponentsLibrary.Hud) as HudComponent
	hud_comp.init_stats(get_good_answer(), get_wrong_answer(), get_victories(),get_defeats())
	
func get_good_answer() -> Label :
	return $good_answer/value	as Label
	
func get_wrong_answer() -> Label :
	return $wrong_answer/value 	as Label
	
func get_victories() -> Label :
	return $victories/value 	as Label

func get_defeats() -> Label :
	return $defeats/value 	as Label

func _exit_tree():
	ECS.set_system_pause_mode(SystemsLibrary.Hud, prev_hud_pause_mode)
