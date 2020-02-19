extends Node2D

var stats : Dictionary = {}
const init_stats : Dictionary =  {
									"damage":15,"health":70,
									"treasure":0,"good_answer":0,
									"wrong_answer":0,"boss_killed":0,
									"health_max":70, "scene_counter":0
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
	print ("File : ", FileBankUtils.scene_counter)
#	var new_scene :	String =  ("create_hero" if stats_hero["new_hero"] == true else "playing_map"[FileBankUtils.scene_counter])
	
	if stats_hero["new_hero"] == true:
		get_tree().change_scene(FileBankUtils.loaded_scenes["create_hero"])
	
	else: 
		if FileBankUtils.scene_counter == 0:
			get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"]["map_tuto"])
		
		else: 
			get_tree().change_scene(FileBankUtils.loaded_scenes["playing_map"]["map_fire"])
	


func _on_6eme_pressed():
	$_5eme.pressed = false
	$_4eme.pressed = false
	$_3eme.pressed = false
	FileBankUtils.classroom = 6

func _on_5eme_pressed():
	$_6eme.pressed = false
	$_4eme.pressed = false
	$_3eme.pressed = false
	FileBankUtils.classroom = 5


func _on_4eme_pressed():
	$_6eme.pressed = false
	$_5eme.pressed = false
	$_3eme.pressed = false
	FileBankUtils.classroom = 4

func _on_3eme_pressed():
	$_6eme.pressed = false
	$_5eme.pressed = false
	$_4eme.pressed = false
	FileBankUtils.classroom = 3
