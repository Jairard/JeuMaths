extends Node2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")

var prev_hud_pause_mode = Node.PAUSE_MODE_PROCESS
var is_shown : bool = false
var comp_score : Component = null

func init(heroNode : Node2D) -> void:
	is_shown = true
	show()
	get_tree().paused = true
	prev_hud_pause_mode = ECS.set_system_pause_mode(SystemsLibrary.Hud, Node.PAUSE_MODE_PROCESS)

	comp_score = ECS.__get_component(heroNode.get_instance_id(), ComponentsLibrary.Health) as HealthComponent

	var comp_hud_stats_popup : Component = ECS.add_component(heroNode, ComponentsLibrary.Hud_stats_popup) as HudStatsPopupComponent
	comp_hud_stats_popup.init_stats(get_good_answer(), get_wrong_answer(), get_victories(),get_defeats())


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

func shutdown():
	is_shown = false
	ECS.set_system_pause_mode(SystemsLibrary.Hud, prev_hud_pause_mode)
	hide()
	get_tree().paused = false

func is_shown() -> bool:
	return is_shown 
