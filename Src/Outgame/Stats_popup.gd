extends KinematicBody2D

onready var hero 			= 	preload("res://Src/Ingame/characters/hero.tscn")
var prev_hud_pause_mode = Node.PAUSE_MODE_PROCESS

func _ready():
	prev_hud_pause_mode = ECS.set_system_pause_mode(SystemsLibrary.Hud, Node.PAUSE_MODE_PROCESS)
		
	var heroNode = hero.instance()
	heroNode.deactivate()
	add_child(heroNode)
	var pos_comp = ECS.add_component(heroNode, ComponentsLibrary.Position, TagsLibrary.Tag_Hero) as PositionComponent
	self.set_position(pos_comp.get_position())
	var comp_score : Component = ECS.add_component(heroNode, ComponentsLibrary.Scoreglobal) as ScoreglobalcounterComponent
	comp_score.init_stats(FileBankUtils.good_answer, FileBankUtils.wrong_answer, FileBankUtils.victories, FileBankUtils.defeats)
	var comp_hud_stats_popup : Component = ECS.add_component(heroNode, ComponentsLibrary.Hud_stats_popup) as HudStatsPopupComponent
	comp_hud_stats_popup.init_stats(get_good_answer(), get_wrong_answer(), get_victories(),get_defeats())
	
	comp_hud_stats_popup.set_good_answer(FileBankUtils.good_answer)
	comp_hud_stats_popup.set_wrong_answer(FileBankUtils.wrong_answer)		
	comp_hud_stats_popup.set_victories(FileBankUtils.victories)
	comp_hud_stats_popup.set_defeats(FileBankUtils.defeats)		
	
	ECS.clear_ghosts()
	
func get_good_answer() -> Label :
	return $CanvasLayer/good_answer/value	as Label
	
func get_wrong_answer() -> Label :
	return $CanvasLayer/wrong_answer/value 	as Label
	
func get_victories() -> Label :
	return $CanvasLayer/victories/value 	as Label

func get_defeats() -> Label :
	return $CanvasLayer/defeats/value 	as Label

func _exit_tree():
	ECS.set_system_pause_mode(SystemsLibrary.Hud, prev_hud_pause_mode)
