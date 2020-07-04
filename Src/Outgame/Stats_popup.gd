extends Node2D

var prev_hud_pause_mode = Node.PAUSE_MODE_PROCESS
var is_shown : bool = false
var comp_score : Component = null
onready var comp_hud_stats_popup : Component = null
var hud_open : Component = null

func init(heroNode : Node2D, _hud_open) -> void:
	hud_open = _hud_open
	if !hud_open.get_shop():
		is_shown = true
		show()
		get_tree().paused = true
	
		hud_open.set_stats(true)
	
		prev_hud_pause_mode = ECS.set_system_pause_mode(SystemsLibrary.Hud, Node.PAUSE_MODE_PROCESS)
	
		comp_score = ECS.__get_component(heroNode.get_instance_id(), 
										ComponentsLibrary.Health) as HealthComponent
		
		if comp_hud_stats_popup == null:
			comp_hud_stats_popup = ECS.add_component(heroNode, 
								   ComponentsLibrary.Hud_stats_popup) as HudStatsPopupComponent
			comp_hud_stats_popup.init_stats(get_good_answer(), get_wrong_answer(), get_victories(),get_defeats())
	
		else:
			comp_hud_stats_popup = ECS.__get_component(heroNode.get_instance_id(), 
									ComponentsLibrary.Scoreglobal) as ScoreglobalcounterComponent


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

func shutdown(hud_open):
	is_shown = false
#	if hud_open != null:
	hud_open.set_stats(false)
	ECS.set_system_pause_mode(SystemsLibrary.Hud, prev_hud_pause_mode)
	hide()
	get_tree().paused = false

func is_shown() -> bool:
	return is_shown 
