extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")

func _ready():
	ECS.register_system(SystemsLibrary.Hud)
	var heroNode = hero.instance()
	heroNode.deactivate()
	add_child(heroNode)
	var stats_comp : Component = ECS.add_component(heroNode, ComponentsLibrary.Personal_stats) as PersonnalStatsComponent
	stats_comp.init(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)
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