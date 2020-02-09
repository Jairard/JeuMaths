extends Node2D

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":15,"health":70,
									"treasure":0,"good_answer":0,
									"wrong_answer":0,"boss_killed":0,
									"health_max":70
									} 
							

func _ready(): 
	if FileBankUtils.loaded_heroes_stats != null:
		stats = FileBankUtils.loaded_heroes_stats.duplicate(true)


#func _process(delta):
#	pass

func get_stats(pseudo : String) -> Dictionary:
	for _pseudo in stats.keys():
		if _pseudo == pseudo:
			return { "new_hero" : false, "stats" : stats[_pseudo]}
	
	var new_stats = init_stats.duplicate(true)
	stats[pseudo] = new_stats
	return {"new_hero" : true, "stats" : new_stats}

func _on_Button_pressed():
	
	var pseudo : String = $TileMap/pseudo.get_text()
	var stats_hero = get_stats(pseudo)
	FileBankUtils.init_stats(stats_hero["stats"], pseudo)
	var new_scene :	String =  ("create_hero" if stats_hero["new_hero"] == true else "map_fire")
	get_tree().change_scene(FileBankUtils.loaded_scenes[new_scene])

		


	
